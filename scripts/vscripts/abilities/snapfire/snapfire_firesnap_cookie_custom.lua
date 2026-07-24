--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_snapfire_firesnap_cookie_custom", "abilities/snapfire/snapfire_firesnap_cookie_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_firesnap_cookie_custom_speed", "abilities/snapfire/snapfire_firesnap_cookie_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_firesnap_cookie_custom_tracker", "abilities/snapfire/snapfire_firesnap_cookie_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_firesnap_cookie_custom_cookie", "abilities/snapfire/snapfire_firesnap_cookie_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_firesnap_cookie_custom_bomb_cookie", "abilities/snapfire/snapfire_firesnap_cookie_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_firesnap_cookie_custom_bomb_slow", "abilities/snapfire/snapfire_firesnap_cookie_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_firesnap_cookie_custom_resist", "abilities/snapfire/snapfire_firesnap_cookie_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_firesnap_cookie_custom_legendary_cd", "abilities/snapfire/snapfire_firesnap_cookie_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_firesnap_cookie_custom_legendary_tracker", "abilities/snapfire/snapfire_firesnap_cookie_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_firesnap_cookie_custom_legendary_speed", "abilities/snapfire/snapfire_firesnap_cookie_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_firesnap_cookie_custom_unslow", "abilities/snapfire/snapfire_firesnap_cookie_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_firesnap_cookie_custom_shield", "abilities/snapfire/snapfire_firesnap_cookie_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_firesnap_cookie_custom_shield_cd", "abilities/snapfire/snapfire_firesnap_cookie_custom", LUA_MODIFIER_MOTION_NONE )



snapfire_firesnap_cookie_custom = class({})
snapfire_firesnap_cookie_custom_2 = class({})


function snapfire_firesnap_cookie_custom:CreateTalent()
--self:UpdateJs()

if dota1x6.current_wave >= upgrade_orange then 
	local caster = self:GetCaster()
	local max = caster:GetTalentValue("modifier_snapfire_cookie_7", "max_speed", true)/2

	local mod = caster:AddNewModifier(caster, self, "modifier_snapfire_firesnap_cookie_custom_legendary_speed", {})
	if mod then
		mod:SetStackCount(max)
	end
end

end

function snapfire_firesnap_cookie_custom_2:CreateTalent()
self:GetCaster():SwapAbilities(self:GetName(), "snapfire_firesnap_cookie_custom", true, false)
end

function snapfire_firesnap_cookie_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_cookie_selfcast.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_cookie_buff.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_cookie_receive.vpcf", context )
PrecacheResource( "particle","particles/sf_refresh_a.vpcf", context )
PrecacheResource( "particle","particles/cleance_blade.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_cookie_landing.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_cookie_landing.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_cookie_receive.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_stunned.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_lifesteal.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_cookie_projectile.vpcf", context )
PrecacheResource( "particle","particles/alch_stun_legendary.vpcf", context )
PrecacheResource( "particle","particles/sf_refresh_a.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_monkey_king/monkey_king_disguise.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_cookie_projectile.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_timer.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/black_powder_bag.vpcf", context )
PrecacheResource( "particle","particles/zeus_resist_stack.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sniper/sniper_headshot_slow.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_huskar_lifebreak.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_cookie_projectile.vpcf", context )
PrecacheResource( "particle","particles/lc_odd_proc_.vpcf", context )
PrecacheResource( "particle","particles/snapfire/cookie_shield.vpcf", context )

end

function snapfire_firesnap_cookie_custom_2:GetBehavior()
local bonus = DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
if self:GetCaster():HasTalent("modifier_snapfire_cookie_5") then
	bonus = 0
end
return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + bonus
end

function snapfire_firesnap_cookie_custom:GetBehavior()
local bonus = DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
if self:GetCaster():HasTalent("modifier_snapfire_cookie_5") then
	bonus = 0
end
return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + bonus
end

