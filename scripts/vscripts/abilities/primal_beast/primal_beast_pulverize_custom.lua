--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_primal_beast_pulverize_custom", "abilities/primal_beast/primal_beast_pulverize_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_pulverize_custom_debuff", "abilities/primal_beast/primal_beast_pulverize_custom", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_primal_beast_pulverize_custom_tracker", "abilities/primal_beast/primal_beast_pulverize_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_pulverize_custom_legendary_count", "abilities/primal_beast/primal_beast_pulverize_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_pulverize_custom_legendary_rock_cd", "abilities/primal_beast/primal_beast_pulverize_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_pulverize_custom_str_count", "abilities/primal_beast/primal_beast_pulverize_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_pulverize_custom_damage_reduce", "abilities/primal_beast/primal_beast_pulverize_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_pulverize_custom_trample_count", "abilities/primal_beast/primal_beast_pulverize_custom", LUA_MODIFIER_MOTION_NONE )

primal_beast_pulverize_custom = class({})


function primal_beast_pulverize_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/generic_gameplay/generic_lifesteal.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_primal_beast/primal_beast_pulverize_hit.vpcf", context )
PrecacheResource( "particle","particles/beast_ult_count.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/sange_maim.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_mars_spear.vpcf", context )
PrecacheResource( "particle","particles/items_fx/black_king_bar_avatar.vpcf", context ) 

end


function primal_beast_pulverize_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_primal_beast_pulverize_custom_tracker"
end


function primal_beast_pulverize_custom:AddLegendaryStack(only_str)
if not IsServer() then return end
local caster = self:GetCaster()

if caster:HasTalent("modifier_primal_beast_pulverize_4") then 
	caster:AddNewModifier(caster, self, "modifier_primal_beast_pulverize_custom_str_count", {duration = caster:GetTalentValue("modifier_primal_beast_pulverize_4", "duration")})
end

if not caster:HasTalent("modifier_primal_beast_pulverize_7") then return end 
if only_str then return end

local mod = caster:AddNewModifier(caster, self, "modifier_primal_beast_pulverize_custom_legendary_count", {duration = caster:GetTalentValue("modifier_primal_beast_pulverize_7", "duration")})
if not mod then return end
if mod:GetStackCount() < caster:GetTalentValue("modifier_primal_beast_pulverize_7", "max") then 
  mod:IncrementStackCount() 
end
end


function primal_beast_pulverize_custom:AddStrStack(target)
if not IsServer() then return end
local caster = self:GetCaster()

if not target:IsHero() then return end
if not caster:HasTalent("modifier_primal_beast_pulverize_4") then return end
target:AddNewModifier(caster, self, "modifier_primal_beast_pulverize_custom_str_count", {duration = caster:GetTalentValue("modifier_primal_beast_pulverize_4", "duration")})
end


