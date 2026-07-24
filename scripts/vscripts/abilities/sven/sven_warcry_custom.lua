--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_sven_warcry_custom", "abilities/sven/sven_warcry_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_warcry_custom_armor", "abilities/sven/sven_warcry_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_warcry_custom_burn", "abilities/sven/sven_warcry_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_warcry_custom_slow", "abilities/sven/sven_warcry_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_warcry_custom_unslow", "abilities/sven/sven_warcry_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_warcry_custom_resist", "abilities/sven/sven_warcry_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_warcry_custom_tracker", "abilities/sven/sven_warcry_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_warcry_custom_legendary", "abilities/sven/sven_warcry_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_warcry_custom_quest", "abilities/sven/sven_warcry_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_warcry_custom_legendary_recast", "abilities/sven/sven_warcry_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_warcry_custom_legendary_barrier", "abilities/sven/sven_warcry_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_warcry_custom_legendary_barrier_knock_cd", "abilities/sven/sven_warcry_custom", LUA_MODIFIER_MOTION_NONE )

sven_warcry_custom = class({})



function sven_warcry_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/cleance_blade.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sven/sven_spell_warcry.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sven/sven_warcry_buff.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/medallion_of_courage_friend_shield.vpcf", context )
PrecacheResource( "particle","particles/general/generic_armor_reduction.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_marci/marci_rebound_bounce_impact_debuff.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_snapfire_slow.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sven/sven_warcry_buff_shield.vpcf", context )
PrecacheResource( "particle","particles/sven_shield_break.vpcf", context )
PrecacheResource( "particle","particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_static_field_gold.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_pointblank_impact_sparks.vpcf", context )
PrecacheResource( "particle","particles/econ/items/sven/sven_warcry_ti5/sven_warcry_cast_arc_lightning.vpcf", context )
PrecacheResource( "particle","particles/sven/warcry_barrier.vpcf", context )
PrecacheResource( "particle","particles/sven/warcry_unslow.vpcf", context )
PrecacheResource( "particle","particles/sven/cry_radiance.vpcf", context )

end

function sven_warcry_custom:GetManaCost(iLevel)
if self:GetCaster():HasModifier("modifier_sven_warcry_custom_legendary_recast") or self:GetCaster():HasShard() then 
	return 0
end
return self.BaseClass.GetManaCost( self, iLevel)
end

function sven_warcry_custom:GetCastRange(vLocation, hTarget)
return self:GetSpecialValueFor("radius")
end

function sven_warcry_custom:GetBehavior()
if self:GetCaster():HasModifier("modifier_sven_warcry_custom_legendary_recast") then 
	return DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE
end
return DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function sven_warcry_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_sven_warcry_custom_tracker"
end

function sven_warcry_custom:GetCooldown(iLevel)
local bonus = 0
if self:GetCaster():HasTalent("modifier_sven_cry_2") then
	bonus = self:GetCaster():GetTalentValue("modifier_sven_cry_2", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + bonus
end


function sven_warcry_custom:GetArmor()
return self:GetSpecialValueFor( "bonus_armor" ) + self:GetCaster():GetTalentValue("modifier_sven_cry_1", "armor")
end

function sven_warcry_custom:GetSpeed()
return self:GetSpecialValueFor( "movespeed" ) + self:GetCaster():GetTalentValue("modifier_sven_cry_3", "move")
end


function sven_warcry_custom:OnSpellStart()
local caster = self:GetCaster()

local mod = caster:FindModifierByName("modifier_sven_warcry_custom_legendary_recast")

if mod then
	local duration = caster:GetTalentValue("modifier_sven_cry_7", "duration")
	local thinker = CreateModifierThinker(caster, self, "modifier_sven_warcry_custom_legendary_barrier", {duration = duration}, caster:GetAbsOrigin(), caster:GetTeamNumber(), false)
	caster:AddNewModifier(caster, self, "modifier_sven_warcry_custom_legendary", {duration = duration, thinker = thinker:entindex()})
	mod:Destroy()
	self:EndCd()
	return
end

local warcry_radius = self:GetSpecialValueFor("radius") 
local warcry_duration = self:GetSpecialValueFor("duration") + caster:GetTalentValue("modifier_sven_cry_2", "duration")

if caster:GetQuest() == "Sven.Quest_7" and not caster:QuestCompleted() then 
	caster:AddNewModifier(caster, self, "modifier_sven_warcry_custom_quest", {duration = caster.quest.number})
end

if caster:HasShard() then 
	caster:Purge(false, true, false, false, false)
end

local allies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetOrigin(), caster, warcry_radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false )

