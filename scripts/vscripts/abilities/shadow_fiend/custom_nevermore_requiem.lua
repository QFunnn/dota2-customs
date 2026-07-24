--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_reqiuem_debuff", "abilities/shadow_fiend/custom_nevermore_requiem", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_reqiuem_tracker", "abilities/shadow_fiend/custom_nevermore_requiem", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_reqiuem_cast", "abilities/shadow_fiend/custom_nevermore_requiem", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_reqiuem_cast_cd", "abilities/shadow_fiend/custom_nevermore_requiem", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_reqiuem_legendary", "abilities/shadow_fiend/custom_nevermore_requiem", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_reqiuem_legendary_quest", "abilities/shadow_fiend/custom_nevermore_requiem", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_reqiuem_legendary_stack", "abilities/shadow_fiend/custom_nevermore_requiem", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_reqiuem_legendary_pull", "abilities/shadow_fiend/custom_nevermore_requiem", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_reqiuem_damage_reduce", "abilities/shadow_fiend/custom_nevermore_requiem", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_reqiuem_speed_damage", "abilities/shadow_fiend/custom_nevermore_requiem", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_reqiuem_spell_absorb", "abilities/shadow_fiend/custom_nevermore_requiem", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_reqiuem_scepter_heal", "abilities/shadow_fiend/custom_nevermore_requiem", LUA_MODIFIER_MOTION_NONE)




custom_nevermore_requiem = class({})



function custom_nevermore_requiem:CreateTalent()
self:LegendaryUI()
end

function custom_nevermore_requiem:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/units/heroes/hero_nevermore/nevermore_wings.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_a.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_nevermore/nevermore_requiemofsouls.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_line.vpcf", context )
PrecacheResource( "particle","particles/sf_ulti_gaze_.vpcf", context )
PrecacheResource( "particle","particles/shadow_fiend/requiem_pull.vpcf", context )
PrecacheResource( "particle","particles/shadow_fiend/requiem_stacks.vpcf", context )
PrecacheResource( "particle","particles/shadow_fiend/requiem_refresh.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_battle_hunger.vpcf", context )
PrecacheResource( "particle","particles/shadow_fiend/requiem_radius.vpcf", context )
PrecacheResource( "particle","particles/shadow_fiend/requiem_speed.vpcf", context )
PrecacheResource( "particle","particles/shadow_fiend/requiem_block.vpcf", context )
end




function custom_nevermore_requiem:GetIntrinsicModifierName() 
if not self:GetCaster():IsRealHero() then return end
return "modifier_custom_reqiuem_tracker" 
end

function custom_nevermore_requiem:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "nevermore_requiem", self)
end

function custom_nevermore_requiem:GetCastAnimation()
return 0
end

function custom_nevermore_requiem:GetCastRange()
if self:GetCaster():HasTalent("modifier_nevermore_requiem_5") then 
	if IsServer() then
		return 99999
	else
		return self:GetCaster():GetTalentValue("modifier_nevermore_requiem_5", "range")
	end
end
return 0
end


function custom_nevermore_requiem:GetBehavior()
if self:GetCaster():HasTalent("modifier_nevermore_requiem_5") then 
	return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end

function custom_nevermore_requiem:GetManaCost(level)
if self:GetCaster():HasTalent("modifier_nevermore_requiem_6") then
	return 0
end
return self.BaseClass.GetManaCost(self,level)
end

function custom_nevermore_requiem:LegendaryStack(count)
local caster = self:GetCaster()

if not caster:HasTalent("modifier_nevermore_requiem_7") and not caster:HasTalent("modifier_nevermore_requiem_4") then return end
if self:GetCooldownTimeRemaining() > 0 then return end
local mod = caster:FindModifierByName("modifier_custom_reqiuem_tracker")

for i = 1,count do
	caster:AddNewModifier(caster, self, "modifier_custom_reqiuem_legendary_stack", {duration = caster:GetTalentValue("modifier_nevermore_requiem_7", "duration", true)})
