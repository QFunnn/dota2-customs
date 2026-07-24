--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skywrath_mage_arcane_bolt_custom", "abilities/skywrath_mage/skywrath_mage_arcane_bolt_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_arcane_bolt_custom_legendary", "abilities/skywrath_mage/skywrath_mage_arcane_bolt_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_arcane_bolt_custom_legendary_mana", "abilities/skywrath_mage/skywrath_mage_arcane_bolt_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_arcane_bolt_custom_slow", "abilities/skywrath_mage/skywrath_mage_arcane_bolt_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_arcane_bolt_custom_root", "abilities/skywrath_mage/skywrath_mage_arcane_bolt_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_arcane_bolt_custom_root_stack", "abilities/skywrath_mage/skywrath_mage_arcane_bolt_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_arcane_bolt_custom_range", "abilities/skywrath_mage/skywrath_mage_arcane_bolt_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_arcane_bolt_custom_lethal", "abilities/skywrath_mage/skywrath_mage_arcane_bolt_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_arcane_bolt_custom_lethal_cd", "abilities/skywrath_mage/skywrath_mage_arcane_bolt_custom", LUA_MODIFIER_MOTION_NONE)


skywrath_mage_arcane_bolt_custom = class({})

function skywrath_mage_arcane_bolt_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "skywrath_mage_arcane_bolt", self)
end

function skywrath_mage_arcane_bolt_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt.vpcf", context )
PrecacheResource( "particle","particles/skymage/bolt_legendary.vpcf", context )
PrecacheResource( "particle","particles/skymage/bolt_legendarya.vpcf", context )
PrecacheResource( "particle","particles/skymage/bolt_legendary_cast.vpcf", context )
PrecacheResource( "particle","particles/skymage/bolt_legendary_status.vpcf", context )
PrecacheResource( "particle","particles/skymage/bolt_legendary_mana.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_keeper_of_the_light/keeper_chakra_magic.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_essence_effect.vpcf", context )
PrecacheResource( "particle","particles/skymage/bolt_root.vpcf", context )
PrecacheResource( "particle","particles/skymage/bolt_root_stack.vpcf", context )
PrecacheResource( "particle","particles/econ/items/outworld_devourer/od_shards_exile/od_shards_exile_prison_end.vpcf", context )
PrecacheResource( "particle","particles/skymage/bolt_lethal.vpcf", context )
PrecacheResource( "particle","particles/skymage/bolt_slow.vpcf", context )
end




function skywrath_mage_arcane_bolt_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_skywrath_mage_arcane_bolt_custom"
end


function skywrath_mage_arcane_bolt_custom:GetCastRange(vLocation, hTarget)
local upgrade = 0
--if self:GetCaster():HasTalent("modifier_sky_arcane_bolt_6") then 
 -- upgrade = self:GetCaster():GetTalentValue("modifier_sky_arcane_bolt_6", "range")
--end
return self.BaseClass.GetCastRange(self , vLocation , hTarget) + upgrade 
end


function skywrath_mage_arcane_bolt_custom:GetCooldown(level)
local bonus = 0
if self:GetCaster():HasModifier("modifier_skywrath_mage_arcane_bolt_custom_range") then 
	bonus = self:GetCaster():GetTalentValue("modifier_sky_arcane_bolt_4", "cd")
end 
return self.BaseClass.GetCooldown( self, level ) + bonus
end


function skywrath_mage_arcane_bolt_custom:GetManaCost(level)
local bonus = 0
local caster = self:GetCaster()

if caster:HasModifier("modifier_skywrath_mage_arcane_bolt_custom_legendary") then 
  bonus = caster:GetUpgradeStack("modifier_skywrath_mage_arcane_bolt_custom_legendary")*caster:GetTalentValue("modifier_sky_arcane_bolt_7", "mana")*caster:GetMaxMana()/100
end 
return self.BaseClass.GetManaCost(self,level) + bonus
end

function skywrath_mage_arcane_bolt_custom:OnSpellStart(new_target)
local caster = self:GetCaster()
local target = self:GetCursorTarget()
if new_target then 
	target = new_target
end

caster:EmitSound("Hero_SkywrathMage.ArcaneBolt.Cast")

local particle_projectile = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt.vpcf", self)

