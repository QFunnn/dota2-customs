--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_enigma_boss_midnight_custom_thinker", "abilities/enigma_boss/enigma_boss_midnight_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_enigma_boss_midnight_custom_debuff", "abilities/enigma_boss/enigma_boss_midnight_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_enigma_boss_midnight_custom_delay", "abilities/enigma_boss/enigma_boss_midnight_custom.lua", LUA_MODIFIER_MOTION_NONE)



enigma_boss_midnight_custom = class({})



function enigma_boss_midnight_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_enigma/enigma_midnight_pulse.vpcf", context )
PrecacheResource( "particle", "particles/enigma_boss/midnight_timer.vpcf", context )
PrecacheResource( "particle", "particles/enigma_boss/midnight_aoe.vpcf", context )
PrecacheResource( "particle", "particles/enigma_boss/midnight_spawn.vpcf", context )

end


function enigma_boss_midnight_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()
local delay = self:GetSpecialValueFor("delay")

caster:EmitSound("Enigma_boss.Midnight_vo")
caster:EmitSound("Enigma_boss.Midnight_spawn")

self.abs = {}

local max = self:GetSpecialValueFor("count")
local radius = self:GetSpecialValueFor("radius")
local global_radius = self:GetSpecialValueFor("global_radius")

for i = 1,max do
	local vec
	local count = 0

	repeat vec = RandomVector(RandomInt(radius, global_radius))
		count = count + 1
	until self:IsValid(caster:GetAbsOrigin() + vec) or (count >= 20)

	local new_point = caster:GetAbsOrigin() + vec
	table.insert(self.abs, new_point)
	
	CreateModifierThinker(caster, self, "modifier_enigma_boss_midnight_custom_delay", {duration = delay}, new_point, caster:GetTeamNumber(), false)
end

end


function enigma_boss_midnight_custom:IsValid(point)
if not self.abs then return true end

local radius = self:GetSpecialValueFor("radius")*2

for _,old_point in pairs(self.abs) do
	if (old_point - point):Length2D() <= radius then
		return false
	end
end

return true
end





modifier_enigma_boss_midnight_custom_thinker = class({})
function modifier_enigma_boss_midnight_custom_thinker:IsHidden() return true end
function modifier_enigma_boss_midnight_custom_thinker:IsPurgable() return false end
function modifier_enigma_boss_midnight_custom_thinker:OnCreated(table)
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.radius = self.ability:GetSpecialValueFor("radius")

if not IsServer() then return end

self.parent:EmitSound("Enigma_boss.Midnight_loop")
self.parent:EmitSound("Enigma_boss.Midnight_start")

local effect_cast = ParticleManager:CreateParticle( "particles/enigma_boss/midnight_spawn.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetAbsOrigin() )
ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 0, 0 ) )
ParticleManager:ReleaseParticleIndex( effect_cast )

self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_enigma/enigma_midnight_pulse.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 1, Vector(self.radius, 0, 0))
self:AddParticle( self.particle, false, false, -1, false, false )

end

function modifier_enigma_boss_midnight_custom_thinker:OnDestroy()
if not IsServer() then return end
if not self.parent or self.parent:IsNull() then return end
self.parent:StopSound("Enigma_boss.Midnight_loop")
end

function modifier_enigma_boss_midnight_custom_thinker:IsAura() return true end
function modifier_enigma_boss_midnight_custom_thinker:GetAuraDuration() return 0.1 end
function modifier_enigma_boss_midnight_custom_thinker:GetAuraRadius() return self.radius end
function modifier_enigma_boss_midnight_custom_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_enigma_boss_midnight_custom_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_enigma_boss_midnight_custom_thinker:GetModifierAura() return "modifier_enigma_boss_midnight_custom_debuff" end