end

end


function custom_nevermore_requiem:LegendaryUI()
if not IsServer() then return end
local mod = self:GetCaster():FindModifierByName("modifier_custom_reqiuem_tracker")
if mod then
	mod:UpdateUI()
end
end


function custom_nevermore_requiem:GetCastPoint()
local bonus = 0
local caster = self:GetCaster()
if caster:HasModifier("modifier_custom_reqiuem_legendary_stack") and caster:HasTalent("modifier_nevermore_requiem_7") then
	bonus = caster:GetUpgradeStack("modifier_custom_reqiuem_legendary_stack")*caster:GetTalentValue("modifier_nevermore_requiem_7", "cast")
end
return self:GetSpecialValueFor("AbilityCastPoint") + bonus
end


function custom_nevermore_requiem:GetCooldown(iLevel)
local upgrade_cooldown = 0 
if self:GetCaster():HasTalent("modifier_nevermore_requiem_2") then 
  upgrade_cooldown = self:GetCaster():GetTalentValue("modifier_nevermore_requiem_2", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown
end



function custom_nevermore_requiem:OnAbilityPhaseStart()
local caster = self:GetCaster()

self.sound = wearables_system:GetSoundReplacement(caster, "Hero_Nevermore.RequiemOfSoulsCast", self)
local cast_time = self:GetCastPoint() * self:GetCastPointModifier()
if not caster:HasModifier("modifier_custom_reqiuem_cast_cd") and caster:HasTalent("modifier_nevermore_requiem_5") then
	self.block_mod = caster:AddNewModifier(caster, self, "modifier_custom_reqiuem_spell_absorb", {duration = cast_time + 0.1})

	if not caster:IsRooted() and not caster:IsLeashed() then
		local point = self:GetCursorPosition()
		local vec = point - caster:GetAbsOrigin()
		local range = caster:GetTalentValue("modifier_nevermore_requiem_5", "range") + caster:GetCastRangeBonus()
		if vec:Length2D() > range then
			point = caster:GetAbsOrigin() + vec:Normalized()*range
		end

		caster:Teleport(point, true, "particles/items3_fx/blink_overwhelming_start.vpcf", "particles/items3_fx/blink_overwhelming_end.vpcf", "Sf.Requiem_blink")
		FindClearSpaceForUnit(caster, point, true)
	end
end

EmitSoundOnLocationForAllies(caster:GetAbsOrigin(), self.sound, caster)

local particle_wing_name = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_nevermore/nevermore_wings.vpcf", self)
self.wings_particle = ParticleManager:CreateParticle(particle_wing_name, PATTACH_ABSORIGIN_FOLLOW, caster)

local anim_k = math.min(1.9, self:GetSpecialValueFor("AbilityCastPoint")/cast_time)

caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_6, anim_k)
caster:AddNewModifier(caster, self, "modifier_custom_reqiuem_cast", {duration = cast_time + FrameTime()})
return true
end


function custom_nevermore_requiem:OnAbilityPhaseInterrupted()
local caster = self:GetCaster()

caster:FadeGesture(ACT_DOTA_CAST_ABILITY_6)
caster:RemoveModifierByName("modifier_custom_reqiuem_cast")
caster:StopSound(self.sound)

caster:AddNewModifier(caster, self, "modifier_custom_reqiuem_cast_cd", {duration = 10})

if self.wings_particle then
	ParticleManager:DestroyParticle(self.wings_particle, true)
	ParticleManager:ReleaseParticleIndex(self.wings_particle)
end

if self.block_mod and not self.block_mod:IsNull() then
	self.block_mod:Destroy()
end

end


function custom_nevermore_requiem:OnSpellStart(death_cast)	

local caster = self:GetCaster()
local ability = self

