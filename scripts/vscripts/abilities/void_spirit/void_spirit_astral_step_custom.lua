--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_void_spirit_astral_step", "abilities/void_spirit/void_spirit_astral_step_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_void_spirit_astral_step_attack", "abilities/void_spirit/void_spirit_astral_step_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_void_spirit_astral_step_tracker", "abilities/void_spirit/void_spirit_astral_step_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_void_spirit_astral_step_spells", "abilities/void_spirit/void_spirit_astral_step_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_void_spirit_astral_step_heal_reduce", "abilities/void_spirit/void_spirit_astral_step_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_void_spirit_astral_step_status", "abilities/void_spirit/void_spirit_astral_step_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_void_spirit_astral_replicant", "abilities/void_spirit/void_spirit_astral_step_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_void_spirit_astral_strikes", "abilities/void_spirit/void_spirit_astral_step_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_void_spirit_legendary_illusion", "abilities/void_spirit/void_spirit_astral_step_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_void_spirit_astral_stun_cd", "abilities/void_spirit/void_spirit_astral_step_custom", LUA_MODIFIER_MOTION_NONE)



void_spirit_astral_step_custom = class({})

function void_spirit_astral_step_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_impact.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_debuff.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/void_spirit_attack_travel_strike_blur_custom.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_void_spirit_astral_step_debuff.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_dmg.vpcf", context )
PrecacheResource( "particle","particles/void_spirit/step_count.vpcf", context )
PrecacheResource( "particle","particles/void_spirit/step_spells_mark.vpcf", context )
PrecacheResource( "particle","particles/void_spirit/step_status.vpcf", context )
PrecacheResource( "particle","particles/void_spirit/step_legendary_vector.vpcf", context )
end



function void_spirit_astral_step_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "void_spirit_astral_step", self)
end

function void_spirit_astral_step_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_void_spirit_astral_step_tracker"
end

