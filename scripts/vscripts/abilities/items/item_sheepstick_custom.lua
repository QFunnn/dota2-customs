--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_sheepstick_custom", "abilities/items/item_sheepstick_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_sheepstick_custom_debuff", "abilities/items/item_sheepstick_custom", LUA_MODIFIER_MOTION_NONE)


item_sheepstick_custom = class({})

function item_sheepstick_custom:GetIntrinsicModifierName()
return "modifier_item_sheepstick_custom"
end


function item_sheepstick_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "model", "models/props_gameplay/pig.vmdl", context )
PrecacheResource( "particle", "particles/units/heroes/hero_lina/lina_supercharge_buff.vpcf", context )
end

function item_sheepstick_custom:Spawn()
self.int = self:GetSpecialValueFor("bonus_intellect")
self.regen = self:GetSpecialValueFor("bonus_mana_regen")

self.sheep_duration = self:GetSpecialValueFor("sheep_duration")
self.sheep_damage_reduce = self:GetSpecialValueFor("sheep_damage_reduce")
self.sheep_movement_speed = self:GetSpecialValueFor("sheep_movement_speed")
self.sheep_movement_speed_self = self:GetSpecialValueFor("sheep_movement_speed_self")
end

function item_sheepstick_custom:CastFilterResultTarget(target)
if not IsServer() then return end
local caster = self:GetCaster()
if caster:GetTeamNumber() == target:GetTeamNumber() and caster ~= target then 
    return UF_FAIL_FRIENDLY
end

return UnitFilter( target, self:GetAbilityTargetTeam(), self:GetAbilityTargetType(), self:GetAbilityTargetFlags(), self:GetCaster():GetTeamNumber() )
end

function item_sheepstick_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()

if target:TriggerSpellAbsorb(self) then return end

if target:IsIllusion() and not target:HasModifier("modifier_chaos_knight_phantasm_illusion") then
    target:Kill(self, caster)
    return
end

local duration = self.sheep_duration
if target:GetTeamNumber() ~= caster:GetTeamNumber() then
    duration = duration*(1 - target:GetStatusResistance())
end

target:RemoveModifierByName("modifier_item_sheepstick_custom_debuff")
target:AddNewModifier(caster, self, "modifier_item_sheepstick_custom_debuff", {duration = duration})
end 



modifier_item_sheepstick_custom = class({})
function modifier_item_sheepstick_custom:IsHidden() return true end
function modifier_item_sheepstick_custom:IsPurgable() return false end
function modifier_item_sheepstick_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
}
end

function modifier_item_sheepstick_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not self.parent.cdr_items then
  self.parent.cdr_items = {}
end
self.parent.cdr_items[self] = self.ability:GetSpecialValueFor("cdr_bonus")
end 

function modifier_item_sheepstick_custom:GetModifierBonusStats_Intellect()
return self.ability.int
end

function modifier_item_sheepstick_custom:GetModifierConstantManaRegen()
return self.ability.regen
end


modifier_item_sheepstick_custom_debuff = class(mod_visible)
function modifier_item_sheepstick_custom_debuff:IsPurgeException() return true end
function modifier_item_sheepstick_custom_debuff:IsDebuff() return true end
function modifier_item_sheepstick_custom_debuff:GetPriority() return MODIFIER_PRIORITY_ILLUSION end
function modifier_item_sheepstick_custom_debuff:OnCreated(data)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.is_enemy = self.parent:GetTeamNumber() ~= self.caster:GetTeamNumber()
self.move = self.ability.sheep_movement_speed
if not self.is_enemy then
    self.move = self.ability.sheep_movement_speed_self
end
self.damage_reduce = self.ability.sheep_damage_reduce

if not IsServer() then return end
self.state = 0

self.model = "models/props_gameplay/pig.vmdl"
local sound = "Item.Hex.Target"
local player_id = self.caster:GetPlayerOwnerID()
local custom_effect_data = shop:GetCurrentEffectData(player_id, "effect_hex")
if custom_effect_data then
    self.model = custom_effect_data[1]
    sound = custom_effect_data[2]
    if custom_effect_data[3] then
        self.parent:EmitSound(custom_effect_data[3])
    end
end

self.parent:EmitSound("DOTA_Item.Sheepstick.Activate")
self.parent:EmitSound(sound)
local mainParticle = ParticleManager:CreateParticle("particles/items_fx/item_sheepstick.vpcf", PATTACH_POINT_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(mainParticle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(mainParticle)

self:OnIntervalThink()
self:StartIntervalThink(0.1)
end

function modifier_item_sheepstick_custom_debuff:OnIntervalThink()
if not IsServer() then return end

if self.state == 0 and not self.parent:IsDebuffImmune() then
    self.state = 1
    self.parent:NoDraw(self, true)
    self.parent:StartGesture(ACT_DOTA_SPAWN)
end

if self.state == 1 and self.parent:IsDebuffImmune() then
    self.state = 0
    self.parent:EndNoDraw(self)
end

end

function modifier_item_sheepstick_custom_debuff:OnDestroy()
if not IsServer() then return end
self.parent:EndNoDraw(self)

local mainParticle = ParticleManager:CreateParticle("particles/items_fx/item_sheepstick.vpcf", PATTACH_POINT_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(mainParticle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(mainParticle)
end

function modifier_item_sheepstick_custom_debuff:CheckState()
return 
{
  [MODIFIER_STATE_HEXED] = true,
  [MODIFIER_STATE_DISARMED] = true,
  [MODIFIER_STATE_SILENCED] = true,
  [MODIFIER_STATE_MUTED] = true,
}
end

function modifier_item_sheepstick_custom_debuff:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,
    MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
    MODIFIER_PROPERTY_MODEL_SCALE,
    MODIFIER_PROPERTY_MODEL_CHANGE
}
end

function modifier_item_sheepstick_custom_debuff:GetModifierIncomingDamage_Percentage()
return self.damage_reduce
end

function modifier_item_sheepstick_custom_debuff:GetModifierMoveSpeed_AbsoluteMin()
if self.is_enemy then return end
return self.move
end

function modifier_item_sheepstick_custom_debuff:GetModifierMoveSpeed_Absolute()
if not self.is_enemy then return end
return self.move
end

function modifier_item_sheepstick_custom_debuff:GetModifierModelScale()
return 15
end

function modifier_item_sheepstick_custom_debuff:GetModifierModelChange()
return self.model
end