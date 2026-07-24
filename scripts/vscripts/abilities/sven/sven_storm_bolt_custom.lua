--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_sven_storm_bolt_custom_legendary", "abilities/sven/sven_storm_bolt_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_storm_bolt_custom_legendary_caster", "abilities/sven/sven_storm_bolt_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_storm_bolt_custom_tracker", "abilities/sven/sven_storm_bolt_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_storm_bolt_custom_scepter", "abilities/sven/sven_storm_bolt_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_storm_bolt_custom_stun", "abilities/sven/sven_storm_bolt_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_storm_bolt_custom_silence", "abilities/sven/sven_storm_bolt_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_storm_bolt_custom_proc", "abilities/sven/sven_storm_bolt_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_storm_bolt_custom_proc_slow", "abilities/sven/sven_storm_bolt_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_storm_bolt_custom_legendary_stack", "abilities/sven/sven_storm_bolt_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_storm_bolt_custom_legendary_cd", "abilities/sven/sven_storm_bolt_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_storm_bolt_custom_damage_reduce", "abilities/sven/sven_storm_bolt_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sven_storm_bolt_custom_shield", "abilities/sven/sven_storm_bolt_custom", LUA_MODIFIER_MOTION_NONE )


sven_storm_bolt_custom = class({})



function sven_storm_bolt_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end


PrecacheResource( "particle", "particles/units/heroes/hero_sven/sven_attack_blur_3_alt.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_sven/sven_attack_blur_2.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_sven/sven_attack_blur.vpcf", context )
PrecacheResource( "particle", "particles/econ/items/sven/sven_warcry_ti5/sven_warcry_shield_bash_blur.vpcf", context )

PrecacheResource( "particle","particles/units/heroes/hero_sven/sven_attack_blur_3_alt.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sven/sven_attack_blur_2.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sven/sven_attack_blur.vpcf", context )
PrecacheResource( "particle","particles/econ/items/sven/sven_warcry_ti5/sven_warcry_shield_bash_blur.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sven/sven_spell_storm_bolt_lightning.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sven/sven_spell_storm_bolt.vpcf", context )
PrecacheResource( "particle","particles/sven_bolt_visual.vpcf", context )
PrecacheResource( "particle","particles/sven_storm_aoe.vpcf", context )
PrecacheResource( "particle","particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_static_field_gold.vpcf", context )
PrecacheResource( "particle","particles/econ/items/sven/sven_warcry_ti5/sven_warcry_cast_arc_lightning.vpcf", context )
PrecacheResource( "particle","particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_static_field_gold.vpcf", context )
PrecacheResource( "particle","particles/econ/items/sven/sven_warcry_ti5/sven_warcry_cast_arc_lightning.vpcf", context )
PrecacheResource( "particle","particles/items_fx/force_staff.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_forcestaff.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_stunned.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_silenced.vpcf", context )
PrecacheResource( "particle","particles/lc_odd_proc_hands.vpcf", context )
PrecacheResource( "particle","particles/sven/hammer_proc.vpcf", context )
PrecacheResource( "particle","particles/sven_hammer_stack.vpcf", context )

end

function sven_storm_bolt_custom:OnInventoryContentsChanged()
if self:GetCaster():HasScepter() and not self.scepter_active then
	self:ToggleAutoCast()
	self.scepter_active = true
end

end


function sven_storm_bolt_custom:GetBehavior()
local behavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
if self:GetCaster():HasScepter() then
	behavior = behavior + DOTA_ABILITY_BEHAVIOR_AUTOCAST
end
return behavior
end


function sven_storm_bolt_custom:GetCastPoint(iLevel)
local bonus = 0
if self:GetCaster():HasTalent("modifier_sven_hammer_6") then
	bonus = self:GetCaster():GetTalentValue("modifier_sven_hammer_6", "cast")
end
return self.BaseClass.GetCastPoint(self) + bonus
end

function sven_storm_bolt_custom:GetCastRange( target, position )
return self.BaseClass.GetCastRange( self, target, position )
end

