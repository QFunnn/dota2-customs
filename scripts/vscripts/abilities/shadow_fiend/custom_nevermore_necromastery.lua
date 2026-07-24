--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_necromastery_souls", "abilities/shadow_fiend/custom_nevermore_necromastery", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_necromastery_kills", "abilities/shadow_fiend/custom_nevermore_necromastery", LUA_MODIFIER_MOTION_NONE) 
LinkLuaModifier("modifier_custom_necromastery_tempo_track", "abilities/shadow_fiend/custom_nevermore_necromastery", LUA_MODIFIER_MOTION_NONE) 
LinkLuaModifier("modifier_custom_necromastery_heal_cd", "abilities/shadow_fiend/custom_nevermore_necromastery", LUA_MODIFIER_MOTION_NONE) 
LinkLuaModifier("modifier_custom_necromastery_attack_slow", "abilities/shadow_fiend/custom_nevermore_necromastery", LUA_MODIFIER_MOTION_NONE) 
LinkLuaModifier("modifier_custom_necromastery_attack_silence", "abilities/shadow_fiend/custom_nevermore_necromastery", LUA_MODIFIER_MOTION_NONE) 

custom_nevermore_necromastery = class({})	



function custom_nevermore_necromastery:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf", context )
PrecacheResource( "particle","particles/sf_souls_attack.vpcf", context )
PrecacheResource( "particle","particles/huskar_leap_heal.vpcf", context )
PrecacheResource( "particle","particles/sf_souls_heal.vpcf", context )
PrecacheResource( "particle","particles/brist_lowhp_.vpcf", context )
PrecacheResource( "particle","particles/sf_wings.vpcf", context )
PrecacheResource( "particle","particles/sf_hands_.vpcf", context )
PrecacheResource( "particle","particles/sf_souls_souls.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_nevermore/sf_necromastery_attack.vpcf", context )
PrecacheResource( "particle","particles/sf_slow_attack.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_nevermore/nevermore_trail.vpcf", context )

PrecacheResource( "model","kynomi/models/sf_default_arms/shadow_fiend_arms.vmdl", context )
PrecacheResource( "model","kynomi/models/sf_default_shoulders/shadow_fiend_shoulders.vmdl", context )
PrecacheResource( "model","kynomi/models/sf_souls_tyrant_shoulder/sf_souls_tyrant_shoulder.vmdl", context )
PrecacheResource( "model","kynomi/models/sf_immortal_flame_arms/sf_immortal_flame_arms.vmdl", context )
PrecacheResource( "model","kynomi/models/sf_arms_deso/arms_deso.vmdl", context )

PrecacheResource( "soundfile", "soundevents/vo_custom/nevermore_vo_custom.vsndevts", context ) 
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_nevermore.vsndevts", context )
end

function custom_nevermore_necromastery:GetIntrinsicModifierName()
return "modifier_custom_necromastery_souls"
end


function custom_nevermore_necromastery:LaunchParticle(target)

local caster = self:GetCaster()
local particle = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf", self)
local soul_projectile = {Target = caster, Source = target, Ability = self, EffectName = particle, bDodgeable = false,bProvidesVision = false,iMoveSpeed = 900,iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION}
ProjectileManager:CreateTrackingProjectile(soul_projectile)
end


modifier_custom_necromastery_souls = class({})
function modifier_custom_necromastery_souls:RemoveOnDeath() return false end
function modifier_custom_necromastery_souls:IsHidden() return false end
function modifier_custom_necromastery_souls:IsPurgable() return false end
function modifier_custom_necromastery_souls:OnCreated()

self.cast = false

self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.parent = self:GetParent()
self.parent:AddDeathEvent(self)

if self.caster:IsRealHero() then 
	self.caster:AddDamageEvent_inc(self)
	self.caster:AddAttackEvent_out(self)
end 


self.perma_stack = 0
self.attack_count = 0

self.proc_count = self.caster:GetTalentValue("modifier_nevermore_souls_4", "attack", true)
self.proc_radius = self.caster:GetTalentValue("modifier_nevermore_souls_4", "radius", true)

