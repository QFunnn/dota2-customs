--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_troll_warlord_battle_trance_custom", "abilities/troll_warlord/troll_warlord_battle_trance_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_battle_trance_custom_tracker", "abilities/troll_warlord/troll_warlord_battle_trance_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_battle_trance_custom_slow", "abilities/troll_warlord/troll_warlord_battle_trance_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_battle_trance_custom_aura", "abilities/troll_warlord/troll_warlord_battle_trance_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_battle_trance_custom_damage", "abilities/troll_warlord/troll_warlord_battle_trance_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_battle_trance_custom_cd", "abilities/troll_warlord/troll_warlord_battle_trance_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_battle_trance_custom_legendary", "abilities/troll_warlord/troll_warlord_battle_trance_custom", LUA_MODIFIER_MOTION_NONE)



troll_warlord_battle_trance_custom = class({})


function troll_warlord_battle_trance_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/units/heroes/hero_troll_warlord/troll_warlord_battletrance_cast.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_troll_warlord/troll_warlord_battletrance_buff.vpcf", context )
PrecacheResource( "particle","particles/troll_warlord/troll_linken_buff.vpcf", context )
PrecacheResource( "particle","particles/troll_warlord/troll_linken.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_troll_warlord_battletrance.vpcf", context )
PrecacheResource( "particle","particles/roshan_meteor_burn_.vpcf", context )
PrecacheResource( "particle","particles/huskar_grave.vpcf", context )
PrecacheResource( "particle","particles/troll_hit.vpcf", context )
PrecacheResource( "particle","particles/troll_warlord/trance_legendary.vpcf", context )
end



function troll_warlord_battle_trance_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_troll_warlord_battle_trance_custom_tracker"
end


