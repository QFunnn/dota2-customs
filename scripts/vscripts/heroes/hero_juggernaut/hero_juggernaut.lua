--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


require("rules")
rules:SafeCall(function()
	LinkLuaModifier(
		"modifier_juggernaut_blade_fury_lua",
		"heroes/hero_juggernaut/hero_juggernaut",
		LUA_MODIFIER_MOTION_NONE
	)

	juggernaut_blade_fury_lua = class({})

	function juggernaut_blade_fury_lua:OnOwnerSpawned()
		self:SetActivated(true)
	end

	function juggernaut_blade_fury_lua:OnSpellStart()
		local caster = self:GetCaster()
		caster:Purge(false, true, false, false, false)

		local duration = self:GetSpecialValueFor("duration")
		caster:AddNewModifier(caster, self, "modifier_juggernaut_blade_fury_lua", { duration = duration })
	end

	--------------------------------------------------------------------------------

	modifier_juggernaut_blade_fury_lua = class({})

	function modifier_juggernaut_blade_fury_lua:IsHidden()
		return false
	end
	function modifier_juggernaut_blade_fury_lua:IsPurgable()
		return false
	end

	function modifier_juggernaut_blade_fury_lua:OnCreated(kv)
		self.tick = self:GetAbility():GetSpecialValueFor("blade_fury_damage_tick")
		self.radius = self:GetAbility():GetSpecialValueFor("blade_fury_radius")
		self.dps = self:GetAbility():GetSpecialValueFor("blade_fury_damage")

		if IsServer() then
			local parent = self:GetParent()
			local caster = self:GetCaster()
			local omni = parent:FindAbilityByName("juggernaut_omni_slash_lua")

			self.can_use = false
			local talent = caster:FindAbilityByName("special_bonus_unique_juggernaut_7")
			if talent and talent:GetLevel() > 0 then
				self.can_use = true
			end

			if omni then
				omni:SetActivated(self.can_use)
			end

			self.damageTable = {
				attacker = parent,
				damage = self.dps * self.tick,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self:GetAbility(),
			}

			self:StartIntervalThink(self.tick)
			self:PlayEffects()
		end
	end

	function modifier_juggernaut_blade_fury_lua:OnRefresh(kv)
		self.tick = self:GetAbility():GetSpecialValueFor("blade_fury_damage_tick")
		self.radius = self:GetAbility():GetSpecialValueFor("blade_fury_radius")
		self.dps = self:GetAbility():GetSpecialValueFor("blade_fury_damage")
		if IsServer() then
			self.damageTable.damage = self.dps * self.tick
		end
	end

	function modifier_juggernaut_blade_fury_lua:OnDestroy()
		if IsServer() then
			local parent = self:GetParent()
			local omni = parent:FindAbilityByName("juggernaut_omni_slash_lua")

			if omni then
				omni:SetActivated(true)
			end

			StopSoundOn("Hero_Juggernaut.BladeFuryStart", parent)
		end
	end

	function modifier_juggernaut_blade_fury_lua:CheckState()
		return { [MODIFIER_STATE_MAGIC_IMMUNE] = true }
	end

	function modifier_juggernaut_blade_fury_lua:OnIntervalThink()
		local parent = self:GetParent()
		local enemies = FindUnitsInRadius(
			parent:GetTeamNumber(),
			parent:GetOrigin(),
			parent,
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			0,
			false
		)

		for _, enemy in pairs(enemies) do
			self.damageTable.victim = enemy
			ApplyDamage(self.damageTable)
			self:PlayEffects2(enemy)
		end
	end

	function modifier_juggernaut_blade_fury_lua:PlayEffects()
		local parent = self:GetParent()
		local effect_cast = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_juggernaut/juggernaut_blade_fury.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			parent
		)
		ParticleManager:SetParticleControl(effect_cast, 5, Vector(self.radius, 0, 0))
		self:AddParticle(effect_cast, false, false, -1, false, false)
		EmitSoundOn("Hero_Juggernaut.BladeFuryStart", parent)
	end

	function modifier_juggernaut_blade_fury_lua:PlayEffects2(target)
		local effect_cast = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_juggernaut/juggernaut_blade_fury_tgt.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			target
		)
		ParticleManager:ReleaseParticleIndex(effect_cast)
	end

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------

	LinkLuaModifier(
		"modifier_juggernaut_healing_ward_thinker_lua",
		"heroes/hero_juggernaut/hero_juggernaut",
		LUA_MODIFIER_MOTION_NONE
	)
	LinkLuaModifier(
		"modifier_juggernaut_healing_ward_aura_buff_lua",
		"heroes/hero_juggernaut/hero_juggernaut",
		LUA_MODIFIER_MOTION_NONE
	)

	juggernaut_heling_ward_lua = class({})

	function juggernaut_heling_ward_lua:OnSpellStart()
		local caster = self:GetCaster()
		local duration = self:GetSpecialValueFor("duration")

		caster:EmitSound("Hero_Juggernaut.HealingWard.Cast")

		local ward = CreateUnitByName(
			"npc_dota_juggernaut_healing_ward",
			caster:GetAbsOrigin(),
			false,
			caster,
			caster,
			caster:GetTeamNumber()
		)

		ward:AddNewModifier(caster, self, "modifier_juggernaut_healing_ward_thinker_lua", { duration = duration })
		ward:AddNewModifier(caster, self, "modifier_kill", { duration = duration })
	end

	--------------------------------------------------------------------------------

	modifier_juggernaut_healing_ward_thinker_lua = class({})

	function modifier_juggernaut_healing_ward_thinker_lua:IsHidden()
		return true
	end

	function modifier_juggernaut_healing_ward_thinker_lua:IsPurgable()
		return false
	end

	function modifier_juggernaut_healing_ward_thinker_lua:OnCreated()
		if not IsServer() then
			return
		end
		local parent = self:GetParent()
		local caster = self:GetCaster()

		self.pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_juggernaut/juggernaut_healing_ward.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			parent
		)
		ParticleManager:SetParticleControl(self.pfx, 1, Vector(self:GetAbility():GetSpecialValueFor("radius"), 1, 1))

		EmitSoundOn("Hero_Juggernaut.HealingWard.Loop", parent)
		self:StartIntervalThink(FrameTime())
	end

	function modifier_juggernaut_healing_ward_thinker_lua:OnIntervalThink()
		local caster = self:GetCaster()
		local parent = self:GetParent()

		if not caster or not caster:IsAlive() then
			parent:Kill(nil, nil)
			return
		end
		parent:MoveToNPC(caster)
	end

	function modifier_juggernaut_healing_ward_thinker_lua:CheckState()
		return {
			[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
			[MODIFIER_STATE_UNSELECTABLE] = true,
			[MODIFIER_STATE_UNTARGETABLE] = true,
			[MODIFIER_STATE_INVULNERABLE] = true,
			[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
			[MODIFIER_STATE_NO_HEALTH_BAR] = true,
			[MODIFIER_STATE_OUT_OF_GAME] = true,
		}
	end

	--------------------------------------------------------------------------------

	function modifier_juggernaut_healing_ward_thinker_lua:IsAura()
		return true
	end
	function modifier_juggernaut_healing_ward_thinker_lua:GetModifierAura()
		return "modifier_juggernaut_healing_ward_aura_buff_lua"
	end
	function modifier_juggernaut_healing_ward_thinker_lua:GetAuraRadius()
		return self:GetAbility():GetSpecialValueFor("radius")
	end
	function modifier_juggernaut_healing_ward_thinker_lua:GetAuraSearchTeam()
		return DOTA_UNIT_TARGET_TEAM_FRIENDLY
	end
	function modifier_juggernaut_healing_ward_thinker_lua:GetAuraSearchType()
		return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	end

	function modifier_juggernaut_healing_ward_thinker_lua:OnDestroy()
		if not IsServer() then
			return
		end
		StopSoundOn("Hero_Juggernaut.HealingWard.Loop", self:GetParent())
		if self.pfx then
			ParticleManager:DestroyParticle(self.pfx, false)
			ParticleManager:ReleaseParticleIndex(self.pfx)
		end
	end

	--------------------------------------------------------------------------------

	modifier_juggernaut_healing_ward_aura_buff_lua = class({})

	function modifier_juggernaut_healing_ward_aura_buff_lua:DeclareFunctions()
		return { MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE }
	end

	function modifier_juggernaut_healing_ward_aura_buff_lua:GetModifierHealthRegenPercentage()
		return self:GetAbility():GetSpecialValueFor("health")
	end

	function modifier_juggernaut_healing_ward_aura_buff_lua:GetEffectName()
		return "particles/units/heroes/hero_juggernaut/juggernaut_ward_heal.vpcf"
	end

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------

	LinkLuaModifier(
		"modifier_juggernaut_blade_dance_lua",
		"heroes/hero_juggernaut/hero_juggernaut",
		LUA_MODIFIER_MOTION_NONE
	)

	juggernaut_blade_dance_lua = class({})

	function juggernaut_blade_dance_lua:GetIntrinsicModifierName()
		return "modifier_juggernaut_blade_dance_lua"
	end

	--------------------------------------------------------------------------------

	modifier_juggernaut_blade_dance_lua = class({})

	function modifier_juggernaut_blade_dance_lua:IsHidden()
		return true
	end

	function modifier_juggernaut_blade_dance_lua:IsPurgable()
		return false
	end

	function modifier_juggernaut_blade_dance_lua:DeclareFunctions()
		return {
			MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
			MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		}
	end

	function modifier_juggernaut_blade_dance_lua:GetModifierPreAttack_CriticalStrike(params)
		if not IsServer() or self:GetParent():PassivesDisabled() then
			return
		end

		if params.target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
			local ability = self:GetAbility()

			if RollPercentage(ability:GetSpecialValueFor("blade_dance_crit_chance")) then
				self.record = params.record
				return ability:GetSpecialValueFor("blade_dance_crit_mult")
			end
		end
	end

	function modifier_juggernaut_blade_dance_lua:GetModifierProcAttack_Feedback(params)
		if IsServer() and self.record and self.record == params.record then
			self.record = nil
			EmitSoundOn("Hero_Juggernaut.BladeDance", params.target)
		end
	end

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------

	LinkLuaModifier(
		"modifier_juggernaut_omni_slash_lua_caster",
		"heroes/hero_juggernaut/hero_juggernaut",
		LUA_MODIFIER_MOTION_NONE
	)

	juggernaut_omni_slash_lua = class({})

	function juggernaut_omni_slash_lua:OnOwnerSpawned()
		self:SetActivated(true)
	end

	function juggernaut_omni_slash_lua:IsHiddenWhenStolen()
		return false
	end

	function juggernaut_omni_slash_lua:GetCooldown(level)
		local caster = self:GetCaster()
		local talent = caster:FindAbilityByName("special_bonus_unique_juggernaut_6")
		if talent and talent:GetLevel() > 0 then
			return self.BaseClass.GetCooldown(self, level) - 30
		end
		return self.BaseClass.GetCooldown(self, level)
	end

	function juggernaut_omni_slash_lua:OnAbilityPhaseStart()
		local caster = self:GetCaster()
		if caster:GetName() == "npc_dota_hero_juggernaut" then
			caster:EmitSound("juggernaut_jug_ability_omnislash_0" .. math.random(3))
		end
		return true
	end

	function juggernaut_omni_slash_lua:OnSpellStart()
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local duration = self:GetSpecialValueFor("duration")
		local prev_pos = caster:GetAbsOrigin()

		-- if target:TriggerSpellAbsorb(self) then return end

		caster:Purge(false, true, false, false, false)
		local modifier =
			caster:AddNewModifier(caster, self, "modifier_juggernaut_omni_slash_lua_caster", { duration = duration })
		if modifier then
			modifier.original_caster = caster
		end

		-- self:SetActivated(false)

		self.can_use = false

		local talent = caster:FindAbilityByName("special_bonus_unique_juggernaut_7")
		if talent and talent:GetLevel() > 0 then
			self.can_use = true
		end

		local fury = caster:FindAbilityByName("juggernaut_blade_fury_lua")
		if fury then
			fury:SetActivated(self.can_use)
		end

		FindClearSpaceForUnit(caster, target:GetAbsOrigin() + RandomVector(128), false)
		caster:EmitSound("Hero_Juggernaut.OmniSlash")

		local trail_pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf",
			PATTACH_ABSORIGIN,
			caster
		)
		ParticleManager:SetParticleControl(trail_pfx, 0, prev_pos)
		ParticleManager:SetParticleControl(trail_pfx, 1, caster:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(trail_pfx)
	end

	--------------------------------------------------------------------------------

	modifier_juggernaut_omni_slash_lua_caster = class({})

	function modifier_juggernaut_omni_slash_lua_caster:IsHidden()
		return false
	end
	function modifier_juggernaut_omni_slash_lua_caster:IsPurgable()
		return false
	end

	function modifier_juggernaut_omni_slash_lua_caster:OnCreated()
		if not IsServer() then
			return
		end
		self.parent = self:GetParent()
		self.ability = self:GetAbility()
		self.radius = self.ability:GetSpecialValueFor("radius")
		self.slash_rate = self.ability:GetSpecialValueFor("bounce_delay")

		self:Bounce(true)
		self:StartIntervalThink(self.slash_rate)
	end

	function modifier_juggernaut_omni_slash_lua_caster:OnIntervalThink()
		self:Bounce(false)
	end

	function modifier_juggernaut_omni_slash_lua_caster:Bounce(bFirst)
		local order = bFirst and FIND_CLOSEST or FIND_ANY_ORDER
		local enemies = FindUnitsInRadius(
			self.parent:GetTeamNumber(),
			self.parent:GetAbsOrigin(),
			self.parent,
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
				+ DOTA_UNIT_TARGET_FLAG_NO_INVIS
				+ DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE
				+ DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
			order,
			false
		)

		local target = nil
		for _, enemy in pairs(enemies) do
			local name = enemy:GetName()
			if name ~= "npc_dota_unit_undying_zombie" and name ~= "npc_dota_elder_titan_ancestral_spirit" then
				target = enemy
				break
			end
		end

		if target then
			local prev_pos = self.parent:GetAbsOrigin()
			FindClearSpaceForUnit(self.parent, target:GetAbsOrigin() + RandomVector(100), false)
			local curr_pos = self.parent:GetAbsOrigin()

			self.parent:FaceTowards(target:GetAbsOrigin())
			AddFOWViewer(self.parent:GetTeamNumber(), target:GetAbsOrigin(), 200, 1, false)

			-- if bFirst and target:TriggerSpellAbsorb(self.ability) then
			--     self:Destroy()
			--     return
			-- end

			self.parent:PerformAttack(target, true, true, true, true, true, false, false)
			target:EmitSound("Hero_Juggernaut.OmniSlash.Damage")

			local hPfx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_tgt.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				target
			)
			ParticleManager:SetParticleControl(hPfx, 0, curr_pos)
			ParticleManager:ReleaseParticleIndex(hPfx)

			local tPfx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf",
				PATTACH_ABSORIGIN,
				self.parent
			)
			ParticleManager:SetParticleControl(tPfx, 0, prev_pos)
			ParticleManager:SetParticleControl(tPfx, 1, curr_pos)
			ParticleManager:ReleaseParticleIndex(tPfx)
		else
			self:Destroy()
		end
	end

	function modifier_juggernaut_omni_slash_lua_caster:CheckState()
		return {
			[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
			[MODIFIER_STATE_INVULNERABLE] = true,
			[MODIFIER_STATE_NO_HEALTH_BAR] = true,
			[MODIFIER_STATE_MAGIC_IMMUNE] = true,
			[MODIFIER_STATE_DISARMED] = true,
			[MODIFIER_STATE_ROOTED] = true,
		}
	end

	function modifier_juggernaut_omni_slash_lua_caster:DeclareFunctions()
		return { MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE, MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
	end

	function modifier_juggernaut_omni_slash_lua_caster:GetModifierPreAttack_BonusDamage()
		return self:GetAbility():GetSpecialValueFor("bonus_damage")
	end

	function modifier_juggernaut_omni_slash_lua_caster:GetOverrideAnimation()
		return ACT_DOTA_OVERRIDE_ABILITY_4
	end

	function modifier_juggernaut_omni_slash_lua_caster:OnDestroy()
		if not IsServer() then
			return
		end
		local parent = self:GetParent()
		if not parent or parent:IsNull() then
			return
		end

		local omni = self:GetAbility()

		if omni and not omni:IsNull() then
			omni:SetActivated(true)
		end

		local fury = parent:FindAbilityByName("juggernaut_blade_fury_lua")
		if fury then
			fury:SetActivated(true)
		end

		parent:FadeGesture(ACT_DOTA_OVERRIDE_ABILITY_4)

		local current_pos = parent:GetAbsOrigin()
		parent:MoveToPosition(current_pos)
	end

	function modifier_juggernaut_omni_slash_lua_caster:GetStatusEffectName()
		return "particles/status_fx/status_effect_omnislash.vpcf"
	end
end)