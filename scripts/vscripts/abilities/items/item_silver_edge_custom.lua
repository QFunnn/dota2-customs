--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("item_silver_edge_custom_surge", "abilities/items/item_silver_edge_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("item_silver_edge_custom_passive", "abilities/items/item_silver_edge_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("item_silver_edge_custom_break", "abilities/items/item_silver_edge_custom", LUA_MODIFIER_MOTION_NONE)

item_silver_edge_custom = class({})

function item_silver_edge_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/silver_edge_speed_.vpcf", context )
PrecacheResource( "particle","particles/silver_edge_sword.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/silver_edge.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_break.vpcf", context )
end


function item_silver_edge_custom:GetIntrinsicModifierName()
return "item_silver_edge_custom_passive"
end

function item_silver_edge_custom:OnSpellStart()

local caster = self:GetCaster()
caster:EmitSound("DOTA_Item.InvisibilitySword.Activate")
caster:AddNewModifier(caster, self, "item_silver_edge_custom_surge", {duration = self:GetSpecialValueFor("duration")})
end




item_silver_edge_custom_surge = class({})
function item_silver_edge_custom_surge:IsHidden() return false end
function item_silver_edge_custom_surge:IsPurgable()  return false end
function item_silver_edge_custom_surge:GetEffectName() return "particles/silver_edge_speed_.vpcf" end
function item_silver_edge_custom_surge:OnCreated(table)

self.parent = self:GetParent()
self.speed = self:GetAbility():GetSpecialValueFor("movement_speed")

if not IsServer() then return end
self.parent:GenericParticle("particles/silver_edge_sword.vpcf", self, true)
end


function item_silver_edge_custom_surge:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function item_silver_edge_custom_surge:CheckState() 
local state = 
{
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    [MODIFIER_STATE_CANNOT_MISS] = true,
}
return state
end

function item_silver_edge_custom_surge:GetModifierMoveSpeedBonus_Percentage() 
return self.speed 
end




item_silver_edge_custom_passive = class({})
function item_silver_edge_custom_passive:IsHidden() return true end
function item_silver_edge_custom_passive:IsPurgable() return false end
function item_silver_edge_custom_passive:RemoveOnDeath() return false end
function item_silver_edge_custom_passive:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_HEALTH_BONUS,
    MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
}
end

function item_silver_edge_custom_passive:GetModifierPreAttack_BonusDamage() 
return self.damage
end

function item_silver_edge_custom_passive:GetModifierAttackSpeedBonus_Constant()
return self.speed
end

function item_silver_edge_custom_passive:GetModifierHealthBonus()
return self.bonus_health
end

function item_silver_edge_custom_passive:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()
self.damage = self.ability:GetSpecialValueFor("bonus_damage")
self.speed = self.ability:GetSpecialValueFor("bonus_attack_speed")
self.bonus_health = self.ability:GetSpecialValueFor("bonus_health")

self.break_duration = self.ability:GetSpecialValueFor("backstab_duration")
self.break_damage = self.ability:GetSpecialValueFor("windwalk_bonus_damage")

if not IsServer() then return end

self.records = {}

if self.parent:IsRealHero() then
    self.parent:AddRecordDestroyEvent(self, true)
    self.parent:AddAttackStartEvent_out(self)
end

end


function item_silver_edge_custom_passive:AttackStartEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsRealHero() then return end

local mod = self.parent:FindModifierByName("item_silver_edge_custom_surge")

if mod then
    mod:Destroy()
    self.records[params.record] = true
end

end


function item_silver_edge_custom_passive:RecordDestroyEvent(params)
if not IsServer() then return end

if self.records[params.record] then
    self.records[params.record] = nil
end

end

function item_silver_edge_custom_passive:GetModifierProcAttack_BonusDamage_Physical(params)
if not params.record then return end
if not self.records[params.record] then return end
local target = params.target

target:EmitSound("DOTA_Item.SilverEdge.Target")
target:AddNewModifier(self.parent, self.ability, "item_silver_edge_custom_break", {duration = (1 - target:GetStatusResistance())*self.break_duration})

return self.break_damage 
end




item_silver_edge_custom_break = class({})
function item_silver_edge_custom_break:IsHidden() return false end
function item_silver_edge_custom_break:IsPurgable() return false end
function item_silver_edge_custom_break:CheckState() return {[MODIFIER_STATE_PASSIVES_DISABLED] = true} end
function item_silver_edge_custom_break:GetEffectName() return "particles/items3_fx/silver_edge.vpcf" end
function item_silver_edge_custom_break:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MAX
}
end

function item_silver_edge_custom_break:OnCreated(table)
self.max_movement_speed = self:GetAbility():GetSpecialValueFor("max_movement_speed")
if not IsServer() then return end
self:GetParent():GenericParticle("particles/generic_gameplay/generic_break.vpcf", self, true)
end

function item_silver_edge_custom_break:GetModifierMoveSpeed_AbsoluteMax()
return self.max_movement_speed 
end