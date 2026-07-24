--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_overwhelming_blink_custom", "abilities/items/item_overwhelming_blink_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_overwhelming_blink_custom_debuff", "abilities/items/item_overwhelming_blink_custom", LUA_MODIFIER_MOTION_NONE)

item_overwhelming_blink_custom = class({})

function item_overwhelming_blink_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items3_fx/blink_overwhelming_start.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/blink_overwhelming_end.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap_debuff.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/blink_overwhelming_burst.vpcf", context )
end

function item_overwhelming_blink_custom:GetIntrinsicModifierName()
return "modifier_item_overwhelming_blink_custom"
end

function item_overwhelming_blink_custom:GetAbilityTextureName()
if self:GetCaster():HasModifier("modifier_blink_break_custom") then
    return "items/item_overwhelming_blink_break"
end
return "item_overwhelming_blink"
end

function item_overwhelming_blink_custom:Spawn()
self.blink_range = self:GetSpecialValueFor("blink_range")
self.break_range = self:GetSpecialValueFor("break_range")
self.break_duration = self:GetSpecialValueFor("break_duration")
self.bonus_strength = self:GetSpecialValueFor("bonus_strength")
self.radius = self:GetSpecialValueFor("radius")
self.movement_slow = self:GetSpecialValueFor("movement_slow")
self.attack_slow = self:GetSpecialValueFor("attack_slow")
self.duration = self:GetSpecialValueFor("duration")
self.damage_base = self:GetSpecialValueFor("damage_base")
self.stun = self:GetSpecialValueFor("stun")
self.damage_pct_instant = self:GetSpecialValueFor("damage_pct_instant")/100
self.damage_pct_over_time = self:GetSpecialValueFor("damage_pct_over_time")/100
end
 

function item_overwhelming_blink_custom:GetCastRange(Vector, hTarget)
if IsServer() then
    return 99999
end
local caster = self:GetCaster()
return self:MaxRange() - (caster:HasModifier("modifier_blink_break_custom") and caster:GetCastRangeBonus() or 0)
end

function item_overwhelming_blink_custom:MaxRange()
local caster = self:GetCaster()
if caster:HasModifier("modifier_blink_break_custom") then
    return (self.break_range and self.break_range or 0)
end
return (self.blink_range and self.blink_range or 0)
end

function item_overwhelming_blink_custom:GetAOERadius()
return self.radius and self.radius or 0
end
 
function item_overwhelming_blink_custom:OnSpellStart()
local caster = self:GetCaster()
local point = caster:CastPosition(self:GetCursorPosition())
local max_range = self:MaxRange() + (not caster:HasModifier("modifier_blink_break_custom") and caster:GetCastRangeBonus() or 0)
local dir = (point - caster:GetAbsOrigin())

if dir:Length2D() > max_range then
    point = caster:GetAbsOrigin() + max_range*dir:Normalized()
end

local player_id = caster:GetPlayerOwnerID()
local custom_effect_data = shop:GetCurrentEffectData(player_id, "effect_blink")
local pfx_name_start = "particles/items3_fx/blink_overwhelming_start.vpcf"
local pfx_name_end = "particles/items3_fx/blink_overwhelming_end.vpcf"
if custom_effect_data then
    pfx_name_start = custom_effect_data[2]
    pfx_name_end = custom_effect_data[1]
end

if not self.multicast_k then
    caster:SetForwardVector(dir:Normalized())
    caster:FaceTowards(point)
    caster:Teleport(point, not caster:HasModifier("modifier_blink_break_custom"), pfx_name_start, pfx_name_end)
end
caster:EmitSound("DOTA_Item.Overwhelming_Blink.Activate")

local effect = ParticleManager:CreateParticle("particles/items3_fx/blink_overwhelming_burst.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(effect, 0, point)
ParticleManager:SetParticleControl(effect, 1, Vector(self.radius, self.radius, self.radius))
ParticleManager:ReleaseParticleIndex(effect)

for _,target in pairs(caster:FindTargets(self.radius)) do
    if not self.multicast_k then
        target:AddNewModifier(caster, self, "modifier_stunned", {duration = (1 - target:GetStatusResistance())*self.stun})
    end
    target:RemoveModifierByName("modifier_item_overwhelming_blink_custom_debuff")
    target:AddNewModifier(caster, self, "modifier_item_overwhelming_blink_custom_debuff", {damage_k = self.multicast_k or 1})
end

if caster:GetQuest() == "General.Quest_15" then
    caster:AddNewModifier(caster, nil, "modifier_quest_blink", {duration = caster.quest.number})
end

end


modifier_item_overwhelming_blink_custom = class(mod_hidden)
function modifier_item_overwhelming_blink_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
}
end

function modifier_item_overwhelming_blink_custom:GetModifierBonusStats_Strength()
return self.ability.bonus_strength
end

function modifier_item_overwhelming_blink_custom:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.parent:AddDamageEvent_inc(self)
end

function modifier_item_overwhelming_blink_custom:DamageEvent_inc(params)
if not IsServer() then return end
self.parent:CheckBlink(params, self.ability)
end


modifier_item_overwhelming_blink_custom_debuff = class(mod_visible)
function modifier_item_overwhelming_blink_custom_debuff:IsPurgable() return true end
function modifier_item_overwhelming_blink_custom_debuff:GetStatusEffectName() return "particles/status_fx/status_effect_brewmaster_thunder_clap.vpcf" end
function modifier_item_overwhelming_blink_custom_debuff:StatusEffectPriority() return MODIFIER_PRIORITY_NORMAL end
function modifier_item_overwhelming_blink_custom_debuff:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.move = self.ability.movement_slow
self.attack = self.ability.attack_slow

if not IsServer() then return end
self.parent:GenericParticle("particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap_debuff.vpcf", self)
self.interval = 1
self.count = self.ability.duration/self.interval
self.damage = self.ability.damage_pct_over_time

self.damageTable = {attacker = self.caster, ability = self.ability, victim = self.parent, damage_type = DAMAGE_TYPE_MAGICAL}
self.damageTable.damage = (self.ability.damage_base + self.ability.damage_pct_instant*self.caster:GetStrength())*table.damage_k
DoDamage(self.damageTable)

self:StartIntervalThink(self.interval)
end

function modifier_item_overwhelming_blink_custom_debuff:OnIntervalThink()
if not IsServer() then return end
self.damageTable.damage = self.caster:GetStrength()*self.damage
DoDamage(self.damageTable)

self.count = self.count - 1
if self.count <= 0 then
    self:Destroy()
    return
end

end

function modifier_item_overwhelming_blink_custom_debuff:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_item_overwhelming_blink_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
return self.move
end

function modifier_item_overwhelming_blink_custom_debuff:GetModifierAttackSpeedBonus_Constant()
return self.attack
end