function void_spirit_astral_step_custom:GetManaCost(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_void_step_5") then 
	bonus = self:GetCaster():GetTalentValue("modifier_void_step_5", "mana")
end 
return self.BaseClass.GetManaCost(self,level) + bonus
end

function void_spirit_astral_step_custom:GetAbilityChargeRestoreTime(level)
local bonus = 0
local caster = self:GetCaster()
if caster:HasTalent("modifier_void_step_2") then 
  bonus = caster:GetTalentValue("modifier_void_step_2", "cd")
end 
if caster:HasModifier("modifier_void_spirit_innate_custom_scepter_step") then
	bonus = bonus - caster:GetUpgradeStack("modifier_void_spirit_innate_custom_scepter_step")
end
return self:GetSpecialValueFor("AbilityChargeRestoreTime") + bonus
end

function void_spirit_astral_step_custom:GetCastPoint()
local bonus = 0
if self:GetCaster():HasTalent("modifier_void_step_6") then 
	bonus = self:GetCaster():GetTalentValue("modifier_void_step_6", "cast")
end
return self.BaseClass.GetCastPoint(self) + bonus
end

function void_spirit_astral_step_custom:GetCastRange(vLocation, hTarget)
if IsServer() then 
	return 9999999
end
return self:GetSpecialValueFor("max_travel_distance")
end

function void_spirit_astral_step_custom:AutoStack(target, is_attack)
local caster = self:GetCaster()
if not caster:HasTalent("modifier_void_step_4") then return end

local attack = 0
if is_attack then
	attack = 1
end
target:AddNewModifier(caster, self, "modifier_void_spirit_astral_step_spells", {duration = caster:GetTalentValue("modifier_void_step_4", "duration"), is_attack = attack})
end



function void_spirit_astral_step_custom:DealDamage(target, damage_k)
local caster = self:GetCaster()
local damage = self:GetSpecialValueFor("pop_damage") 
local damage_ability = nil

if target and caster:HasTalent("modifier_void_step_4") then
	local bonus = (target:GetMaxHealth() - target:GetHealth())*caster:GetTalentValue("modifier_void_step_4", "damage")/100
	if target:IsCreep() then
		bonus = math.min(bonus, caster:GetTalentValue("modifier_void_step_4", "creeps"))
	end
	damage = damage + bonus
end

if damage_k then
	damage_ability = "modifier_void_step_4"
	damage = damage*damage_k
end

target:SendNumber(4, damage)

DoDamage( {victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self, }, damage_ability	)
local effect_name = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_dmg.vpcf", self)
target:GenericParticle(effect_name)
end



function void_spirit_astral_step_custom:OnSpellStart()

local caster = self:GetCaster()
local origin = caster:GetOrigin()
local point = self:GetCursorPosition()

local max_dist = self:GetSpecialValueFor( "max_travel_distance" )
local min_dist = self:GetSpecialValueFor( "min_travel_distance" )

if point == origin then 
	point = caster:GetAbsOrigin() + caster:GetForwardVector()*10
end

local vec = (point - caster:GetAbsOrigin())

if vec:Length2D() > max_dist + caster:GetCastRangeBonus() then 
	point = caster:GetAbsOrigin() + vec:Normalized()*(max_dist + caster:GetCastRangeBonus())
else 
	if vec:Length2D() < min_dist then 
		point = caster:GetAbsOrigin() + vec:Normalized()*min_dist
	end
end

self:CastSpell(point)
end



function void_spirit_astral_step_custom:CastSpell( point, new_origin)

local caster = self:GetCaster()
local origin = caster:GetOrigin()
if new_origin then
	origin = new_origin
end

local target = GetGroundPosition( point, nil )

local radius = self:GetSpecialValueFor( "radius" )
local delay = self:GetSpecialValueFor( "pop_damage_delay" )
local heal_reduce_duration = caster:GetTalentValue("modifier_void_step_1", "duration", true)
local health_thresh = caster:GetTalentValue("modifier_void_step_5", "health", true)
local stun_duration = caster:GetTalentValue("modifier_void_step_5", "stun", true)
local break_duration = caster:GetTalentValue("modifier_void_step_5", "break_duration", true)
local stun_cd = caster:GetTalentValue("modifier_void_step_5", "cd", true)

local no_damage = 0

local mod = caster:FindModifierByName("modifier_void_spirit_astral_replicant")
if mod then 
	no_damage = 1
	mod:IncrementStackCount()
end

if caster:HasTalent("modifier_void_step_6") then 
	ProjectileManager:ProjectileDodge(caster)
	caster:AddNewModifier(caster, self, "modifier_void_spirit_astral_step_status", {duration = caster:GetTalentValue("modifier_void_step_6", "duration")})
end

EmitSoundOnLocationWithCaster(origin, "Hero_VoidSpirit.AstralStep.Start", caster)

if not new_origin then
	FindClearSpaceForUnit( caster, target, true )
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_2_END)
end

caster:EmitSound("Hero_VoidSpirit.AstralStep.End")

local enemies = FindUnitsInLine( caster:GetTeamNumber(), origin, target, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES )

if no_damage == 0 then
	caster:AddNewModifier(caster, self, "modifier_void_spirit_astral_step_attack", {duration = 0.1})
end

for _,enemy in pairs(enemies) do
	if enemy:IsUnit() and not enemy:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then 
		enemy:AddNewModifier( caster, self, "modifier_void_spirit_astral_step", {duration = delay, no_damage = no_damage})

		if no_damage == 0 then
			if caster:HasTalent("modifier_void_step_1") then
				enemy:EmitSound("DOTA_Item.Daedelus.Crit")
				enemy:AddNewModifier(caster, self, "modifier_void_spirit_astral_step_heal_reduce", {duration = heal_reduce_duration})
			end

			if caster:HasTalent("modifier_void_step_5") and not enemy:HasModifier("modifier_void_spirit_astral_stun_cd") and enemy:GetHealthPercent() <= health_thresh then
				enemy:AddNewModifier(caster, self, "modifier_void_spirit_astral_stun_cd", {duration = stun_cd})
				enemy:AddNewModifier(caster, self, "modifier_bashed", {duration = (1 - enemy:GetStatusResistance())*stun_duration})
				if enemy:IsHero() then
					enemy:EmitSound("DOTA_Item.SilverEdge.Target")
				end
				local mod = enemy:AddNewModifier(caster, self, "modifier_generic_break", {duration = (1 - enemy:GetStatusResistance())*break_duration})
				if mod then
					enemy:GenericParticle("particles/items3_fx/silver_edge.vpcf", mod)
				end
			end

			self:AutoStack(enemy)
			caster:PerformAttack( enemy, true, true, true, false, true, false, true )
		end
	end
