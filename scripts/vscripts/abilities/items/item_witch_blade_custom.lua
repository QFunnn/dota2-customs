--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_witch_blade_custom_passive", "abilities/items/item_witch_blade_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_witch_blade_custom_poison", "abilities/items/item_witch_blade_custom", LUA_MODIFIER_MOTION_NONE)

item_witch_blade_custom = class({})

function item_witch_blade_custom:GetIntrinsicModifierName()
return "modifier_item_witch_blade_custom_passive"
end

function item_witch_blade_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items_fx/witch_blade/witch_blade_base.vpcf", context ) 
PrecacheResource( "particle", "particles/items3_fx/witch_blade_debuff.vpcf", context ) 
end

modifier_item_witch_blade_custom_passive = class(mod_hidden)
function modifier_item_witch_blade_custom_passive:RemoveOnDeath() return false end
function modifier_item_witch_blade_custom_passive:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
  MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
  MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS,
  MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
  MODIFIER_PROPERTY_PROJECTILE_NAME,
  MODIFIER_PROPERTY_HEALTH_BONUS
}
end

function modifier_item_witch_blade_custom_passive:CheckState()
if not self.ability:IsFullyCastable() then return end
return
{
  [MODIFIER_STATE_CANNOT_MISS] = true
}
end

function modifier_item_witch_blade_custom_passive:GetPriority()
if not self.ability:IsFullyCastable() then return MODIFIER_PRIORITY_LOW end
return MODIFIER_PRIORITY_HIGH
end

function modifier_item_witch_blade_custom_passive:GetModifierProjectileName()
if not self.ability:IsFullyCastable() then return end
return "particles/items_fx/witch_blade/witch_blade_base.vpcf"
end

function modifier_item_witch_blade_custom_passive:GetModifierBonusStats_Intellect()
return self.ability.bonus_intellect
end

function modifier_item_witch_blade_custom_passive:GetModifierAttackSpeedBonus_Constant()
return self.ability.bonus_attack_speed
end

function modifier_item_witch_blade_custom_passive:GetModifierPhysicalArmorBonus()
return self.ability.bonus_armor
end

function modifier_item_witch_blade_custom_passive:GetModifierProjectileSpeedBonus()
return self.ability.projectile_speed
end

function modifier_item_witch_blade_custom_passive:GetModifierConstantManaRegen()
return self.ability.bonus_regen
end

function modifier_item_witch_blade_custom_passive:GetModifierHealthBonus()
return self.ability.bonus_health
end

function modifier_item_witch_blade_custom_passive:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.ability.bonus_regen = self.ability:GetSpecialValueFor("bonus_regen")
self.ability.bonus_intellect = self.ability:GetSpecialValueFor("bonus_intellect")
self.ability.bonus_attack_speed = self.ability:GetSpecialValueFor("bonus_attack_speed")
self.ability.bonus_armor = self.ability:GetSpecialValueFor("bonus_armor")
self.ability.projectile_speed = self.ability:GetSpecialValueFor("projectile_speed")
self.ability.bonus_health = self.ability:GetSpecialValueFor("bonus_health")

self.ability.int_damage_multiplier = self.ability:GetSpecialValueFor("int_damage_multiplier")/100
self.ability.slow = self.ability:GetSpecialValueFor("slow")
self.ability.slow_duration = self.ability:GetSpecialValueFor("slow_duration")
self.ability.int_heal = self.ability:GetSpecialValueFor("int_heal")/100

if not IsServer() then return end
if not self.parent:IsRealHero() then return end

self.records = {}

self.parent:AddAttackStartEvent_out(self)
self.parent:AddAttackEvent_out(self, true)
self.parent:AddRecordDestroyEvent(self, true)
end

function modifier_item_witch_blade_custom_passive:RecordDestroyEvent( params )
if not self.records[params.record] then return end
self.records[params.record] = nil
end

function modifier_item_witch_blade_custom_passive:AttackStartEvent_out(params)
if not IsServer() then return end
if not self.ability:IsFullyCastable() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

self.records[params.record] = true
self.ability:StartCd()
end

function modifier_item_witch_blade_custom_passive:AttackEvent_out(params)
if not IsServer() then return end
if not self.records[params.record] then return end
if self.parent ~= params.attacker then return end
if self.parent:HasModifier("modifier_item_devastator_custom_passive") then return end
if not params.target:IsUnit() then return end
local target = params.target

target:EmitSound("Item.WitchBlade.Target")
target:RemoveModifierByName("modifier_item_witch_blade_custom_poison")
target:AddNewModifier(self.parent, self.ability, "modifier_item_witch_blade_custom_poison", {})
end


modifier_item_witch_blade_custom_poison = class(mod_visible)
function modifier_item_witch_blade_custom_poison:GetEffectName() return "particles/items3_fx/witch_blade_debuff.vpcf" end
function modifier_item_witch_blade_custom_poison:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.damage = self.ability.int_damage_multiplier
self.slow = self.ability.slow
self.interval = 1
self.count = self.ability.slow_duration
self.heal = self.ability.int_heal

if not IsServer() then return end
self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}
self:StartIntervalThink(self.interval)
end

function modifier_item_witch_blade_custom_poison:OnIntervalThink()
if not IsServer() then return end
local damage = self.caster:GetIntellect(false)*self.damage*self.interval

self.damageTable.damage = damage
DoDamage(self.damageTable)
self.parent:SendNumber(9, self.damageTable.damage)

self.caster:GenericHeal(damage*self.heal, self.ability, false, "particles/items3_fx/octarine_core_lifesteal.vpcf")

self.count = self.count - 1
if self.count <= 0 then
  self:Destroy()
  return
end

end

function modifier_item_witch_blade_custom_poison:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_item_witch_blade_custom_poison:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end