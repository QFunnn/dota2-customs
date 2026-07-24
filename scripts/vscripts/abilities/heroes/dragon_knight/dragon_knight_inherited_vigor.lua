--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


dragon_knight_inherited_vigor_lua = class({})
LinkLuaModifier("modifier_dragon_knight_inherited_vigor_lua", "abilities/heroes/dragon_knight/dragon_knight_inherited_vigor", LUA_MODIFIER_MOTION_NONE)

function dragon_knight_inherited_vigor_lua:GetIntrinsicModifierName()
	return "modifier_dragon_knight_inherited_vigor_lua"
end


---------------------------------------------------------------------------------------------------------------------------------------------------------


modifier_dragon_knight_inherited_vigor_lua = class({})

function modifier_dragon_knight_inherited_vigor_lua:IsHidden() return false end
function modifier_dragon_knight_inherited_vigor_lua:IsDebuff() return false end
function modifier_dragon_knight_inherited_vigor_lua:IsPurgable() return false end

function modifier_dragon_knight_inherited_vigor_lua:OnCreated(keys)
	self:SetHasCustomTransmitterData(true)
	self.parent = self:GetParent()
	if not IsValidEntity(self.parent) then return end
	self.ability = self:GetAbility()
	if not IsValidEntity(self.ability) then return end

	self.interval = 0.2
	self.base_armor = self.ability:GetSpecialValueFor("base_armor") or 0
	self.base_health_regen = self.ability:GetSpecialValueFor("base_health_regen") or 0
	self.level_mult = self.ability:GetSpecialValueFor("level_mult") or 0
	self.regen_and_armor_multiplier_during_dragon_form = self.ability:GetSpecialValueFor("regen_and_armor_multiplier_during_dragon_form") or 0


	if not IsServer() then return end
	self:StartIntervalThink(self.interval)
	self:SendBuffRefreshToClients()
end

function modifier_dragon_knight_inherited_vigor_lua:OnRefresh(keys)
	self:OnCreated(keys)
end

function modifier_dragon_knight_inherited_vigor_lua:OnIntervalThink()
	if not self or self:IsNull() then return end
	if not IsValidEntity(self.parent) then return end

	self.actual_armor = self.base_armor + self.parent:GetLevel() * self.level_mult
	self.actual_health_regen = self.base_health_regen + self.parent:GetLevel() * self.level_mult

	if self.parent:HasModifier("modifier_dragon_knight_dragon_form") then
		self.actual_armor = self.actual_armor * self.regen_and_armor_multiplier_during_dragon_form
		self.actual_health_regen = self.actual_health_regen * self.regen_and_armor_multiplier_during_dragon_form
	end

	self:SendBuffRefreshToClients()
end

function modifier_dragon_knight_inherited_vigor_lua:AddCustomTransmitterData()
	return {
		actual_health_regen = self.actual_health_regen,
		actual_armor = self.actual_armor,
	}
end

function modifier_dragon_knight_inherited_vigor_lua:HandleCustomTransmitterData(kv)
	self.actual_health_regen = kv.actual_health_regen
	self.actual_armor = kv.actual_armor
end

function modifier_dragon_knight_inherited_vigor_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_dragon_knight_inherited_vigor_lua:GetModifierConstantHealthRegen()
	if not IsValidEntity(self.parent) then return 0 end
	if self.parent:PassivesDisabled() then return 0 end
	return self.actual_health_regen
end

function modifier_dragon_knight_inherited_vigor_lua:GetModifierPhysicalArmorBonus()
	if not IsValidEntity(self.parent) then return 0 end
	if self.parent:PassivesDisabled() then return 0 end
	return self.actual_armor
end