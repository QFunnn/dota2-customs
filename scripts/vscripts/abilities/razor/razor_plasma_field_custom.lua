--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_razor_plasma_field_custom", "abilities/razor/razor_plasma_field_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_plasma_field_custom_slow", "abilities/razor/razor_plasma_field_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_plasma_field_custom_slow_speed", "abilities/razor/razor_plasma_field_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_plasma_field_custom_damage_cd", "abilities/razor/razor_plasma_field_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_plasma_field_custom_stop", "abilities/razor/razor_plasma_field_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_plasma_field_custom_legendary", "abilities/razor/razor_plasma_field_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_plasma_field_custom_legendary_anim", "abilities/razor/razor_plasma_field_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_plasma_field_custom_knock", "abilities/razor/razor_plasma_field_custom", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_razor_plasma_field_custom_damage", "abilities/razor/razor_plasma_field_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_plasma_field_custom_speed", "abilities/razor/razor_plasma_field_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_plasma_field_custom_shield", "abilities/razor/razor_plasma_field_custom", LUA_MODIFIER_MOTION_NONE)



razor_plasma_field_custom = class({})


function razor_plasma_field_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/razor_custom/razor_whip.vpcf", context )
PrecacheResource( "particle","particles/razor_custom/razor_ambient.vpcf", context )
PrecacheResource( "particle","particles/razor_custom/razor_ambient_main.vpcf", context )

PrecacheResource( "particle","particles/units/heroes/hero_razor/razor_plasmafield.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_zuus/zuus_static_field.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_arc_warden/arc_warden_flux_cast.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_monkey_king_fur_army.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_zuus/zuus_lightning_bolt_glow_fx.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_techies/techies_stasis_trap_explode.vpcf", context )
PrecacheResource( "particle","particles/huskar_timer.vpcf", context )
PrecacheResource( "particle","particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_static_field.vpcf", context )
PrecacheResource( "particle","particles/items_fx/force_staff.vpcf", context )
PrecacheResource( "particle","particles/zuus_speed.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_mjollnir_shield.vpcf", context )
PrecacheResource( "particle","particles/zuus_shield_wrath.vpcf", context )
PrecacheResource( "particle","particles/econ/items/razor/razor_ti6/razor_plasmafield_ti6.vpcf", context )

PrecacheResource( "particle","particles/dev/empty_particle.vpcf", context )
dota1x6:PrecacheShopItems("npc_dota_hero_razor", context)
end



function razor_plasma_field_custom:GetAbilityTextureName()
local caster = self:GetCaster()
return wearables_system:GetAbilityIconReplacement(self.caster, "razor_plasma_field", self)
end


