--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_nevermore_frenzy_custom","abilities/shadow_fiend/nevermore_frenzy_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_frenzy_custom_shield","abilities/shadow_fiend/nevermore_frenzy_custom", LUA_MODIFIER_MOTION_NONE)



nevermore_frenzy_custom = class({})

function nevermore_frenzy_custom:GetManaCost(level)
if self:GetCaster():HasShard() then  
  return 0
end
return self.BaseClass.GetManaCost(self,level) 
end

function nevermore_frenzy_custom:GetCooldown(iLevel)
local upgrade_cooldown = 0 
if self:GetCaster():HasTalent("modifier_nevermore_souls_1") then 
  upgrade_cooldown = self:GetCaster():GetTalentValue("modifier_nevermore_souls_1", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown
end


function nevermore_frenzy_custom:GetBehavior()
local caster = self:GetCaster()
local cost = self:GetSpecialValueFor("soul_cost")

if not caster:HasModifier("modifier_slark_saltwater_shiv_custom_legendary_steal") and
	not caster:HasShard() and (not caster:HasModifier("modifier_custom_necromastery_souls") or caster:GetUpgradeStack("modifier_custom_necromastery_souls") < cost) then 
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end


function nevermore_frenzy_custom:OnAbilityPhaseStart()
if self:IsStolen() then return true end

CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetCaster():GetPlayerID()), "CreateIngameErrorMessage", {message = "#no_souls"})
return false
end


function nevermore_frenzy_custom:OnSpellStart()

local caster = self:GetCaster()
local duration = self:GetSpecialValueFor("duration") + caster:GetTalentValue("modifier_nevermore_souls_4", "duration")

if caster:HasTalent("modifier_nevermore_souls_7") then 
	caster:EmitSound("Sf.Souls_Legendary")
end
caster:EmitSound("Hero_Nevermore.Frenzy")
caster:RemoveModifierByName("modifier_custom_necromastery_tempo_track")
caster:AddNewModifier(caster, self, "modifier_nevermore_frenzy_custom", {duration = duration})

if caster:HasTalent("modifier_nevermore_souls_1") then
	caster:AddNewModifier(caster, self, "modifier_nevermore_frenzy_custom_shield", {duration = duration})
end

end



modifier_nevermore_frenzy_custom = class({})
function modifier_nevermore_frenzy_custom:IsHidden() return false end
function modifier_nevermore_frenzy_custom:IsPurgable() return false end
function modifier_nevermore_frenzy_custom:OnCreated(table)
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.silence = false

self.speed = self.ability:GetSpecialValueFor("bonus_attack_speed") + self.caster:GetTalentValue("modifier_nevermore_souls_2", "speed")
self.cast = self.ability:GetSpecialValueFor("cast_inc")
self.cost = self.ability:GetSpecialValueFor("soul_cost")
self.status = self.caster:GetTalentValue("modifier_nevermore_souls_3", "status")
self.move = self.ability:GetSpecialValueFor("move_speed") + self.caster:GetTalentValue("modifier_nevermore_souls_3", "move")

self.range = self.caster:GetTalentValue("modifier_nevermore_souls_7", "range", true)
self.vision_radius = self.caster:GetTalentValue("modifier_nevermore_souls_7", "vision", true)
if not IsServer() then return end 

self.RemoveForDuel = true

