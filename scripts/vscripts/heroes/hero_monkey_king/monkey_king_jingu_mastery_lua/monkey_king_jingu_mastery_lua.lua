--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_monkey_king_jingu_mastery_lua",
	"heroes/hero_monkey_king/monkey_king_jingu_mastery_lua/monkey_king_jingu_mastery_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_monkey_king_jingu_mastery_lua_counter",
	"heroes/hero_monkey_king/monkey_king_jingu_mastery_lua/monkey_king_jingu_mastery_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_monkey_king_jingu_mastery_lua_active",
	"heroes/hero_monkey_king/monkey_king_jingu_mastery_lua/monkey_king_jingu_mastery_lua",
	LUA_MODIFIER_MOTION_NONE
)

monkey_king_jingu_mastery_lua = class({})

function monkey_king_jingu_mastery_lua:GetIntrinsicModifierName()
	return "modifier_monkey_king_jingu_mastery_lua"
end

-----------------------------------------------------

modifier_monkey_king_jingu_mastery_lua = class({})

function modifier_monkey_king_jingu_mastery_lua:IsHidden()
	return true
end

function modifier_monkey_king_jingu_mastery_lua:IsPurgable()
	return false
end

function modifier_monkey_king_jingu_mastery_lua:OnCreated()
	self.max_duration = self:GetAbility():GetSpecialValueFor("max_duration")
end

function modifier_monkey_king_jingu_mastery_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,

		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,
	}
end

function modifier_monkey_king_jingu_mastery_lua:OnAttackLanded(data)
	if data.attacker ~= self:GetParent() then
		return
	end
	if data.target:IsBuilding() then
		return
	end
	if self:GetParent():PassivesDisabled() then
		return
	end
	if self:GetParent():HasModifier("modifier_monkey_king_jingu_mastery_lua_active") then
		return
	end
	data.target:AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_monkey_king_jingu_mastery_lua_counter",
		{ duration = self.max_duration }
	)
end

----------------------------------------------------------------------------------

modifier_monkey_king_jingu_mastery_lua_counter = class({})

function modifier_monkey_king_jingu_mastery_lua_counter:IsHidden()
	return false
end

function modifier_monkey_king_jingu_mastery_lua_counter:IsPurgable()
	return true
end

function modifier_monkey_king_jingu_mastery_lua_counter:OnCreated()
	self.required_hits = self:GetAbility():GetSpecialValueFor("required_hits")
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	self.pcf = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_stack.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(self.pcf, 1, Vector(0, self:GetStackCount(), 0))
	self:AddParticle(self.pcf, false, false, -1, false, true)
end

function modifier_monkey_king_jingu_mastery_lua_counter:OnRefresh()
	if not IsServer() then
		return
	end
	self:IncrementStackCount()
	ParticleManager:SetParticleControl(self.pcf, 1, Vector(0, self:GetStackCount(), 0))
end

function modifier_monkey_king_jingu_mastery_lua_counter:OnStackCountChanged()
	if not IsServer() then
		return
	end
	if self:GetStackCount() >= self.required_hits then
		self:GetCaster()
			:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_monkey_king_jingu_mastery_lua_active", {})
		EmitSoundOn("Hero_MonkeyKing.IronCudgel", self:GetCaster())
		self:Destroy()
	end
end

---------------------------------------------------------------------

modifier_monkey_king_jingu_mastery_lua_active = class({})

function modifier_monkey_king_jingu_mastery_lua_active:IsHidden()
	return false
end

function modifier_monkey_king_jingu_mastery_lua_active:IsDebuff()
	return false
end

function modifier_monkey_king_jingu_mastery_lua_active:IsPurgable()
	return true
end

function modifier_monkey_king_jingu_mastery_lua_active:IsPurgeException()
	return false
end

function modifier_monkey_king_jingu_mastery_lua_active:OnCreated()
	self.max_duration = self:GetAbility():GetSpecialValueFor("max_duration")
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.charges = self:GetAbility():GetSpecialValueFor("charges")

	local ability = self:GetCaster():FindAbilityByName("special_bonus_monkey_king_1")
	if ability ~= nil and ability:GetLevel() > 0 then
		self.charges = self.charges + 2
	end

	local ability = self:GetCaster():FindAbilityByName("special_bonus_monkey_king_3")
	if ability ~= nil and ability:GetLevel() > 0 then
		self.bonus_damage = self.bonus_damage + 40
	end

	self.lifesteal = self:GetAbility():GetSpecialValueFor("lifesteal")

	local ability = self:GetCaster():FindAbilityByName("special_bonus_monkey_king_6")
	if ability ~= nil and ability:GetLevel() > 0 then
		self.lifesteal = self.lifesteal + 25
	end

	if not IsServer() then
		return
	end
	local pcf = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_overhead.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
	self:AddParticle(pcf, false, false, -1, false, true)
	self.special_bonus_unique_special_bonus_monkey_king_str9 = self:GetCaster():FindAbilityByName(
		"special_bonus_unique_special_bonus_monkey_king_str9"
	) ~= nil
	if self.special_bonus_unique_special_bonus_monkey_king_str9 then
		self:SetDuration(-1, true)
		self:SetStackCount(self.charges)
		self:StartIntervalThink(1)
	else
		self:SetDuration(self.max_duration, true)
		self:SetStackCount(self.charges)
	end
end

function modifier_monkey_king_jingu_mastery_lua_active:OnIntervalThink()
	self.special_bonus_unique_special_bonus_monkey_king_str9 = self:GetCaster():FindAbilityByName(
		"special_bonus_unique_special_bonus_monkey_king_str9"
	) ~= nil
	if not self.special_bonus_unique_special_bonus_monkey_king_str9 then
		self:SetDuration(self.max_duration, true)
		self:SetStackCount(self.charges)
		self:StartIntervalThink(-1)
	end
end

function modifier_monkey_king_jingu_mastery_lua_active:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_monkey_king_jingu_mastery_lua_active:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_monkey_king_jingu_mastery_lua_active:OnAttackLanded(data)
	if data.attacker == self:GetParent() and not data.target:IsBuilding() and not data.attacker:PassivesDisabled() then
		local lifePfx = ParticleManager:CreateParticle(
			"particles/generic_gameplay/generic_lifesteal.vpcf",
			PATTACH_POINT_FOLLOW,
			data.attacker
		)
		ParticleManager:ReleaseParticleIndex(lifePfx)
		local hitPfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf",
			PATTACH_POINT_FOLLOW,
			data.target
		)
		ParticleManager:SetParticleControl(hitPfx, 1, data.target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(hitPfx)
		data.attacker:HealWithParams(data.damage * self.lifesteal / 100, self, true, true, data.attacker, false)
		if
			self:GetCaster().cast_boundless_strike == true
			or not self.special_bonus_unique_special_bonus_monkey_king_str9
		then
			self:DecrementStackCount()
		end
		if self:GetStackCount() <= 0 then
			self:Destroy()
		end
	end
end