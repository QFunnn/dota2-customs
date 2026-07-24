--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_templar_assassin_refraction_custom_damage", "abilities/templar_assasssin/templar_assassin_refraction_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_refraction_custom_absorb", "abilities/templar_assasssin/templar_assassin_refraction_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_refraction_custom_silence", "abilities/templar_assasssin/templar_assassin_refraction_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_refraction_custom_legendary_attack", "abilities/templar_assasssin/templar_assassin_refraction_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_refraction_custom_shield_speed", "abilities/templar_assasssin/templar_assassin_refraction_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_refraction_custom_tracker", "abilities/templar_assasssin/templar_assassin_refraction_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_refraction_custom_speed_slow", "abilities/templar_assasssin/templar_assassin_refraction_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_refraction_custom_shield_immune", "abilities/templar_assasssin/templar_assassin_refraction_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_refraction_custom_recast", "abilities/templar_assasssin/templar_assassin_refraction_custom", LUA_MODIFIER_MOTION_NONE )


templar_assassin_refraction_custom = class({})


function templar_assassin_refraction_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_templar_assassin/templar_assassin_refraction_dmg.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_templar_assassin/templar_assassin_refraction.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_antimage/antimage_spellshield_reflect.vpcf", context )
PrecacheResource( "particle","particles/ta_wave.vpcf", context )
PrecacheResource( "particle","particles/ta_shield_exp.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_templar_assassin/templar_assassin_refract_hit.vpcf", context )
PrecacheResource( "particle","particles/ta_shield_roots.vpcf", context )
PrecacheResource( "particle","particles/ta_shield_magic_2.vpcf", context )
PrecacheResource( "particle","particles/ta_shield_magic.vpcf", context )
PrecacheResource( "particle","particles/templar_assassin_magic_attack.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_omnislash.vpcf", context )
PrecacheResource( "particle","particles/templar_assassin/shield_invun.vpcf", context )
PrecacheResource( "particle","particles/templar_assassin/shield_invun_hit.vpcf", context )

end

function templar_assassin_refraction_custom:GetAbilityTextureName()
if self:GetCaster():HasModifier("modifier_templar_assassin_refraction_custom_recast") then
    return "templar_assassin_refraction_damage"
end 
return "templar_assassin_refraction"
end




function templar_assassin_refraction_custom:GetBehavior()
local bonus = 0
if self:GetCaster():HasTalent("modifier_templar_assassin_refraction_5") then 
    bonus = DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE
end 
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + bonus
end 


function templar_assassin_refraction_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_templar_assassin_refraction_custom_tracker"
end