function snapfire_firesnap_cookie_custom_2:GetAbilityChargeRestoreTime(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_snapfire_cookie_6") then 
	bonus = self:GetCaster():GetTalentValue("modifier_snapfire_cookie_6", "cd")
end 
return self:GetSpecialValueFor("AbilityChargeRestoreTime") + bonus
end

function snapfire_firesnap_cookie_custom:GetCastPoint()
local bonus = 0
if self:GetCaster():HasTalent("modifier_snapfire_cookie_3") then 
	bonus = self:GetCaster():GetTalentValue("modifier_snapfire_cookie_3", "cast")
end
return self:GetSpecialValueFor("AbilityCastPoint") + bonus
end

function snapfire_firesnap_cookie_custom_2:GetCastPoint()
local bonus = 0
if self:GetCaster():HasTalent("modifier_snapfire_cookie_3") then 
	bonus = self:GetCaster():GetTalentValue("modifier_snapfire_cookie_3", "cast")
end
return self:GetSpecialValueFor("AbilityCastPoint") + bonus
end

function snapfire_firesnap_cookie_custom_2:GetAOERadius()
return self:GetSpecialValueFor("impact_radius")
end

function snapfire_firesnap_cookie_custom:GetAOERadius()
return self:GetSpecialValueFor("impact_radius")
end

function snapfire_firesnap_cookie_custom:GetManaCost(iLevel)
if self:GetCaster():HasTalent("modifier_snapfire_cookie_6") then
    return 0
end
return self.BaseClass.GetManaCost(self, iLevel)
end

function snapfire_firesnap_cookie_custom_2:GetManaCost(iLevel)
if self:GetCaster():HasTalent("modifier_snapfire_cookie_6") then
    return 0
end
return self.BaseClass.GetManaCost(self, iLevel)
end

function snapfire_firesnap_cookie_custom:GetRange()
return self:GetSpecialValueFor( "jump_horizontal_distance" ) + self:GetCaster():GetTalentValue("modifier_snapfire_cookie_2", "range")
end

function snapfire_firesnap_cookie_custom_2:GetRange()
return self:GetSpecialValueFor( "jump_horizontal_distance" ) + self:GetCaster():GetTalentValue("modifier_snapfire_cookie_2", "range")
end

function snapfire_firesnap_cookie_custom_2:GetCastRange(vLocation, hTarget)
if IsServer() then return 999999 end 
return self:GetRange() - self:GetCaster():GetCastRangeBonus()
end

function snapfire_firesnap_cookie_custom:GetCastRange(vLocation, hTarget)
if IsServer() then return 999999 end 
return self:GetRange() - self:GetCaster():GetCastRangeBonus()
end

function snapfire_firesnap_cookie_custom:OnAbilityPhaseStart()
self:GetCaster():GenericParticle("particles/units/heroes/hero_snapfire/hero_snapfire_cookie_selfcast.vpcf")
return true
end

function snapfire_firesnap_cookie_custom_2:OnAbilityPhaseStart()
self:GetCaster():GenericParticle("particles/units/heroes/hero_snapfire/hero_snapfire_cookie_selfcast.vpcf")
return true
end

function snapfire_firesnap_cookie_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_snapfire_firesnap_cookie_custom_tracker"
end


function snapfire_firesnap_cookie_custom:UpdateJs()
local mod = self:GetCaster():FindModifierByName("modifier_snapfire_firesnap_cookie_custom_tracker")
if mod then
	mod:UpdateJs()
end

end


function snapfire_firesnap_cookie_custom:LaunchBomb(target, point)

local caster = self:GetCaster()
local cookie = CreateUnitByName("npc_snapfire_cookie_bomb", point, true, nil, nil, caster:GetTeamNumber())

local vector = point - target:GetAbsOrigin()
local direction = vector:Normalized()
local distance = vector:Length2D()
local speed = 1200

local info = 
{
    Target = cookie,
    Source = target,
    Ability = self,    
        
    EffectName ="particles/units/heroes/hero_snapfire/hero_snapfire_cookie_projectile.vpcf",
    iMoveSpeed = speed,
    bDodgeable = false,                           
    
    vSourceLoc = target:GetAttachmentOrigin(target:ScriptLookupAttachment("attach_hitloc")),                
        
    bDrawsOnMinimap = false,                          
    bVisibleToEnemies = true,                         
    bProvidesVision = true,                           
    iVisionRadius = 200,                              
    iVisionTeamNumber = caster:GetTeamNumber()       
}

ProjectileManager:CreateTrackingProjectile(info)

target:EmitSound("Snapfire.Bombs_activate")
cookie:AddNewModifier(caster, self, "modifier_snapfire_firesnap_cookie_custom_bomb_cookie", {interval = distance/speed})
end

function snapfire_firesnap_cookie_custom_2:OnSpellStart()
local caster = self:GetCaster()
local point = self:GetCursorPosition()
local ability = caster:FindAbilityByName("snapfire_firesnap_cookie_custom")

if not ability then return end

if point == caster:GetAbsOrigin() then 
	point = caster:GetAbsOrigin() +caster:GetForwardVector()*10
end
caster:AddNewModifier(caster, ability, "modifier_snapfire_firesnap_cookie_custom", {duration = self:GetSpecialValueFor("jump_duration"), x = point.x, y = point.y})
end


function snapfire_firesnap_cookie_custom:OnSpellStart()
local caster = self:GetCaster()
local point = self:GetCursorPosition()

if point == caster:GetAbsOrigin() then 
	point = caster:GetAbsOrigin() +caster:GetForwardVector()*10
end
caster:AddNewModifier(caster, self, "modifier_snapfire_firesnap_cookie_custom", {duration = self:GetSpecialValueFor("jump_duration"), x = point.x, y = point.y})
end





modifier_snapfire_firesnap_cookie_custom = class({})
function modifier_snapfire_firesnap_cookie_custom:IsHidden() return true end
function modifier_snapfire_firesnap_cookie_custom:IsPurgable()return false end
function modifier_snapfire_firesnap_cookie_custom:OnCreated( table )
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.anim_end = false

if not IsServer() then return end
self.point = GetGroundPosition(Vector(table.x, table.y, 0), nil)

self.duration = self:GetRemainingTime()
self.height = self.ability:GetSpecialValueFor( "jump_height" )
self.distance = self.ability:GetRange()
self.impact_stun_duration = self.ability:GetSpecialValueFor( "impact_stun_duration" ) + self.parent:GetTalentValue("modifier_snapfire_cookie_3", "stun")
self.impact_damage = self.ability:GetSpecialValueFor( "impact_damage" ) + self.parent:GetTalentValue("modifier_snapfire_cookie_1", "damage")
self.impact_radius = self.ability:GetSpecialValueFor( "impact_radius" )

if self.parent:HasTalent("modifier_snapfire_cookie_6") then
	self.impact_stun_duration = self.impact_stun_duration * (1 + self.parent:GetTalentValue("modifier_snapfire_cookie_6", "stun")/100)
	self.impact_damage = self.impact_damage * (1 + self.parent:GetTalentValue("modifier_snapfire_cookie_6", "damage")/100)
end

local speed = self.distance/self.duration

self.scatter_ability = self.parent:FindAbilityByName("snapfire_scatterblast_custom")
local ulti = self.parent:FindAbilityByName("snapfire_mortimer_kisses_custom")

local vec = self.point - self.parent:GetAbsOrigin()
vec.z = 0
local dir = vec:Normalized()

self.parent:SetForwardVector(dir)
self.parent:FaceTowards(self.parent:GetAbsOrigin() + dir*10)

self.distance = math.min(self.distance, math.max(200, vec:Length2D()))
self.height = math.min(250, self.distance*0.55)
self.duration = self.distance/speed

if self.parent:HasShard() then
	if ulti and ulti:IsTrained() then 
		ulti:LauchBall(self.parent:GetAbsOrigin() + self.parent:GetForwardVector()*self.distance, "shard")
	end
	self.parent:GenericHeal(self.parent:GetMaxHealth()*self.ability:GetSpecialValueFor("shard_heal")/100, self.ability, nil, nil, "shard")
end

self.parent:EmitSound("Hero_Snapfire.FeedCookie.Cast")
self.parent:EmitSound("Hero_Snapfire.FeedCookie.Consume")

self.mod = self.parent:AddNewModifier( self.parent, self.ability, "modifier_generic_arc", 
{ 
	distance = self.distance, 
	height = self.height, 
	duration = self.duration, 
	direction_x = self.parent:GetForwardVector().x, 
	direction_y = self.parent:GetForwardVector().y, 
    isStun = true,
})

self.parent:GenericParticle("particles/units/heroes/hero_snapfire/hero_snapfire_cookie_buff.vpcf")
self.parent:GenericParticle("particles/units/heroes/hero_snapfire/hero_snapfire_cookie_receive.vpcf", self)
self:StartIntervalThink(0.1)
end

function modifier_snapfire_firesnap_cookie_custom:OnIntervalThink()
if not IsServer() then return end

if not self.mod or self.mod:IsNull() then
	self:Destroy()
	return
end

if self:GetElapsedTime()/self.duration >= 0.8 and not self.anim_end then 
    self.anim_end = true
    self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2_END, 1.4)
