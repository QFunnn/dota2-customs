--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_enigma_boss_black_hole_custom_thinker", "abilities/enigma_boss/enigma_boss_black_hole_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_enigma_boss_black_hole_custom_debuff", "abilities/enigma_boss/enigma_boss_black_hole_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_enigma_boss_black_hole_custom_debuff_cd", "abilities/enigma_boss/enigma_boss_black_hole_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_enigma_boss_black_hole_custom_debuff_slow", "abilities/enigma_boss/enigma_boss_black_hole_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_enigma_boss_black_hole_custom_caster", "abilities/enigma_boss/enigma_boss_black_hole_custom.lua", LUA_MODIFIER_MOTION_NONE)


enigma_boss_black_hole_custom = class({})



function enigma_boss_black_hole_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/enigma_boss/black_hole_custom.vpcf", context )

end


function enigma_boss_black_hole_custom:OnSpellStart()
local caster = self:GetCaster()
local duration = self:GetSpecialValueFor("duration")

caster:EmitSound("Enigma_boss.Blackhole_vo")

local amount = 1
if caster:GetUpgradeStack("modifier_waveupgrade_boss") == 2 then
	amount = 2
end

for i = 1, amount do
	local angel = (math.pi/2 + 2*math.pi/2 * i)
	CreateModifierThinker(caster, self, "modifier_enigma_boss_black_hole_custom_thinker", {angle = angel}, caster:GetAbsOrigin(), caster:GetTeamNumber(), false)
end

caster:AddNewModifier(caster, self, "modifier_enigma_boss_black_hole_custom_caster", {})
end

modifier_enigma_boss_black_hole_custom_caster = class({})
function modifier_enigma_boss_black_hole_custom_caster:IsHidden() return true end
function modifier_enigma_boss_black_hole_custom_caster:IsPurgable() return false end


modifier_enigma_boss_black_hole_custom_thinker = class({})
function modifier_enigma_boss_black_hole_custom_thinker:IsHidden() return true end
function modifier_enigma_boss_black_hole_custom_thinker:IsPurgable() return false end
function modifier_enigma_boss_black_hole_custom_thinker:OnCreated(table)
if not IsServer() then return end 

