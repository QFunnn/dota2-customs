--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_puck_phase_shift", "abilities/puck/custom_puck_phase_shift", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_phase_shift_stun_cd", "abilities/puck/custom_puck_phase_shift", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_phase_shift_tracker", "abilities/puck/custom_puck_phase_shift", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_phase_shift_slow", "abilities/puck/custom_puck_phase_shift", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_phase_shift_legendary_damage", "abilities/puck/custom_puck_phase_shift", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_phase_shift_proc_attack", "abilities/puck/custom_puck_phase_shift", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_phase_shift_proc", "abilities/puck/custom_puck_phase_shift", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_phase_shift_shield", "abilities/puck/custom_puck_phase_shift", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_phase_shift_speed", "abilities/puck/custom_puck_phase_shift", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_phase_shift_absorb", "abilities/puck/custom_puck_phase_shift", LUA_MODIFIER_MOTION_NONE)


custom_puck_phase_shift = class({})

function custom_puck_phase_shift:CreateTalent(name)
self:ToggleAutoCast()
end

function custom_puck_phase_shift:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/status_fx/status_effect_dark_seer_illusion.vpcf", context )
PrecacheResource( "particle","particles/puck_phase_shift.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_puck/puck_phase_shift.vpcf", context )
PrecacheResource( "particle","particles/puck_shift_stun.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf", context )
PrecacheResource( "particle","particles/puck_stun.vpcf", context )
PrecacheResource( "particle","particles/econ/items/outworld_devourer/od_shards_exile/od_shards_exile_prison_end.vpcf", context )
PrecacheResource( "particle","particles/puck_resist.vpcf", context )
PrecacheResource( "particle","particles/puck_orb_speed.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_terrorblade/terrorblade_reflection_slow.vpcf", context )
PrecacheResource( "particle","particles/puck/shift_proc.vpcf", context )
PrecacheResource( "particle","particles/puck/shift_proj.vpcf", context )
PrecacheResource( "particle","particles/puck/shift_sphere.vpcf", context )

end


function custom_puck_phase_shift:GetCooldown(iLevel)
local bonus = 0
if self:GetCaster():HasTalent("modifier_puck_shift_5") then
	bonus = self:GetCaster():GetTalentValue("modifier_puck_shift_5", "cd_inc")
end
return self.BaseClass.GetCooldown( self, iLevel ) + bonus
end

function custom_puck_phase_shift:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_custom_puck_phase_shift_tracker"
end

function custom_puck_phase_shift:GetBehavior()
local bonus = 0
if self:GetCaster():HasTalent("modifier_puck_shift_6") then
	bonus = DOTA_ABILITY_BEHAVIOR_AUTOCAST
end
if self:GetCaster():HasTalent("modifier_puck_shift_7") then
  return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + bonus
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_CHANNELLED + bonus
end

function custom_puck_phase_shift:GetChannelTime()
if not self:GetCaster():HasTalent("modifier_puck_shift_7") then
	return self:GetDuration()
end

end

function custom_puck_phase_shift:GetDuration()
return self:GetSpecialValueFor("duration") + self:GetCaster():GetTalentValue("modifier_puck_shift_2", "duration_inc")
end


function custom_puck_phase_shift:OnSpellStart()
local caster = self:GetCaster()

if caster:HasShard() then 
  for _,enemy in pairs(caster:FindTargets(caster:Script_GetAttackRange())) do
		caster:PerformAttack(enemy, false, true, true, false, true, false, false)
  end
end

if caster:GetName() == "npc_dota_hero_puck" then
	caster:EmitSound("puck_puck_ability_phase_0"..RandomInt(1, 7))
end

if caster:HasTalent("modifier_puck_shift_6") then 
	if self:GetAutoCastState() and not caster:IsRooted() and not caster:IsLeashed() then
		caster:Teleport(caster:GetAbsOrigin() + caster:GetForwardVector()*caster:GetTalentValue("modifier_puck_shift_6", "range"), false, "particles/puck/rift_blink_start.vpcf", "particles/puck/rift_blint_end.vpcf", "Puck.Shift_blink")
	end
end

local duration = self:GetDuration() + FrameTime()

