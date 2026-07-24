--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bloodseeker_blood_bath_custom_thinker", "abilities/bloodseeker/bloodseeker_blood_bath_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bloodseeker_blood_bath_custom_damage_inc", "abilities/bloodseeker/bloodseeker_blood_bath_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bloodseeker_blood_bath_custom_legendary_self", "abilities/bloodseeker/bloodseeker_blood_bath_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bloodseeker_blood_bath_custom_tracker", "abilities/bloodseeker/bloodseeker_blood_bath_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bloodseeker_blood_bath_custom_silence", "abilities/bloodseeker/bloodseeker_blood_bath_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bloodseeker_blood_mist_custom", "abilities/bloodseeker/bloodseeker_blood_bath_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_bloodseeker_blood_mist_custom_effect", "abilities/bloodseeker/bloodseeker_blood_bath_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_bloodseeker_blood_mist_custom_root", "abilities/bloodseeker/bloodseeker_blood_bath_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_bloodseeker_blood_mist_custom_health_reduce", "abilities/bloodseeker/bloodseeker_blood_bath_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_bloodseeker_blood_mist_custom_health_inc", "abilities/bloodseeker/bloodseeker_blood_bath_custom", LUA_MODIFIER_MOTION_NONE )

bloodseeker_blood_bath_custom = class({})
bloodseeker_blood_bath_custom.talents = {}

function bloodseeker_blood_bath_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_ring.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_ring.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_impact.vpcf", context )
PrecacheResource( "particle", "particles/generic_gameplay/generic_silenced.vpcf", context )
PrecacheResource( "particle", "particles/items2_fx/sange_maim.vpcf", context )
PrecacheResource( "particle", "particles/status_fx/status_effect_rupture.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_rupture.vpcf", context )
PrecacheResource( "particle", "particles/bloodseeker/rite_stun.vpcf", context )
PrecacheResource( "particle", "particles/bs_root.vpcf", context )
end

function bloodseeker_blood_bath_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true

  self.talents =
  {
  	q1_spell = 0,
  	q1_damage = 0,

    cd_inc = 0,
    delay_inc = 0,

    has_h2 = 0,

    has_bkb = 0,
    bkb_duration = caster:GetTalentValue("modifier_bloodseeker_hero_4", "bkb_duration", true),

    has_w3 = 0,
    w3_health = 0,
    w3_duration = caster:GetTalentValue("modifier_bloodseeker_bloodrite_3", "duration", true),
    w3_stack = caster:GetTalentValue("modifier_bloodseeker_bloodrite_3", "stack", true),
    w3_max = caster:GetTalentValue("modifier_bloodseeker_bloodrite_3", "max", true),

    has_root = 0,
    radius_inc = 0,
    root_duration = caster:GetTalentValue("modifier_bloodseeker_bloodrite_4", "root", true),
    root_range = caster:GetTalentValue("modifier_bloodseeker_bloodrite_4", "range", true),
    root_knock_duration = caster:GetTalentValue("modifier_bloodseeker_bloodrite_4", "duration", true),

    has_legendary = 0,
    legendary_damage = caster:GetTalentValue("modifier_bloodseeker_bloodrite_7", "damage", true)/100,
    legendary_damage_inc = caster:GetTalentValue("modifier_bloodseeker_bloodrite_7", "damage_inc", true)/100,
    legendary_damage_duration = caster:GetTalentValue("modifier_bloodseeker_bloodrite_7", "duration", true),
    legendary_radius = caster:GetTalentValue("modifier_bloodseeker_bloodrite_7", "radius", true),
    legendary_damage_type = caster:GetTalentValue("modifier_bloodseeker_bloodrite_7", "damage_type", true),
    legendary_interval = caster:GetTalentValue("modifier_bloodseeker_bloodrite_7", "interval", true),
    legendary_cost = caster:GetTalentValue("modifier_bloodseeker_bloodrite_7", "cost", true)/100,
  }

end

if caster:HasTalent("modifier_bloodseeker_bloodrite_1") then
  self.talents.q1_spell = caster:GetTalentValue("modifier_bloodseeker_bloodrite_1", "spell")
  self.talents.q1_damage = caster:GetTalentValue("modifier_bloodseeker_bloodrite_1", "damage")