self.silence_duration = self.caster:GetTalentValue("modifier_nevermore_souls_6", "silence", true)
self.slow_duration = self.caster:GetTalentValue("modifier_nevermore_souls_6", "duration", true)

self.speed_inc = self.caster:GetTalentValue("modifier_nevermore_souls_7", "speed", true)

self.heal_health = self.caster:GetTalentValue("modifier_nevermore_souls_5", "health", true)
self.heal_heal = self.caster:GetTalentValue("modifier_nevermore_souls_5", "heal", true)/100
self.heal_cd = self.caster:GetTalentValue("modifier_nevermore_souls_5", "cd", true)

self.base_max_souls = self.ability:GetSpecialValueFor("necromastery_max_souls")
self.scepter_max_souls = self.ability:GetSpecialValueFor("necromastery_max_souls_scepter")
self.damage_per_soul = self.ability:GetSpecialValueFor("necromastery_damage_per_soul")
self.souls_per_kill = self.ability:GetSpecialValueFor("souls_per_kill")
self.max_souls = self.base_max_souls
self.souls_lost_on_death_pct = self.ability:GetSpecialValueFor("necromastery_soul_release")/100

if not IsServer() then return end

self:StartIntervalThink(0.2)
end


function modifier_custom_necromastery_souls:OnRefresh()
self.damage_per_soul = self.ability:GetSpecialValueFor("necromastery_damage_per_soul")
end


function modifier_custom_necromastery_souls:OnIntervalThink()
self:RefreshSoulsMax()
end

function modifier_custom_necromastery_souls:RefreshSoulsMax()
self.max_souls = self.ability:GetSpecialValueFor("necromastery_max_souls")
local tempo = 0
if self.caster:HasModifier("modifier_custom_necromastery_tempo_track") then 
	tempo = self.caster:GetUpgradeStack("modifier_custom_necromastery_tempo_track")
end

if self.caster:HasScepter() then
	self.max_souls = self.max_souls + self.scepter_max_souls
end
if self.caster:HasModifier("modifier_custom_necromastery_kills")  then 
	self.max_souls = self.max_souls + self.souls_per_kill*self.caster:GetUpgradeStack("modifier_custom_necromastery_kills")
end
if self.caster:HasTalent("modifier_nevermore_requiem_1") then 
	self.max_souls = self.max_souls + self.caster:GetTalentValue("modifier_nevermore_requiem_1", "max")
end 

self.perma_stack = math.min(self.perma_stack, self.max_souls)

if IsServer() then 
	self:SetStackCount(self.perma_stack + tempo)
end

return self.max_souls
end


function modifier_custom_necromastery_souls:SetMax()
local max = self:RefreshSoulsMax()
self.perma_stack = max
end

function modifier_custom_necromastery_souls:ReduceStack(count)
self.perma_stack = math.max(0, self.perma_stack - count)
end


function modifier_custom_necromastery_souls:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_TOOLTIP,
	MODIFIER_PROPERTY_HEALTH_BONUS,
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end

function modifier_custom_necromastery_souls:GetModifierPreAttack_BonusDamage()
return self.damage_per_soul*self:GetStackCount() 
end

function modifier_custom_necromastery_souls:GetModifierAttackSpeedBonus_Constant()
if not self.caster:HasTalent("modifier_nevermore_souls_7") then return end
return self.speed_inc*self:GetStackCount() 
end

function modifier_custom_necromastery_souls:OnStackCountChanged(iStackCount)
if not IsServer() then return end
self.caster:CalculateStatBonus(true)
end

function modifier_custom_necromastery_souls:GetModifierSpellAmplify_Percentage()
local bonus = 0
if self.caster:HasTalent("modifier_nevermore_souls_2") then 
	bonus = self.caster:GetTalentValue("modifier_nevermore_souls_2", "damage")*self:GetStackCount()
end
return bonus
end

function modifier_custom_necromastery_souls:GetModifierHealthBonus()
local bonus = 0
if self.caster:HasTalent("modifier_nevermore_requiem_3") then 
	bonus = self.caster:GetTalentValue("modifier_nevermore_requiem_3", "health")*self:GetStackCount()
end
return bonus
end


