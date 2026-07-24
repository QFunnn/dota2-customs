--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_furion_blooming_flare_custom", "abilities/furion/furion_blooming_flare_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_furion_blooming_flare_custom_tracker", "abilities/furion/furion_blooming_flare_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_furion_blooming_flare_custom_root", "abilities/furion/furion_blooming_flare_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_furion_blooming_flare_custom_heal_reduce", "abilities/furion/furion_blooming_flare_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_furion_blooming_flare_custom_proc", "abilities/furion/furion_blooming_flare_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_furion_blooming_flare_custom_slow", "abilities/furion/furion_blooming_flare_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_furion_blooming_flare_custom_legendary_tree", "abilities/furion/furion_blooming_flare_custom", LUA_MODIFIER_MOTION_NONE)

furion_blooming_flare_custom = class({})
furion_blooming_flare_custom.talents = {}
furion_blooming_flare_custom.trees = {}

function furion_blooming_flare_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf", context )
PrecacheResource( "particle", "particles/items3_fx/silver_edge.vpcf", context )
PrecacheResource( "particle", "particles/nature_prophet/scepter_effect.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_furion/furion_wrath_of_nature_cast.vpcf", context )
PrecacheResource( "particle", "particles/nature_prophet/wrath_legendary_proj.vpcf", context )
PrecacheResource( "particle", "particles/nature_prophet/wrath_legendary_aoe.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_sniper/sniper_headshot_slow.vpcf", context )
PrecacheResource( "particle", "particles/lc_odd_proc_.vpcf", context )
PrecacheResource( "particle", "particles/nature_prophet/wrath_stack.vpcf", context )
PrecacheResource( "particle", "particles/nature_prophet/wrath_stack_max.vpcf", context )
PrecacheResource( "particle", "particles/hoodwink/bush_damage.vpcf", context )
PrecacheResource( "particle", "particles/nature_prophet/blooming_proc_aoe.vpcf", context )
end

function furion_blooming_flare_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_r1 = 0,
    r1_damage = 0,
    r1_health = 0,
    
    has_r2 = 0,
    r2_cd = 0,
    r2_heal_reduce = 0,
    r2_duration = caster:GetTalentValue("modifier_furion_nature_2", "duration", true),
    
    has_r3 = 0,
    r3_base = 0,
    r3_damage = 0,
    r3_spell = 0,
    r3_chance = caster:GetTalentValue("modifier_furion_nature_3", "chance", true),
    r3_damage_type = caster:GetTalentValue("modifier_furion_nature_3", "damage_type", true),
    r3_radius = caster:GetTalentValue("modifier_furion_nature_3", "radius", true),
    r3_range = caster:GetTalentValue("modifier_furion_nature_3", "range", true),
    r3_interval = caster:GetTalentValue("modifier_furion_nature_3", "interval", true),
    r3_duration = caster:GetTalentValue("modifier_furion_nature_3", "duration", true),
    r3_talent_cd = caster:GetTalentValue("modifier_furion_nature_3", "talent_cd", true),
    r3_max = caster:GetTalentValue("modifier_furion_nature_3", "max", true),
    
    has_r4 = 0,
    r4_cd_items_legendary = caster:GetTalentValue("modifier_furion_nature_4", "cd_items_legendary", true),
    r4_cast = caster:GetTalentValue("modifier_furion_nature_4", "cast", true)/100,
    r4_cd_items = caster:GetTalentValue("modifier_furion_nature_4", "cd_items", true),
    r4_cdr = caster:GetTalentValue("modifier_furion_nature_4", "cdr", true),
    r4_speed = caster:GetTalentValue("modifier_furion_nature_4", "speed", true)/100,
    
    has_r7 = 0,
    r7_root = caster:GetTalentValue("modifier_furion_nature_7", "root", true)/100,
    r7_cd_inc = caster:GetTalentValue("modifier_furion_nature_7", "cd_inc", true)/100,
    r7_duration = caster:GetTalentValue("modifier_furion_nature_7", "duration", true),
    r7_tree_min = caster:GetTalentValue("modifier_furion_nature_7", "tree_min", true),
    r7_tree_max = caster:GetTalentValue("modifier_furion_nature_7", "tree_max", true),
    r7_chance = caster:GetTalentValue("modifier_furion_nature_7", "chance", true),
    r7_radius = caster:GetTalentValue("modifier_furion_nature_7", "radius", true),
    r7_mana = caster:GetTalentValue("modifier_furion_nature_7", "mana", true)/100,
  }