end

if caster:HasTalent("modifier_bloodseeker_bloodrite_2") then
  self.talents.cd_inc = caster:GetTalentValue("modifier_bloodseeker_bloodrite_2", "cd")
  self.talents.delay_inc = caster:GetTalentValue("modifier_bloodseeker_bloodrite_2", "delay")
end

if caster:HasTalent("modifier_bloodseeker_bloodrite_3") then
	self.talents.has_w3 = 1
  self.talents.w3_health = caster:GetTalentValue("modifier_bloodseeker_bloodrite_3", "health")
end

if caster:HasTalent("modifier_bloodseeker_bloodrite_4") then
  self.talents.has_root = 1
  self.talents.radius_inc = caster:GetTalentValue("modifier_bloodseeker_bloodrite_4", "radius")
end

if caster:HasTalent("modifier_bloodseeker_hero_2") then
  self.talents.has_h2 = 1
end

if caster:HasTalent("modifier_bloodseeker_hero_4") then
  self.talents.has_bkb = 1
end

if caster:HasTalent("modifier_bloodseeker_bloodrite_7") then
  self.talents.has_legendary = 1
end

end

function bloodseeker_blood_bath_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_bloodseeker_blood_bath_custom_tracker"
end

function bloodseeker_blood_bath_custom:GetCastAnimation()
if self.talents.has_bkb == 1 then 
	return 0
end 
return ACT_DOTA_CAST_ABILITY_2
end

function bloodseeker_blood_bath_custom:GetCastPoint()
if self.talents.has_bkb == 1 then 
  return 0
end
return self:GetSpecialValueFor("AbilityCastPoint")
end

function bloodseeker_blood_bath_custom:GetAOERadius()
return (self.radius and self.radius or 0) + (self.talents.radius_inc and self.talents.radius_inc or 0)
end

function bloodseeker_blood_bath_custom:GetCooldown(iLevel)
return self.BaseClass.GetCooldown(self, iLevel) + (self.talents.cd_inc and self.talents.cd_inc or 0)
end

function bloodseeker_blood_bath_custom:OnSpellStart()
local caster = self:GetCaster()
local point = self:GetCursorPosition()
local delay = self.delay + self.talents.delay_inc

local thinker = CreateModifierThinker( caster, self, "modifier_bloodseeker_blood_bath_custom_thinker", {duration = delay}, point, caster:GetTeamNumber(), false )
thinker:EmitSound("Hero_Bloodseeker.BloodRite.Cast")

if self.talents.has_root == 1 then
	for _,target in pairs(caster:FindTargets(self:GetAOERadius(), point)) do
		if not target:IsDebuffImmune() then
			local target_point = target:GetAbsOrigin()
			if target_point == point then
				target_point = target_point + target:GetForwardVector()*10
			end

			local direction = point - target_point
			local distance = math.min(self.talents.root_range, direction:Length2D())
			direction = direction:Normalized()

			local arc = target:AddNewModifier( caster, self, "modifier_generic_arc",
			{ 
				dir_x = direction.x,
				dir_y = direction.y,
				duration = self.talents.root_knock_duration,
				distance = distance,
				fix_end = false,
				isStun = false,
				activity = ACT_DOTA_FLAIL,
			})

			if arc then 
				local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_rupture.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
				ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
				arc:AddParticle(particle, false, false, -1, false, false)

				arc:SetEndCallback(function()
					target:AddNewModifier(caster, self, "modifier_bloodseeker_blood_mist_custom_root", {duration = (1 - target:GetStatusResistance()*self.talents.root_duration)})
				end)
			end
		end
	end
end

if self.talents.has_bkb == 1 then 
  caster:StartGesture(ACT_DOTA_CAST_ABILITY_4)
end 

end


function bloodseeker_blood_bath_custom:ApplyHealth(target, is_stack)
if not IsServer() then return end
if not self:IsTrained() then return end
if self.talents.has_w3 == 0 then return end
if not target:IsRealHero() then return end
local caster = self:GetCaster()