end

if #enemies > 0 then
	local shield = caster:FindAbilityByName("void_spirit_resonant_pulse_custom")
	if shield then
		shield:LegendaryStack()
	end

	if caster:HasTalent("modifier_void_astral_6") and no_damage == 0 then
		caster:CdItems(caster:GetTalentValue("modifier_void_astral_6", "cd_items"))
	end
end

caster:RemoveModifierByName("modifier_void_spirit_astral_step_attack")

local particle_name = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step.vpcf", self)
local effect_cast = ParticleManager:CreateParticle( particle_name, PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast, 0, origin )
ParticleManager:SetParticleControl( effect_cast, 1, target )
ParticleManager:ReleaseParticleIndex( effect_cast )
caster:GenericParticle(wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_void_spirit/void_spirit_attack_travel_strike_blur_custom.vpcf", self))
end





modifier_void_spirit_astral_step = class({})
function modifier_void_spirit_astral_step:IsHidden() return false end
function modifier_void_spirit_astral_step:IsPurgable() return true end
function modifier_void_spirit_astral_step:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_void_spirit_astral_step:OnCreated( kv )

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.slow = -self.ability:GetSpecialValueFor( "movement_slow_pct" )
if not IsServer() then return end

local effect_name = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_impact.vpcf", self)
local debuff_particle = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_debuff.vpcf", self)

local particle = ParticleManager:CreateParticle(debuff_particle, PATTACH_ABSORIGIN_FOLLOW, self.parent)
self:AddParticle(particle, false, false, -1, false, false)

self.parent:GenericParticle(effect_name)
self.no_damage = kv.no_damage
end


function modifier_void_spirit_astral_step:OnDestroy()
if not IsServer() then return end
if self.no_damage == 1 then return end
if self.parent:IsNull() or not self.parent:IsAlive() then return end

self.ability:DealDamage(self.parent)
end

function modifier_void_spirit_astral_step:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_void_spirit_astral_step:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end


function modifier_void_spirit_astral_step:GetStatusEffectName() return "particles/status_fx/status_effect_void_spirit_astral_step_debuff.vpcf" end
function modifier_void_spirit_astral_step:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH  end




modifier_void_spirit_astral_step_attack = class({})
function modifier_void_spirit_astral_step_attack:IsHidden() return true end
function modifier_void_spirit_astral_step_attack:IsPurgable() return false end
function modifier_void_spirit_astral_step_attack:OnCreated(table)
self.parent = self:GetParent()
self.crit_damage = self.parent:GetTalentValue("modifier_void_step_1", "crit")
end

function modifier_void_spirit_astral_step_attack:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
}
end

function modifier_void_spirit_astral_step_attack:GetCritDamage() 
if not self.parent:HasTalent("modifier_void_step_1") then return end
return self.crit_damage
end

function modifier_void_spirit_astral_step_attack:GetModifierPreAttack_CriticalStrike(params)
if not self.parent:HasTalent("modifier_void_step_1") then return end
return self.crit_damage
end



modifier_void_spirit_astral_step_tracker = class({})
function modifier_void_spirit_astral_step_tracker:IsHidden() return true end
function modifier_void_spirit_astral_step_tracker:IsPurgable() return false end
function modifier_void_spirit_astral_step_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
}
end

function modifier_void_spirit_astral_step_tracker:GetModifierCastRangeBonusStacking()
return self.range_bonus
end

function modifier_void_spirit_astral_step_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.heal_creeps = self.parent:GetTalentValue("modifier_void_step_3", "creeps", true)
self.heal_bonus = self.parent:GetTalentValue("modifier_void_step_3", "bonus", true)
self.heal_base = 0

