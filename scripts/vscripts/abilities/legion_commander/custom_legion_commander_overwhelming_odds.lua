--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_overwhelming_odds_custom_speed", "abilities/legion_commander/custom_legion_commander_overwhelming_odds", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_overwhelming_odds_custom_slow", "abilities/legion_commander/custom_legion_commander_overwhelming_odds", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_overwhelming_odds_custom_tracker", "abilities/legion_commander/custom_legion_commander_overwhelming_odds", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_overwhelming_odds_custom_legendary", "abilities/legion_commander/custom_legion_commander_overwhelming_odds", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_overwhelming_odds_custom_proc_charge", "abilities/legion_commander/custom_legion_commander_overwhelming_odds", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_overwhelming_odds_custom_heal_reduce", "abilities/legion_commander/custom_legion_commander_overwhelming_odds", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_overwhelming_odds_custom_damage", "abilities/legion_commander/custom_legion_commander_overwhelming_odds", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_overwhelming_odds_custom_shield", "abilities/legion_commander/custom_legion_commander_overwhelming_odds", LUA_MODIFIER_MOTION_NONE)

custom_legion_commander_overwhelming_odds = class({})
custom_legion_commander_overwhelming_odds.talents = {}

function custom_legion_commander_overwhelming_odds:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_weapon_blur.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_weapon_blurb.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_weapon_blurc.vpcf", context )

PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_commander_odds_cast.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_commander_odds.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_commander_odds_dmga.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_commander_odds_buff.vpcf", context )

PrecacheResource( "particle", "particles/lc_odd_proc_burst.vpcf", context )
PrecacheResource( "particle", "particles/lina_timer.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf", context )
PrecacheResource( "particle", "particles/status_fx/status_effect_snapfire_slow.vpcf", context )
PrecacheResource( "particle", "particles/items_fx/force_staff.vpcf", context )
PrecacheResource( "particle", "particles/lc_odd_charge.vpcf", context )
PrecacheResource( "particle", "particles/items2_fx/vindicators_axe_armor.vpcf", context )
PrecacheResource( "particle", "particles/legion_commander/odds_legendary_aoe.vpcf", context )
PrecacheResource( "particle", "particles/bristleback/back_shield.vpcf", context )

dota1x6:PrecacheShopItems("npc_dota_hero_legion_commander", context)
end

function custom_legion_commander_overwhelming_odds:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_q1 = 0,
    q1_damage = 0,
    q1_heal_reduce = 0,
    q1_duration = caster:GetTalentValue("modifier_legion_odds_1", "duration", true),
    
    has_q2 = 0,
    q2_cd = 0,
    q2_radius = 0,
    
    has_q3 = 0,
    q3_damage = 0,
    q3_spell = 0,
    q3_duration = caster:GetTalentValue("modifier_legion_odds_3", "duration", true),
    q3_damage_max = caster:GetTalentValue("modifier_legion_odds_3", "damage_max", true)/100,
    q3_damage_type = caster:GetTalentValue("modifier_legion_odds_3", "damage_type", true),
    
    has_q4 = 0,
    q4_shield_max = caster:GetTalentValue("modifier_legion_odds_4", "shield_max", true)/100,
    q4_duration = caster:GetTalentValue("modifier_legion_odds_4", "duration", true),
    q4_shield = caster:GetTalentValue("modifier_legion_odds_4", "shield", true)/100,
    
    has_q7 = 0,
    q7_damage_max = caster:GetTalentValue("modifier_legion_odds_7", "damage_max", true)/100,
    q7_damage = caster:GetTalentValue("modifier_legion_odds_7", "damage", true)/100,
    q7_max = caster:GetTalentValue("modifier_legion_odds_7", "max", true),
    q7_speed = caster:GetTalentValue("modifier_legion_odds_7", "speed", true),
    q7_radius = caster:GetTalentValue("modifier_legion_odds_7", "radius", true),
    q7_interval = caster:GetTalentValue("modifier_legion_odds_7", "interval", true),
    q7_aoe_radius = caster:GetTalentValue("modifier_legion_odds_7", "aoe_radius", true),
    
    has_w4 = 0,
    w4_odds_count = caster:GetTalentValue("modifier_legion_press_4", "odds_count", true),

    has_w7 = 0,

    has_h4 = 0,
    h4_silence = caster:GetTalentValue("modifier_legion_hero_4", "silence", true),
    h4_slow = caster:GetTalentValue("modifier_legion_hero_4", "slow", true),
  }