local bolt_speed = self:GetSpecialValueFor("bolt_speed") * (1 + caster:GetTalentValue("modifier_sky_arcane_bolt_6", "speed")/100)
local bolt_vision = self:GetSpecialValueFor("bolt_vision")
local radius = self:GetSpecialValueFor("radius")
local max_targets = self:GetSpecialValueFor("max_targets") + 1

local bolt_damage = self:GetSpecialValueFor("bolt_damage")
local int_multiplier = self:GetSpecialValueFor("int_multiplier") + caster:GetTalentValue("modifier_sky_arcane_bolt_1", "damage")/100
local legendary_damage = caster:GetTalentValue("modifier_sky_arcane_bolt_7", "damage")/100

local mod = caster:FindModifierByName("modifier_skywrath_mage_arcane_bolt_custom_legendary")

bolt_damage = bolt_damage + int_multiplier*caster:GetIntellect(false)

if mod then 
	bolt_damage = bolt_damage*(1 + mod:GetStackCount()*legendary_damage)
end

local arcane_bolt_projectile = {
	Source = caster,
	Ability = self,
	EffectName = particle_projectile,
	iMoveSpeed = bolt_speed,
	bDodgeable = false, 
	bVisibleToEnemies = true,
	bReplaceExisting = false,
	bProvidesVision = true,
	iVisionRadius = bolt_vision,
	iVisionTeamNumber = caster:GetTeamNumber(),
	ExtraData = {bolt_damage = bolt_damage}
}

local count = 0

for _,target in pairs(caster:FindTargets(radius, target:GetAbsOrigin())) do 
	arcane_bolt_projectile.Target = target
	ProjectileManager:CreateTrackingProjectile(arcane_bolt_projectile)

	count = count + 1
	if count >= max_targets then 
		break
	end
end

if caster:HasModifier("modifier_skywrath_mage_arcane_bolt_custom_range") then 
	caster:CdItems(caster:GetTalentValue("modifier_sky_arcane_bolt_4", "cd_items"))
end

if caster:HasTalent("modifier_sky_arcane_bolt_2") then 
	caster:AddNewModifier(caster, self, "modifier_skywrath_mage_arcane_bolt_custom_slow", {duration = caster:GetTalentValue("modifier_sky_arcane_bolt_2", "duration")})
end

end



function skywrath_mage_arcane_bolt_custom:OnProjectileHit_ExtraData(target, location, extra_data)
if not target then return nil end
if not extra_data.bolt_damage then return end

local caster = self:GetCaster() 
caster:StopSound("Hero_SkywrathMage.ArcaneBolt.Cast")

if target:TriggerSpellAbsorb(self) then return end
  
local vision_duration  = self:GetSpecialValueFor("vision_duration")
local bolt_vision = self:GetSpecialValueFor("bolt_vision")

target:EmitSound("Hero_SkywrathMage.ArcaneBolt.Impact")

AddFOWViewer(caster:GetTeamNumber(), location, bolt_vision, vision_duration, false)

local shot = caster:FindAbilityByName("skywrath_mage_concussive_shot_custom")
if shot then 
	shot:ApplyBurn(target)
end

if caster:HasTalent("modifier_sky_arcane_bolt_2") then 
	target:AddNewModifier(caster, self, "modifier_skywrath_mage_arcane_bolt_custom_slow", {duration = caster:GetTalentValue("modifier_sky_arcane_bolt_2", "duration")})
end

if caster:HasTalent("modifier_sky_flare_4") then 
	target:AddNewModifier(caster, self, "modifier_skywrath_mage_mystic_flare_custom_damage_inc", {duration = caster:GetTalentValue("modifier_sky_flare_4", "duration")})
end

if caster:HasTalent("modifier_sky_arcane_bolt_6") then 
	target:AddNewModifier(caster, self, "modifier_skywrath_mage_arcane_bolt_custom_root_stack", {duration = caster:GetTalentValue("modifier_sky_arcane_bolt_6", "duration")})

	if target:IsHero() then 
		target:AddNewModifier(caster, self, "modifier_generic_vision", {duration = caster:GetTalentValue("modifier_sky_arcane_bolt_6", "duration")})
	end
end

local damageTable = {victim = target, attacker = caster, damage = extra_data.bolt_damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self }
DoDamage(damageTable)
end



skywrath_mage_arcane_bolt_custom_legendary = class({})


function skywrath_mage_arcane_bolt_custom_legendary:CreateTalent()
self:SetHidden(false)
end