self.break_duration = caster:GetTalentValue("modifier_nevermore_requiem_6", "break_duration", true)
self.damage_duration = caster:GetTalentValue("modifier_nevermore_requiem_3", "duration", true)

local mod = caster:FindModifierByName("modifier_custom_reqiuem_legendary_stack")
if mod then
	if mod:GetStackCount() >= caster:GetTalentValue("modifier_nevermore_requiem_7", "max") and caster:HasTalent("modifier_nevermore_requiem_7") then
		caster:CdAbility(self, self:GetCooldownTimeRemaining()*caster:GetTalentValue("modifier_nevermore_requiem_7", "cd")/100)

		local particle = ParticleManager:CreateParticle("particles/shadow_fiend/requiem_refresh.vpcf", PATTACH_CUSTOMORIGIN, caster)
		ParticleManager:SetParticleControlEnt( particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetOrigin(), true )
		ParticleManager:ReleaseParticleIndex(particle)

		caster:EmitSound("Hero_Rattletrap.Overclock.Cast")	
	end

	if caster:HasTalent("modifier_nevermore_requiem_4") then
		caster:AddNewModifier(caster, self, "modifier_custom_reqiuem_speed_damage", {duration = caster:GetTalentValue("modifier_nevermore_requiem_4", "duration"), stacks = mod:GetStackCount()})
	end

	mod:Destroy()
end

if self.block_mod and not self.block_mod:IsNull() then
	self.block_mod:SetDuration(caster:GetTalentValue("modifier_nevermore_requiem_5", "duration"), true)
end

if self.wings_particle then
	ParticleManager:DestroyParticle(self.wings_particle, false)
	ParticleManager:ReleaseParticleIndex(self.wings_particle)
end

if caster:HasScepter() then
	caster:AddNewModifier(caster, self, "modifier_custom_reqiuem_scepter_heal", {duration = self:GetSpecialValueFor("scepter_duration")})
end

caster:RemoveModifierByName("modifier_custom_reqiuem_cast_cd")
caster:RemoveModifierByName("modifier_custom_reqiuem_cast")
self:LegendaryUI()

local particle_caster_souls = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_a.vpcf", self)
local particle_caster_ground = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_nevermore/nevermore_requiemofsouls.vpcf", self)

local sound_cast = wearables_system:GetSoundReplacement(caster, "Hero_Nevermore.RequiemOfSouls", self)

caster:EmitSound(sound_cast)

local travel_distance = ability:GetSpecialValueFor("requiem_radius")
local modifier_souls_handler = caster:FindModifierByName("modifier_custom_necromastery_souls")
local stacks = 0

if modifier_souls_handler then
	stacks = modifier_souls_handler:GetStackCount()
end

