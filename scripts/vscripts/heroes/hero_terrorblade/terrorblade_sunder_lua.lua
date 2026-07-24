--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


terrorblade_sunder_lua = class({}) ---@class terrorblade_sunder_lua : CDOTA_Ability_Lua

---@param hTarget CDOTA_BaseNPC
---@return integer
function terrorblade_sunder_lua:CastFilterResultTarget(hTarget)
	local hCaster = self:GetCaster()

	if hCaster == hTarget then
		return UF_FAIL_CUSTOM
	end

	local isEnemy = hTarget:GetTeamNumber() ~= hCaster:GetTeamNumber()

	if isEnemy and hTarget:IsDebuffImmune() then
		return UF_FAIL_MAGIC_IMMUNE_ENEMY
	end

	if isEnemy and hTarget:IsMagicImmune() then
		return UF_FAIL_MAGIC_IMMUNE_ENEMY
	end

	return UnitFilter(
		hTarget,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
		hCaster:GetTeamNumber()
	)
end

function terrorblade_sunder_lua:GetCustomCastErrorTarget(hTarget)
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end

	return ""
end

function terrorblade_sunder_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local ability = self

	if not target then return end

	if target:GetUnitName() == "npc_dota_techies_land_mine" then
		return
	end


	if not target:TriggerSpellAbsorb(self) then
		local minPct = ability:GetSpecialValueFor("hit_point_minimum_pct") / 100.0

		local ignoreMinForEnemies = ability:GetSpecialValueFor("ignore_minimum_pct_for_enemies") == 1
		local isEnemy = target:GetTeamNumber() ~= caster:GetTeamNumber()

		local minPctCaster = minPct
		local minPctTarget = (ignoreMinForEnemies and isEnemy) and 0 or minPct

		local casterPct = caster:GetHealth() / caster:GetMaxHealth()
		local targetPct = target:GetHealth() / target:GetMaxHealth()

		local newCasterPct = math.max(minPctCaster, targetPct)
		local newTargetPct = math.max(minPctTarget, casterPct)

		local newCasterHP = math.floor(caster:GetMaxHealth() * newCasterPct + 0.5)
		local newTargetHP = math.floor(target:GetMaxHealth() * newTargetPct + 0.5)

		caster:ModifyHealth(newCasterHP, ability, false, DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_DIRECTOR_EVENT)
		target:ModifyHealth(newTargetHP, ability, false, DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_DIRECTOR_EVENT)


		EmitSoundOn("Hero_Terrorblade.Sunder.Cast", caster)
		EmitSoundOn("Hero_Terrorblade.Sunder.Target", target)
		local particleName = "particles/units/heroes/hero_terrorblade/terrorblade_sunder.vpcf"

		local particle1 = ParticleManager:CreateParticle(particleName, PATTACH_ABSORIGIN_FOLLOW, target)
		ParticleManager:SetParticleControlEnt(particle1, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc",
			Vector(0, 0, 0), true)
		ParticleManager:SetParticleControlEnt(particle1, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc",
			Vector(0, 0, 0), true)
		ParticleManager:ReleaseParticleIndex(particle1)

		local particle2 = ParticleManager:CreateParticle(particleName, PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:SetParticleControlEnt(particle2, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc",
			target:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(particle2, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc",
			target:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(particle2)
	end
end