self.range_bonus = 0

if not IsServer() then return end
self:SetHasCustomTransmitterData(true)
self:UpdateTalent()
end

function modifier_void_spirit_astral_step_tracker:UpdateTalent(name)

if name == "modifier_void_step_legendary" or self.parent:HasTalent("modifier_void_step_legendary") then
	self.parent:AddAttackEvent_out(self)
end

if name == "modifier_void_step_4" or self.parent:HasTalent("modifier_void_step_4") then
	self.parent:AddAttackEvent_out(self)
end

if name == "modifier_void_step_3" or self.parent:HasTalent("modifier_void_step_3") then
	self.heal_base = self.parent:GetTalentValue("modifier_void_step_3", "heal")/100
	self.parent:AddDamageEvent_out(self)
end

self.range_bonus = self.parent:GetTalentValue("modifier_void_step_2", "range")
self:SendBuffRefreshToClients()
end

function modifier_void_spirit_astral_step_tracker:AddCustomTransmitterData() 
return 
{
  range_bonus = self.range_bonus,
} 
end

function modifier_void_spirit_astral_step_tracker:HandleCustomTransmitterData(data)
self.range_bonus = data.range_bonus
end


function modifier_void_spirit_astral_step_tracker:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
if params.no_attack_cooldown then return end

if self.parent:HasModifier("modifier_void_spirit_astral_replicant") then
	self.ability:AddCharge(1, "particles/void_spirit/shield_refresh.vpcf")
end

if self.parent:HasTalent("modifier_void_step_4") then
	self.ability:AutoStack(params.target, 1)
end

end


function modifier_void_spirit_astral_step_tracker:DamageEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_void_step_3") then return end
if not self.parent:CheckLifesteal(params) then return end

local heal = params.damage*self.heal_base
local hide_number = ""
if (params.inflictor and params.inflictor == self.ability) or self.parent:HasModifier("modifier_void_spirit_astral_step_attack") then
	heal = heal*self.heal_bonus
	hide_number = nil
end
if params.unit:IsCreep() then
	heal = heal/self.heal_creeps
end
self.parent:GenericHeal(heal, self.ability, true, hide_number, "modifier_void_step_3")
end









modifier_void_spirit_astral_step_spells = class({})
function modifier_void_spirit_astral_step_spells:IsHidden() return true end
function modifier_void_spirit_astral_step_spells:IsPurgable() return false end
function modifier_void_spirit_astral_step_spells:GetTexture() return "buffs/step_spells" end
function modifier_void_spirit_astral_step_spells:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.attack_count = 0
self.attack_max = self.caster:GetTalentValue("modifier_void_step_4", "attack")
self.max = self.caster:GetTalentValue("modifier_void_step_4", "max")
if not IsServer() then return end 

if not self.caster:HasTalent("modifier_void_astral_legendary") then
	self.effect_cast = self.parent:GenericParticle("particles/void_spirit/step_count.vpcf", self, true)
end

self:IncStack(table.is_attack)
end

function modifier_void_spirit_astral_step_spells:OnRefresh(table)
if not IsServer() then return end 
self:IncStack(table.is_attack)
end

function modifier_void_spirit_astral_step_spells:IncStack(is_attack)
if is_attack == 1 then
	self.attack_count = self.attack_count + 1
end

if self.attack_count >= self.attack_max or is_attack == 0 then
	if self.attack_count >= self.attack_max then
		self.attack_count = 0
	end
	self:IncrementStackCount()

	if self:GetStackCount() >= self.max then
    local effect_name = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_impact.vpcf", self)
		self.parent:GenericParticle(effect_name)
		self.ability:DealDamage(self.parent, self.caster:GetTalentValue("modifier_void_step_4", "damage_auto")/100)
		self:Destroy()
	end
end

end


function modifier_void_spirit_astral_step_spells:OnStackCountChanged(iStackCount)
if not self.effect_cast then return end
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )
end