function modifier_custom_necromastery_souls:DeathEvent(params)
if not IsServer() then return end
if self.caster:IsIllusion() then return end
local target = params.unit
local attacker = params.attacker

if not target:IsUnit() then return end


if self.caster == attacker then

	if target:IsIllusion() or self.caster == target then
		return nil
	end

	if target:IsValidKill(self.caster) then 
		self.caster:AddNewModifier(self.caster, nil, "modifier_custom_necromastery_kills", {})
		self:SetMax()
	else 
		self:RefreshSoulsMax()
		self.perma_stack = math.min(self.max_souls, self.perma_stack + 1)
	end

	self.ability:LaunchParticle(target)
end


if self.caster == target and not self.caster:IsReincarnating() then

	self.caster:RemoveModifierByName("modifier_custom_necromastery_tempo_track")
	self.caster:RemoveModifierByName("modifier_custom_necromastery_kills")
	self:RefreshSoulsMax()

	local stacks_lost = math.floor(self.perma_stack  * (self.souls_lost_on_death_pct))
	self.perma_stack = self.perma_stack - stacks_lost


	local requiem = self.caster:FindAbilityByName("custom_nevermore_requiem")

	if requiem and requiem:GetLevel() >= 1 then
		requiem:OnSpellStart(true)
	end
end

end


function modifier_custom_necromastery_souls:AttackEvent_out(params)
if not IsServer() then return end
if params.attacker ~= self.caster then return end
if not params.target:IsUnit() then return end

local frenzy = self.caster:FindModifierByName("modifier_nevermore_frenzy_custom")

if frenzy then 

	if self.caster:HasTalent("modifier_nevermore_souls_6") then 
		params.target:AddNewModifier(self.caster, self.ability, "modifier_custom_necromastery_attack_slow", {duration = self.slow_duration})

		if frenzy.silence == false and params.target:IsHero() then 
			frenzy.silence = true
			params.target:AddNewModifier(self.caster, self.ability, "modifier_custom_necromastery_attack_silence", {duration = self.silence_duration*(1 - params.target:GetStatusResistance())})
		end
	end

	if self.caster:HasTalent("modifier_nevermore_souls_7") and self.caster:IsAlive() then
		self.caster:AddNewModifier(self.caster, nil, "modifier_custom_necromastery_tempo_track", {})
		self:RefreshSoulsMax()
		self.ability:LaunchParticle(params.target)
	end
end


if not self.caster:HasTalent("modifier_nevermore_souls_4") then return end

self.attack_count = self.attack_count + 1

if self.attack_count < self.proc_count then return end
self.attack_count = 0

local damage = self:GetStackCount()*self.caster:GetTalentValue("modifier_nevermore_souls_4", "damage")
self.caster:GenericHeal(damage, self.ability, nil, nil, "modifier_nevermore_souls_4")

for _,target in pairs(self.caster:FindTargets(self.proc_radius, params.target:GetAbsOrigin())) do 
	DoDamage({ victim = target, attacker = self.caster, ability = self.ability, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL}, "modifier_nevermore_souls_4")
end