end

if caster:HasTalent("modifier_legion_odds_1") then
  self.talents.has_q1 = 1
  self.talents.q1_damage = caster:GetTalentValue("modifier_legion_odds_1", "damage")/100
  self.talents.q1_heal_reduce = caster:GetTalentValue("modifier_legion_odds_1", "heal_reduce")
end

if caster:HasTalent("modifier_legion_odds_2") then
  self.talents.has_q2 = 1
  self.talents.q2_cd = caster:GetTalentValue("modifier_legion_odds_2", "cd")
  self.talents.q2_radius = caster:GetTalentValue("modifier_legion_odds_2", "radius")
end

if caster:HasTalent("modifier_legion_odds_3") then
  self.talents.has_q3 = 1
  self.talents.q3_damage = caster:GetTalentValue("modifier_legion_odds_3", "damage")/100
  self.talents.q3_spell = caster:GetTalentValue("modifier_legion_odds_3", "spell")
  if IsServer() then
  	self.tracker:UpdateUI()
  	caster:AddDamageEvent_out(self.tracker, true)
  end
end

if caster:HasTalent("modifier_legion_odds_4") then
  self.talents.has_q4 = 1
end

if caster:HasTalent("modifier_legion_odds_7") then
  self.talents.has_q7 = 1
end

if caster:HasTalent("modifier_legion_press_4") then
  self.talents.has_w4 = 1
end

if caster:HasTalent("modifier_legion_press_7") then
  self.talents.has_w7 = 1
end

if caster:HasTalent("modifier_legion_hero_4") then
  self.talents.has_h4 = 1
end

end

function custom_legion_commander_overwhelming_odds:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_overwhelming_odds_custom_tracker" 
end

function custom_legion_commander_overwhelming_odds:OnInventoryContentsChanged()
if not IsServer() then return end
if self.shard_init then return end
if not self.caster:HasShard() then return end

self.shard_init = true
self:ToggleAutoCast()
end

function custom_legion_commander_overwhelming_odds:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "legion_commander_overwhelming_odds", self)
end

function custom_legion_commander_overwhelming_odds:GetBehavior()
local result = DOTA_ABILITY_BEHAVIOR_NO_TARGET
if self.talents.has_q7 == 1 or self.caster:HasShard() then
	result = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
end
if self.caster:HasShard() then
	result = result + DOTA_ABILITY_BEHAVIOR_AUTOCAST
end
return result
end

function custom_legion_commander_overwhelming_odds:GetCastAnimation()
if self.caster:HasShard() and self:GetAutoCastState() then
	return 0
end
return ACT_DOTA_CAST_ABILITY_1
end

function custom_legion_commander_overwhelming_odds:GetRadius()
local base = (self.ability.radius and self.ability.radius or 0) 
if self.talents.has_q7 == 1 then
	base = self.talents.q7_aoe_radius
end
return base + (self.talents.has_q2 == 1 and self.ability.talents.q2_radius or 0)
end

function custom_legion_commander_overwhelming_odds:GetAOERadius()
return self:GetRadius()
end

function custom_legion_commander_overwhelming_odds:GetCastPoint(iLevel)
return self.BaseClass.GetCastPoint(self) + (self.caster:HasShard() and self.shard_cast or 0)
end

function custom_legion_commander_overwhelming_odds:GetCooldown(iLevel)
return self.BaseClass.GetCooldown(self, iLevel) + (self.talents.has_q2 == 1 and self.talents.q2_cd or 0)
end

