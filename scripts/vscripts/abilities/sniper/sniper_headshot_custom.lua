--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_sniper_headshot_custom", "abilities/sniper/sniper_headshot_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_headshot_custom_slow", "abilities/sniper/sniper_headshot_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_headshot_custom_shield", "abilities/sniper/sniper_headshot_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_headshot_custom_shield_cd", "abilities/sniper/sniper_headshot_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_headshot_custom_vision", "abilities/sniper/sniper_headshot_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_headshot_custom_invis", "abilities/sniper/sniper_headshot_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_headshot_custom_legendary_effect", "abilities/sniper/sniper_headshot_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_headshot_custom_legendary_agility", "abilities/sniper/sniper_headshot_custom", LUA_MODIFIER_MOTION_NONE )


sniper_headshot_custom = class({})


function sniper_headshot_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/sniper_legendary_attacka.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sniper/sniper_headshot_slow.vpcf", context )
PrecacheResource( "particle","particles/sniper_legendary_attack.vpcf", context )
PrecacheResource( "particle","particles/general/generic_armor_reduction.vpcf", context )
PrecacheResource( "particle","particles/items4_fx/ascetic_cap.vpcf", context )
PrecacheResource( "particle","particles/sniper/headshot_cleave.vpcf", context )
PrecacheResource( "particle","particles/sniper/headshot_legendary_radius.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_juggernaut/jugg_agility_boost.vpcf", context )
PrecacheResource( "particle","particles/hoodwink_head.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_bounty_hunter/bounty_hunter_windwalk.vpcf", context )

end




function sniper_headshot_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_sniper_headshot_custom"
end

function sniper_headshot_custom:GetCooldown(iLevel)
if self:GetCaster():HasTalent("modifier_sniper_headshot_7") then  
	return self:GetCaster():GetTalentValue("modifier_sniper_headshot_7", "cd")
end 
return 
end

function sniper_headshot_custom:GetBehavior()
if self:GetCaster():HasTalent("modifier_sniper_headshot_7") then 
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end
return DOTA_ABILITY_BEHAVIOR_PASSIVE
end



function sniper_headshot_custom:OnSpellStart()

local caster = self:GetCaster()
caster:RemoveModifierByName("modifier_sniper_headshot_custom_legendary_agility")
caster:AddNewModifier(caster, self, "modifier_sniper_headshot_custom_invis", {duration = caster:GetTalentValue("modifier_sniper_headshot_7", "invis")})

local particle_aoe_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_bounty_hunter/bounty_hunter_windwalk.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl( particle_aoe_fx, 0, caster:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(particle_aoe_fx) 

caster:EmitSound("Sniper.Aim_legendary_cast")
end






modifier_sniper_headshot_custom = class({})
function modifier_sniper_headshot_custom:IsHidden() return self:GetStackCount() == 1 or not self:GetCaster():HasTalent("modifier_sniper_headshot_3") end
function modifier_sniper_headshot_custom:IsPurgable() return false end

function modifier_sniper_headshot_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
    MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_EVASION_CONSTANT,
    MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
    MODIFIER_PROPERTY_HEALTH_BONUS,
    MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
    MODIFIER_PROPERTY_MIN_HEALTH
}
end

function modifier_sniper_headshot_custom:GetModifierHealthBonus()
if not self.parent:HasTalent("modifier_sniper_headshot_5") then return end
return self.health_bonus*self.parent:GetAgility()
end

function modifier_sniper_headshot_custom:GetModifierAttackRangeBonus()
if not self.parent:HasTalent("modifier_sniper_headshot_4") then return end
return self.parent:GetTalentValue("modifier_sniper_headshot_4", "range")
end

function modifier_sniper_headshot_custom:GetModifierTotalDamageOutgoing_Percentage(params)
if not self.parent:HasTalent("modifier_sniper_headshot_4") then return end
if not params.target:IsUnit() then return end