function templar_assassin_refraction_custom:GetCooldown(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_templar_assassin_refraction_3") then 
	bonus = self:GetCaster():GetTalentValue("modifier_templar_assassin_refraction_3", "cd")
end
return self.BaseClass.GetCooldown( self, level ) + bonus
end


function templar_assassin_refraction_custom:GetManaCost(level)
local bonus = 0
if self:GetCaster():HasModifier("modifier_templar_assassin_refraction_custom_recast") then
	return 0
end
if self:GetCaster():HasTalent("modifier_templar_assassin_refraction_2") then 
	bonus = self:GetCaster():GetTalentValue("modifier_templar_assassin_refraction_2", "mana")
end
return self.BaseClass.GetManaCost(self,level) + bonus
end

function templar_assassin_refraction_custom:ProcHeal()
local caster = self:GetCaster()
if not caster:HasTalent("modifier_templar_assassin_refraction_2") then return end

local heal = caster:GetMaxHealth()*caster:GetTalentValue("modifier_templar_assassin_refraction_2", "heal")/100
caster:GenericHeal(heal, self, nil, nil, "modifier_templar_assassin_refraction_2")
end


function templar_assassin_refraction_custom:OnProjectileHit_ExtraData(hTarget, vLocation, table)
if not IsServer() then return end
if not hTarget then return end
if not table or not table.damage then return end

local caster = self:GetCaster()

hTarget:EmitSound("TA.Shield_legendary_attack")

local real_damage = DoDamage({victim = hTarget, attacker = caster, damage = table.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self}, "modifier_templar_assassin_refraction_7")
hTarget:SendNumber(4, real_damage)    
end



function templar_assassin_refraction_custom:OnSpellStart()

local caster = self:GetCaster()
local duration = self:GetSpecialValueFor("duration")

caster:StartGesture(ACT_DOTA_CAST_REFRACTION)

local mod = caster:FindModifierByName("modifier_templar_assassin_refraction_custom_recast")
if mod then
	caster:AddNewModifier(caster, self, "modifier_templar_assassin_refraction_custom_shield_immune", {duration = caster:GetTalentValue("modifier_templar_assassin_refraction_7", "invun")})
	mod:Destroy()
	caster:EmitSound("TA.Shield_invun")
	self:EndCd()
	return
end

caster:RemoveModifierByName("modifier_templar_assassin_refraction_custom_damage")
caster:RemoveModifierByName("modifier_templar_assassin_refraction_custom_absorb")
caster:RemoveModifierByName("modifier_templar_assassin_refraction_custom_legendary_attack")

caster:AddNewModifier(caster, self, "modifier_templar_assassin_refraction_custom_damage", {duration = duration})
caster:AddNewModifier(caster, self, "modifier_templar_assassin_refraction_custom_absorb", {duration = duration})

if caster.templar_illusion then
	local illusion = EntIndexToHScript(caster.templar_illusion)
	if illusion and not illusion:IsNull() and illusion:IsAlive() then
		illusion:StartGesture(ACT_DOTA_CAST_REFRACTION)
		illusion:AddNewModifier(caster, self, "modifier_templar_assassin_refraction_custom_absorb", {})
	end
end

if caster:HasTalent("modifier_templar_assassin_refraction_6") then
	caster:AddNewModifier(caster, self, "modifier_templar_assassin_refraction_custom_shield_immune", {duration = caster:GetTalentValue("modifier_templar_assassin_refraction_6", "duration")})
end

if caster:HasTalent("modifier_templar_assassin_refraction_7") then
	caster:AddNewModifier(caster, self, "modifier_templar_assassin_refraction_custom_recast", {duration = duration})
	self:EndCd(1)
else
	self:EndCd()
end

caster:EmitSound("Hero_TemplarAssassin.Refraction")
end



modifier_templar_assassin_refraction_custom_damage = class({})
function modifier_templar_assassin_refraction_custom_damage:IsPurgable() return false end
function modifier_templar_assassin_refraction_custom_damage:GetTexture() return "templar_assassin_refraction_damage" end
function modifier_templar_assassin_refraction_custom_damage:OnCreated()

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.instances = self.ability:GetSpecialValueFor("instances") + self.parent:GetTalentValue("modifier_templar_assassin_refraction_3", "stack")
self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")

if not IsServer() then return end

self:SetStackCount(self.instances)

self.RemoveForDuel = true

self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_templar_assassin/templar_assassin_refraction_dmg.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.particle, 2, self.parent, PATTACH_POINT_FOLLOW, "attach_attack1", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(self.particle, 3, self.parent, PATTACH_POINT_FOLLOW, "attach_attack2", self.parent:GetAbsOrigin(), true)
self:AddParticle(self.particle, false, false, -1, true, false)
end

function modifier_templar_assassin_refraction_custom_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	MODIFIER_PROPERTY_PROCATTACK_FEEDBACK
}
end

function modifier_templar_assassin_refraction_custom_damage:GetModifierPreAttack_BonusDamage()
return self.bonus_damage
end

function modifier_templar_assassin_refraction_custom_damage:GetModifierProcAttack_Feedback(params)
if not IsServer() then return end
if params.attacker ~= self.parent then return end
if not params.target:IsUnit() then return end

params.target:EmitSound("Hero_TemplarAssassin.Refraction.Damage")
self:DecrementStackCount()

self.ability:ProcHeal()

if self.parent:HasTalent("modifier_templar_assassin_refraction_7") then
	local mod = self.parent:FindModifierByName("modifier_templar_assassin_refraction_custom_absorb") 
	if mod then
		mod:IncrementStackCount()
	end
end

if self:GetStackCount() <= 0 then
	self:Destroy()
	return
