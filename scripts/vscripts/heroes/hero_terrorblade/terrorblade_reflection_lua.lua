--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


terrorblade_reflection_lua = class({})
LinkLuaModifier("modifier_terrorblade_reflection_creep_damage_lua", "heroes/hero_terrorblade/terrorblade_reflection_lua", LUA_MODIFIER_MOTION_NONE)

-- Диагностические принты управляются глобальным REFLECTION_DEBUG_ENABLED из constants/main.lua.
-- В проде false -- проверка `if REFLECTION_DEBUG_ENABLED then` оборачивает каждый print-сайт,
-- аргументы (string concat / GetUnitName / etc) не вычисляются.

function terrorblade_reflection_lua:GetAOERadius()
	return self:GetSpecialValueFor("range")
end

function terrorblade_reflection_lua:OnSpellStart()
	if not IsServer() then return end

	local caster = self:GetCaster()
	local ability_level = self:GetLevel() - 1
	local target_loc = self:GetCursorPosition()

	local illusion_duration = self:GetSpecialValueFor("illusion_duration")
	local range = self:GetSpecialValueFor("range")
	local illusion_outgoing_damage = self:GetLevelSpecialValueFor("illusion_outgoing_damage", ability_level)
	-- max_creep_affect -- ОБЩИЙ лимит целей способности (исторически назван _creep, но
	-- считаем и героев тоже). Талантов на это значение в текущей KV нет, GetSpecialValueFor
	-- просто вернёт фиксированное число из AbilityValues.
	local max_targets = self:GetSpecialValueFor("max_creep_affect")
	self.affected_targets_counter = 0

	local enemies = FindUnitsInRadius(caster:GetTeam(), target_loc, nil, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO, FIND_ANY_ORDER, false)
	for i, enemy in pairs(enemies) do

		if enemy and not enemy:IsNull() and enemy:IsAlive() and Players:IsUnitCanAttackOrCastOnThis(caster, enemy)
			and self.affected_targets_counter < max_targets then

			local modifier_apply_flag = false		-- checks if particles and slow modifier should be applied to this enemy
			local reflection = nil				-- referenced from slow modifier so it gets removed on dispel
			-- reflect the hero
			-- always spawn hero illusions
			if enemy:IsRealHero() then
				local reflection_loc = enemy:GetAbsOrigin() + RandomVector(200)
				local illusions = CreateIllusions(caster, enemy, {}, 1, enemy:GetHullRadius(), false, true)
				reflection = illusions[1]
				reflection:AddNewModifier( caster, self, "modifier_terrorblade_reflection_invulnerability", { duration = illusion_duration } )
				FindClearSpaceForUnit(reflection, reflection_loc, true)
				reflection:AddNewModifier( caster, self, "modifier_illusion", { duration = illusion_duration, outgoing_damage = illusion_outgoing_damage, incoming_damage = 0 } )
				-- Зелёный урон цели передаётся иллюзии частично (hero_green_damage_pct из KV,
				-- сейчас 50%). Иллюзия не должна бить как сам герой со всем билдом, но и
				-- полностью игнорировать билд цели тоже несбалансированно. К крипам
				-- применяется такой же коэффициент (см. OnIntervalThink модификатора ниже).
				local enemy_avg_true = enemy:GetAverageTrueAttackDamage(nil)
				local enemy_base_avg = (enemy:GetBaseDamageMin() + enemy:GetBaseDamageMax()) / 2
				local raw_bonus = enemy_avg_true - enemy_base_avg
				local hero_green_pct = self:GetSpecialValueFor("hero_green_damage_pct") or 50
				local bonus_damage = raw_bonus * hero_green_pct / 100
				if REFLECTION_DEBUG_ENABLED then
					print("[Reflection DEBUG] HERO target:", enemy:GetUnitName(),
						"avg_true =", enemy_avg_true,
						"base_avg =", enemy_base_avg,
						"raw_bonus =", raw_bonus,
						"pct =", hero_green_pct,
						"applied_bonus =", bonus_damage,
						"refl_base_before =", reflection:GetBaseDamageMin(), "/", reflection:GetBaseDamageMax())
				end
				if bonus_damage > 0 then
					reflection:SetBaseDamageMin(reflection:GetBaseDamageMin() + bonus_damage)
					reflection:SetBaseDamageMax(reflection:GetBaseDamageMax() + bonus_damage)
					if REFLECTION_DEBUG_ENABLED then
						print("[Reflection DEBUG] HERO refl_base_after =", reflection:GetBaseDamageMin(), "/", reflection:GetBaseDamageMax())
					end
				end
				reflection:SetForceAttackTarget(enemy)
				modifier_apply_flag = true

			else	-- just damage over time the creeps for performance reasons
				-- Общий лимит уже проверен в условии цикла, отдельный счётчик не нужен.
				enemy:AddNewModifier( caster, self, "modifier_terrorblade_reflection_creep_damage_lua", { duration = illusion_duration } )
				modifier_apply_flag = true
			end

			if modifier_apply_flag then
				self.affected_targets_counter = self.affected_targets_counter + 1

				-- Нативный slow-модификатор (с правильной иконкой и radial-таймером).
				-- Он dispellable из ванильной KV.
				enemy:AddNewModifier( caster, self, "modifier_terrorblade_reflection_slow", { duration = illusion_duration } )

				-- Watchdog для иллюзии-отражения: тикает каждые 0.1 сек и проверяет, висит
				-- ли ещё на жертве нативный slow. Если slow пропал (диспел / истечение
				-- duration) -- удаляем иллюзию и завершаем think. Этот подход вместо
				-- дополнительного скрытого Lua-модификатора (тот всё равно отображался в
				-- debuff-баре, несмотря на IsHidden=true).
				if reflection and not reflection:IsNull() then
					local refl_ref = reflection -- локальная ссылка для closure
					enemy:SetContextThink(DoUniqueString("ReflectionDispelWatchdog"), function()
						-- Если жертва или иллюзия уже невалидны -- ничего не делаем, выходим
						if not enemy or enemy:IsNull() or not refl_ref or refl_ref:IsNull() then
							return nil
						end
						-- Slow ещё висит -> продолжаем следить
						if enemy:HasModifier("modifier_terrorblade_reflection_slow") then
							return 0.1
						end
						-- Slow пропал (диспел или истечение) -> удаляем иллюзию, завершаем think
						UTIL_Remove(refl_ref)
						return nil
					end, 0.1)
				end

				-- particles
				local particle_cast = "particles/units/heroes/hero_terrorblade/terrorblade_reflection_cast.vpcf"
				local particle_fx = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, caster )
				ParticleManager:SetParticleControl(particle_fx, 3, Vector(1,0,0))
				ParticleManager:SetParticleControlEnt(particle_fx, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
				ParticleManager:SetParticleControlEnt(particle_fx, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
				ParticleManager:ReleaseParticleIndex(particle_fx)
			end

		end
	end

	EmitSoundOn("Hero_Terrorblade.Reflection", caster)

end

modifier_terrorblade_reflection_creep_damage_lua = class({})
function modifier_terrorblade_reflection_creep_damage_lua:IsHidden() return true end
function modifier_terrorblade_reflection_creep_damage_lua:IsDebuff() return true end
-- Dispellable как и slow-модификатор: при использовании Lotus Orb, Manta Style и пр.
-- эффект Reflection полностью снимается, а не только slow (соответствует ванильной
-- Dota и описанию способности).
function modifier_terrorblade_reflection_creep_damage_lua:IsPurgable() return true end
function modifier_terrorblade_reflection_creep_damage_lua:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

if not IsServer() then return end

function modifier_terrorblade_reflection_creep_damage_lua:OnCreated(keys)
	local parent = self:GetParent()
	local bat = GetUnitBaseAttackTime(parent)
	bat = math.max(bat,0.28)
	self:StartIntervalThink(bat)
	if REFLECTION_DEBUG_ENABLED then
		print("[Reflection DEBUG] CREEP OnCreated:", parent:GetUnitName(),
			"bat =", bat,
			"base_min/max =", parent:GetBaseDamageMin(), "/", parent:GetBaseDamageMax(),
			"avg_true =", parent:GetAverageTrueAttackDamage(nil))
	end
end

function modifier_terrorblade_reflection_creep_damage_lua:OnIntervalThink()
	local caster = self:GetCaster()
	local parent = self:GetParent()
	local ability = self:GetAbility()

	if not caster or caster:IsNull() then return end
	if not parent or parent:IsNull() then return end
	if not ability or ability:IsNull() then return end

	local ability_level = ability:GetLevel() - 1
	local illusion_outgoing_tooltip = ability:GetLevelSpecialValueFor("illusion_outgoing_tooltip", ability_level)

	-- Считаем зелёный (бонусный) урон с тем же коэффициентом что и для героев (hero_green_damage_pct из KV, по умолчанию 50%).
	-- Раньше для крипов использовался полный GetAverageTrueAttackDamage = база + 100% бонуса -- это давало
	-- крипам слишком много урона. Теперь: effective = base_avg + raw_bonus * hero_green_pct/100.
	local avg_true = parent:GetAverageTrueAttackDamage(nil)
	local base_avg = (parent:GetBaseDamageMin() + parent:GetBaseDamageMax()) / 2
	local raw_bonus = avg_true - base_avg
	local hero_green_pct = ability:GetSpecialValueFor("hero_green_damage_pct") or 50
	local effective_damage = base_avg + raw_bonus * hero_green_pct / 100
	local final_damage = effective_damage * illusion_outgoing_tooltip / 100

	if REFLECTION_DEBUG_ENABLED then
		print("[Reflection DEBUG] CREEP tick:", parent:GetUnitName(),
			"avg_true =", avg_true,
			"base_avg =", base_avg,
			"raw_bonus =", raw_bonus,
			"green_pct =", hero_green_pct,
			"effective =", effective_damage,
			"outgoing% =", illusion_outgoing_tooltip,
			"final =", final_damage)
	end
	ApplyDamage({
		attacker = caster,
		victim = parent,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		damage = final_damage,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
	})
end