if target:GetTeamNumber() == caster:GetTeamNumber() then return end

local stack = 1
if is_stack then
	stack = self.talents.w3_stack
end

target:AddNewModifier(caster, self, "modifier_bloodseeker_blood_mist_custom_health_reduce", {stack = stack, duration = self.talents.w3_duration})
end


modifier_bloodseeker_blood_bath_custom_thinker = class(mod_hidden)
function modifier_bloodseeker_blood_bath_custom_thinker:OnCreated( kv )
if not IsServer() then return end

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.center = self.parent:GetAbsOrigin()

self.radius = self.ability:GetAOERadius()
self.silence_duration = self.ability.silence_duration

AddFOWViewer( self.caster:GetTeamNumber(), self.center, self.radius, 6 + self:GetRemainingTime(), false)

self.particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_ring.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( self.particle, 0, self.center )
ParticleManager:SetParticleControl( self.particle, 1, Vector( self.radius, self.radius, self.radius ) )
self:AddParticle(self.particle, false, false, -1, false, false)

self.parent:EmitSound("BS.Bloodrite")
end

function modifier_bloodseeker_blood_bath_custom_thinker:OnDestroy( kv )
if not IsServer() then return end

self.damage = self.ability.damage + self.ability.talents.q1_damage
local hit_hero = false

for _,enemy in pairs(self.caster:FindTargets(self.radius, self.center)) do
	if enemy:IsRealHero() and self.caster:GetQuest() == "Blood.Quest_6" then 
		self.caster:UpdateQuest(1)
	end

	if enemy:IsHero() then
		hit_hero = true
	end

	if self.ability.talents.has_legendary == 1 then
		enemy:AddNewModifier(self.caster, self.ability, "modifier_bloodseeker_blood_bath_custom_damage_inc", {duration = self.ability.talents.legendary_damage_duration})
	end

	if self.ability.talents.has_w3 == 1 and enemy:IsRealHero() then
		self.ability:ApplyHealth(enemy, true)
	end

	enemy:AddNewModifier( self.caster, self.ability, "modifier_bloodseeker_blood_bath_custom_silence", { duration = self.silence_duration*(1 - enemy:GetStatusResistance()) } )

	local target_damage = self.damage
	if enemy:IsCreep() then
		target_damage = target_damage*(1 + self.ability.creeps)
	end

	DoDamage({ attacker = self.caster, victim = enemy, damage = target_damage, damage_type = DAMAGE_TYPE_PURE, ability = self.ability })

	if self.caster.bloodrage_ability then
		self.caster.bloodrage_ability:ProcShard(enemy)
	end

	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy )
	ParticleManager:ReleaseParticleIndex( particle )
	enemy:EmitSound("hero_bloodseeker.bloodRite.silence")
end

if (self.caster:GetAbsOrigin() - self.center):Length2D() <= self.radius then
	if self.ability.talents.has_legendary == 1 then
		self.caster:AddNewModifier(self.caster, self.ability, "modifier_bloodseeker_blood_bath_custom_legendary_self", {duration = self.ability.talents.legendary_damage_duration})
	end

	if self.ability.talents.has_bkb == 1 then 
		self.caster:EmitSound("BS.Bloodrite_purge")
		self.caster:Purge(false, true, false, true, true)
		self.caster:AddNewModifier(self.caster, self.ability, "modifier_generic_debuff_immune", {effect = 2, duration = self.ability.talents.bkb_duration})
	end

	if self.ability.talents.has_h2 == 1 and self.caster.sanguivore_ability and IsValid(self.caster.sanguivore_ability.tracker) then 
		self.caster.sanguivore_ability.tracker:AddShield(nil, true)
	end
end

if self.ability.talents.delay_inc < 0 then
	self.parent:StopSound("BS.Bloodrite")
end

UTIL_Remove(self.parent)
end



modifier_bloodseeker_blood_bath_custom_tracker = class(mod_hidden)
function modifier_bloodseeker_blood_bath_custom_tracker:OnCreated()
self.ability  = self:GetAbility()
self.parent   = self:GetParent()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.bath_ability = self.ability

