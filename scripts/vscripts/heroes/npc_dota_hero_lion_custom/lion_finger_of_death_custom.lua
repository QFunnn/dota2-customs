--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_lion_finger_of_death_custom", "heroes/npc_dota_hero_lion_custom/lion_finger_of_death_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lion_finger_of_death_custom_buff", "heroes/npc_dota_hero_lion_custom/lion_finger_of_death_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lion_finger_of_death_custom_passive", "heroes/npc_dota_hero_lion_custom/lion_finger_of_death_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lion_finger_of_death_custom_zapret", "heroes/npc_dota_hero_lion_custom/lion_finger_of_death_custom", LUA_MODIFIER_MOTION_NONE )

lion_finger_of_death_custom = class({})

function lion_finger_of_death_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_lion/lion_spell_finger_of_death_woda.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/lion/lion_ti8/lion_spell_finger_ti8.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_lion.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_lion.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_lion.vpcf", context)
end

lion_finger_of_death_custom.modifier_lion_3 = {40,60}
lion_finger_of_death_custom.modifier_lion_14 = 500
lion_finger_of_death_custom.modifier_lion_17 = 300
lion_finger_of_death_custom.modifier_lion_18 = {-4,-8,-12}
lion_finger_of_death_custom.modifier_lion_10 = {1,2}

function lion_finger_of_death_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_lion_finger_punch") then
        return "lion_fist_of_death"
    end
    if self:GetCaster():HasModifier("modifier_lion_9") then
        return "lion_fist_of_death"
    end
	if self:GetCaster():HasModifier("modifier_lion_14") then
		return "lion_14"
	end
	return "lion_finger_of_death"
end

function lion_finger_of_death_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_lion_finger_of_death_custom_zapret") then
        return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AOE
    end
end

function lion_finger_of_death_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_lion_14") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, level)
end

function lion_finger_of_death_custom:GetCooldown( level )
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_lion_18") then
		bonus = self.modifier_lion_18[self:GetCaster():GetTalentLevel("modifier_lion_18")]
	end
	return self.BaseClass.GetCooldown( self, level ) + bonus
end

function lion_finger_of_death_custom:GetIntrinsicModifierName()
	return "modifier_lion_finger_of_death_custom_passive"
end

function lion_finger_of_death_custom:GetAOERadius()
	if self:GetCaster():HasModifier("modifier_lion_17") then
		return self.modifier_lion_17
	end
	return 0
end

function lion_finger_of_death_custom:CastFilterResultTarget( hTarget )
    if hTarget:IsMagicImmune() and (not self:GetCaster():HasModifier("modifier_lion_14")) then
        return UF_FAIL_MAGIC_IMMUNE_ENEMY
    end

    if not IsServer() then return UF_SUCCESS end
    local nResult = UnitFilter(
        hTarget,
        self:GetAbilityTargetTeam(),
        self:GetAbilityTargetType(),
        self:GetAbilityTargetFlags(),
        self:GetCaster():GetTeamNumber()
    )

    if nResult ~= UF_SUCCESS then
        return nResult
    end

    return UF_SUCCESS
end

function lion_finger_of_death_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()

	self:GetCaster():EmitSound("Hero_Lion.FingerOfDeath")

	if target:TriggerSpellAbsorb(self) then
		self:DamageParticle( target )
		return 
	end

	local delay = self:GetSpecialValueFor("damage_delay")

	if self:GetCaster():HasModifier("modifier_lion_17") then
		local targets = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, self:GetCaster():GetAoeBonus(self.modifier_lion_17), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		for _,enemy in pairs(targets) do
			enemy:AddNewModifier( self:GetCaster(), self, "modifier_lion_finger_of_death_custom", { duration = delay } )
			self:DamageParticle( enemy )
		end
	else
		target:AddNewModifier( self:GetCaster(), self, "modifier_lion_finger_of_death_custom", { duration = delay } )
		self:DamageParticle( target )
	end

    if self:GetCaster():HasModifier("modifier_lion_9") then return end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lion_finger_punch", {duration = self:GetSpecialValueFor("punch_duration")})
end