end

end

function modifier_snapfire_firesnap_cookie_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
}
end

function modifier_snapfire_firesnap_cookie_custom:GetOverrideAnimation( params )
return ACT_DOTA_OVERRIDE_ABILITY_2
end

function modifier_snapfire_firesnap_cookie_custom:OnDestroy()
if not IsServer() then return end

if self.scatter_ability and self.scatter_ability:IsTrained() then

	if self.parent:HasTalent("modifier_snapfire_scatter_7") and self.scatter_ability:GetCooldownTimeRemaining() > 0 then 

		local particle = ParticleManager:CreateParticle("particles/sf_refresh_a.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
	   	ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
	   	ParticleManager:ReleaseParticleIndex(particle)

	    self.parent:EmitSound("Hero_Rattletrap.Overclock.Cast")
		self.scatter_ability:EndCd(0)
	end

	if self.parent:HasTalent("modifier_snapfire_scatter_6") then
		self.parent:CdItems(self.parent:GetTalentValue("modifier_snapfire_scatter_6", "cd_items"))
	end
end

if self.parent:HasTalent("modifier_snapfire_cookie_4") then 
	local vec = self.parent:GetForwardVector()
	vec.z = 0
	local dist = self.parent:GetTalentValue("modifier_snapfire_cookie_4", "distance")

	for i = 1, self.parent:GetTalentValue("modifier_snapfire_cookie_4", "count") do 
		vec = vec*-1
		self.ability:LaunchBomb(self.parent, self.parent:GetAbsOrigin() + vec*dist)
	end
end

if self.parent:HasTalent("modifier_snapfire_cookie_5") then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_snapfire_firesnap_cookie_custom_unslow", {duration = self.parent:GetTalentValue("modifier_snapfire_cookie_5", "unslow")})
	if not self.parent:HasModifier("modifier_snapfire_firesnap_cookie_custom_shield_cd") then
		self.parent:AddNewModifier(self.parent, self.ability, "modifier_snapfire_firesnap_cookie_custom_shield_cd", {duration = self.parent:GetTalentValue("modifier_snapfire_cookie_5", "cd")})
		self.parent:AddNewModifier(self.parent, self.ability, "modifier_snapfire_firesnap_cookie_custom_shield", {duration = self.parent:GetTalentValue("modifier_snapfire_cookie_5", "duration")})
	end
end

if self.parent:HasTalent("modifier_snapfire_cookie_2") then 
	self.parent:RemoveModifierByName("modifier_snapfire_firesnap_cookie_custom_speed")
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_snapfire_firesnap_cookie_custom_speed", {duration = self.parent:GetTalentValue("modifier_snapfire_cookie_2", "duration")})
end

local enemies = self.parent:FindTargets(self.impact_radius)


for _,enemy in pairs(enemies) do
	if enemy:IsRealHero() and self.parent:GetQuest() == "Snapfire.Quest_6" and not self.parent:QuestCompleted() then 
		self.parent:UpdateQuest(1)
	end
	DoDamage({ attacker = self.parent, victim = enemy, damage = self.impact_damage, damage_type = self.ability:GetAbilityDamageType(), ability = self.ability })
	enemy:AddNewModifier( self.parent, self.ability, "modifier_stunned", { duration = (1 - enemy:GetStatusResistance())* self.impact_stun_duration } )
end

GridNav:DestroyTreesAroundPoint( self.parent:GetOrigin(), self.impact_radius, true )

local land_particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_snapfire/hero_snapfire_cookie_landing.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( land_particle, 0, GetGroundPosition(self.parent:GetOrigin(), nil) )
ParticleManager:SetParticleControl( land_particle, 1, Vector( self.impact_radius, self.impact_radius, self.impact_radius ) )
ParticleManager:ReleaseParticleIndex( land_particle )

self.parent:EmitSound("Hero_Snapfire.FeedCookie.Impact")
end






modifier_snapfire_firesnap_cookie_custom_speed = class({})
function modifier_snapfire_firesnap_cookie_custom_speed:IsHidden() return false end
function modifier_snapfire_firesnap_cookie_custom_speed:GetTexture() return "buffs/chains_speed" end
function modifier_snapfire_firesnap_cookie_custom_speed:IsPurgable() return false end

function modifier_snapfire_firesnap_cookie_custom_speed:GetEffectName()
return "particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf"
end

function modifier_snapfire_firesnap_cookie_custom_speed:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end









modifier_snapfire_firesnap_cookie_custom_tracker = class({})
function modifier_snapfire_firesnap_cookie_custom_tracker:IsHidden() return true end
function modifier_snapfire_firesnap_cookie_custom_tracker:IsPurgable() return false end

function modifier_snapfire_firesnap_cookie_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.legendary_duration = self.parent:GetTalentValue("modifier_snapfire_cookie_7", "timer", true)
self.cd = self.parent:GetTalentValue("modifier_snapfire_cookie_7", "cd", true)
self.distance = self.parent:GetTalentValue("modifier_snapfire_cookie_7", "distance", true)
self.legendary_chance = self.parent:GetTalentValue("modifier_snapfire_cookie_7", "chance", true)

self.bomb_distance = self.parent:GetTalentValue("modifier_snapfire_cookie_4", "distance", true)
self.bomb_chance = self.parent:GetTalentValue("modifier_snapfire_cookie_4", "chance", true)

self.move_bonus = self.parent:GetTalentValue("modifier_snapfire_cookie_2", "bonus", true)

self.resist_duration = self.parent:GetTalentValue("modifier_snapfire_cookie_1", "duration", true)

self.parent:AddAttackEvent_out(self)
end

function modifier_snapfire_firesnap_cookie_custom_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
}
end