caster:RemoveModifierByName("modifier_custom_puck_phase_shift_legendary_damage")
caster:RemoveModifierByName("modifier_custom_puck_phase_shift_shield")

if caster:HasTalent("modifier_puck_shift_2") then 
	caster:AddNewModifier(caster, self, "modifier_custom_puck_phase_shift_shield", {duration = duration + 0.1})
end

caster:AddNewModifier(caster, self, "modifier_custom_puck_phase_shift", {duration = duration})
end






function custom_puck_phase_shift:OnChannelFinish(interrupted)
local phase_modifier =  self:GetCaster():FindModifierByName("modifier_custom_puck_phase_shift")

if not phase_modifier then return end
phase_modifier:SetDuration(FrameTime(), true)
end


modifier_custom_puck_phase_shift = class({})
function modifier_custom_puck_phase_shift:IsHidden() return false end
function modifier_custom_puck_phase_shift:IsPurgable() return false end

function modifier_custom_puck_phase_shift:GetStatusEffectName()
return "particles/status_fx/status_effect_dark_seer_illusion.vpcf"
end

function modifier_custom_puck_phase_shift:StatusEffectPriority()
return MODIFIER_PRIORITY_SUPER_ULTRA 
end

function modifier_custom_puck_phase_shift:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.legendary_damage = self.parent:GetTalentValue("modifier_puck_shift_7", "damage_reduce")
self.legendary_spell = self.parent:GetTalentValue("modifier_puck_shift_7", "damage")
self.legendary_status = self.parent:GetTalentValue("modifier_puck_shift_7", "status")
self.legendary_attack_damage = self.parent:GetTalentValue("modifier_puck_shift_7", "attack_damage")

if not IsServer() then return end
self.ability:EndCd()

self.parent:EmitSound("Hero_Puck.Phase_Shift")
self.RemoveForDuel = true
ProjectileManager:ProjectileDodge(self.parent)

if not self.parent:HasTalent("modifier_puck_shift_7") then 

	local caster = self.parent
	caster:AddEffects(EF_NODRAW)
	local pos = self.parent:GetAbsOrigin()
	pos.z = pos.z + 120

	self.effect_cast = ParticleManager:CreateParticle("particles/puck_phase_shift.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.effect_cast, 0, pos)
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(35,0,0))
	self:AddParticle(self.effect_cast, false, false, -1, false, false)
else 
	self.parent:GenericParticle("particles/puck_resist.vpcf", self)
	self.parent:GenericParticle("particles/units/heroes/hero_puck/puck_phase_shift.vpcf", self)
end

self.max_time = self:GetRemainingTime()

if not self.parent:HasTalent("modifier_puck_shift_7") then return end
self:OnIntervalThink()
self:StartIntervalThink(FrameTime())
end


function modifier_custom_puck_phase_shift:OnIntervalThink()
if not IsServer() then return end
local mod = self.parent:FindModifierByName("modifier_custom_puck_phase_shift_legendary_damage")
local stack = 0
if mod then
	stack = mod:GetStackCount()
end
self.parent:UpdateUIshort({active = 0, max_time = self.max_time, time = self:GetElapsedTime(), stack = tostring(stack*self.legendary_spell).."%", style = "PuckShift"})
end


function modifier_custom_puck_phase_shift:OnDestroy()
if not IsServer() then return end

local mod = self.parent:FindModifierByName("modifier_custom_puck_phase_shift_legendary_damage")
if mod then 
	mod:OnIntervalThink()
else 
	self.parent:UpdateUIshort({hide = 1, style = "PuckShift"})
end

local shield = self.parent:FindModifierByName("modifier_custom_puck_phase_shift_shield")
if shield then 
	shield:SetDuration(self.parent:GetTalentValue("modifier_puck_shift_2", "duration"), true)
end

self.parent:RemoveEffects(EF_NODRAW)
self.parent:StopSound("Hero_Puck.Phase_Shift")

if self.ability:GetToggleState() then
	self.ability:ToggleAbility()
end

self.ability:StartCd()

if self.parent:HasTalent("modifier_puck_shift_3") then 
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_puck_phase_shift_speed", {duration = self.parent:GetTalentValue("modifier_puck_shift_3", "duration")})
end