function custom_legion_commander_overwhelming_odds:GetCastRange(location, target)
if self.caster:HasShard() or self.talents.has_q7 == 1 then 
	return self.ability.shard_range
end
return self:GetRadius() - self.caster:GetCastRangeBonus() 
end

function custom_legion_commander_overwhelming_odds:OnAbilityPhaseStart()
if not IsServer() then return end
self.cast = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_odds_cast.vpcf", PATTACH_CUSTOMORIGIN, self.caster)
ParticleManager:SetParticleControlEnt( self.cast, 1, self.caster, PATTACH_POINT_FOLLOW, "attach_attack1", self.caster:GetAbsOrigin(), true )
self.caster:EmitSound("Hero_LegionCommander.Overwhelming.Cast")
return true 
end

function custom_legion_commander_overwhelming_odds:OnAbilityPhaseInterrupted()
if not IsServer() then return end
if not self.cast then return end
ParticleManager:DestroyParticle(self.cast, false)
ParticleManager:ReleaseParticleIndex(self.cast)
end

function custom_legion_commander_overwhelming_odds:OnSpellStart()
local point = self.caster:GetAbsOrigin()

if self.caster:HasShard() or self.ability.talents.has_q7 == 1 then 
	point = self:GetCursorPosition()
	if point == self.caster:GetAbsOrigin() then 
		point = self.caster:GetAbsOrigin() + self.caster:GetForwardVector()*10
	end 

	local dir = (point - self.caster:GetAbsOrigin())
	dir.z = 0

	local vec = dir:Normalized() 
	self.caster:FaceTowards(point)
	self.caster:SetForwardVector(vec)

	if self.caster:HasShard() and self:GetAutoCastState() and not self.caster:IsRooted() and not self.caster:IsLeashed() then 
		local duration = (point - self.caster:GetAbsOrigin()):Length2D()/self.shard_speed
		self.caster:AddNewModifier(self.caster, self, "modifier_overwhelming_odds_custom_proc_charge", {x = point.x, y = point.y, duration = duration})
	end
end

self:ProcOdds(point)

if self.ability.talents.has_q4 == 1 then
	self.caster:RemoveModifierByName("modifier_overwhelming_odds_custom_shield")
	self.caster:AddNewModifier(self.caster, self, "modifier_overwhelming_odds_custom_shield", {})
end

if self.ability.talents.has_q7 == 1 then
	CreateModifierThinker(self.caster, self, "modifier_overwhelming_odds_custom_legendary", {}, point, self.caster:GetTeamNumber(), false)
end

end


function custom_legion_commander_overwhelming_odds:ProcOdds(point, source, buffed)
if not IsServer() then return end
local radius = self:GetRadius()
local damage = self.damage + self.ability.talents.q1_damage*(self.caster:GetStrength() + self.caster:GetIntellect(false))
local slow_duration = self.slow_duration + (self.talents.has_h4 == 1 and self.talents.h4_slow or 0)

local particle_cast = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_legion_commander/legion_commander_odds.vpcf", self)
local particle_damage = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_legion_commander/legion_commander_odds_dmga.vpcf", self)
local sound_cast = wearables_system:GetSoundReplacement(self.caster, "Hero_LegionCommander.Overwhelming.Location", self)

EmitSoundOnLocationWithCaster(point, sound_cast, self.caster)

local particle = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( particle, 0, point )
ParticleManager:SetParticleControl( particle, 1, source and point or self.caster:GetAbsOrigin() )
ParticleManager:SetParticleControl( particle, 2, point )
ParticleManager:SetParticleControl( particle, 3, point )
ParticleManager:SetParticleControl( particle, 4, Vector( radius, radius, radius ) )
ParticleManager:SetParticleControl( particle, 6, point )
ParticleManager:ReleaseParticleIndex( particle )

