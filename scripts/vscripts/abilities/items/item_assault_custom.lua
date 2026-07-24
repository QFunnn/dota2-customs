--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_assault_custom", "abilities/items/item_assault_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_assault_custom_aura", "abilities/items/item_assault_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_assault_custom_buff", "abilities/items/item_assault_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_assault_custom_debuff_aura", "abilities/items/item_assault_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_assault_custom_debuff", "abilities/items/item_assault_custom", LUA_MODIFIER_MOTION_NONE)

item_assault_custom = class({})

function item_assault_custom:GetIntrinsicModifierName()
return "modifier_item_assault_custom"
end

function item_assault_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/bristleback/armor_buff.vpcf", context )
end

modifier_item_assault_custom = class(mod_hidden)
function modifier_item_assault_custom:RemoveOnDeath() return false end
function modifier_item_assault_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self

self.bonus_attack_speed = self.ability:GetSpecialValueFor("bonus_attack_speed")
self.bonus_armor = self.ability:GetSpecialValueFor("bonus_armor")
self.radius = self.ability:GetSpecialValueFor("AbilityCastRange")
self.timer = self.ability:GetSpecialValueFor("timer")

if not IsServer() then return end
if not self.parent:IsRealHero() or self.parent:IsTempestDouble() then return end
self.interval = 1
self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_item_assault_custom:OnIntervalThink()
if not IsServer() then return end
if not self.parent:IsAlive() then return end

if not self.parent:HasModifier("modifier_item_assault_custom_debuff") then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_assault_custom_debuff", {})
end

local targets = self.parent:FindTargets(self.radius)
for _,target in pairs(targets) do
	if target:IsRealHero() then
		self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_assault_custom_buff", {duration = self.timer})
		break
	end
end

end

function modifier_item_assault_custom:OnDestroy()
if not IsServer() then return end
if not IsValid(self.parent) then return end
self.parent:RemoveModifierByName("modifier_item_assault_custom_debuff")
self.parent:RemoveModifierByName("modifier_item_assault_custom_buff")
end

function modifier_item_assault_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
}
end

function modifier_item_assault_custom:GetModifierAttackSpeedBonus_Constant()
return self.bonus_attack_speed
end

function modifier_item_assault_custom:GetModifierPhysicalArmorBonus()
return self.bonus_armor
end

function modifier_item_assault_custom:GetAuraRadius() return self.radius end
function modifier_item_assault_custom:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD end
function modifier_item_assault_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_item_assault_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_item_assault_custom:GetModifierAura() return "modifier_item_assault_custom_aura" end
function modifier_item_assault_custom:IsAura() 
if not IsServer() then return end
return IsValid(self.parent) and self.parent:IsRealHero() and not self.parent:IsTempestDouble()
end

function modifier_item_assault_custom:GetAuraEntityReject(hEntity)
if hEntity.ignore_assault then return true end
return false
end


modifier_item_assault_custom_debuff = class(mod_hidden)
function modifier_item_assault_custom_debuff:RemoveOnDeath() return false end
function modifier_item_assault_custom_debuff:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.radius = self.ability:GetSpecialValueFor("AbilityCastRange")
end

function modifier_item_assault_custom_debuff:GetAuraRadius() return self.radius end
function modifier_item_assault_custom_debuff:GetAuraSearchFlags() return  DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE end
function modifier_item_assault_custom_debuff:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_item_assault_custom_debuff:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_item_assault_custom_debuff:GetModifierAura() return "modifier_item_assault_custom_debuff_aura" end
function modifier_item_assault_custom_debuff:IsAura() 
if not IsServer() then return end
return IsValid(self.parent) and self.parent:IsRealHero() and not self.parent:IsTempestDouble()
end



modifier_item_assault_custom_aura = class(mod_visible)
function modifier_item_assault_custom_aura:OnCreated()
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.aura_positive_armor = self.ability:GetSpecialValueFor("aura_positive_armor")
self.aura_attack_speed = self.ability:GetSpecialValueFor("aura_attack_speed")

self.bonus_aura_armor = self.ability:GetSpecialValueFor("bonus_aura_armor")
self.bonus_aura_speed = self.ability:GetSpecialValueFor("bonus_aura_speed")
end

function modifier_item_assault_custom_aura:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_item_assault_custom_aura:GetModifierPhysicalArmorBonus()
return self.aura_positive_armor + self.caster:GetUpgradeStack("modifier_item_assault_custom_aura")*self.bonus_aura_armor
end

function modifier_item_assault_custom_aura:GetModifierAttackSpeedBonus_Constant()
return self.aura_attack_speed + self.caster:GetUpgradeStack("modifier_item_assault_custom_aura")*self.bonus_aura_speed
end



modifier_item_assault_custom_debuff_aura = class(mod_visible)
function modifier_item_assault_custom_debuff_aura:OnCreated()
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.heal_reduce = self.ability:GetSpecialValueFor("aura_heal_reduce")
self.aura_negative_armor = self.ability:GetSpecialValueFor("aura_negative_armor")
end

function modifier_item_assault_custom_debuff_aura:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
}
end

function modifier_item_assault_custom_debuff_aura:GetModifierHealChange()
return self.heal_reduce
end

function modifier_item_assault_custom_debuff_aura:GetModifierHPRegenAmplify_Percentage()
return self.heal_reduce
end

function modifier_item_assault_custom_debuff_aura:GetModifierPhysicalArmorBonus()
return self.aura_negative_armor
end



modifier_item_assault_custom_buff = class(mod_hidden)
function modifier_item_assault_custom_buff:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.bonus_max = self.ability:GetSpecialValueFor("bonus_max")
if not IsServer() then return end
self:OnRefresh()
end

function modifier_item_assault_custom_buff:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.bonus_max then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.bonus_max and not self.particle then
	self.parent:EmitSound("BB.Back_shield")
	self.particle = self.parent:GenericParticle("particles/bristleback/armor_buff.vpcf", self)
end

end

function modifier_item_assault_custom_buff:OnStackCountChanged(iStackCount)
if not IsServer() then return end
local mod = self.parent:FindModifierByName("modifier_item_assault_custom_aura")
if not mod then return end
mod:SetStackCount(self:GetStackCount())
end

function modifier_item_assault_custom_buff:OnDestroy()
if not IsServer() then return end
local mod = self.parent:FindModifierByName("modifier_item_assault_custom_aura")
if not mod then return end
mod:SetStackCount(0)
end