if self.parent:HasTalent("modifier_puck_shift_6") then 
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_puck_phase_shift_absorb", {duration = self.parent:GetTalentValue("modifier_puck_shift_6", "duration")})
end

end

function modifier_custom_puck_phase_shift:CheckState()
if self.parent:HasTalent("modifier_puck_shift_7") then
	return 
	{
		[MODIFIER_STATE_NO_UNIT_COLLISION]  = true,
	}
else
	return 
	{
		[MODIFIER_STATE_INVULNERABLE] 	= true,
		[MODIFIER_STATE_OUT_OF_GAME]	= true,
		[MODIFIER_STATE_UNSELECTABLE]	= true,
		[MODIFIER_STATE_NO_HEALTH_BAR]  = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION]  = true,
	}
end

end

function modifier_custom_puck_phase_shift:DeclareFunctions()
return
{

	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_custom_puck_phase_shift:GetModifierStatusResistanceStacking() 
if not self.parent:HasTalent("modifier_puck_shift_7") then return end
return self.legendary_status
end

function modifier_custom_puck_phase_shift:GetModifierIncomingDamage_Percentage()
if not self.parent:HasTalent("modifier_puck_shift_7") then return end
return self.legendary_damage
end

function modifier_custom_puck_phase_shift:GetModifierDamageOutgoing_Percentage()
if not self.parent:HasTalent("modifier_puck_shift_7") then return end
return self.legendary_attack_damage
end










modifier_custom_puck_phase_shift_tracker = class({})
function modifier_custom_puck_phase_shift_tracker:IsHidden() return true end
function modifier_custom_puck_phase_shift_tracker:IsPurgable() return false end
function modifier_custom_puck_phase_shift_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PROJECTILE_NAME,
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL
}
end


function modifier_custom_puck_phase_shift_tracker:GetModifierProcAttack_BonusDamage_Magical()
if not self.parent:HasShard() then return end
return self.shard_damage
end

function modifier_custom_puck_phase_shift_tracker:GetModifierAttackSpeedBonus_Constant()
if not self.parent:HasTalent("modifier_puck_shift_1") then return end
return self.parent:GetIntellect(false)*self.parent:GetTalentValue("modifier_puck_shift_1", "speed")/100
end

function modifier_custom_puck_phase_shift_tracker:GetModifierBonusStats_Intellect()
if not self.parent:HasTalent("modifier_puck_shift_1") then return end
return (self.parent:GetStrength() + self.parent:GetAgility())*self.parent:GetTalentValue("modifier_puck_shift_1", "int")/100
end


function modifier_custom_puck_phase_shift_tracker:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.shard_damage = self.ability:GetSpecialValueFor("shard_damage")

self.proc_chance = self.parent:GetTalentValue("modifier_puck_shift_4", "chance", true)
self.proc_radius = self.parent:GetTalentValue("modifier_puck_shift_4", "radius", true)
self.proc_duration = self.parent:GetTalentValue("modifier_puck_shift_4", "duration", true)
self.proc_spell = self.parent:GetTalentValue("modifier_puck_shift_4", "effect_duration", true)

self.stun_radius = self.parent:GetTalentValue("modifier_puck_shift_5", "radius", true)
self.stun_duration = self.parent:GetTalentValue("modifier_puck_shift_5", "stun", true)
self.stun_cd = self.parent:GetTalentValue("modifier_puck_shift_5", "cd", true)

self.legendary_duration = self.parent:GetTalentValue("modifier_puck_shift_7", "duration", true)

self.parent:AddAttackEvent_out(self)

if self.parent:IsRealHero() then
	self.parent:AddRecordDestroyEvent(self)
	self.parent:AddAttackEvent_inc(self)
	self.parent:AddAttackRecordEvent_out(self)
end

self.parent:AddSpellEvent(self)
self.parent:AddAttackStartEvent_out(self)

self.records = {}
end


function modifier_custom_puck_phase_shift_tracker:RecordDestroyEvent( params )
if not params.record then return end
if not self.records[params.record] then return end
self.records[params.record] = nil
end