for _,ally in pairs(allies) do
	ally:AddNewModifier( caster, self, "modifier_sven_warcry_custom", { duration = warcry_duration } )

	if caster:HasTalent("modifier_sven_cry_5") then
		ally:AddNewModifier(caster, self, "modifier_sven_warcry_custom_unslow", {duration = caster:GetTalentValue("modifier_sven_cry_5", "duration")})
	end
end

if caster:GetName() == "npc_dota_hero_sven" then
	caster:EmitSound("sven_sven_ability_warcry_0"..RandomInt(1, 4))
end


if caster:HasTalent("modifier_sven_cry_7") then
	caster:AddNewModifier(caster, self, "modifier_sven_warcry_custom_legendary_recast", {duration = warcry_duration})
	self:EndCd(0)
	self:StartCooldown(0.3)
else
	self:EndCd()
end


local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_sven/sven_spell_warcry.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
ParticleManager:SetParticleControlEnt( nFXIndex, 2, caster, PATTACH_POINT_FOLLOW, "attach_head", caster:GetOrigin(), true )
ParticleManager:ReleaseParticleIndex( nFXIndex )

caster:EmitSound("Hero_Sven.WarCry")

caster:StartGesture( ACT_DOTA_OVERRIDE_ABILITY_3 )
end





modifier_sven_warcry_custom = class({})

function modifier_sven_warcry_custom:IsHidden() return false end
function modifier_sven_warcry_custom:IsPurgable() return false end
function modifier_sven_warcry_custom:GetEffectName() return "particles/items2_fx/medallion_of_courage_friend_shield.vpcf" end
function modifier_sven_warcry_custom:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end

function modifier_sven_warcry_custom:OnCreated( kv )

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.warcry_armor = self.ability:GetArmor()
self.warcry_movespeed = self.ability:GetSpeed()

self.speed = self.caster:GetTalentValue("modifier_sven_cry_3", "speed")

self.regen = self.caster:GetTalentValue("modifier_sven_cry_1", "regen")/100

self.radius = self.parent:GetTalentValue("modifier_sven_cry_6", "radius", true)

if not IsServer() then return end

self.RemoveForDuel = true

local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_sven/sven_warcry_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( nFXIndex, 2, self.parent, PATTACH_POINT_FOLLOW, "attach_head", self.parent:GetOrigin(), true )
self:AddParticle( nFXIndex, false, false, -1, false, true )
end



function modifier_sven_warcry_custom:OnDestroy()
if not IsServer() then return end
if self.parent ~= self.caster then return end

self.parent:RemoveModifierByName("modifier_sven_warcry_custom_legendary_recast")
self.ability:StartCd()
end

function modifier_sven_warcry_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
}
end

function modifier_sven_warcry_custom:GetActivityTranslationModifiers()
if self.caster == self.parent then
	return "sven_warcry"
end
return 0
end

function modifier_sven_warcry_custom:GetModifierMoveSpeedBonus_Percentage()
return self.warcry_movespeed
end

function modifier_sven_warcry_custom:GetModifierPhysicalArmorBonus()
return self.warcry_armor
end

function modifier_sven_warcry_custom:GetModifierAttackSpeedBonus_Constant()
if not self.caster:HasTalent("modifier_sven_cry_3") then return end
return self.speed
end

function modifier_sven_warcry_custom:GetModifierConstantHealthRegen()
if not self.caster:HasTalent("modifier_sven_cry_1") then return end
return self.caster:GetPhysicalArmorValue(false)*self.regen
end

function modifier_sven_warcry_custom:GetAuraRadius()
return self.radius
end

function modifier_sven_warcry_custom:GetAuraSearchTeam()
return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_sven_warcry_custom:GetAuraSearchType() 
return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

function modifier_sven_warcry_custom:GetModifierAura()
return "modifier_sven_warcry_custom_slow"
end

function modifier_sven_warcry_custom:IsAura()
return self.parent:HasTalent("modifier_sven_cry_6")
end




