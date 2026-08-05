--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_wraith_king_mortal_strike_lua",
	"heroes/hero_skeleton/wraith_king_crit/wraith_king_crit",
	LUA_MODIFIER_MOTION_NONE
)

wraith_king_mortal_strike_lua = class({})

function wraith_king_mortal_strike_lua:GetIntrinsicModifierName()
	return "modifier_wraith_king_mortal_strike_lua"
end

----------------------------------------------------------------

modifier_wraith_king_mortal_strike_lua = class({})

function modifier_wraith_king_mortal_strike_lua:IsHidden()
	return true
end

function modifier_wraith_king_mortal_strike_lua:IsDebuff()
	return false
end

function modifier_wraith_king_mortal_strike_lua:OnCreated(kv)
	self.crit_chance = self:GetAbility():GetSpecialValueFor("crit_chance")
	self.crit_mult = self:GetAbility():GetSpecialValueFor("crit_mult")
	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_skeleton_king_tal2")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		self.crit_chance = self.crit_chance * 2
	end
end

function modifier_wraith_king_mortal_strike_lua:OnRefresh(kv)
	self.crit_chance = self:GetAbility():GetSpecialValueFor("crit_chance")
	self.crit_mult = self:GetAbility():GetSpecialValueFor("crit_mult")
	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_skeleton_king_tal2")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		self.crit_chance = self.crit_chance * 2
	end
end

function modifier_wraith_king_mortal_strike_lua:OnDestroy(kv) end

function modifier_wraith_king_mortal_strike_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
	return funcs
end

function modifier_wraith_king_mortal_strike_lua:GetModifierPreAttack_CriticalStrike(params)
	if IsServer() then
		local pass = false
		if params.target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
			pass = true
		end

		if pass and RandomInt(1, 100) <= self.crit_chance then
			self.attack_record = params.record
			return self.crit_mult
		end
	end
	return 0
end

function modifier_wraith_king_mortal_strike_lua:GetModifierProcAttack_Feedback(params)
	if IsServer() then
		local pass = false
		if self.attack_record and params.record == self.attack_record then
			pass = true
			self.attack_record = nil
		end

		if pass then
			self:PlayEffects(params.target)
		end
	end
end

function modifier_wraith_king_mortal_strike_lua:PlayEffects(target)
	local sound_impact = "Hero_SkeletonKing.CriticalStrike"
	EmitSoundOn(sound_impact, target)
end