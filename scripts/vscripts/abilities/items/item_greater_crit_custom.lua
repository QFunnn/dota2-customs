--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_greater_crit_custom", "abilities/items/item_greater_crit_custom", LUA_MODIFIER_MOTION_NONE)

item_greater_crit_custom = class({})

function item_greater_crit_custom:GetIntrinsicModifierName()
return "modifier_item_greater_crit_custom"
end

function item_greater_crit_custom:GetAbilityTextureName()
local caster = self:GetCaster()
return wearables_system:GetAbilityIconReplacement(self.caster, "item_greater_crit", self)
end

modifier_item_greater_crit_custom	= class(mod_hidden)
function modifier_item_greater_crit_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_greater_crit_custom:RemoveOnDeath() return false end
function modifier_item_greater_crit_custom:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")
self.bonus_health = self.ability:GetSpecialValueFor("bonus_health")
self.crit_chance = self.ability:GetSpecialValueFor("crit_chance")
self.crit_multiplier = self.ability:GetSpecialValueFor("crit_multiplier")
self.records = {}

self.parent:AddRecordDestroyEvent(self, true)
end

function modifier_item_greater_crit_custom:GetCritDamage() return self.crit_multiplier end
function modifier_item_greater_crit_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
	MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	MODIFIER_PROPERTY_HEALTH_BONUS
}
end

function modifier_item_greater_crit_custom:GetModifierHealthBonus()
return self.bonus_health
end

function modifier_item_greater_crit_custom:GetModifierPreAttack_BonusDamage()
return self.bonus_damage
end

function modifier_item_greater_crit_custom:GetModifierProcAttack_Feedback(params)
if params.attacker ~= self.parent then return end
local target = params.target

if not target:IsUnit() then return end
if not self.records[params.record] then return end
target:EmitSound("DOTA_Item.Daedelus.Crit")
end

function modifier_item_greater_crit_custom:GetModifierPreAttack_CriticalStrike( params )
if not IsServer() then return end
if not params.target:IsUnit() then return end
if not RollPseudoRandomPercentage(self.crit_chance, 1094, self.parent) then return end
if self.parent.wd_ward_attack then return self.crit_multiplier/100 end
if params.record then
	self.records[params.record] = true
end
return self.crit_multiplier
end

function modifier_item_greater_crit_custom:RecordDestroyEvent(params)
if not IsServer() then return end
self.records[params.record] = nil
end
