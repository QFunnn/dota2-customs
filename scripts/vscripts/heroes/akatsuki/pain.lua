--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


-- Pain: аура замедления + периодический урон + метеорит при смерти

LinkLuaModifier("modifier_pain_six_paths_authority", "heroes/akatsuki/pain", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pain_aura_slow", "heroes/akatsuki/pain", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pain_full_slow", "heroes/akatsuki/pain", LUA_MODIFIER_MOTION_NONE)

pain_six_paths_authority = class({})

function pain_six_paths_authority:Precache(context)
	PrecacheResource("particle", "particles/meteor_shadow.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_invoker/invoker_chaos_meteor_fly.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_ember_spirit/ember_spirit_hit.vpcf", context)
end

function pain_six_paths_authority:GetIntrinsicModifierName()
	return "modifier_pain_six_paths_authority"
end

---------------------------------------------------------------------------

modifier_pain_six_paths_authority = class({})

function modifier_pain_six_paths_authority:IsHidden()
	return true
end
function modifier_pain_six_paths_authority:IsPurgable()
	return false
end
function modifier_pain_six_paths_authority:IsPermanent()
	return true
end

function modifier_pain_six_paths_authority:OnCreated()
	if not IsServer() then
		return
	end
	local ab = self:GetAbility()
	self._aura_radius = ab and ab:GetSpecialValueFor("aura_radius") or 500
	self._meteor_radius = ab and ab:GetSpecialValueFor("meteor_radius") or 400
	self._last_dot = -99
	self:StartIntervalThink(0.25)
end

function modifier_pain_six_paths_authority:OnRefresh()
	if not IsServer() then
		return
	end
	self:OnCreated()
end

function modifier_pain_six_paths_authority:DeclareFunctions()
	return { MODIFIER_EVENT_ON_DEATH }
end

function modifier_pain_six_paths_authority:OnDeath(data)
	if not IsServer() then
		return
	end
	if data.unit ~= self:GetParent() then
		return
	end

	local caster = data.unit
	local origin = caster:GetAbsOrigin()
	local max_hp = caster:GetMaxHealth()
	local radius = self._meteor_radius
	local team = caster:GetTeamNumber() -- сохраняем до смерти

	local DELAY = 1.3

	-- Метеорит летит сверху (как в zone_12)
	local fly_pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_invoker/invoker_chaos_meteor_fly.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(fly_pfx, 0, origin + Vector(0, 0, 1000))
	ParticleManager:SetParticleControl(fly_pfx, 1, origin)
	ParticleManager:SetParticleControl(fly_pfx, 2, Vector(DELAY, 0, 0))
	ParticleManager:ReleaseParticleIndex(fly_pfx)

	EmitSoundOnLocationWithCaster(origin, "Hero_Invoker.ChaosMeteor.Cast", caster)

	-- Удар
	Timers:CreateTimer(DELAY, function()
		local crash_pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_ember_spirit/ember_spirit_hit.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(crash_pfx, 0, origin + Vector(0, 0, 200))
		ParticleManager:ReleaseParticleIndex(crash_pfx)

		EmitSoundOnLocationWithCaster(origin, "Hero_Invoker.ChaosMeteor.Impact", caster)

		local enemies = FindUnitsInRadius(
			team,
			origin,
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		for _, enemy in ipairs(enemies) do
			ApplyDamage({
				victim = enemy,
				attacker = caster,
				damage = max_hp,
				damage_type = DAMAGE_TYPE_PURE,
			})
		end
	end)
end

function modifier_pain_six_paths_authority:OnIntervalThink()
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	if not caster or caster:IsNull() or not caster:IsAlive() then
		return
	end

	local ab = self:GetAbility()
	local new_level = math.min(math.floor((caster:GetLevel() - 1) / 6) + 1, ab:GetMaxLevel())
	if ab:GetLevel() ~= new_level then
		ab:SetLevel(new_level)
	end

	local now = GameRules:GetGameTime()
	local caster_pos = caster:GetAbsOrigin()

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster_pos,
		nil,
		self._aura_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	-- Поддерживаем замедление 25% пока в ауре
	for _, enemy in ipairs(enemies) do
		if enemy:IsAlive() then
			enemy:AddNewModifier(caster, ab, "modifier_pain_aura_slow", { duration = 0.4 })
		end
	end

	-- DoT раз в 1 сек + бриф-стоп
	if (now - self._last_dot) >= 1.0 then
		self._last_dot = now
		local dmg_pct = ab:GetSpecialValueFor("dot_damage_pct") / 100
		local dmg = caster:GetAverageTrueAttackDamage(caster) * dmg_pct
		for _, enemy in ipairs(enemies) do
			if enemy:IsAlive() then
				ApplyDamage({
					victim = enemy,
					attacker = caster,
					damage = dmg,
					damage_type = DAMAGE_TYPE_PURE,
					ability = ab,
					damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
				})
				enemy:AddNewModifier(caster, ab, "modifier_pain_full_slow", { duration = 0.2 })
			end
		end
	end
end

---------------------------------------------------------------------------

modifier_pain_aura_slow = class({})

function modifier_pain_aura_slow:IsHidden()
	return false
end
function modifier_pain_aura_slow:IsPurgable()
	return true
end

function modifier_pain_aura_slow:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_pain_aura_slow:GetModifierMoveSpeedBonus_Percentage()
	return -25
end

---------------------------------------------------------------------------

modifier_pain_full_slow = class({})

function modifier_pain_full_slow:IsHidden()
	return true
end
function modifier_pain_full_slow:IsPurgable()
	return false
end

function modifier_pain_full_slow:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_pain_full_slow:GetModifierMoveSpeedBonus_Percentage()
	return -100
end