self.legendary_ability = self.parent:FindAbilityByName("bloodseeker_blood_mist_custom")
if self.legendary_ability then
	self.legendary_ability:UpdateTalents()
end

self.ability.delay = self.ability:GetSpecialValueFor( "delay" )
self.ability.radius = self.ability:GetSpecialValueFor("radius")
self.ability.damage = self.ability:GetSpecialValueFor("damage")
self.ability.creeps = self.ability:GetSpecialValueFor("creeps")/100
self.ability.silence_duration = self.ability:GetSpecialValueFor("silence_duration")
end

function modifier_bloodseeker_blood_bath_custom_tracker:OnRefresh()
self.ability.damage = self.ability:GetSpecialValueFor("damage")
self.ability.silence_duration = self.ability:GetSpecialValueFor("silence_duration")
end

function modifier_bloodseeker_blood_bath_custom_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end

function modifier_bloodseeker_blood_bath_custom_tracker:GetModifierSpellAmplify_Percentage()
return self.ability.talents.q1_spell
end



modifier_bloodseeker_blood_bath_custom_silence = class({})
function modifier_bloodseeker_blood_bath_custom_silence:IsHidden() return true end
function modifier_bloodseeker_blood_bath_custom_silence:IsPurgable() return true end
function modifier_bloodseeker_blood_bath_custom_silence:OnCreated()
if not IsServer() then return end
self.ability = self:GetAbility()
if self.ability.talents.has_legendary == 1 then return end
self:GetParent():GenericParticle("particles/generic_gameplay/generic_silenced.vpcf", self, true)
end

function modifier_bloodseeker_blood_bath_custom_silence:CheckState()
return
{
	[MODIFIER_STATE_SILENCED] = true,
}
end



modifier_bloodseeker_blood_mist_custom_root = class({})
function modifier_bloodseeker_blood_mist_custom_root:IsHidden() return true end
function modifier_bloodseeker_blood_mist_custom_root:IsPurgable() return true end
function modifier_bloodseeker_blood_mist_custom_root:CheckState()
return
{
	[MODIFIER_STATE_ROOTED] = true
}
end
function modifier_bloodseeker_blood_mist_custom_root:OnCreated()
self.parent = self:GetParent()
if not IsServer() then return end
self.parent:EmitSound("BS.Bloodrite_root")
self.parent:GenericParticle("particles/bs_root.vpcf", self)
end




bloodseeker_blood_mist_custom = class({})
bloodseeker_blood_mist_custom.talents = {}

function bloodseeker_blood_mist_custom:CreateTalent()
self:SetHidden(false)
end

function bloodseeker_blood_mist_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init and caster:HasTalent("modifier_bloodseeker_bloodrite_7")  then
  self.init = true
  if IsServer() and not self:IsTrained() then
  	self:SetLevel(1)
  end
  self.talents.legendary_cost = caster:GetTalentValue("modifier_bloodseeker_bloodrite_7", "cost", true)/100
  self.talents.legendary_radius = caster:GetTalentValue("modifier_bloodseeker_bloodrite_7", "radius", true)
  self.talents.legendary_damage_inc = caster:GetTalentValue("modifier_bloodseeker_bloodrite_7", "damage_inc", true)/100
  self.talents.legendary_interval = caster:GetTalentValue("modifier_bloodseeker_bloodrite_7", "interval", true)
  self.talents.legendary_damage_type = caster:GetTalentValue("modifier_bloodseeker_bloodrite_7", "damage_type", true)
  self.talents.legendary_damage = caster:GetTalentValue("modifier_bloodseeker_bloodrite_7", "damage", true)/100
end

end

function bloodseeker_blood_mist_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_scepter_blood_mist_aoe.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_scepter_blood_mist_spray_initial.vpcf", context )
PrecacheResource( "particle", "particles/status_fx/status_effect_life_stealer_open_wounds.vpcf", context )
PrecacheResource( "particle", "particles/bloodseeker/bloodrage_shield.vpcf", context )
end

function bloodseeker_blood_mist_custom:GetCastRange()
return (self.talents.legendary_radius and self.talents.legendary_radius or 0) - self:GetCaster():GetCastRangeBonus()
end


