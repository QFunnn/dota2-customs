--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


templar_assassin_elusive_assassin_lua = class({})
LinkLuaModifier("modifier_templar_assassin_elusive_assassin_lua", "abilities/heroes/templar_assassin/elusive_assassin", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_templar_assassin_elusive_assassin_buff_lua", "abilities/heroes/templar_assassin/elusive_assassin", LUA_MODIFIER_MOTION_NONE)

function templar_assassin_elusive_assassin_lua:GetIntrinsicModifierName()
	return "modifier_templar_assassin_elusive_assassin_lua"
end


---------------------------------------------------------------------------------------------------------------------------------------------------


modifier_templar_assassin_elusive_assassin_lua = class({})

function modifier_templar_assassin_elusive_assassin_lua:IsHidden() return true end
function modifier_templar_assassin_elusive_assassin_lua:IsDebuff() return false end
function modifier_templar_assassin_elusive_assassin_lua:IsPurgable() return false end
function modifier_templar_assassin_elusive_assassin_lua:RemoveOnDeath() return false end
function modifier_templar_assassin_elusive_assassin_lua:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_templar_assassin_elusive_assassin_lua:OnCreated(kv)
	self.caster = self:GetCaster()
	if not IsValidEntity(self.caster) then return end
	self.ability = self:GetAbility()
	if not IsValidEntity(self.ability) then return end

	self.linger_duration = self.ability:GetSpecialValueFor("linger_duration") or 0

	if not IsServer() then return end

	self:StartIntervalThink(0.1)
	self:OnIntervalThink()
end

function modifier_templar_assassin_elusive_assassin_lua:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_templar_assassin_elusive_assassin_lua:OnDestroy(kv)
end

function modifier_templar_assassin_elusive_assassin_lua:OnIntervalThink()
	if not self or self:IsNull() then return end
	if not IsValidEntity(self.caster) then return end
	if not IsValidEntity(self.ability) then return end

	local is_caster_invisible = false
	local all_modifiers = self.caster:FindAllModifiers()
	for _, modifier in pairs(all_modifiers) do
		if modifier:HasFunction(MODIFIER_PROPERTY_INVISIBILITY_LEVEL) then
			is_caster_invisible = true
			break
		end
	end

	local buff_modifier = self.caster:FindModifierByName("modifier_templar_assassin_elusive_assassin_buff_lua")
	if is_caster_invisible then
		if buff_modifier then return end
		self.caster:AddNewModifier(self.caster, self.ability, "modifier_templar_assassin_elusive_assassin_buff_lua", {duration = -1})
	else
		if not buff_modifier then return end
		local duration = buff_modifier:GetDuration()
		if duration ~= -1 then return end
		buff_modifier:SetDuration(self.linger_duration, true)
	end
end


---------------------------------------------------------------------------------------------------------------------------------------------------


modifier_templar_assassin_elusive_assassin_buff_lua = class({})

function modifier_templar_assassin_elusive_assassin_buff_lua:IsHidden() return false end
function modifier_templar_assassin_elusive_assassin_buff_lua:IsDebuff() return false end
function modifier_templar_assassin_elusive_assassin_buff_lua:IsPurgable() return false end

function modifier_templar_assassin_elusive_assassin_buff_lua:OnCreated(kv)
	self.caster = self:GetCaster()
	if not IsValidEntity(self.caster) then return end
	self.ability = self:GetAbility()
	if not IsValidEntity(self.ability) then return end

	self.bonus_base_damage_pct = self.ability:GetSpecialValueFor("bonus_base_damage_pct") or 0
	self.linger_duration = self.ability:GetSpecialValueFor("linger_duration") or 0
end

function modifier_templar_assassin_elusive_assassin_buff_lua:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_templar_assassin_elusive_assassin_buff_lua:DeclareFunctions()
	return {
		-- MODIFIER_EVENT_ON_BREAK_INVISIBILITY, -- this doesn't work!
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_templar_assassin_elusive_assassin_buff_lua:GetModifierBaseDamageOutgoing_Percentage()
	if not IsValidEntity(self.caster) then return 0 end
	if self.caster:PassivesDisabled() then return 0 end
	return self.bonus_base_damage_pct
end

function modifier_templar_assassin_elusive_assassin_buff_lua:OnTooltip()
	return self.linger_duration
end