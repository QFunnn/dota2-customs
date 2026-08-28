--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lycan_double_hit_sabre", "heroes/hero_lycan/hero_lycan", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lycan_double_hit_haste", "heroes/hero_lycan/hero_lycan", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lycan_double_hit_slow", "heroes/hero_lycan/hero_lycan", LUA_MODIFIER_MOTION_NONE)

lycan_double_hit = class({})

function lycan_double_hit:GetIntrinsicModifierName()
	return "modifier_lycan_double_hit_sabre"
end

--------------------------------------------------------------------

modifier_lycan_double_hit_sabre = class({})

function modifier_lycan_double_hit_sabre:IsPurgable()
	return false
end
function modifier_lycan_double_hit_sabre:RemoveOnDeath()
	return false
end
function modifier_lycan_double_hit_sabre:IsHidden()
	return true
end

function modifier_lycan_double_hit_sabre:OnCreated()
	self.attack_count = 0
	self.skip_next = false
end

function modifier_lycan_double_hit_sabre:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_lycan_double_hit_sabre:OnAttackLanded(keys)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if keys.attacker ~= parent or not self:GetAbility() then
		return
	end
	if parent:IsIllusion() or parent:PassivesDisabled() then
		return
	end
	if not keys.target or keys.target:IsNull() then
		return
	end

	keys.target:AddNewModifier(
		parent,
		self:GetAbility(),
		"modifier_lycan_double_hit_slow",
		{ duration = self:GetAbility():GetSpecialValueFor("duration") }
	)

	if parent:IsRangedAttacker() then
		return
	end

	-- быстрый добивающий удар не считаем в счётчике
	if self.skip_next then
		self.skip_next = false
		return
	end

	self.attack_count = (self.attack_count or 0) + 1
	local hits = self:GetAbility():GetSpecialValueFor("hits")
	if self.attack_count < hits then
		return
	end
	self.attack_count = 0

	-- всплеск скорости атаки -> быстрый второй удар
	self.skip_next = true
	parent:AddNewModifier(parent, self:GetAbility(), "modifier_lycan_double_hit_haste", {})

	local abil = parent:FindAbilityByName("special_bonus_unique_lycan_7")
	if abil ~= nil and abil:GetLevel() > 0 then
		DoCleaveAttack(
			parent,
			keys.target,
			self:GetAbility(),
			keys.original_damage,
			150,
			360,
			360,
			"particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave.vpcf"
		)
	end
end

--------------------------------------------------------------------

modifier_lycan_double_hit_haste = class({})

function modifier_lycan_double_hit_haste:IsDebuff()
	return false
end
function modifier_lycan_double_hit_haste:IsHidden()
	return true
end
function modifier_lycan_double_hit_haste:IsPurgable()
	return false
end
function modifier_lycan_double_hit_haste:RemoveOnDeath()
	return true
end

function modifier_lycan_double_hit_haste:OnCreated()
	self:SetStackCount(2)
	self.attack_speed_buff = math.max(500, self:GetParent():GetIncreasedAttackSpeed(true) * 2)
end

function modifier_lycan_double_hit_haste:OnRefresh()
	self:OnCreated()
end

function modifier_lycan_double_hit_haste:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK,
	}
end

function modifier_lycan_double_hit_haste:OnAttack(keys)
	if keys.attacker ~= self:GetParent() then
		return
	end
	self:SetStackCount(self:GetStackCount() - 1)
	if self:GetStackCount() <= 1 then
		self:Destroy()
	end
end

function modifier_lycan_double_hit_haste:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed_buff or 0
end

--------------------------------------------------------------------

modifier_lycan_double_hit_slow = class({})

function modifier_lycan_double_hit_slow:IsPurgable()
	return false
end
function modifier_lycan_double_hit_slow:RemoveOnDeath()
	return false
end
function modifier_lycan_double_hit_slow:IsHidden()
	return true
end

function modifier_lycan_double_hit_slow:OnCreated() end

function modifier_lycan_double_hit_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_lycan_double_hit_slow:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("slow") * -1
end

function modifier_lycan_double_hit_slow:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("slow_as") * -1
end

--------------------------------------------------------------------
--------------------------------------------------------------------

LinkLuaModifier("modifier_lycan_howl_lua_buff", "heroes/hero_lycan/hero_lycan", LUA_MODIFIER_MOTION_NONE)

lycan_howl_lua = class({})