function bloodseeker_blood_mist_custom:OnToggle()
local caster = self:GetCaster()
local toggle = self:GetToggleState()
local mod = caster:FindModifierByName("modifier_bloodseeker_blood_mist_custom")

if not mod then
	caster:EmitSound("Hero_Boodseeker.Bloodmist")
  caster:AddNewModifier( caster, self, "modifier_bloodseeker_blood_mist_custom", {} )
  caster:StartGesture(ACT_DOTA_CAST_ABILITY_4)
else
	mod:Destroy()
  caster:StopSound("Hero_Boodseeker.Bloodmist")
end

self:StartCd()
end


modifier_bloodseeker_blood_mist_custom = class(mod_visible)
function modifier_bloodseeker_blood_mist_custom:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.radius = self.ability.talents.legendary_radius
self.cost = self.ability.talents.legendary_cost
self.damage_inc = self.ability.talents.legendary_damage_inc
self.interval = self.ability.talents.legendary_interval
self.damage = self.ability.talents.legendary_damage

if not IsServer() then return end
self.target_table = {attacker = self.parent, damage_type = self.ability.talents.legendary_damage_type, ability = self.ability}
self.self_table = {attacker = self.parent, victim = self.parent, damage_type = DAMAGE_TYPE_PURE, ability = self.parent:BkbAbility(self.ability, true), damage_flags = DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS + DOTA_DAMAGE_FLAG_NON_LETHAL + DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK}

local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_scepter_blood_mist_aoe.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(particle, 1, Vector(self.radius, self.radius, self.radius))
self:AddParticle(particle, false, false, -1, false, false)

self.parent:GenericParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_scepter_blood_mist_spray_initial.vpcf", self)

self:StartIntervalThink(self.interval)
end

function modifier_bloodseeker_blood_mist_custom:OnIntervalThink()
if not IsServer() then return end

local cost = self.parent:GetMaxHealth()*self.cost*self.interval
self.self_table.damage = cost

if not self.parent:HasModifier("modifier_bloodseeker_blood_bath_custom_legendary_self") then
	DoDamage(self.self_table)
end

local cost = cost*self.damage
for _,target in pairs(self.parent:FindTargets(self.radius)) do
	self.target_table.victim = target
	self.target_table.damage = target:HasModifier("modifier_bloodseeker_blood_bath_custom_damage_inc") and cost*(1 + self.damage_inc) or cost
	DoDamage(self.target_table)

	if self.parent.bloodrage_ability then
		self.parent.bloodrage_ability:ProcShard(target)
	end
end

end


function modifier_bloodseeker_blood_mist_custom:GetAuraRadius() return self.radius end
function modifier_bloodseeker_blood_mist_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_bloodseeker_blood_mist_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_bloodseeker_blood_mist_custom:GetAuraDuration() return 0 end
function modifier_bloodseeker_blood_mist_custom:GetModifierAura() return "modifier_bloodseeker_blood_mist_custom_effect" end
function modifier_bloodseeker_blood_mist_custom:IsAura() return true end



modifier_bloodseeker_blood_mist_custom_effect = class(mod_hidden)
function modifier_bloodseeker_blood_mist_custom_effect:GetStatusEffectName() return "particles/status_fx/status_effect_life_stealer_open_wounds.vpcf" end
function modifier_bloodseeker_blood_mist_custom_effect:StatusEffectPriority() return MODIFIER_PRIORITY_NORMAL  end



modifier_bloodseeker_blood_bath_custom_damage_inc = class(mod_hidden)
function modifier_bloodseeker_blood_bath_custom_damage_inc:GetEffectName() return "particles/items2_fx/sange_maim.vpcf" end
function modifier_bloodseeker_blood_bath_custom_damage_inc:OnCreated()
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.parent:GenericParticle("particles/general/generic_armor_reduction.vpcf", self, true)
end 