if self.caster:HasTalent("modifier_nevermore_souls_7") then 

	self.wings_particle = self.caster:GenericParticle("particles/sf_wings.vpcf", self) 

	self.hands = ParticleManager:CreateParticle("particles/sf_hands_.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
	ParticleManager:SetParticleControlEnt(self.hands, 0 , self.caster, PATTACH_ABSORIGIN_FOLLOW, "follow_origin", self.caster:GetOrigin(),false)
	self:AddParticle(self.hands,true,false,0,false,false)

	local mod = self.caster:FindModifierByName("modifier_custom_necromastery_souls")
	local souls = 0
	if mod then 
		souls = mod:GetStackCount()
	end
	self.effect = self.caster:GenericParticle("particles/sf_souls_souls.vpcf", self) 
	ParticleManager:SetParticleControl(self.effect, 1, Vector(souls, 0, 0))
	self.interval = 0.2

	self:StartIntervalThink(self.interval)
end

self.ability:EndCd()
self.caster:GenericParticle("particles/items2_fx/mask_of_madness.vpcf", self)
end



function modifier_nevermore_frenzy_custom:OnIntervalThink()
if not IsServer() then return end 

AddFOWViewer(self.caster:GetTeamNumber(), self.caster:GetAbsOrigin(), self.vision_radius, self.interval*2, false)

if self.wings_particle and self:GetElapsedTime() >= 4 then 
	ParticleManager:DestroyParticle(self.wings_particle, false)
	ParticleManager:ReleaseParticleIndex(self.wings_particle)
	self.wings_particle = nil  
end

end



function modifier_nevermore_frenzy_custom:OnDestroy()
if not IsServer() then return end 
local mod = self.caster:FindModifierByName("modifier_custom_necromastery_souls")

if mod and not self.caster:HasShard() then 
	mod:ReduceStack(self.cost)
end

local tempo = self.caster:FindModifierByName("modifier_custom_necromastery_tempo_track")
if tempo then 
	tempo:SetDuration(self.caster:GetTalentValue("modifier_nevermore_souls_7", "duration"), true)
end

self.ability:StartCd()
end


function modifier_nevermore_frenzy_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_PROJECTILE_NAME,
	MODIFIER_PROPERTY_CASTTIME_PERCENTAGE,
	MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
}
end


function modifier_nevermore_frenzy_custom:GetModifierStatusResistanceStacking()
if not self.caster:HasTalent("modifier_nevermore_souls_3") then return end
return self.status
end

function modifier_nevermore_frenzy_custom:GetModifierMoveSpeedBonus_Percentage()
return self.move
end

function modifier_nevermore_frenzy_custom:GetModifierAttackRangeBonus()
if not self.caster:HasTalent("modifier_nevermore_souls_7") then return end
return self.range
end

function modifier_nevermore_frenzy_custom:GetPriority()
if not self:GetParent():HasTalent("modifier_nevermore_souls_7") then return MODIFIER_PRIORITY_LOW end
return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_nevermore_frenzy_custom:GetModifierProjectileName()
if not self:GetParent():HasTalent("modifier_nevermore_souls_7") then return end
return "particles/units/heroes/hero_nevermore/sf_necromastery_attack.vpcf"
end

function modifier_nevermore_frenzy_custom:GetModifierAttackSpeedBonus_Constant()
return self.speed
end

function modifier_nevermore_frenzy_custom:GetModifierPercentageCasttime()
if not self.caster:HasShard() then return end
return self.cast
end





modifier_nevermore_frenzy_custom_shield = class({})
function modifier_nevermore_frenzy_custom_shield:IsHidden() return true end
function modifier_nevermore_frenzy_custom_shield:IsPurgable() return false end
function modifier_nevermore_frenzy_custom_shield:OnCreated(table)

self.caster = self:GetCaster()
self.parent = self:GetParent()
self.shield_talent = "modifier_nevermore_souls_1"
self.max_shield = self.caster:GetTalentValue("modifier_nevermore_souls_1", "shield")*self.caster:GetMaxHealth()/100

if not IsServer() then return end
self.caster:GenericParticle("particles/items4_fx/ascetic_cap.vpcf", self)

self.RemoveForDuel = true
self:SetStackCount(self.max_shield)
end

function modifier_nevermore_frenzy_custom_shield:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end

function modifier_nevermore_frenzy_custom_shield:GetModifierIncomingDamageConstant( params )

if IsClient() then 
  if params.report_max then 
    return self.max_shield
  else 
      return self:GetStackCount()
    end 
end

if not IsServer() then return end
if self.caster == params.attacker then return end

local damage = math.min(params.damage, self:GetStackCount())
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self:SetStackCount(self:GetStackCount() - damage)
if self:GetStackCount() <= 0 then
  self:Destroy()
end

return -damage
end



