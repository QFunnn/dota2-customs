--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ursa_earthshock_hit_by_wave", "abilities/bosses/ursa/ursa", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)

boss_ursa_earthshock_lua = class({})

function boss_ursa_earthshock_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_ursa_earthshock_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_ursa/ursa_earthshock.vpcf", context)
end

-------------------------------------------------------

function boss_ursa_earthshock_lua:OnSpellStart()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("damage")
	local diff_boost_damage = self:GetSpecialValueFor("diff_boost_damage")
	local duration = self:GetSpecialValueFor("duration")
	local wave_max_radius = self:GetSpecialValueFor("wave_max_radius")

	caster:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	caster:EmitSound("Hero_Ursa.Earthshock")

	local shock_pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ursa/ursa_earthshock.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(shock_pfx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(shock_pfx, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(shock_pfx)

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = caster,
			damage = damage + diff_boost_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		})
	end

	local current_wave_radius = radius
	local wave_speed = 30

	Timers:CreateTimer(0.03, function()
		current_wave_radius = current_wave_radius + wave_speed
		local wave_enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			caster:GetAbsOrigin(),
			nil,
			current_wave_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_ALL,
			0,
			0,
			false
		)
		for _, enemy in pairs(wave_enemies) do
			if not enemy:HasModifier("modifier_ursa_earthshock_hit_by_wave") then
				enemy:AddNewModifier(caster, self, "modifier_stunned", { duration = duration })
				enemy:AddNewModifier(caster, self, "modifier_ursa_earthshock_hit_by_wave", { duration = 1.0 })
				local swipes_ability = caster:FindAbilityByName("boss_ursa_fury_swipes_lua")
				if swipes_ability then
					local modifier = enemy:FindModifierByNameAndCaster("modifier_ursa_fury_swipes_debuff_lua", caster)
					if modifier then
						modifier:IncrementStackCount()
					else
						enemy:AddNewModifier(
							caster,
							swipes_ability,
							"modifier_ursa_fury_swipes_debuff_lua",
							{ duration = swipes_ability:GetSpecialValueFor("bonus_reset_time") }
						)
					end
				end
			end
		end
		if current_wave_radius < wave_max_radius then
			return 0.03
		end
	end)
end

--------------------------------------------------------------------------------

modifier_ursa_earthshock_hit_by_wave = class({
	IsHidden = function()
		return true
	end,
	IsPurgable = function()
		return false
	end,
})
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

boss_ursa_fury_swipes_lua = class({})
LinkLuaModifier("modifier_boss_ursa_fury_swipes_lua", "abilities/bosses/ursa/ursa", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ursa_fury_swipes_debuff_lua", "abilities/bosses/ursa/ursa", LUA_MODIFIER_MOTION_NONE)

function boss_ursa_fury_swipes_lua:GetIntrinsicModifierName()
	return "modifier_boss_ursa_fury_swipes_lua"
end

------------------------------------------------------------------------------------------

modifier_boss_ursa_fury_swipes_lua = class({})

function modifier_boss_ursa_fury_swipes_lua:IsHidden()
	return true
end

function modifier_boss_ursa_fury_swipes_lua:IsDebuff()
	return false
end

function modifier_boss_ursa_fury_swipes_lua:IsPurgable()
	return false
end

function modifier_boss_ursa_fury_swipes_lua:OnCreated(kv)
	if IsServer() then
		self.bonus_reset_time = self:GetAbility():GetSpecialValueFor("bonus_reset_time")
		self.damage_per_stack = self:GetAbility():GetSpecialValueFor("damage_per_stack")
	end
end

function modifier_boss_ursa_fury_swipes_lua:OnRefresh(kv)
	if IsServer() then
		self.bonus_reset_time = self:GetAbility():GetSpecialValueFor("bonus_reset_time")
		self.damage_per_stack = self:GetAbility():GetSpecialValueFor("damage_per_stack")
	end
end

function modifier_boss_ursa_fury_swipes_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}

	return funcs
end