function sven_storm_bolt_custom:GetManaCost(iLevel)
if self:GetCaster():HasTalent("modifier_sven_hammer_5") then 
	return 0
end
return self.BaseClass.GetManaCost( self, iLevel)
end

function sven_storm_bolt_custom:GetAOERadius()
return self:GetSpecialValueFor( "bolt_aoe" )
end

function sven_storm_bolt_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_sven_storm_bolt_custom_tracker"
end

function sven_storm_bolt_custom:GetCooldown(iLevel)
return self.BaseClass.GetCooldown(self, iLevel)
end

function sven_storm_bolt_custom:OnAbilityPhaseStart()
local caster = self:GetCaster()
local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_sven/sven_spell_storm_bolt_lightning.vpcf", PATTACH_CUSTOMORIGIN, caster )
ParticleManager:SetParticleControlEnt( nFXIndex, 0, caster, PATTACH_POINT_FOLLOW, "attach_sword", caster:GetOrigin(), true )

local vLightningOffset = caster:GetOrigin() + Vector( 0, 0, 1600 )
ParticleManager:SetParticleControl( nFXIndex, 1, vLightningOffset )
ParticleManager:ReleaseParticleIndex( nFXIndex )

return true
end


function sven_storm_bolt_custom:GetBoltDamage(target)
if not IsServer() then return end
local caster = self:GetCaster()
local damage = self:GetSpecialValueFor( "bolt_damage" ) + caster:GetStrength()*caster:GetTalentValue("modifier_sven_hammer_1", "damage")/100

local mod = target:FindModifierByName("modifier_sven_storm_bolt_custom_legendary_stack")
if mod then 
	damage = damage*(1 + mod:GetStackCount()*caster:GetTalentValue("modifier_sven_hammer_7", "damage_inc")/100)
end 
return damage
end


function sven_storm_bolt_custom:OnSpellStart(new_target)
local caster = self:GetCaster()
local target = self:GetCursorTarget()

local vision_radius = self:GetSpecialValueFor( "vision_radius" )
local bolt_speed = self:GetSpecialValueFor( "bolt_speed" ) * (1 + caster:GetTalentValue("modifier_sven_hammer_6", "speed")/100)

if new_target then 
	target = new_target
end
	
if caster:HasTalent("modifier_sven_hammer_4") or caster:HasTalent("modifier_sven_hammer_1") then
	caster:AddNewModifier(caster, self, "modifier_sven_storm_bolt_custom_proc", {duration = caster:GetTalentValue("modifier_sven_hammer_4", "duration", true)})
end

if caster:HasScepter() then
	if self:GetAutoCastState() and target:TriggerSpellAbsorb(self) then
		if caster:HasScepter() then
			caster:CdAbility(self, self:GetCooldownTimeRemaining()*self:GetSpecialValueFor("scepter_cd")/100)
		end
 		return
 	end
end 

local info = {
	EffectName = "particles/units/heroes/hero_sven/sven_spell_storm_bolt.vpcf",
	Ability = self,
	iMoveSpeed = bolt_speed,
	Source = caster,
	Target = target,
	bDodgeable = true,
	bProvidesVision = true,
	iVisionTeamNumber = caster:GetTeamNumber(),
	iVisionRadius = vision_radius,
	iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2, 
}

self.projectile = ProjectileManager:CreateTrackingProjectile( info )

if caster:HasScepter() and self:GetAutoCastState() then
	caster:AddNewModifier( caster, self, "modifier_sven_storm_bolt_custom_scepter", {} )
end

caster:EmitSound( "Hero_Sven.StormBolt" )
end


function sven_storm_bolt_custom:OnProjectileThinkHandle( projID )
local caster = self:GetCaster()

if caster:HasModifier("modifier_sven_storm_bolt_custom_scepter") and self.projectile == projID then
	local projLoc = ProjectileManager:GetTrackingProjectileLocation( projID )
	local newPos = GetGroundPosition( projLoc, nil )
	caster:SetAbsOrigin( newPos )
end

end



function sven_storm_bolt_custom:OnProjectileHit_ExtraData(hTarget, vLocation, table)