end

if caster:HasTalent("modifier_furion_nature_1") then
  self.talents.has_r1 = 1
  self.talents.r1_damage = caster:GetTalentValue("modifier_furion_nature_1", "damage")/100
  self.talents.r1_health = caster:GetTalentValue("modifier_furion_nature_1", "health")
  if IsServer() then
  	self.caster:CalculateStatBonus(true)
  end
end

if caster:HasTalent("modifier_furion_nature_2") then
  self.talents.has_r2 = 1
  self.talents.r2_cd = caster:GetTalentValue("modifier_furion_nature_2", "cd")
  self.talents.r2_heal_reduce = caster:GetTalentValue("modifier_furion_nature_2", "heal_reduce")
end

if caster:HasTalent("modifier_furion_nature_3") then
  self.talents.has_r3 = 1
  self.talents.r3_base = caster:GetTalentValue("modifier_furion_nature_3", "base")
  self.talents.r3_damage = caster:GetTalentValue("modifier_furion_nature_3", "damage")/100
  self.talents.r3_spell = caster:GetTalentValue("modifier_furion_nature_3", "spell")
  self.caster:AddSpellEvent(self.tracker, true)
end

if caster:HasTalent("modifier_furion_nature_4") then
  self.talents.has_r4 = 1
end

if caster:HasTalent("modifier_furion_nature_7") then
  self.talents.has_r7 = 1
  self.caster:AddSpellEvent(self.tracker, true)
end

end

function furion_blooming_flare_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_furion_blooming_flare_custom_tracker"
end

function furion_blooming_flare_custom:GetCooldown(level)
return self.BaseClass.GetCooldown( self, level ) + (self.talents.r2_cd and self.talents.r2_cd or 0)
end

function furion_blooming_flare_custom:GetManaCost(level)
return self.BaseClass.GetManaCost(self, level)*(1 + (self.talents.has_r7 == 1 and self.talents.r7_mana or 0))
end

function furion_blooming_flare_custom:GetCastPoint()
return self.BaseClass.GetCastPoint(self) * (1 + (self.talents.has_r4 == 1 and self.talents.r4_cast or 0))
end

