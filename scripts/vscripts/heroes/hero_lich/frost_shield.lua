--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ability_lich_frost_shield", "heroes/hero_lich/frost_shield", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_lich_frost_shield_slow", "heroes/hero_lich/frost_shield", LUA_MODIFIER_MOTION_NONE )

if ability_lich_frost_shield == nil then
	ability_lich_frost_shield = class({})
end

function ability_lich_frost_shield:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_lich/lich_ice_age.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_lich/lich_frost_armor.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_lich/lich_ice_age_dmg.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_lich/lich_ice_age_debuff.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_lich_ice_age.vpcf", context)
end

function ability_lich_frost_shield:CastFilterResultTarget( hTarget )
	if not IsServer() then return end

    if hTarget:IsOther() and hTarget:GetUnitName() ~= "npc_dota_lich_ice_spire" then
        return UF_FAIL_OTHER
    end

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

function ability_lich_frost_shield:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local Duration = self:GetSpecialValueFor("duration")

	if target then
		target:AddNewModifier(caster, self, "modifier_ability_lich_frost_shield", {duration=Duration})

		EmitSoundOn("Hero_Lich.IceAge", target)
	end

	-- [#22/NP-4] Талант lich_4 даёт 2 заряда, но общий AbilityCooldown (30/25/20/15) после
	-- траты первого заряда блокировал второй до конца кулдауна. При активных зарядах
	-- сбрасываем кулдаун до короткого (0.3с), чтобы можно было применить второй заряд сразу
	-- (паттерн Zeus jump). Перезарядку самих зарядов считает движок через нативный
	-- AbilityChargeRestoreTime (он же рисует визуал свипа/счётчика). Без таланта
	-- (charges=0) — обычный кулдаун 30/25/20/15.
	if IsServer() then
		local maxCharges = self:GetSpecialValueFor("AbilityCharges")
		if maxCharges and maxCharges > 0 then
			self:EndCooldown()
			self:StartCooldown(0.3)
		end
	end
end


modifier_ability_lich_frost_shield = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return (self.Undispellable or 0) == 0 end,
    IsPurgeException        = function(self) return (self.Undispellable or 0) == 0 end,
    IsDebuff                = function(self) return false end,

	DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
			MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
			MODIFIER_EVENT_ON_DEATH
        }
    end,

	GetModifierIncomingDamage_Percentage	= function(self, event)
		local DamageType = event.damage_type
		if DamageType == DAMAGE_TYPE_PHYSICAL then
			return -(self.DamageReduction or 0)
		end
		return 0
	end,

	GetModifierConstantHealthRegen	= function(self)
		return self.TalentHealthRegen or 0
	end,
})

function modifier_ability_lich_frost_shield:OnCreated()
	self:UpdateKV()

	if IsServer() then
		self:StartIntervalThink(self.WaveInterval or 1)

		local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_lich/lich_ice_age.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControlEnt(fx, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), true)
		self:AddParticle(fx, false, false, -1, false, false)

		fx = ParticleManager:CreateParticle("particles/units/heroes/hero_lich/lich_frost_armor.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
		self:AddParticle(fx, false, false, -1, false, false)

		self:OnIntervalThink()
	end
end

function modifier_ability_lich_frost_shield:OnRefresh()
	self:UpdateKV()
end

function modifier_ability_lich_frost_shield:UpdateKV()
	local ability = self:GetAbility()
	if ability then
		self.DamageReduction = ability:GetSpecialValueFor("damage_reduction")
		self.WaveSlowDuration = ability:GetSpecialValueFor("slow_duration")
		self.WaveInterval = ability:GetSpecialValueFor("interval")
		self.WaveRadius = ability:GetSpecialValueFor("radius")
		self.WaveDamage = ability:GetSpecialValueFor("damage")

		self.TalentHealthRegen = ability:GetSpecialValueFor("health_regen")

		self.FacetBonusDurationPerKillHero = ability:GetSpecialValueFor("bonus_duration_per_hero_killed")
		self.FacetBonusDurationPerKillCreep = ability:GetSpecialValueFor("bonus_duration_per_creep_killed")

		self.Undispellable = ability:GetSpecialValueFor("undispellable")
	end
end

function modifier_ability_lich_frost_shield:OnIntervalThink()
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	
	if parent and caster and ability then
		local Units = FindUnitsInRadius(
			caster:GetTeamNumber(), 
			parent:GetAbsOrigin(), 
			nil, 
			self.WaveRadius or 0, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS, 
			DOTA_UNIT_TARGET_FLAG_NONE, 
			FIND_ANY_ORDER, 
			false
		)

		for _, unit in ipairs(Units) do
			unit:EmitSound("Hero_Lich.IceAge.Damage")

			local Duration = (self.WaveSlowDuration or 0) * (1 - unit:GetStatusResistance())
			unit:AddNewModifier(caster, ability, "modifier_ability_lich_frost_shield_slow", {duration=Duration})

			ApplyDamage({
				victim = unit,
				damage = self.WaveDamage or 0,
				damage_type = ability:GetAbilityDamageType(),
				damage_flags = DOTA_DAMAGE_FLAG_NONE,
				attacker = caster,
				ability = ability
			})
		end

		if parent:GetUnitName() == "npc_dota_lich_ice_spire" then
			parent:Heal(2, ability)
		end

		local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_lich/lich_ice_age_dmg.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
		ParticleManager:SetParticleControlEnt(fx, 1, parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), true)
		ParticleManager:SetParticleControl(fx, 2, Vector(self.WaveRadius, self.WaveRadius, self.WaveRadius))
		
		ParticleManager:ReleaseParticleIndex(fx)

		parent:EmitSound("Hero_Lich.IceAge.Tick")
	end
end

function modifier_ability_lich_frost_shield:OnDeath(event)
	if self.FacetBonusDurationPerKillHero == 0 then return end

	local caster = self:GetCaster()
	local attacker = event.attacker
	local unit = event.unit
	local inflictor = event.inflictor
	
	if caster and unit and attacker then
		local bDiedFromFrostShield = inflictor and inflictor:GetName() == "ability_lich_frost_shield"

		local Modif = unit:FindModifierByName("modifier_ability_lich_frost_shield_slow")

		local bDiedUnderFrostShield = Modif ~= nil

		if (bDiedFromFrostShield and inflictor:GetCaster() == caster) or (bDiedUnderFrostShield and Modif:GetCaster() == caster) then
			local BonusDuration = self.FacetBonusDurationPerKillCreep
			if unit:IsRealHero() and not unit:IsIllusion() and not unit:IsStrongIllusion() and not unit:IsTempestDouble() and not unit:IsClone() then
				BonusDuration = self.FacetBonusDurationPerKillHero
			end

			self:SetDuration(self:GetRemainingTime() + BonusDuration, true)
		end
	end
end

modifier_ability_lich_frost_shield_slow = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return true end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return true end,

	DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        }
    end,

	GetModifierMoveSpeedBonus_Percentage	= function(self)
		return -(self.MovespeedSlow or 0)
	end,

	GetEffectName 						= function(self)
		return "particles/units/heroes/hero_lich/lich_ice_age_debuff.vpcf"
	end,

	GetStatusEffectName					= function(self)
		return "particles/status_fx/status_effect_lich_ice_age.vpcf"
	end,
})

function modifier_ability_lich_frost_shield_slow:OnCreated()
	local ability = self:GetAbility()
	if ability then
		self.MovespeedSlow = ability:GetSpecialValueFor("movement_slow")
	end
end

modifier_ability_lich_frost_shield_slow.OnRefresh = modifier_ability_lich_frost_shield_slow.OnCreated