local caster = self:GetCaster()

caster:RemoveModifierByName("modifier_sven_storm_bolt_custom_scepter")

local linken = false
if hTarget then
	linken = hTarget:TriggerSpellAbsorb(self) 
end

if hTarget and not linken and caster:HasScepter() and not hTarget:IsDebuffImmune() then 
	hTarget:Purge(true, false, false, false, false)
end

if not hTarget or hTarget:IsInvulnerable() or hTarget:IsDebuffImmune() or linken then
	if caster:HasScepter() then
		caster:CdAbility(self, self:GetCooldownTimeRemaining()*self:GetSpecialValueFor("scepter_cd")/100)
	end
end

if hTarget == nil then return end
if linken then return end


if hTarget:IsInvulnerable() then return end

hTarget:EmitSound("Hero_Sven.StormBoltImpact" )

local bolt_aoe = self:GetSpecialValueFor( "bolt_aoe" )
local bolt_stun_duration = self:GetSpecialValueFor( "bolt_stun_duration" ) + caster:GetTalentValue("modifier_sven_hammer_2", "stun")
local enemies = caster:FindTargets(bolt_aoe, hTarget:GetAbsOrigin())
local reduction_duration = caster:GetTalentValue("modifier_sven_hammer_3", "duration")

for _,enemy in pairs(enemies) do
	if not enemy:IsInvulnerable() then

		local main = 0
		if enemy == hTarget then
			main = 1
		end

		local duration = bolt_stun_duration*(1 - enemy:GetStatusResistance())
		enemy:AddNewModifier( caster, self, "modifier_sven_storm_bolt_custom_stun", { duration =  duration, main = main} )

		if caster:HasTalent("modifier_sven_hammer_3") then
			enemy:AddNewModifier(caster, self, "modifier_sven_storm_bolt_custom_damage_reduce", {duration = duration + reduction_duration})
		end

		DoDamage({ victim = enemy, attacker = caster, damage = self:GetBoltDamage(enemy), ability = self, damage_type = DAMAGE_TYPE_MAGICAL, })
	end
end

return true
end




modifier_sven_storm_bolt_custom_tracker = class({})
function modifier_sven_storm_bolt_custom_tracker:IsHidden() return true end
function modifier_sven_storm_bolt_custom_tracker:IsPurgable() return false end
function modifier_sven_storm_bolt_custom_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
  MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
  MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
}
end

function modifier_sven_storm_bolt_custom_tracker:GetModifierPercentageCooldown() 
if not self.parent:HasTalent("modifier_sven_hammer_6") then return end 
return self.cdr
end

function modifier_sven_storm_bolt_custom_tracker:GetModifierCastRangeBonusStacking()
if not self.parent:HasTalent("modifier_sven_hammer_2") then return end 
return self.parent:GetTalentValue("modifier_sven_hammer_2", "range")
end

function modifier_sven_storm_bolt_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.proc_cd = self.parent:GetTalentValue("modifier_sven_hammer_4", "cd", true)
self.proc_slow = self.parent:GetTalentValue("modifier_sven_hammer_4", "slow_duration", true)
self.proc_inc = self.parent:GetTalentValue("modifier_sven_hammer_4", "chance_inc", true)
self.proc_damage = self.parent:GetTalentValue("modifier_sven_hammer_4", "damage", true)/100

self.shield = self.parent:GetTalentValue("modifier_sven_hammer_6", "shield", true)/100
self.shield_duration = self.parent:GetTalentValue("modifier_sven_hammer_6", "duration", true)
self.shield_creeps = self.parent:GetTalentValue("modifier_sven_hammer_6", "creeps",true)
self.cdr = self.parent:GetTalentValue("modifier_sven_hammer_6", "cdr", true)

self.parent:AddAttackEvent_out(self)
self.parent:AddDamageEvent_out(self)
end

function modifier_sven_storm_bolt_custom_tracker:DamageEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_sven_hammer_6") then return end
if self.parent ~= params.attacker then return end

local mod = params.unit:FindModifierByName("modifier_sven_storm_bolt_custom_stun")
if not mod or not mod.main or mod.main == 0 then return end