function furion_blooming_flare_custom:OnAbilityPhaseStart()
local pfx = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_furion/furion_wrath_of_nature_cast.vpcf", self)
local cast_particle = ParticleManager:CreateParticle(pfx, PATTACH_ABSORIGIN_FOLLOW, self.caster)
ParticleManager:SetParticleControlEnt(cast_particle, 1, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", self.caster:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(cast_particle)
return true
end

function furion_blooming_flare_custom:OnSpellStart()
local point = self.caster:CastPosition(self:GetCursorPosition())

local distance = self.AbilityCastRange + self.caster:GetCastRangeBonus()
local speed = self.speed * (1 + (self.talents.has_r4 == 1 and self.talents.r4_speed or 0))
local width = self.width
local vect = point - self.caster:GetAbsOrigin()
local dir = vect:Normalized()
dir.z = 0

ProjectileManager:CreateLinearProjectile({
	EffectName = "particles/nature_prophet/wrath_legendary_proj.vpcf",
	Ability = self,
	vSpawnOrigin = self.caster:GetAbsOrigin(),
	fStartRadius = width,
	fEndRadius = width,
	vVelocity = dir * speed,
	fDistance = distance,
	Source = self.caster,
	bDeleteOnHit = true,
	iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	iUnitTargetType = DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
	bProvidesVision = true,
	iVisionTeamNumber = self.caster:GetTeamNumber(),
	iVisionRadius = width*2,
})

self.can_cd = true

self.caster:EmitSound("Furion.Wrath_legendary_cast")
self.caster:EmitSound("Furion.Wrath_legendary_cast2")
end

function furion_blooming_flare_custom:OnProjectileHit(target, vLocation)
EmitSoundOnLocationWithCaster(vLocation, "Furion.Wrath_legendary_end", self.caster)

if not target then return end

local hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_CUSTOMORIGIN, target)
ParticleManager:SetParticleControlEnt(hit_effect, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
ParticleManager:SetParticleControlEnt(hit_effect, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
ParticleManager:ReleaseParticleIndex(hit_effect)

target:AddNewModifier(self.caster, self, "modifier_stunned", {duration = (1 - target:GetStatusResistance())*self.stun})
target:AddNewModifier(self.caster, self, "modifier_furion_blooming_flare_custom", {})
return true
end



modifier_furion_blooming_flare_custom = class(mod_hidden)
function modifier_furion_blooming_flare_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_furion_blooming_flare_custom:RemoveOnDeath() return false end
function modifier_furion_blooming_flare_custom:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.jump_delay = self.ability.jump_delay * (1 - (self.ability.talents.has_r4 == 1 and self.ability.talents.r4_speed or 0))
self.target_max = self.ability.max
self.radius = self.ability.radius

self.root = self.ability.root
self.damage = self.ability.damage
self.root_max = (self.ability.root_max + (self.caster:HasShard() and self.ability.shard_root or 0))*(1 + (self.ability.talents.has_r7 == 1 and self.ability.talents.r7_root or 0))
self.damage_max = self.ability.damage_max + self.ability.talents.r1_damage*self.caster:GetIntellect(false)

self.pfx = wearables_system:GetParticleReplacementAbility(self.caster, "particles/furion/furion_wrath_of_nature_custom.vpcf", self)

self.particle_peffect = ParticleManager:CreateParticle("particles/nature_prophet/wrath_legendary_aoe.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)	
ParticleManager:SetParticleControl(self.particle_peffect, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle_peffect, 1, Vector(self.radius, 0, 0))
self:AddParticle(self.particle_peffect, false, false, -1, false, true)

self.hit_targets = {}
self.hit_count = 0

self.position = self.parent:GetAbsOrigin()
self.origin = self.position
self.part_dist = 350
self.new_target = nil
self.tree_count = 0

self.last_pos = self.position
self.stage = 1
self.need_target = true

self.damageTable = {attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}

AddFOWViewer(self.caster:GetTeamNumber(), self.position, self.radius, 5, false)
self:StartIntervalThink(FrameTime())
end

function modifier_furion_blooming_flare_custom:FindNewTarget()
if not IsServer() then return end

self.new_target = nil

if self.stage == 1 then
	local new_tree = nil
	for _, tree in pairs(GridNav:GetAllTreesAroundPoint(self.origin, self.radius, false )) do
		if not self.hit_targets[tree:entindex()] and not self.ability.trees[tree] then
			new_tree = tree
			break
		end
	end 
	if new_tree == nil then
		for _, treant in pairs(FindUnitsInRadius(self.caster:GetTeamNumber(), self.origin, nil, self.radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false)) do
			if not self.hit_targets[treant:entindex()] and treant.is_treant then
				new_tree = treant
				break
			end
		end 
	end 
	self.new_target = new_tree

elseif self.stage == 3 then
	local new_tree = nil
	for tree,_ in pairs(self.ability.trees) do
		if IsValid(tree) and not self.hit_targets[tree:entindex()] then
			new_tree = tree
			break
		end
	end
	self.new_target = new_tree

elseif self.stage == 2 then
	if not self.hit_targets[self.parent:entindex()] then
		self.new_target = self.parent
		return
	end

	local targets = self.caster:FindTargets(self.radius, self.position, false, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS)
	for _, enemy in pairs(targets) do
		if not self.hit_targets[enemy:entindex()] then
			self.new_target = enemy
			break
		end
	end 
end

end

function modifier_furion_blooming_flare_custom:CountDamage()
if not IsServer() then return end

local max = self.ability.max
self.root = self.root + (self.root_max - self.root)*math.min(1, (self.hit_count/max))
self.damage = self.damage + (self.damage_max - self.damage)*(self.hit_count/max)

if self.ability.talents.has_r4 == 1 then
	local cd = self.ability.talents.has_r7 == 1 and self.ability.talents.r4_cd_items_legendary or self.ability.talents.r4_cd_items
	self.caster:CdItems(self.hit_count*cd)
end

self.tree_count = self.hit_count

self.stage = 2
self:StartIntervalThink(0.1)
end

function modifier_furion_blooming_flare_custom:OnIntervalThink()
if not IsServer() then return end

if self.need_target then 
	self.need_target = false
	self:FindNewTarget()
end 

local enemy = nil

if not IsValid(self.new_target) or self.hit_count >= self.target_max then 
	self.need_target = true
	if self.stage == 1 then 

		self.target_max = 9999

		if self.ability.talents.has_r7 == 1 then
			self.stage = 3
			self.jump_delay = 0.1
			self:OnIntervalThink()
			return
		end

		self:CountDamage()
	elseif self.stage == 3 then
		self:CountDamage()
	elseif self.stage == 2 then
		self:StartIntervalThink(-1)
		self:Destroy()
	end
	return
else
	enemy = self.new_target
		
	local hit_effect
	if self.stage == 2 then
		hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, enemy)
		ParticleManager:SetParticleControlEnt(hit_effect, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), false) 
		ParticleManager:SetParticleControlEnt(hit_effect, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), false) 
	else
		hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(hit_effect, 0, enemy:GetAbsOrigin() + Vector(0,0,100)) 
		ParticleManager:SetParticleControl(hit_effect, 1, enemy:GetAbsOrigin() + Vector(0,0,100)) 
	end
	ParticleManager:ReleaseParticleIndex(hit_effect)

	self.hit_targets[enemy:entindex()] = true
	self.hit_count = self.hit_count + 1
	
	if self.stage == 2 then
		self.damageTable.damage = self.damage * (1 + (enemy:IsCreep() and self.ability.creeps or 0))	
		self.damageTable.victim = enemy
		DoDamage(self.damageTable)

		if self.ability.talents.has_r2 == 1 then
			enemy:AddNewModifier(self.caster, self.ability, "modifier_furion_blooming_flare_custom_heal_reduce", {duration = self.ability.talents.r2_duration})
		end

		if self.ability.talents.has_r7 == 1 and not self.tree_init and enemy:IsHero() then
			self.tree_init = true

			local count = 1
			for i = self.ability.talents.r7_tree_min, (self.ability.talents.r7_tree_max - 1) do
				if RollPseudoRandomPercentage(self.ability.talents.r7_chance, 8990, self.caster) then
					count = count + 1
				end
			end

			for i = 1, count do
				local abs = enemy:GetAbsOrigin() + RandomVector(150)
				local tree = CreateTempTree(abs, self.ability.talents.r7_duration)
				tree.is_tree = true
				ResolveNPCPositions(abs, 85)

				local unit = CreateUnitByName("npc_dota_companion", abs, false, nil, nil,self.caster:GetTeamNumber())
				unit:AddNewModifier(self.caster, self.ability, "modifier_furion_blooming_flare_custom_legendary_tree", {duration = self.ability.talents.r7_duration, tree = tree:entindex()}) 
			end
		end

		if enemy:IsRealHero() and self.caster:GetQuest() == "Furion.Quest_8" and not self.caster:QuestCompleted() and self.tree_count >= self.caster.quest.number then
			self.caster:UpdateQuest(1)
		end

		enemy:AddNewModifier(self.caster, self.caster:BkbAbility(self.ability, self.caster:HasShard()), "modifier_furion_blooming_flare_custom_root", {duration = (1 - enemy:GetStatusResistance())*self.root})
	end