modifier_sven_warcry_custom_armor = class({})
function modifier_sven_warcry_custom_armor:IsHidden() return false end
function modifier_sven_warcry_custom_armor:IsPurgable() return false end
function modifier_sven_warcry_custom_armor:GetTexture() return "buffs/cry_reduce" end

function modifier_sven_warcry_custom_armor:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max = self.caster:GetTalentValue("modifier_sven_cry_4", "max")
self.armor = self.caster:GetTalentValue("modifier_sven_cry_4", "armor")

if not IsServer() then return end
self:SetStackCount(1)
end



function modifier_sven_warcry_custom_armor:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()

if self:GetStackCount() >= self.max then
	self.parent:EmitSound("Hoodwink.Acorn_armor")
	self.parent:GenericParticle("particles/general/generic_armor_reduction.vpcf", self, true)
end

end 

function modifier_sven_warcry_custom_armor:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_sven_warcry_custom_armor:GetModifierPhysicalArmorBonus()
return self.armor*self:GetStackCount()
end




modifier_sven_warcry_custom_slow = class({})
function modifier_sven_warcry_custom_slow:IsHidden() return false end
function modifier_sven_warcry_custom_slow:IsPurgable() return false end
function modifier_sven_warcry_custom_slow:GetTexture() return "buffs/cry_lowhp" end

function modifier_sven_warcry_custom_slow:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()

self.slow = self.caster:GetTalentValue("modifier_sven_cry_6", "slow")
end


function modifier_sven_warcry_custom_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_sven_warcry_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_sven_warcry_custom_slow:GetEffectName()
return "particles/units/heroes/hero_marci/marci_rebound_bounce_impact_debuff.vpcf"
end

function modifier_sven_warcry_custom_slow:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_sven_warcry_custom_slow:GetStatusEffectName()
return "particles/status_fx/status_effect_snapfire_slow.vpcf"
end

function modifier_sven_warcry_custom_slow:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL
end


modifier_sven_warcry_custom_resist = class({})
function modifier_sven_warcry_custom_resist:IsHidden() return false end
function modifier_sven_warcry_custom_resist:IsPurgable() return false end
function modifier_sven_warcry_custom_resist:GetTexture() return "buffs/cry_lowhp" end
function modifier_sven_warcry_custom_resist:OnCreated()
self.parent = self:GetParent()
self.armor = self.parent:GetTalentValue("modifier_sven_cry_6", "armor")
self.magic = self.parent:GetTalentValue("modifier_sven_cry_6", "magic")
self.max = self.parent:GetTalentValue("modifier_sven_cry_6", "max")

if not IsServer() then return end
self:SetStackCount(1)
end


function modifier_sven_warcry_custom_resist:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end 

function modifier_sven_warcry_custom_resist:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_sven_warcry_custom_resist:GetModifierPhysicalArmorBonus()
return self.armor*self:GetStackCount()
end

function modifier_sven_warcry_custom_resist:GetModifierMagicalResistanceBonus()
return self.magic*self:GetStackCount()
end




modifier_sven_warcry_custom_tracker = class({})
function modifier_sven_warcry_custom_tracker:IsHidden() 
if not self:GetParent():HasModifier("modifier_sven_warcry_custom") and self:GetParent():HasShard() then
	return false
end
return true 
end

function modifier_sven_warcry_custom_tracker:IsPurgable() return false end

function modifier_sven_warcry_custom_tracker:OnCreated()

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:AddAttackEvent_out(self)

self.armor_duration = self.parent:GetTalentValue("modifier_sven_cry_4", "duration", true)

self.radius = self.parent:GetTalentValue("modifier_sven_cry_4", "radius", true)

self.status = self.parent:GetTalentValue("modifier_sven_cry_5", "status", true)
self.status_bonus = self.parent:GetTalentValue("modifier_sven_cry_5", "bonus", true)

self.armor_radius = self.parent:GetTalentValue("modifier_sven_cry_6", "radius", true)
self.resist_duration = self.parent:GetTalentValue("modifier_sven_cry_6", "duration", true)

self.shard_k = self.ability:GetSpecialValueFor("shard_k")/100

if not IsServer() then return end
self:StartIntervalThink(1)
end 

function modifier_sven_warcry_custom_tracker:OnIntervalThink()
if not IsServer() then return end

local mod = self.parent:FindModifierByName("modifier_sven_warcry_custom")
if not mod and not self.ability:IsActivated() then
	self.ability:StartCd()