function skywrath_mage_arcane_bolt_custom_legendary:GetCooldown(level)
return self:GetCaster():GetTalentValue("modifier_sky_arcane_bolt_7", "cd")
end

function skywrath_mage_arcane_bolt_custom_legendary:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "skywrath_mage_staff_of_the_scion", self)
end 



function skywrath_mage_arcane_bolt_custom_legendary:OnSpellStart()
local caster = self:GetCaster()

local mod = caster:FindModifierByName("modifier_skywrath_mage_arcane_bolt_custom_legendary")

if mod then 
	mod:Destroy()
	return
end

self:EndCd(0)
self:StartCooldown(0.5)

if not caster:HasModifier("modifier_skywrath_mage_mystic_flare_custom_legendary_caster") then
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_2)
end

caster:AddNewModifier(caster, self, "modifier_skywrath_mage_arcane_bolt_custom_legendary", {duration = caster:GetTalentValue("modifier_sky_arcane_bolt_7", "duration")})
end



modifier_skywrath_mage_arcane_bolt_custom_legendary = class({})
function modifier_skywrath_mage_arcane_bolt_custom_legendary:IsHidden() return true end
function modifier_skywrath_mage_arcane_bolt_custom_legendary:IsPurgable() return false end
function modifier_skywrath_mage_arcane_bolt_custom_legendary:OnCreated(table)
self.parent = self:GetCaster()
self.ability = self:GetAbility()

self.status = self.parent:GetTalentValue("modifier_sky_arcane_bolt_7", "status")

if not IsServer() then return end

self.RemoveForDuel = true

self.player = PlayerResource:GetPlayer(self.parent:GetPlayerOwnerID())
self.time = self.parent:GetTalentValue("modifier_sky_arcane_bolt_7", "duration")

self.parent:EmitSound("Sky.Bolt_legendary")
self.parent:EmitSound("Sky.Bolt_legendary2")
self.parent:EmitSound("Sky.Bolt_legendary_loop")

