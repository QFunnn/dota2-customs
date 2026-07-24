--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_antimage_attack", "abilities/npc_antimage_burn.lua", LUA_MODIFIER_MOTION_NONE)

npc_antimage_burn = class({})


function npc_antimage_burn:GetIntrinsicModifierName() return "modifier_antimage_attack" end
 
modifier_antimage_attack = class ({})

function modifier_antimage_attack:IsHidden() return true end
function modifier_antimage_attack:IsPurgable() return false end

function modifier_antimage_attack:DeclareFunctions() 
return 
{
    MODIFIER_PROPERTY_PROCATTACK_FEEDBACK
} 
end



function modifier_antimage_attack:GetModifierProcAttack_Feedback( param )
if not IsServer() then end 
if self:GetParent() ~= param.attacker then return end
if param.target:IsMagicImmune() then return end
if param.target:GetMaxMana() == 0 then return end

local mana = self:GetAbility():GetSpecialValueFor("mana")*param.target:GetMaxMana()/100

if mana > param.target:GetMana() then 
    mana = param.target:GetMana()
end

DoDamage({ victim = param.target, attacker = self:GetParent(), ability = self:GetAbility(), damage = mana, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION})
            

param.target:EmitSound("Hero_Antimage.ManaBreak")

param.target:SpendMana(mana, self:GetAbility())        
local manaburn_pfx = ParticleManager:CreateParticle("particles/generic_gameplay/generic_manaburn.vpcf", PATTACH_ABSORIGIN_FOLLOW, param.target)
ParticleManager:SetParticleControl(manaburn_pfx, 0, param.target:GetAbsOrigin() )
ParticleManager:ReleaseParticleIndex(manaburn_pfx)

end