function primal_beast_pulverize_custom:GetCooldown(iLevel)
local upgrade_cooldown = 0
if self:GetCaster():HasTalent("modifier_primal_beast_pulverize_3") then 
  upgrade_cooldown = self:GetCaster():GetTalentValue("modifier_primal_beast_pulverize_3", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown
end


function primal_beast_pulverize_custom:GetChannelAnimation()
return ACT_DOTA_CHANNEL_ABILITY_5
end

function primal_beast_pulverize_custom:GetChannelTime()
local bonus = self:GetCaster():GetUpgradeStack("modifier_primal_beast_pulverize_custom_legendary_count")*self:GetSpecialValueFor("interval")
return self:GetSpecialValueFor( "channel_time" ) + bonus
end




function primal_beast_pulverize_custom:OnSpellStart(new_target)

local caster = self:GetCaster()
local target = self:GetCursorTarget()

if new_target then 
	target = new_target
end

target:InterruptMotionControllers(true)

self:EndCd()

if not caster:HasTalent("modifier_primal_beast_pulverize_6") then 
	if target:TriggerSpellAbsorb( self ) then
		caster:Interrupt()
		return
	end
end

local duration = self:GetSpecialValueFor( "channel_time" ) + caster:GetUpgradeStack("modifier_primal_beast_pulverize_custom_legendary_count")*self:GetSpecialValueFor("interval")

local legendary_mod = caster:FindModifierByName("modifier_primal_beast_pulverize_custom_legendary_count")

if legendary_mod then
	legendary_mod:SetDuration(99999, true)
end

self:AddStrStack(target)
self:AddLegendaryStack(true)

self.target_mod = target:AddNewModifier( caster, self, "modifier_primal_beast_pulverize_custom_debuff", { duration = duration } )
caster:AddNewModifier( caster, self, "modifier_primal_beast_pulverize_custom", { duration = duration } )

if not target:IsHero() then
	caster:EmitSound("Hero_PrimalBeast.Pulverize.Cast.Creep")
else
	caster:EmitSound("Hero_PrimalBeast.Pulverize.Cast")
end

end

function primal_beast_pulverize_custom:OnChannelThink()
if not self.target_mod or self.target_mod:IsNull() then
	self:GetCaster():Interrupt()
end

end


function primal_beast_pulverize_custom:OnChannelFinish( bInterrupted )

local caster = self:GetCaster()
self:StartCd()

local self_mod = caster:FindModifierByName( "modifier_primal_beast_pulverize_custom" )
if self_mod then
	self_mod:Destroy()
end

if self.target_mod and not self.target_mod:IsNull() then 
	self.target_mod:Destroy()
	self.target_mod = nil
end

if caster:HasModifier("modifier_primal_beast_pulverize_custom_legendary_count") then
	caster:RemoveModifierByName("modifier_primal_beast_pulverize_custom_legendary_count")
end

end






modifier_primal_beast_pulverize_custom = class({})
function modifier_primal_beast_pulverize_custom:IsPurgable() return false end
function modifier_primal_beast_pulverize_custom:IsHidden() return true end
function modifier_primal_beast_pulverize_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_DISABLE_TURNING,
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
}
end

function modifier_primal_beast_pulverize_custom:GetModifierDisableTurning()
return 1
end


function modifier_primal_beast_pulverize_custom:OnCreated(table)
if not IsServer() then return end 

self.parent = self:GetParent()
self.ability = self:GetAbility()

if self.parent:HasTalent("modifier_primal_beast_pulverize_6") then 
	self.bkb = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_debuff_immune", {effect = 1})
end

end

function modifier_primal_beast_pulverize_custom:OnDestroy()
if not IsServer() then return end
if not self.parent:HasTalent("modifier_primal_beast_pulverize_6") then return end

if self.bkb and not self.bkb:IsNull() then 
	self.bkb:SetDuration(self.parent:GetTalentValue("modifier_primal_beast_pulverize_6", "duration"), true)
end 

end




modifier_primal_beast_pulverize_custom_debuff = class({})

function modifier_primal_beast_pulverize_custom_debuff:IsPurgable() return false end
function modifier_primal_beast_pulverize_custom_debuff:IsPurgeException() return true end
function modifier_primal_beast_pulverize_custom_debuff:IsStunDebuff() return true end

function modifier_primal_beast_pulverize_custom_debuff:OnCreated( kv )

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.interval = self.ability:GetSpecialValueFor( "interval" )
self.radius = self.ability:GetSpecialValueFor( "splash_radius" )
self.ministun = self.ability:GetSpecialValueFor( "ministun" )
self.animrate = self.ability:GetSpecialValueFor( "animation_rate" )

self.damage_duration = self.caster:GetTalentValue("modifier_primal_beast_pulverize_2", "duration")

self.items_cd = self.caster:GetTalentValue("modifier_primal_beast_pulverize_5", "cd_items")
self.items_heal = self.caster:GetTalentValue("modifier_primal_beast_pulverize_5", "heal")/100