function modifier_custom_puck_phase_shift_tracker:GetPriority()
if not self.parent:HasModifier("modifier_custom_puck_phase_shift_proc") then return MODIFIER_PRIORITY_LOW end
return MODIFIER_PRIORITY_ULTRA
end

function modifier_custom_puck_phase_shift_tracker:GetModifierProjectileName()
if not self.parent:HasModifier("modifier_custom_puck_phase_shift_proc") then return end
return "particles/puck/shift_proj.vpcf"
end

function modifier_custom_puck_phase_shift_tracker:AttackRecordEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_puck_shift_4")  then return end
if self.parent ~= params.attacker then return end
if params.no_attack_cooldown then return end
if not params.target:IsUnit() then return end

self.parent:RemoveModifierByName("modifier_custom_puck_phase_shift_proc")
local proc = false

if self.parent:HasModifier("modifier_custom_puck_phase_shift_proc_attack") then 
	proc = true
else 
	if RollPseudoRandomPercentage(self.proc_chance, 5059, self.parent) then 
		proc = true
	end
end

if not proc then return end
self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_puck_phase_shift_proc", {})
end


function modifier_custom_puck_phase_shift_tracker:PuckAttackProc()
if not IsServer() then return end

local mod = self.parent:FindModifierByName("modifier_custom_puck_phase_shift")

if self.parent:HasTalent("modifier_puck_shift_7") and mod then 
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_puck_phase_shift_legendary_damage", {duration = mod:GetRemainingTime() + self.legendary_duration})
end

end



function modifier_custom_puck_phase_shift_tracker:AttackStartEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if params.no_attack_cooldown then return end
if not params.target:IsUnit() then return end

self:PuckAttackProc()

if not self.parent:HasModifier("modifier_custom_puck_phase_shift_proc") then return end
self.parent:RemoveModifierByName("modifier_custom_puck_phase_shift_proc_attack")
self.parent:RemoveModifierByName("modifier_custom_puck_phase_shift_proc")
self.records[params.record] = true
end


function modifier_custom_puck_phase_shift_tracker:AttackEvent_inc(params)
if not IsServer() then return end

