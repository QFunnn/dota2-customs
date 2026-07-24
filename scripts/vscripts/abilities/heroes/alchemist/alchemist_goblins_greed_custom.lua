--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


alchemist_goblins_greed_custom = alchemist_goblins_greed_custom or class({})
LinkLuaModifier("modifier_alchemist_scepter_bonus_damage_lua", "abilities/heroes/alchemist/alchemist_goblins_greed_custom", LUA_MODIFIER_MOTION_NONE)

function alchemist_goblins_greed_custom:Spawn()
	self.caster = self:GetCaster()
	if not IsValidEntity(self.caster) then return end

	if not IsServer() then return end

	-- self:SetLevel(1)

	Timers:CreateTimer(0.1, function()
		local caster = self:GetCaster()
		if caster:IsIllusion() then return end
		local player_id = caster:GetPlayerOwnerID()

		if GameLoop.hero_by_player_id[player_id] ~= caster then return end

		local gold = self:GetSpecialValueFor("starting_gold_bonus") or 0
		PlayerResource:ModifyGold(caster:GetPlayerOwnerID(), gold, true, 0)
		SendOverheadEventMessage(caster, OVERHEAD_ALERT_GOLD, caster, gold, nil)
	end)


	if not self.orb_captured_listener then
		self.orb_captured_listener = EventDriver:Listen("GameLoop:orb_captured", self.OnOrbCaptured, self)
	end

	if not self.ability_used_listener then
		self.ability_used_listener = ListenToGameEvent("dota_player_used_ability", self.OnAbilityUsed, self)
	end
end

function alchemist_goblins_greed_custom:OnOrbCaptured(event)
	if not IsValidEntity(self.caster) then return end
	if event.team ~= self:GetTeam() then return end
	if not event.rarity then return end

	local gold = (self:GetSpecialValueFor("bonus_orb_gold") or 0)
	local modifier = self.caster:FindModifierByName("modifier_alchemist_scepter_bonus_damage_lua")
	if modifier then
		local scepter_bonus_orb_gold_per_stack = self:GetSpecialValueFor("scepter_bonus_orb_gold_per_stack") or 0
		gold = gold + (scepter_bonus_orb_gold_per_stack * modifier:GetStackCount())
	end
	local gold = gold * event.rarity
	PlayerResource:ModifyGold(self.caster:GetPlayerOwnerID(), gold, true, 0)
	SendOverheadEventMessage(self.caster, OVERHEAD_ALERT_GOLD, self.caster, gold, nil)
end

function alchemist_goblins_greed_custom:OnAbilityUsed(event)
	if not IsValidEntity(self.caster) then return end
	local caster = EntIndexToHScript(event.caster_entindex)
	if caster ~= self.caster then return end
	local ability_name = event.abilityname
	if ability_name ~= "item_ultimate_scepter" then return end

	self.caster:AddNewModifier(self.caster, self, "modifier_alchemist_scepter_bonus_damage_lua", {duration = -1})
end



-- vanilla modifier is linked to vanilla goblins greed, just read the charges and add the damage and spell amp
modifier_alchemist_scepter_bonus_damage_lua = class({})

function modifier_alchemist_scepter_bonus_damage_lua:IsHidden() return true end
function modifier_alchemist_scepter_bonus_damage_lua:IsPurgable() return false end
function modifier_alchemist_scepter_bonus_damage_lua:IsDebuff() return false end
function modifier_alchemist_scepter_bonus_damage_lua:RemoveOnDeath() return false end
function modifier_alchemist_scepter_bonus_damage_lua:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_alchemist_scepter_bonus_damage_lua:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	if not IsValidEntity(self.caster) then return end
	if not IsValidEntity(self.ability) then return end

	self.scepter_bonus_damage = self.ability:GetSpecialValueFor("scepter_bonus_damage")
	self.scepter_spell_amp = self.ability:GetSpecialValueFor("scepter_spell_amp")

	if not IsServer() then return end

	Timers:CreateTimer(0.1, function()
		if not self or self:IsNull() then return end
		if not IsValidEntity(self.caster) then return end
		local vanilla_modifier = self.caster:FindModifierByName("modifier_alchemist_scepter_bonus_damage")
		if not vanilla_modifier or vanilla_modifier:IsNull() then return end
		self:SetStackCount(vanilla_modifier:GetStackCount())
	end)
end

function modifier_alchemist_scepter_bonus_damage_lua:OnRefresh()
	self:OnCreated()
end

function modifier_alchemist_scepter_bonus_damage_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_alchemist_scepter_bonus_damage_lua:GetModifierPreAttack_BonusDamage()
	return self:GetStackCount() * self.scepter_bonus_damage
end