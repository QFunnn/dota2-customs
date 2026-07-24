--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_conjure_image_custom_tracker", "abilities/terrorblade/custom_terrorblade_conjure_image", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_conjure_image_custom_legendary_invun", "abilities/terrorblade/custom_terrorblade_conjure_image", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_conjure_image_custom_legendary_legendary_cd", "abilities/terrorblade/custom_terrorblade_conjure_image", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_conjure_image_custom_invun", "abilities/terrorblade/custom_terrorblade_conjure_image", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_conjure_image_custom_legendary_illusion_mod", "abilities/terrorblade/custom_terrorblade_conjure_image", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_conjure_image_custom_illusion_basic", "abilities/terrorblade/custom_terrorblade_conjure_image", LUA_MODIFIER_MOTION_NONE)


custom_terrorblade_conjure_image = class({})

custom_terrorblade_conjure_image.illusions = {}


function custom_terrorblade_conjure_image:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "terrorblade_conjure_image", self)
end



function custom_terrorblade_conjure_image:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end


PrecacheResource( "particle","particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade_2.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_r.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_l.vpcf", context )
PrecacheResource( "particle","particles/terrorblade_custom/terrorblade_feet_effects.vpcf", context )

PrecacheResource( "particle","particles/units/heroes/hero_terrorblade/terrorblade_sunder.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave_burn.vpcf", context )
PrecacheResource( "particle","particles/tb_illusion_legendary.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/manta_phase.vpcf", context )
PrecacheResource( "particle","particles/terrorblade/image_blink.vpcf", context )
PrecacheResource( "particle","particles/terrorblade/illusion_damage_reduce.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_terrorblade/terrorblade_death_custom.vpcf", context )
end