end 

self.position = enemy:GetAbsOrigin()
EmitSoundOnLocationWithCaster(enemy:GetAbsOrigin(), "Furion.WrathOfNature_Damage.Creep", self.caster)

self:FindNewTarget()
local part_target = self.new_target and self.new_target or enemy

self.wrath_particle = ParticleManager:CreateParticle(self.pfx, PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.wrath_particle, 0, enemy:GetAbsOrigin() + Vector(0,0,100))
ParticleManager:SetParticleControl(self.wrath_particle, 1, part_target:GetAbsOrigin() + Vector(0,0,100))
ParticleManager:SetParticleControl(self.wrath_particle, 2, self.last_pos + Vector(0,0,100))
ParticleManager:SetParticleControl(self.wrath_particle, 3, enemy:GetAbsOrigin() + Vector(0,0,100))
ParticleManager:SetParticleControl(self.wrath_particle, 4, enemy:GetAbsOrigin() + Vector(0,0,100))
ParticleManager:ReleaseParticleIndex(self.wrath_particle)

self.last_pos = enemy:GetAbsOrigin()
self:StartIntervalThink(self.jump_delay)
end


modifier_furion_blooming_flare_custom_root = class(mod_hidden)
function modifier_furion_blooming_flare_custom_root:IsPurgable() return true end
function modifier_furion_blooming_flare_custom_root:CheckState()
return
{
	[MODIFIER_STATE_ROOTED] = true,
}
end