self.base_damage = self.ability:GetSpecialValueFor("damage") + self.caster:GetTalentValue("modifier_primal_beast_pulverize_1", "damage")*self.caster:GetStrength()/100
self.inc_damage = self.ability:GetSpecialValueFor("damage_stack")
self.max_damage = self.ability:GetSpecialValueFor("damage_stack_max")

if not IsServer() then return end

self.interrupt_pos = self.caster:GetOrigin() + self.caster:GetForwardVector() * 200
self.cast_pos = self.caster:GetOrigin()
self.pos_threshold = 100

local attach_rollback = 
{
	[1] = "attach_pummel",
	[2] = "attach_attack1",
	[3] = "attach_attack",
	[4] = "attach_hitloc",
}

for i,name in pairs(attach_rollback) do
	self.attach_name = name
	if self.caster:ScriptLookupAttachment( name )~=0 then
		break
	end
end

local hitloc_enum = self.parent:ScriptLookupAttachment( "attach_hitloc" )
local hitloc_pos = self.parent:GetAttachmentOrigin( hitloc_enum )
self.deltapos = self.parent:GetOrigin() - hitloc_pos

if not self:ApplyHorizontalMotionController() then
	self:Destroy()
	return
end

if not self:ApplyVerticalMotionController() then
	self:Destroy()
	return
end

if self.caster:HasTalent("modifier_primal_beast_pulverize_6") then 
	self.break_effect = self.parent:AddNewModifier(self.caster, self.ability, "modifier_generic_break", {duration =  self:GetRemainingTime() + 0.1})
end

self:SetPriority( DOTA_MOTION_CONTROLLER_PRIORITY_HIGHEST )
self:StartIntervalThink( self.interval )
end



function modifier_primal_beast_pulverize_custom_debuff:OnDestroy()
if not IsServer() then return end

if self.break_effect and not self.break_effect:IsNull() then 
	self.break_effect:SetDuration(self.caster:GetTalentValue("modifier_primal_beast_pulverize_6", "duration"), true)
end

self.parent:FadeGesture(ACT_DOTA_FLAIL)
self.parent:RemoveHorizontalMotionController( self )

local angle = self.parent:GetAnglesAsVector()
self.parent:SetAngles( 0, angle.y+180, 0 )

FindClearSpaceForUnit( self.parent, GetGroundPosition(self.interrupt_pos, nil), false )

local vec = self.parent:GetForwardVector()
vec.z = 0

self.parent:SetForwardVector(vec)
self.parent:FaceTowards(self.parent:GetAbsOrigin() + vec*10)
--self.caster:Interrupt()
end



function modifier_primal_beast_pulverize_custom_debuff:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
}
end

function modifier_primal_beast_pulverize_custom_debuff:GetOverrideAnimation()
return ACT_DOTA_FLAIL
end

function modifier_primal_beast_pulverize_custom_debuff:GetOverrideAnimationRate()
return self.animrate
end

