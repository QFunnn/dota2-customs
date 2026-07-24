--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_puck_dream_coil", "abilities/puck/custom_puck_dream_coil", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_dream_coil_thinker", "abilities/puck/custom_puck_dream_coil", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_dream_coil_resist", "abilities/puck/custom_puck_dream_coil", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_dream_coil_tether", "abilities/puck/custom_puck_dream_coil", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_dream_coil_tracker", "abilities/puck/custom_puck_dream_coil", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_dream_coil_cdr", "abilities/puck/custom_puck_dream_coil", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_dream_coil_scepter_caster", "abilities/puck/custom_puck_dream_coil", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_dream_coil_stun", "abilities/puck/custom_puck_dream_coil", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_dream_coil_mute", "abilities/puck/custom_puck_dream_coil", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_dream_coil_legendary_cd", "abilities/puck/custom_puck_dream_coil", LUA_MODIFIER_MOTION_NONE)

custom_puck_dream_coil = class({})


function custom_puck_dream_coil:CreateTalent()
self:ToggleAutoCast()
end


function custom_puck_dream_coil:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/puck_magic.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_puck/puck_dreamcoil_tether.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_puck/puck_dreamcoil.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_puck/puck_dreamcoil_mini_center.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_puck/puck_dreamcoil_mini.vpcf", context )
PrecacheResource( "particle","particles/lc_odd_proc_.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_puck/puck_base_attack.vpcf", context )
PrecacheResource( "particle","particles/puck/coil_refresh.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_demonartist/demonartist_engulf_disarm/items2_fx/heavens_halberd.vpcf", context )

end

function custom_puck_dream_coil:GetAbilityTargetFlags()
if self:GetCaster():HasTalent("modifier_puck_coil_5") then 
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
else 
	return DOTA_UNIT_TARGET_FLAG_NONE
end

end


function custom_puck_dream_coil:GetBehavior()
local bonus = 0
if self:GetCaster():HasTalent("modifier_puck_coil_7") then
	bonus = DOTA_ABILITY_BEHAVIOR_AUTOCAST
end
return DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_POINT + bonus
end

function custom_puck_dream_coil:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_custom_puck_dream_coil_tracker"
end 