local particle_peffect = ParticleManager:CreateParticle("particles/skymage/bolt_legendary_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(particle_peffect, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_peffect, 2, self.parent:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(particle_peffect)

self.effect_cast = ParticleManager:CreateParticle( "particles/skymage/bolt_legendarya.vpcf", PATTACH_CUSTOMORIGIN, self.parent )
ParticleManager:SetParticleControlEnt( self.effect_cast, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
self:AddParticle(self.effect_cast,false, false, -1, false, false)

self:OnIntervalThink()
self:StartIntervalThink(0.05)
end

function modifier_skywrath_mage_arcane_bolt_custom_legendary:OnIntervalThink()
if not IsServer() then return end

self.parent:UpdateUIshort({max_time = self.time, time = self:GetRemainingTime(), stack = self:GetStackCount(), style = "SkyBolt"})
end


function modifier_skywrath_mage_arcane_bolt_custom_legendary:GetEffectName()
return "particles/skymage/bolt_legendary_status.vpcf"
end

function modifier_skywrath_mage_arcane_bolt_custom_legendary:GetStatusEffectName()
return "particles/econ/items/necrolyte/necro_ti9_immortal/status_effect_necro_ti9_immortal_shroud.vpcf"
end

function modifier_skywrath_mage_arcane_bolt_custom_legendary:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end

function modifier_skywrath_mage_arcane_bolt_custom_legendary:OnDestroy()
if not IsServer() then return end
self.parent:StopSound("Sky.Bolt_legendary_loop")
self.ability:StartCd()

self.parent:UpdateUIshort({hide = 1, hide_full = 1, style = "SkyBolt"})
self.parent:AddNewModifier(self.parent, self.ability, "modifier_skywrath_mage_arcane_bolt_custom_legendary_mana", {duration = self.parent:GetTalentValue("modifier_sky_arcane_bolt_7", "mana_duration")})
end


function modifier_skywrath_mage_arcane_bolt_custom_legendary:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
}
end

function modifier_skywrath_mage_arcane_bolt_custom_legendary:GetModifierStatusResistanceStacking() 
return self.status
end





modifier_skywrath_mage_arcane_bolt_custom = class({})
function modifier_skywrath_mage_arcane_bolt_custom:IsHidden() return true end
function modifier_skywrath_mage_arcane_bolt_custom:IsPurgable() return false end
function modifier_skywrath_mage_arcane_bolt_custom:OnCreated()

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.parent:AddSpellEvent(self)
self.parent:AddDamageEvent_inc(self)

self.lethal_duration = self.parent:GetTalentValue("modifier_sky_arcane_bolt_5", "duration", true)
self.lethal_cd = self.parent:GetTalentValue("modifier_sky_arcane_bolt_5", "cd", true)

self.mana_chance = self.parent:GetTalentValue("modifier_sky_arcane_bolt_3", "chance", true)

self.close_radius = self.parent:GetTalentValue("modifier_sky_arcane_bolt_4", "radius", true)

self.legendary_duration = self.parent:GetTalentValue("modifier_sky_arcane_bolt_7", "duration", true)
if not IsServer() then return end 
self:StartIntervalThink(1)
end

function modifier_skywrath_mage_arcane_bolt_custom:SpellEvent(params)
if not IsServer() then return end 
if self.parent ~= params.unit then return end 
if params.ability:IsItem() then return end

if self.parent:HasTalent("modifier_sky_arcane_bolt_3") and RollPseudoRandomPercentage(self.mana_chance, 5251, self.parent) then
	self.parent:EmitSound("Sky.Bolt_legendary_end")

	local mana = self.parent:GetMaxMana()*self.parent:GetTalentValue("modifier_sky_arcane_bolt_3", "mana")/100
	self.parent:GiveMana(mana)
	self.parent:GenericHeal(mana, self, false, "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_essence_effect.vpcf", "modifier_sky_arcane_bolt_3")
end

local mod = self.parent:FindModifierByName("modifier_skywrath_mage_arcane_bolt_custom_legendary")
if mod then 
	mod:IncrementStackCount()
end

end


function modifier_skywrath_mage_arcane_bolt_custom:DamageEvent_inc(params)
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_sky_arcane_bolt_5") then return end
if self.parent ~= params.unit then return end
if self.parent:GetHealth() > 1 then return end 
if self.parent:PassivesDisabled() then return end
if not self.parent:IsAlive() then return end
if self.parent:HasModifier("modifier_death") then return end
if self.parent:HasModifier("modifier_skywrath_mage_arcane_bolt_custom_lethal_cd") then return end

self.parent:Purge(false, true, false, true, true)
self.parent:AddNewModifier(self.parent, self.parent:BkbAbility(self.ability, true), "modifier_skywrath_mage_arcane_bolt_custom_lethal",  {duration = self.lethal_duration})
self.parent:AddNewModifier(self.parent, self.ability, "modifier_skywrath_mage_arcane_bolt_custom_lethal_cd",  {duration = self.lethal_cd})
end


function modifier_skywrath_mage_arcane_bolt_custom:GetMinHealth()
if not self.parent:HasTalent("modifier_sky_arcane_bolt_5") then return end
if self.parent:PassivesDisabled() then return end
if self.parent:LethalDisabled() then return end
if self.parent:HasModifier("modifier_skywrath_mage_arcane_bolt_custom_lethal_cd") then return end
if not self.parent:IsAlive() then return end
return 1
end


function modifier_skywrath_mage_arcane_bolt_custom:DeclareFunctions()
return
{
 	MODIFIER_PROPERTY_HEALTH_BONUS,
 	MODIFIER_PROPERTY_MIN_HEALTH,
}
end


function modifier_skywrath_mage_arcane_bolt_custom:GetModifierHealthBonus()
if not self.parent:HasTalent("modifier_sky_arcane_bolt_1") then return end 
return self.parent:GetTalentValue("modifier_sky_arcane_bolt_1", "health")*self.parent:GetIntellect(false)
end


function modifier_skywrath_mage_arcane_bolt_custom:OnIntervalThink()
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_sky_arcane_bolt_4") then return end
local targets = self.parent:FindTargets(self.close_radius)

local allow = true
for _,target in pairs(targets) do
	if target:IsHero() then
		allow = false
		break
	end
end

local mod = self.parent:FindModifierByName("modifier_skywrath_mage_arcane_bolt_custom_range")

if not allow and mod then 
	mod:Destroy()
end 

if allow and not mod then 
	mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_skywrath_mage_arcane_bolt_custom_range", {})
end 

self:StartIntervalThink(0.2)
end 






modifier_skywrath_mage_arcane_bolt_custom_legendary_mana = class({})
function modifier_skywrath_mage_arcane_bolt_custom_legendary_mana:IsHidden() return false end
function modifier_skywrath_mage_arcane_bolt_custom_legendary_mana:IsPurgable() return false end
function modifier_skywrath_mage_arcane_bolt_custom_legendary_mana:OnCreated()
self.parent = self:GetParent()

if not IsServer() then return end
self.parent:GenericParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_chakra_magic.vpcf", false, false, {1})
self.parent:GenericParticle("particles/items_fx/arcane_boots.vpcf")

self.parent:EmitSound("Sky.Bolt_legendary_end")
self.interval = 0.5
self.mana = self.interval*((self.parent:GetTalentValue("modifier_sky_arcane_bolt_7", "mana_inc")*(self.parent:GetMaxMana() - self.parent:GetMana())/100)/self:GetRemainingTime())
self:StartIntervalThink(self.interval - FrameTime())
end

function modifier_skywrath_mage_arcane_bolt_custom_legendary_mana:OnIntervalThink()
if not IsServer() then return end
self.parent:GiveMana(self.mana)
self.parent:SendNumber(OVERHEAD_ALERT_MANA_ADD, self.mana)
end


function modifier_skywrath_mage_arcane_bolt_custom_legendary_mana:GetEffectName()
return "particles/skymage/bolt_legendary_mana.vpcf"
end



modifier_skywrath_mage_arcane_bolt_custom_slow = class({})
function modifier_skywrath_mage_arcane_bolt_custom_slow:IsHidden() return false end
function modifier_skywrath_mage_arcane_bolt_custom_slow:IsPurgable() return true end
function modifier_skywrath_mage_arcane_bolt_custom_slow:OnCreated()

self.caster = self:GetCaster()
self.parent = self:GetParent()
self.max = self.caster:GetTalentValue("modifier_sky_arcane_bolt_2", "max")
self.slow = self.caster:GetTalentValue("modifier_sky_arcane_bolt_2", "slow")

if self.caster == self.parent then 
	self.slow = self.slow*-1
end

if not IsServer() then return end 
self:SetStackCount(1)
end

function modifier_skywrath_mage_arcane_bolt_custom_slow:OnRefresh(table)
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end 
self:IncrementStackCount()

if self:GetStackCount() >= self.max and self.parent ~= self.caster then 
	self.parent:GenericParticle("particles/skymage/bolt_slow.vpcf", self)
end

end

function modifier_skywrath_mage_arcane_bolt_custom_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_skywrath_mage_arcane_bolt_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow*self:GetStackCount()
end




modifier_skywrath_mage_arcane_bolt_custom_root = class({})
function modifier_skywrath_mage_arcane_bolt_custom_root:IsHidden() return true end
function modifier_skywrath_mage_arcane_bolt_custom_root:IsPurgable() return true end
function modifier_skywrath_mage_arcane_bolt_custom_root:CheckState()
return
{
	[MODIFIER_STATE_ROOTED] = true
}
end

function modifier_skywrath_mage_arcane_bolt_custom_root:GetEffectName()
return "particles/skymage/bolt_root.vpcf"
end



modifier_skywrath_mage_arcane_bolt_custom_root_stack = class({})
function modifier_skywrath_mage_arcane_bolt_custom_root_stack:IsHidden() return true end
function modifier_skywrath_mage_arcane_bolt_custom_root_stack:IsPurgable() return false end
function modifier_skywrath_mage_arcane_bolt_custom_root_stack:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.count = self.caster:GetTalentValue("modifier_sky_arcane_bolt_6", "count")

if not IsServer() then return end 

if not self.caster:HasTalent("modifier_sky_flare_4") then 
	self.particle = self.parent:GenericParticle("particles/skymage/bolt_root_stack.vpcf", self, true)
end

self:SetStackCount(1)
end

function modifier_skywrath_mage_arcane_bolt_custom_root_stack:OnRefresh()
if not IsServer() then return end 
if self:GetStackCount() >= self.count then return end 

self:IncrementStackCount()
end


function modifier_skywrath_mage_arcane_bolt_custom_root_stack:OnStackCountChanged(iStackCount)
if not IsServer() then return end 

if self.particle then 
	ParticleManager:SetParticleControl(self.particle, 1, Vector(0, self:GetStackCount(), 0))
end

if self:GetStackCount() >= self.count then 
	self.parent:EmitSound("Sky.Bolt_root")
	self.parent:GenericParticle("particles/econ/items/outworld_devourer/od_shards_exile/od_shards_exile_prison_end.vpcf")
	self.parent:AddNewModifier(self.caster, self.ability, "modifier_skywrath_mage_arcane_bolt_custom_root", {duration = (1 - self.parent:GetStatusResistance())*self.caster:GetTalentValue("modifier_sky_arcane_bolt_6", "root")})
	self:Destroy()
end

end



modifier_skywrath_mage_arcane_bolt_custom_range = class({})
function modifier_skywrath_mage_arcane_bolt_custom_range:IsHidden() return false end
function modifier_skywrath_mage_arcane_bolt_custom_range:IsPurgable() return false end
function modifier_skywrath_mage_arcane_bolt_custom_range:GetTexture() return "buffs/bolt_range" end
function modifier_skywrath_mage_arcane_bolt_custom_range:OnCreated()

self.parent = self:GetParent()

if not IsServer() then return end
self.effect_cast = ParticleManager:CreateParticle( "particles/skymage/bolt_legendary.vpcf", PATTACH_CUSTOMORIGIN, self.parent )
ParticleManager:SetParticleControlEnt( self.effect_cast, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
ParticleManager:SetParticleControlEnt( self.effect_cast, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_attack2", self.parent:GetAbsOrigin(), true )
ParticleManager:SetParticleControlEnt( self.effect_cast, 2, self.parent, PATTACH_POINT_FOLLOW, "attach_staff", self.parent:GetAbsOrigin(), true )
self:AddParticle(self.effect_cast,false, false, -1, false, false)
end



modifier_skywrath_mage_arcane_bolt_custom_lethal = class({})
function modifier_skywrath_mage_arcane_bolt_custom_lethal:IsHidden() return true end
function modifier_skywrath_mage_arcane_bolt_custom_lethal:IsPurgable() return false end
function modifier_skywrath_mage_arcane_bolt_custom_lethal:IsDebuff() return true end
function modifier_skywrath_mage_arcane_bolt_custom_lethal:CheckState()
return
{
	[MODIFIER_STATE_INVULNERABLE] = true,
	[MODIFIER_STATE_UNSLOWABLE] = true,
	[MODIFIER_STATE_SILENCED] = true,
	[MODIFIER_STATE_NO_HEALTH_BAR_FOR_ENEMIES] = true,
	[MODIFIER_STATE_MUTED] = true,
	[MODIFIER_STATE_DISARMED] = true
}
end

function modifier_skywrath_mage_arcane_bolt_custom_lethal:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.heal = (self.parent:GetTalentValue("modifier_sky_arcane_bolt_5", "heal")*self.parent:GetIntellect(false)/100)/self:GetRemainingTime()

if not IsServer() then return end

self.parent:EmitSound("Sky.Bolt_lethal")
self.parent:EmitSound("Sky.Bolt_lethal2")

self.effect_cast = ParticleManager:CreateParticle( "particles/skymage/bolt_lethal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControlEnt( self.effect_cast, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
self:AddParticle(self.effect_cast,false, false, -1, false, false)
end

function modifier_skywrath_mage_arcane_bolt_custom_lethal:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
}
end

function modifier_skywrath_mage_arcane_bolt_custom_lethal:GetModifierConstantHealthRegen()
return self.heal
end

function modifier_skywrath_mage_arcane_bolt_custom_lethal:GetStatusEffectName()
return "particles/skymage/bolt_lethal_status.vpcf"
end

function modifier_skywrath_mage_arcane_bolt_custom_lethal:StatusEffectPriority()
return MODIFIER_PRIORITY_SUPER_ULTRA 
end




modifier_skywrath_mage_arcane_bolt_custom_lethal_cd = class({})
function modifier_skywrath_mage_arcane_bolt_custom_lethal_cd:IsHidden() return false end
function modifier_skywrath_mage_arcane_bolt_custom_lethal_cd:IsPurgable() return false end
function modifier_skywrath_mage_arcane_bolt_custom_lethal_cd:GetTexture() return "buffs/bolt_lethal" end
function modifier_skywrath_mage_arcane_bolt_custom_lethal_cd:RemoveOnDeath() return false end
function modifier_skywrath_mage_arcane_bolt_custom_lethal_cd:IsDebuff() return true end
function modifier_skywrath_mage_arcane_bolt_custom_lethal_cd:OnCreated()
self.RemoveForDuel = true
end