function modifier_primal_beast_pulverize_custom_debuff:CheckState()
return
{
	[MODIFIER_STATE_STUNNED] = true,
	[MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true,
}
end

function modifier_primal_beast_pulverize_custom_debuff:OnIntervalThink()
local origin = self.interrupt_pos
local stack_damage = math.min(self.max_damage, self.inc_damage*self:GetStackCount())

local damage = self.base_damage + stack_damage
local damageTable = { attacker = self.caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability, damage_flags = DOTA_DAMAGE_FLAG_NONE, }

if self.caster:HasTalent("modifier_primal_beast_pulverize_5") then 
	self.caster:CdItems(self.items_cd)
	local heal = (self.caster:GetMaxHealth() - self.caster:GetHealth())*self.items_heal
	self.caster:GenericHeal(heal, self.ability, nil, nil, "modifier_primal_beast_pulverize_5")
end

for _,enemy in pairs(self.caster:FindTargets(self.radius, origin)) do

	if self.caster:HasTalent("modifier_primal_beast_pulverize_2") then 
		enemy:AddNewModifier(self.caster, self.ability, "modifier_primal_beast_pulverize_custom_damage_reduce", {duration = self.damage_duration})
	end

	damageTable.victim = enemy
	DoDamage(damageTable)
	enemy:AddNewModifier( self.caster, self.ability, "modifier_stunned", { duration = self.ministun } )
	self.caster:EmitSound("Hero_PrimalBeast.Pulverize.Stun")
end

self:IncrementStackCount()

self:PlayEffects( origin, self.radius )

if (self.caster:GetOrigin()-self.cast_pos):Length2D() > self.pos_threshold then
	self:Destroy()
	return		
end

end


function modifier_primal_beast_pulverize_custom_debuff:UpdateHorizontalMotion( me, dt )
if self.parent:IsOutOfGame() or self.parent:IsInvulnerable() then
	self:Destroy()
	return
end

local attach = self.caster:ScriptLookupAttachment( self.attach_name )
local pos = self.caster:GetAttachmentOrigin( attach )
local angles = self.caster:GetAttachmentAngles( attach )

me:SetLocalAngles( 180-angles.x, 180+angles.y, 0 )

local deltapos = RotatePosition( Vector(0,0,0), QAngle(180-angles.x, 180+angles.y,0), self.deltapos )
pos = pos + deltapos

me:SetOrigin( pos )
end


function modifier_primal_beast_pulverize_custom_debuff:OnHorizontalMotionInterrupted()
--self:Destroy()
end

function modifier_primal_beast_pulverize_custom_debuff:UpdateVerticalMotion( me, dt )
local attach = self.caster:ScriptLookupAttachment( self.attach_name )
local pos = self.caster:GetAttachmentOrigin( attach )
local angles = self.caster:GetAttachmentAngles( attach )

local deltapos = RotatePosition( Vector(0,0,0), QAngle(180-angles.x, 180+angles.y,0), self.deltapos )
pos = pos + deltapos

local mepos = me:GetOrigin()
mepos.z = pos.z
me:SetOrigin( mepos )
end

function modifier_primal_beast_pulverize_custom_debuff:OnHorizontalMotionInterrupted()
--self:Destroy()
end

function modifier_primal_beast_pulverize_custom_debuff:GetPriority()
return DOTA_MOTION_CONTROLLER_PRIORITY_HIGHEST
end

function modifier_primal_beast_pulverize_custom_debuff:GetMotionPriority()
return DOTA_MOTION_CONTROLLER_PRIORITY_HIGHEST
end

function modifier_primal_beast_pulverize_custom_debuff:PlayEffects( origin, radius )
local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_primal_beast/primal_beast_pulverize_hit.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast, 0, origin )
ParticleManager:SetParticleControl( effect_cast, 1, Vector(radius, radius, radius) )
ParticleManager:DestroyParticle( effect_cast, false )
ParticleManager:ReleaseParticleIndex( effect_cast )
EmitSoundOnLocationWithCaster( self.parent:GetOrigin(), "Hero_PrimalBeast.Pulverize.Impact", self.caster )
end





modifier_primal_beast_pulverize_custom_tracker = class({})
function modifier_primal_beast_pulverize_custom_tracker:IsHidden() return true end
function modifier_primal_beast_pulverize_custom_tracker:IsPurgable() return false end


function modifier_primal_beast_pulverize_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if self.parent:IsRealHero() then 
	self.parent:AddDamageEvent_out(self)
end

self.cdr = self.parent:GetTalentValue("modifier_primal_beast_pulverize_5", "cdr", true)

self.legendary_max = self:GetCaster():GetTalentValue("modifier_primal_beast_pulverize_7", "max", true)
if not IsServer() then return end 
self:StartIntervalThink(1)
end


function modifier_primal_beast_pulverize_custom_tracker:DamageEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if params.inflictor == nil then return end
if params.inflictor:GetName() ~= "primal_beast_rock_throw" then return end

if not self.parent:HasModifier("modifier_primal_beast_pulverize_custom_legendary_rock_cd") then 
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_primal_beast_pulverize_custom_legendary_rock_cd", {duration = 0.2})
	self.ability:AddLegendaryStack()