modifier_void_spirit_astral_step_heal_reduce = class({})
function modifier_void_spirit_astral_step_heal_reduce:IsHidden() return true end
function modifier_void_spirit_astral_step_heal_reduce:IsPurgable() return false end
function modifier_void_spirit_astral_step_heal_reduce:GetEffectName() return "particles/items4_fx/spirit_vessel_damage.vpcf" end
function modifier_void_spirit_astral_step_heal_reduce:OnCreated()
self.caster = self:GetCaster()
self.heal = self.caster:GetTalentValue("modifier_void_step_1", "heal_reduce")
end


function modifier_void_spirit_astral_step_heal_reduce:DeclareFunctions()
return
{
	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_void_spirit_astral_step_heal_reduce:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal
end

function modifier_void_spirit_astral_step_heal_reduce:GetModifierHealChange() 
return self.heal
end

function modifier_void_spirit_astral_step_heal_reduce:GetModifierHPRegenAmplify_Percentage()
return self.heal
end




modifier_void_spirit_astral_step_status = class({})
function modifier_void_spirit_astral_step_status:IsHidden() return true end
function modifier_void_spirit_astral_step_status:IsPurgable() return false end
function modifier_void_spirit_astral_step_status:GetEffectName() return "particles/void_spirit/step_status.vpcf" end
function modifier_void_spirit_astral_step_status:OnCreated()
self.parent = self:GetParent()
self.status = self.parent:GetTalentValue("modifier_void_step_6", "status")
self.damage_reduce = self.parent:GetTalentValue("modifier_void_step_6", "damage_reduce")
end

function modifier_void_spirit_astral_step_status:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
  MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
}
end

function modifier_void_spirit_astral_step_status:GetModifierStatusResistanceStacking() 
return self.status
end

function modifier_void_spirit_astral_step_status:GetModifierIncomingDamage_Percentage() 
return self.damage_reduce
end

function modifier_void_spirit_astral_step_status:GetStatusEffectName()
return "particles/status_fx/status_effect_void_spirit_pulse_buff.vpcf"
end

function modifier_void_spirit_astral_step_status:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end




void_spirit_astral_replicant = class({})


function void_spirit_astral_replicant:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/generic_gameplay/void_step_active.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_clinkz/void_buf.vpcf", context )
PrecacheResource( "particle","particles/void_buf2.vpcf", context )
PrecacheResource( "particle","particles/void_step_texture.vpcf", context )

end

function void_spirit_astral_replicant:CreateTalent()
self:SetHidden(false)
end


function void_spirit_astral_replicant:GetCooldown(iLevel)
local bonus = 0
local caster = self:GetCaster()
if caster:HasTalent("modifier_void_step_2") then
	bonus = caster:GetTalentValue("modifier_void_step_2", "cd")
end
return caster:GetTalentValue("modifier_void_step_legendary", "cd") + bonus
end


function void_spirit_astral_replicant:OnSpellStart()
local caster = self:GetCaster()
caster:AddNewModifier(caster, self, "modifier_void_spirit_astral_replicant", {duration = caster:GetTalentValue("modifier_void_step_legendary", "duration")})
end


modifier_void_spirit_astral_replicant = class({})
function modifier_void_spirit_astral_replicant:IsHidden() return true end
function modifier_void_spirit_astral_replicant:IsPurgable() return false end
function modifier_void_spirit_astral_replicant:GetEffectName() return "particles/generic_gameplay/void_step_active.vpcf" end
function modifier_void_spirit_astral_replicant:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.point = self.parent:GetAbsOrigin()
self.illusion = nil

self.parent:EmitSound("VoidSpirit.Step.Active")
self.parent:GenericParticle("particles/units/heroes/hero_clinkz/void_buf.vpcf", self)
self.parent:GenericParticle("particles/void_buf2.vpcf")
self.parent:GenericParticle("particles/void_spirit/step_spells_mark.vpcf", self, true)

