--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_undying_decay_lua_buff", "heroes/hero_undying/hero_undying", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_undying_decay_lua_buff_counter", "heroes/hero_undying/hero_undying", LUA_MODIFIER_MOTION_NONE)

undying_decay_lua = class({})

function undying_decay_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_undying/undying_decay.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_undying/undying_decay_strength_xfer.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_undying/undying_decay_strength_buff.vpcf", context)
end

function undying_decay_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function undying_decay_lua:OnSpellStart()
	self:DecayCast(self:GetCursorPosition())
end

function undying_decay_lua:DecayCast(point)
	local count = 1
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("decay_damage")
	local duration = self:GetSpecialValueFor("decay_duration")

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_undying_8")
	if talent ~= nil and talent:GetLevel() > 0 then
		count = 2
	end

	local function doWave()
		local caster = self:GetCaster()
		if not caster or caster:IsNull() then
			return
		end

		caster:EmitSound("Hero_Undying.Decay.Cast")
		local decay_particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_undying/undying_decay.vpcf",
			PATTACH_WORLDORIGIN,
			caster
		)
		ParticleManager:SetParticleControl(decay_particle, 0, point)
		ParticleManager:SetParticleControl(decay_particle, 1, Vector(radius, 0, 0))
		ParticleManager:SetParticleControl(decay_particle, 2, caster:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(decay_particle)
		for _, enemy in
			pairs(
				FindUnitsInRadius(
					caster:GetTeamNumber(),
					point,
					nil,
					radius,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
			)
		do
			enemy:EmitSound("Hero_Undying.Decay.Target")
			caster:EmitSound("Hero_Undying.Decay.Transfer")
			local strength_transfer_particle = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_undying/undying_decay_strength_xfer.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				enemy
			)
			ParticleManager:SetParticleControlEnt(
				strength_transfer_particle,
				0,
				enemy,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				enemy:GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControlEnt(
				strength_transfer_particle,
				1,
				caster,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				caster:GetAbsOrigin(),
				true
			)
			ParticleManager:ReleaseParticleIndex(strength_transfer_particle)
			caster:AddNewModifier(caster, self, "modifier_undying_decay_lua_buff_counter", { duration = duration })
			caster:AddNewModifier(caster, self, "modifier_undying_decay_lua_buff", { duration = duration })
			caster:CalculateStatBonus(true)
			ApplyDamage({
				victim = enemy,
				damage = damage,
				damage_type = self:GetAbilityDamageType(),
				damage_flags = DOTA_DAMAGE_FLAG_NONE,
				attacker = caster,
				ability = self,
			})
		end
	end

	doWave()

	if count == 2 then
		Timers:CreateTimer(0.5, function()
			doWave()
		end)
	end
end

------------------------------------------------------------------------

modifier_undying_decay_lua_buff = class({})

function modifier_undying_decay_lua_buff:IsHidden()
	return true
end

function modifier_undying_decay_lua_buff:IsPurgable()
	return false
end

function modifier_undying_decay_lua_buff:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

------------------------------------------------------------------------------

modifier_undying_decay_lua_buff_counter = class({})

function modifier_undying_decay_lua_buff_counter:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	self:StartIntervalThink(FrameTime())
end

function modifier_undying_decay_lua_buff_counter:OnIntervalThink()
	local stack = self:GetParent():FindAllModifiersByName("modifier_undying_decay_lua_buff")
	local str_steal = self:GetAbility():GetSpecialValueFor("str_steal")

	self:SetStackCount(#stack * str_steal)
end

function modifier_undying_decay_lua_buff_counter:IsPurgable()
	return false
end

function modifier_undying_decay_lua_buff_counter:GetEffectName()
	return "particles/units/heroes/hero_undying/undying_decay_strength_buff.vpcf"
end

function modifier_undying_decay_lua_buff_counter:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	}
end

function modifier_undying_decay_lua_buff_counter:GetModifierBonusStats_Strength()
	return self:GetStackCount()
end

------------------------------------------------------------------------------
------------------------------------------------------------------------------

undying_soul_rip_lua = class({})

function undying_soul_rip_lua:OnAbilityPhaseStart()
	EmitSoundOn("Hero_Undying.SoulRip.Cast", self:GetCaster())
	return true
end

function undying_soul_rip_lua:OnAbilityPhaseInterrupted()
	StopSoundOn("Hero_Undying.SoulRip.Cast", self:GetCaster())
end

function undying_soul_rip_lua:OnSpellStart()
	self:OnSpellStart_target(self:GetCursorTarget())
end

function undying_soul_rip_lua:OnSpellStart_target(target)
	local radius = self:GetSpecialValueFor("radius")
	local damage_per_unit = self:GetSpecialValueFor("damage_per_unit")

	local max_units = self:GetSpecialValueFor("max_units")
	local counter = 0
	local total_damage = 0

	EmitSoundOn("Hero_Undying.SoulRip.Enemy", target)
	local pcf = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_undying/undying_soul_rip_damage.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(pcf, 0, self:GetCaster():GetOrigin())
	ParticleManager:SetParticleControl(pcf, 1, target:GetOrigin())
	ParticleManager:SetParticleControl(pcf, 2, self:GetCaster():GetOrigin())
	ParticleManager:ReleaseParticleIndex(pcf)

	local flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_REFLECTION
	local totalValue = 0
	local units = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetAbsOrigin(),
		self:GetCaster(),
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, unit in ipairs(units) do
		if maxUnits == counter then
			break
		end
		total_damage = total_damage
			+ ApplyDamage({
				victim = unit,
				attacker = self:GetCaster(),
				damage = damage_per_unit,
				damage_type = DAMAGE_TYPE_PURE,
				damage_flags = flags,
				ability = self,
			})
		counter = counter + 1
	end
	SendOverheadEventMessage(
		self:GetCaster():GetPlayerOwner(),
		OVERHEAD_ALERT_HEAL,
		self:GetCaster(),
		total_damage,
		nil
	)
	self:GetCaster()
		:HealWithParams(math.min(math.abs(total_damage), 2 ^ 30), self, false, false, self:GetCaster(), false)
	if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		ApplyDamage({
			victim = self:GetCursorTarget(),
			attacker = self:GetCaster(),
			damage = counter * damage_per_unit,
			damage_type = DAMAGE_TYPE_PURE,
			damage_flags = 0,
			ability = self,
		})
	end
end

------------------------------------------------------------------------------
------------------------------------------------------------------------------

LinkLuaModifier("modifier_undying_skin_lua", "heroes/hero_undying/hero_undying", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_undying_skin_lua_debuff", "heroes/hero_undying/hero_undying", LUA_MODIFIER_MOTION_NONE)

undying_skin_lua = class({})

function undying_skin_lua:GetIntrinsicModifierName()
	return "modifier_undying_skin_lua"
end

------------------------------------------------------------

modifier_undying_skin_lua = class({})

function modifier_undying_skin_lua:IsHidden()
	return true
end

function modifier_undying_skin_lua:IsPurgable()
	return false
end

function modifier_undying_skin_lua:OnCreated(kv)
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
end

function modifier_undying_skin_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
	return funcs
end

function modifier_undying_skin_lua:OnTakeDamage(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self:GetParent() then
		return
	end
	if self:GetParent():PassivesDisabled() then
		return
	end
	if params.attacker:GetTeamNumber() == self:GetParent():GetTeamNumber() then
		return
	end

	params.attacker:AddNewModifier(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"modifier_undying_skin_lua_debuff", -- modifier name
		{ duration = self.duration } -- kv
	)
	EmitSoundOn("hero_viper.CorrosiveSkin", params.attacker)
end

------------------------------------------------------------

modifier_undying_skin_lua_debuff = class({})

function modifier_undying_skin_lua_debuff:IsHidden()
	return false
end

function modifier_undying_skin_lua_debuff:IsDebuff()
	return true
end

function modifier_undying_skin_lua_debuff:IsStunDebuff()
	return false
end

function modifier_undying_skin_lua_debuff:IsPurgable()
	return true
end

function modifier_undying_skin_lua_debuff:OnCreated(kv)
	self.slow = -self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
	local damage = self:GetAbility():GetSpecialValueFor("damage")

	if not IsServer() then
		return
	end
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_PURE,
		ability = self:GetAbility(), --Optional.
		damage_flags = DOTA_DAMAGE_FLAG_REFLECTION, --Optional.
	}
	self:StartIntervalThink(1)
	self:OnIntervalThink() -- первый урон сразу, а не через секунду
end

function modifier_undying_skin_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_undying_skin_lua_debuff:GetModifierAttackSpeedBonus_Constant()
	return self.slow
end

function modifier_undying_skin_lua_debuff:OnIntervalThink()
	ApplyDamage(self.damageTable)
end

function modifier_undying_skin_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_viper/viper_corrosive_debuff.vpcf"
end

function modifier_undying_skin_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

------------------------------------------------------------------------------
------------------------------------------------------------------------------

LinkLuaModifier("modifier_undying_flesh_golem_lua", "heroes/hero_undying/hero_undying", LUA_MODIFIER_MOTION_NONE)

undying_flesh_golem_lua = class({})

function undying_flesh_golem_lua:OnSpellStart()
	self:GetCaster():EmitSound("Hero_Undying.FleshGolem.Cast")
	self.mod = self:GetCaster():AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_undying_flesh_golem_lua",
		{ duration = self:GetSpecialValueFor("duration") }
	)
end

----------------------------------------------------

modifier_undying_flesh_golem_lua = class({})

function modifier_undying_flesh_golem_lua:IsHidden()
	return false
end

function modifier_undying_flesh_golem_lua:IsDebuff()
	return false
end

function modifier_undying_flesh_golem_lua:IsPurgable()
	return false
end

function modifier_undying_flesh_golem_lua:IsPurgeException()
	return false
end

function modifier_undying_flesh_golem_lua:OnCreated()
	if not IsServer() then
		return
	end
	self:GetParent():StartGesture(ACT_DOTA_SPAWN)
end

function modifier_undying_flesh_golem_lua:OnRefresh()
	self:OnCreated()
end

function modifier_undying_flesh_golem_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_undying_flesh_golem_lua:GetModifierBonusStats_Strength()
	if self:GetParent().calc_str then
		return 0
	end
	self:GetParent().calc_str = true

	self.str = self:GetAbility():GetSpecialValueFor("str_percentage")

	local s = self:GetCaster():GetStrength() * self.str / 100
	self:GetParent().calc_str = false
	return s
end

function modifier_undying_flesh_golem_lua:GetModifierMoveSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("movespeed")
end

function modifier_undying_flesh_golem_lua:GetModifierTotalDamageOutgoing_Percentage()
	self.damage_increace = self:GetAbility():GetSpecialValueFor("damage_increace")

	return self.damage_increace
end

function modifier_undying_flesh_golem_lua:GetModifierModelChange()
	return "models/heroes/undying/undying_flesh_golem.vmdl"
end