end

self.ability:AddStrStack(params.unit)
end


function modifier_primal_beast_pulverize_custom_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
  MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
}
end


function modifier_primal_beast_pulverize_custom_tracker:GetModifierCastRangeBonusStacking()
if not self.parent:HasTalent("modifier_primal_beast_pulverize_3") then return end 
return self.parent:GetTalentValue("modifier_primal_beast_pulverize_3", "range")
end

function modifier_primal_beast_pulverize_custom_tracker:GetModifierPercentageCooldown()
if not self.parent:HasTalent("modifier_primal_beast_pulverize_5") then return end
return self.cdr
end

function modifier_primal_beast_pulverize_custom_tracker:GetModifierSpellAmplify_Percentage()
if not self.parent:HasTalent("modifier_primal_beast_pulverize_1") then return end
return self.parent:GetStrength()/self.parent:GetTalentValue("modifier_primal_beast_pulverize_1", "str")
end

function modifier_primal_beast_pulverize_custom_tracker:OnIntervalThink()
if not IsServer() then return end
if not self.parent:HasTalent("modifier_primal_beast_pulverize_7") then return end 

local stack = 0
local mod = self.parent:FindModifierByName("modifier_primal_beast_pulverize_custom_legendary_count")
if mod then 
	stack = mod:GetStackCount()
end

self.parent:UpdateUIlong({max = self.legendary_max, stack = stack, style = "BeastPulverize"})
self:StartIntervalThink(0.2)
end











modifier_primal_beast_pulverize_custom_legendary_count = class({})
function modifier_primal_beast_pulverize_custom_legendary_count:IsHidden() return false end
function modifier_primal_beast_pulverize_custom_legendary_count:IsPurgable() return false end
function modifier_primal_beast_pulverize_custom_legendary_count:IsDebuff() return true end

function modifier_primal_beast_pulverize_custom_legendary_count:OnCreated(table)
if not IsServer() then return end
self.RemoveForDuel = true
self.parent = self:GetParent()

self.max = self.parent:GetTalentValue("modifier_primal_beast_pulverize_7", "max")
self.timer = self.parent:GetTalentValue("modifier_primal_beast_pulverize_7", "duration")
self.radius = self.parent:GetTalentValue("modifier_primal_beast_pulverize_7", "radius")

self.particle = self.parent:GenericParticle("particles/beast_ult_count.vpcf", self, true)

self:SetStackCount(0)
self:StartIntervalThink(0.1)
end


function modifier_primal_beast_pulverize_custom_legendary_count:OnStackCountChanged(iStackCount)
if self:GetStackCount() == 0 then return end
if not self.particle then return end

for i = 1,self.max do 
	if i <= self:GetStackCount() then 
		ParticleManager:SetParticleControl(self.particle, i, Vector(1, 0, 0))	
	else 
		ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0))	
	end
end

end


function modifier_primal_beast_pulverize_custom_legendary_count:OnIntervalThink()
if not IsServer() then return end

local heroes = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false )

if #heroes > 0 or self.parent:HasModifier("modifier_primal_beast_pulverize_custom") then 
	self:SetDuration(self.timer, true)
end

end






modifier_primal_beast_pulverize_custom_legendary_rock_cd = class({})
function modifier_primal_beast_pulverize_custom_legendary_rock_cd:IsHidden() return true end
function modifier_primal_beast_pulverize_custom_legendary_rock_cd:IsPurgable() return false end




modifier_primal_beast_pulverize_custom_str_count = class({})
function modifier_primal_beast_pulverize_custom_str_count:IsHidden() return false end
function modifier_primal_beast_pulverize_custom_str_count:IsPurgable() return false end
function modifier_primal_beast_pulverize_custom_str_count:GetTexture() return "buffs/pulverize_str" end
function modifier_primal_beast_pulverize_custom_str_count:OnCreated(table)

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.str_percentage = self.caster:GetTalentValue("modifier_primal_beast_pulverize_4", "str")/100
self.max = self.caster:GetTalentValue("modifier_primal_beast_pulverize_4", "max")
self.duration = self.caster:GetTalentValue("modifier_primal_beast_pulverize_4", "duration")

