--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_centaur_stun", "abilities/neutral_centaur_stun", LUA_MODIFIER_MOTION_NONE)


neutral_centaur_stun = class({})

function neutral_centaur_stun:GetIntrinsicModifierName()
if not self:GetCaster():IsCreep() then return end
return "modifier_centaur_stun" 
end


modifier_centaur_stun = class({})

function modifier_centaur_stun:IsPurgable() return false end

function modifier_centaur_stun:IsHidden() return true end


function modifier_centaur_stun:OnCreated(table)
if not IsServer() then return end
self:GetAbility():SetLevel(1)

self.ability  = self:GetAbility()
self.stun = self.ability:GetSpecialValueFor("stun")
self.aoe = self.ability:GetSpecialValueFor("aoe")
self.damage = self.ability:GetSpecialValueFor("damage")
self.illusion = self.ability:GetSpecialValueFor("illusion")

self.parent = self:GetParent()
end


function modifier_centaur_stun:StartCast(target)
if not IsServer() then return end
local array_target = nil

if target then 
  array_target = target:entindex()

  if target:IsStunned() then 
  	return
  end 
end

self:GetParent():EmitSound("n_creep_Centaur.Stomp")
self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_neutral_cast", {target = array_target, duration = 0.5, anim = ACT_DOTA_CAST_ABILITY_1, effect = 1, parent_mod = self:GetName()})
end


function modifier_centaur_stun:EndCast()
if not IsServer() then return end

local trail_pfx = ParticleManager:CreateParticle("particles/neutral_fx/neutral_centaur_khan_war_stomp.vpcf", PATTACH_ABSORIGIN, self.parent)
ParticleManager:SetParticleControl(trail_pfx, 1, Vector(self.aoe, self.aoe, self.aoe))
ParticleManager:ReleaseParticleIndex(trail_pfx) 

for _,target in pairs(self:GetParent():FindTargets(self.aoe)) do

	local damage = self.damage

	if target:IsIllusion() then 
		damage = target:GetMaxHealth()*self.illusion/100
	end

	SendOverheadEventMessage(target, 4, target, damage, nil)

	DoDamage({victim = target, attacker = self.parent, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability })
	target:AddNewModifier(self.parent, self.ability, "modifier_stunned", { duration = self.stun * (1 - target:GetStatusResistance()) })
end
      
end