function modifier_snapfire_firesnap_cookie_custom_tracker:GetModifierMoveSpeedBonus_Constant()
if not self.parent:HasTalent("modifier_snapfire_cookie_2") then return end
local bonus = self.parent:GetTalentValue("modifier_snapfire_cookie_2", "move")
if self.parent:HasModifier("modifier_snapfire_firesnap_cookie_custom_speed") then
	bonus = self.move_bonus*bonus
end
return bonus
end

function modifier_snapfire_firesnap_cookie_custom_tracker:UpdateJs()
if not IsServer() then return end
if not self.parent:HasTalent("modifier_snapfire_cookie_7") then return end

local max = 1
local stack = 0
local use_zero = nil
local override_stack = nil
local active = 1
local mod = self.parent:FindModifierByName("modifier_snapfire_firesnap_cookie_custom_legendary_tracker")
if mod and mod.max then
	max = mod.max
	stack = mod:GetStackCount()
end
local cd = self.parent:FindModifierByName("modifier_snapfire_firesnap_cookie_custom_legendary_cd")
if cd and cd.max_time then
	max = cd.max_time
	stack = 0
	use_zero = 1
	active = 0
	override_stack = cd:GetRemainingTime()
end

self.parent:UpdateUIlong({max = max, stack = stack, use_zero = use_zero, no_min = 1, active = active, override_stack = override_stack, style = "SnapfireCookie"})
end