if source == "modifier_legion_odds_7" then
	if buffed then 
		damage = damage * self.ability.talents.q7_damage_max

		EmitSoundOnLocationWithCaster(point, "Lc.Odds_Proc_Damage", self.caster)
		local particle = ParticleManager:CreateParticle( "particles/lc_odd_proc_burst.vpcf", PATTACH_WORLDORIGIN, nil )
	 	ParticleManager:SetParticleControl( particle, 0, point )
	 	ParticleManager:SetParticleControl( particle, 1, Vector(radius, radius, radius ))
	  ParticleManager:ReleaseParticleIndex( particle )
	else
		damage = damage * self.ability.talents.q7_damage
	end
end

local damageTable = {damage = damage , damage_type = DAMAGE_TYPE_MAGICAL, attacker = self.caster, ability = self}

for _,enemy in pairs(self.caster:FindTargets(radius, point)) do 
	enemy:EmitSound("Hero_LegionCommander.Overwhelming.Creep")

	if not source then
		local particle_peffect = ParticleManager:CreateParticle(particle_damage, PATTACH_ABSORIGIN_FOLLOW, enemy)
		ParticleManager:SetParticleControlEnt(particle_peffect, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(particle_peffect, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(particle_peffect, 3, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", self.caster:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(particle_peffect)

		if self.talents.has_h4 == 1 then 
			enemy:AddNewModifier(self.caster, self, "modifier_generic_silence", {duration = (1 - enemy:GetStatusResistance())*self.talents.h4_silence})	
		end
	end

	enemy:AddNewModifier(self.caster, self, "modifier_overwhelming_odds_custom_slow", {duration = slow_duration})

	if self.talents.has_q1 == 1 then
		enemy:AddNewModifier(self.caster, self, "modifier_overwhelming_odds_custom_heal_reduce", {duration = self.talents.q1_duration})
	end

	if IsValid(self.parent.press_ability) then
		self.parent.press_ability:ProcDamage(enemy)
	end
	
	damageTable.victim = enemy
	DoDamage(damageTable, source)
end

self.caster:AddNewModifier(self.caster, self, "modifier_overwhelming_odds_custom_speed", {duration = self.duration})
end


modifier_overwhelming_odds_custom_speed = class(mod_visible)
function modifier_overwhelming_odds_custom_speed:IsPurgable() return true end
function modifier_overwhelming_odds_custom_speed:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.speed = self.ability.attack_speed

if not IsServer() then return end

if self.ability.talents.has_q7 == 0 then
	self.use_cd = true
	self.ability:EndCd()
end

self.parent:GenericParticle(wearables_system:GetParticleReplacementAbility(self.parent, "particles/units/heroes/hero_legion_commander/legion_commander_odds_buff.vpcf", self), self)
end

function modifier_overwhelming_odds_custom_speed:OnDestroy()
if not IsServer() then return end
if not self.use_cd then return end
self.ability:StartCd()
end

function modifier_overwhelming_odds_custom_speed:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
}
end

function modifier_overwhelming_odds_custom_speed:GetModifierAttackSpeedBonus_Constant()
return self.speed
end


modifier_overwhelming_odds_custom_tracker = class(mod_hidden)
function modifier_overwhelming_odds_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.odds_ability = self.ability

self.ability.damage = self.ability:GetSpecialValueFor("damage")
self.ability.attack_speed = self.ability:GetSpecialValueFor("attack_speed")
self.ability.duration = self.ability:GetSpecialValueFor("duration")
self.ability.radius = self.ability:GetSpecialValueFor("radius")
self.ability.move_slow = self.ability:GetSpecialValueFor("move_slow")
self.ability.slow_duration = self.ability:GetSpecialValueFor("slow_duration")
self.ability.shard_cast = self.ability:GetSpecialValueFor("shard_cast")
self.ability.shard_range = self.ability:GetSpecialValueFor("shard_range")
self.ability.shard_speed = self.ability:GetSpecialValueFor("shard_speed")
end

function modifier_overwhelming_odds_custom_tracker:OnRefresh(table)
self.ability.damage = self.ability:GetSpecialValueFor("damage")
self.ability.attack_speed = self.ability:GetSpecialValueFor("attack_speed")
end

function modifier_overwhelming_odds_custom_tracker:UpdateUI()
if not IsServer() then return end
if self.ability.talents.has_q3 == 0 then return end
local stack = 0
local show = 0
local mod = self.ability.damage_mod
if IsValid(mod) then
  stack = mod.count
  show = 1
end

self.parent:UpdateUIlong({max = 1, stack = show, override_stack = stack, style = "LegionOddsDamage"})
end

function modifier_overwhelming_odds_custom_tracker:DamageEvent_out(params)
if not IsServer() then return end
if self.ability.talents.has_q3 == 0 then return end
if self.parent ~= params.attacker then return end
if not params.unit:IsRealHero() then return end
if not params.inflictor then return end
if params.custom_flag == "lc_odds_duel" then return end
if params.unit:HasModifier("modifier_legion_commander_duel_custom_buff") or params.unit:HasModifier("modifier_legion_commander_duel_custom_legendary_unit") then return end

params.unit:AddNewModifier(self.parent, self.ability, "modifier_overwhelming_odds_custom_damage", {duration = self.ability.talents.q3_duration, damage = params.original_damage})
end

function modifier_overwhelming_odds_custom_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end

function modifier_overwhelming_odds_custom_tracker:GetModifierSpellAmplify_Percentage()
return self.ability.talents.q3_spell
end


modifier_overwhelming_odds_custom_legendary = class(mod_hidden)
function modifier_overwhelming_odds_custom_legendary:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.ability:EndCd()

self.proc_count = 0
self.count = 0
self.interval = 0.05

self.current_target = nil

self.max = self.ability.talents.q7_max
self.proc_interval = self.ability.talents.q7_interval
self.max_duration = self.proc_interval*self.max
self.total_count = 0
self.search_radius = self.ability.talents.q7_radius
self.speed = self.ability.talents.q7_speed

self.effect = ParticleManager:CreateParticle( "particles/legion_commander/odds_legendary_aoe.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl( self.effect, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl( self.effect, 1, Vector(self.ability:GetRadius(), 1, 1 ))
ParticleManager:SetParticleControl( self.effect, 2, Vector(self.max_duration, 1, 1 ))
self:AddParticle( self.effect, false, false, -1, false, false)

self:OnIntervalThink(true)
self:StartIntervalThink(self.interval)
end

function modifier_overwhelming_odds_custom_legendary:OnIntervalThink(first)
if not IsServer() then return end
local point = self.parent:GetAbsOrigin()

if not first then
	self.count = self.count + self.interval
	self.total_count = self.total_count + self.interval

	if self.count >= self.proc_interval then
		self.count = 0
		self.proc_count = self.proc_count + 1

		if self.proc_count == (self.ability.talents.w4_odds_count - 1) and self.ability.talents.has_w4 == 1 and IsValid(self.caster.press_ability) and self.ability.talents.has_w7 == 0 then
			self.caster.press_ability:ProcRoot(nil, self.parent:GetAbsOrigin())
		end

		self.ability:ProcOdds(self.parent:GetAbsOrigin(), "modifier_legion_odds_7", self.proc_count >= self.max)
		if self.proc_count >= self.max then
			self:Destroy()
			return
		end
	end
end

if not IsValid(self.current_target) or not self.current_target:IsAlive() or not self.current_target:IsRealHero() then
	self.current_target = self.caster:RandomTarget(self.search_radius, point)
end

if self.current_target then
	local vec = (self.current_target:GetAbsOrigin() - point)
	if vec:Length2D() > 30 then
		self.parent:SetAbsOrigin(point + vec:Normalized()*self.speed*self.interval)
	end
end

self.caster:UpdateUIshort({time = self.max_duration - self.total_count, max_time = self.max_duration, stack = self.proc_count, style = "LegionOdds", priority = 0, active = self.proc_count >= (self.max - 1)})
end

function modifier_overwhelming_odds_custom_legendary:OnDestroy()
if not IsServer() then return end 
self.caster:UpdateUIshort({hide = 1, hide_full = 1, priority = 0,  style = "LegionOdds"})
self.ability:StartCd()
end 



modifier_overwhelming_odds_custom_slow = class(mod_hidden)
function modifier_overwhelming_odds_custom_slow:IsPurgable() return self.ability.talents.has_h4 == 0 end
function modifier_overwhelming_odds_custom_slow:GetEffectName() return "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf" end
function modifier_overwhelming_odds_custom_slow:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
end

function modifier_overwhelming_odds_custom_slow:DeclareFunctions()
return
{
 	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_overwhelming_odds_custom_slow:GetModifierMoveSpeedBonus_Percentage() 
return self.ability.move_slow
end


modifier_overwhelming_odds_custom_proc_charge = class(mod_hidden)
function modifier_overwhelming_odds_custom_proc_charge:GetEffectName() return "particles/lc_odd_charge.vpcf" end
function modifier_overwhelming_odds_custom_proc_charge:GetStatusEffectName() return "particles/status_fx/status_effect_forcestaff.vpcf" end
function modifier_overwhelming_odds_custom_proc_charge:StatusEffectPriority() return MODIFIER_PRIORITY_NORMAL  end
function modifier_overwhelming_odds_custom_proc_charge:OnCreated(kv)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.bkb = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_debuff_immune", {duration = self:GetRemainingTime() + 0.1})
self.parent:GenericParticle("particles/items_fx/force_staff.vpcf", self)
self.parent:StartGesture(ACT_DOTA_RUN)
self.parent:EmitSound("Lc.Odds_Charge")

local point = GetGroundPosition(Vector(kv.x, kv.y, 0), nil)

self.angle = (point - self.parent:GetAbsOrigin()):Normalized()
self.distance = (point - self.parent:GetAbsOrigin()):Length2D()/self:GetDuration()

if not self:ApplyHorizontalMotionController() then
  self:Destroy()
end

end

function modifier_overwhelming_odds_custom_proc_charge:DeclareFunctions()
return
{
 	MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
  MODIFIER_PROPERTY_DISABLE_TURNING
}
end

function modifier_overwhelming_odds_custom_proc_charge:GetActivityTranslationModifiers()
return "press_the_attack"
end

function modifier_overwhelming_odds_custom_proc_charge:GetModifierDisableTurning() 
return 1 
end

function modifier_overwhelming_odds_custom_proc_charge:UpdateHorizontalMotion( me, dt )
if not IsServer() then return end
local pos = self.parent:GetAbsOrigin()
GridNav:DestroyTreesAroundPoint(pos, 80, false)

local pos_p = self.angle * self.distance * dt

local next_pos = GetGroundPosition(pos + pos_p, self.parent)
self.parent:SetAbsOrigin(next_pos)
end

function modifier_overwhelming_odds_custom_proc_charge:OnDestroy()
if not IsServer() then return end

if IsValid(self.bkb) then
	self.bkb:Destroy()
end

self.parent:InterruptMotionControllers( true )
self.parent:FadeGesture(ACT_DOTA_RUN)

local dir = self.parent:GetForwardVector()
dir.z = 0
self.parent:SetForwardVector(dir)
self.parent:FaceTowards(self.parent:GetAbsOrigin() + dir*10)

ResolveNPCPositions(self.parent:GetAbsOrigin(), 128)
end

function modifier_overwhelming_odds_custom_proc_charge:OnHorizontalMotionInterrupted()
self:Destroy()
end

function modifier_overwhelming_odds_custom_proc_charge:CheckState()
return
{
	[MODIFIER_STATE_SILENCED] = true,
	[MODIFIER_STATE_DISARMED] = true
}
end


modifier_overwhelming_odds_custom_heal_reduce = class(mod_hidden)
function modifier_overwhelming_odds_custom_heal_reduce:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.heal_reduce = self.ability.talents.q1_heal_reduce
end

function modifier_overwhelming_odds_custom_heal_reduce:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE
}
end

function modifier_overwhelming_odds_custom_heal_reduce:GetModifierHealChange()
return self.heal_reduce
end

function modifier_overwhelming_odds_custom_heal_reduce:GetModifierHPRegenAmplify_Percentage()
return self.heal_reduce
end


modifier_overwhelming_odds_custom_damage = class(mod_hidden)
function modifier_overwhelming_odds_custom_damage:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.count = 0
self.RemoveForDuel = true

if self.parent:IsRealHero() and not IsValid(self.ability.damage_mod) then
	self.ability.damage_mod = self
end

self:AddStack(table.damage)
end

function modifier_overwhelming_odds_custom_damage:OnRefresh(table)
if not IsServer() then return end
self:AddStack(table.damage)
end

function modifier_overwhelming_odds_custom_damage:AddStack(damage)
if not IsServer() then return end
self.count = math.min(self.parent:GetMaxHealth()*self.ability.talents.q3_damage_max, math.floor(self.count + damage*self.ability.talents.q3_damage))

if self.ability.damage_mod == self then
  self.ability.tracker:UpdateUI()
end

end

function modifier_overwhelming_odds_custom_damage:CheckDuel()
if not IsServer() then return end
self.parent:EmitSound("LC.Duel_damage")
local real_damage = DoDamage({victim = self.parent, attacker = self.caster, ability = self.ability, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, damage_type = self.ability.talents.q3_damage_type, damage = self.count, custom_flag = "lc_odds_duel"}, "modifier_legion_odds_3")
self.parent:SendNumber(6, real_damage)

local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_omniknight/omniknight_hammer_of_purity_detonation.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
ParticleManager:SetParticleControlEnt( particle, 3, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
ParticleManager:ReleaseParticleIndex( particle )

local effect_target = ParticleManager:CreateParticle( "particles/lc_press_heal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( effect_target, 1, Vector( 200, 100, 100 ) )
ParticleManager:ReleaseParticleIndex( effect_target )

self:Destroy()
end

function modifier_overwhelming_odds_custom_damage:OnDestroy()
if not IsServer() then return end

if self.ability.damage_mod == self then
  self.ability.damage_mod = nil
  self.ability.tracker:UpdateUI()
end

end


modifier_overwhelming_odds_custom_shield = class(mod_hidden)
function modifier_overwhelming_odds_custom_shield:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.interval = 0.1
self.count = 0
self.max_shield = self.parent:GetMaxHealth()*self.ability.talents.q4_shield_max
self.shield_add = self.parent:GetMaxHealth()*self.ability.talents.q4_shield*self.interval

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_overwhelming_odds_custom_shield:OnIntervalThink()
if not IsServer() then return end

if not IsValid(self.ability.shield_mod) then
	self.ability.shield_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_shield", {
		duration = self.ability.talents.q4_duration,
		max_shield = self.max_shield,
		shield_talent = "modifier_legion_odds_4",
	})
	if self.ability.shield_mod then

		self.ability.shield_mod:SetCanDestoyFunc(function()
			return not self.parent:HasModifier("modifier_overwhelming_odds_custom_shield")
		end)

		self.particle = ParticleManager:CreateParticle("particles/bristleback/back_shield.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent )
		ParticleManager:SetParticleControlEnt( self.particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
		self.ability.shield_mod:AddParticle(self.particle,false, false, -1, false, false)
	end
end

if self.ability.shield_mod then
	self.ability.shield_mod:AddShield(self.shield_add)
	self.ability.shield_mod:SetDuration(self.ability.talents.q4_duration, true)
end

self.count = self.count + self.shield_add
if self.count >= self.max_shield then
	self:Destroy()
end

end