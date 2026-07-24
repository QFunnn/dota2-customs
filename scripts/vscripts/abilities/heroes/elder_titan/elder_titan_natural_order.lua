--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


elder_titan_natural_order_lua = class({})
LinkLuaModifier("modifier_elder_titan_natural_order_lua", "abilities/heroes/elder_titan/elder_titan_natural_order", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_elder_titan_natural_order_aura_magic_resistance_lua", "abilities/heroes/elder_titan/elder_titan_natural_order", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_elder_titan_natural_order_magic_resistance_effect_lua", "abilities/heroes/elder_titan/elder_titan_natural_order", LUA_MODIFIER_MOTION_NONE)


function elder_titan_natural_order_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius") or 0
end

function elder_titan_natural_order_lua:GetIntrinsicModifierName()
	return "modifier_elder_titan_natural_order_lua"
end

function elder_titan_natural_order_lua:GetAbilityTextureName()
	if self:GetCaster():GetUnitName() == "npc_dota_elder_titan_ancestral_spirit" then
		return "elder_titan_natural_order_spirit"
	end
	return "elder_titan_natural_order"
end


function elder_titan_natural_order_lua:OnUpgrade()
	local caster = self:GetCaster()

	if caster:GetUnitName() == "npc_dota_elder_titan_ancestral_spirit" then return end

	local spirit_ability = caster:FindAbilityByName("elder_titan_ancestral_spirit_lua")
	if IsValidEntity(spirit_ability) then
		spirit_ability:UpdateSpiritAbilities()
	end
end


-----------------------------------------------------------------------------------------------------------------------------------------------------------


modifier_elder_titan_natural_order_lua = class({})

function modifier_elder_titan_natural_order_lua:IsHidden() return true end
function modifier_elder_titan_natural_order_lua:IsDebuff() return false end
function modifier_elder_titan_natural_order_lua:IsPurgable() return false end
function modifier_elder_titan_natural_order_lua:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_elder_titan_natural_order_lua:OnCreated(keys)
	if not IsServer() then return end
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	if not self.ability or self.ability:IsNull() then return end
	if not self.parent or self.parent:IsNull() then return end

	local is_ancestral_spirit = self.parent:GetUnitName() == "npc_dota_elder_titan_ancestral_spirit"

	-- ancestral spirit aura depends on owner ability (as spirit itself doesn't have facet etc)
	if is_ancestral_spirit then
		local owner = self.parent:GetOwner()
		local ability = owner:FindAbilityByName(self.ability:GetAbilityName())
		self.parent:AddNewModifier(owner, ability, "modifier_elder_titan_natural_order_aura_magic_resistance_lua", {})
	else
		self.parent:AddNewModifier(self.parent, self.ability, "modifier_elder_titan_natural_order_aura_armor", {})
	end
end

function modifier_elder_titan_natural_order_lua:OnRefresh(keys)
	self:OnCreated(keys)
end

function modifier_elder_titan_natural_order_lua:OnDestroy()
	if not IsServer() then return end
	if not self or self:IsNull() then return end
	if not self.parent or self.parent:IsNull() then return end

	self.parent:RemoveModifierByName("modifier_elder_titan_natural_order_aura_armor")
	self.parent:RemoveModifierByName("modifier_elder_titan_natural_order_aura_magic_resistance_lua")
end


function modifier_elder_titan_natural_order_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
	}
end

function modifier_elder_titan_natural_order_lua:OnAbilityExecuted(keys)
	if not IsServer() then return end
	if not self.caster or self.caster:IsNull() then return end
	if self.caster ~= keys.unit then return end
	if keys.ability:GetAbilityName() ~= "elder_titan_ancestral_spirit_lua" then return end	-- the spirit does not have this ability

	self.caster:RemoveModifierByName("modifier_elder_titan_natural_order_aura_magic_resistance_lua")
end


---------------------------------------------------------------------------------------------------------------------------------------------------------------


-- valve broke the magic resist aura in 7.32 that's why there's a lua version of only one aura
modifier_elder_titan_natural_order_aura_magic_resistance_lua = class({})

function modifier_elder_titan_natural_order_aura_magic_resistance_lua:IsPurgable() return false end
function modifier_elder_titan_natural_order_aura_magic_resistance_lua:IsHidden() return true end

function modifier_elder_titan_natural_order_aura_magic_resistance_lua:IsAura() return true end
function modifier_elder_titan_natural_order_aura_magic_resistance_lua:GetAuraRadius() return IsValidEntity(self.ability) and self.ability:GetSpecialValueFor("radius") or 0 end
function modifier_elder_titan_natural_order_aura_magic_resistance_lua:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS end
function modifier_elder_titan_natural_order_aura_magic_resistance_lua:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_elder_titan_natural_order_aura_magic_resistance_lua:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_elder_titan_natural_order_aura_magic_resistance_lua:GetModifierAura() return "modifier_elder_titan_natural_order_magic_resistance_effect_lua" end

function modifier_elder_titan_natural_order_aura_magic_resistance_lua:OnCreated()
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()
	if not self.ability or self.ability:IsNull() then return end
	if not self.caster or self.caster:IsNull() then return end
end

function modifier_elder_titan_natural_order_aura_magic_resistance_lua:OnRefresh()
	self:OnCreated()
end


modifier_elder_titan_natural_order_magic_resistance_effect_lua = modifier_elder_titan_natural_order_magic_resistance_effect_lua or class({})

function modifier_elder_titan_natural_order_magic_resistance_effect_lua:IsPurgable() return false end

function modifier_elder_titan_natural_order_magic_resistance_effect_lua:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.magic_resistance_pct = -self.ability:GetSpecialValueFor("magic_resistance_pct")
	self.magic_resistance_per_tick = -self.ability:GetSpecialValueFor("magic_resistance_per_tick")
	self.tick_rate = self.ability:GetSpecialValueFor("tick_rate")
	self.max_stacks = self.ability:GetSpecialValueFor("max_stacks")

	if self.tick_rate > 0 then self:StartIntervalThink(self.tick_rate) end
end

function modifier_elder_titan_natural_order_magic_resistance_effect_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DIRECT_MODIFICATION,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end


function modifier_elder_titan_natural_order_magic_resistance_effect_lua:GetModifierMagicalResistanceDirectModification()
	if self.lock then return 0 end

	self.lock = true
	local value = self.magic_resistance_pct * self.parent:GetBaseMagicalResistanceValue() / 100.0
	self.lock = false

	return value
end


function modifier_elder_titan_natural_order_magic_resistance_effect_lua:GetModifierMagicalResistanceBonus()
	return self.magic_resistance_per_tick * self:GetStackCount()
end


function modifier_elder_titan_natural_order_magic_resistance_effect_lua:OnIntervalThink()
	self:SetStackCount(math.min(self:GetStackCount() + 1, self.max_stacks))
end


function modifier_elder_titan_natural_order_magic_resistance_effect_lua:OnTooltip()
	return self.magic_resistance_pct
end


function modifier_elder_titan_natural_order_magic_resistance_effect_lua:GetTexture()
	return "elder_titan_natural_order_spirit"
end