function modifier_furion_blooming_flare_custom_root:OnCreated()
if not IsServer() then return end 
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self.caster.blooming_ability
if not self.ability then
	self:Destroy()
	return
end

self.parent:EmitSound("Furion.Call_root")
self.parent:EmitSound("Furion.Call_root2")

local nfx = ParticleManager:CreateParticle("particles/nature_prophet/call_root.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent) 
ParticleManager:SetParticleControlEnt(nfx, 0, self.parent, PATTACH_ABSORIGIN, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(nfx, 1, self.parent, PATTACH_ABSORIGIN, "attach_hitloc", self.parent:GetAbsOrigin(), true)
self:AddParticle(nfx,false, false, -1, false, false)
end

function modifier_furion_blooming_flare_custom_root:OnDestroy()
if not IsServer() then return end
if not self.caster:HasShard() then return end

local duration = self.ability.shard_duration*(1 + (self.ability.talents.has_r7 == 1 and self.ability.talents.r7_root or 0))
self.parent:AddNewModifier(self.caster, self.caster:BkbAbility(self.ability, true), "modifier_furion_blooming_flare_custom_slow", {duration = duration})
end


modifier_furion_blooming_flare_custom_tracker = class(mod_hidden)
function modifier_furion_blooming_flare_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.blooming_ability = self.ability

self.ability.damage = self.ability:GetSpecialValueFor("damage")
self.ability.root = self.ability:GetSpecialValueFor("root")
self.ability.root_max = self.ability:GetSpecialValueFor("root_max")
self.ability.damage_max = self.ability:GetSpecialValueFor("damage_max")
self.ability.max = self.ability:GetSpecialValueFor("max")
self.ability.stun = self.ability:GetSpecialValueFor("stun")
self.ability.speed = self.ability:GetSpecialValueFor("speed")
self.ability.width = self.ability:GetSpecialValueFor("width")
self.ability.radius = self.ability:GetSpecialValueFor("radius")
self.ability.jump_delay = self.ability:GetSpecialValueFor("jump_delay")
self.ability.AbilityCastRange = self.ability:GetSpecialValueFor("AbilityCastRange")
self.ability.shard_root = self.ability:GetSpecialValueFor("shard_root")
self.ability.shard_slow = self.ability:GetSpecialValueFor("shard_slow")
self.ability.shard_duration = self.ability:GetSpecialValueFor("shard_duration")
self.ability.creeps = self.ability:GetSpecialValueFor("creeps")/100
end 

function modifier_furion_blooming_flare_custom_tracker:OnRefresh()
self.ability.root_max = self.ability:GetSpecialValueFor("root_max")
self.ability.damage_max = self.ability:GetSpecialValueFor("damage_max")
end

function modifier_furion_blooming_flare_custom_tracker:SpellEvent(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end

if self.ability.talents.has_r7 == 1 and self.ability ~= params.ability and self.ability.can_cd and self.ability:GetCooldownTimeRemaining() > 0 then
	self.ability.can_cd = false
	self.parent:CdAbility(self.ability, nil, self.ability.talents.r7_cd_inc)

	local particle = ParticleManager:CreateParticle("particles/furion/teleport_refresh.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
	ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex(particle)
	self.parent:EmitSound("Furion.Teleport_refresh")
end

if self.ability.talents.has_r3 == 0 then return end

local point = self.parent:GetAbsOrigin()
if params.point then
	point = params.point
elseif params.target then
	point = params.target:GetAbsOrigin()
end

local target = self.parent:RandomTarget(self.ability.talents.r3_range, point)
if not target then return end
if not self.parent:CheckCd("furion_r3", self.ability.talents.r3_talent_cd, self.ability.talents.r3_chance, 8991) then return end

local timer = params.ability == self.ability and 0.4 or 0

Timers:CreateTimer(timer, function()
	self.parent:EmitSound("Furion.Blooming_proc")
	target:AddNewModifier(self.parent, self.ability, "modifier_furion_blooming_flare_custom_proc", {})

	local wrath_particle = ParticleManager:CreateParticle("particles/nature_prophet/teleport_damage.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(wrath_particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(wrath_particle, 1, self.parent:GetAbsOrigin() + Vector(0,0,100))
	ParticleManager:SetParticleControlEnt(wrath_particle, 4, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(wrath_particle)
end)

end

function modifier_furion_blooming_flare_custom_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	MODIFIER_PROPERTY_HEALTH_BONUS,
}
end

function modifier_furion_blooming_flare_custom_tracker:GetModifierSpellAmplify_Percentage()
return self.ability.talents.r3_spell
end

function modifier_furion_blooming_flare_custom_tracker:GetModifierPercentageCooldown()
if self.ability.talents.has_r4 == 0 then return end
return self.ability.talents.r4_cdr
end

function modifier_furion_blooming_flare_custom_tracker:GetModifierHealthBonus()
return self.ability.talents.r1_health*self.parent:GetIntellect(false)
end



modifier_furion_blooming_flare_custom_slow = class(mod_hidden)
function modifier_furion_blooming_flare_custom_slow:IsPurgable() return true end
function modifier_furion_blooming_flare_custom_slow:GetStatusEffectName() return "particles/status_fx/status_effect_natures_prophet_curse.vpcf" end 
function modifier_furion_blooming_flare_custom_slow:StatusEffectPriority() return MODIFIER_PRIORITY_NORMAL end
function modifier_furion_blooming_flare_custom_slow:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability = self:GetCaster().blooming_ability
if not self.ability then
	self:Destroy()
	return
end

self.slow = self.ability.shard_slow
if not IsServer() then return end
self.parent:GenericParticle("particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap_debuff.vpcf", self)
end

function modifier_furion_blooming_flare_custom_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_furion_blooming_flare_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end



modifier_furion_blooming_flare_custom_proc = class(mod_visible)
function modifier_furion_blooming_flare_custom_proc:GetTexture() return "buffs/furion/nature_wrath_3" end
function modifier_furion_blooming_flare_custom_proc:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_furion_blooming_flare_custom_proc:GetEffectName()  return "particles/units/heroes/hero_furion/furion_sprout_damage.vpcf" end
function modifier_furion_blooming_flare_custom_proc:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.init = false
self.max = self.ability.talents.r3_duration + 1
self.radius = self.ability.talents.r3_radius
self.interval = self.ability.talents.r3_interval
self.count = 0

self.parent:GenericParticle("particles/units/heroes/hero_furion/furion_curse_of_forest_debuff.vpcf", self)

self.damageTable = {victim = self.parent, ability = self.ability, attacker = self.caster, damage_type = self.ability.talents.r3_damage_type}

self:StartIntervalThink(0.15)
end

function modifier_furion_blooming_flare_custom_proc:OnIntervalThink()
if not IsServer() then return end

if not self.init then
	local nFXIndex = ParticleManager:CreateParticle( "particles/nature_prophet/blooming_proc_aoe.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( nFXIndex, 0, self.parent:GetAbsOrigin() )
	ParticleManager:SetParticleControl( nFXIndex, 1, Vector(self.radius, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( nFXIndex )

	self.init = true

	local count = #GridNav:GetAllTreesAroundPoint(self.parent:GetOrigin(), self.radius, false)

	self.treants = FindUnitsInRadius(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false )
	for _,treant in pairs(self.treants) do
		if treant.is_treant and treant.owner and treant.owner == self.caster then 
			count = count + 1
		end
	end 
	count = math.max(1, math.min(self.ability.talents.r3_max, count))

	self:SetStackCount(count)
	local damage = (self.ability.talents.r3_base + self.ability.talents.r3_damage*self.caster:GetIntellect(false))*count*self.interval/self.max
	self.damageTable.damage = damage
	self:StartIntervalThink(self.interval)
end

DoDamage(self.damageTable, "modifier_furion_nature_3")

self.count = self.count + 1
if self.count >= self.max then
	self:Destroy()
	return
end

end



modifier_furion_blooming_flare_custom_heal_reduce = class(mod_hidden)
function modifier_furion_blooming_flare_custom_heal_reduce:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.heal_reduce = self.ability.talents.r2_heal_reduce
end

function modifier_furion_blooming_flare_custom_heal_reduce:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE
}
end

function modifier_furion_blooming_flare_custom_heal_reduce:GetModifierHealChange()
return self.heal_reduce
end

function modifier_furion_blooming_flare_custom_heal_reduce:GetModifierHPRegenAmplify_Percentage()
return self.heal_reduce
end


modifier_furion_blooming_flare_custom_legendary_tree = class(mod_hidden)
function modifier_furion_blooming_flare_custom_legendary_tree:OnCreated(params)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.vision_radius = self.ability.talents.r7_radius
self.tree = EntIndexToHScript(params.tree)
self.team = self.caster:GetTeamNumber()
self.pos = self.parent:GetAbsOrigin()

self.ability.trees[self.tree] = true

self.parent:GenericParticle("particles/nature_prophet/teleport_armor.vpcf", self)

self.interval = 0.5
self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_furion_blooming_flare_custom_legendary_tree:OnIntervalThink()
if not IsServer() then return end

if (self.tree.IsStanding and not self.tree:IsStanding()) or self.tree:IsNull() then
	self:Destroy()
	return
end

for _,player in pairs(players) do
	if player:IsAlive() and (player == self.caster or (player:GetAbsOrigin() - self.pos):Length2D() <= (self.vision_radius + 200)) then
		AddFOWViewer(player:GetTeamNumber(), self.pos, self.vision_radius, self.interval*2, false)
	end
end

end

function modifier_furion_blooming_flare_custom_legendary_tree:CheckState()
return
{
	[MODIFIER_STATE_INVULNERABLE] = true,
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	[MODIFIER_STATE_OUT_OF_GAME] = true,
	[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	[MODIFIER_STATE_UNTARGETABLE] = true,
	[MODIFIER_STATE_UNSELECTABLE] = true,
	[MODIFIER_STATE_STUNNED] = true,
	[MODIFIER_STATE_FLYING] = true,
}
end

function modifier_furion_blooming_flare_custom_legendary_tree:OnDestroy()
if not IsServer() then return end

self.ability.trees[self.tree] = nil
self.parent:RemoveSelf()
end