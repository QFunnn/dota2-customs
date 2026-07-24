--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_orchid_custom", "abilities/items/item_orchid_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_orchid_custom_debuff", "abilities/items/item_orchid_custom", LUA_MODIFIER_MOTION_NONE)

item_orchid_custom = class({})

function item_orchid_custom:GetIntrinsicModifierName()
return "modifier_item_orchid_custom"
end

function item_orchid_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items2_fx/orchid.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/orchid_pop.vpcf", context )
end

function item_orchid_custom:Spawn()
self.bonus_attack_speed = self:GetSpecialValueFor("bonus_attack_speed")
self.bonus_damage = self:GetSpecialValueFor("bonus_damage")
self.bonus_mana_regen = self:GetSpecialValueFor("bonus_mana_regen")
self.bonus_intellect = self:GetSpecialValueFor("bonus_intellect")
self.silence_damage_percent = self:GetSpecialValueFor("silence_damage_percent")/100
self.silence_duration = self:GetSpecialValueFor("silence_duration")
self.bonus_health = self:GetSpecialValueFor("bonus_health")
end

function item_orchid_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()

if target:TriggerSpellAbsorb(self) then return end

target:EmitSound("DOTA_Item.Orchid.Activate")
target:RemoveModifierByName("modifier_item_orchid_custom_debuff")
target:AddNewModifier(caster, self, "modifier_item_orchid_custom_debuff", {duration = self.silence_duration*(1 - target:GetStatusResistance())})
end

modifier_item_orchid_custom_debuff = class({})
function modifier_item_orchid_custom_debuff:IsHidden() return false end
function modifier_item_orchid_custom_debuff:IsPurgable() return true end
function modifier_item_orchid_custom_debuff:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.damage = self.ability.silence_damage_percent
self.count = 0

if not IsServer() then return end
local hit_effect = ParticleManager:CreateParticle("particles/items2_fx/orchid.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(hit_effect, 0, self.parent, PATTACH_OVERHEAD_FOLLOW, nil, self.parent:GetAbsOrigin(), false) 
ParticleManager:SetParticleControlEnt(hit_effect, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetAbsOrigin(), false) 
self:AddParticle(hit_effect, false, false, -1, false, false  )
self.parent:AddDamageEvent_inc(self, true)
end

function modifier_item_orchid_custom_debuff:CheckState()
return
{
	[MODIFIER_STATE_SILENCED] = true,
}
end

function modifier_item_orchid_custom_debuff:DamageEvent_inc(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end
if not params.attacker:IsUnit() then return end
if params.attacker:GetTeamNumber() == self.parent:GetTeamNumber() then return end
if params.damage <= 0 then return end

self.count = self.count + params.damage*self.damage
end

function modifier_item_orchid_custom_debuff:OnDestroy()
if not IsServer() then return end
if self:GetRemainingTime() > 0.1 then return end
if self.count <= 0 then return end

local hit_effect = ParticleManager:CreateParticle("particles/items2_fx/orchid_pop.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(hit_effect, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetAbsOrigin(), false) 
ParticleManager:SetParticleControl(hit_effect, 1, Vector(self.count, 0, 0)) 
ParticleManager:ReleaseParticleIndex(hit_effect)

DoDamage({victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL, damage = self.count})
end


modifier_item_orchid_custom	= class(mod_hidden)
function modifier_item_orchid_custom:RemoveOnDeath() return false end
function modifier_item_orchid_custom:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()
end

function modifier_item_orchid_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    MODIFIER_PROPERTY_HEALTH_BONUS,
    MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
}
end

function modifier_item_orchid_custom:GetModifierConstantManaRegen()
return self.ability.bonus_mana_regen
end

function modifier_item_orchid_custom:GetModifierAttackSpeedBonus_Constant()
return self.ability.bonus_attack_speed
end

function modifier_item_orchid_custom:GetModifierPreAttack_BonusDamage()
return self.ability.bonus_damage
end

function modifier_item_orchid_custom:GetModifierBonusStats_Intellect()
return self.ability.bonus_intellect
end

function modifier_item_orchid_custom:GetModifierHealthBonus()
return self.ability.bonus_health
end