function lion_finger_of_death_custom:DamageParticle( target )
	if not self:GetCaster():HasModifier("modifier_lion_14") then
		local attach = "attach_attack1"
		if self:GetCaster():ScriptLookupAttachment( "attach_attack2" )~=0 then attach = "attach_attack2" end
		local direction = (self:GetCaster():GetAbsOrigin()-target:GetAbsOrigin()):Normalized()
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lion/lion_spell_finger_of_death_woda.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
		ParticleManager:SetParticleControlEnt( particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, attach, Vector(0,0,0), true )
		ParticleManager:SetParticleControlEnt( particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
		ParticleManager:SetParticleControl( particle, 2, target:GetAbsOrigin() )
		ParticleManager:SetParticleControl( particle, 3, target:GetAbsOrigin() + direction )
		ParticleManager:SetParticleControlForward( particle, 3, -direction )
		ParticleManager:ReleaseParticleIndex( particle )
	else
		local vStart = self:GetCaster():GetAbsOrigin()
		local vPosition = target:GetAbsOrigin()
		local vDirection = (vPosition - vStart):Normalized()
		local flDistance = (vPosition - vStart):Length2D()
		local iParticleID = ParticleManager:CreateParticle("particles/econ/items/lion/lion_ti8/lion_spell_finger_ti8.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControlEnt(iParticleID, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack2", self:GetCaster():GetAbsOrigin(), false)
		ParticleManager:SetParticleControl(iParticleID, 1, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(iParticleID, 2, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(iParticleID, 6, vStart + vDirection * flDistance * 0.7 + RandomVector(RandomInt(flDistance * 0.2, flDistance * 0.25)))
		ParticleManager:SetParticleControl(iParticleID, 10, vStart + vDirection * flDistance * 0.3 + RandomVector(RandomInt(flDistance * 0.2, flDistance * 0.25)))
		ParticleManager:ReleaseParticleIndex(iParticleID)
	end
	target:EmitSound("Hero_Lion.FingerOfDeathImpact")
end

modifier_lion_finger_of_death_custom_passive = class({})

function modifier_lion_finger_of_death_custom_passive:IsPurgable() return false end
function modifier_lion_finger_of_death_custom_passive:RemoveOnDeath() return false end
function modifier_lion_finger_of_death_custom_passive:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_lion_finger_of_death_custom_passive:OnTooltip()
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("damage_per_kill")
end

function modifier_lion_finger_of_death_custom_passive:GetModifierHealthBonus()
	if self:GetCaster():HasModifier("modifier_lion_3") then
		return self:GetStackCount() * self:GetAbility().modifier_lion_3[self:GetCaster():GetTalentLevel("modifier_lion_3")]
	end
	return 0
end

function modifier_lion_finger_of_death_custom_passive:GetModifierBonusStats_Agility()
	if self:GetCaster():HasModifier("modifier_lion_10") then
		return self:GetStackCount() * self:GetAbility().modifier_lion_10[self:GetCaster():GetTalentLevel("modifier_lion_10")]
	end
	return 0
end

function modifier_lion_finger_of_death_custom_passive:OnDeath(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if not params.unit:IsRealHero() then return end
    if not self:GetParent():HasModifier("modifier_lion_finger_punch") then return end
    if params.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then return end
    local modifier = self:GetCaster():FindModifierByName("modifier_lion_finger_of_death_custom_passive")
	if modifier and not params.unit:HasModifier("modifier_lion_finger_of_death_custom_buff") then
		modifier:IncrementStackCount()
		self:GetCaster():CalculateStatBonus(true)
	end
end

modifier_lion_finger_of_death_custom_buff = class({})
function modifier_lion_finger_of_death_custom_buff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_lion_finger_of_death_custom_buff:IsHidden() return true end
function modifier_lion_finger_of_death_custom_buff:IsPurgable() return false end

function modifier_lion_finger_of_death_custom_buff:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH
	}
end

function modifier_lion_finger_of_death_custom_buff:OnDeath(params)
	if params.unit ~= self:GetParent() then return end
	if not params.unit:IsRealHero() then return end
	local modifier = self:GetCaster():FindModifierByName("modifier_lion_finger_of_death_custom_passive")
	if modifier then
		modifier:IncrementStackCount()
		self:GetCaster():CalculateStatBonus(true)
	end
end

modifier_lion_finger_of_death_custom = class({})

function modifier_lion_finger_of_death_custom:IsHidden()
	return true
end

function modifier_lion_finger_of_death_custom:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_lion_finger_of_death_custom:IsPurgable()
	return false
end

function modifier_lion_finger_of_death_custom:OnCreated( kv )
	if not IsServer() then return end
	local grace_period = self:GetAbility():GetSpecialValueFor("grace_period")
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_lion_finger_of_death_custom_buff", {duration = grace_period})
	local bonus_damage = 0
	local bonus_damage_modifier = self:GetCaster():FindModifierByName("modifier_lion_finger_of_death_custom_passive")
	if bonus_damage_modifier then
		bonus_damage = bonus_damage + ( self:GetAbility():GetSpecialValueFor("damage_per_kill") * bonus_damage_modifier:GetStackCount() )
	end
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" ) + bonus_damage
end

function modifier_lion_finger_of_death_custom:OnRefresh( kv )
	if not IsServer() then return end
	local grace_period = self:GetAbility():GetSpecialValueFor("grace_period")
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_lion_finger_of_death_custom_buff", {duration = grace_period})
	local bonus_damage = 0
	local bonus_damage_modifier = self:GetCaster():FindModifierByName("modifier_lion_finger_of_death_custom_passive")
	if bonus_damage_modifier then
		bonus_damage = bonus_damage + ( self:GetAbility():GetSpecialValueFor("damage_per_kill") * bonus_damage_modifier:GetStackCount() )
	end
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" ) + bonus_damage
end

function modifier_lion_finger_of_death_custom:OnDestroy( kv )
	if not IsServer() then return end
	if not self:GetParent():IsAlive() then return end

	local damage_type = DAMAGE_TYPE_MAGICAL

	if self:GetCaster():HasModifier("modifier_lion_14") then
		damage_type = DAMAGE_TYPE_PHYSICAL
		self.damage = self.damage + self:GetCaster():GetAgility() / 100 * self:GetAbility().modifier_lion_14
	end

	ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage, damage_type = damage_type, ability = self:GetAbility() })
end

modifier_lion_finger_of_death_custom_zapret = class({})
function modifier_lion_finger_of_death_custom_zapret:IsHidden() return true end
function modifier_lion_finger_of_death_custom_zapret:IsPurgable() return false end
function modifier_lion_finger_of_death_custom_zapret:IsPurgeException() return false end
function modifier_lion_finger_of_death_custom_zapret:RemoveOnDeath() return false end