function modifier_snapfire_firesnap_cookie_custom_tracker:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
if params.no_attack_cooldown then return end

local target = params.target

if self.parent:HasTalent("modifier_snapfire_cookie_7") and not self.parent:HasModifier("modifier_snapfire_firesnap_cookie_custom_legendary_cd") then
	if RollPseudoRandomPercentage(self.legendary_chance, 1887, self.parent) then
		self:ProcLegendary(params.target)
	end
end

if self.parent:HasTalent("modifier_snapfire_cookie_4") and RollPseudoRandomPercentage(self.bomb_chance, 1886, self.parent) then
	local vec = target:GetAbsOrigin() + self.bomb_distance*(self.parent:GetAbsOrigin() - target:GetAbsOrigin()):Normalized()
	local point = RotatePosition(target:GetAbsOrigin(), QAngle(0, RandomInt(-75, 75), 0), vec)
	self.ability:LaunchBomb(target, point)
end

if self.parent:HasTalent("modifier_snapfire_cookie_1") then
	target:AddNewModifier(self.parent, self.ability, "modifier_snapfire_firesnap_cookie_custom_resist", {duration = self.resist_duration})
end

end


function modifier_snapfire_firesnap_cookie_custom_tracker:ProcLegendary(target)
if not IsServer() then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_snapfire_firesnap_cookie_custom_legendary_cd", {duration = self.cd})

local point = (	target:GetAbsOrigin() + RandomVector(self.distance))
local vector = point - target:GetAbsOrigin()
local direction = vector:Normalized()
local distance = vector:Length2D()
local speed = 1200

local cookie = CreateUnitByName("npc_snapfire_cookie", point, false, nil, nil, self.parent:GetTeamNumber())

local info = 
{
    Target = cookie,
    Source = target,
    Ability = nil,    
        
    EffectName ="particles/units/heroes/hero_snapfire/hero_snapfire_cookie_projectile.vpcf",
    iMoveSpeed = speed,
    bDodgeable = false,
    
    vSourceLoc = self:GetCaster():GetAttachmentOrigin(self:GetCaster():ScriptLookupAttachment("attach_hitloc")),
        
    bDrawsOnMinimap = false,
    bVisibleToEnemies = true, 
    bProvidesVision = true,
    iVisionRadius = 200,
    iVisionTeamNumber = self.parent:GetTeamNumber()       
}

ProjectileManager:CreateTrackingProjectile(info)

target:EmitSound("Snapfire.Cookie_legendary")
target:EmitSound("Snapfire.Cookie_legendary_proc")

local is_hero = 0
if target:IsRealHero() then
	is_hero = 1
end
cookie:AddNewModifier(self.parent, self.ability, "modifier_snapfire_firesnap_cookie_custom_cookie", {duration = 12, is_hero = is_hero, interval = distance/speed})
end




modifier_snapfire_firesnap_cookie_custom_legendary_tracker = class({})
function modifier_snapfire_firesnap_cookie_custom_legendary_tracker:IsHidden() return true end
function modifier_snapfire_firesnap_cookie_custom_legendary_tracker:IsPurgable() return false end
function modifier_snapfire_firesnap_cookie_custom_legendary_tracker:RemoveOnDeath() return false end
function modifier_snapfire_firesnap_cookie_custom_legendary_tracker:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.parent:GetTalentValue("modifier_snapfire_cookie_7", "max")
self.cd = self.parent:GetTalentValue("modifier_snapfire_cookie_7", "cd")
self.distance = self.parent:GetTalentValue("modifier_snapfire_cookie_7", "distance")

