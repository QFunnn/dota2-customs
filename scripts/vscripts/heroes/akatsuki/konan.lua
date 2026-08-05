--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_konan_paper_dance", "heroes/akatsuki/konan", LUA_MODIFIER_MOTION_NONE)

konan_paper_dance = class({})

function konan_paper_dance:GetIntrinsicModifierName()
	return "modifier_konan_paper_dance"
end

---------------------------------------------------------------------------

modifier_konan_paper_dance = class({})

function modifier_konan_paper_dance:IsHidden()
	return true
end
function modifier_konan_paper_dance:IsPurgable()
	return false
end
function modifier_konan_paper_dance:IsPermanent()
	return true
end

function modifier_konan_paper_dance:OnCreated()
	if not IsServer() then
		return
	end
	self:_RefreshValues()
	self:StartIntervalThink(1.0)
end

function modifier_konan_paper_dance:OnRefresh()
	if not IsServer() then
		return
	end
	self:_RefreshValues()
end

function modifier_konan_paper_dance:OnIntervalThink()
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	local new_level = math.min(math.floor((self:GetParent():GetLevel() - 1) / 6) + 1, ability:GetMaxLevel())
	if ability:GetLevel() ~= new_level then
		ability:SetLevel(new_level)
		self:_RefreshValues()
	end
end

function modifier_konan_paper_dance:_RefreshValues()
	local ab = self:GetAbility()
	self._radius = ab:GetSpecialValueFor("aura_radius")
	self._revive_chance = ab:GetSpecialValueFor("revive_chance_pct")
	self._revive_hp = ab:GetSpecialValueFor("revive_hp_pct") / 100
	self._heal_pct = ab:GetSpecialValueFor("creep_heal_pct") / 100
end

function modifier_konan_paper_dance:DeclareFunctions()
	return { MODIFIER_EVENT_ON_DEATH }
end

function modifier_konan_paper_dance:OnDeath(params)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	local unit = params.unit
	-- Воскрешение союзника
	if unit:IsRealHero() and unit ~= caster and unit:GetTeamNumber() == caster:GetTeamNumber() then
		local dist = (unit:GetAbsOrigin() - caster:GetAbsOrigin()):Length2D()
		if dist > self._radius then
			return
		end
		if not RollPercentage(self._revive_chance) then
			return
		end

		local revive_hp = self._revive_hp
		local death_pos = unit:GetAbsOrigin()
		Timers:CreateTimer(0.1, function()
			if not unit or unit:IsNull() then
				return
			end
			unit:RespawnHero(false, false)
			unit:SetAbsOrigin(death_pos)
			FindClearSpaceForUnit(unit, death_pos, true)
			unit:SetHealth(unit:GetMaxHealth() * revive_hp)

			local pfx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_omniknight/omniknight_purification.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				unit
			)
			ParticleManager:ReleaseParticleIndex(pfx)
		end)
		return
	end

	-- Лечение союзников при убийстве крипа
	if not IsMyKilledBadGuys2(caster, params) then
		return
	end

	local allies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		self._radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	if #allies == 0 then
		return
	end

	local heal_amount = unit:GetMaxHealth() * self._heal_pct / #allies

	for _, ally in ipairs(allies) do
		ally:Heal(heal_amount, caster)
		local pfx = ParticleManager:CreateParticle(
			"particles/generic_gameplay/generic_healed.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			ally
		)
		ParticleManager:ReleaseParticleIndex(pfx)
	end
end

function IsMyKilledBadGuys2(hero, params)
	if params.unit:GetTeamNumber() ~= DOTA_TEAM_NEUTRALS then
		return false
	end
	local attacker = params.attacker
	if hero ~= attacker or attacker:HasModifier("modifier_guild_event") then
		return false
	end
	if not _G.excludedUnitsLookup[params.unit:GetUnitName()] then
		return false
	end
	return true
end