local effect = ParticleManager:CreateParticle("particles/sf_souls_attack.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.target)
ParticleManager:SetParticleControlEnt(effect, 0 , params.target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", params.target:GetOrigin(),false)
ParticleManager:ReleaseParticleIndex(effect)

params.target:SendNumber(4, damage)
params.target:EmitSound("Sf.Souls_Attack")
params.target:GenericParticle()  	
end



function modifier_custom_necromastery_souls:DamageEvent_inc(params)
if not IsServer() then return end
if self.caster:PassivesDisabled() then return end
if not self.caster:HasTalent("modifier_nevermore_souls_5") then return end
if params.unit ~= self.caster then return end
if self.caster:GetHealthPercent() > self.heal_health then return end
if self.caster:HasModifier("modifier_custom_necromastery_heal_cd") then return end
if self.caster:HasModifier("modifier_death") then return end

local heal = self.caster:GetMaxHealth()*self.heal_heal*self:GetStackCount()

self.caster:GenericHeal(heal, self.ability, nil, nil, "modifier_nevermore_souls_5")
self.caster:Purge(false, true, false, true, true)
self.caster:EmitSound("Sf.Souls_Heal")  

self.caster:GenericParticle("particles/huskar_leap_heal.vpcf")
self.caster:GenericParticle("particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf")

local particle_aoe_fx = ParticleManager:CreateParticle("particles/sf_souls_heal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
ParticleManager:SetParticleControl(particle_aoe_fx, 0,  self.caster:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_aoe_fx, 1, Vector(150, 1, 1))
ParticleManager:ReleaseParticleIndex(particle_aoe_fx)  

self.caster:AddNewModifier(self.caster, nil, "modifier_custom_necromastery_heal_cd", {duration = self.heal_cd})
end


function modifier_custom_necromastery_souls:OnTooltip()
return self:RefreshSoulsMax() 
end



modifier_custom_necromastery_kills = class({})
function modifier_custom_necromastery_kills:IsHidden() return false end
function modifier_custom_necromastery_kills:IsPurgable() return false end
function modifier_custom_necromastery_kills:GetTexture() return "nevermore_necromastery" end
function modifier_custom_necromastery_kills:OnCreated(table)
if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_custom_necromastery_kills:OnRefresh(table)
if not  IsServer() then return end
self:IncrementStackCount()
end

function modifier_custom_necromastery_kills:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TOOLTIP,
}

end
function modifier_custom_necromastery_kills:OnTooltip()
return self:GetStackCount()
end








modifier_custom_necromastery_tempo_track = class({})
function modifier_custom_necromastery_tempo_track:IsHidden() return false end
function modifier_custom_necromastery_tempo_track:IsPurgable() return false end
function modifier_custom_necromastery_tempo_track:GetTexture() return "buffs/souls_tempo" end

function modifier_custom_necromastery_tempo_track:OnCreated(table)
self.RemoveForDuel = true
self:SetStackCount(1)
end

function modifier_custom_necromastery_tempo_track:OnRefresh()
if not IsServer() then return end
self:IncrementStackCount()
end





modifier_custom_necromastery_heal_cd = class({})
function modifier_custom_necromastery_heal_cd:IsHidden() return false end
function modifier_custom_necromastery_heal_cd:IsPurgable() return false end
function modifier_custom_necromastery_heal_cd:IsDebuff() return true end
function modifier_custom_necromastery_heal_cd:RemoveOnDeath() return false end
function modifier_custom_necromastery_heal_cd:GetTexture() return "buffs/souls_heal_cd" end
function modifier_custom_necromastery_heal_cd:OnCreated(table)
self.RemoveForDuel = true
end



modifier_custom_necromastery_attack_slow = class({})
function modifier_custom_necromastery_attack_slow:IsHidden() return true end
function modifier_custom_necromastery_attack_slow:IsPurgable() return true end
function modifier_custom_necromastery_attack_slow:GetEffectName() return "particles/sf_slow_attack.vpcf" end
function modifier_custom_necromastery_attack_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_custom_necromastery_attack_slow:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.slow = self.caster:GetTalentValue("modifier_nevermore_souls_6", "slow")
self.bonus = self.caster:GetTalentValue("modifier_nevermore_souls_6", "bonus")
end

function modifier_custom_necromastery_attack_slow:GetModifierMoveSpeedBonus_Percentage()
local bonus = self.slow
if self.parent:HasModifier("modifier_custom_necromastery_attack_silence") then
	bonus = bonus*self.bonus
end
return bonus
end





modifier_custom_necromastery_attack_silence = class({})
function modifier_custom_necromastery_attack_silence:IsHidden() return true end
function modifier_custom_necromastery_attack_silence:IsPurgable() return true end
function modifier_custom_necromastery_attack_silence:CheckState() 
return 
{
	[MODIFIER_STATE_SILENCED] = true,
} 
end


function modifier_custom_necromastery_attack_silence:GetEffectName() return "particles/generic_gameplay/generic_silenced.vpcf" end
function modifier_custom_necromastery_attack_silence:ShouldUseOverheadOffset() return true end
function modifier_custom_necromastery_attack_silence:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end
function modifier_custom_necromastery_attack_silence:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.parent:EmitSound("Sf.Raze_Silence")
end