end

if not self.parent:HasTalent("modifier_sven_cry_6") then return end
if not self.parent:IsAlive() then return end

local enemies = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.armor_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE,FIND_ANY_ORDER,false)

if #enemies > 0 then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_sven_warcry_custom_resist", {duration = self.resist_duration})
end

end

function modifier_sven_warcry_custom_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_sven_warcry_custom_tracker:GetModifierMoveSpeedBonus_Percentage()
if not self.parent:HasShard() then return end
if self.parent:HasModifier("modifier_sven_warcry_custom") then return end

return self.ability:GetSpeed()*self.shard_k
end

function modifier_sven_warcry_custom_tracker:GetModifierPhysicalArmorBonus()
if not self.parent:HasShard() then return end
if self.parent:HasModifier("modifier_sven_warcry_custom") then return end

return self.ability:GetArmor()*self.shard_k
end

function modifier_sven_warcry_custom_tracker:AttackEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_sven_cry_4") then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
if not self.parent:HasModifier("modifier_sven_warcry_custom") then return end

params.target:AddNewModifier(self.parent, self.ability, "modifier_sven_warcry_custom_armor", {duration = self.armor_duration})
end

function modifier_sven_warcry_custom_tracker:GetModifierStatusResistanceStacking() 
if not self.parent:HasTalent("modifier_sven_cry_5") then return end
local bonus = self.status
if self.parent:HasModifier("modifier_sven_warcry_custom_unslow") then
	bonus = self.status_bonus*bonus
end
return bonus
end

function modifier_sven_warcry_custom_tracker:GetAuraRadius()
return self.radius
end

function modifier_sven_warcry_custom_tracker:GetAuraSearchTeam()
return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_sven_warcry_custom_tracker:GetAuraSearchType() 
return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

function modifier_sven_warcry_custom_tracker:GetModifierAura()
return "modifier_sven_warcry_custom_burn"
end

function modifier_sven_warcry_custom_tracker:IsAura()
return self.parent:HasTalent("modifier_sven_cry_4")
end



modifier_sven_warcry_custom_unslow = class({})
function modifier_sven_warcry_custom_unslow:IsHidden() return true end
function modifier_sven_warcry_custom_unslow:IsPurgable() return false end
function modifier_sven_warcry_custom_unslow:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.speed = self.caster:GetTalentValue("modifier_sven_cry_5", "speed")
if not IsServer() then return end
self.parent:GenericParticle("particles/sven/warcry_unslow.vpcf", self)
end

function modifier_sven_warcry_custom_unslow:CheckState()
return
{
	[MODIFIER_STATE_UNSLOWABLE] = true,
}
end

function modifier_sven_warcry_custom_unslow:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
}
end

function modifier_sven_warcry_custom_unslow:GetModifierMoveSpeed_Absolute()
	return self.speed
end




modifier_sven_warcry_custom_legendary = class({})
function modifier_sven_warcry_custom_legendary:IsHidden() return false end
function modifier_sven_warcry_custom_legendary:IsPurgable() return false end
function modifier_sven_warcry_custom_legendary:GetTexture() return "buffs/cry_legendary" end
function modifier_sven_warcry_custom_legendary:OnCreated(table)

self.parent = self:GetParent()
self.shield_talent = "modifier_sven_cry_7"
self.max = math.max(1, self.parent:GetTalentValue("modifier_sven_cry_7", "shield")*self.parent:GetPhysicalArmorValue(false))

if not IsServer() then return end

self.thinker = EntIndexToHScript(table.thinker)

self.parent:EmitSound("Sven.Cry_shield_loop")
self.parent:EmitSound("UI.Generic_shield")

local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_sven/sven_warcry_buff_shield.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
ParticleManager:SetParticleControl( particle, 1, Vector( 110, 1, 1 ) )
self:AddParticle( particle, false, false, 0, false, false )

self.shield = self.max
self.max_time = self:GetRemainingTime()


self:SetStackCount(self.max)
self:OnIntervalThink()
self:StartIntervalThink(0.05)
end


function modifier_sven_warcry_custom_legendary:OnIntervalThink()
if not IsServer() then return end

self.parent:UpdateUIshort({time = self:GetRemainingTime(), max_time = self.max_time, stack = self:GetStackCount(), style = "SvenWarcry"})
end

function modifier_sven_warcry_custom_legendary:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end