function troll_warlord_battle_trance_custom:GetCooldown(iLevel)
local bonus = 0
if self:GetCaster():HasTalent("modifier_troll_trance_1") then 
	bonus = self:GetCaster():GetTalentValue("modifier_troll_trance_1", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + bonus
end


function troll_warlord_battle_trance_custom:GetBehavior()
local bonus = 0
if self:GetCaster():HasTalent("modifier_troll_trance_legendary") then
  bonus = DOTA_ABILITY_BEHAVIOR_AUTOCAST
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + bonus
end


function troll_warlord_battle_trance_custom:OnSpellStart()

local caster = self:GetCaster()

local target = nil
if self:GetCursorTarget() ~= nil then 
	target = self:GetCursorTarget()
end

local trance_duration	= self:GetSpecialValueFor("trance_duration") + caster:GetTalentValue("modifier_troll_trance_4", "duration")

caster:RemoveModifierByName("modifier_troll_warlord_battle_trance_custom_damage")
caster:RemoveModifierByName("modifier_troll_warlord_battle_trance_custom")

if caster:HasTalent("modifier_troll_trance_4") then
	local stack = caster:GetTalentValue("modifier_troll_trance_4", "damage")*(1 - caster:GetHealthPercent()/100)
	if stack > 0 then
		caster:AddNewModifier(caster, self, "modifier_troll_warlord_battle_trance_custom_damage", {stack = stack, duration = trance_duration + caster:GetTalentValue("modifier_troll_trance_4", "linger")})
	end
end

caster:EmitSound("Hero_TrollWarlord.BattleTrance.Cast")
caster:AddNewModifier(caster, self, "modifier_troll_warlord_battle_trance_custom", {auto = 0, duration = trance_duration})
caster:Purge(false, true, false, false, false)

local cast_pfx = ParticleManager:CreateParticle( "particles/units/heroes/hero_troll_warlord/troll_warlord_battletrance_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
ParticleManager:SetParticleControlEnt(cast_pfx, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc" , caster:GetOrigin(), true )
ParticleManager:Delete(cast_pfx, 1)
caster:StartGesture(ACT_DOTA_CAST_ABILITY_4)
end




modifier_troll_warlord_battle_trance_custom = class({})
function modifier_troll_warlord_battle_trance_custom:IsPurgable()	return false end
function modifier_troll_warlord_battle_trance_custom:GetEffectName() return "particles/units/heroes/hero_troll_warlord/troll_warlord_battletrance_buff.vpcf" end
function modifier_troll_warlord_battle_trance_custom:GetStatusEffectName() return "particles/status_fx/status_effect_troll_warlord_battletrance.vpcf" end
function modifier_troll_warlord_battle_trance_custom:StatusEffectPriority() return MODIFIER_PRIORITY_SUPER_ULTRA  end

function modifier_troll_warlord_battle_trance_custom:OnCreated(table)
self.ability	= self:GetAbility()
self.parent		= self:GetParent()

self.attack_speed	= self.ability:GetSpecialValueFor("attack_speed")
self.movement_speed	= self.ability:GetSpecialValueFor("movement_speed")
self.range = self.ability:GetSpecialValueFor("range")

if not IsServer() then return end

self.block = false

if table.auto == 1 then
	self.parent:GenericParticle("particles/huskar_grave.vpcf", self)
else

	if self.parent:HasTalent("modifier_troll_trance_6") then 
		self.block = true
		self.particle = ParticleManager:CreateParticle("particles/troll_warlord/troll_linken_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
		ParticleManager:SetParticleControlEnt(self.particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
		self:AddParticle(self.particle, false, false, -1, false, true)
	end 
end

self.interval = 0.1

self.target = nil
self.RemoveForDuel = true
self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end


function modifier_troll_warlord_battle_trance_custom:GetAbsorbSpell(params) 
if params.ability:GetCaster():GetTeamNumber() == self.parent:GetTeamNumber() then return end
if self.parent ~= self.parent then return end
if self.block == false then return end 

self.block = false

local particle = ParticleManager:CreateParticle("particles/troll_warlord/troll_linken.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(particle)

self.parent:EmitSound("DOTA_Item.LinkensSphere.Activate")

if self.particle then 
	ParticleManager:Delete(self.particle, 1)
end

return 1 
end

function modifier_troll_warlord_battle_trance_custom:IsValidTarget(target)
if not IsServer() then return end 

if target and not target:IsNull() and not target:IsAttackImmune() and target:IsAlive() and not target:IsInvulnerable() and self.parent:CanEntityBeSeenByMyTeam(target)
  and target:IsUnit() and not target:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") and (target:IsHero() or target:IsCreep())
  and (target:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= 1500 then 

	return true
end 

return false
end 


function modifier_troll_warlord_battle_trance_custom:SetTarget(target)
if not IsServer() then return end 
if not self:IsValidTarget(target) then return end 

self.target = target
self.parent:MoveToTargetToAttack(self.target)
end


function modifier_troll_warlord_battle_trance_custom:OnIntervalThink()
if not IsServer() then return end
if self.parent:HasTalent("modifier_troll_trance_6") then return end

local hero_enemies = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, FIND_CLOSEST, false)
local non_hero_enemies = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, FIND_CLOSEST, false)

if not self:IsValidTarget(self.target) then
	self.target = nil
end 

if #hero_enemies > 0 and (not self:IsValidTarget(self.target) or self.target:IsCreep()) then 
	for _,hero in pairs(hero_enemies) do 
		self:SetTarget(hero)
		if self.target then 
			break
		end 
	end 
end 

if self.target == nil and #non_hero_enemies > 0 then 
	for _,creep in pairs(non_hero_enemies) do 
		self:SetTarget(creep)
		if self.target then 
			break
		end 
	end 
end 

if self.target == nil then 
	self.parent:SetForceAttackTarget(nil)
else 
	AddFOWViewer(self.parent:GetTeamNumber(), self.target:GetAbsOrigin(), 10, self.interval*2, false)
	self.parent:MoveToTargetToAttack(self.target)
end

end


function modifier_troll_warlord_battle_trance_custom:OnDestroy()
if not IsServer() then return end

if not self.parent:HasTalent("modifier_troll_trance_6") then 
	self.parent:SetForceAttackTarget(nil)
end

if self.parent:HasTalent("modifier_troll_trance_5") then
	self.parent:EmitSound("Troll.Trance_heal")
	self.parent:GenericParticle("particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf")
	self.parent:GenericHeal(self.parent:GetMaxHealth()*self.parent:GetTalentValue("modifier_troll_trance_5", "heal")/100, self.ability, nil, nil, "modifier_troll_trance_5")
end

end


function modifier_troll_warlord_battle_trance_custom:CheckState()
local table_state =
{
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true
}

if not self.parent:HasTalent("modifier_troll_trance_6") and self.target ~= nil then 
	table_state[MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true
end

return table_state
end


function modifier_troll_warlord_battle_trance_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
	MODIFIER_PROPERTY_MIN_HEALTH,
	MODIFIER_PROPERTY_ABSORB_SPELL
}
end


function modifier_troll_warlord_battle_trance_custom:GetModifierAttackSpeedBonus_Constant()
return self.attack_speed
end

function modifier_troll_warlord_battle_trance_custom:GetModifierMoveSpeedBonus_Percentage()
return self.movement_speed
end

function modifier_troll_warlord_battle_trance_custom:GetModifierIgnoreCastAngle()
return 1
end

function modifier_troll_warlord_battle_trance_custom:GetMinHealth()
if self.parent:HasModifier("modifier_death") then return end
if not self.parent:IsAlive() then return end
return 1
end






modifier_troll_warlord_battle_trance_custom_tracker = class({})
function modifier_troll_warlord_battle_trance_custom_tracker:IsHidden() return self:GetStackCount() == 1 or not self.parent:HasTalent("modifier_troll_trance_1") end
function modifier_troll_warlord_battle_trance_custom_tracker:IsPurgable() return false end
function modifier_troll_warlord_battle_trance_custom_tracker:GetTexture() return "buffs/duel_lowhp" end
function modifier_troll_warlord_battle_trance_custom_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MIN_HEALTH,
	MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	MODIFIER_PROPERTY_HEALTH_BONUS,
  MODIFIER_PROPERTY_MOVESPEED_LIMIT,
  MODIFIER_PROPERTY_MOVESPEED_MAX,
  MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
}
end


function modifier_troll_warlord_battle_trance_custom_tracker:GetModifierHealthBonus()
if self:GetStackCount() == 1 then return end 
return self.health_bonus
end
   


function modifier_troll_warlord_battle_trance_custom_tracker:OnCreated()

self.parent = self:GetParent()
self.ability = self:GetAbility()
 
self.legendary_radius = self.parent:GetTalentValue("modifier_troll_trance_legendary", "radius", true)

self.max_inc = self.parent:GetTalentValue("modifier_troll_trance_6", "move", true)
self.move_max = self.parent:GetTalentValue("modifier_troll_trance_6", "move_real", true)

self.aoe_radius = self.parent:GetTalentValue("modifier_troll_trance_3", "radius", true)
self.aoe_slow = self.parent:GetTalentValue("modifier_troll_trance_3", "duration", true)
self.aoe_chance = self.parent:GetTalentValue("modifier_troll_trance_3", "chance", true)
self.aoe_bonus = self.parent:GetTalentValue("modifier_troll_trance_3", "bonus", true)

self.health_bonus = 0
self.lifesteal = self.ability:GetSpecialValueFor("lifesteal") / 100
self.lifesteal_creeps = self.parent:GetTalentValue("modifier_troll_trance_2", "creeps", true)
self.parent:AddDamageEvent_inc(self)
self.parent:AddDamageEvent_out(self)

if not IsServer() then return end

self:SetHasCustomTransmitterData(true)
self:UpdateTalent()
end 

function modifier_troll_warlord_battle_trance_custom_tracker:OnRefresh(table)
self.lifesteal = self.ability:GetSpecialValueFor("lifesteal") / 100
end


function modifier_troll_warlord_battle_trance_custom_tracker:UpdateTalent(name)
self.lifesteal_bonus = self.parent:GetTalentValue("modifier_troll_trance_2", "heal")/100

self.health_bonus = self.parent:GetTalentValue("modifier_troll_trance_1", "health")

self.aoe_damage = self.parent:GetTalentValue("modifier_troll_trance_3", "damage")

if name == "modifier_troll_trance_3" or self.parent:HasTalent("modifier_troll_trance_3") then
	self.parent:AddAttackEvent_out(self)
end

if name == "modifier_troll_trance_1" or self.parent:HasTalent("modifier_troll_trance_1") then
	self:StartIntervalThink(0.5)
end

self:SendBuffRefreshToClients()
end

function modifier_troll_warlord_battle_trance_custom_tracker:OnIntervalThink()
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_troll_trance_1") then return end 

local stack = 1

if self.ability:GetCooldownTimeRemaining() > 0 then 
  stack = 0
end 

if stack ~= self:GetStackCount() then 
  self:SetStackCount(stack)
  self.parent:CalculateStatBonus(true)
end

self:StartIntervalThink(0.5)
end


function modifier_troll_warlord_battle_trance_custom_tracker:AddCustomTransmitterData() 
return 
{
  health_bonus = self.health_bonus,
} 
end

function modifier_troll_warlord_battle_trance_custom_tracker:HandleCustomTransmitterData(data)
self.health_bonus = data.health_bonus
end


function modifier_troll_warlord_battle_trance_custom_tracker:GetMinHealth()
if not IsServer() then return end
if not self.parent:IsAlive() then return end
if self.parent:LethalDisabled() then return end
if self.parent:PassivesDisabled() then return end
if not self.parent:HasTalent("modifier_troll_trance_5") then return end
if self.parent:HasModifier("modifier_troll_warlord_battle_trance_custom_cd") then return end 

return 1
end


function modifier_troll_warlord_battle_trance_custom_tracker:AttackEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_troll_trance_3") then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

local chance = self.aoe_chance
if self.parent:HasModifier("modifier_troll_warlord_battle_trance_custom") then
	chance = chance*self.aoe_bonus
end
if not RollPseudoRandomPercentage(chance, 3520, self.parent) then return end

local damageTable = {attacker = self.parent, damage = self.aoe_damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability}

local particle = ParticleManager:CreateParticle("particles/troll_hit.vpcf", PATTACH_WORLDORIGIN, nil)	
ParticleManager:SetParticleControl(particle, 0, params.target:GetAbsOrigin())
ParticleManager:Delete(particle, 1)

for _,target in pairs(self.parent:FindTargets(self.aoe_radius, params.target:GetAbsOrigin())) do
	damageTable.victim = target
	DoDamage(damageTable, "modifier_troll_trance_3")
	target:SendNumber(4, self.aoe_damage)

	target:AddNewModifier(self.parent, self.ability, "modifier_troll_warlord_battle_trance_custom_slow", {duration = self.aoe_slow})
end

end


function modifier_troll_warlord_battle_trance_custom_tracker:DamageEvent_out(params)
if not IsServer() then return end

local mod = self.parent:FindModifierByName("modifier_troll_warlord_battle_trance_custom")

if (mod or self.parent:HasTalent("modifier_troll_trance_2")) and self.parent:CheckLifesteal(params) then

	local heal = 0
	local hide_number = true
	local effect = ""
	if mod then
		effect = nil
		hide_number = false
		heal = self.lifesteal
	end

	if self.parent:HasTalent("modifier_troll_trance_2") then
		heal = heal + self.lifesteal_bonus * (1 - self.parent:GetHealthPercent()/100)
	end

	heal = heal*params.damage
	if params.unit:IsCreep() then
		heal = heal/self.lifesteal_creeps
	end

	self.parent:GenericHeal(heal, self.ability, hide_number, effect)
end

end


function modifier_troll_warlord_battle_trance_custom_tracker:DamageEvent_inc(params)
if not IsServer() then return end
if self.parent:PassivesDisabled() then return end
if self.parent ~= params.unit then return end
if not self.parent:HasTalent("modifier_troll_trance_5") then return end
if self.parent:GetHealth() > 1 then return end
if self.parent:HasModifier("modifier_troll_warlord_battle_trance_custom_cd") then return end 
if self.parent:HasModifier("modifier_troll_warlord_battle_trance_custom") then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_troll_warlord_battle_trance_custom_cd", {duration = self.parent:GetTalentValue("modifier_troll_trance_5", "cd")})

self.parent:EmitSound("Hero_TrollWarlord.BattleTrance.Cast")
self.parent:AddNewModifier(self.parent, self.ability, "modifier_troll_warlord_battle_trance_custom", {auto = 1, duration = self.parent:GetTalentValue("modifier_troll_trance_5", "duration")})
end


function modifier_troll_warlord_battle_trance_custom_tracker:GetModifierIgnoreMovespeedLimit( params )
if self.parent:HasTalent("modifier_troll_trance_6") then return 1 end
return 0
end


function modifier_troll_warlord_battle_trance_custom_tracker:GetModifierMoveSpeed_Max( params )
if self.parent:HasTalent("modifier_troll_trance_6") then return self.move_max end
return 
end


function modifier_troll_warlord_battle_trance_custom_tracker:GetModifierMoveSpeed_Limit()
if self.parent:HasTalent("modifier_troll_trance_6") then return self.move_max end
return 
end


function modifier_troll_warlord_battle_trance_custom_tracker:GetAuraDuration() return 0.5 end
function modifier_troll_warlord_battle_trance_custom_tracker:GetAuraRadius() return self.legendary_radius end
function modifier_troll_warlord_battle_trance_custom_tracker:GetAuraSearchFlags() return 0 end
function modifier_troll_warlord_battle_trance_custom_tracker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_troll_warlord_battle_trance_custom_tracker:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_troll_warlord_battle_trance_custom_tracker:GetModifierAura() return "modifier_troll_warlord_battle_trance_custom_aura" end
function modifier_troll_warlord_battle_trance_custom_tracker:IsAura() return self.parent:HasTalent("modifier_troll_trance_legendary") end



modifier_troll_warlord_battle_trance_custom_aura = class({})
function modifier_troll_warlord_battle_trance_custom_aura:IsHidden() return true end
function modifier_troll_warlord_battle_trance_custom_aura:IsPurgable() return false end
function modifier_troll_warlord_battle_trance_custom_aura:OnCreated()
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.interval = self.caster:GetTalentValue("modifier_troll_trance_legendary", "interval")
self.damage = self.caster:GetTalentValue("modifier_troll_trance_legendary", "damage")*self.interval/100

if not IsServer() then return end 

self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}

self.parent:GenericParticle("particles/roshan_meteor_burn_.vpcf", self)
self:StartIntervalThink(self.interval)
end

function modifier_troll_warlord_battle_trance_custom_aura:OnIntervalThink()
if not IsServer() then return end 

local damage = self.damage*(self.caster:GetMaxHealth() - self.caster:GetHealth())
if damage < 1 then return end

self.damageTable.damage = damage
DoDamage(self.damageTable, "modifier_troll_trance_legendary")
end





modifier_troll_warlord_battle_trance_custom_cd = class({})
function modifier_troll_warlord_battle_trance_custom_cd:IsHidden() return false end
function modifier_troll_warlord_battle_trance_custom_cd:IsPurgable() return false end
function modifier_troll_warlord_battle_trance_custom_cd:RemoveOnDeath() return false end
function modifier_troll_warlord_battle_trance_custom_cd:IsDebuff() return true end
function modifier_troll_warlord_battle_trance_custom_cd:GetTexture() return "buffs/trance_cd" end
function modifier_troll_warlord_battle_trance_custom_cd:OnCreated(table)
self.RemoveForDuel = true 
end

modifier_troll_warlord_battle_trance_custom_slow = class({})
function modifier_troll_warlord_battle_trance_custom_slow:IsHidden() return true end
function modifier_troll_warlord_battle_trance_custom_slow:IsPurgable() return false end
function modifier_troll_warlord_battle_trance_custom_slow:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_troll_trance_3", "slow")
end

function modifier_troll_warlord_battle_trance_custom_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_troll_warlord_battle_trance_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end



modifier_troll_warlord_battle_trance_custom_legendary = class({})
function modifier_troll_warlord_battle_trance_custom_legendary:IsHidden() return false end
function modifier_troll_warlord_battle_trance_custom_legendary:IsPurgable() return false end
function modifier_troll_warlord_battle_trance_custom_legendary:RemoveOnDeath() return false end
function modifier_troll_warlord_battle_trance_custom_legendary:IsDebuff() return true end
function modifier_troll_warlord_battle_trance_custom_legendary:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.cost = self.parent:GetTalentValue("modifier_troll_trance_legendary", "cost")/100
self.cd_inc = self.parent:GetTalentValue("modifier_troll_trance_legendary", "cd_inc")/100

self.interval = 1
self.start_interval = 0.15

if not IsServer() then return end
self.effect = nil
self:StartIntervalThink(self.start_interval)
end

function modifier_troll_warlord_battle_trance_custom_legendary:OnIntervalThink()
if not IsServer() then return end

if not self.effect then
	self.parent:EmitSound("Troll.Trance_legendary")
	self.effect = self.parent:GenericParticle("particles/troll_warlord/trance_legendary.vpcf", self)
	self:StartIntervalThink(self.interval - self.start_interval)
	return
end

if not self.parent:IsAlive() then return end

local cost = self.parent:GetMaxHealth()*self.cost
self.parent:SetHealth(math.max(1, self.parent:GetHealth() - cost))

if self.ability:GetCooldownTimeRemaining() > 0 then
	local cd = self.ability:GetEffectiveCooldown(self.ability:GetLevel())*self.cd_inc
	self.parent:CdAbility(self.ability, cd)
end

self:StartIntervalThink(self.interval)
end




modifier_troll_warlord_battle_trance_custom_damage = class({})
function modifier_troll_warlord_battle_trance_custom_damage:IsHidden() return false end
function modifier_troll_warlord_battle_trance_custom_damage:IsPurgable() return false end
function modifier_troll_warlord_battle_trance_custom_damage:GetTexture() return "buffs/trance_slow" end
function modifier_troll_warlord_battle_trance_custom_damage:OnCreated(table)
self.parent = self:GetParent()
if not IsServer() then return end
self:SetStackCount(table.stack)
end


function modifier_troll_warlord_battle_trance_custom_damage:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_troll_warlord_battle_trance_custom_damage:GetModifierDamageOutgoing_Percentage()
return self:GetStackCount()
end

function modifier_troll_warlord_battle_trance_custom_damage:GetModifierSpellAmplify_Percentage()
return self:GetStackCount()
end