function custom_terrorblade_conjure_image:GetCooldown(iLevel)
local upgrade_cooldown = 0
if self:GetCaster():HasTalent("modifier_terror_illusion_2") then 
	upgrade_cooldown = self:GetCaster():GetTalentValue("modifier_terror_illusion_2", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown
end

function custom_terrorblade_conjure_image:GetManaCost(level)
local caster = self:GetCaster()
local bonus = 0
if caster:HasTalent("modifier_terror_illusion_2") then 
	bonus = caster:GetTalentValue("modifier_terror_illusion_2", "mana")
end
return self.BaseClass.GetManaCost(self,level) + bonus
end


function custom_terrorblade_conjure_image:GetCastRange(vLocation, hTarget)
local caster = self:GetCaster()
if not caster:HasTalent("modifier_terror_illusion_5") then return end

if IsClient() then
	return caster:GetTalentValue("modifier_terror_illusion_5", "range")
end
return 999999
end

function custom_terrorblade_conjure_image:GetBehavior()
local bonus = 0
local base = DOTA_ABILITY_BEHAVIOR_NO_TARGET
if self:GetCaster():HasTalent("modifier_terror_illusion_5") then
	base = DOTA_ABILITY_BEHAVIOR_POINT
	bonus = DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end
return base + bonus
end


function custom_terrorblade_conjure_image:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_conjure_image_custom_tracker"
end

function custom_terrorblade_conjure_image:SpawnIllusion(spaw_unit, attack_target)
local caster = self:GetCaster()

local duration = self:GetSpecialValueFor("illusion_duration")
local outgoing = self:GetSpecialValueFor("illusion_outgoing_damage")
local incoming = self:GetSpecialValueFor("illusion_incoming_damage")

local position = 108
local scramble = false 
local count = 1

if caster:HasTalent("modifier_terror_illusion_5") then 
	position = 0
	scramble = true
end

if spaw_unit then 
	spaw_unit:EmitSound("Hero_Terrorblade.ConjureImage")
	duration = caster:GetTalentValue("modifier_terror_illusion_7", "duration")
	outgoing = caster:GetTalentValue("modifier_terror_illusion_7", "damage") - 100
	incoming = caster:GetTalentValue("modifier_terror_illusion_7", "incoming") - 100
	scramble = false

	local effect = ParticleManager:CreateParticle("particles/general/illusion_created.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, spaw_unit)
	ParticleManager:SetParticleControlEnt( effect, 0, spaw_unit, PATTACH_POINT_FOLLOW, "attach_hitloc", spaw_unit:GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex(effect)
else

	if caster:HasTalent("modifier_terror_illusion_6") then
		caster:AddNewModifier(caster, self, "modifier_terrorblade_innate_custom_damage_reduce", {duration = caster:GetTalentValue("modifier_terror_illusion_6", "duration")})
	end

	caster:EmitSound("Hero_Terrorblade.ConjureImage")
end


local illusions = CreateIllusions(caster, caster, {
	outgoing_damage = outgoing,
	incoming_damage	= incoming,
	bounty_base		= nil, 
	bounty_growth	= nil,
	outgoing_damage_structure	= nil,
	outgoing_damage_roshan		= nil,
	duration = duration
}
, count, position, scramble, true, spaw_unit ~= nil)


for _, illusion in pairs(illusions) do

	illusion.owner = caster	

	illusion:AddNewModifier(caster, self, "modifier_conjure_image_custom_illusion_basic", {duration = duration, is_legendary = spaw_unit ~= nil})

	if spaw_unit then 
		illusion:SetOwner(nil)
		local point = spaw_unit:GetAbsOrigin() + Vector(100)
		illusion:SetAbsOrigin(point)
		FindClearSpaceForUnit(illusion, point, false)

		local target = nil
		if attack_target then
			target = attack_target
		end

		illusion:AddNewModifier(caster, self, "modifier_conjure_image_custom_legendary_illusion_mod", {target = target})
	end

  illusion:RemoveAbility("custom_terrorblade_reflection")
  illusion:RemoveAbility("custom_terrorblade_conjure_image")
  illusion:RemoveAbility("custom_terrorblade_metamorphosis")
  illusion:RemoveAbility("custom_terrorblade_sunder")
  illusion:RemoveAbility("custom_terrorblade_terror_wave")

	illusion:StartGesture(ACT_DOTA_CAST_ABILITY_3_END)
	
  for _,mod in pairs(caster:FindAllModifiers()) do
    if mod.StackOnIllusion ~= nil and mod.StackOnIllusion == true then
      illusion:UpgradeIllusion(mod:GetName(), mod:GetStackCount() )
    end
  end
end

end



function custom_terrorblade_conjure_image:OnSpellStart()
local caster = self:GetCaster()

if caster:HasTalent("modifier_terror_illusion_5") and not caster:IsRooted() and not caster:IsLeashed() then
	local point = self:GetCursorPosition()
	if point == caster:GetAbsOrigin() then
		point = caster:GetAbsOrigin() + caster:GetForwardVector()*10
	end

	local vec = point - caster:GetAbsOrigin()
	local max_range = caster:GetTalentValue("modifier_terror_illusion_5", "range") + caster:GetCastRangeBonus()
	if vec:Length2D() > max_range then
		point = caster:GetAbsOrigin() + vec:Normalized()*max_range
	end

	caster:AddNewModifier(caster, self, "modifier_conjure_image_custom_invun", {x = point.x, y = point.y, duration = caster:GetTalentValue("modifier_terror_illusion_5", "invun")})
else
	self:SpawnIllusion()
end

end



modifier_conjure_image_custom_tracker = class({})
function modifier_conjure_image_custom_tracker:IsHidden() return true end
function modifier_conjure_image_custom_tracker:IsPurgable() return false end


function modifier_conjure_image_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.legendary_max = self.parent:GetTalentValue("modifier_terror_illusion_7", "max", true)
self.legendary_chance = self.parent:GetTalentValue("modifier_terror_illusion_7", "chance", true)
self.legendary_radius = self.parent:GetTalentValue("modifier_terror_illusion_7", "radius", true)
self.legendary_heal = self.parent:GetTalentValue("modifier_terror_illusion_7", "heal", true)
self.parent:AddAttackEvent_out(self)
end


function modifier_conjure_image_custom_tracker:AttackEvent_out(params)
if not IsServer() then return end
if self.parent:GetTeamNumber() ~= params.attacker:GetTeamNumber() then return end
if not params.target:IsUnit() then return end

local attacker = params.attacker

if self.parent:HasTalent("modifier_terror_illusion_7") and attacker:IsIllusion() and attacker.owner and attacker.owner == self.parent and self:GetStackCount() < self.legendary_max then 
	if RollPseudoRandomPercentage(self.legendary_chance,1842,self.parent) then 
		self.ability:SpawnIllusion(attacker, params.target:entindex())
	end
end

if not self.parent:HasTalent("modifier_terror_illusion_7") then return end
if not attacker.owner or attacker.owner ~= self.parent or not attacker:IsIllusion() or not attacker.owner:IsAlive() then return end

attacker.owner:GenericHeal(self.legendary_heal, self.ability, true, "", "modifier_terror_illusion_7")
end






modifier_conjure_image_custom_invun = class({})
function modifier_conjure_image_custom_invun:IsHidden()  return true end
function modifier_conjure_image_custom_invun:IsPurgable() return false end

function modifier_conjure_image_custom_invun:OnCreated(table)
self.ability = self:GetAbility()
self.parent = self:GetParent()
if not IsServer() then return end

self.parent:AddNoDraw()
self.parent:NoDraw(self)

self.origin = self.parent:GetAbsOrigin()
self.point = GetGroundPosition(Vector(table.x, table.y, 0), nil)

local vec = (self.point - self.origin):Normalized()
vec.z = 0
self.parent:FaceTowards(self.origin + vec*10)
self.parent:SetForwardVector(vec)

local point_1 = self.point + Vector(0,0,150)
local point_2 = self.origin + Vector(0,0,150)

EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "TB.Image_blink_start", self.parent)
EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "TB.Image_blink_start2", self.parent)

local effect_cast = ParticleManager:CreateParticle("particles/terrorblade/image_blink.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(effect_cast, 0, self.point + Vector(0,0,100))
ParticleManager:SetParticleControl(effect_cast, 1, self.origin + Vector(0,0,100))
ParticleManager:SetParticleControl(effect_cast, 2, self.point)
ParticleManager:ReleaseParticleIndex(effect_cast)
end


function modifier_conjure_image_custom_invun:OnDestroy()
if not IsServer() then return end
if not self.parent or self.parent:IsNull() then return end

self.parent:RemoveNoDraw()
self.parent:SetAbsOrigin(self.point)

if not self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
	self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_3_END)
end

self.parent:Stop()

FindClearSpaceForUnit(self.parent, self.point, false)
self.ability:SpawnIllusion()
end

function modifier_conjure_image_custom_invun:CheckState()
return 
{
  [MODIFIER_STATE_INVULNERABLE]       = true,
  [MODIFIER_STATE_NO_HEALTH_BAR]      = true,
  [MODIFIER_STATE_STUNNED]            = true,
  [MODIFIER_STATE_OUT_OF_GAME]        = true,
  [MODIFIER_STATE_NO_UNIT_COLLISION]  = true
}
end





modifier_conjure_image_custom_legendary_illusion_mod = class({})
function modifier_conjure_image_custom_legendary_illusion_mod:IsHidden() return true end
function modifier_conjure_image_custom_legendary_illusion_mod:IsPurgable() return false end
function modifier_conjure_image_custom_legendary_illusion_mod:OnCreated(table)
if not IsServer() then return end
self.target = nil
self.parent = self:GetParent()

if table.target then
	self.target = EntIndexToHScript(table.target)
end

self.mod = self:GetCaster():FindModifierByName("modifier_conjure_image_custom_tracker")
if self.mod then
	self.mod:IncrementStackCount()
end

self:OnIntervalThink()
self:StartIntervalThink(0.5)
end

function modifier_conjure_image_custom_legendary_illusion_mod:OnDestroy()
if not IsServer() then return end
if not self.mod or self.mod:IsNull() then return end
self.mod:DecrementStackCount()
end


function modifier_conjure_image_custom_legendary_illusion_mod:OnIntervalThink()
if not IsServer() then return end

local target = nil

if self.target and not self.target:IsNull() and self.target:IsAlive() then
	target = self.target
else
	target = self.parent:FindTargets(1000)[1]
end

if not target then 
	return
end

self.target = target
self.parent:SetForceAttackTarget(target)
self.parent:MoveToTargetToAttack(target)
end


function modifier_conjure_image_custom_legendary_illusion_mod:CheckState()
return
{
	[MODIFIER_STATE_COMMAND_RESTRICTED] = true
}
end



modifier_conjure_image_custom_illusion_basic = class({})
function modifier_conjure_image_custom_illusion_basic:IsHidden() return true end
function modifier_conjure_image_custom_illusion_basic:IsPurgable() return false end
function modifier_conjure_image_custom_illusion_basic:OnCreated(table)
self.ability = self:GetAbility()
self.parent = self:GetParent()
self.max = self.ability:GetSpecialValueFor("illusion_max")
if not IsServer() then return end
self.is_legendary = table.is_legendary

if self.is_legendary and self.is_legendary == 1 then return end

local count = 0
local min_duration = 9999
local min_index = nil

for index,_ in pairs(self.ability.illusions) do
	count = count + 1
	local unit = EntIndexToHScript(index)
	if unit and not unit:IsNull() then
		local mod = unit:FindModifierByName(self:GetName())
		if mod and mod:GetRemainingTime() <= min_duration then
			min_duration = mod:GetRemainingTime()
			min_index = index
		end
	end
	if count >= self.max and min_index then
		local unit = EntIndexToHScript(min_index)
		if unit and not unit:IsNull() then
			unit:Kill(nil, nil)
		end
		break
	end
end

self.ability.illusions[self.parent:entindex()] = true
end

function modifier_conjure_image_custom_illusion_basic:OnDestroy(table)
if not IsServer() then return end
if self.is_legendary and self.is_legendary == 1 then return end

self.ability.illusions[self.parent:entindex()] = nil
end