function razor_plasma_field_custom:GetCooldown(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_razor_plasma_3") then
	bonus = self:GetCaster():GetTalentValue("modifier_razor_plasma_3", "cd")
end
return self.BaseClass.GetCooldown( self, level ) + bonus
end

function razor_plasma_field_custom:GetManaCost(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_razor_plasma_3") then
	bonus = self:GetCaster():GetTalentValue("modifier_razor_plasma_3", "mana")
end
return self.BaseClass.GetManaCost(self, level) + bonus
end

function razor_plasma_field_custom:GetCastRange(vLocation, hTarget)
local radius = self:GetSpecialValueFor("radius")
if self:GetCaster():HasTalent("modifier_razor_plasma_1") then 
	radius = radius + self:GetCaster():GetTalentValue("modifier_razor_plasma_1", "radius")
end 
return radius - self:GetCaster():GetCastRangeBonus()
end 


function razor_plasma_field_custom:OnSpellStart()
local caster = self:GetCaster()

if caster:HasTalent("modifier_razor_plasma_4") then 
	if caster:HasAbility("razor_plasma_field_custom_stop") and caster:FindAbilityByName("razor_plasma_field_custom_stop"):IsHidden() then 
		caster:SwapAbilities(self:GetName(), "razor_plasma_field_custom_stop",  false, true)

		caster:FindAbilityByName("razor_plasma_field_custom_stop"):StartCooldown(0.3)
	end 
end 

if caster:HasTalent("modifier_razor_plasma_5") then 
	caster:AddNewModifier(caster, self, "modifier_razor_plasma_field_custom_speed", {duration = caster:GetTalentValue("modifier_razor_plasma_5", "duration")})
end 

--caster:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_1)
caster:AddNewModifier(caster, self, "modifier_razor_plasma_field_custom", {})
end 





modifier_razor_plasma_field_custom = class({})
function modifier_razor_plasma_field_custom:IsHidden() return true end
function modifier_razor_plasma_field_custom:IsPurgable() return false end
function modifier_razor_plasma_field_custom:RemoveOnDeath() return false end
function modifier_razor_plasma_field_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_razor_plasma_field_custom:OnCreated( kv )
if not IsServer() then return end

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.is_thinker = not self.parent:IsRealHero()

self.start_radius = 0
self.current_radius = 0
self.width = 80

self.prev_radius = self.start_radius

self.radius = self.ability:GetSpecialValueFor("radius")
self.speed = self.ability:GetSpecialValueFor("speed")

self.total_duration = self.radius/self.speed

if self.caster:HasTalent("modifier_razor_plasma_1") then 
	self.radius = self.radius + self.caster:GetTalentValue("modifier_razor_plasma_1", "radius")
	self.speed = self.radius/self.total_duration
end 

self.end_radius = self.radius + self.width
self.max_radius = self.end_radius

self.min_damage = self.ability:GetSpecialValueFor("damage_min")
self.max_damage = self.ability:GetSpecialValueFor("damage_max")
self.slow_duration = self.ability:GetSpecialValueFor("slow_duration") + self.caster:GetTalentValue("modifier_razor_plasma_2", "duration")
self.slow_max = self.ability:GetSpecialValueFor("slow_max")
self.slow_min = self.ability:GetSpecialValueFor("slow_min") + self.caster:GetTalentValue("modifier_razor_plasma_6", "slow")

self.more_damage = 1

if kv.more_damage then 
	self.more_damage = 1 + kv.more_damage
	self.more_damage = 1 +kv.more_damage
end 

local particle = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_razor/razor_plasmafield.vpcf", self)

local sound = wearables_system:GetSoundReplacement(self.caster, "Ability.PlasmaField", self)

if self.is_thinker == true then 
	self.speed = self.speed*1.5
	sound = "Razor.Legendary_start"
	particle = "particles/econ/items/razor/razor_ti6/razor_plasmafield_ti6.vpcf"
end 

self.effect_cast = ParticleManager:CreateParticle( particle, PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl(self.effect_cast , 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.speed, self.max_radius, 1 ) )
self:AddParticle( self.effect_cast, false, false, -1, false, false )

self.damage_duration = self.caster:GetTalentValue("modifier_razor_plasma_4", "duration")
self.damage_interval = self.caster:GetTalentValue("modifier_razor_plasma_4", "interval")

self.silence_duration = self.caster:GetTalentValue("modifier_razor_plasma_6", "silence")

self.parent:EmitSound( sound )

self.damageTable = {attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}

self.outward = true
self.targets = {}
self.silence_targets = {}

self.interval = 0.01
self.count = 0
self.prev_speed = 0

self:StartIntervalThink( self.interval )
self:OnIntervalThink()
end


function modifier_razor_plasma_field_custom:Stop()
if not IsServer() then return end

self.parent:StopSound(wearables_system:GetSoundReplacement(self:GetCaster(), "Ability.PlasmaField", self))

local prev = self.speed
self.speed = self.prev_speed
self.prev_speed = prev

local k = 1 

if self.speed < 0 then 
	k = -1
end 

if self.effect_cast then 	
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(math.abs(self.speed), self.max_radius, k ) )
end 

end 

function modifier_razor_plasma_field_custom:OnDestroy()
if not IsServer() then return end

AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), self.radius, 2, false)

self.parent:StopSound("Razor.Plasma_start")

if self.is_thinker == false and self.caster:HasAbility("razor_plasma_field_custom_stop") and not self.caster:FindAbilityByName("razor_plasma_field_custom_stop"):IsHidden() then 
	self.caster:SwapAbilities(self.ability:GetName(), "razor_plasma_field_custom_stop",  true, false)
end 

end


function modifier_razor_plasma_field_custom:ChangeDir()

if self.effect_cast then 	
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.speed, self.max_radius, -1 ) )
end 

self.outward = not self.outward

self.speed = self.speed*-1

if self.outward == true then 
	self.end_radius = self.radius + self.width
	self.start_radius = 0
else 
	self.end_radius = 0
	self.start_radius = self.radius + self.width
end 

self.current_radius = self.current_radius - self.speed*self.interval
self.targets = {}
end 


function modifier_razor_plasma_field_custom:OnIntervalThink()
if not IsServer() then return end

if not self.parent or self.parent:IsNull() then
	return
end
 
AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), self.radius, self.interval, false)

if self.effect_cast then 
	ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetAbsOrigin() )
end 

local ability = nil
if self.caster:HasModifier("modifier_razor_plasma_field_custom_stop") then 
	ability = "modifier_razor_plasma_4"
end 

if self.is_thinker == true then 
	ability = "modifier_razor_plasma_7"
end 

local damage_min = self.min_damage*self.more_damage
local damage_max = (self.max_damage + self.caster:GetAverageTrueAttackDamage(nil)*self.caster:GetTalentValue("modifier_razor_plasma_1", "damage")/100)*self.more_damage

self.current_radius =  math.max(0, self.current_radius + self.speed * self.interval)
local dealt_damage = false

for _,target in pairs(self.caster:FindTargets((self.current_radius + self.width), self.parent:GetOrigin())) do

	local distance = (target:GetOrigin()-self.parent:GetOrigin()):Length2D()
	local real_radius = self.current_radius

	if (not self.targets[target] or (self.speed == 0 and not target:HasModifier("modifier_razor_plasma_field_custom_damage_cd"))) 
		and distance>(real_radius -self.width*2) and (not target:HasModifier("modifier_razor_plasma_field_custom_knock") or self.is_thinker == false) then

	    dealt_damage = true
		self.targets[target] = true

		local k = distance/self.radius
		self.damageTable.victim = target
		self.damageTable.damage = math.max(damage_min, math.min(damage_max, damage_min + (damage_max - damage_min)*k))
		
		local slow = math.max(self.slow_min, math.min(self.slow_max, self.slow_min + (self.slow_max - self.slow_min)*k))

		target:AddNewModifier(self.caster, self.ability, "modifier_razor_plasma_field_custom_slow", {slow = slow, duration = self.slow_duration*(1 - target:GetStatusResistance())})

		if self.caster:HasTalent("modifier_razor_plasma_2") then 
			target:AddNewModifier(self.caster, self.ability, "modifier_razor_plasma_field_custom_slow_speed", {duration = self.slow_duration*(1 - target:GetStatusResistance())})
		end 

		target:AddNewModifier(self.caster, self.ability, "modifier_razor_plasma_field_custom_damage_cd", {duration = self.damage_interval})
	
		ParticleManager:ReleaseParticleIndex( ParticleManager:CreateParticle( "particles/units/heroes/hero_zuus/zuus_static_field.vpcf", PATTACH_ABSORIGIN_FOLLOW, target ) )
		DoDamage(self.damageTable, ability)

		if self.caster:GetQuest() == "Razor.Quest_5" and target:IsRealHero() and self.caster.quest.number and distance >= self.caster.quest.number then 
			self.caster:UpdateQuest(1)
		end 

		if self.caster:HasTalent("modifier_razor_plasma_6") and not self.silence_targets[target] then 
			target:EmitSound("SF.Raze_silence")
			self.silence_targets[target] = true

			if not target:IsDebuffImmune() then
				target:Purge(true, false, false, false, false)
			end

			local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
			ParticleManager:ReleaseParticleIndex(particle)

			target:AddNewModifier(self.caster, self.ability, "modifier_generic_silence", {duration = (1 - target:GetStatusResistance())*self.silence_duration})
		end 

		target:EmitSound( "Ability.PlasmaFieldImpact" )
	end