self:SetStackCount(1)
end

function modifier_snapfire_firesnap_cookie_custom_legendary_tracker:OnRefresh(table)
if not IsServer() then return end
self:IncrementStackCount()

if self:GetStackCount() < self.max then return end

local target = EntIndexToHScript(table.target)
if not target then
	target = self.parent
end

self.ability:ProcLegendary(target)
self:Destroy()
end

function modifier_snapfire_firesnap_cookie_custom_legendary_tracker:OnStackCountChanged(iStackCount)
if not IsServer() then return end
self.ability:UpdateJs()
end

function modifier_snapfire_firesnap_cookie_custom_legendary_tracker:OnDestroy()
if not IsServer() then return end
self.ability:UpdateJs()
end




modifier_snapfire_firesnap_cookie_custom_cookie = class({})
function modifier_snapfire_firesnap_cookie_custom_cookie:IsHidden() return true end
function modifier_snapfire_firesnap_cookie_custom_cookie:IsPurgable() return false end
function modifier_snapfire_firesnap_cookie_custom_cookie:CheckState()
return
{
  [MODIFIER_STATE_INVULNERABLE] = true,
  [MODIFIER_STATE_UNSELECTABLE] = true,
  [MODIFIER_STATE_OUT_OF_GAME] = true,
  [MODIFIER_STATE_NO_HEALTH_BAR] = true,
  [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
  [MODIFIER_STATE_UNTARGETABLE] = true,
}
end

function modifier_snapfire_firesnap_cookie_custom_cookie:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.parent:SetAbsOrigin(self.parent:GetAbsOrigin() + Vector(0,0,25))

self.is_hero = table.is_hero

self.particle_ally_fx = ParticleManager:CreateParticleForTeam("particles/alch_stun_legendary.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, self.parent:GetTeamNumber())
ParticleManager:SetParticleControl(self.particle_ally_fx, 0, self.parent:GetAbsOrigin())
self:AddParticle(self.particle_ally_fx, false, false, -1, false, false) 

self.start = true 
self.parent:AddNoDraw()

self.radius = self.caster:GetTalentValue("modifier_snapfire_cookie_7", "radius")
self:StartIntervalThink(table.interval)
end


function modifier_snapfire_firesnap_cookie_custom_cookie:OnIntervalThink()
if not IsServer() then return end
if not self.caster or self.caster:IsNull() then return end

if self.start == true then 
	self.start = false
	self.parent:RemoveNoDraw()
end

AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), 200, 0.2, false)