function lycan_howl_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")

	local allies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetOrigin(),
		self:GetCaster(),
		radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		0,
		false
	)
	for _, ally in pairs(allies) do
		ally:AddNewModifier(self:GetCaster(), self, "modifier_lycan_howl_lua_buff", { duration = duration })
	end
	local sound_cast = "Hero_Lycan.Howl"
	-- EmitSoundOnLocationForAllies(self:GetCaster():GetAbsOrigin(), sound_cast, self:GetCaster())
	EmitSoundOn(sound_cast, self:GetCaster())

	local particle_lycan_howl_fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_lycan/lycan_howl_cast.vpcf",
		PATTACH_ABSORIGIN,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(particle_lycan_howl_fx, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_lycan_howl_fx, 1, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_lycan_howl_fx, 2, self:GetCaster():GetAbsOrigin())
end

---------------------------------------------------------------

modifier_lycan_howl_lua_buff = class({})

function modifier_lycan_howl_lua_buff:IsPurgable()
	return false
end
function modifier_lycan_howl_lua_buff:RemoveOnDeath()
	return false
end
function modifier_lycan_howl_lua_buff:IsHidden()
	return false
end

function modifier_lycan_howl_lua_buff:GetEffectName()
	return "particles/units/heroes/hero_lycan/lycan_howl_buff.vpcf"
end

function modifier_lycan_howl_lua_buff:OnCreated() end

function modifier_lycan_howl_lua_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_lycan_howl_lua_buff:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("as")
end

function modifier_lycan_howl_lua_buff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("movespeed")
end

function modifier_lycan_howl_lua_buff:GetModifierBaseDamageOutgoing_Percentage()
	return self:GetAbility():GetSpecialValueFor("damage")
end

---------------------------------------------------------------
---------------------------------------------------------------

LinkLuaModifier("modifier_lycan_feral_lua_buff", "heroes/hero_lycan/hero_lycan", LUA_MODIFIER_MOTION_NONE)

lycan_feral_lua = class({})

function lycan_feral_lua:GetIntrinsicModifierName()
	return "modifier_lycan_feral_lua_buff"
end

---------------------------------------------------------------

modifier_lycan_feral_lua_buff = class({})

function modifier_lycan_feral_lua_buff:IsPurgable()
	return false
end
function modifier_lycan_feral_lua_buff:RemoveOnDeath()
	return false
end
function modifier_lycan_feral_lua_buff:IsHidden()
	return true
end

function modifier_lycan_feral_lua_buff:OnCreated() end

function modifier_lycan_feral_lua_buff:DeclareFunctions()
	local decFuncs = { MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE, MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }

	return decFuncs
end

function modifier_lycan_feral_lua_buff:GetModifierBaseDamageOutgoing_Percentage()
	return self:GetAbility():GetSpecialValueFor("damage")
end

function modifier_lycan_feral_lua_buff:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("armor")
end

---------------------------------------------------------------
---------------------------------------------------------------

lycan_shapeshift_lua = class({})
LinkLuaModifier(
	"modifier_lycan_shapeshift_lua_transform_stun",
	"heroes/hero_lycan/hero_lycan",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_lycan_shapeshift_lua_transform", "heroes/hero_lycan/hero_lycan", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lycan_shapeshift_lua", "heroes/hero_lycan/hero_lycan", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lycan_shapeshift_lua_certain_crit", "heroes/hero_lycan/hero_lycan", LUA_MODIFIER_MOTION_NONE)

function lycan_shapeshift_lua:GetBehavior()
	local abil = self:GetCaster():FindAbilityByName("special_bonus_unique_lycan_8")
	if abil ~= nil and abil:GetLevel() > 0 then
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	end
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function lycan_shapeshift_lua:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local sound_cast = "Hero_Lycan.Shapeshift.Cast"
	local response_cast = "lycan_lycan_ability_shapeshift_"

	local abil = self:GetCaster():FindAbilityByName("special_bonus_unique_lycan_8")
	if abil ~= nil and abil:GetLevel() > 0 then
		target = self:GetCursorTarget()
	else
		target = caster
	end

	local transformation_time = 1
	local duration = ability:GetSpecialValueFor("duration")

	target:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_4)

	local random_sound = RandomInt(1, 10)
	local correct_sound_num = ""
	if random_sound < 10 then
		correct_sound_num = "0" .. tostring(random_sound)
	else
		correct_sound_num = random_sound
	end

	local response_cast = response_cast .. correct_sound_num
	local who_let_the_dogs_out = 10

	if RollPercentage(who_let_the_dogs_out) then
		EmitSoundOn("Imba.LycanDogsOut", target)
	else
		EmitSoundOn(response_cast, target)
	end

	EmitSoundOn(sound_cast, target)

	local particle_cast_fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_lycan/lycan_shapeshift_cast.vpcf",
		PATTACH_ABSORIGIN,
		target
	)
	ParticleManager:SetParticleControl(particle_cast_fx, 0, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_cast_fx, 1, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_cast_fx, 2, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_cast_fx, 3, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle_cast_fx)

	target:AddNewModifier(
		caster,
		ability,
		"modifier_lycan_shapeshift_lua_transform_stun",
		{ duration = transformation_time }
	)

	Timers:CreateTimer(transformation_time, function()
		target:AddNewModifier(caster, ability, "modifier_lycan_shapeshift_lua_transform", { duration = duration + 1 })
	end)