end

if self.caster:HasTalent("modifier_razor_plasma_4") and dealt_damage == true and not self.caster:HasModifier("modifier_razor_plasma_field_custom_damage_cd") then
	self.caster:AddNewModifier(self.caster, self.ability, "modifier_razor_plasma_field_custom_damage_cd", {duration = self.damage_interval}) 
	self.caster:AddNewModifier(self.caster, self.ability, "modifier_razor_plasma_field_custom_damage", {duration = self.damage_duration})
end 

if self.outward and self.current_radius>self.end_radius then
	self.caster:RemoveModifierByName("modifier_razor_plasma_field_custom_damage_cd")
	self:ChangeDir()
end

if not self.outward and self.current_radius<=self.end_radius then
	self:Destroy()
	return
end 

end 



modifier_razor_plasma_field_custom_slow = class({})
function modifier_razor_plasma_field_custom_slow:IsHidden() return false end
function modifier_razor_plasma_field_custom_slow:IsPurgable() return true end
function modifier_razor_plasma_field_custom_slow:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_razor_plasma_field_custom_slow:OnCreated(table)
if not IsServer() then return end 
self:SetStackCount(table.slow)
end 

function modifier_razor_plasma_field_custom_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_razor_plasma_field_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self:GetStackCount()*-1
end



modifier_razor_plasma_field_custom_slow_speed = class({})
function modifier_razor_plasma_field_custom_slow_speed:IsHidden() return true end
function modifier_razor_plasma_field_custom_slow_speed:IsPurgable() return true end
function modifier_razor_plasma_field_custom_slow_speed:OnCreated(table)
self.slow = self:GetCaster():GetTalentValue("modifier_razor_plasma_2", "speed")
end 

function modifier_razor_plasma_field_custom_slow_speed:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_razor_plasma_field_custom_slow_speed:GetModifierAttackSpeedBonus_Constant()
return self.slow
end


modifier_razor_plasma_field_custom_damage_cd = class({})
function modifier_razor_plasma_field_custom_damage_cd:IsHidden() return true end
function modifier_razor_plasma_field_custom_damage_cd:IsPurgable() return false end





razor_plasma_field_custom_stop = class({})


function razor_plasma_field_custom_stop:GetAbilityTextureName()
local caster = self:GetCaster()
return wearables_system:GetAbilityIconReplacement(self.caster, "razor_plasma_field", self)
end


function razor_plasma_field_custom_stop:OnSpellStart()

local caster = self:GetCaster()
if caster:HasModifier("modifier_razor_plasma_field_custom_stop") then 
	caster:RemoveModifierByName("modifier_razor_plasma_field_custom_stop")
	return
end

local duration = caster:GetTalentValue("modifier_razor_plasma_4", "stop")
caster:AddNewModifier(caster, self, "modifier_razor_plasma_field_custom_stop", {duration = duration})

self:EndCd(0)
self:StartCooldown(0.3)
end


modifier_razor_plasma_field_custom_stop = class({})
function modifier_razor_plasma_field_custom_stop:IsHidden() return false end
function modifier_razor_plasma_field_custom_stop:IsPurgable() return false end
function modifier_razor_plasma_field_custom_stop:OnCreated()
if not IsServer() then return end 

self.parent = self:GetParent()
self.ability = self.parent:FindAbilityByName("razor_plasma_field_custom")
if not self.ability then 
	self:Destroy()
	return
end 

self.cd = self.ability:GetCooldownTimeRemaining()

self.parent:EmitSound("Razor.Plasma_stop")
self.parent:EmitSound("Razor.Plasma_stop_loop")