local shield = params.damage*self.shield
if params.unit:IsCreep() then
	shield = shield/self.shield_creeps
end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_sven_storm_bolt_custom_shield", {duration = self.shield_duration, shield = shield})
end

function modifier_sven_storm_bolt_custom_tracker:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if params.no_attack_cooldown then return end
if not params.target:IsUnit() then return end
if not self.parent:HasTalent("modifier_sven_hammer_4") then return end

local chance = self.parent:GetTalentValue("modifier_sven_hammer_4", "chance")
if self.parent:HasModifier("modifier_sven_storm_bolt_custom_proc") then
	chance = chance * self.proc_inc
end 

if not RollPseudoRandomPercentage(chance, 4254, self.parent) then return end

local enemy = params.target

local particle = ParticleManager:CreateParticle( "particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_static_field_gold.vpcf", PATTACH_POINT_FOLLOW, enemy )
ParticleManager:SetParticleControlEnt( particle, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
ParticleManager:ReleaseParticleIndex( particle )

local pfx2 = ParticleManager:CreateParticle( "particles/econ/items/sven/sven_warcry_ti5/sven_warcry_cast_arc_lightning.vpcf", PATTACH_CUSTOMORIGIN, enemy)
ParticleManager:SetParticleControl( pfx2, 0, enemy:GetAbsOrigin() )
ParticleManager:ReleaseParticleIndex(pfx2)


enemy:EmitSound("Sven.Bolt_legendary_damage")

local real_damage = DoDamage({victim = enemy, attacker = self.parent, damage = self.parent:GetStrength()*self.proc_damage, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL, }, "modifier_sven_hammer_4")
enemy:AddNewModifier(self.parent, self.ability, "modifier_sven_storm_bolt_custom_proc_slow", {duration = self.proc_slow})
enemy:SendNumber(4, real_damage)

self.parent:CdAbility(self.ability, self.proc_cd)
end






modifier_sven_storm_bolt_custom_scepter = class({})

function modifier_sven_storm_bolt_custom_scepter:IsPurgable() return false end

function modifier_sven_storm_bolt_custom_scepter:OnDestroy()
if not IsServer() then return end
ResolveNPCPositions( self:GetCaster():GetAbsOrigin(), 256 ) 
end

function modifier_sven_storm_bolt_custom_scepter:CheckState()
return 
{
	[MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
	[MODIFIER_STATE_INVULNERABLE] = true,
	[MODIFIER_STATE_STUNNED] = true,
	[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
}
end

function modifier_sven_storm_bolt_custom_scepter:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end

function modifier_sven_storm_bolt_custom_scepter:GetOverrideAnimation()
return ACT_DOTA_OVERRIDE_ABILITY_1
end

function modifier_sven_storm_bolt_custom_scepter:IsHidden()
return true
end

function modifier_sven_storm_bolt_custom_scepter:OnCreated(table)
if not IsServer() then return end
self.pfx = ParticleManager:CreateParticle("particles/items_fx/force_staff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
self:AddParticle(self.pfx, false, false, -1, false, false)
end

function modifier_sven_storm_bolt_custom_scepter:GetStatusEffectName() return "particles/status_fx/status_effect_forcestaff.vpcf" end
function modifier_sven_storm_bolt_custom_scepter:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH end





modifier_sven_storm_bolt_custom_stun = class({})

function modifier_sven_storm_bolt_custom_stun:IsHidden() return true end
function modifier_sven_storm_bolt_custom_stun:IsStunDebuff() return true end
function modifier_sven_storm_bolt_custom_stun:IsPurgeException() return true end
function modifier_sven_storm_bolt_custom_stun:GetEffectName() return "particles/generic_gameplay/generic_stunned.vpcf" end
function modifier_sven_storm_bolt_custom_stun:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end

function modifier_sven_storm_bolt_custom_stun:CheckState()
local state = {[MODIFIER_STATE_STUNNED] = true}
if self.caster:HasTalent("modifier_sven_hammer_5") then
	state[MODIFIER_STATE_SILENCED] = true
end
return state
end

function modifier_sven_storm_bolt_custom_stun:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end

function modifier_sven_storm_bolt_custom_stun:GetOverrideAnimation()
return ACT_DOTA_DISABLED
end

function modifier_sven_storm_bolt_custom_stun:OnCreated(table)
self.caster = self:GetCaster()
self.parent = self:GetParent()

if not IsServer() then return end

self.main = table.main

if self.caster:GetQuest() ~= "Sven.Quest_5" or self.caster:QuestCompleted() then return end
if not self.parent:IsRealHero() then return end
self:StartIntervalThink(0.1)
end

function modifier_sven_storm_bolt_custom_stun:OnIntervalThink()
if not IsServer() then return end
self:GetCaster():UpdateQuest(0.1)
end

function modifier_sven_storm_bolt_custom_stun:OnDestroy()
if not IsServer() then return end
if not self.caster:HasTalent("modifier_sven_hammer_5") then return end

self.parent:EmitSound("Sf.Raze_Silence")
self.parent:AddNewModifier(self.caster, self:GetAbility(), "modifier_sven_storm_bolt_custom_silence", {duration = (1 - self.parent:GetStatusResistance())*self.caster:GetTalentValue("modifier_sven_hammer_5", "silence")})
end




modifier_sven_storm_bolt_custom_silence = class({})
function modifier_sven_storm_bolt_custom_silence:IsHidden() return true end
function modifier_sven_storm_bolt_custom_silence:IsPurgable() return true end
function modifier_sven_storm_bolt_custom_silence:GetTexture() return "silencer_last_word" end
function modifier_sven_storm_bolt_custom_silence:CheckState()
return
{
	[MODIFIER_STATE_SILENCED] = true
}
end
function modifier_sven_storm_bolt_custom_silence:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end
function modifier_sven_storm_bolt_custom_silence:GetModifierMoveSpeedBonus_Percentage()
return self.slow 
end

function modifier_sven_storm_bolt_custom_silence:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_sven_hammer_5", "slow")
end 

function modifier_sven_storm_bolt_custom_silence:GetEffectName() return "particles/generic_gameplay/generic_silenced.vpcf" end
function modifier_sven_storm_bolt_custom_silence:ShouldUseOverheadOffset() return true end
function modifier_sven_storm_bolt_custom_silence:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end






modifier_sven_storm_bolt_custom_proc = class({})
function modifier_sven_storm_bolt_custom_proc:IsHidden() return false end
function modifier_sven_storm_bolt_custom_proc:IsPurgable() return false end
function modifier_sven_storm_bolt_custom_proc:GetTexture() return "buffs/hammer_proc" end
function modifier_sven_storm_bolt_custom_proc:GetEffectName() return "particles/lc_odd_proc_hands.vpcf" end
function modifier_sven_storm_bolt_custom_proc:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.parent:GenericParticle("particles/sven/hammer_proc.vpcf", self)

if not self.parent:HasTalent("modifier_sven_hammer_1") then return end
self.parent:AddPercentStat({str = self.parent:GetTalentValue("modifier_sven_hammer_1", "str")/100}, self)
end


modifier_sven_storm_bolt_custom_proc_slow = class({})
function modifier_sven_storm_bolt_custom_proc_slow:IsHidden() return true end
function modifier_sven_storm_bolt_custom_proc_slow:IsPurgable() return true end
function modifier_sven_storm_bolt_custom_proc_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_sven_storm_bolt_custom_proc_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow 
end

function modifier_sven_storm_bolt_custom_proc_slow:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_sven_hammer_4", "slow")
end 




modifier_sven_storm_bolt_custom_legendary_stack = class({})
function modifier_sven_storm_bolt_custom_legendary_stack:IsHidden() return false end
function modifier_sven_storm_bolt_custom_legendary_stack:IsPurgable() return false end
function modifier_sven_storm_bolt_custom_legendary_stack:OnCreated(table)
if not IsServer() then return end
self.ability = self:GetAbility()
self:SetStackCount(1)
self.max = self.ability:GetSpecialValueFor("max")
end

function modifier_sven_storm_bolt_custom_legendary_stack:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()
end


function modifier_sven_storm_bolt_custom_legendary_stack:OnStackCountChanged(iStackCount)
if not IsServer() then return end
if self:GetStackCount() == 0 then return end
if not self.effect_cast then 

  local particle_cast = "particles/sven_hammer_stack.vpcf"

  self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
  ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )

  self:AddParticle(self.effect_cast,false, false, -1, false, false)
else 

  ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )

end

end






modifier_sven_storm_bolt_custom_damage_reduce = class({})
function modifier_sven_storm_bolt_custom_damage_reduce:IsHidden() return false end
function modifier_sven_storm_bolt_custom_damage_reduce:IsPurgable() return false end
function modifier_sven_storm_bolt_custom_damage_reduce:GetTexture() return "buffs/spear_heal" end

function modifier_sven_storm_bolt_custom_damage_reduce:OnCreated(table)

self.damage_reduce = self:GetCaster():GetTalentValue("modifier_sven_hammer_3", "damage_reduce")
self.heal_reduce = self:GetCaster():GetTalentValue("modifier_sven_hammer_3", "heal_reduce")
end

function modifier_sven_storm_bolt_custom_damage_reduce:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE
}
end


function modifier_sven_storm_bolt_custom_damage_reduce:GetStatusEffectName()
return "particles/status_fx/status_effect_enchantress_shard_debuff.vpcf"
end

function modifier_sven_storm_bolt_custom_damage_reduce:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end

function modifier_sven_storm_bolt_custom_damage_reduce:GetModifierDamageOutgoing_Percentage()
return self.damage_reduce
end

function modifier_sven_storm_bolt_custom_damage_reduce:GetModifierSpellAmplify_Percentage()
return self.damage_reduce
end

function modifier_sven_storm_bolt_custom_damage_reduce:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_reduce
end

function modifier_sven_storm_bolt_custom_damage_reduce:GetModifierHealChange() 
return self.heal_reduce
end

function modifier_sven_storm_bolt_custom_damage_reduce:GetModifierHPRegenAmplify_Percentage() 
return self.heal_reduce
end






sven_storm_bolt_custom_legendary = class({})

sven_storm_bolt_custom_legendary.thinkers = {}

function sven_storm_bolt_custom_legendary:CreateTalent()
self:SetHidden(false)
end

function sven_storm_bolt_custom_legendary:GetAOERadius()
return self:GetSpecialValueFor("radius")
end

function sven_storm_bolt_custom_legendary:GetCooldown()
return self:GetCaster():GetTalentValue("modifier_sven_hammer_7", "cd")
end

function sven_storm_bolt_custom_legendary:GetBehavior()
local bonus = 0
local caster = self:GetCaster()
if caster:HasModifier("modifier_sven_storm_bolt_custom_legendary_caster") then
	bonus = DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end
return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_HIDDEN + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE + bonus
end


function sven_storm_bolt_custom_legendary:GetCastRange()
local caster = self:GetCaster()
if caster:HasModifier("modifier_sven_storm_bolt_custom_legendary_caster") then
	return self:GetSpecialValueFor("move_range")
end
return self:GetSpecialValueFor("range")
end

function sven_storm_bolt_custom_legendary:OnSpellStart()

local caster = self:GetCaster()
local point = self:GetCursorPosition()

if point == caster:GetAbsOrigin() then
	point = caster:GetAbsOrigin() + caster:GetForwardVector()*10
end

local mod = caster:FindModifierByName("modifier_sven_storm_bolt_custom_legendary_caster")
if mod and mod.thinker and not mod.thinker:IsNull() then

	local thinker_mod = self.thinkers[1]:FindModifierByName("modifier_sven_storm_bolt_custom_legendary")
	if thinker_mod and thinker_mod.moved == false then

		local dist = self:GetSpecialValueFor("move_range") + caster:GetCastRangeBonus()
		local vec = point - caster:GetAbsOrigin()
		if vec:Length2D() > dist then
			point = caster:GetAbsOrigin() + vec:Normalized()*dist
		end

		thinker_mod:Move(point)
		self:EndCd()
		return
	else
		UTIL_Remove(mod.thinker)
	end
end

self:EndCd(0)
self:StartCooldown(0.5)

local radius = self:GetSpecialValueFor("radius")

self.thinkers[1] = CreateModifierThinker(caster, self, "modifier_sven_storm_bolt_custom_legendary", {}, point, caster:GetTeamNumber(), false)
caster:AddNewModifier(caster, self, "modifier_sven_storm_bolt_custom_legendary_caster", {thinker = self.thinkers[1]:entindex()})

local qangle_rotation_rate = 60

local line_position = point + caster:GetForwardVector() * radius
for i = 1, 6 do
	local qangle = QAngle(0, qangle_rotation_rate, 0)
	line_position = RotatePosition(point , qangle, line_position)

	local particle = ParticleManager:CreateParticle("particles/sven_bolt_visual.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, caster:GetAttachmentOrigin(caster:ScriptLookupAttachment("attach_attack1")))
	ParticleManager:SetParticleControl(particle, 1, line_position)
	ParticleManager:DestroyParticle(particle, false)	
	ParticleManager:ReleaseParticleIndex(particle)
end


end




modifier_sven_storm_bolt_custom_legendary = class({})
function modifier_sven_storm_bolt_custom_legendary:IsHidden() return false end
function modifier_sven_storm_bolt_custom_legendary:IsPurgable() return false end


function modifier_sven_storm_bolt_custom_legendary:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.main = self.caster:FindAbilityByName("sven_storm_bolt_custom")


if not self.main or not self.main:IsTrained() then
	self:Destroy()
	return
end
self.moved = false

self.parent:EmitSound("Sven.Bolt_legendary")

self.radius = self.ability:GetSpecialValueFor("radius")
self.damage_interval = self.ability:GetSpecialValueFor("interval")
self.stun = self.ability:GetSpecialValueFor("stun")
self.effect_duration = self.ability:GetSpecialValueFor("effect_duration")

self.damage_inc = self.caster:GetTalentValue("modifier_sven_hammer_7", "damage_inc")/100
self.damage_init = self.caster:GetTalentValue("modifier_sven_hammer_7", "damage_init")/100
self.end_timer = self.caster:GetTalentValue("modifier_sven_hammer_7", "duration")
self.move_duration = self.ability:GetSpecialValueFor("move_duration")

self.zuus_nimbus_particle = ParticleManager:CreateParticle("particles/sven_storm_aoe.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.zuus_nimbus_particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.zuus_nimbus_particle, 1, Vector(self.radius, 0, 0))
self:AddParticle(self.zuus_nimbus_particle, false, false, -1, false, false)

self.move_speed = nil

self.ending = false
self.end_count = 0
self.interval = 0.03
self.move_target = nil
self:StartIntervalThink(self.interval)
end

function modifier_sven_storm_bolt_custom_legendary:OnIntervalThink()
if not IsServer() then return end
if not self.parent or self.parent:IsNull() then return end

if self.move_target and self.move_speed then
	local vec = self.move_target - self.parent:GetAbsOrigin()
	local new_point = self.parent:GetAbsOrigin() + vec:Normalized()*self.move_speed*self.interval
	self.parent:SetAbsOrigin(new_point)

	if (self.parent:GetAbsOrigin() - self.move_target):Length2D() <= 20 then
		self.move_target = nil
		self.move_speed = nil
	end
end

AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), self.radius, self.interval*3, false)

local enemies = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, 0, false )
local count = 0
local all_count = 0

