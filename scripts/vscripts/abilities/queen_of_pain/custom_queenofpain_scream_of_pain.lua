--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_scream_slow", "abilities/queen_of_pain/custom_queenofpain_scream_of_pain", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_scream_tracker", "abilities/queen_of_pain/custom_queenofpain_scream_of_pain", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_scream_armor", "abilities/queen_of_pain/custom_queenofpain_scream_of_pain", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_scream_lowhp", "abilities/queen_of_pain/custom_queenofpain_scream_of_pain", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_scream_auto_cd", "abilities/queen_of_pain/custom_queenofpain_scream_of_pain", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_scream_speed", "abilities/queen_of_pain/custom_queenofpain_scream_of_pain", LUA_MODIFIER_MOTION_NONE)



custom_queenofpain_scream_of_pain = class({})


function custom_queenofpain_scream_of_pain:GetAbilityTextureName()
local caster = self:GetCaster()
return wearables_system:GetAbilityIconReplacement(self.caster, "queenofpain_scream_of_pain", self)
end


function custom_queenofpain_scream_of_pain:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/queen_of_pain/queen_scream_proc.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_queenofpain/queen_scream_of_pain_owner.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_queenofpain/queen_scream_of_pain.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_huskar_lifebreak.vpcf", context )
PrecacheResource( "particle","particles/lc_lowhp.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pudge/pudge_fleshheap_block_shield_model.vpcf", context )
PrecacheResource( "particle","particles/queen_of_pain/scream_speed.vpcf", context )
PrecacheResource( "particle","particles/void_astral_slow.vpcf", context )

end

function custom_queenofpain_scream_of_pain:UpdateTalents()
local caster = self:GetCaster()

if caster:HasTalent("modifier_queen_scream_6") then 
  caster:AddPercentStat({str = caster:GetTalentValue("modifier_queen_scream_6", "str")/100}, self.tracker)
end

end 


function custom_queenofpain_scream_of_pain:GetManaCost(iLevel)
if self:GetCaster():HasModifier("modifier_queenofpain_blood_pact") then 
	return 0
end
return self.BaseClass.GetManaCost(self,iLevel)
end 


function custom_queenofpain_scream_of_pain:GetHealthCost(level)
local caster = self:GetCaster()
if caster:HasModifier("modifier_queenofpain_blood_pact") then 
	return caster:GetTalentValue("modifier_queen_scream_7", "cost")*caster:GetMaxHealth()/100
end

end 


function custom_queenofpain_scream_of_pain:GetCooldown(iLevel)
local caster = self:GetCaster()
local upgrade_cooldown = 0	
local k = 1
if caster:HasTalent("modifier_queen_scream_2") then 
	upgrade_cooldown = caster:GetTalentValue("modifier_queen_scream_2", "cd")
end
if caster:HasTalent("modifier_queen_scream_6") and caster:GetHealthPercent() <= caster:GetTalentValue("modifier_queen_scream_6", "health") then 
	k = 1 - caster:GetTalentValue("modifier_queen_scream_6", "cd")/100
end
return (self.BaseClass.GetCooldown(self, iLevel) - upgrade_cooldown)*k
end


function custom_queenofpain_scream_of_pain:GetCastRange( location , target)
return self:GetSpecialValueFor("radius")
end

function custom_queenofpain_scream_of_pain:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_custom_scream_tracker"
end


function custom_queenofpain_scream_of_pain:ProcHeal()
local caster = self:GetCaster()

local random = RollPseudoRandomPercentage(caster:GetTalentValue("modifier_queen_scream_4", "chance"),451,caster)
if not random then return end

local heal = (caster:GetMaxHealth())*caster:GetTalentValue("modifier_queen_scream_4", "heal")/100
local radius = caster:GetTalentValue("modifier_queen_scream_4", "radius")

caster:GenericHeal(heal, self, nil, nil, "modifier_queen_scream_4")

local damage = heal
local particle_cast = "particles/queen_of_pain/queen_scream_proc.vpcf"

caster:EmitSound("QoP.Scream_heal")

local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN,  nil)
ParticleManager:SetParticleControl( effect_cast, 0, caster:GetAbsOrigin() )
ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius*0.58 , 0, 0 ) )
ParticleManager:ReleaseParticleIndex( effect_cast )
 
for _,unit in pairs(caster:FindTargets(radius)) do  
    DoDamage({ victim = unit, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self, }, "modifier_queen_scream_4")
	SendOverheadEventMessage(unit, 6, unit, damage, nil)
end

end