end

end




modifier_templar_assassin_refraction_custom_absorb = class({})
function modifier_templar_assassin_refraction_custom_absorb:IsPurgable() return false end
function modifier_templar_assassin_refraction_custom_absorb:GetTexture() return "templar_assassin_refraction" end

function modifier_templar_assassin_refraction_custom_absorb:OnCreated()

self.ability = self:GetAbility()
self.parent = self:GetParent()

self.instances = self.ability:GetSpecialValueFor("instances")
self.max_shield = self.ability:GetSpecialValueFor("shield_per_instance") + self.parent:GetTalentValue("modifier_templar_assassin_refraction_6", "shield")
self.shield = self.max_shield

self.legendary_damage = self.parent:GetTalentValue("modifier_templar_assassin_refraction_7", "damage", true)/100
self.legendary_duration = self.parent:GetTalentValue("modifier_templar_assassin_refraction_7", "duration", true)

if not IsServer() then return end
self:SetStackCount(self.instances)
self.RemoveForDuel = true

self.damage_count = 0

self.particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_templar_assassin/templar_assassin_refraction.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( self.particle, 0, self.parent:GetOrigin())
ParticleManager:SetParticleControlEnt( self.particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_origin", self.parent:GetOrigin(), true );
ParticleManager:SetParticleControl( self.particle, 5, self.parent:GetOrigin())
self:AddParticle(self.particle, false, false, -1, true, false)

self:SetHasCustomTransmitterData(true)
self:SendBuffRefreshToClients()

if not self.parent:HasTalent("modifier_templar_assassin_refraction_7") then return end

self.max_time = self:GetRemainingTime()

self:OnIntervalThink()
self:StartIntervalThink(0.1)
end


function modifier_templar_assassin_refraction_custom_absorb:OnIntervalThink()
if not IsServer() then return end

self.parent:UpdateUIshort({time = self:GetElapsedTime(), max_time = self.max_time, stack_icon = self:GetStackCount(), stack = "+"..tostring(math.floor(self.damage_count)), style = "TemplarRefraction"})
end



function modifier_templar_assassin_refraction_custom_absorb:AddCustomTransmitterData() 
return 
{
    shield = self.shield,
} 
end

function modifier_templar_assassin_refraction_custom_absorb:HandleCustomTransmitterData(data)
self.shield = data.shield
end


function modifier_templar_assassin_refraction_custom_absorb:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	MODIFIER_PROPERTY_REFLECT_SPELL,
	MODIFIER_PROPERTY_ABSORB_SPELL,
}
end


function modifier_templar_assassin_refraction_custom_absorb:ReduceStack(attacker)
if not IsServer() then return end

self:DecrementStackCount()
self.ability:ProcHeal()
self.parent:EmitSound("Hero_TemplarAssassin.Refraction.Absorb")

self:ParticleProc(attacker, "particles/units/heroes/hero_templar_assassin/templar_assassin_refract_hit.vpcf")

if self:GetStackCount() <= 0 then 
	self:Destroy()
end

end


function modifier_templar_assassin_refraction_custom_absorb:ParticleProc(attacker, name)
if not IsServer() then return end
local forward = self.parent:GetAbsOrigin() - attacker:GetAbsOrigin()
forward.z = 0
forward = forward:Normalized()

