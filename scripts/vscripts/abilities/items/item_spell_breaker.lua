--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_spell_breaker", "abilities/items/item_spell_breaker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_spell_breaker_shield", "abilities/items/item_spell_breaker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_spell_breaker_passive", "abilities/items/item_spell_breaker", LUA_MODIFIER_MOTION_NONE)

item_spell_breaker = class({})

function item_spell_breaker:GetIntrinsicModifierName()
	return "modifier_item_spell_breaker"
end
function item_spell_breaker:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items/active_breaker.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_muerta/muerta_spell_amp_steal_debuff.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/status_effect_mage_slayer_debuff.vpcf", context )
end

function item_spell_breaker:OnSpellStart()
local caster = self:GetCaster()
caster:EmitSound("Items.Spell_breaker")
caster:AddNewModifier(caster, self, "modifier_item_spell_breaker_shield", {duration = self:GetSpecialValueFor("duration_active")})
end 

modifier_item_spell_breaker = class(mod_hidden)
function modifier_item_spell_breaker:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
    MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
    MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
    MODIFIER_PROPERTY_HEALTH_BONUS,
    MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
}
end

function modifier_item_spell_breaker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.parent:AddAttackEvent_out(self, true)

self.duration = self.ability:GetSpecialValueFor("duration")
self.damage = self.ability:GetSpecialValueFor("bonus_damage")
self.regen = self.ability:GetSpecialValueFor("bonus_mana_regen")
self.health_regen = self.ability:GetSpecialValueFor("bonus_health_regen")
self.resist = self.ability:GetSpecialValueFor("bonus_magical_armor")
self.health = self.ability:GetSpecialValueFor("bonus_health")
end 

function modifier_item_spell_breaker:AttackEvent_out(params)
if not IsServer() then return end 
if self.parent ~= params.attacker then return end 
if not params.target:IsUnit() then return end
params.target:AddNewModifier(self.parent , self.ability, "modifier_item_spell_breaker_passive", {duration = self.duration})
end

function modifier_item_spell_breaker:GetModifierMagicalResistanceBonus()
if self.parent:HasModifier("modifier_item_pipe_custom") then return end
if self.parent:HasModifier("modifier_item_consecrated_wraps_custom") then return end
if self.parent:HasModifier("modifier_item_mage_slayer") then return end

return self.resist
end

function modifier_item_spell_breaker:GetModifierHealthBonus()
return self.health
end

function modifier_item_spell_breaker:GetModifierConstantManaRegen()
return self.regen
end

function modifier_item_spell_breaker:GetModifierConstantHealthRegen()
return self.health_regen
end

function modifier_item_spell_breaker:GetModifierPreAttack_BonusDamage()
return self.damage
end



modifier_item_spell_breaker_shield = class({})
function modifier_item_spell_breaker_shield:IsHidden() return false end
function modifier_item_spell_breaker_shield:IsPurgable() return true end


function modifier_item_spell_breaker_shield:OnCreated(table)
self.parent = self:GetParent()
self.damage = self:GetAbility():GetSpecialValueFor("resist_active")*-1
if not IsServer() then return end

local particle = ParticleManager:CreateParticle( "particles/items/active_breaker.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
ParticleManager:SetParticleControl(particle, 1, Vector(100,1,1))
self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_item_spell_breaker_shield:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    MODIFIER_PROPERTY_TOOLTIP
}

end
function modifier_item_spell_breaker_shield:GetModifierIncomingDamage_Percentage(params)
--if self:GetParent() ~= params.unit then return end
if params.inflictor == nil then return end
--if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end

if Not_spell_damage[params.inflictor:GetName()] then return end

return self.damage
end

function modifier_item_spell_breaker_shield:OnTooltip()
return self.damage
end


modifier_item_spell_breaker_passive = class({})
function modifier_item_spell_breaker_passive:IsHidden() return false end
function modifier_item_spell_breaker_passive:IsPurgable() return false end

function modifier_item_spell_breaker_passive:GetEffectName()
return "particles/units/heroes/hero_muerta/muerta_spell_amp_steal_debuff.vpcf"
end 


function modifier_item_spell_breaker_passive:GetEffectAttachType()
return PATTACH_OVERHEAD_FOLLOW
end

function modifier_item_spell_breaker_passive:GetStatusEffectName()
return "particles/items3_fx/status_effect_mage_slayer_debuff.vpcf"
end

function modifier_item_spell_breaker_passive:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL 
end

function modifier_item_spell_breaker_passive:OnCreated()

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.dps = self.ability:GetSpecialValueFor("dps")
self.interval = self.ability:GetSpecialValueFor("interval")
self.amp = self.ability:GetSpecialValueFor("spell_amp_debuff")
self.damageTable = {victim = self.parent, attacker = self.caster, damage = self.dps*self.interval, ability = self.ability, damage_type = DAMAGE_TYPE_PHYSICAL}

if not IsServer() then return end 

self:StartIntervalThink(self.interval)
end 

function modifier_item_spell_breaker_passive:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_item_spell_breaker_passive:GetModifierSpellAmplify_Percentage() 
if self.parent:HasModifier("modifier_item_mage_slayer_debuff") then return end
return self.amp
end


function modifier_item_spell_breaker_passive:OnIntervalThink()
if not IsServer() then return end 
if not self.caster or self.caster:IsNull() then return end
if not self.ability or self.ability:IsNull() then return end
DoDamage(self.damageTable)
end