function modifier_boss_ursa_fury_swipes_lua:GetModifierProcAttack_BonusDamage_Physical(params)
	if IsServer() then
		local target = params.target
		if target == nil then
			target = params.unit
		end
		if target:GetTeamNumber() == self:GetParent():GetTeamNumber() then
			return 0
		end

		local stack = 0
		local modifier = target:FindModifierByNameAndCaster("modifier_ursa_fury_swipes_debuff_lua", nil)

		if modifier == nil then
			if not self:GetParent():PassivesDisabled() then
				local _duration = self.bonus_reset_time

				target:AddNewModifier(
					self:GetAbility():GetCaster(),
					self:GetAbility(),
					"modifier_ursa_fury_swipes_debuff_lua",
					{ duration = _duration }
				)

				stack = 1
			end
		else
			modifier:IncrementStackCount()
			modifier:ForceRefresh()

			stack = modifier:GetStackCount()
		end

		if self:GetAbility():GetCaster():IsAncient() then
			self.damage_per_stack = 3
		end

		damage = target:GetMaxHealth() / 100 * self.damage_per_stack
		return stack * damage
	end
end

----------------------------------------------------------------

modifier_ursa_fury_swipes_debuff_lua = class({})

function modifier_ursa_fury_swipes_debuff_lua:IsHidden()
	return false
end

function modifier_ursa_fury_swipes_debuff_lua:IsDebuff()
	return true
end

function modifier_ursa_fury_swipes_debuff_lua:IsPurgable()
	return false
end

function modifier_ursa_fury_swipes_debuff_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_ursa_fury_swipes_debuff_lua:OnTooltip()
	return self:GetParent():GetMaxHealth() / 100 * self.damagePerStack * self:GetStackCount()
end

function modifier_ursa_fury_swipes_debuff_lua:OnCreated(kv)
	self:SetStackCount(1)
	self.damagePerStack = self:GetAbility():GetSpecialValueFor("damage_per_stack")
end

function modifier_ursa_fury_swipes_debuff_lua:OnRefresh(kv) end

function modifier_ursa_fury_swipes_debuff_lua:GetEffectName()
	return "particles/units/heroes/hero_ursa/ursa_fury_swipes_debuff.vpcf"
end

function modifier_ursa_fury_swipes_debuff_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------

boss_ursa_roar_lua = class({})

LinkLuaModifier("modifier_boss_ursa_fear", "abilities/bosses/ursa/ursa", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ursa_enrage_lua", "abilities/bosses/ursa/ursa", LUA_MODIFIER_MOTION_NONE)

function boss_ursa_roar_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_beastmaster/beastmaster_primal_roar.vpcf", context)
end

function boss_ursa_roar_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_ursa_roar_lua:OnSpellStart()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("fear_duration")
	local damage = self:GetSpecialValueFor("leap_damage")
	local diff_boost_damage = self:GetSpecialValueFor("diff_boost_damage")
	local duration_enrage = self:GetSpecialValueFor("duration_enrage")

	caster:EmitSound("Hero_Ursa.Enrage")
	local roar_pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_beastmaster/beastmaster_primal_roar.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(roar_pfx, 1, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(roar_pfx)

	self:GetCaster():AddNewModifier(caster, self, "modifier_ursa_enrage_lua", { duration = duration_enrage })

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
		0,
		0,
		false
	)

	local furthest_enemy = nil
	local max_distance = -1

	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(caster, self, "modifier_boss_ursa_fear", { duration = duration })
		local dist = (enemy:GetAbsOrigin() - caster:GetAbsOrigin()):Length2D()
		if dist > max_distance then
			max_distance = dist
			furthest_enemy = enemy
		end
	end

	if furthest_enemy then
		local target_pos = furthest_enemy:GetAbsOrigin()
		Timers:CreateTimer(0.5, function()
			if not caster:IsAlive() or not furthest_enemy:IsAlive() then
				return
			end

			FindClearSpaceForUnit(caster, target_pos, true)

			caster:StartGesture(ACT_DOTA_ATTACK)
			caster:EmitSound("Hero_Ursa.Attack")

			ApplyDamage({
				victim = furthest_enemy,
				attacker = caster,
				damage = damage + diff_boost_damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				ability = self,
			})

			local hit_pfx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_ursa/ursa_fury_swipes.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				furthest_enemy
			)
			ParticleManager:ReleaseParticleIndex(hit_pfx)
		end)
	end
