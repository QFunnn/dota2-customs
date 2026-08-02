--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local levelup_blink_common = require("abilities/levelup_blink_common")

levelup_void_spirit_astral_step = class({})

function levelup_void_spirit_astral_step:Spawn()
	if not IsServer() then
		return
	end
	if self:IsTrained() then
		return
	end
	self:SetLevel(1)
end

function levelup_void_spirit_astral_step:GetManaCost(level)
	return levelup_blink_common.GetManaCost(self, level)
end

function levelup_void_spirit_astral_step:OnSpellStart()
	local caster = self:GetCaster()
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_2_END)
	local point = self:GetCursorPosition()
	local origin = caster:GetAbsOrigin()
	local direction = point - origin
	direction.z = 0

	local distance = direction:Length2D()
	if distance <= 0.01 then
		return
	end

	local max_distance = self:GetSpecialValueFor("max_travel_distance")
	local radius = self:GetSpecialValueFor("radius")
	local attack_damage_pct = self:GetSpecialValueFor("attack_damage_pct")

	direction = direction:Normalized()
	distance = math.min(distance, max_distance)

	local target = GetGroundPosition(origin + direction * distance, caster)
	caster:SetForwardVector(direction)
	caster:FaceTowards(target)
	caster:Stop()
	GridNav:DestroyTreesAroundPoint(target, 125, true)
	FindClearSpaceForUnit(caster, target, true)

	local attack_damage = ((caster:GetLevelUpHeroHandlerModifier():GetCustomDamageBonus()) or 0)
		+ ((caster:GetLevelUpHeroHandlerModifier():GetCustomProcAttackPhysicalBonus()) or 0)
	local damage = math.floor(attack_damage * attack_damage_pct * 0.01 + 0.5)
	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		origin,
		target,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		0
	)
	local prepared_damage = health_system:BuildPreparedDamage({
		attacker = caster,
		ability = self,
		damage = damage,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		damage_kind = "physical_spell",
	})

	for _, enemy in ipairs(enemies or {}) do
		if IsValid(enemy) and enemy:IsAlive() then
			health_system:ApplyPreparedDamage(prepared_damage, enemy, "levelup_void_spirit_astral_step")
			local p = LevelUpParticleManager:CreateParticle(
				"particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_immortal_2021_astral_step_impact.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				enemy
			)
			LevelUpParticleManager:ReleaseParticleIndex(p)
		end
	end

	local p = LevelUpParticleManager:CreateParticle(
		"particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_immortal_2021_astral_step.vpcf",
		PATTACH_WORLDORIGIN,
		caster
	)
	LevelUpParticleManager:SetParticleControl(p, 0, origin)
	LevelUpParticleManager:SetParticleControl(p, 1, target)
	LevelUpParticleManager:ReleaseParticleIndex(p)

	EmitSoundOnLocationWithCaster(origin, "Hero_VoidSpirit.AstralStep.Start", caster)
	EmitSoundOnLocationWithCaster(target, "Hero_VoidSpirit.AstralStep.End", caster)

	levelup_blink_common.OnSuccessfulBlink(caster, self)
end