modifier_bloodseeker_blood_bath_custom_legendary_self = class(mod_hidden)
function modifier_bloodseeker_blood_bath_custom_legendary_self:GetEffectName() return "particles/bloodseeker/bloodrage_shield.vpcf" end
function modifier_bloodseeker_blood_bath_custom_legendary_self:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self.interval = 0.1
self.max_time = self:GetRemainingTime()
self:StartIntervalThink(self.interval)
end

function modifier_bloodseeker_blood_bath_custom_legendary_self:OnIntervalThink()
if not IsServer() then return end
if self.ended then return end
self.parent:UpdateUIshort({max_time = self.max_time, time = self:GetRemainingTime(), stack = self:GetRemainingTime(), use_zero = 1, style = "BloodseekerRite"})
end


function modifier_bloodseeker_blood_bath_custom_legendary_self:OnDestroy()
if not IsServer() then return end
self.ended = true
self.parent:UpdateUIshort({hide = 1, hide_full = 1, style = "BloodseekerRite"})
end



modifier_bloodseeker_blood_mist_custom_health_reduce = class(mod_visible)
function modifier_bloodseeker_blood_mist_custom_health_reduce:GetTexture() return "buffs/bloodseeker/bloodrite_3" end
function modifier_bloodseeker_blood_mist_custom_health_reduce:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max_health = self.parent:GetMaxHealth()
self.max = self.ability.talents.w3_max
self.health = self.ability.talents.w3_health/self.max

if not IsServer() then return end
self.RemoveForDuel = true

self.duration = self:GetRemainingTime()

self:AddStack(table)
end

function modifier_bloodseeker_blood_mist_custom_health_reduce:OnRefresh(table)
if not IsServer() then return end
self:AddStack(table)
end

function modifier_bloodseeker_blood_mist_custom_health_reduce:AddStack(table)
if not IsServer() then return end

if self:GetStackCount() < self.max then
	local stack = table.stack and table.stack or 1
	self:SetStackCount(math.min(self.max, self:GetStackCount() + stack))

	if self:GetStackCount() >= self.max then
	  self.parent:GenericParticle("particles/items4_fx/spirit_vessel_damage.vpcf", self)
	end
end

self:SendHealth()
end

function modifier_bloodseeker_blood_mist_custom_health_reduce:SendHealth()
if not IsServer() then return end

local health = self.max_health*self.health*self:GetStackCount()/100

if not IsValid(self.health_mod) then
  self.health_mod = self.caster:AddNewModifier(self.caster, self.ability, "modifier_bloodseeker_blood_mist_custom_health_inc", {duration = self.duration, health = health})
else
  self.health_mod:SetDuration(self.duration, true)
  self.health_mod:AddHealth({health = health})
end

end

function modifier_bloodseeker_blood_mist_custom_health_reduce:OnStackCountChanged(iStackCount)
if not IsServer() then return end
if not self.parent:IsHero() then return end
self.parent:CalculateStatBonus(true)
end

function modifier_bloodseeker_blood_mist_custom_health_reduce:OnDestroy()
if not IsServer() then return end
if IsValid(self.health_mod) then
  self.health_mod:Destroy()
end

self:OnStackCountChanged()
end

function modifier_bloodseeker_blood_mist_custom_health_reduce:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE
}
end

function modifier_bloodseeker_blood_mist_custom_health_reduce:GetModifierExtraHealthPercentage()
return self.health*self:GetStackCount()*-1
end


modifier_bloodseeker_blood_mist_custom_health_inc = class(mod_visible)
function modifier_bloodseeker_blood_mist_custom_health_inc:GetTexture() return "buffs/bloodseeker/bloodrite_3" end
function modifier_bloodseeker_blood_mist_custom_health_inc:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_bloodseeker_blood_mist_custom_health_inc:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self:AddHealth(table)
end

function modifier_bloodseeker_blood_mist_custom_health_inc:AddHealth(table)
if not IsServer() then return end
self:SetStackCount(table.health)
self.parent:CalculateStatBonus(true)
end

function modifier_bloodseeker_blood_mist_custom_health_inc:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_HEALTH_BONUS,
}
end

function modifier_bloodseeker_blood_mist_custom_health_inc:GetModifierHealthBonus()
return self:GetStackCount()
end