local particle_2 = ParticleManager:CreateParticle(name, PATTACH_CUSTOMORIGIN, self.parent)
ParticleManager:SetParticleControlEnt(particle_2, 0, self.parent, PATTACH_POINT, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControl(particle_2, 1, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControlForward(particle_2, 1, forward)
ParticleManager:SetParticleControlEnt(particle_2, 2, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetAbsOrigin(), false)
ParticleManager:ReleaseParticleIndex(particle_2)
end


function modifier_templar_assassin_refraction_custom_absorb:GetModifierIncomingDamageConstant(params)

if IsClient() then 
	if params.report_max then 
		return self.max_shield
	else 
     	return self.shield
    end 
end

if not IsServer() then return end
if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) == DOTA_DAMAGE_FLAG_HPLOSS then return end
if self.parent == params.attacker then return end

if not self.parent:HasModifier("modifier_templar_assassin_refraction_custom_shield_immune") then 
	if self.shield > params.damage then
	    self.shield = self.shield - params.damage
	else
	 	self.shield = self.max_shield
	 	self:ReduceStack(params.attacker)
	end
else
	self:ParticleProc(params.attacker, "particles/templar_assassin/shield_invun_hit.vpcf")
	self.parent:EmitSound("TA.Shield_invun_hit")
end

if self.parent:HasTalent("modifier_templar_assassin_refraction_7") then 
	self.damage_count = self.damage_count + params.original_damage*self.legendary_damage
end

if self.parent:GetQuest() == "Templar.Quest_5" and params.attacker:IsRealHero() and not self.parent:QuestCompleted() then 
	self.parent:UpdateQuest(math.floor(params.original_damage))
end

self:SendBuffRefreshToClients()
self.parent:AddShieldInfo({shield_mod = self, healing = params.damage, healing_type = "shield"})
return -params.damage
end


function modifier_templar_assassin_refraction_custom_absorb:GetAbsorbSpell( params )
if not IsServer() then return end
if params.ability and params.ability:GetCaster() == self.parent then return end
if self.blocked then return end
if not self.parent:HasTalent("modifier_templar_assassin_refraction_6") then return end

self.blocked = true

local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_antimage/antimage_spellshield_reflect.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
ParticleManager:ReleaseParticleIndex( particle )
self.parent:EmitSound("TA.Spell_block")

return 1
end


function modifier_templar_assassin_refraction_custom_absorb:OnDestroy()
if not IsServer() then return end
self.parent:RemoveModifierByName("modifier_templar_assassin_refraction_custom_recast")
self.ability:StartCd()

if self.parent:HasTalent("modifier_templar_assassin_refraction_4") then 
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_templar_assassin_refraction_custom_shield_speed", {duration = self.parent:GetTalentValue("modifier_templar_assassin_refraction_4", "effect_duration")})
end


if self.parent:HasTalent("modifier_templar_assassin_refraction_5") then 
	self.parent:EmitSound("TA.Shield_break")
	self.parent:GenericParticle("particles/ta_wave.vpcf")
	self.parent:GenericParticle("particles/ta_shield_exp.vpcf")
	local radius = self.parent:GetTalentValue("modifier_templar_assassin_refraction_5", "radius")
	local duration = self.parent:GetTalentValue("modifier_templar_assassin_refraction_5", "duration")
	local silence = self.parent:GetTalentValue("modifier_templar_assassin_refraction_5", "silence")

	for _,enemy in pairs(self.parent:FindTargets(radius)) do 
		local direction = enemy:GetOrigin()-self.parent:GetOrigin()
		direction.z = 0
		direction = direction:Normalized()

		local end_point = self.parent:GetAbsOrigin() + direction*(radius + 10)
		local distance = (enemy:GetAbsOrigin() - end_point):Length2D()

		local knockbackProperties =
		{
			duration = duration,
			distance = distance,
			direction_x = direction.x,
			direction_y = direction.y,
		}
		enemy:AddNewModifier( self.parent, self.ability, "modifier_generic_knockback", knockbackProperties )
		enemy:AddNewModifier(self.parent, self.parent:BkbAbility(nil, false), "modifier_templar_assassin_refraction_custom_silence", {duration = (1 - enemy:GetStatusResistance())*silence})
	end
end

if self.damage_count <= 0 then 
	if self.parent:HasTalent("modifier_templar_assassin_refraction_7") then
		self.parent:UpdateUIshort({hide = 1, style = "TemplarRefraction"})
	end
	return 
end

self.parent:RemoveModifierByName("modifier_templar_assassin_refraction_custom_legendary_attack")
self.parent:AddNewModifier(self.parent, self.ability, "modifier_templar_assassin_refraction_custom_legendary_attack", {duration = self.legendary_duration, stack = self.damage_count})
end



modifier_templar_assassin_refraction_custom_legendary_attack = class({})
function modifier_templar_assassin_refraction_custom_legendary_attack:IsHidden() return true end
function modifier_templar_assassin_refraction_custom_legendary_attack:IsPurgable() return false end
function modifier_templar_assassin_refraction_custom_legendary_attack:GetEffectName() return "particles/ta_shield_magic_2.vpcf" end
function modifier_templar_assassin_refraction_custom_legendary_attack:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.parent:AddAttackStartEvent_out(self)

self.ability = self:GetAbility()

self:SetStackCount(table.stack)
self.parent:EmitSound("TA.Shield_legendary")

local particle_peffect = ParticleManager:CreateParticle("particles/ta_shield_magic.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(particle_peffect, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_peffect, 2, self.parent:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(particle_peffect)

self.max_time = self:GetRemainingTime()

self:OnIntervalThink()
self:StartIntervalThink(0.2)
end


function modifier_templar_assassin_refraction_custom_legendary_attack:OnIntervalThink()
if not IsServer() then return end

self.parent:UpdateUIshort({time = self:GetRemainingTime(), max_time = self.max_time, stack = "+"..tostring(self:GetStackCount()), active = 1, style = "TemplarRefraction"})
end


function modifier_templar_assassin_refraction_custom_legendary_attack:OnDestroy()
if not IsServer() then return end

self.parent:UpdateUIshort({hide = 1, style = "TemplarRefraction"})
end



function modifier_templar_assassin_refraction_custom_legendary_attack:AttackStartEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

local projectile =
{
    Target = params.target,
    Source = self.parent,
    Ability = self.ability,
    EffectName = "particles/templar_assassin_magic_attack.vpcf",
    iMoveSpeed = self.parent:GetProjectileSpeed(),
    vSourceLoc = self.parent:GetAbsOrigin(),
    bDodgeable = false,
    bProvidesVision = false,
    ExtraData = {damage = self:GetStackCount()}
}

ProjectileManager:CreateTrackingProjectile( projectile )
end



function modifier_templar_assassin_refraction_custom_legendary_attack:GetStatusEffectName() return "particles/status_fx/status_effect_omnislash.vpcf" end
function modifier_templar_assassin_refraction_custom_legendary_attack:StatusEffectPriority() return MODIFIER_PRIORITY_ULTRA  end






modifier_templar_assassin_refraction_custom_silence = class({})
function modifier_templar_assassin_refraction_custom_silence:IsHidden() return true end
function modifier_templar_assassin_refraction_custom_silence:IsPurgable() return true end
function modifier_templar_assassin_refraction_custom_silence:CheckState()
return
{
	[MODIFIER_STATE_SILENCED] = true
}
end

function modifier_templar_assassin_refraction_custom_silence:OnCreated()
self.parent = self:GetParent()
self.slow = self:GetCaster():GetTalentValue("modifier_templar_assassin_refraction_5", "slow")
if not IsServer() then return end
self.parent:GenericParticle("particles/void_astral_slow.vpcf", self)
self.parent:EmitSound("Sf.Raze_Silence")
end

function modifier_templar_assassin_refraction_custom_silence:GetEffectName() return "particles/generic_gameplay/generic_silenced.vpcf" end
function modifier_templar_assassin_refraction_custom_silence:ShouldUseOverheadOffset() return true end
function modifier_templar_assassin_refraction_custom_silence:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end


function modifier_templar_assassin_refraction_custom_silence:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end


function modifier_templar_assassin_refraction_custom_silence:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end




modifier_templar_assassin_refraction_custom_shield_speed = class({})
function modifier_templar_assassin_refraction_custom_shield_speed:IsHidden() return false end
function modifier_templar_assassin_refraction_custom_shield_speed:IsPurgable() return false end
function modifier_templar_assassin_refraction_custom_shield_speed:GetTexture() return "buffs/refraction_speed" end



modifier_templar_assassin_refraction_custom_tracker = class({})
function modifier_templar_assassin_refraction_custom_tracker:IsHidden() return true end
function modifier_templar_assassin_refraction_custom_tracker:IsPurgable() return false end
function modifier_templar_assassin_refraction_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.move_bonus = self.parent:GetTalentValue("modifier_templar_assassin_refraction_1", "bonus", true)

self.speed_slow = self.parent:GetTalentValue("modifier_templar_assassin_refraction_4", "duration", true)

self.parent:AddAttackEvent_out(self)
end

function modifier_templar_assassin_refraction_custom_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_templar_assassin_refraction_custom_tracker:GetModifierAttackSpeedBonus_Constant()
if not self.parent:HasTalent("modifier_templar_assassin_refraction_4") then return end 
if not self.parent:HasModifier("modifier_templar_assassin_refraction_custom_damage") and not self.parent:HasModifier("modifier_templar_assassin_refraction_custom_shield_speed") then return end

return self.parent:GetTalentValue("modifier_templar_assassin_refraction_4", "speed")
end


function modifier_templar_assassin_refraction_custom_tracker:GetModifierMoveSpeedBonus_Constant()
if not self.parent:HasTalent("modifier_templar_assassin_refraction_1") then return end

local bonus = self.parent:GetTalentValue("modifier_templar_assassin_refraction_1", "move")
if self.parent:HasModifier("modifier_templar_assassin_refraction_custom_absorb") then 
	bonus = bonus*self.move_bonus
end
return bonus
end


function modifier_templar_assassin_refraction_custom_tracker:GetModifierStatusResistanceStacking()
if not self.parent:HasTalent("modifier_templar_assassin_refraction_1") then return end

local bonus = self.parent:GetTalentValue("modifier_templar_assassin_refraction_1", "status")
if self.parent:HasModifier("modifier_templar_assassin_refraction_custom_absorb") then 
	bonus = bonus*self.move_bonus
end
return bonus
end


function modifier_templar_assassin_refraction_custom_tracker:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

if self.parent:HasTalent("modifier_templar_assassin_refraction_4") and (self.parent:HasModifier("modifier_templar_assassin_refraction_custom_damage") or self.parent:HasModifier("modifier_templar_assassin_refraction_custom_shield_speed")) then
	params.target:AddNewModifier(self.parent, self.ability, "modifier_templar_assassin_refraction_custom_speed_slow", {duration = self.speed_slow})
end

end



modifier_templar_assassin_refraction_custom_speed_slow = class({})
function modifier_templar_assassin_refraction_custom_speed_slow:IsHidden() return true end
function modifier_templar_assassin_refraction_custom_speed_slow:IsPurgable() return true end
function modifier_templar_assassin_refraction_custom_speed_slow:GetTexture() return "buffs/psiblades_slow" end
function modifier_templar_assassin_refraction_custom_speed_slow:GetEffectName() return "particles/void_astral_slow.vpcf" end
function modifier_templar_assassin_refraction_custom_speed_slow:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_templar_assassin_refraction_custom_speed_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_templar_assassin_refraction_custom_speed_slow:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_templar_assassin_refraction_4", "slow")
end


modifier_templar_assassin_refraction_custom_shield_immune = class({})
function modifier_templar_assassin_refraction_custom_shield_immune:IsHidden() return true end
function modifier_templar_assassin_refraction_custom_shield_immune:IsPurgable() return false end
function modifier_templar_assassin_refraction_custom_shield_immune:OnCreated()
if not IsServer() then return end

self.parent = self:GetParent()
self.particle = ParticleManager:CreateParticle( "particles/templar_assassin/shield_invun.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( self.particle, 0, self.parent:GetOrigin())
ParticleManager:SetParticleControlEnt( self.particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_origin", self.parent:GetOrigin(), true );
ParticleManager:SetParticleControl( self.particle, 5, self.parent:GetOrigin())
self:AddParticle(self.particle, false, false, -1, true, false)
end

function modifier_templar_assassin_refraction_custom_shield_immune:GetStatusEffectName() return "particles/status_fx/status_effect_omnislash.vpcf" end
function modifier_templar_assassin_refraction_custom_shield_immune:StatusEffectPriority() return MODIFIER_PRIORITY_SUPER_ULTRA  end




modifier_templar_assassin_refraction_custom_recast = class({})
function modifier_templar_assassin_refraction_custom_recast:IsHidden() return true end
function modifier_templar_assassin_refraction_custom_recast:IsPurgable() return false end