local damage = self.parent:GetTalentValue("modifier_sniper_headshot_4", "damage")
local dist = (params.target:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D()
damage = math.min(1, dist/self.damage_range)*damage

return damage
end

function modifier_sniper_headshot_custom:GetModifierMoveSpeedBonus_Constant()
if not self.parent:HasTalent("modifier_sniper_headshot_3") then return end
local bonus = self.parent:GetTalentValue("modifier_sniper_headshot_3", "move")
if self:GetStackCount() == 0 then
	bonus = bonus*self.move_bonus
end
return bonus
end

function modifier_sniper_headshot_custom:GetModifierEvasion_Constant()
if not self.parent:HasTalent("modifier_sniper_headshot_3") then return end
local bonus = self.parent:GetTalentValue("modifier_sniper_headshot_3", "evasion")
if self:GetStackCount() == 0 then
	bonus = bonus*self.move_bonus
end
return bonus
end

function modifier_sniper_headshot_custom:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.chance = self.ability:GetSpecialValueFor("proc_chance")
self.knockback_dist = self.ability:GetSpecialValueFor("knockback_distance")
self.damage = self.ability:GetSpecialValueFor("damage")
self.slow_duration = self.ability:GetSpecialValueFor("slow_duration")

self.move_bonus = self.caster:GetTalentValue("modifier_sniper_headshot_3", "bonus", true)
self.move_radius = self.caster:GetTalentValue("modifier_sniper_headshot_3", "radius", true)

self.cleave_radius = self.parent:GetTalentValue("modifier_sniper_headshot_1", "radius", true)

self.damage_range = self.parent:GetTalentValue("modifier_sniper_headshot_4", "distance", true)

self.health_bonus = self.parent:GetTalentValue("modifier_sniper_headshot_5", "health", true)
self.health_thresh = self.parent:GetTalentValue("modifier_sniper_headshot_5", "thresh", true)
self.health_cd = self.parent:GetTalentValue("modifier_sniper_headshot_5", "cd", true)
self.health_duration = self.parent:GetTalentValue("modifier_sniper_headshot_5", "duration", true)

self.vision_duration = self.parent:GetTalentValue("modifier_sniper_headshot_6", "vision", true) 

self.armor_duration = self.parent:GetTalentValue("modifier_sniper_aim_4", "duration", true)

self.max_range = self.parent:GetTalentValue("modifier_sniper_headshot_7", "radius", true)
self.agi_duration = self.parent:GetTalentValue("modifier_sniper_headshot_7", "agi_duration", true)

if self.parent:IsRealHero() then
	self.parent:AddDamageEvent_out(self)
	self.parent:AddDamageEvent_inc(self)
	self.parent:AddAttackEvent_out(self)
end

if not IsServer() then return end
self:StartIntervalThink(1)
end

function modifier_sniper_headshot_custom:OnRefresh()
self.chance = self.ability:GetSpecialValueFor("proc_chance")
self.knockback_dist = self.ability:GetSpecialValueFor("knockback_distance")
self.damage = self.ability:GetSpecialValueFor("damage")
self.slow_duration = self.ability:GetSpecialValueFor("slow_duration")
end


function modifier_sniper_headshot_custom:OnIntervalThink()
if not IsServer() then return end
if not self.parent:HasTalent("modifier_sniper_headshot_3") then return end
if not self.parent:IsAlive() then return end

local targets = self.parent:FindTargets(self.move_radius)
if #targets > 0 then
	self:SetStackCount(0)
else
	self:SetStackCount(1)
end

self:StartIntervalThink(0.2)
end

function modifier_sniper_headshot_custom:GetMinHealth()
if not IsServer() then return end
if not self.parent:IsAlive() then return end
if not self.parent:HasTalent("modifier_sniper_headshot_5") then return end
if self.parent:PassivesDisabled() then return end
if self.parent:LethalDisabled() then return end
if self.parent:HasModifier("modifier_sniper_headshot_custom_shield_cd") then return end

return 1
end

function modifier_sniper_headshot_custom:DamageEvent_out(params)
if not IsServer() then return end 

if self.parent:HasTalent("modifier_sniper_headshot_1") and self.parent == params.attacker and params.unit:IsUnit() and self.record and params.record == self.record then 
	local damage = params.original_damage*self.parent:GetTalentValue("modifier_sniper_headshot_1", "cleave")/100
	for _,target in pairs(self.parent:FindTargets(self.cleave_radius, params.unit:GetAbsOrigin())) do
		if target ~= params.unit then 
			DoDamage({victim = target, attacker = self.parent, ability = self.ability, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK}, "modifier_sniper_headshot_1")
		end 
	end 

	local particle = ParticleManager:CreateParticle("particles/sniper/headshot_cleave.vpcf", PATTACH_WORLDORIGIN, nil)	
	ParticleManager:SetParticleControl(particle, 0, params.unit:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)
end

end

function modifier_sniper_headshot_custom:DamageEvent_inc(params)
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_sniper_headshot_5") then return end
if self.parent ~= params.unit then return end
if self.parent:PassivesDisabled() then return end
if self.parent:HasModifier("modifier_death") then return end
if self.parent:HasModifier("modifier_sniper_headshot_custom_shield_cd") then return end
if self.parent:GetHealthPercent() > self.health_thresh then return end

self.parent:Purge(false, true, false, false, false)

self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_sniper_headshot_custom_shield", {duration = self.health_duration})
self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_sniper_headshot_custom_shield_cd", {duration = self.health_cd})
end




function modifier_sniper_headshot_custom:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

if self.parent:HasTalent("modifier_sniper_headshot_6") then
	params.target:AddNewModifier(self.parent, self.ability, "modifier_sniper_headshot_custom_vision", {duration = self.vision_duration})
end

if self.parent:HasModifier("modifier_sniper_headshot_custom_legendary_effect") 
	and (self.parent:GetAbsOrigin() - params.target:GetAbsOrigin()):Length2D() >= self.max_range then

	self.parent:AddNewModifier(self.parent, self.ability, "modifier_sniper_headshot_custom_legendary_agility", {duration = self.agi_duration})
end

end




function modifier_sniper_headshot_custom:GetModifierProcAttack_BonusDamage_Physical(params)
if not IsServer() then return end

local target = params.target
self.record = nil

if not self.caster:IsRealHero() then return end
if self.caster:PassivesDisabled() then return 0 end
if not target:IsUnit() then return end
if target:IsDebuffImmune() and not self.parent:HasTalent("modifier_sniper_headshot_6") then return end

local chance = self.chance + self.caster:GetTalentValue("modifier_sniper_headshot_2", "chance")

if not self.parent:HasModifier("modifier_sniper_take_aim_custom_active") or self.parent:HasTalent("modifier_sniper_aim_7") then 
	if not RollPseudoRandomPercentage(chance,267,self.parent) then 
		return 
	end
end

self.record = params.record

local knockback_dist = self.knockback_dist + self.caster:GetTalentValue("modifier_sniper_headshot_2", "distance")
local damage = self.damage + self.caster:GetTalentValue("modifier_sniper_headshot_1", "damage")*self.caster:GetAgility()/100
local slow_duration = self.slow_duration + self.parent:GetTalentValue("modifier_sniper_headshot_6", "duration")

if target:IsRealHero() and not self.parent:QuestCompleted() and self.parent:GetQuest() == "Sniper.Quest_6" then 
	self.parent:UpdateQuest(1)
end

target:AddNewModifier(self.parent, self.parent:BkbAbility(self.ability, self.parent:HasTalent("modifier_sniper_headshot_6")), "modifier_sniper_headshot_custom_slow", { duration = slow_duration*(1 - target:GetStatusResistance())})

local dist = (target:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D()
knockback_dist = math.max(5, (1 - dist/800)*knockback_dist)

local knockback =	
{
    should_stun = 0,
    knockback_duration = 0.1,
    duration = 0.1,
    knockback_distance = knockback_dist,
    knockback_height = 0,
    center_x = self.parent:GetAbsOrigin().x,
    center_y = self.parent:GetAbsOrigin().y,
    center_z = self.parent:GetAbsOrigin().z,
}

if not target:IsCurrentlyHorizontalMotionControlled() and not target:IsCurrentlyVerticalMotionControlled() and not target:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then 
	target:AddNewModifier(self.parent, self.parent:BkbAbility(self.ability, self.parent:HasTalent("modifier_sniper_headshot_6")), "modifier_knockback", knockback)
end 

if self.parent:HasTalent("modifier_sniper_aim_4") and 
	(self.parent:HasModifier("modifier_sniper_take_aim_custom_active") or self.parent:HasModifier("modifier_sniper_take_aim_custom_legendary_damage")) then 

	params.target:AddNewModifier(self.parent, self.parent:BkbAbility(nil, true), "modifier_sniper_take_aim_custom_armor", {duration = self.armor_duration})
end

return damage
end



modifier_sniper_headshot_custom_slow = class({})

function modifier_sniper_headshot_custom_slow:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
}
end

function modifier_sniper_headshot_custom_slow:OnCreated(table)

self.ability = self:GetCaster():FindAbilityByName("sniper_headshot_custom")
if not self.ability then 
	self:Destroy()
	return 
end

self.move =  self.ability:GetSpecialValueFor("slow")
self.attack =  self.ability:GetSpecialValueFor("slow")
end

function modifier_sniper_headshot_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.move
end

function modifier_sniper_headshot_custom_slow:GetModifierAttackSpeedBonus_Constant()
return self.attack
end

function modifier_sniper_headshot_custom_slow:GetEffectName()
return "particles/units/heroes/hero_sniper/sniper_headshot_slow.vpcf"
end

function modifier_sniper_headshot_custom_slow:GetEffectAttachType()
return PATTACH_OVERHEAD_FOLLOW
end



modifier_sniper_headshot_custom_shield = class({})
function modifier_sniper_headshot_custom_shield:IsHidden() return false end
function modifier_sniper_headshot_custom_shield:IsPurgable() return false end
function modifier_sniper_headshot_custom_shield:GetTexture() return "buffs/back_ground" end
function modifier_sniper_headshot_custom_shield:OnCreated()

self.parent = self:GetParent()

self.shield_talent = "modifier_sniper_headshot_5"
self.max_shield = self.parent:GetMaxHealth()*self.parent:GetTalentValue("modifier_sniper_headshot_5", "shield")/100
self:SetStackCount(self.max_shield)

if not IsServer() then return end

self.parent:EmitSound("Sniper.Aim_shield")
self.parent:EmitSound("Sniper.Aim_shield2")
local position = self.parent:GetAbsOrigin()

self.particle = ParticleManager:CreateParticle("particles/sniper_matrix.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(  self.particle, 0, self.parent, PATTACH_CENTER_FOLLOW , nil, self.parent:GetOrigin(), true )
ParticleManager:SetParticleControlEnt(self.particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", position, true)
self:AddParticle(self.particle, false, false, -1, false, false)
end

function modifier_sniper_headshot_custom_shield:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_REFLECT_SPELL,
	MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end

function modifier_sniper_headshot_custom_shield:GetModifierIncomingDamageConstant( params )
if IsClient() then 
	if params.report_max then 
		return self.max_shield 
	else 
		return self:GetStackCount()
	end
end

if not IsServer() then return end
if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) == DOTA_DAMAGE_FLAG_HPLOSS then return end

self.parent:EmitSound("Sniper.Aim_shield_damage")

local forward = self.parent:GetAbsOrigin() - params.attacker:GetAbsOrigin()
forward.z = 0
forward = forward:Normalized()

local particle_2 = ParticleManager:CreateParticle("particles/sniper_shield_hit.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
ParticleManager:SetParticleControlEnt(particle_2, 0, self.parent, PATTACH_POINT, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControl(particle_2, 1, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControlForward(particle_2, 1, forward)
ParticleManager:SetParticleControlEnt(particle_2, 2, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetAbsOrigin(), false)
ParticleManager:ReleaseParticleIndex(particle_2)

local damage = math.min(params.damage, self:GetStackCount())
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self:SetStackCount(self:GetStackCount() - damage)
if self:GetStackCount() <= 0 then
  self:Destroy()
end

return -damage
end


modifier_sniper_headshot_custom_shield_cd = class({})
function modifier_sniper_headshot_custom_shield_cd:IsHidden() return false end
function modifier_sniper_headshot_custom_shield_cd:IsPurgable() return false end
function modifier_sniper_headshot_custom_shield_cd:GetTexture() return "buffs/back_ground" end
function modifier_sniper_headshot_custom_shield_cd:IsDebuff() return true end
function modifier_sniper_headshot_custom_shield_cd:RemoveOnDeath() return false end
function modifier_sniper_headshot_custom_shield_cd:OnCreated(table)
self.RemoveForDuel = true
end



modifier_sniper_headshot_custom_vision = class({})
function modifier_sniper_headshot_custom_vision:IsHidden() return true end
function modifier_sniper_headshot_custom_vision:IsPurgable() return false end
function modifier_sniper_headshot_custom_vision:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self:StartIntervalThink(0.2)
end

function modifier_sniper_headshot_custom_vision:OnIntervalThink()
if not IsServer() then return end 

AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), 10, 0.2, false)
end



modifier_sniper_headshot_custom_invis = class({})
function modifier_sniper_headshot_custom_invis:IsPurgable() return false end
function modifier_sniper_headshot_custom_invis:IsHidden() return false end
function modifier_sniper_headshot_custom_invis:GetTexture() return "buffs/reflection_speed" end
function modifier_sniper_headshot_custom_invis:OnCreated(table)

self.parent = self:GetParent()
self.parent:AddSpellEvent(self)

self.ability = self:GetAbility()
self.speed = self.parent:GetTalentValue("modifier_sniper_headshot_7", "speed")

self.parent:AddAttackStartEvent_out(self)
if not IsServer() then return end
self.RemoveForDuel = true
self.ability:EndCd()
end

function modifier_sniper_headshot_custom_invis:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_sniper_headshot_custom_invis:SpellEvent( params )
if not IsServer() then return end
if not params.ability then return end
if not params.unit then return end
if params.unit ~= self.parent then return end

self:Destroy()
end

function modifier_sniper_headshot_custom_invis:AttackStartEvent_out(params)
if not IsServer() then return end
if not params.attacker then return end
if params.attacker ~= self.parent then return end

self:Destroy()
end

function modifier_sniper_headshot_custom_invis:GetModifierMoveSpeedBonus_Percentage()
return self.speed
end

function modifier_sniper_headshot_custom_invis:GetModifierInvisibilityLevel()
return 1
end

function modifier_sniper_headshot_custom_invis:CheckState()
return 
{
    [MODIFIER_STATE_INVISIBLE] = true,
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true
}
end

function modifier_sniper_headshot_custom_invis:GetEffectName() 
return "particles/items3_fx/blink_swift_buff.vpcf" 
end

function modifier_sniper_headshot_custom_invis:OnDestroy()
if not IsServer() then return end
local mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_sniper_headshot_custom_legendary_effect", {duration = self.parent:GetTalentValue("modifier_sniper_headshot_7", "duration")})

if not mod then
	self.ability:StartCd()
end

end


modifier_sniper_headshot_custom_legendary_effect = class({})
function modifier_sniper_headshot_custom_legendary_effect:IsHidden() return true end
function modifier_sniper_headshot_custom_legendary_effect:IsPurgable() return false end
function modifier_sniper_headshot_custom_legendary_effect:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if not IsServer() then return end

self.RemoveForDuel = true
self.agi = self.parent:GetTalentValue("modifier_sniper_headshot_7", "agi")
self.max_range = self.parent:GetTalentValue("modifier_sniper_headshot_7", "radius")

self.radius_visual = ParticleManager:CreateParticleForPlayer("particles/sniper/headshot_legendary_radius.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, self.caster:GetPlayerOwner())
ParticleManager:SetParticleControl(self.radius_visual, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.radius_visual, 1, Vector(self.max_range, 0, 0))
self:AddParticle(self.radius_visual, false, false, -1, false, false)

self.parent:EmitSound("Sniper.Aim_attack")
self.parent:GenericParticle("particles/hoodwink_head.vpcf", self, true)

self.max_time = self:GetRemainingTime()

self:OnIntervalThink()
self:StartIntervalThink(0.1)
end

function modifier_sniper_headshot_custom_legendary_effect:OnIntervalThink()
if not IsServer() then return end

local stack = "+0%"

local mod = self.parent:FindModifierByName("modifier_sniper_headshot_custom_legendary_agility")

if mod then
	stack = "+"..tostring(math.floor(mod:GetStackCount()*self.agi)).."%"
end

self.parent:UpdateUIshort({time = self:GetElapsedTime(), max_time = self.max_time, stack = stack, style = "SniperHeadshot"})
end

function modifier_sniper_headshot_custom_legendary_effect:OnDestroy()
if not IsServer() then return end

local mod = self.parent:FindModifierByName("modifier_sniper_headshot_custom_legendary_agility")
if mod then
	mod:SetDuration(self.parent:GetTalentValue("modifier_sniper_headshot_7", "agi_duration"), true)
	mod:OnIntervalThink()
else
	self.parent:UpdateUIshort({hide = 1, style = "SniperHeadshot"})
end

self.ability:StartCd()
end


modifier_sniper_headshot_custom_legendary_agility = class({})
function modifier_sniper_headshot_custom_legendary_agility:IsHidden() return true end
function modifier_sniper_headshot_custom_legendary_agility:IsPurgable() return false end
function modifier_sniper_headshot_custom_legendary_agility:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self.RemoveForDuel = true
self.agi = self.parent:GetTalentValue("modifier_sniper_headshot_7", "agi")/100
self.max_time = self.parent:GetTalentValue("modifier_sniper_headshot_7", "agi_duration")
self:SetStackCount(1)
end

function modifier_sniper_headshot_custom_legendary_agility:OnRefresh()
if not IsServer() then return end
self:IncrementStackCount()
end

function modifier_sniper_headshot_custom_legendary_agility:OnStackCountChanged(iStackCount)
if not IsServer() then return end
self.parent:AddPercentStat({agi = self.agi*self:GetStackCount()}, self)
end

function modifier_sniper_headshot_custom_legendary_agility:OnIntervalThink()
if not IsServer() then return end

if not self.parent:HasModifier("modifier_sniper_headshot_custom_legendary_effect") then
	self.parent:UpdateUIshort({time = self:GetRemainingTime(), max_time = self.max_time, stack = "+"..tostring(math.floor(self:GetStackCount()*self.agi*100)).."%", style = "SniperHeadshot"})
end

self:StartIntervalThink(0.1)
end

function modifier_sniper_headshot_custom_legendary_agility:OnDestroy()
if not IsServer() then return end

self.parent:UpdateUIshort({hide = 1, style = "SniperHeadshot"})
end

function modifier_sniper_headshot_custom_legendary_agility:GetEffectName()
return "particles/units/heroes/hero_juggernaut/jugg_agility_boost.vpcf"
end