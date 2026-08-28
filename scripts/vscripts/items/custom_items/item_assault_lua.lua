--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_assault_lua", "items/custom_items/item_assault_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_assault_lua_aura_buff", "items/custom_items/item_assault_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_assault_lua_aura_debuff", "items/custom_items/item_assault_lua", LUA_MODIFIER_MOTION_NONE)

item_assault_lua1 = item_assault_lua1 or class({})
item_assault_lua2 = item_assault_lua1 or class({})
item_assault_lua3 = item_assault_lua1 or class({})

function item_assault_lua1:GetIntrinsicModifierName()
	return "modifier_assault_lua"
end

-------------------------------------------------------------------------------

modifier_assault_lua = class({})

function modifier_assault_lua:IsHidden()
	return true
end
function modifier_assault_lua:IsPurgable()
	return false
end
function modifier_assault_lua:RemoveOnDeath()
	return false
end
function modifier_assault_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_assault_lua:OnCreated()
	local ability = self:GetAbility()

	self.bonus_attack_speed = ability:GetSpecialValueFor("bonus_attack_speed")
	self.bonus_armor = ability:GetSpecialValueFor("bonus_armor")

	self.auraRadius = ability:GetSpecialValueFor("aura_radius")
end

function modifier_assault_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_assault_lua:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attack_speed
end

function modifier_assault_lua:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end

function modifier_assault_lua:GetModifierAura()
	return self.auraModifierName
end
function modifier_assault_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end
function modifier_assault_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING
end
function modifier_assault_lua:GetAuraRadius()
	return self.auraRadius
end
function modifier_assault_lua:GetAuraEntityReject(target)
	if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
		self.auraModifierName = "modifier_assault_lua_aura_buff"
	else
		self.auraModifierName = "modifier_assault_lua_aura_debuff"
	end

	return false
end
function modifier_assault_lua:IsAura()
	local caster = self:GetCaster()

	return not caster:PassivesDisabled() and not caster:IsIllusion()
end

---------------------------------------------------------------------------------------------------------------------------------------

modifier_assault_lua_aura_buff = class({})

function modifier_assault_lua_aura_buff:OnCreated()
	local ability = self:GetAbility()
	if ability then
		self.aura_attack_speed = ability:GetSpecialValueFor("aura_attack_speed")
		self.aura_positive_armor = ability:GetSpecialValueFor("aura_positive_armor")
	end
end

function modifier_assault_lua_aura_buff:OnRefresh()
	self:OnCreated()
end

function modifier_assault_lua_aura_buff:IsHidden()
	return false
end
function modifier_assault_lua_aura_buff:IsPurgable()
	return false
end
function modifier_assault_lua_aura_buff:IsDebuff()
	return false
end

function modifier_assault_lua_aura_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_assault_lua_aura_buff:GetModifierAttackSpeedBonus_Constant()
	return self.aura_attack_speed
end

function modifier_assault_lua_aura_buff:GetModifierPhysicalArmorBonus()
	return self.aura_positive_armor
end

------------------------------------------------------------------------------------------------------------------------------------------

modifier_assault_lua_aura_debuff = class({})

function modifier_assault_lua_aura_debuff:OnCreated()
	self.aura_negative_armor = -self:GetAbility():GetSpecialValueFor("aura_negative_armor")
end
function modifier_assault_lua_aura_debuff:OnRefresh()
	self:OnCreated()
end

function modifier_assault_lua_aura_debuff:IsHidden()
	return false
end
function modifier_assault_lua_aura_debuff:IsPurgable()
	return false
end
function modifier_assault_lua_aura_debuff:IsDebuff()
	return true
end

function modifier_assault_lua_aura_debuff:DeclareFunctions()
	return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end

function modifier_assault_lua_aura_debuff:GetModifierPhysicalArmorBonus()
	return self.aura_negative_armor
end