self.particle = ParticleManager:CreateParticleForPlayer("particles/void_spirit/step_legendary_vector.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, PlayerResource:GetPlayer(self.parent:GetPlayerOwnerID()))
ParticleManager:SetParticleControl(self.particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 1, self.point + self.parent:GetForwardVector()*1)
self:AddParticle(self.particle,true,false,0,false,false)

self.ability:EndCd()
self.RemoveForDuel = true

self.max_time = self:GetRemainingTime()

local illusion_self = CreateIllusions(self.parent,self.parent, {outgoing_damage = 0, duration	= self:GetRemainingTime() + 0.2}, 1, 0, false, false, true)
for _,illusion in pairs(illusion_self) do
	illusion.owner = self.parent
	illusion:SetAbsOrigin(self.point)
	illusion:AddNewModifier(illusion, self.ability, "modifier_void_spirit_legendary_illusion", {})
	self.illusion = illusion
end

self:OnIntervalThink()
self:StartIntervalThink(0.1)
end


function modifier_void_spirit_astral_replicant:OnIntervalThink()
if not IsServer() then return end
self.parent:UpdateUIshort({max_time = self.max_time, time = self:GetRemainingTime(), stack = self:GetStackCount(), style = "VoidStep"})
end

function modifier_void_spirit_astral_replicant:OnDestroy()
if not IsServer() then return end

self.parent:UpdateUIshort({hide = 1, hide_full = 1, style = "VoidStep"})
self.ability:StartCd()

if not self.parent:IsAlive() then return end
if self:GetStackCount() == 0 then return end

if self.illusion and not self.illusion:IsNull() then
	self.illusion:Kill(nil, nil)
end

local ability = self.parent:FindAbilityByName("void_spirit_astral_step_custom")

if not ability then return end
if self:GetStackCount() == 0 then return end

self.parent:EmitSound("VoidSpirit.Step.Active_End")
self.parent:AddNewModifier(self.parent, ability, "modifier_void_spirit_astral_strikes", {max = self:GetStackCount(), x = self.point.x, y = self.point.y})
end



modifier_void_spirit_astral_strikes = class({})
function modifier_void_spirit_astral_strikes:IsHidden() return true end
function modifier_void_spirit_astral_strikes:IsPurgable() return false end

function modifier_void_spirit_astral_strikes:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = table.max
self.origin = self.parent:GetAbsOrigin()
self.target = GetGroundPosition(Vector(table.x, table.y, 0), nil)
self:StartIntervalThink(0.1)
end


function modifier_void_spirit_astral_strikes:OnIntervalThink()
if not IsServer() then return end

local origin = self.origin
if self:GetStackCount() == 0 then
	origin = nil
end

self:IncrementStackCount()

self.ability:CastSpell(self.target, origin)

if self:GetStackCount() >= self.max then 
	self:Destroy()
end

end




modifier_void_spirit_legendary_illusion = class({})
function modifier_void_spirit_legendary_illusion:IsHidden() return true end
function modifier_void_spirit_legendary_illusion:IsPurgable() return false end
function modifier_void_spirit_legendary_illusion:GetStatusEffectName() return "particles/void_step_texture.vpcf" end
function modifier_void_spirit_legendary_illusion:StatusEffectPriority() return MODIFIER_PRIORITY_ILLUSION end
function modifier_void_spirit_legendary_illusion:OnCreated(table)
if not IsServer() then return end
self:GetParent():StartGesture(ACT_DOTA_CAPTURE)
end

function modifier_void_spirit_legendary_illusion:CheckState()
return
{
	[MODIFIER_STATE_INVULNERABLE] = true,
	[MODIFIER_STATE_UNTARGETABLE] = true,
	[MODIFIER_STATE_UNSELECTABLE] = true,
	[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	[MODIFIER_STATE_FROZEN] = true,
	[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
	[MODIFIER_STATE_OUT_OF_GAME]	= true,
	[MODIFIER_STATE_STUNNED]	= true,
}
end



modifier_void_spirit_astral_stun_cd = class({})
function modifier_void_spirit_astral_stun_cd:IsHidden() return true end
function modifier_void_spirit_astral_stun_cd:IsPurgable() return false end
function modifier_void_spirit_astral_stun_cd:RemoveOnDeath() return false end
function modifier_void_spirit_astral_stun_cd:OnCreated()
self.RemoveForDuel = true
end