local mod = self.parent:FindModifierByName("modifier_razor_plasma_field_custom")

if mod then 
	mod:Stop()
	return
end 

end 


function modifier_razor_plasma_field_custom_stop:OnDestroy()
if not IsServer() then return end 

if self.ability and self.ability:IsHidden() then 
	self.parent:SwapAbilities(self:GetAbility():GetName(), "razor_plasma_field_custom",  false, true)

	self.ability:EndCd(0)
	self.ability:StartCooldown(self.cd)
end 


self.parent:EmitSound("Razor.Plasma_start")
self.parent:StopSound("Razor.Plasma_stop_loop")
local mod = self.parent:FindModifierByName("modifier_razor_plasma_field_custom")

if mod then 
	mod:Stop()
	return
end 

end 





razor_plasma_field_custom_clone = class({})

function razor_plasma_field_custom_clone:CreateTalent()
self:SetHidden(false)
end


function razor_plasma_field_custom_clone:GetBehavior()
local bonus = 0
if self:GetCaster():HasModifier("modifier_razor_static_link_custom") or self:GetCaster():HasModifier("modifier_razor_static_link_custom_legendary") then
	bonus = DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end
return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_HIDDEN + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE + bonus
end

function razor_plasma_field_custom_clone:GetCooldown(level)
return self:GetCaster():GetTalentValue("modifier_razor_plasma_7", "cd")
end 


function razor_plasma_field_custom_clone:OnSpellStart()
local caster = self:GetCaster()
local point = self:GetCursorPosition()
local delay = caster:GetTalentValue("modifier_razor_plasma_7", "delay")

caster:EmitSound("Razor.Legendary_cast")

local illusion_self = CreateIllusions(caster, caster, {
	outgoing_damage = 0,
	incoming_damage = caster:GetTalentValue("modifier_razor_plasma_7", "incoming") - 100,
	duration    = delay + 1  
}, 1, 0, false, false)