end

--------------------------------------------------------------------------------

modifier_ursa_enrage_lua = class({})

function modifier_ursa_enrage_lua:IsHidden()
	return false
end

function modifier_ursa_enrage_lua:IsDebuff()
	return false
end

function modifier_ursa_enrage_lua:IsPurgable()
	return false
end

function modifier_ursa_enrage_lua:OnCreated(kv)
	self.damage_reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
end

function modifier_ursa_enrage_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_MODEL_SCALE,
	}
	return funcs
end

function modifier_ursa_enrage_lua:GetModifierIncomingDamage_Percentage(params)
	return -self.damage_reduction
end

function modifier_ursa_enrage_lua:GetModifierModelScale(params)
	return 30
end

function modifier_ursa_enrage_lua:GetEffectName()
	return "particles/units/heroes/hero_ursa/ursa_enrage_buff.vpcf"
end

function modifier_ursa_enrage_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------

modifier_boss_ursa_fear = class({})

function modifier_boss_ursa_fear:OnCreated()
	if IsServer() then
		local caster = self:GetCaster()
		local parent = self:GetParent()
		local direction = (parent:GetAbsOrigin() - caster:GetAbsOrigin()):Normalized()
		local run_to = parent:GetAbsOrigin() + direction * 1000
		parent:MoveToPosition(run_to)
	end
end

function modifier_boss_ursa_fear:CheckState()
	return {
		[MODIFIER_STATE_FEARED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end

function modifier_boss_ursa_fear:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_boss_ursa_fear:GetModifierMoveSpeedBonus_Percentage()
	return -self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_boss_ursa_fear:GetStatusEffectName()
	return "particles/status_fx/status_effect_night_stalker_crippling_fear.vpcf"
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

boss_ursa_overpower_lua = class({})

LinkLuaModifier("modifier_boss_ursa_overpower", "abilities/bosses/ursa/ursa", LUA_MODIFIER_MOTION_NONE)

function boss_ursa_roar_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_ursa/ursa_overpower_buff.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave.vpcf",
		context
	)
end

function boss_ursa_overpower_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	caster:EmitSound("Hero_Ursa.Overpower")
	caster:AddNewModifier(caster, self, "modifier_boss_ursa_overpower", { duration = duration })
end

--------------------------------------------------------------------------------

modifier_boss_ursa_overpower = class({})

function modifier_boss_ursa_overpower:OnCreated()
	self.attacks_number = self:GetAbility():GetSpecialValueFor("max_attacks")
	self.attack_speed = self:GetAbility():GetSpecialValueFor("attack_speed_bonus")
	self.cleave_pct = 100

	if IsServer() then
		self:SetStackCount(self.attacks_number)
		self:AddEffects()
	end
end

function modifier_boss_ursa_overpower:OnDestroy(kv)
	if IsServer() then
		self:RemoveEffects()
	end
end

function modifier_boss_ursa_overpower:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	}
end

function modifier_boss_ursa_overpower:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed
end

function modifier_boss_ursa_overpower:GetModifierStatusResistanceStacking()
	return 100
end

function modifier_boss_ursa_overpower:OnAttackLanded(params)
	if IsServer() then
		if params.attacker == self:GetParent() and (not self:GetParent():IsIllusion()) then
			local target = params.target
			if target ~= nil and target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
				if self:GetStackCount() == 3 then
					DoCleaveAttack(
						params.attacker,
						target,
						self:GetAbility(),
						params.damage,
						150,
						360,
						400,
						"particles/units/heroes/hero_sven/sven_spell_great_cleave.vpcf"
					)
				end
			end
		end

		self:DecrementStackCount()
		if self:GetStackCount() <= 0 then
			self:Destroy()
		end
	end
end

function modifier_boss_ursa_overpower:AddEffects()
	local particle_buff = "particles/units/heroes/hero_ursa/ursa_overpower_buff.vpcf"
	self.effect_cast = ParticleManager:CreateParticle(particle_buff, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_head",
		self:GetParent():GetOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		3,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetOrigin(),
		true
	)
	self:AddParticle(self.effect_cast, false, false, -1, false, false)
end

function modifier_boss_ursa_overpower:RemoveEffects()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
end