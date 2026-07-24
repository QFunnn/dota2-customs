--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_npc_necro_melle_passive", "abilities/npc_necro_melle_passive", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_npc_necro_melle_passive_heal", "abilities/npc_necro_melle_passive", LUA_MODIFIER_MOTION_NONE)

npc_necro_melle_passive = class({})

function npc_necro_melle_passive:GetIntrinsicModifierName() 
return "modifier_npc_necro_melle_passive"
end

function npc_necro_melle_passive:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_doom_bringer/doom_infernal_blade_impact.vpcf", context )

end




modifier_npc_necro_melle_passive = class({})

function modifier_npc_necro_melle_passive:IsHidden() return true end
function modifier_npc_necro_melle_passive:IsPurgable() return false end

function modifier_npc_necro_melle_passive:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.parent:AddDeathEvent(self)

self.damage = self:GetAbility():GetSpecialValueFor("damage")/100
self.stun = self:GetAbility():GetSpecialValueFor("stun")
self.duration = self:GetAbility():GetSpecialValueFor("duration")
end

function modifier_npc_necro_melle_passive:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_PROCATTACK_FEEDBACK
}

end


function modifier_npc_necro_melle_passive:GetModifierProcAttack_Feedback(params)
if not IsServer() then return end
if params.attacker ~= self:GetParent() then return end
if params.target:IsMagicImmune() then return end

params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_npc_necro_melle_passive_heal", {duration = self.duration})

end


function modifier_npc_necro_melle_passive:CheckState()
return
{
    [MODIFIER_STATE_CANNOT_MISS] = true
}
end

function modifier_npc_necro_melle_passive:DeathEvent(params)
if not IsServer() then return end
if self:GetParent() ~= params.unit then return end
if not params.attacker then return end
if params.attacker:IsBuilding() then return end

local damage = params.attacker:GetMaxHealth()*self.damage

params.attacker:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_stunned", {duration = (1 - params.attacker:GetStatusResistance())*self.stun})

local damageTable = 
{
    victim      = params.attacker,
    damage      = damage,
    damage_type   = DAMAGE_TYPE_PURE,
    damage_flags  = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
    attacker    = self:GetParent(),
    ability     = self:GetAbility()
}

DoDamage(damageTable)

local effect_target = ParticleManager:CreateParticle( "particles/units/heroes/hero_doom_bringer/doom_infernal_blade_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.attacker )
ParticleManager:SetParticleControl( effect_target, 0, params.attacker:GetAbsOrigin() )
ParticleManager:ReleaseParticleIndex( effect_target )
params.attacker:EmitSound("Hero_DoomBringer.InfernalBlade.PreAttack")


end



modifier_npc_necro_melle_passive_heal = class({})

function modifier_npc_necro_melle_passive_heal:IsHidden() return false end

function modifier_npc_necro_melle_passive_heal:IsPurgable() return true end

function modifier_npc_necro_melle_passive_heal:OnCreated(table)
    self.reduce = self:GetAbility():GetSpecialValueFor("reduce")
end






function modifier_npc_necro_melle_passive_heal:DeclareFunctions()
    return {
    --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
    MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
    --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE
    }
 end

 function modifier_npc_necro_melle_passive_heal:GetTexture() return "centaur_double_edge" end

function modifier_npc_necro_melle_passive_heal:GetModifierLifestealRegenAmplify_Percentage() return -(self.reduce ) end
function modifier_npc_necro_melle_passive_heal:GetModifierHealChange() return -(self.reduce ) end
function modifier_npc_necro_melle_passive_heal:GetModifierHPRegenAmplify_Percentage() return -(self.reduce ) end


function modifier_npc_necro_melle_passive_heal:GetEffectName() return "particles/items4_fx/spirit_vessel_damage.vpcf" end
 
function modifier_npc_necro_melle_passive_heal:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end
