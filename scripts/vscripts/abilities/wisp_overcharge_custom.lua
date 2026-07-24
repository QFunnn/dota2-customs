--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_wisp_overcharge_custom", "abilities/wisp_overcharge_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_overcharge_custom_cooldown", "abilities/wisp_overcharge_custom", LUA_MODIFIER_MOTION_NONE)

wisp_overcharge_custom = class({})

function wisp_overcharge_custom:GetIntrinsicModifierName()
	return "modifier_wisp_overcharge_custom"
end

function wisp_overcharge_custom:OnSpellStart()
	if not IsServer() then return end
    local caster = self:GetCaster()
    local ability = self
	caster:AddNewModifier(caster, ability, "modifier_wisp_overcharge", {duration = ability:GetSpecialValueFor("duration")})
end

modifier_wisp_overcharge_custom = class({})

function modifier_wisp_overcharge_custom:IsHidden() return true end
function modifier_wisp_overcharge_custom:IsPurgable() return false end
function modifier_wisp_overcharge_custom:IsPurgeException() return false end
function modifier_wisp_overcharge_custom:RemoveOnDeath() return false end

function modifier_wisp_overcharge_custom:OnCreated()
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.damage_pct = self.ability:GetSpecialValueFor("damage_pct")
    self.lifesteal_percent = self.ability:GetSpecialValueFor("lifesteal")
end

function modifier_wisp_overcharge_custom:OnRefresh()
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.damage_pct = self.ability:GetSpecialValueFor("damage_pct")
    self.lifesteal_percent = self.ability:GetSpecialValueFor("lifesteal")
end

function modifier_wisp_overcharge_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end

function modifier_wisp_overcharge_custom:GetModifierPreAttack_BonusDamage( params )
	if not IsServer() then return end
	if not self.parent:HasModifier("modifier_wisp_overcharge") then return end
	if self.parent:PassivesDisabled() then return end
	if params.target == nil then return end
	if self.parent:HasModifier("modifier_wisp_overcharge_custom_cooldown") then return end
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_wisp_overcharge_custom_cooldown", {duration = 0.15})
	local roshan_phys_immune_resist = 1
    local roshan_phys_immune = params.target:FindAbilityByName("roshan_phys_immune")
    if roshan_phys_immune then
        roshan_phys_immune_resist = 1 - (roshan_phys_immune:GetSpecialValueFor("phys_immune") / 100)
    end
	local leech = params.target:GetMaxHealth() / 100 * self.damage_pct
	local bonus = leech * roshan_phys_immune_resist
	if _G.Players and _G.Players.QueueAttackBonus then
		_G.Players:QueueAttackBonus(params.attacker, params.target, bonus, "wisp_overcharge_custom", DAMAGE_TYPE_PHYSICAL)
	end
	return bonus
end

function modifier_wisp_overcharge_custom:AttackLandedModifier(params)
	if IsServer() then
		local no_heal_target =
        {
			["npc_dota_phoenix_sun"] = true,
			["npc_dota_grimstroke_ink_creature"] = true,
			["npc_dota_juggernaut_healing_ward"] = true,
			["npc_dota_healing_campfire"] = true,
			["npc_dota_pugna_nether_ward_1"] = true,
			["npc_dota_item_wraith_pact_totem"] = true,
			["npc_dota_pugna_nether_ward_2"] = true,
			["npc_dota_pugna_nether_ward_3"] = true,
			["npc_dota_pugna_nether_ward_4"] = true,
			["npc_dota_templar_assassin_psionic_trap"] = true,
			["npc_dota_weaver_swarm"] = true,
			["npc_dota_venomancer_plague_ward_1"] = true,
			["npc_dota_venomancer_plague_ward_2"] = true,
			["npc_dota_venomancer_plague_ward_3"] = true,
			["npc_dota_venomancer_plague_ward_4"] = true,
			["npc_dota_shadow_shaman_ward_1"] = true,
			["npc_dota_shadow_shaman_ward_2"] = true,
			["npc_dota_shadow_shaman_ward_3"] = true,
			["npc_dota_unit_tombstone1"] = true,
			["npc_dota_unit_tombstone2"] = true,
			["npc_dota_unit_tombstone3"] = true,
			["npc_dota_unit_tombstone4"] = true,
			["npc_dota_unit_undying_zombie"] = true,
			["npc_dota_unit_undying_zombie_torso"] = true,
			["npc_dota_clinkz_skeleton_archer"] = true,
			["npc_dota_techies_land_mine"] = true,
			["npc_dota_zeus_cloud"] = true,
			["npc_dota_rattletrap_cog"] = true,
			["npc_dota_lich_ice_spire"] = true,
		}
		if params.attacker == self.parent then
			if params.damage <= 0 then return end
			if no_heal_target[params.target:GetUnitName()] then return end
			if params.target:IsWard() or params.target:IsHeroWard() then return end
			local lifesteal = self.lifesteal_percent / 100
			self.parent:Heal(params.target:GetMaxHealth() / 100 * lifesteal, nil)
		end
	end
end

modifier_wisp_overcharge_custom_cooldown = class({})
function modifier_wisp_overcharge_custom_cooldown:IsHidden() return true end
function modifier_wisp_overcharge_custom_cooldown:IsPurgeException() return false end
function modifier_wisp_overcharge_custom_cooldown:IsPurgable() return false end