function modifier_sven_warcry_custom_legendary:GetModifierIncomingDamageConstant( params )

if IsClient() then 
	if params.report_max then 
		return self.max
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


function modifier_sven_warcry_custom_legendary:OnDestroy()
if not IsServer() then return end

if self.thinker and not self.thinker:IsNull() and self:GetRemainingTime() > 0.1 then
	self.thinker:RemoveModifierByName("modifier_sven_warcry_custom_legendary_barrier")
end

self.parent:StopSound("Sven.Cry_shield_loop")
self.parent:UpdateUIshort({hide = 1, hide_full = 1, style = "SvenWarcry"})
end





modifier_sven_warcry_custom_quest = class({})
function modifier_sven_warcry_custom_quest:IsHidden() return true end
function modifier_sven_warcry_custom_quest:IsPurgable() return false end


modifier_sven_warcry_custom_legendary_recast = class({})
function modifier_sven_warcry_custom_legendary_recast:IsHidden() return true end
function modifier_sven_warcry_custom_legendary_recast:IsPurgable() return false end



modifier_sven_warcry_custom_legendary_barrier = class({})
function modifier_sven_warcry_custom_legendary_barrier:IsHidden() return true end
function modifier_sven_warcry_custom_legendary_barrier:IsPurgable() return false end
function modifier_sven_warcry_custom_legendary_barrier:OnCreated()
self.thinker = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.center = self.thinker:GetAbsOrigin()

self.radius = self.caster:GetTalentValue("modifier_sven_cry_7", "radius")
self.damage = self.caster:GetTalentValue("modifier_sven_cry_7", "damage")
self.stun = self.caster:GetTalentValue("modifier_sven_cry_7", "stun")

if not IsServer() then return end

EmitSoundOnLocationWithCaster(self.center, "Sven.Cry_barrier_start", self.caster)