function custom_queenofpain_scream_of_pain:OnSpellStart(damage_ability)
local caster = self:GetCaster()
local projectile_speed = self:GetSpecialValueFor("projectile_speed")
local radius = self:GetSpecialValueFor("radius")
local ability = nil
if damage_ability then
	ability = damage_ability
end

local scream_loc = caster:GetAbsOrigin()
caster:StartGesture(ACT_DOTA_CAST_ABILITY_3)

if caster:HasTalent("modifier_queen_scream_5") then
	caster:RemoveModifierByName("modifier_custom_scream_speed")

	local min = caster:GetTalentValue("modifier_queen_scream_5", "min")
	local max = caster:GetTalentValue("modifier_queen_scream_5", "speed")
	local stack = min + (1 - caster:GetHealthPercent()/100)*(max - min)

	caster:AddNewModifier(caster, self, "modifier_custom_scream_speed", {duration = caster:GetTalentValue("modifier_queen_scream_5", "duration"), stack = stack})
end

EmitSoundOnLocationWithCaster(scream_loc, "Hero_QueenOfPain.ScreamOfPain", caster)

local particle_name = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_queenofpain/queen_scream_of_pain_owner.vpcf", self)
local effect_cast = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_queenofpain/queen_scream_of_pain.vpcf", self)

local scream_pfx = ParticleManager:CreateParticle(particle_name, PATTACH_ABSORIGIN, caster)
ParticleManager:SetParticleControl(scream_pfx, 0, scream_loc )
ParticleManager:ReleaseParticleIndex(scream_pfx)

for _, enemy in pairs(caster:FindTargets(radius, scream_loc)) do
	local projectile =
	{
		Target 				= enemy,
		Source 				= caster,
		Ability 			= self,
		EffectName 			= effect_cast,
		iMoveSpeed			= projectile_speed,
		vSourceLoc 			= scream_loc,
		bDrawsOnMinimap 	= false,
		bDodgeable 			= true,
		bIsAttack 			= false,
		bVisibleToEnemies 	= true,
		bReplaceExisting 	= false,
		flExpireTime 		= GameRules:GetGameTime() + 20,
		bProvidesVision 	= false,
		iSourceAttachment 	= DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
		ExtraData			= {ability = ability}
	}
	ProjectileManager:CreateTrackingProjectile(projectile)	
end


end


function custom_queenofpain_scream_of_pain:OnProjectileHit_ExtraData(target, location, ExtraData)
if not IsServer() then return end
if not target then return end

local caster = self:GetCaster()
local damage = self:GetSpecialValueFor("damage") + caster:GetTalentValue("modifier_queen_scream_1", "damage")*caster:GetMaxHealth()/100

if ExtraData.ability and ExtraData.ability == "modifier_queen_scream_1" then
	damage = damage*caster:GetTalentValue("modifier_queen_scream_1", "damage_auto")/100
end

if caster:HasTalent("modifier_queen_scream_2") then
	target:AddNewModifier(caster, self, "modifier_custom_scream_slow", {duration = (1 - target:GetStatusResistance())*caster:GetTalentValue("modifier_queen_scream_2", "duration")})
end

DoDamage({victim = target, attacker = caster, ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL}, ExtraData.ability)
end







modifier_custom_scream_tracker = class({})
function modifier_custom_scream_tracker:IsHidden() return true end
function modifier_custom_scream_tracker:IsPurgable() return false end
function modifier_custom_scream_tracker:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent:AddAttackEvent_inc(self)
self.parent:AddSpellEvent(self)

self.radius = self.ability:GetSpecialValueFor("radius")
self.auto_cd = self.parent:GetTalentValue("modifier_queen_scream_1", "cd", true)

self.low_health = self.parent:GetTalentValue("modifier_queen_scream_6", "health", true)

self.armor_duration = self.parent:GetTalentValue("modifier_queen_scream_3", "duration", true)
self:StartIntervalThink(1)
end


function modifier_custom_scream_tracker:OnIntervalThink()
if not IsServer() then return end
if not self.parent:HasTalent("modifier_queen_scream_6") then return end
if not self.parent:IsAlive() then return end

local mod = self.parent:FindModifierByName("modifier_custom_scream_lowhp")

if (self.parent:GetHealthPercent() > self.low_health or self.parent:PassivesDisabled()) and mod then 
	mod:Destroy()
end

if self.parent:GetHealthPercent() <= self.low_health and not mod and not self.parent:PassivesDisabled() then 
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_scream_lowhp", {})
end

self:StartIntervalThink(0.2)
end


