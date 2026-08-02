--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


night_stalker_void_lua = class({})
LinkLuaModifier(
	"modifier_imba_void_ministun",
	"heroes/hero_night_stalker/night_stalker_void_lua/night_stalker_void_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_imba_void_slow",
	"heroes/hero_night_stalker/night_stalker_void_lua/night_stalker_void_lua",
	LUA_MODIFIER_MOTION_NONE
)

function night_stalker_void_lua:IsHiddenWhenStolen()
	return false
end

function night_stalker_void_lua:GetAOERadius()
	return 250
end

function night_stalker_void_lua:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local target_point = self:GetCursorPosition()
	local rare_cast_response = "night_stalker_nstalk_ability_dark_08"
	local cast_response = {
		"night_stalker_nstalk_ability_void_01",
		"night_stalker_nstalk_ability_void_02",
		"night_stalker_nstalk_ability_void_03",
		"night_stalker_nstalk_ability_void_04",
	}
	local sound_cast = "Hero_Nightstalker.Void"
	local modifier_ministun = "modifier_imba_void_ministun"
	local modifier_void = "modifier_imba_void_slow"
	local modifier_darkness = "modifier_imba_darkness_night"

	-- Ability specials
	local damage = ability:GetSpecialValueFor("damage")
	local ministun_duration = ability:GetSpecialValueFor("ministun_duration")
	local day_duration = ability:GetSpecialValueFor("day_duration")
	local night_pull = ability:GetSpecialValueFor("night_pull")
	local night_duration = ability:GetSpecialValueFor("night_duration")
	local night_extend = ability:GetSpecialValueFor("night_extend")

	if RollPercentage(5) then
		-- EmitSoundOnLocationForAllies(caster:GetAbsOrigin(), rare_cast_response, caster)
		EmitSoundOn(rare_cast_response, caster)
	elseif RollPercentage(25) then
		-- EmitSoundOnLocationForAllies(caster:GetAbsOrigin(), cast_response[math.random(1,#cast_response)], caster)
		EmitSoundOn(cast_response[math.random(1, #cast_response)], caster)
	end

	-- Play sound cast
	EmitSoundOn(sound_cast, caster)

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		target_point,
		nil,
		250,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, target in pairs(enemies) do
		if target then
			if caster:GetTeamNumber() ~= target:GetTeamNumber() then
				if target:TriggerSpellAbsorb(ability) then
					return nil
				end
			end

			if self:GetCaster():FindAbilityByName("npc_dota_night_stalker_int2") ~= nil then
				if self:GetCaster():FindAbilityByName("npc_dota_night_stalker_int2"):GetLevel() > 0 then
					damage = ability:GetSpecialValueFor("damage") + 280
				end
			end

			local damageTable = {
				victim = target,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = ability,
			}

			ApplyDamage(damageTable)

			target:AddNewModifier(
				caster,
				ability,
				modifier_ministun,
				{ duration = ministun_duration * (1 - target:GetStatusResistance()) }
			)

			local duration

			if caster:HasModifier(modifier_darkness) then
				duration = night_duration
			else
				if GameRules:IsDaytime() then
					duration = day_duration
				else
					duration = night_duration
				end
			end

			target:AddNewModifier(
				caster,
				ability,
				modifier_void,
				{ duration = duration * (1 - target:GetStatusResistance()) }
			)
		end
	end
end

-- Ministun modifier
modifier_imba_void_ministun = class({})

function modifier_imba_void_ministun:IsHidden()
	return false
end
function modifier_imba_void_ministun:IsPurgeException()
	return true
end
function modifier_imba_void_ministun:IsStunDebuff()
	return true
end

function modifier_imba_void_ministun:CheckState()
	local state = { [MODIFIER_STATE_STUNNED] = true }
	return state
end

function modifier_imba_void_ministun:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_imba_void_ministun:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

-- Attack/movespeed Slow modifier
modifier_imba_void_slow = class({})

function modifier_imba_void_slow:OnCreated()
	-- Ability properties
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()

	-- Ability specials
	self.ms_slow_pct = self.ability:GetSpecialValueFor("ms_slow_pct")
	self.as_slow = self.ability:GetSpecialValueFor("as_slow")
	self.vision_reduction = self.ability:GetSpecialValueFor("vision_reduction")
end

function modifier_imba_void_slow:IsHidden()
	return false
end
function modifier_imba_void_slow:IsPurgable()
	return true
end
function modifier_imba_void_slow:IsDebuff()
	return true
end

function modifier_imba_void_slow:DeclareFunctions()
	local decFuncs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_BONUS_DAY_VISION,
		MODIFIER_PROPERTY_BONUS_NIGHT_VISION,
	}
	return decFuncs
end

function modifier_imba_void_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow_pct * -1
end

function modifier_imba_void_slow:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow * -1
end

function modifier_imba_void_slow:GetBonusDayVision()
	return self.vision_reduction * -1
end

function modifier_imba_void_slow:GetBonusNightVision()
	return self.vision_reduction * -1
end

function modifier_imba_void_slow:GetEffectName()
	return "particles/units/heroes/hero_night_stalker/nightstalker_void.vpcf"
end

function modifier_imba_void_slow:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end