local particle_caster_souls_fx = ParticleManager:CreateParticle(particle_caster_souls, PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(particle_caster_souls_fx, 0, caster:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_caster_souls_fx, 1, Vector(stacks, 0, 0))
ParticleManager:SetParticleControl(particle_caster_souls_fx, 2, caster:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(particle_caster_souls_fx)

local particle_caster_ground_fx = ParticleManager:CreateParticle(particle_caster_ground, PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(particle_caster_ground_fx, 0, caster:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_caster_ground_fx, 1, Vector(stacks, 0, 0))
ParticleManager:ReleaseParticleIndex(particle_caster_ground_fx)


if not modifier_souls_handler then return end

local line_position = caster:GetAbsOrigin() + caster:GetForwardVector() * travel_distance

if stacks >= 1 then
	local start_pos = caster:GetAbsOrigin() + (line_position - caster:GetAbsOrigin()):Normalized()*(105) 
	self:CreateRequiemSoulLine(line_position, start_pos, death_cast)
end

local qangle_rotation_rate = 360 / stacks
for i = 1, stacks - 1 do
	local qangle = QAngle(0, qangle_rotation_rate, 0)
	line_position = RotatePosition(caster:GetAbsOrigin() , qangle, line_position)

	local start_pos = caster:GetAbsOrigin() + (line_position - caster:GetAbsOrigin()):Normalized()*(105) 
	self:CreateRequiemSoulLine(line_position, start_pos, death_cast)
end

end




function custom_nevermore_requiem:OnProjectileHit_ExtraData(target, location, extra_data)
local caster = self:GetCaster()
local scepter_line = extra_data.is_scepter and extra_data.is_scepter == 1
local death_cast = extra_data.death_cast and extra_data.death_cast == 1

if not target then 
	if caster:HasScepter() and not scepter_line and not death_cast then
		local pos = GetGroundPosition(Vector(extra_data.x, extra_data.y, 0), nil)
		self:CreateRequiemSoulLine(pos, location, false, true)
	end
	return  
end

local damage = self:GetSpecialValueFor("damage") + caster:GetTalentValue("modifier_nevermore_requiem_1", "damage")
local slow_duration = self:GetSpecialValueFor("requiem_slow_duration")
local max_duration = self:GetSpecialValueFor("requiem_slow_duration_max")
local fear_k = max_duration/slow_duration
local target_status = (1 - target:GetStatusResistance())

if caster:HasTalent("modifier_nevermore_requiem_2") then
	local fear_inc = caster:GetTalentValue("modifier_nevermore_requiem_2", "duration")
	slow_duration = slow_duration + fear_inc/fear_k
	max_duration = max_duration + fear_inc
end

local scepter_line_damage_pct = self:GetSpecialValueFor("requiem_damage_pct_scepter")/100
local scepter_line_heal_pct = self:GetSpecialValueFor("requiem_heal_pct_scepter")/100
local damage_ability = nil

if scepter_line then
	damage_ability = "scepter"
	damage = damage * scepter_line_damage_pct
end

if caster:HasTalent("modifier_nevermore_requiem_3") and self.damage_duration then
	target:AddNewModifier(caster, self, "modifier_custom_reqiuem_damage_reduce", {duration = self.damage_duration})
end

if caster:HasTalent("modifier_nevermore_requiem_6") and self.break_duration then
	target_status = 1
	target:AddNewModifier(caster, self, "modifier_generic_break", {duration = self.break_duration})
end

target:RemoveModifierByName("modifier_custom_reqiuem_debuff")
target:EmitSound("Hero_Nevermore.RequiemOfSouls.Damage")

local damage_dealt = DoDamage({victim = target, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, attacker = caster, ability = self }, damage_ability)


if caster:GetQuest() == "Never.Quest_8" and target:IsRealHero() then 
	target:AddNewModifier(caster, self, "modifier_custom_reqiuem_legendary_quest", {duration = 0.5})
end
	
local fear_mod = target:FindModifierByName("modifier_nevermore_requiem_fear")

if not death_cast and not target:IsDebuffImmune() then
	if not fear_mod then
		fear_mod = target:AddNewModifier(caster, self, "modifier_nevermore_requiem_fear", {duration  = slow_duration * target_status})
	else 
		fear_mod:SetDuration(math.min(fear_mod:GetRemainingTime() + slow_duration, max_duration)*target_status, true)
	end
end


target:AddNewModifier(caster, self, "modifier_custom_reqiuem_debuff", {duration = max_duration})
end




function custom_nevermore_requiem:CreateRequiemSoulLine(line_end_pos, line_start_pos, death_cast, is_scepter)
local caster = self:GetCaster()

local particle_lines = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_line.vpcf", self)

local travel_distance = self:GetSpecialValueFor("requiem_radius")
local lines_starting_width = self:GetSpecialValueFor("requiem_line_width_start")
local lines_end_width = self:GetSpecialValueFor("requiem_line_width_end")
local lines_travel_speed = self:GetSpecialValueFor("requiem_line_speed")

local max_distance_time = travel_distance / lines_travel_speed
local velocity = (line_end_pos - line_start_pos):Normalized() * lines_travel_speed 

projectile_info = 
{
   Ability = self,				     			
   vSpawnOrigin = line_start_pos,
   fDistance = travel_distance,
   fStartRadius = lines_starting_width,
   fEndRadius = lines_end_width,
   Source = caster,
   bHasFrontalCone = false,
   bReplaceExisting = false,
   iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
   iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
   iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
   bDeleteOnHit = false,
   vVelocity = velocity,
   bProvidesVision = false,
   ExtraData = {x = line_start_pos.x, y = line_start_pos.y, is_scepter = is_scepter, death_cast = death_cast}
}

ProjectileManager:CreateLinearProjectile(projectile_info)

local particle_lines_fx = ParticleManager:CreateParticle(particle_lines, PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(particle_lines_fx, 0, line_start_pos)
ParticleManager:SetParticleControl(particle_lines_fx, 1, velocity)
ParticleManager:SetParticleControl(particle_lines_fx, 2, Vector(0, max_distance_time, 0))
--ParticleManager:DestroyParticle(particle_lines_fx, false)
ParticleManager:ReleaseParticleIndex(particle_lines_fx)
end




modifier_custom_reqiuem_debuff = class({})

function modifier_custom_reqiuem_debuff:IsHidden() return true end
function modifier_custom_reqiuem_debuff:IsPurgable() return true end
function modifier_custom_reqiuem_debuff:OnCreated()

self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.ms_slow_pct = self.ability:GetSpecialValueFor("requiem_reduction_ms") 
self.magic = self.ability:GetSpecialValueFor("magic_res")
end

function modifier_custom_reqiuem_debuff:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_custom_reqiuem_debuff:GetModifierMoveSpeedBonus_Percentage()
return self.ms_slow_pct
end

function modifier_custom_reqiuem_debuff:GetModifierMagicalResistanceBonus()
return self.magic
end





modifier_custom_reqiuem_tracker = class({})
function modifier_custom_reqiuem_tracker:IsHidden() return true end
function modifier_custom_reqiuem_tracker:IsPurgable() return false end
function modifier_custom_reqiuem_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.legendary_max = self.parent:GetTalentValue("modifier_nevermore_requiem_7", "max", true)
self.visual_max = 4

self.parent:AddAttackStartEvent_out(self)
end 


function modifier_custom_reqiuem_tracker:AttackStartEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
if not params.target:IsRealHero() then return end

self.ability:LegendaryStack(1)
end

function modifier_custom_reqiuem_tracker:UpdateUI()
if not IsServer() then return end
if not self.parent:HasTalent("modifier_nevermore_requiem_7") and not self.parent:HasTalent("modifier_nevermore_requiem_4") then return end
local stack = 0
local override = nil
local zero = nil
local interval = -1
local mod = self.parent:FindModifierByName("modifier_custom_reqiuem_legendary_stack")

if mod then
	stack = mod:GetStackCount()
	if self.particle then
		ParticleManager:DestroyParticle(self.particle, true)
		ParticleManager:ReleaseParticleIndex(self.particle)
		self.particle = nil
	end
else
	if not self.particle then
		self.particle = self.parent:GenericParticle("particles/shadow_fiend/requiem_stacks.vpcf", self, true)
		for i = 1,self.visual_max do 
			ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0))	
		end
	end
end

if self.ability:GetCooldownTimeRemaining() > 0 then
	override = self.ability:GetCooldownTimeRemaining()
	interval = 1
end

self.parent:UpdateUIlong({stack = stack, max = self.legendary_max, override_stack = override, use_zero = zero, style = "FiendRequiem"})
self:StartIntervalThink(interval)
end

function modifier_custom_reqiuem_tracker:OnIntervalThink()
if not IsServer() then return end
self:UpdateUI()
end


modifier_custom_reqiuem_legendary_stack = class({})
function modifier_custom_reqiuem_legendary_stack:IsHidden() return false end
function modifier_custom_reqiuem_legendary_stack:IsPurgable() return false end
function modifier_custom_reqiuem_legendary_stack:IsDebuff() return true end
function modifier_custom_reqiuem_legendary_stack:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.max = self.parent:GetTalentValue("modifier_nevermore_requiem_7", "max", true)
self.radius = self.parent:GetTalentValue("modifier_nevermore_requiem_7", "radius", true)
self.duration = self.parent:GetTalentValue("modifier_nevermore_requiem_7", "duration", true)
self.pull_radius = self.parent:GetTalentValue("modifier_nevermore_requiem_7", "pull_radius", true)


if not IsServer() then return end
self.visual_max = 4
self.particle = self.parent:GenericParticle("particles/shadow_fiend/requiem_stacks.vpcf", self, true)

self:SetStackCount(1)
self:StartIntervalThink(0.2)
end

function modifier_custom_reqiuem_legendary_stack:OnIntervalThink()
if not IsServer() then return end
local targets = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false )

if #targets > 0 then
	self:SetDuration(self.duration, true)
end

end

function modifier_custom_reqiuem_legendary_stack:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max then

	self.parent:EmitSound("Sf.Requiem_max_stack")
	self.parent:EmitSound("Sf.Requiem_max_stack2")

	local particle_peffect = ParticleManager:CreateParticle("particles/brist_lowhp_.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControl(particle_peffect, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_peffect, 2, self.parent:GetAbsOrigin())
	ParticleManager:DestroyParticle(particle_peffect, false)
	ParticleManager:ReleaseParticleIndex(particle_peffect)

	if self.parent:HasTalent("modifier_nevermore_requiem_7") then
		self.radius_visual = ParticleManager:CreateParticleForPlayer("particles/shadow_fiend/requiem_radius.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, self.parent:GetPlayerOwner())
		ParticleManager:SetParticleControl(self.radius_visual, 0, self.parent:GetAbsOrigin())
		ParticleManager:SetParticleControl(self.radius_visual, 1, Vector(self.pull_radius, 0, 0))
		self:AddParticle(self.radius_visual, false, false, -1, false, false)
	end
end

end

function modifier_custom_reqiuem_legendary_stack:OnStackCountChanged()
if not IsServer() then return end

self.ability:LegendaryUI()
if not self.particle then return end

for i = 1,self.visual_max do 
	if i <= math.floor(self:GetStackCount()/(self.max/self.visual_max)) then 
		ParticleManager:SetParticleControl(self.particle, i, Vector(1, 0, 0))	
	else 
		ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0))	
	end
end

end

function modifier_custom_reqiuem_legendary_stack:OnDestroy()
if not IsServer() then return end
self.ability:LegendaryUI()
end



modifier_custom_reqiuem_cast = class({})
function modifier_custom_reqiuem_cast:IsHidden() return true end
function modifier_custom_reqiuem_cast:IsPurgable() return false end
function modifier_custom_reqiuem_cast:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.radius = self.parent:GetTalentValue("modifier_nevermore_requiem_7", "pull_radius")
self.max = self.parent:GetTalentValue("modifier_nevermore_requiem_7", "max")
self.pull_duration = self:GetRemainingTime()
self.min_dist = 100

if not IsServer() then return end

local mod = self.parent:FindModifierByName("modifier_custom_reqiuem_legendary_stack")
if mod and self.parent:HasTalent("modifier_nevermore_requiem_7") and mod:GetStackCount() >= self.max and not self.parent:HasModifier("modifier_custom_reqiuem_cast_cd") then

	local origin = self.parent:GetAbsOrigin()

	self.parent:EmitSound("Sf.Requiem_Bkb")
	self.particle = ParticleManager:CreateParticle("particles/sf_ulti_gaze_.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(self.particle, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, origin, true)
	ParticleManager:SetParticleControlEnt(self.particle, 2, self.parent, PATTACH_POINT_FOLLOW, "attach_portrait", origin, true)
	ParticleManager:SetParticleControlEnt(self.particle, 3, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, origin, true)
	ParticleManager:SetParticleControlEnt(self.particle, 10, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, origin, true)
	self:AddParticle(self.particle, false, false, -1, false, false)

	for _,target in pairs(self.parent:FindTargets(self.radius)) do
		local dir = (origin - target:GetAbsOrigin()):Normalized()

		local point = origin - dir:Normalized()*self.min_dist
		local distance = (point - target:GetAbsOrigin()):Length2D()
		if (target:GetAbsOrigin() - origin):Length2D() <= self.min_dist then
			point = target:GetAbsOrigin()
			distance = 0
		end

		local mod = target:AddNewModifier( self.parent, self.parent:BkbAbility(self.ability, true),  "modifier_generic_arc",  
		{
		  target_x = point.x,
		  target_y = point.y,
		  distance = distance,
		  duration = self.pull_duration,
		  height = 0,
		  fix_end = false,
		  isStun = true,
		  activity = ACT_DOTA_FLAIL,
		})

		if mod then
			local pfx = ParticleManager:CreateParticle("particles/shadow_fiend/requiem_pull.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
			ParticleManager:SetParticleControlEnt(pfx, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetOrigin(), true )
			mod:AddParticle(pfx, false, false, -1, false, false)	
		end

		target:AddNewModifier(self.parent, self.ability, "modifier_custom_reqiuem_legendary_pull", {duration = self.pull_duration})
	end
end

end

function modifier_custom_reqiuem_cast:CheckState()
return
{
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true
}
end




modifier_custom_reqiuem_legendary_pull = class({})
function modifier_custom_reqiuem_legendary_pull:IsHidden() return true end
function modifier_custom_reqiuem_legendary_pull:IsPurgable() return false end
function modifier_custom_reqiuem_legendary_pull:GetStatusEffectName()
return "particles/status_fx/status_effect_battle_hunger.vpcf"
end
function modifier_custom_reqiuem_legendary_pull:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end


modifier_custom_reqiuem_cast_cd = class({})
function modifier_custom_reqiuem_cast_cd:IsHidden() return false end
function modifier_custom_reqiuem_cast_cd:IsPurgable() return false end
function modifier_custom_reqiuem_cast_cd:IsDebuff() return true end
function modifier_custom_reqiuem_cast_cd:GetTexture() return "buffs/darklord_damage" end
function modifier_custom_reqiuem_cast_cd:OnCreated()
self.RemoveOnDuel = true
end




modifier_custom_reqiuem_legendary_quest = class({})
function modifier_custom_reqiuem_legendary_quest:IsHidden() return true end
function modifier_custom_reqiuem_legendary_quest:IsPurgable() return false end
function modifier_custom_reqiuem_legendary_quest:OnCreated(table)
if not IsServer() then return end

self.done = false
self:SetStackCount(1)
end

function modifier_custom_reqiuem_legendary_quest:OnRefresh()
if not IsServer() then return end
if not self:GetCaster():GetQuest() then return end
if self.done == true then return end

self:IncrementStackCount()

if self:GetStackCount() >= self:GetCaster().quest.number then 
	self:GetCaster():UpdateQuest(1)
	self.done = true
end

end


modifier_custom_reqiuem_damage_reduce = class({})
function modifier_custom_reqiuem_damage_reduce:IsHidden() return false end
function modifier_custom_reqiuem_damage_reduce:IsPurgable() return false end
function modifier_custom_reqiuem_damage_reduce:GetTexture() return "buffs/counterspell_slow" end
function modifier_custom_reqiuem_damage_reduce:OnCreated()
self.damage_reduce = self:GetCaster():GetTalentValue("modifier_nevermore_requiem_3", "damage_reduce")
end

function modifier_custom_reqiuem_damage_reduce:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_custom_reqiuem_damage_reduce:GetModifierDamageOutgoing_Percentage()
return self.damage_reduce
end

function modifier_custom_reqiuem_damage_reduce:GetModifierSpellAmplify_Percentage()
return self.damage_reduce
end





modifier_custom_reqiuem_speed_damage = class({})
function modifier_custom_reqiuem_speed_damage:IsHidden() return false end
function modifier_custom_reqiuem_speed_damage:IsPurgable() return false end
function modifier_custom_reqiuem_speed_damage:GetTexture() return "buffs/fireblast_damage" end
function modifier_custom_reqiuem_speed_damage:OnCreated(table)
self.parent = self:GetParent()

self.max = self.parent:GetTalentValue("modifier_nevermore_requiem_4", "max")
self.damage = self.parent:GetTalentValue("modifier_nevermore_requiem_4", "damage")/self.max
self.speed = self.parent:GetTalentValue("modifier_nevermore_requiem_4", "speed")/self.max
if not IsServer() then return end

self.buff_particle = ParticleManager:CreateParticle( "particles/shadow_fiend/requiem_speed.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl( self.buff_particle, 0, self.parent:GetAbsOrigin() )
ParticleManager:SetParticleControl( self.buff_particle, 1, self.parent:GetAbsOrigin() )
ParticleManager:SetParticleControl( self.buff_particle, 2, self.parent:GetAbsOrigin() )
self:AddParticle(self.buff_particle, false, false, 0, true, false)

self:SetStackCount(table.stacks)
end

function modifier_custom_reqiuem_speed_damage:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_custom_reqiuem_speed_damage:GetModifierAttackSpeedBonus_Constant()
return self:GetStackCount()*self.speed
end

function modifier_custom_reqiuem_speed_damage:GetModifierSpellAmplify_Percentage()
return self:GetStackCount()*self.damage
end




modifier_custom_reqiuem_spell_absorb = class({})
function modifier_custom_reqiuem_spell_absorb:IsHidden() return true end
function modifier_custom_reqiuem_spell_absorb:IsPurgable() return false end
function modifier_custom_reqiuem_spell_absorb:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end 
self.particle = ParticleManager:CreateParticle("particles/shadow_fiend/requiem_block.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
self:AddParticle(self.particle, true, false, -1, false, false)
end

function modifier_custom_reqiuem_spell_absorb:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ABSORB_SPELL
}
end

function modifier_custom_reqiuem_spell_absorb:GetAbsorbSpell(params) 
if not IsServer() then return end
if params.ability:GetCaster():GetTeamNumber() == self.parent:GetTeamNumber() then return end

if self.particle then 
	ParticleManager:DestroyParticle(self.particle, false)
	ParticleManager:ReleaseParticleIndex(self.particle)
end 

self.block = true
self.parent:EmitSound("DOTA_Item.LinkensSphere.Activate")
self:Destroy()
return 1 
end



modifier_custom_reqiuem_scepter_heal = class({})
function modifier_custom_reqiuem_scepter_heal:IsHidden() return false end
function modifier_custom_reqiuem_scepter_heal:IsPurgable() return false end
function modifier_custom_reqiuem_scepter_heal:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.heal = self.ability:GetSpecialValueFor("scepter_heal")/100
self.creeps = self.ability:GetSpecialValueFor("scepter_heal_creeps")
self.parent:AddDamageEvent_out(self)
end

function modifier_custom_reqiuem_scepter_heal:DamageEvent_out(params)
if not IsServer() then return end
if not self.parent:CheckLifesteal(params, 0 ) then return end
local heal = self.heal*params.damage
if params.unit:IsCreep() then
	heal = heal/self.creeps
end
self.parent:GenericHeal(heal, self.ability, true, nil, "scepter")
end