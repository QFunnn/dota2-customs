--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tusk_ghost_passive", "abilities/npc_tusk_ghost_passive.lua", LUA_MODIFIER_MOTION_NONE)

npc_tusk_ghost_passive = class({})


function npc_tusk_ghost_passive:GetIntrinsicModifierName() return "modifier_tusk_ghost_passive" end
 
modifier_tusk_ghost_passive = class ({})

function modifier_tusk_ghost_passive:IsHidden() return true end
function modifier_tusk_ghost_passive:CheckState() return {[MODIFIER_STATE_CANNOT_MISS] = true } end

function modifier_tusk_ghost_passive:DeclareFunctions() 
return 
{
   MODIFIER_PROPERTY_PROCATTACK_FEEDBACK
}
end

function modifier_tusk_ghost_passive:OnCreated()	
if not IsServer() then return end
self.parent = self:GetParent()
self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_phased", {})
self:StartIntervalThink(1)
self.timer = 0
self.live = self:GetAbility():GetSpecialValueFor("live")
end



function modifier_tusk_ghost_passive:OnIntervalThink()
self.timer = self.timer + 1

if self.timer >= self.live then
	self.parent:RemoveModifierByName("modifier_invulnerable")
   self.parent:Kill(nil, nil)
end

end

function modifier_tusk_ghost_passive:GetModifierProcAttack_Feedback( param )
if not IsServer() then end 
if self.parent ~= param.attacker  then return end
param.target:EmitSound("UI.Ability_frost")

local particle = ParticleManager:CreateParticle( "particles/econ/items/lich/frozen_chains_ti6/lich_frozenchains_frostnova.vpcf", PATTACH_ABSORIGIN_FOLLOW, param.target )
ParticleManager:ReleaseParticleIndex( particle )

local damage = self:GetAbility():GetSpecialValueFor("damage")
if param.target:IsBuilding() then 
   damage = self:GetAbility():GetSpecialValueFor("tower_damage") 
end

damage = param.target:GetMaxHealth() * (damage / 100)

local duration = self:GetAbility():GetSpecialValueFor("duration")
param.target:AddNewModifier(self.parent, self:GetAbility(), "modifier_stunned", {duration = duration*(1 - param.target:GetStatusResistance())})
DoDamage({ victim = param.target, attacker = self:GetCaster(), ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})


self.parent:RemoveModifierByName("modifier_invulnerable")
self.parent:Kill(nil, nil)
end