modifier_enigma_boss_midnight_custom_delay = class({})
function modifier_enigma_boss_midnight_custom_delay:IsHidden() return false end
function modifier_enigma_boss_midnight_custom_delay:IsPurgable() return false end
function modifier_enigma_boss_midnight_custom_delay:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.duration = self.ability:GetSpecialValueFor("duration")
self.radius = self.ability:GetSpecialValueFor("radius")
self.time = self.ability:GetSpecialValueFor("delay")


if self.caster:GetUpgradeStack("modifier_waveupgrade_boss") == 2 then
	self.duration = self.ability:GetSpecialValueFor("duration_2")
end


if not IsServer() then return end
self.effect_cast = ParticleManager:CreateParticle("particles/enigma_boss/midnight_aoe.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 0, -self.radius/self:GetRemainingTime() ) )
ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( self:GetRemainingTime(), 0, 0 ) )
self:AddParticle( self.effect_cast, false, false, -1, false, false )

self.interval = 0.5
self.t = -1

self.timer = self.time*2 
--self:StartIntervalThink(self.interval)
--self:OnIntervalThink()
end


function modifier_enigma_boss_midnight_custom_delay:OnIntervalThink()
if not IsServer() then return end

self.t = self.t + 1

local number = (self.timer-self.t)/2 
local int = 0
int = number
if number % 1 ~= 0 then int = number - 0.5 end

local digits = math.floor(math.log10(number)) + 2

local decimal = number % 1

if decimal == 0.5 then
  decimal = 8
else 
  decimal = 1
end

local particle = ParticleManager:CreateParticle("particles/enigma_boss/midnight_timer.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(particle, 1, Vector(0, int, decimal))
ParticleManager:SetParticleControl(particle, 2, Vector(digits, 0, 0))
ParticleManager:ReleaseParticleIndex(particle)
end



function modifier_enigma_boss_midnight_custom_delay:OnDestroy()
if not IsServer() then return end
if not self.caster or self.caster:IsNull() or not self.caster:IsAlive() then return end

CreateModifierThinker(self.caster, self.ability, "modifier_enigma_boss_midnight_custom_thinker", {duration = self.duration}, self.parent:GetAbsOrigin(), self.caster:GetTeamNumber(), false)
end









modifier_enigma_boss_midnight_custom_debuff = class({})
function modifier_enigma_boss_midnight_custom_debuff:IsHidden() return false end
function modifier_enigma_boss_midnight_custom_debuff:IsPurgable() return false end
function modifier_enigma_boss_midnight_custom_debuff:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.damage = self.ability:GetSpecialValueFor("damage")/100
self.interval = self.ability:GetSpecialValueFor("interval")
self.damage_reduce = self.ability:GetSpecialValueFor("damage_reduce")
self.slow = self.ability:GetSpecialValueFor("slow")

if self.caster:GetUpgradeStack("modifier_waveupgrade_boss") == 2 then
	self.damage_reduce = self.ability:GetSpecialValueFor("damage_reduce_2")
end


if not IsServer() then return end

self:StartIntervalThink(self.interval)
end

function modifier_enigma_boss_midnight_custom_debuff:OnIntervalThink()
if not IsServer() then return end

local damage = self.parent:GetMaxHealth()*self.damage*self.interval
DoDamage({victim = self.parent, attacker = self.caster, ability = self.ability, damage = damage, damage_type = DAMAGE_TYPE_PURE})
end


function modifier_enigma_boss_midnight_custom_debuff:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end
function modifier_enigma_boss_midnight_custom_debuff:GetStatusEffectName()
return "particles/status_fx/status_effect_enchantress_shard_debuff.vpcf"
end

function modifier_enigma_boss_midnight_custom_debuff:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end
function modifier_enigma_boss_midnight_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end


function modifier_enigma_boss_midnight_custom_debuff:GetModifierDamageOutgoing_Percentage()
return self.damage_reduce
end

function modifier_enigma_boss_midnight_custom_debuff:GetModifierSpellAmplify_Percentage()
return self.damage_reduce
end
