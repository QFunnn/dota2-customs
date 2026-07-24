--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_chen_hand_of_god_custom", "heroes/hero_chen/chen_hand_of_god_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_chen_hand_of_god_custom_immunity", "heroes/hero_chen/chen_hand_of_god_custom", LUA_MODIFIER_MOTION_NONE)

chen_hand_of_god_custom = class({})

function chen_hand_of_god_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local heal_amount = self:GetSpecialValueFor("heal_amount") / 100
	local hot_duration = self:GetSpecialValueFor("hot_duration")
	local units = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false )

	local caster_found = false
	for _, unit in pairs(units) do
		if unit == caster then
			caster_found = true
		end
		local health = unit:GetMaxHealth()
		local heal = health * heal_amount
		unit:Heal(heal, self)
		unit:AddNewModifier(caster, self, "modifier_chen_hand_of_god_custom", {duration = hot_duration})
		unit:AddNewModifier(caster, self, "modifier_black_king_bar_immune", {duration = hot_duration})
		unit:AddNewModifier(caster, self, "modifier_chen_hand_of_god_custom_immunity", {duration = hot_duration})
		if caster:HasTalent("special_bonus_unique_chen_12") then
			unit:Purge(false, true, false, true, false)
		end
		unit:EmitSound("chen_chen_ability_handgod_02")
		if unit:IsRealHero() then
			unit:EmitSound("Hero_Chen.HandOfGodHealHero")
		elseif unit:IsCreep() then
			unit:EmitSound("Hero_Chen.HandOfGodHealCreep")
		end
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_chen/chen_hand_of_god.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
		ParticleManager:ReleaseParticleIndex(particle)
	end

	-- Snowball fix: if caster was not found by FindUnitsInRadius (e.g. hidden inside Snowball), apply manually
	if not caster_found then
		local health = caster:GetMaxHealth()
		local heal = health * heal_amount
		caster:Heal(heal, self)
		caster:AddNewModifier(caster, self, "modifier_chen_hand_of_god_custom", {duration = hot_duration})
		caster:AddNewModifier(caster, self, "modifier_black_king_bar_immune", {duration = hot_duration})
		caster:AddNewModifier(caster, self, "modifier_chen_hand_of_god_custom_immunity", {duration = hot_duration})
		if caster:HasTalent("special_bonus_unique_chen_12") then
			caster:Purge(false, true, false, true, false)
		end
		caster:EmitSound("chen_chen_ability_handgod_02")
		caster:EmitSound("Hero_Chen.HandOfGodHealHero")
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_chen/chen_hand_of_god.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:ReleaseParticleIndex(particle)
	end
end

modifier_chen_hand_of_god_custom = class({})

function modifier_chen_hand_of_god_custom:IsPurgable() return true end
function modifier_chen_hand_of_god_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_chen_hand_of_god_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	}
end

function modifier_chen_hand_of_god_custom:GetModifierHealthRegenPercentage()
	if self:GetParent():HasModifier("modifier_tusk_snowball_movement") then
		return 0
	end
	return self:GetAbility():GetSpecialValueFor("heal_per_second")
end

modifier_chen_hand_of_god_custom_immunity = class({})

function modifier_chen_hand_of_god_custom_immunity:IsPurgable() return false end
function modifier_chen_hand_of_god_custom_immunity:IsPurgeException() return false end

function modifier_chen_hand_of_god_custom_immunity:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_chen_hand_of_god_custom_immunity:GetModifierMagicalResistanceBonus()
	return 80
end