if self.parent:HasTalent("modifier_puck_shift_5") and self.parent ~= params.attacker and self.parent == params.target and params.attacker:IsRealHero() 
	and (params.attacker:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= self.stun_radius and not self.parent:HasModifier("modifier_custom_puck_phase_shift_stun_cd") then

	local effect =  ParticleManager:CreateParticle("particles/puck_stun.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl( effect, 0,  self.parent:GetOrigin() )
	ParticleManager:SetParticleControl( effect, 1, Vector(self.stun_radius, self.stun_radius, self.stun_radius) )
	ParticleManager:ReleaseParticleIndex(effect)

	self.parent:EmitSound("Puck.Shift_Stun")
	for _,target in pairs(self.parent:FindTargets(self.stun_radius)) do
		target:GenericParticle("particles/econ/items/outworld_devourer/od_shards_exile/od_shards_exile_prison_end.vpcf")
		target:AddNewModifier(self.parent, self.ability, "modifier_stunned", {duration = self.stun_duration*(1 - target:GetStatusResistance())})
	end

	self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_puck_phase_shift_stun_cd", {duration = self.stun_cd})
end


end


function modifier_custom_puck_phase_shift_tracker:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
if not self.records[params.record] then return end

self:ProcDamage(params.target)
self.records[params.record] = nil
end


function modifier_custom_puck_phase_shift_tracker:ProcDamage(target)
if not IsServer() then return end

local damage = self.parent:GetIntellect(false)*self.parent:GetTalentValue("modifier_puck_shift_4", "damage")/100
local damageTable = {attacker = self.parent, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability}

target:EmitSound("Puck.Shift_attack")
target:SendNumber(4, damage)

local effect = ParticleManager:CreateParticle("particles/puck/shift_proc.vpcf", PATTACH_WORLDORIGIN, target)
ParticleManager:SetParticleControl( effect, 0, target:GetOrigin() )
ParticleManager:SetParticleControl( effect, 1, Vector(self.proc_radius,0,0) )
ParticleManager:ReleaseParticleIndex(effect)

for _,target in pairs(self.parent:FindTargets(self.proc_radius, target:GetAbsOrigin())) do
	damageTable.victim = target
	target:AddNewModifier(self.parent, self.ability, "modifier_custom_puck_phase_shift_slow", {duration = self.proc_duration})
	DoDamage(damageTable, "modifier_puck_shift_4")
end

end


function modifier_custom_puck_phase_shift_tracker:SpellEvent(params)
if not IsServer() then return end
if params.ability:IsItem() then return end
if not self.parent:HasTalent("modifier_puck_shift_4") then return end 
if self.parent ~= params.unit then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_puck_phase_shift_proc_attack", {duration = self.proc_spell})
end



modifier_custom_puck_phase_shift_stun_cd = class({})
function modifier_custom_puck_phase_shift_stun_cd:IsHidden() return false end
function modifier_custom_puck_phase_shift_stun_cd:IsPurgable() return false end
function modifier_custom_puck_phase_shift_stun_cd:IsDebuff() return true end
function modifier_custom_puck_phase_shift_stun_cd:RemoveOnDeath() return false end
function modifier_custom_puck_phase_shift_stun_cd:GetTexture() return "buffs/multi_spell" end
function modifier_custom_puck_phase_shift_stun_cd:OnCreated()
self.RemoveForDuel = true
end





modifier_custom_puck_phase_shift_slow = class({})
function modifier_custom_puck_phase_shift_slow:IsHidden() return true end
function modifier_custom_puck_phase_shift_slow:IsPurgable() return true end
function modifier_custom_puck_phase_shift_slow:GetTexture() return "buffs/orb_slow" end
function modifier_custom_puck_phase_shift_slow:GetEffectName() return "particles/puck_orb_slow.vpcf" end
function modifier_custom_puck_phase_shift_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_custom_puck_phase_shift_slow:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_puck_shift_4", "slow")
end
function modifier_custom_puck_phase_shift_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end





modifier_custom_puck_phase_shift_proc_attack = class({})
function modifier_custom_puck_phase_shift_proc_attack:IsHidden() return true end
function modifier_custom_puck_phase_shift_proc_attack:IsPurgable() return false end


modifier_custom_puck_phase_shift_proc = class({})
function modifier_custom_puck_phase_shift_proc:IsHidden() return true end
function modifier_custom_puck_phase_shift_proc:IsPurgable() return false end



modifier_custom_puck_phase_shift_legendary_damage = class({})
function modifier_custom_puck_phase_shift_legendary_damage:IsHidden() return false end
function modifier_custom_puck_phase_shift_legendary_damage:IsPurgable() return false end
function modifier_custom_puck_phase_shift_legendary_damage:GetTexture() return "buffs/eye_damage" end
function modifier_custom_puck_phase_shift_legendary_damage:OnCreated()
self.parent = self:GetParent()
self.damage = self.parent:GetTalentValue("modifier_puck_shift_7", "damage")
self.max_time = self.parent:GetTalentValue("modifier_puck_shift_7", "duration")

if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_custom_puck_phase_shift_legendary_damage:OnRefresh()
if not IsServer() then return end
self:IncrementStackCount()
end

function modifier_custom_puck_phase_shift_legendary_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end

function modifier_custom_puck_phase_shift_legendary_damage:GetModifierSpellAmplify_Percentage()
return self.damage*self:GetStackCount()
end


function modifier_custom_puck_phase_shift_legendary_damage:OnIntervalThink()
if not IsServer() then return end

self.parent:UpdateUIshort({active = 1, max_time = self.max_time, time = self:GetRemainingTime(), stack = tostring(self:GetStackCount()*self.damage).."%", style = "PuckShift"})
self:StartIntervalThink(FrameTime())
end


function modifier_custom_puck_phase_shift_legendary_damage:OnDestroy()
if not IsServer() then return end

self.parent:UpdateUIshort({hide = 1, style = "PuckShift"})
end







modifier_custom_puck_phase_shift_shield = class({})
function modifier_custom_puck_phase_shift_shield:IsHidden() return false end
function modifier_custom_puck_phase_shift_shield:IsPurgable() return false end
function modifier_custom_puck_phase_shift_shield:GetTexture() return "buffs/shift_shield" end
function modifier_custom_puck_phase_shift_shield:OnCreated(table)

self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.shield_talent = "modifier_puck_shift_2"
self.max_shield = self.caster:GetTalentValue("modifier_puck_shift_2", "shield")*self.caster:GetIntellect(false)/100
self.interval = 0.1
self.shield = 0
self.status = self.caster:GetTalentValue("modifier_puck_shift_2", "status")

self.legendary_damage = self.caster:GetTalentValue("modifier_puck_shift_7", "damage_reduce", true)/100

if not IsServer() then return end

self.shield_inc = (self.max_shield/self:GetRemainingTime())*self.interval

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end


function modifier_custom_puck_phase_shift_shield:OnIntervalThink()
if not IsServer() then return end 

self.shield = math.min(self.max_shield, (self.shield + self.shield_inc))

self:SetStackCount(self.shield)
if not self.caster:HasModifier("modifier_custom_puck_phase_shift") then 
	self:StartIntervalThink(-1)
end

end

function modifier_custom_puck_phase_shift_shield:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
}
end

function modifier_custom_puck_phase_shift_shield:GetModifierStatusResistanceStacking()
return self.status
end

function modifier_custom_puck_phase_shift_shield:GetModifierIncomingDamageConstant( params )
if self:GetStackCount() == 0 then return end

if IsClient() then 
  if params.report_max then 
  	return self.max_shield
  else 
	  return self:GetStackCount()
	end 
end

if not IsServer() then return end
local damage = math.min(params.damage, self:GetStackCount())

local real_damage = params.damage
if self.caster:HasModifier("modifier_custom_puck_phase_shift") and self.caster:HasTalent("modifier_puck_shift_7") then
	real_damage = real_damage * (1 + self.legendary_damage)
end
real_damage = math.min(real_damage, self:GetStackCount())

self.parent:AddShieldInfo({shield_mod = self, healing = real_damage, healing_type = "shield"})

self:SetStackCount(self:GetStackCount() - real_damage)
if self:GetStackCount() <= 0 then
  if not self.caster:HasModifier("modifier_custom_puck_phase_shift") then 
  	self:Destroy()
	end
end

return -damage
end




modifier_custom_puck_phase_shift_speed = class({})
function modifier_custom_puck_phase_shift_speed:IsHidden() return false end
function modifier_custom_puck_phase_shift_speed:IsPurgable() return false end
function modifier_custom_puck_phase_shift_speed:GetTexture() return "buffs/orb_speed" end
function modifier_custom_puck_phase_shift_speed:GetEffectName() return "particles/puck_orb_speed.vpcf" end

function modifier_custom_puck_phase_shift_speed:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_custom_puck_phase_shift_speed:OnCreated()
self.speed = self:GetCaster():GetTalentValue("modifier_puck_shift_3", "speed")
end

function modifier_custom_puck_phase_shift_speed:GetModifierMoveSpeedBonus_Percentage()
return self.speed 
end

function modifier_custom_puck_phase_shift_speed:CheckState()
return
{
  [MODIFIER_STATE_UNSLOWABLE] = true
}
end





modifier_custom_puck_phase_shift_absorb = class({})
function modifier_custom_puck_phase_shift_absorb:IsHidden() return true end
function modifier_custom_puck_phase_shift_absorb:IsPurgable() return false end

function modifier_custom_puck_phase_shift_absorb:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_ABSORB_SPELL
}
end

function modifier_custom_puck_phase_shift_absorb:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()

self.sphere = ParticleManager:CreateParticle("particles/puck/shift_sphere.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt(self.sphere, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
self:AddParticle( self.sphere, true, false, -1, false, false )
end


function modifier_custom_puck_phase_shift_absorb:GetAbsorbSpell(params) 
if not self.sphere then return end
if params.ability:GetCaster():GetTeamNumber() == self.parent:GetTeamNumber() then return end

ParticleManager:DestroyParticle(self.sphere, false)
ParticleManager:ReleaseParticleIndex(self.sphere)
self.sphere = nil

self.parent:EmitSound("DOTA_Item.LinkensSphere.Activate")
self:Destroy()
return 1 
end