function custom_puck_dream_coil:GetCooldown(iLevel)
local upgrade_cooldown = 0
if self:GetCaster():HasTalent("modifier_puck_coil_2") then 
 upgrade_cooldown = self:GetCaster():GetTalentValue("modifier_puck_coil_2", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown
end



function custom_puck_dream_coil:GetBreakDamage()
local damage = self:GetSpecialValueFor("coil_break_damage")
return damage
end 


function custom_puck_dream_coil:LegendaryProc(point)
local caster = self:GetCaster()
if not caster:HasTalent("modifier_puck_coil_7") then return end
if caster:HasModifier("modifier_custom_puck_dream_coil_legendary_cd") then return end
if not self:GetAutoCastState() then return end

local mana = caster:GetTalentValue("modifier_puck_coil_7", "mana")*caster:GetMaxMana()/100

if caster:GetMana() < mana then return end
caster:SetMana(math.max(1, caster:GetMana() - mana))

caster:AddNewModifier(caster, self, "modifier_custom_puck_dream_coil_legendary_cd", {duration = caster:GetTalentValue("modifier_puck_coil_7", "cd")})


local radius = caster:GetTalentValue("modifier_puck_coil_7", "radius")
local knock_range = caster:GetTalentValue("modifier_puck_coil_7", "knock_distance")
local knock_duration = caster:GetTalentValue("modifier_puck_coil_7", "knock_duration")

local enemies = FindUnitsInRadius(caster:GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)

EmitSoundOnLocationWithCaster(point,"Puck.Coil_Wave" , caster)

local particle = ParticleManager:CreateParticle("particles/puck_magic.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(particle, 0, point)
ParticleManager:SetParticleControl(particle, 1, point)
ParticleManager:SetParticleControl(particle, 2, Vector(radius, 0, 0))
ParticleManager:ReleaseParticleIndex(particle)

local damageTable = {damage = mana*caster:GetTalentValue("modifier_puck_coil_7", "damage")/100, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = caster, ability = self }

for _, enemy in pairs(caster:FindTargets(radius, point)) do
	damageTable.victim = enemy
  local real_damage = DoDamage(damageTable, "modifier_puck_coil_7")
  enemy:SendNumber(4, real_damage)

	local enemy_direction = (enemy:GetOrigin() - point):Normalized()
	local point = point + enemy_direction*(radius + 10) 
	local distance = math.min(knock_range, (point - enemy:GetAbsOrigin()):Length2D())

	local knock = enemy:AddNewModifier(caster, self,
	"modifier_generic_knockback",
	{
		duration = knock_duration,
		distance = distance,
		height = 0,
		direction_x = enemy_direction.x,
		direction_y = enemy_direction.y,
	})
end 


end 



function custom_puck_dream_coil:GetCoilDuration()
local latch_duration	= self:GetSpecialValueFor("coil_duration")
if self:GetCaster():HasTalent("modifier_puck_coil_2") then 
	latch_duration = latch_duration + self:GetCaster():GetTalentValue("modifier_puck_coil_2", "duration")
end
return latch_duration
end 


function custom_puck_dream_coil:GetAOERadius()
	return self:GetSpecialValueFor("coil_radius")
end

function custom_puck_dream_coil:OnSpellStart()
local caster = self:GetCaster()

if caster:GetName() == "npc_dota_hero_puck" then
	caster:EmitSound("puck_puck_ability_dreamcoil_0"..RandomInt(1, 2))
end

local damage = self:GetSpecialValueFor("coil_initial_damage")
local latch_duration = self:GetCoilDuration() 
local coil_stun_duration = self:GetSpecialValueFor("coil_stun_duration")
local radius = self:GetSpecialValueFor("coil_radius")
local point = self:GetCursorPosition()

local coil_thinker = CreateModifierThinker(caster, self, "modifier_custom_puck_dream_coil_thinker", {duration = latch_duration,}, point, caster:GetTeamNumber(), false )

if caster:HasScepter() then
	caster:AddNewModifier(caster, self, "modifier_custom_puck_dream_coil_scepter_caster", {duration = latch_duration, coil_thinker = coil_thinker:entindex()}) 
end 

local damageTable = {damage = damage, damage_type = self:GetAbilityDamageType(), attacker= caster, ability = self }
for _,enemy in pairs(caster:FindTargets(radius, point)) do

	damageTable.victim = enemy
	DoDamage(damageTable)

	if not enemy:HasModifier("modifier_custom_puck_dream_coil") then
		enemy:AddNewModifier(caster, self, "modifier_custom_puck_dream_coil",  {duration= latch_duration*(1 - enemy:GetStatusResistance()), coil_thinker = coil_thinker:entindex() })
	end
end


end


function custom_puck_dream_coil:OnProjectileHit(hTarget, vLocation)
if not hTarget then return end

hTarget:EmitSound("Puck.Coil_Attack_impact")
local caster = self:GetCaster()
if caster:HasTalent("modifier_puck_shift_4") then
	local mod = caster:FindModifierByName("modifier_custom_puck_phase_shift_tracker")
	if mod and mod.proc_chance then
		if RollPseudoRandomPercentage(mod.proc_chance, 5059, caster) then 
			mod:ProcDamage(hTarget)
		end
	end
end


self:GetCaster():PerformAttack(hTarget, true, true, true, false, false, false, false)
end





modifier_custom_puck_dream_coil = class({})

function modifier_custom_puck_dream_coil:IsPurgable()	return false end
function modifier_custom_puck_dream_coil:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_custom_puck_dream_coil:OnCreated(params)

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.coil_break_radius	= self.ability:GetSpecialValueFor("coil_break_radius") + self.caster:GetTalentValue("modifier_puck_coil_1", "radius")
self.coil_stun_duration	= self.ability:GetSpecialValueFor("coil_stun_duration") + self.caster:GetTalentValue("modifier_puck_coil_5", "stun")
self.coil_break_damage = self.ability:GetBreakDamage() 

self.reduction_duration = self.caster:GetTalentValue("modifier_puck_coil_3", "duration", true)

self.RemoveForDuel = true

if not IsServer() then return end

self.leash = self.parent:AddNewModifier(self.caster, self.caster:BkbAbility(self.ability, self.caster:HasTalent("modifier_puck_coil_5")), "modifier_custom_puck_dream_coil_tether", {duration = self:GetRemainingTime()})
	
if self.caster:HasTalent("modifier_puck_coil_5") then
	self.parent:AddNewModifier(self.caster, self.caster:BkbAbility(self.ability, self.caster:HasTalent("modifier_puck_coil_5")), "modifier_custom_puck_dream_coil_mute", {duration = self.caster:GetTalentValue("modifier_puck_coil_5", "duration")*(1 - self.parent:GetStatusResistance())})
end

self.ability_damage_type = self.ability:GetAbilityDamageType()
self.coil_thinker	= EntIndexToHScript(params.coil_thinker)
self.coil_thinker_location = self.coil_thinker:GetAbsOrigin()

local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_puck/puck_dreamcoil_tether.vpcf", PATTACH_ABSORIGIN, self.parent )
ParticleManager:SetParticleControl( effect_cast, 0, self.coil_thinker_location )
ParticleManager:SetParticleControlEnt(effect_cast,1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true)
self:AddParticle(effect_cast,false,false,-1,false,false)

self.interval 	= 0.05
self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end



function modifier_custom_puck_dream_coil:OnIntervalThink()
if not IsServer() then return end

if self.caster:HasTalent("modifier_puck_coil_3") or self.caster:HasTalent("modifier_puck_coil_1") then 
	self.parent:AddNewModifier(self.caster, self.caster:BkbAbility(self.ability, self.caster:HasTalent("modifier_puck_coil_5")), "modifier_custom_puck_dream_coil_resist", {duration = self.reduction_duration})
end 

if (self.parent:GetAbsOrigin() - self.coil_thinker_location):Length2D() < self.coil_break_radius then return end

local damageTable = {
	victim 			= self.parent,
	damage 			= self.coil_break_damage,
	damage_type		= self.ability_damage_type,
	damage_flags 	= DOTA_DAMAGE_FLAG_NONE,
	attacker 		= self.caster,
	ability 		= self.ability
}

if self.caster:GetQuest() == "Puck.Quest_8" and self.parent:IsRealHero() then 
	self.caster:UpdateQuest(1)
end

DoDamage(damageTable)
self.parent:EmitSound("Hero_Puck.Dream_Coil_Snap")
self.parent:ApplyStun(self.ability, self.caster:HasTalent("modifier_puck_coil_5"), self.caster, self.coil_stun_duration)

self.parent:AddNewModifier(self.caster, self.ability, "modifier_custom_puck_dream_coil_stun", {duration = (1 - self.parent:GetStatusResistance())*self.coil_stun_duration})

if self.parent:IsRealHero() then 
	self.caster:AddNewModifier(self.caster, self.ability, "modifier_custom_puck_dream_coil_cdr", {})
end 

if self.caster:HasScepter() then 
	local dir = (self.coil_thinker_location - self.parent:GetAbsOrigin()):Normalized()
	local distance = (self.coil_thinker_location - self.parent:GetAbsOrigin()):Length2D()

	distance = math.max(50, distance)
	self.coil_thinker_location = self.parent:GetAbsOrigin() + dir*distance

	local mod = self.parent:AddNewModifier( self.caster, self.caster:BkbAbility(self.ability, self.caster:HasTalent("modifier_puck_coil_5")),  "modifier_generic_arc",  
	{
	  target_x = self.coil_thinker_location.x,
	  target_y = self.coil_thinker_location.y,
	  distance = distance,
	  duration = 0.3,
	  height = 0,
	  fix_end = false,
	  isStun = true,
	  activity = ACT_DOTA_FLAIL,
	})
end

if self.leash and not self.leash:IsNull() then 
	self.leash:Destroy()
end 	


if self.coil_thinker and not self.coil_thinker:IsNull() then
	local thinker_mod = self.coil_thinker:FindModifierByName("modifier_custom_puck_dream_coil_thinker")
	if thinker_mod then
		thinker_mod:Break()
	end
end

self:Destroy()
end






modifier_custom_puck_dream_coil_thinker = class({})

function modifier_custom_puck_dream_coil_thinker:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.origin = self.parent:GetAbsOrigin()

self.ended = false

self.parent:EmitSound("Puck.Coil")

self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_puck/puck_dreamcoil.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.pfx, 0, self.parent:GetAbsOrigin())
self:AddParticle(self.pfx, false, false, -1, false, true)

self.radius = self.ability:GetSpecialValueFor("scepter_radius")
self.scepter_max_radius = self.ability:GetSpecialValueFor("scepter_radius_max")
self.speed = 1 + self.ability:GetSpecialValueFor("scepter_speed")/100

self.projectile =
{
  Source = self.parent,
  Ability = self.ability,
  EffectName = "particles/units/heroes/hero_puck/puck_base_attack.vpcf",
  iMoveSpeed = self.caster:GetProjectileSpeed(),
  vSourceLoc = self.parent:GetAbsOrigin(),
  bDodgeable = true,
  bProvidesVision = false,
}

if not self.caster:HasScepter() then return end

self:StartIntervalThink(self:GetInterval())
end 


function modifier_custom_puck_dream_coil_thinker:OnIntervalThink()
if not IsServer() then return end

local targets = self.caster:FindTargets(self.radius, self.origin)

if #targets > 0 and self.caster:IsAlive() and (self.caster:GetAbsOrigin() - self.origin):Length2D() <= self.scepter_max_radius then
	self.parent:EmitSound("Puck.Coil_Attack")

	for _,mod in pairs(self.caster:FindAllModifiers()) do
		if mod and mod.PuckAttackProc then
			mod:PuckAttackProc()
		end
	end

	for _,target in pairs(targets) do 
		self.projectile.Target = target
		ProjectileManager:CreateTrackingProjectile( self.projectile )	
	end 
end


self:StartIntervalThink(self:GetInterval())
end

function modifier_custom_puck_dream_coil_thinker:GetInterval()
return (1/self.caster:GetAttacksPerSecond(true))/self.speed
end


function modifier_custom_puck_dream_coil_thinker:Break()
if self.ended == true then return end

self.ended = true

if self.caster:HasTalent("modifier_puck_coil_7") then
	self.caster:CdAbility(self.ability, self.ability:GetCooldownTimeRemaining()*self.caster:GetTalentValue("modifier_puck_coil_7", "cd_inc")/100)

	local particle = ParticleManager:CreateParticle("particles/puck/coil_refresh.vpcf", PATTACH_CUSTOMORIGIN, self.caster)
	ParticleManager:SetParticleControlEnt( particle, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", self.caster:GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex(particle)

	self.caster:EmitSound("Sky.Seal_refresh")
end

end


function modifier_custom_puck_dream_coil_thinker:OnDestroy()
if not IsServer() then return end
self.parent:StopSound("Puck.Coil")
self.parent:RemoveSelf()
end








modifier_custom_puck_dream_coil_resist = class({})
function modifier_custom_puck_dream_coil_resist:IsHidden() return false end
function modifier_custom_puck_dream_coil_resist:IsPurgable() return false end
function modifier_custom_puck_dream_coil_resist:GetTexture() return "buffs/coil_resist" end

function modifier_custom_puck_dream_coil_resist:OnCreated(table)
self.caster = self:GetCaster()
self.parent = self:GetParent()

self.damage_reduce = self.caster:GetTalentValue("modifier_puck_coil_3", "damage_reduce")
self.damage_slow = self.caster:GetTalentValue("modifier_puck_coil_3", "slow")
self.burn_damage = self.caster:GetTalentValue("modifier_puck_coil_1", "damage")/100
self.burn_interval = self.caster:GetTalentValue("modifier_puck_coil_1", "interval", true)

if not IsServer() then return end
self.ability = self.caster:FindAbilityByName("custom_puck_dream_coil")
if not self.ability or self.ability:IsNull() then
	self:Destroy()
	return
end
self.RemoveForDuel = true

if self.caster:HasTalent("modifier_puck_coil_3") then
	self.parent:GenericParticle("particles/puck_orb_slow.vpcf", self)
end

if self.caster:HasTalent("modifier_puck_coil_1") then
	self:StartIntervalThink(self.burn_interval)
end

end

function modifier_custom_puck_dream_coil_resist:OnIntervalThink()
if not IsServer() then return end

local damage = self.burn_damage*self.caster:GetMaxMana()*self.burn_interval
DoDamage({victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL, damage = damage}, "modifier_puck_coil_1")
end


function modifier_custom_puck_dream_coil_resist:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end

function modifier_custom_puck_dream_coil_resist:GetModifierMoveSpeedBonus_Percentage() 
if not self:GetCaster():HasTalent("modifier_puck_coil_3") then return end
return self.damage_slow
end

function modifier_custom_puck_dream_coil_resist:GetModifierDamageOutgoing_Percentage()
if not self:GetCaster():HasTalent("modifier_puck_coil_3") then return end
return self.damage_reduce
end

function modifier_custom_puck_dream_coil_resist:GetModifierSpellAmplify_Percentage()
if not self:GetCaster():HasTalent("modifier_puck_coil_3") then return end
return self.damage_reduce
end





modifier_custom_puck_dream_coil_tether = class({})
function modifier_custom_puck_dream_coil_tether:IsHidden() return true end
function modifier_custom_puck_dream_coil_tether:IsPurgable() return false end
function modifier_custom_puck_dream_coil_tether:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_custom_puck_dream_coil_tether:CheckState()
return
{
	[MODIFIER_STATE_TETHERED] = true
}
end




modifier_custom_puck_dream_coil_tracker = class({})
function modifier_custom_puck_dream_coil_tracker:IsHidden() return true end
function modifier_custom_puck_dream_coil_tracker:IsPurgable() return false end


function modifier_custom_puck_dream_coil_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:AddSpellEvent(self)

self.point_spells =
{
	["custom_puck_dream_coil"] = true
}
self.delay_spells =
{
	["custom_puck_waning_rift"] = true,
	["custom_puck_ethereal_jaunt"] = true, 	
	["item_blink_custom"] = true,
	["item_swift_blink_custom"] = true,
	["item_arcane_blink_custom"] = true,
	["item_overwhelming_blink_custom"] = true,
	["custom_puck_phase_shift"] = true
}

end


function modifier_custom_puck_dream_coil_tracker:SpellEvent(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_puck_coil_7") then return end 
if self.parent ~= params.unit then return end 

local point = self.parent:GetAbsOrigin()

if self.point_spells[params.ability:GetName()] and self.parent:GetCursorPosition() then
	point = self.parent:GetCursorPosition()
end

if self.delay_spells[params.ability:GetName()] then
	Timers:CreateTimer(FrameTime(), function()
		self.ability:LegendaryProc(self.parent:GetAbsOrigin())
	end)
else
	self.ability:LegendaryProc(point)
end

end 




modifier_custom_puck_dream_coil_cdr = class({})
function modifier_custom_puck_dream_coil_cdr:IsHidden() return not self:GetCaster():HasTalent("modifier_puck_coil_6") end
function modifier_custom_puck_dream_coil_cdr:IsPurgable() return false end
function modifier_custom_puck_dream_coil_cdr:RemoveOnDeath() return false end
function modifier_custom_puck_dream_coil_cdr:GetTexture() return "buffs/Coil_kills" end
function modifier_custom_puck_dream_coil_cdr:OnCreated(table)
self.parent = self:GetParent()
self.max = self.parent:GetTalentValue("modifier_puck_coil_6", "max", true)
self.cdr = self.parent:GetTalentValue("modifier_puck_coil_6", "cdr", true)

if not IsServer() then return end
self:SetStackCount(1)
self:StartIntervalThink(0.5)
end

function modifier_custom_puck_dream_coil_cdr:OnIntervalThink()
if not IsServer() then return end 
if self:GetStackCount() < self.max then return end
if not self.parent:HasTalent("modifier_puck_coil_6") then return end

local particle_peffect = ParticleManager:CreateParticle("particles/lc_odd_proc_.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(particle_peffect, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_peffect, 2, self.parent:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(particle_peffect)

self.parent:EmitSound("BS.Thirst_legendary_active")
self:StartIntervalThink(-1)
end 

function modifier_custom_puck_dream_coil_cdr:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

end


function modifier_custom_puck_dream_coil_cdr:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
}
end


function modifier_custom_puck_dream_coil_cdr:GetModifierPercentageCooldown() 
if not self.parent:HasTalent("modifier_puck_coil_6") then return end
return self:GetStackCount()*self.cdr
end







modifier_custom_puck_dream_coil_scepter_caster = class({})
function modifier_custom_puck_dream_coil_scepter_caster:IsHidden() return false end
function modifier_custom_puck_dream_coil_scepter_caster:IsPurgable() return false end
function modifier_custom_puck_dream_coil_scepter_caster:RemoveOnDeath() return false end
function modifier_custom_puck_dream_coil_scepter_caster:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_custom_puck_dream_coil_scepter_caster:CheckState()
if not self.particle then return end
return
{
	[MODIFIER_STATE_DISARMED] = true
}
end

function modifier_custom_puck_dream_coil_scepter_caster:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.scepter_max_radius = self.ability:GetSpecialValueFor("scepter_radius_max")

if not IsServer() then return end
self.thinker = EntIndexToHScript(table.coil_thinker)
self.center = self.thinker:GetAbsOrigin()
self:OnIntervalThink()
self:StartIntervalThink(0.1)
end


function modifier_custom_puck_dream_coil_scepter_caster:OnIntervalThink()
if not IsServer() then return end

local dist = (self.parent:GetAbsOrigin() - self.center):Length2D()
local disarm = self.parent:IsAlive() and dist <= self.scepter_max_radius

if disarm and not self.particle then
	self.particle = self.parent:GenericParticle("particles/units/heroes/hero_demonartist/demonartist_engulf_disarm/items2_fx/heavens_halberd.vpcf", self, true)
end

if not disarm and self.particle then
	ParticleManager:DestroyParticle(self.particle, false)
	ParticleManager:ReleaseParticleIndex(self.particle)
	self.particle = nil
end

end




modifier_custom_puck_dream_coil_stun = class({})
function modifier_custom_puck_dream_coil_stun:IsHidden() return true end
function modifier_custom_puck_dream_coil_stun:IsPurgable() return false end
function modifier_custom_puck_dream_coil_stun:IsPurgeException() return true end
function modifier_custom_puck_dream_coil_stun:IsStunDebuff() return true end




modifier_custom_puck_dream_coil_mute = class({})
function modifier_custom_puck_dream_coil_mute:IsHidden() return true end
function modifier_custom_puck_dream_coil_mute:IsPurgable() return false end
function modifier_custom_puck_dream_coil_mute:GetEffectName() return "particles/generic_gameplay/generic_break.vpcf" end
function modifier_custom_puck_dream_coil_mute:ShouldUseOverheadOffset() return true end
function modifier_custom_puck_dream_coil_mute:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end
function modifier_custom_puck_dream_coil_mute:OnCreated()
self.parent = self:GetParent()
if not IsServer() then return end
self:OnIntervalThink()
self:StartIntervalThink(0.1)
end

function modifier_custom_puck_dream_coil_mute:OnIntervalThink()
if not IsServer() then return end
if self.parent:IsDebuffImmune() then return end

self.parent:Purge(true, false, false, false, false)
end


modifier_custom_puck_dream_coil_legendary_cd = class({})
function modifier_custom_puck_dream_coil_legendary_cd:IsHidden() return false end
function modifier_custom_puck_dream_coil_legendary_cd:IsPurgable() return false end
function modifier_custom_puck_dream_coil_legendary_cd:IsDebuff() return true end