end

--------------------------------------------------------------------------------------------

modifier_lycan_shapeshift_lua_transform_stun = class({})

function modifier_lycan_shapeshift_lua_transform_stun:CheckState()
	local state = { [MODIFIER_STATE_STUNNED] = true }
	return state
end

function modifier_lycan_shapeshift_lua_transform_stun:IsHidden()
	return true
end

--------------------------------------------------------------------------------------------

modifier_lycan_shapeshift_lua_transform = class({})

function modifier_lycan_shapeshift_lua_transform:DeclareFunctions()
	local decFuncs = { MODIFIER_PROPERTY_MODEL_CHANGE }
	return decFuncs
end

function modifier_lycan_shapeshift_lua_transform:GetModifierModelChange()
	return "models/heroes/lycan/lycan_wolf.vmdl"
end

function modifier_lycan_shapeshift_lua_transform:OnCreated()
	local duration = self:GetAbility():GetSpecialValueFor("duration")
	if IsServer() then
		self:GetParent():AddNewModifier(
			self:GetCaster(),
			self:GetAbility(),
			"modifier_lycan_shapeshift_lua",
			{ duration = duration + 1 }
		)
	end
end

function modifier_lycan_shapeshift_lua_transform:OnDestroy()
	if IsServer() then
		local response_sound = "lycan_lycan_ability_revert_0" .. RandomInt(1, 3)

		EmitSoundOn(response_sound, self:GetParent())

		local particle_revert_fx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_lycan/lycan_shapeshift_revert.vpcf",
			PATTACH_ABSORIGIN,
			self:GetParent()
		)
		ParticleManager:SetParticleControl(particle_revert_fx, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(particle_revert_fx, 3, self:GetParent():GetAbsOrigin())
	end
end

function modifier_lycan_shapeshift_lua_transform:IsHidden()
	return false
end

function modifier_lycan_shapeshift_lua_transform:IsPurgable()
	return false
end

function modifier_lycan_shapeshift_lua_transform:IsDebuff()
	return false
end

--------------------------------------------------------------------------------------

modifier_lycan_shapeshift_lua = class({})

function modifier_lycan_shapeshift_lua:IsHidden()
	return true
end

function modifier_lycan_shapeshift_lua:IsPurgable()
	return false
end

function modifier_lycan_shapeshift_lua:OnCreated(kv)
	self.crit_chance = self:GetAbility():GetSpecialValueFor("chance")
	self.crit_mult = self:GetAbility():GetSpecialValueFor("mult")
	self.ms = self:GetAbility():GetSpecialValueFor("ms")
	self.hp = self:GetAbility():GetSpecialValueFor("hp")
end

function modifier_lycan_shapeshift_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,
		MODIFIER_PROPERTY_HEALTH_BONUS,
	}
	return funcs
end

function modifier_lycan_shapeshift_lua:GetModifierMoveSpeed_AbsoluteMin()
	return self.ms
end

function modifier_lycan_shapeshift_lua:GetModifierHealthBonus()
	return self.hp
end

function modifier_lycan_shapeshift_lua:GetModifierPreAttack_CriticalStrike(params)
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		if params.target:GetTeamNumber() == self:GetParent():GetTeamNumber() then
			return
		end
		if RandomInt(0, 100) < self.crit_chance then
			self.record = params.record
			return self.crit_mult
		end
	end
end