self.particle = ParticleManager:CreateParticle("particles/sven/warcry_barrier.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.particle, 0, self.center)
ParticleManager:SetParticleControl(self.particle, 2, Vector(self.radius, 0, 0))
ParticleManager:SetParticleControl(self.particle, 7, self.center)
self:AddParticle(self.particle, false, false, -1, true, false)

local targets = self.caster:FindTargets(self.radius, self.center)
self.targets = {}

for _,target in pairs(targets) do
	if target:IsUnit() then
		self.targets[target] = true
	end
end

self:OnIntervalThink()
self:StartIntervalThink(0.05)
end


function modifier_sven_warcry_custom_legendary_barrier:OnDestroy()
if not IsServer() then return end
EmitSoundOnLocationWithCaster(self.center, "Sven.Cry_barrier_end", self.caster)

if self:GetRemainingTime() > 0.1 then return end

local pfx = ParticleManager:CreateParticle( "particles/sven_shield_break.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl( pfx, 0, self.center + Vector(0,0,70) )
ParticleManager:ReleaseParticleIndex(pfx)

EmitSoundOnLocationWithCaster(self.center, "Sven.Cry_shield_break", self.caster)
EmitSoundOnLocationWithCaster(self.center, "Sven.Cry_shield_break2", self.caster)

local enemies = self.caster:FindTargets(self.radius, self.center)
local damage = self.caster:GetPhysicalArmorValue(false)*self.damage

for _,enemy in pairs(enemies) do

	DoDamage({victim = enemy, attacker = self.caster, damage = damage, ability = self.ability, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK}, "modifier_sven_cry_7")
	enemy:SendNumber(4, damage)

	enemy:AddNewModifier(self.caster, self.caster:BkbAbility(self.ability, true), "modifier_stunned", {duration = self.stun*(1 - enemy:GetStatusResistance())})
	enemy:EmitSound("Sven.Cry_shield_damage")

	local particle = ParticleManager:CreateParticle( "particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_static_field_gold.vpcf", PATTACH_POINT_FOLLOW, enemy )
	ParticleManager:SetParticleControlEnt( particle, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:ReleaseParticleIndex( particle )

	local particle2 = ParticleManager:CreateParticle( "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_pointblank_impact_sparks.vpcf", PATTACH_POINT_FOLLOW, enemy )
	ParticleManager:SetParticleControlEnt( particle2, 4, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:ReleaseParticleIndex( particle2 )

	local pfx2 = ParticleManager:CreateParticle( "particles/econ/items/sven/sven_warcry_ti5/sven_warcry_cast_arc_lightning.vpcf", PATTACH_CUSTOMORIGIN, enemy)
	ParticleManager:SetParticleControl( pfx2, 0, enemy:GetAbsOrigin() )
	ParticleManager:ReleaseParticleIndex(pfx2)
end

end




function modifier_sven_warcry_custom_legendary_barrier:OnIntervalThink()
if not IsServer() then return end
if not self.thinker or self.thinker:IsNull() then return end

--if (self.caster:GetAbsOrigin() - self.center):Length2D() > self.radius then
--	self.caster:RemoveModifierByName("modifier_sven_warcry_custom_legendary")
--	self:Destroy()
--	return
--end

self:CheckPos(self.caster)

for target,_ in pairs(self.targets) do 
	if target and not target:IsNull() and target:IsAlive() and not target:IsInvulnerable() then
		self:CheckPos(target)
	end
end

local enemies = FindUnitsInRadius(self.caster:GetTeamNumber(), self.center, nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,FIND_ANY_ORDER,false)

for _,target in pairs(enemies) do 
  if not self.targets[target] and not target:HasModifier("modifier_sven_warcry_custom_legendary_barrier_knock_cd") then 

    local dir = target:GetAbsOrigin() - self.thinker:GetAbsOrigin() 
    local point = self.thinker:GetAbsOrigin() + dir:Normalized()*self.radius*1.2

    target:InterruptMotionControllers(false)
    self:ChangePos(target, point)
    target:AddNewModifier(target, nil, "modifier_sven_warcry_custom_legendary_barrier_knock_cd", {duration = 0.2})
  end
end

end 


function modifier_sven_warcry_custom_legendary_barrier:CheckPos(target)
if not IsServer() then return end

local radius = self.radius*0.9
local dir = (target:GetAbsOrigin() - self.thinker:GetAbsOrigin())

if dir:Length2D() > radius then 

  target:InterruptMotionControllers(false)
  local point = self.thinker:GetAbsOrigin() + dir:Normalized()*(radius*0.8)

  if dir:Length2D() > radius*1.4 then 
    FindClearSpaceForUnit(target, point, true)
  else 
    self:ChangePos(target, point)
  end
end 

end


function modifier_sven_warcry_custom_legendary_barrier:ChangePos(target, point)
if not IsServer() then return end

target:EmitSound("Sven.Cry_barrier_return")
local duration = 0.2
local distance = (target:GetAbsOrigin() - point):Length2D()
local knockbackProperties =
{
  target_x = point.x,
  target_y = point.y,
  distance = distance,
  speed = distance/duration,
  height = 0,
  fix_end = true,
  isStun = true,
  activity = ACT_DOTA_FLAIL,
}
target:AddNewModifier( self.caster, self.caster:BkbAbility(nil, true), "modifier_generic_arc", knockbackProperties )
end 



modifier_sven_warcry_custom_legendary_barrier_knock_cd = class({})
function modifier_sven_warcry_custom_legendary_barrier_knock_cd:IsHidden() return true end
function modifier_sven_warcry_custom_legendary_barrier_knock_cd:IsPurgable() return false end


modifier_sven_warcry_custom_burn = class({})
function modifier_sven_warcry_custom_burn:IsHidden() return true end
function modifier_sven_warcry_custom_burn:IsPurgable() return false end
function modifier_sven_warcry_custom_burn:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.damage = self.caster:GetTalentValue("modifier_sven_cry_4", "damage")/100
self.interval = self.caster:GetTalentValue("modifier_sven_cry_4", "interval")

if not IsServer() then return end

self.particle = ParticleManager:CreateParticle("particles/sven/cry_radiance.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.particle, 1, self.caster:GetAbsOrigin())
self:AddParticle(self.particle,false, false, -1, false, false)

self:StartIntervalThink(self.interval)
end

function modifier_sven_warcry_custom_burn:OnIntervalThink()
if not IsServer() then return end

if self.particle then
	ParticleManager:SetParticleControl(self.particle, 1, self.caster:GetAbsOrigin())
end

local damage = self.damage*self.interval*self.caster:GetPhysicalArmorValue(false)
DoDamage({victim = self.parent, attacker = self.caster, damage = damage, ability = self.ability, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK}, "modifier_sven_cry_4")
end