function modifier_custom_scream_tracker:SpellEvent(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end
if params.ability:IsItem() then return end

if self.parent:HasTalent("modifier_queen_scream_4") then
	Timers:CreateTimer(FrameTime(), function()
		self.ability:ProcHeal()
	end)
end

if self.parent:HasTalent("modifier_queen_scream_3") then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_scream_armor", {duration = self.armor_duration})
end

end


function modifier_custom_scream_tracker:AttackEvent_inc(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_queen_scream_1") then return end
if self.parent:HasModifier("modifier_custom_scream_auto_cd") then return end
if self.parent ~= params.target then return end
if not params.attacker:IsUnit() then return end
if (params.attacker:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > self.radius then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_scream_auto_cd", {duration = self.auto_cd})
self.ability:OnSpellStart("modifier_queen_scream_1")
end





modifier_custom_scream_armor = class({})
function modifier_custom_scream_armor:IsHidden() return false end
function modifier_custom_scream_armor:IsPurgable() return false end
function modifier_custom_scream_armor:GetTexture() return "buffs/blood_defence" end
function modifier_custom_scream_armor:OnCreated(table)
self.parent = self:GetParent()
self.max = self.parent:GetTalentValue("modifier_queen_scream_3", "max")
self.armor = self.parent:GetTalentValue("modifier_queen_scream_3", "armor")
self.str = self.parent:GetTalentValue("modifier_queen_scream_3", "str")
if not IsServer() then return end
self:SetStackCount(1)
self.parent:CalculateStatBonus(true)
end

function modifier_custom_scream_armor:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
self.parent:CalculateStatBonus(true)
end


function modifier_custom_scream_armor:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
}
end

function modifier_custom_scream_armor:GetModifierPhysicalArmorBonus()
return self.armor*self:GetStackCount()
end

function modifier_custom_scream_armor:GetModifierBonusStats_Strength()
return self.str*self:GetStackCount()
end




modifier_custom_scream_lowhp = class({})
function modifier_custom_scream_lowhp:IsHidden() return false end
function modifier_custom_scream_lowhp:IsPurgable() return false end
function modifier_custom_scream_lowhp:GetTexture() return "buffs/scream_fear" end
function modifier_custom_scream_lowhp:OnCreated()
self.parent = self:GetParent()
if not IsServer() then return end

self.parent:EmitSound("Lc.Moment_Lowhp")
self.particle = ParticleManager:CreateParticle( "particles/lc_lowhp.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl( self.particle, 0, self.parent:GetAbsOrigin() )
ParticleManager:SetParticleControl( self.particle, 1, self.parent:GetAbsOrigin() )
ParticleManager:SetParticleControl( self.particle, 2, self.parent:GetAbsOrigin() )
self:AddParticle(self.particle, false, false, 0, true, false)
end




modifier_custom_scream_auto_cd = class({})
function modifier_custom_scream_auto_cd:IsHidden() return false end
function modifier_custom_scream_auto_cd:IsPurgable() return false end
function modifier_custom_scream_auto_cd:RemoveOnDeath() return false end
function modifier_custom_scream_auto_cd:GetTexture() return "buffs/scream_slow" end
function modifier_custom_scream_auto_cd:IsDebuff() return true end
function modifier_custom_scream_auto_cd:OnCreated(table)
self.RemoveForDuel = true
end


modifier_custom_scream_slow = class({})
function modifier_custom_scream_slow:IsHidden() return true end
function modifier_custom_scream_slow:IsPurgable() return true end
function modifier_custom_scream_slow:OnCreated()
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.slow = self.caster:GetTalentValue("modifier_queen_scream_2", "slow")
if not IsServer() then return end
self.parent:GenericParticle("particles/items2_fx/sange_maim.vpcf", self)
end

function modifier_custom_scream_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_custom_scream_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end




modifier_custom_scream_speed = class({})
function modifier_custom_scream_speed:IsHidden() return false end
function modifier_custom_scream_speed:IsPurgable() return true end
function modifier_custom_scream_speed:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self:SetStackCount(table.stack)
self.parent:GenericParticle("particles/queen_of_pain/scream_speed.vpcf", self)
self.parent:GenericParticle("particles/units/heroes/hero_pudge/pudge_fleshheap_block_shield_model.vpcf", self)
end

function modifier_custom_scream_speed:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_custom_scream_speed:GetModifierMoveSpeedBonus_Percentage()
return self:GetStackCount()
end

function modifier_custom_scream_speed:GetModifierIncomingDamage_Percentage()
return self:GetStackCount()*-1
end

function modifier_custom_scream_speed:CheckState()
return
{
	[MODIFIER_STATE_UNSLOWABLE] = true
}
end