for _,enemy in pairs(enemies) do 
	if enemy:IsUnit() and (enemy:IsHero() or (enemy:IsCreep() and not enemy:IsOutOfGame())) then 
		all_count = all_count + 1
	end

	if not enemy:IsInvulnerable() and enemy:IsUnit() and not enemy:HasModifier("modifier_sven_storm_bolt_custom_legendary_cd") then

		enemy:AddNewModifier(self.caster, self.ability, "modifier_sven_storm_bolt_custom_legendary_cd", {duration = self.damage_interval})

		local particle = ParticleManager:CreateParticle( "particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_static_field_gold.vpcf", PATTACH_POINT_FOLLOW, enemy )
	    ParticleManager:SetParticleControlEnt( particle, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	    ParticleManager:ReleaseParticleIndex( particle )

	  	enemy:GenericParticle("particles/econ/items/sven/sven_warcry_ti5/sven_warcry_cast_arc_lightning.vpcf")

		local real_damage = DoDamage(  { victim = enemy, attacker = self.caster, damage = self.main:GetBoltDamage(enemy)*self.damage_init, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL, })
		enemy:SendNumber(4, real_damage)

		if enemy:IsRealHero() and self.caster:GetQuest() == "Sven.Quest_5" then 
			self.caster:UpdateQuest(self.stun)
		end

		if enemy:IsRealHero() or enemy:IsIllusion() then 
			enemy:AddNewModifier(self.caster, self.ability, "modifier_stunned", {duration = self.stun})
		end

		enemy:AddNewModifier(self.caster, self.ability, "modifier_sven_storm_bolt_custom_legendary_stack", {duration = self.effect_duration})
		count = count + 1
	end
end

if all_count == 0 then 
	if self.ending == false then
		self.ending = true
		self.end_count = -self.interval
	end
else
	self.ending = false
end

if count > 0 then 
	self.parent:EmitSound("Sven.Bolt_legendary_damage")
end

if self.ending == true then
	self.end_count = self.end_count + self.interval
	if self.end_count >= self.end_timer then
		self:Destroy()
		return
	end
end

end


function modifier_sven_storm_bolt_custom_legendary:Move(point)
if not IsServer() then return end
if self.moved == true then return end

self.moved = true
self.move_target = point
local dist = (point - self.parent:GetAbsOrigin()):Length2D()
self.move_speed = dist/self.move_duration
end

function modifier_sven_storm_bolt_custom_legendary:OnDestroy()
if not IsServer() then return end
self.caster:RemoveModifierByName("modifier_sven_storm_bolt_custom_legendary_caster")
self.ability:StartCd()
end

modifier_sven_storm_bolt_custom_legendary_cd = class({})
function modifier_sven_storm_bolt_custom_legendary_cd:IsHidden() return true end
function modifier_sven_storm_bolt_custom_legendary_cd:IsPurgable() return false end


modifier_sven_storm_bolt_custom_legendary_caster = class({})
function modifier_sven_storm_bolt_custom_legendary_caster:IsHidden() return true end
function modifier_sven_storm_bolt_custom_legendary_caster:IsPurgable() return false end
function modifier_sven_storm_bolt_custom_legendary_caster:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.thinker = EntIndexToHScript(table.thinker)
end




modifier_sven_storm_bolt_custom_shield = class({})
function modifier_sven_storm_bolt_custom_shield:IsHidden() return false end
function modifier_sven_storm_bolt_custom_shield:IsPurgable() return false end
function modifier_sven_storm_bolt_custom_shield:GetTexture() return "buffs/back_shield" end
function modifier_sven_storm_bolt_custom_shield:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.shield_talent = "modifier_sven_hammer_6"
self.max_shield = self.parent:GetMaxHealth()*self.parent:GetTalentValue("modifier_sven_hammer_6", "shield_max")/100

if not IsServer() then return end

--self.parent:GenericParticle("particles/items2_fx/vindicators_axe_armor.vpcf", self)

self:SetStackCount(1)
self:AddShield(table.shield)
self.RemoveForDuel = true
end

function modifier_sven_storm_bolt_custom_shield:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end

function modifier_sven_storm_bolt_custom_shield:OnRefresh(table)
if not IsServer() then return end

self:AddShield(table.shield)
end


function modifier_sven_storm_bolt_custom_shield:AddShield(shield)
if not IsServer() then return end 
self:SetStackCount(math.min(self.max_shield, self:GetStackCount() + shield))
end 


function modifier_sven_storm_bolt_custom_shield:GetModifierIncomingDamageConstant( params )

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