if (self.parent:GetAbsOrigin() - self.caster:GetAbsOrigin()):Length2D() <= self.radius 
  and self.caster:IsAlive() and not self.caster:HasModifier("modifier_snapfire_firesnap_cookie_custom") then 

	local particle = ParticleManager:CreateParticle("particles/sf_refresh_a.vpcf", PATTACH_CUSTOMORIGIN, self.caster)
   	ParticleManager:SetParticleControlEnt( particle, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", self.caster:GetOrigin(), true )
   	ParticleManager:ReleaseParticleIndex(particle)

   	if self.is_hero == 1 then
   		self.caster:AddNewModifier(self.caster, self.ability, "modifier_snapfire_firesnap_cookie_custom_legendary_speed", {})
   	end

   	if self.caster:HasTalent("modifier_snapfire_cookie_6") then
   		local ability = self.caster:FindAbilityByName("snapfire_firesnap_cookie_custom_2")
   		if ability then
   			ability:AddCharge(1)
   		end
   	else
   		self.ability:EndCd(0)
    end
    self.caster:EmitSound("Snapfire.Cookie_legendary_activate")
    self.caster:EmitSound("Hero_Rattletrap.Overclock.Cast")	
  	self:Destroy()
end

self:StartIntervalThink(FrameTime())
end


function modifier_snapfire_firesnap_cookie_custom_cookie:OnDestroy()
if not IsServer() then return end

local part = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_disguise.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(part, 0, self.parent:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(part)

self.parent:EmitSound("Hero_MonkeyKing.Transform.On")
UTIL_Remove(self.parent)
end



modifier_snapfire_firesnap_cookie_custom_legendary_speed = class({})
function modifier_snapfire_firesnap_cookie_custom_legendary_speed:IsHidden() return false end
function modifier_snapfire_firesnap_cookie_custom_legendary_speed:IsPurgable() return false end
function modifier_snapfire_firesnap_cookie_custom_legendary_speed:RemoveOnDeath() return false end
function modifier_snapfire_firesnap_cookie_custom_legendary_speed:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.speed = self.parent:GetTalentValue("modifier_snapfire_cookie_7", "speed")
self.max = self.parent:GetTalentValue("modifier_snapfire_cookie_7", "max_speed")
if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_snapfire_firesnap_cookie_custom_legendary_speed:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max then
	self.parent:GenericParticle("particles/lc_odd_proc_.vpcf")
	self.parent:EmitSound("BS.Thirst_legendary_active")
end

end

function modifier_snapfire_firesnap_cookie_custom_legendary_speed:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_snapfire_firesnap_cookie_custom_legendary_speed:GetModifierAttackSpeedBonus_Constant()
return self.speed*self:GetStackCount()
end






modifier_snapfire_firesnap_cookie_custom_bomb_cookie = class({})
function modifier_snapfire_firesnap_cookie_custom_bomb_cookie:IsHidden() return true end
function modifier_snapfire_firesnap_cookie_custom_bomb_cookie:IsPurgable() return false end
function modifier_snapfire_firesnap_cookie_custom_bomb_cookie:CheckState()
return
{
  [MODIFIER_STATE_INVULNERABLE] = true,
  [MODIFIER_STATE_UNSELECTABLE] = true,
  [MODIFIER_STATE_OUT_OF_GAME] = true,
  [MODIFIER_STATE_NO_HEALTH_BAR] = true,
  [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
  [MODIFIER_STATE_UNTARGETABLE] = true,
}
end

function modifier_snapfire_firesnap_cookie_custom_bomb_cookie:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.start = true 
self.parent:AddNoDraw()

self.aoe = self.caster:GetTalentValue("modifier_snapfire_cookie_4", "radius")
self.bomb_timer = self.caster:GetTalentValue("modifier_snapfire_cookie_4", "timer")
self.damage = self.caster:GetTalentValue("modifier_snapfire_cookie_4", "damage")/100
self.damage_creeps = self.caster:GetTalentValue("modifier_snapfire_cookie_4", "damage_creeps")
self.duration = self.caster:GetTalentValue("modifier_snapfire_cookie_4", "duration")

self.timer = self.bomb_timer*2
self.t = 0
self:StartIntervalThink(table.interval)
end

function modifier_snapfire_firesnap_cookie_custom_bomb_cookie:OnIntervalThink()
if not IsServer() then return end

self.parent:SetRenderColor(255, 255 * (self.bomb_timer - self:GetElapsedTime() / self.bomb_timer ), 255 * (self.bomb_timer - self:GetElapsedTime() / self.bomb_timer ))

if self.start == true then 
	self.start = false
	self.parent:RemoveNoDraw()
end

if self.t == self.timer then 
	self:Destroy()
end

local number = (self.timer-self.t)/2 
local int = number

if number % 1 ~= 0 then 
    int = number - 0.5  
end

local digits = math.floor(math.log10(number)) + 2
local decimal = number % 1

if decimal == 0.5 then
    decimal = 8
else 
    decimal = 1
end

if not self.parent or self.parent:IsNull() then
	self:Destroy()
	return
end

local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_timer.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(particle, 1, Vector(0, int, decimal))
ParticleManager:SetParticleControl(particle, 2, Vector(digits, 0, 0))
ParticleManager:ReleaseParticleIndex(particle)

self.t = self.t + 1

AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), 200, 0.5, false)
self:StartIntervalThink(0.5)
end


function modifier_snapfire_firesnap_cookie_custom_bomb_cookie:OnDestroy()
if not IsServer() then return end

for _,enemy in pairs(self.caster:FindTargets(self.aoe, self.parent:GetAbsOrigin())) do
	local damage = self.damage*enemy:GetMaxHealth()
	if enemy:IsCreep() then 
		damage = self.damage_creeps
	end

	local real_damage = DoDamage({ attacker = self.caster, victim = enemy, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability }, "modifier_snapfire_cookie_4")
	enemy:SendNumber(4, real_damage)
	enemy:AddNewModifier( self.caster, self.ability, "modifier_snapfire_firesnap_cookie_custom_bomb_slow", { duration = (1 - enemy:GetStatusResistance())*self.duration} )
end

self.parent:EmitSound("Snapfire.Shredder_silence")
local effect_cast = ParticleManager:CreateParticle( "particles/items3_fx/black_powder_bag.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( effect_cast, 0,  self.parent:GetOrigin() )
ParticleManager:SetParticleControl( effect_cast, 1, self.parent:GetOrigin() )
ParticleManager:SetParticleControl( effect_cast, 5, self.parent:GetOrigin() )
ParticleManager:ReleaseParticleIndex(effect_cast)

UTIL_Remove(self.parent)
end



modifier_snapfire_firesnap_cookie_custom_bomb_slow = class({})
function modifier_snapfire_firesnap_cookie_custom_bomb_slow:IsHidden() return true end
function modifier_snapfire_firesnap_cookie_custom_bomb_slow:IsPurgable() return true end
function modifier_snapfire_firesnap_cookie_custom_bomb_slow:OnCreated(table)
self.slow = self:GetCaster():GetTalentValue("modifier_snapfire_cookie_4", "slow")
if not IsServer() then return end
self:GetParent():GenericParticle("particles/units/heroes/hero_sniper/sniper_headshot_slow.vpcf", self, true)
end

function modifier_snapfire_firesnap_cookie_custom_bomb_slow:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_snapfire_firesnap_cookie_custom_bomb_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end





modifier_snapfire_firesnap_cookie_custom_resist = class({})
function modifier_snapfire_firesnap_cookie_custom_resist:IsHidden() return false end
function modifier_snapfire_firesnap_cookie_custom_resist:IsPurgable() return false end
function modifier_snapfire_firesnap_cookie_custom_resist:GetTexture() return "buffs/cookie_damage" end
function modifier_snapfire_firesnap_cookie_custom_resist:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.max = self.caster:GetTalentValue("modifier_snapfire_cookie_1", "max")
self.resist = self.caster:GetTalentValue("modifier_snapfire_cookie_1", "resist")
self:SetStackCount(1)
end

function modifier_snapfire_firesnap_cookie_custom_resist:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_snapfire_firesnap_cookie_custom_resist:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_snapfire_firesnap_cookie_custom_resist:GetModifierMagicalResistanceBonus()
return self:GetStackCount()*self.resist
end




modifier_snapfire_firesnap_cookie_custom_legendary_cd = class({})
function modifier_snapfire_firesnap_cookie_custom_legendary_cd:IsHidden() return true end
function modifier_snapfire_firesnap_cookie_custom_legendary_cd:IsPurgable() return false end
function modifier_snapfire_firesnap_cookie_custom_legendary_cd:OnCreated(table)
self.ability = self:GetAbility()
self.max_time = self:GetRemainingTime()

if not IsServer() then return end
--self:OnIntervalThink()
--self:StartIntervalThink(0.1)
end

function modifier_snapfire_firesnap_cookie_custom_legendary_cd:OnIntervalThink()
if not IsServer() then return end
--self.ability:UpdateJs()
end

function modifier_snapfire_firesnap_cookie_custom_legendary_cd:OnDestroy()
if not IsServer() then return end
--self.ability:UpdateJs()
end




modifier_snapfire_firesnap_cookie_custom_unslow = class({})
function modifier_snapfire_firesnap_cookie_custom_unslow:IsHidden() return true end
function modifier_snapfire_firesnap_cookie_custom_unslow:IsPurgable() return false end
function modifier_snapfire_firesnap_cookie_custom_unslow:CheckState()
return
{
	[MODIFIER_STATE_UNSLOWABLE] = true
}
end



modifier_snapfire_firesnap_cookie_custom_shield_cd = class({})
function modifier_snapfire_firesnap_cookie_custom_shield_cd:IsHidden() return false end
function modifier_snapfire_firesnap_cookie_custom_shield_cd:IsPurgable() return false end
function modifier_snapfire_firesnap_cookie_custom_shield_cd:RemoveOnDeath() return false end
function modifier_snapfire_firesnap_cookie_custom_shield_cd:IsDebuff() return true end
function modifier_snapfire_firesnap_cookie_custom_shield_cd:GetTexture() return "buffs/berserker_armor" end
function modifier_snapfire_firesnap_cookie_custom_shield_cd:OnCreated()
self.RemoveForDuel = true
end





modifier_snapfire_firesnap_cookie_custom_shield = class({})
function modifier_snapfire_firesnap_cookie_custom_shield:IsHidden() return true end
function modifier_snapfire_firesnap_cookie_custom_shield:IsPurgable() return false end
function modifier_snapfire_firesnap_cookie_custom_shield:OnCreated(table)
self.parent = self:GetParent()
self.shield_talent = "modifier_snapfire_cookie_5"
self.max_shield = self.parent:GetTalentValue("modifier_snapfire_cookie_5", "shield")*self.parent:GetMaxHealth()/100

if not IsServer() then return end

self.parent:EmitSound("Snapfire.Cookie_shield")
self.particle = ParticleManager:CreateParticle("particles/snapfire/cookie_shield.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(self.particle, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetAbsOrigin(), true)
self:AddParticle(self.particle, false, false, -1, false, false)

self.RemoveForDuel = true
self:SetStackCount(self.max_shield)
end

function modifier_snapfire_firesnap_cookie_custom_shield:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end

function modifier_snapfire_firesnap_cookie_custom_shield:GetModifierIncomingDamageConstant( params )

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