self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.effect_cast = ParticleManager:CreateParticle( "particles/enigma_boss/black_hole_custom.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(self.hit_radius, 0, 0) )
self:AddParticle(self.effect_cast,false, false, -1, false, false)


self.parent:EmitSound("Enigma_boss.Blackhole_loop")

self.hit_radius = self.ability:GetSpecialValueFor("radius")
self.radius_min = self.ability:GetSpecialValueFor("radius_min")
self.radius_max = self.ability:GetSpecialValueFor("radius_max")

self.radius_speed = 40
self.radius_k = 1
self.radius_timer = 0 
self.radius_timer_max = 0.2
self.radius_stop = false
self.radius = self.radius_min

self.ability =  self:GetAbility()
self.caster = self:GetCaster()
self.target_point = nil
self.damage_dealt = false

self.center = self.caster:GetAbsOrigin()

self.current_angle = table.angle

self.current_speed = 1

if self.caster:GetUpgradeStack("modifier_waveupgrade_boss") ~= 2 then
	self.current_speed = 1.5
end

self.dt = 0.01
self:StartIntervalThink(self.dt)
self:OnIntervalThink()
end 

function modifier_enigma_boss_black_hole_custom_thinker:OnIntervalThink()
if not IsServer() then return end 

if not self.caster or self.caster:IsNull() or not self.caster:IsAlive() then 
	self:Destroy()
	return
end 


if self.caster:HasModifier("modifier_enigma_boss_black_hole_custom_debuff_slow") then
	return
end

self.center = self.caster:GetAbsOrigin()

local enemies = self.caster:FindTargets(1000, self.center)

for _,enemy in pairs(enemies) do
	if enemy:IsRealHero() then
		AddFOWViewer(enemy:GetTeamNumber(), self.parent:GetAbsOrigin(), 300, 0.2, false)
	end
end

self.current_angle = self.current_angle + self.current_speed * self.dt
if self.current_angle > 2*math.pi then
	self.current_angle = self.current_angle - 2*math.pi
end

local position = self:GetPosition()
self.parent:SetAbsOrigin(position)

self.radius = self.radius + self.radius_k * self.radius_speed * self.dt

if self.radius >= self.radius_max then 
	self.radius_k = -1
end 

if self.radius <= self.radius_min then 
	self.radius_k = 1
end 


end


function modifier_enigma_boss_black_hole_custom_thinker:GetPosition()

local abs = GetGroundPosition(self.center + Vector( math.cos( self.current_angle ), math.sin( self.current_angle ), 0 ) * self.radius, nil)

return abs
end

function modifier_enigma_boss_black_hole_custom_thinker:OnDestroy()
if not IsServer() then return end 

self.parent:StopSound("Enigma_boss.Blackhole_loop")

end 



function modifier_enigma_boss_black_hole_custom_thinker:IsAura()
return true
end

function modifier_enigma_boss_black_hole_custom_thinker:GetModifierAura()
return "modifier_enigma_boss_black_hole_custom_debuff"
end

function modifier_enigma_boss_black_hole_custom_thinker:GetAuraRadius()
return self.hit_radius
end

function modifier_enigma_boss_black_hole_custom_thinker:GetAuraDuration()
return 0.1
end

function modifier_enigma_boss_black_hole_custom_thinker:GetAuraSearchTeam()
return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_enigma_boss_black_hole_custom_thinker:GetAuraSearchType()
return DOTA_UNIT_TARGET_HERO
end

function modifier_enigma_boss_black_hole_custom_thinker:GetAuraEntityReject(hEntity)
return not hEntity:IsRealHero() or hEntity:HasModifier("modifier_enigma_boss_black_hole_custom_debuff_cd") or hEntity:IsDebuffImmune()
end


modifier_enigma_boss_black_hole_custom_debuff = class({})
function modifier_enigma_boss_black_hole_custom_debuff:IsHidden() return true end
function modifier_enigma_boss_black_hole_custom_debuff:IsPurgable() return false end
function modifier_enigma_boss_black_hole_custom_debuff:IsPurgeException() return true end
function modifier_enigma_boss_black_hole_custom_debuff:IsStunDebuff() return true end
function modifier_enigma_boss_black_hole_custom_debuff:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.thinker = self:GetAuraOwner()
self.ability = self:GetAbility()

self.stun = self.ability:GetSpecialValueFor("stun")
self.vec =  self.parent:GetAbsOrigin() - self.thinker:GetAbsOrigin()
self.damage = self.ability:GetSpecialValueFor("damage")*self.parent:GetMaxHealth()/100

if not IsServer() then return end

self.caster:AddNewModifier(self.caster, self.ability, "modifier_enigma_boss_black_hole_custom_debuff_slow", {duration = self.stun})

local real_damage = DoDamage({victim = self.parent, damage = self.damage, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_PURE})
self.parent:SendNumber(6, real_damage)

self.init = false
self.interval = 0.03
self.count = 0
self:StartIntervalThink(self.interval)
end

function modifier_enigma_boss_black_hole_custom_debuff:OnIntervalThink()
if not IsServer() then return end

if not self.thinker or self.thinker:IsNull() then
	self:Destroy()
	return
end

if not self.init then
	self.init = true
	self.parent:EmitSound("Enigma_boss.Blackhole_loop_caster")
end

self.parent:SetAbsOrigin(self.thinker:GetAbsOrigin() + self.vec:Normalized()*self.vec:Length2D()*0.8 )

self.count = self.count + self.interval

if self.count >= self.stun then
	self:Destroy()
	self:StartIntervalThink(-1)
end

end

function modifier_enigma_boss_black_hole_custom_debuff:OnDestroy()
if not IsServer() then return end

self.parent:StopSound("Enigma_boss.Blackhole_loop_caster")
self.parent:EmitSound("Enigma_boss.Blackhole_damage")


FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), false)
self.parent:AddNewModifier(self.parent, nil, "modifier_enigma_boss_black_hole_custom_debuff_cd", {duration = 2})
end
	
function modifier_enigma_boss_black_hole_custom_debuff:CheckState()
return
{
	[MODIFIER_STATE_STUNNED] = true
}
end


function modifier_enigma_boss_black_hole_custom_debuff:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end


function modifier_enigma_boss_black_hole_custom_debuff:GetOverrideAnimation()
return ACT_DOTA_FLAIL
end


modifier_enigma_boss_black_hole_custom_debuff_cd = class({})
function modifier_enigma_boss_black_hole_custom_debuff_cd:IsHidden() return true end
function modifier_enigma_boss_black_hole_custom_debuff_cd:IsPurgable() return false end


modifier_enigma_boss_black_hole_custom_debuff_slow = class({})
function modifier_enigma_boss_black_hole_custom_debuff_slow:IsHidden() return true end
function modifier_enigma_boss_black_hole_custom_debuff_slow:IsPurgable() return false end