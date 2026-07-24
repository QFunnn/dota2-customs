--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bird_tornado", "abilities/neutral_bird_tornado", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tornado_think", "abilities/neutral_bird_tornado", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tornado_think_slow", "abilities/neutral_bird_tornado", LUA_MODIFIER_MOTION_NONE)



neutral_bird_tornado = class({})

function neutral_bird_tornado:GetIntrinsicModifierName()
if not self:GetCaster():IsCreep() then return end  
return "modifier_bird_tornado" 
end





modifier_bird_tornado = class({})

function modifier_bird_tornado:IsPurgable() return false end

function modifier_bird_tornado:IsHidden() return true end

function modifier_bird_tornado:OnCreated(table)

self.health = self:GetAbility():GetSpecialValueFor("health")
self.duration = self:GetAbility():GetSpecialValueFor("duration")

end


function modifier_bird_tornado:StartCast(target)
if not IsServer() then return end
local array_target = nil

if target then 
  array_target = target:entindex()
end

self:GetParent():AddNewModifier(self.parent, self:GetAbility(), "modifier_neutral_cast", {target = array_target, duration = 0.4, anim = ACT_DOTA_CAST_ABILITY_1, parent_mod = self:GetName()})
end



function modifier_bird_tornado:EndCast()
if not IsServer() then return end

local parent = self:GetParent()

parent:EmitSound("n_creep_Wildkin.SummonTornado")

local tornado = CreateUnitByName("npc_dota_enraged_wildkin_tornado", self:GetParent():GetAbsOrigin() + 250*self:GetParent():GetForwardVector(), true, nil, nil, DOTA_TEAM_NEUTRALS)
tornado:SetOwner(parent)
tornado:AddNewModifier(tornado, self:GetAbility(), "modifier_kill", {duration = self.duration})
tornado:AddNewModifier(tornado, self:GetAbility(), "modifier_tornado_think", {})

end





modifier_tornado_think = class({})

function modifier_tornado_think:IsPurgable() return false end
function modifier_tornado_think:IsHidden() return true end


function modifier_tornado_think:CheckState()
return
{
	[MODIFIER_STATE_STUNNED] = true,
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true
}
end

function modifier_tornado_think:DeclareFunctions() 
return 
{
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
} 
end

function modifier_tornado_think:GetAbsoluteNoDamageMagical() return 1 end
function modifier_tornado_think:GetAbsoluteNoDamagePhysical() return 1 end
function modifier_tornado_think:GetAbsoluteNoDamagePure() return 1 end

function modifier_tornado_think:AttackEvent_inc( param )
if not IsServer() then return end
if self:GetParent() ~= param.target then return end

self.health = self.health - 1

if self.health <= 0 then
	self:GetParent():Kill(nil, param.attacker)
else 
	self:GetParent():SetHealth(self.health)
end

end


function modifier_tornado_think:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.parent:AddAttackEvent_inc(self, true)

self.damage = self:GetAbility():GetSpecialValueFor("damage")
self.health = self:GetAbility():GetSpecialValueFor("health")
self.aoe = self:GetAbility():GetSpecialValueFor("aoe")
self.illusion = self:GetAbility():GetSpecialValueFor("illusion")

self.interval = 0.2

self.effect = ParticleManager:CreateParticle( "particles/creatures/enraged_wildkin/enraged_wildkin_tornado.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
self:AddParticle(self.effect,false, false, -1, false, false)

self:StartIntervalThink(self.interval)
end

function modifier_tornado_think:OnIntervalThink()
if not IsServer() then return end

for _,target in pairs(self:GetParent():FindTargets(self.aoe)) do
  
	local damage = self.damage
	if target:IsIllusion() then 
	    damage = target:GetMaxHealth()*self.illusion/100
	end
	DoDamage({victim = target, attacker = self:GetParent(), damage = damage*self.interval, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})

	target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_tornado_think_slow", {duration = 0.5})
end 

end





modifier_tornado_think_slow = class({})
function modifier_tornado_think_slow:IsHidden() return false  end
function modifier_tornado_think_slow:GetTexture() return "enraged_wildkin_tornado" end
function modifier_tornado_think_slow:IsPurgable() return true end

function modifier_tornado_think_slow:OnCreated(table)
self.slow = self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_tornado_think_slow:DeclareFunctions()
return 
{
   MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
}
end


function modifier_tornado_think_slow:GetModifierAttackSpeedBonus_Constant() 
return self.slow
end