for _,illusion in pairs(illusion_self) do

	illusion:SetHealth(illusion:GetMaxHealth())

	illusion.owner = caster

	illusion:AddNewModifier(caster, self, "modifier_razor_plasma_field_custom_legendary",  {duration = delay})
	illusion:AddNewModifier(caster, self, "modifier_chaos_knight_phantasm_illusion", {})
	illusion:SetOrigin(GetGroundPosition(point, nil))

	illusion:EmitSound("Razor.Legendary_cast_voice")

	point.z = point.z + 150

	cast_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_arc_warden/arc_warden_flux_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(cast_particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_attack1", caster:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(cast_particle, 1, point)
	ParticleManager:SetParticleControlEnt(cast_particle, 2, caster, PATTACH_POINT_FOLLOW, "attach_attack1", caster:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(cast_particle)
end

end






modifier_razor_plasma_field_custom_legendary = class({})
function modifier_razor_plasma_field_custom_legendary:IsHidden() return false end
function modifier_razor_plasma_field_custom_legendary:IsPurgable() return false end
function modifier_razor_plasma_field_custom_legendary:GetStatusEffectName() return "particles/status_fx/status_effect_monkey_king_fur_army.vpcf" end
function modifier_razor_plasma_field_custom_legendary:StatusEffectPriority() return MODIFIER_PRIORITY_ILLUSION end
function modifier_razor_plasma_field_custom_legendary:OnDestroy()
if not IsServer() then return end
self.parent:StopSound("Razor.Legendary_loop")

local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf", PATTACH_WORLDORIGIN, nil)
local particle2 = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_lightning_bolt_glow_fx.vpcf", PATTACH_WORLDORIGIN, nil)

local z_pos = 3000
local target_point = self.parent:GetAbsOrigin()

self.parent:EmitSound("Razor.Legendary_end1")
self.parent:EmitSound("Razor.Legendary_end2")

self.ability:StartCd()

ParticleManager:SetParticleControl(particle, 0, Vector(target_point.x, target_point.y, z_pos))
ParticleManager:SetParticleControl(particle, 1, Vector(target_point.x, target_point.y, target_point.z))
ParticleManager:ReleaseParticleIndex(particle)

ParticleManager:SetParticleControl(particle2, 0, Vector(target_point.x, target_point.y, z_pos))
ParticleManager:SetParticleControl(particle2, 1, Vector(target_point.x, target_point.y, target_point.z))
ParticleManager:ReleaseParticleIndex(particle2)

local particle_explode_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_stasis_trap_explode.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(particle_explode_fx, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_explode_fx, 1, Vector(self.radius, 1, 1))
ParticleManager:SetParticleControl(particle_explode_fx, 3, self.parent:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(particle_explode_fx)

local knock_duration = self.caster:GetTalentValue("modifier_razor_plasma_7", "knock_duration")

self.plasma_ability = self.caster:FindAbilityByName("razor_plasma_field_custom")

if self.plasma_ability and self.parent:GetHealth() > 1 then 

	local targets = self.caster:FindTargets(600, self.parent:GetAbsOrigin())

	local location = self.parent:GetAbsOrigin()
	for _,target in pairs(targets) do 
		if target:IsHero() then 

			local enemy_direction = (target:GetOrigin() - location):Normalized()
			local point = location + enemy_direction*self.knock_dist 
			local distance = math.max(self.knock_dist_min, (point - target:GetAbsOrigin()):Length2D())

			local knock = target:AddNewModifier(caster, self,
			"modifier_generic_knockback",
			{
				duration = knock_duration,
				distance = distance,
				height = 0,
				direction_x = enemy_direction.x,
				direction_y = enemy_direction.y,
			})
			target:AddNewModifier(caster, self, "modifier_razor_plasma_field_custom_knock", {duration = knock_duration})
			target:GenericParticle("particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_static_field.vpcf")
		end
	end 

	local damage = self.damage*math.min(1, (self.parent:GetHealth()/self.parent:GetMaxHealth()))
	CreateModifierThinker(self.caster, self.plasma_ability, "modifier_razor_plasma_field_custom", {more_damage = damage}, self.parent:GetAbsOrigin(), self.caster:GetTeamNumber(), false)
end 

self.parent:Kill(nil, nil) 
end



function modifier_razor_plasma_field_custom_legendary:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.ability:EndCd()

self.parent:StartGesture(ACT_DOTA_TELEPORT)

self.max_time = self:GetRemainingTime()
self.damage = self.caster:GetTalentValue("modifier_razor_plasma_7", "damage")/100

self.radius = self.caster:GetTalentValue("modifier_razor_plasma_7", "radius")

self.knock_dist = self.caster:GetTalentValue("modifier_razor_plasma_7", "knock_distance", true)
self.knock_dist_min = self.caster:GetTalentValue("modifier_razor_plasma_7", "knock_distance_min", true)

self.parent:EmitSound("Razor.Legendary_loop")
self.parent:EmitSound("Razor.Legendary_spawn1")
self.parent:EmitSound("Razor.Legendary_spawn2")

self.parent:AddNewModifier(self.caster, self.ability, "modifier_razor_plasma_field_custom_legendary_anim", {duration = self.caster:GetTalentValue("modifier_razor_plasma_7", "delay")})
self.count = 0
self:StartIntervalThink(0.2)
end


function modifier_razor_plasma_field_custom_legendary:OnIntervalThink()
if not IsServer() then return end 

local targets = self.caster:FindTargets(1000, self.parent:GetAbsOrigin())

for _,target in pairs(targets) do 
	if target:IsRealHero() then 
		AddFOWViewer(target:GetTeamNumber(), self.parent:GetAbsOrigin(), 100, 0.2, false)
	end 
end 

local caster = self.parent

local point = caster:GetAbsOrigin() + RandomVector(RandomInt(100, 300))

cast_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_arc_warden/arc_warden_flux_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
ParticleManager:SetParticleControlEnt(cast_particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
ParticleManager:SetParticleControl(cast_particle, 1, point)
ParticleManager:SetParticleControlEnt(cast_particle, 2, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(cast_particle)

self.count = self.count + 1

if self.count >= 3 then 
	self.count = 0 
	self.parent:EmitSound("Razor.Legendary_bolt")
end 

end 

function modifier_razor_plasma_field_custom_legendary:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end


function modifier_razor_plasma_field_custom_legendary:GetOverrideAnimation()
return ACT_DOTA_TELEPORT
end

function modifier_razor_plasma_field_custom_legendary:CheckState()
return
{
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	[MODIFIER_STATE_STUNNED] = true,
	[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	[MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
}
end




modifier_razor_plasma_field_custom_legendary_anim = class({})

function modifier_razor_plasma_field_custom_legendary_anim:IsHidden() return true end 
function modifier_razor_plasma_field_custom_legendary_anim:IsPurgable() return false end
function modifier_razor_plasma_field_custom_legendary_anim:OnCreated(table)
if not IsServer() then return end
self.t = -1
self.parent = self:GetParent()
self.timer = self:GetCaster():GetTalentValue("modifier_razor_plasma_7", "delay")*2
self:StartIntervalThink(0.5)
self:OnIntervalThink()
end


function modifier_razor_plasma_field_custom_legendary_anim:OnIntervalThink()
if not IsServer() then return end
self.t = self.t + 1

local number = (self.timer-self.t)/2 
local int = 0
int = number
if number % 1 ~= 0 then int = number - 0.5  end

local digits = math.floor(math.log10(number)) + 2

local decimal = number % 1

if decimal == 0.5 then
  decimal = 8
else 
  decimal = 1
end

local particleName = "particles/huskar_timer.vpcf"
local particle = ParticleManager:CreateParticle(particleName, PATTACH_OVERHEAD_FOLLOW, self.parent)
ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(particle, 1, Vector(0, int, decimal))
ParticleManager:SetParticleControl(particle, 2, Vector(digits, 0, 0))
ParticleManager:ReleaseParticleIndex(particle)
end





modifier_razor_plasma_field_custom_damage = class({})
function modifier_razor_plasma_field_custom_damage:IsHidden() return false end
function modifier_razor_plasma_field_custom_damage:IsPurgable() return false end
function modifier_razor_plasma_field_custom_damage:GetTexture() return "buffs/plasma_damage" end
function modifier_razor_plasma_field_custom_damage:OnCreated()
self.parent = self:GetParent()
self.damage = self.parent:GetTalentValue("modifier_razor_plasma_4", "damage")
self.duration = self:GetRemainingTime()

if not IsServer() then return end 
self:AddStack()
end 

function modifier_razor_plasma_field_custom_damage:OnRefresh(table)
if not IsServer() then return end 
self:AddStack()
end 

function modifier_razor_plasma_field_custom_damage:AddStack()
if not IsServer() then return end

Timers:CreateTimer(self.duration, function() 
	if self and not self:IsNull() then 
		self:DecrementStackCount()
		if self:GetStackCount() <= 0 then 
			self:Destroy()
		end 
	end 
end)

self:IncrementStackCount()
end 

function modifier_razor_plasma_field_custom_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
}
end

function modifier_razor_plasma_field_custom_damage:GetModifierPreAttack_BonusDamage()
return self.damage*self:GetStackCount()
end





modifier_razor_plasma_field_custom_speed = class({})
function modifier_razor_plasma_field_custom_speed:IsHidden() return true end
function modifier_razor_plasma_field_custom_speed:IsPurgable() return false end
function modifier_razor_plasma_field_custom_speed:GetEffectName()
	return "particles/items_fx/force_staff.vpcf"
end 

function modifier_razor_plasma_field_custom_speed:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_razor_plasma_field_custom_speed:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.speed = self.parent:GetTalentValue("modifier_razor_plasma_5", "speed")
self.shield_duration = self.parent:GetTalentValue("modifier_razor_plasma_5", "shield_duration")

if not IsServer() then return end 
self.parent:GenericParticle("particles/zuus_speed.vpcf", self)

self:OnIntervalThink()
self:StartIntervalThink(self.parent:GetTalentValue("modifier_razor_plasma_5", "interval") - 0.01)
end

function modifier_razor_plasma_field_custom_speed:OnIntervalThink()
if not IsServer() then return end 
if not self.parent:IsMoving() then return end 

self.parent:AddNewModifier(self.parent, self.ability, "modifier_razor_plasma_field_custom_shield", {duration = self.shield_duration})
end 

function modifier_razor_plasma_field_custom_speed:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_razor_plasma_field_custom_speed:GetModifierMoveSpeedBonus_Percentage()
return self.speed
end

function modifier_razor_plasma_field_custom_speed:CheckState()
return
{
	[MODIFIER_STATE_UNSLOWABLE] = true
}
end








modifier_razor_plasma_field_custom_shield = class({})
function modifier_razor_plasma_field_custom_shield:IsHidden() return false end
function modifier_razor_plasma_field_custom_shield:IsPurgable() return false end
function modifier_razor_plasma_field_custom_shield:GetTexture() return "buffs/laguna_shield" end
function modifier_razor_plasma_field_custom_shield:GetStatusEffectName() return "particles/status_fx/status_effect_mjollnir_shield.vpcf" end
function modifier_razor_plasma_field_custom_shield:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH  end
function modifier_razor_plasma_field_custom_shield:OnCreated(table)

self.parent = self:GetParent()

self.shield_talent = "modifier_razor_plasma_5"
self.max_shield = self.parent:GetTalentValue("modifier_razor_plasma_5", "shield")*self.parent:GetMaxHealth()/100
self.add_shiled = self.max_shield/(self.parent:GetTalentValue("modifier_razor_plasma_5", "duration")/self.parent:GetTalentValue("modifier_razor_plasma_5", "interval"))

if not IsServer() then return end
self:AddStack()

self.RemoveForDuel = true
local shield_size = self.parent:GetModelRadius() 

local particle = ParticleManager:CreateParticle("particles/zuus_shield_wrath.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
local common_vector = Vector(shield_size,0,shield_size)
ParticleManager:SetParticleControl(particle, 1, common_vector)
ParticleManager:SetParticleControl(particle, 2, common_vector)
ParticleManager:SetParticleControl(particle, 4, common_vector)
ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
self:AddParticle(particle, false, false, -1, false, false)

self.parent:EmitSound("DOTA_Item.Mjollnir.Loop")
end

function modifier_razor_plasma_field_custom_shield:OnRefresh()
if not IsServer() then return end 
self:AddStack()
end 

function modifier_razor_plasma_field_custom_shield:AddStack()
if not IsServer() then return end 
self:SetStackCount(math.min(self.max_shield, self:GetStackCount() + self.add_shiled))
end 

function modifier_razor_plasma_field_custom_shield:OnDestroy()
if not IsServer() then return end
self.parent:StopSound("DOTA_Item.Mjollnir.Loop")
self.parent:EmitSound("DOTA_Item.Mjollnir.DeActivate")
end

function modifier_razor_plasma_field_custom_shield:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end

function modifier_razor_plasma_field_custom_shield:GetModifierIncomingDamageConstant( params )

if IsClient() then 
	if params.report_max then 
		return self.max_shield
	else 
     	return self:GetStackCount()
    end 
end

if not IsServer() then return end

local damage = math.min(params.damage, self:GetStackCount())
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self:SetStackCount(self:GetStackCount() - damage)
if self:GetStackCount() <= 0 then
  self:Destroy()
end

return -damage
end




modifier_razor_plasma_field_custom_knock = class({})
function modifier_razor_plasma_field_custom_knock:IsHidden() return true end
function modifier_razor_plasma_field_custom_knock:IsPurgable() return false end