if self.caster:GetTeamNumber() ~= self.parent:GetTeamNumber() then 
	self.str_percentage = self.str_percentage*-1
end
if not IsServer() then return end
self.RemoveForDuel = true

self.parent:AddPercentStat({str = self.str_percentage}, self)
self:IncrementStackCount()
self:StartIntervalThink(0.3)
end

function modifier_primal_beast_pulverize_custom_str_count:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()
self.parent:AddPercentStat({str = self.str_percentage * self:GetStackCount()}, self)
end


function modifier_primal_beast_pulverize_custom_str_count:OnIntervalThink()
if not IsServer() then return end

if self.parent:HasModifier("modifier_primal_beast_pulverize_custom") or self.parent:HasModifier("modifier_primal_beast_pulverize_custom_debuff") then 
	self:SetDuration(self.duration, true)
end

end


function modifier_primal_beast_pulverize_custom_str_count:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TOOLTIP,
}
end

function modifier_primal_beast_pulverize_custom_str_count:OnTooltip()
return self.str_percentage*self:GetStackCount()*100
end



modifier_primal_beast_pulverize_custom_damage_reduce = class({})
function modifier_primal_beast_pulverize_custom_damage_reduce:IsHidden() return false end
function modifier_primal_beast_pulverize_custom_damage_reduce:IsPurgable() return false end
function modifier_primal_beast_pulverize_custom_damage_reduce:GetTexture() return "buffs/dismember_damage" end
function modifier_primal_beast_pulverize_custom_damage_reduce:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_primal_beast_pulverize_custom_damage_reduce:GetEffectName()
return "particles/items2_fx/sange_maim.vpcf"
end

function modifier_primal_beast_pulverize_custom_damage_reduce:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end

function modifier_primal_beast_pulverize_custom_damage_reduce:GetStatusEffectName()
return "particles/status_fx/status_effect_mars_spear.vpcf"
end

function modifier_primal_beast_pulverize_custom_damage_reduce:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_reduce
end

function modifier_primal_beast_pulverize_custom_damage_reduce:GetModifierHealChange() 
return self.heal_reduce
end

function modifier_primal_beast_pulverize_custom_damage_reduce:GetModifierHPRegenAmplify_Percentage() 
return self.heal_reduce
end

function modifier_primal_beast_pulverize_custom_damage_reduce:GetModifierDamageOutgoing_Percentage()
return self.damage 
end

function modifier_primal_beast_pulverize_custom_damage_reduce:GetModifierSpellAmplify_Percentage() 
 return self.damage 
end

function modifier_primal_beast_pulverize_custom_damage_reduce:OnCreated(table)
self.caster = self:GetCaster()
self.damage = self.caster:GetTalentValue("modifier_primal_beast_pulverize_2", "damage_reduce")
self.heal_reduce = self.caster:GetTalentValue("modifier_primal_beast_pulverize_2", "heal_reduce")
end






modifier_primal_beast_pulverize_custom_trample_count = class({})
function modifier_primal_beast_pulverize_custom_trample_count:IsHidden() return true end
function modifier_primal_beast_pulverize_custom_trample_count:IsPurgable() return false end
function modifier_primal_beast_pulverize_custom_trample_count:OnCreated()
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.max = self.caster:GetTalentValue("modifier_primal_beast_pulverize_4", "trample", true)

if not IsServer() then return end 
self:SetStackCount(1)
end

function modifier_primal_beast_pulverize_custom_trample_count:OnRefresh()
if not IsServer() then return end 
self:IncrementStackCount()

if self:GetStackCount() >= self.max then 
	self.ability:AddStrStack(self:GetParent())
	self:Destroy()
end

end