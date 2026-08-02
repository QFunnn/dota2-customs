--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_sven_great_cleave_lua",
	"heroes/hero_sven/sven_great_cleave_lua/sven_great_cleave_lua",
	LUA_MODIFIER_MOTION_NONE
)

sven_great_cleave_lua = class({})

function sven_great_cleave_lua:GetIntrinsicModifierName()
	return "modifier_sven_great_cleave_lua"
end

--------------------------------------------------------------------------------
modifier_sven_great_cleave_lua = class({})

function modifier_sven_great_cleave_lua:IsHidden()
	return true
end

function modifier_sven_great_cleave_lua:OnCreated(kv)
	self.great_cleave_damage = self:GetAbility():GetSpecialValueFor("great_cleave_damage")
	self.great_cleave_radius = self:GetAbility():GetSpecialValueFor("great_cleave_radius")
end

function modifier_sven_great_cleave_lua:OnRefresh(kv)
	self.great_cleave_damage = self:GetAbility():GetSpecialValueFor("great_cleave_damage")
	self.great_cleave_radius = self:GetAbility():GetSpecialValueFor("great_cleave_radius")
end

function modifier_sven_great_cleave_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}

	return funcs
end

function modifier_sven_great_cleave_lua:OnAttackLanded(params)
	if IsServer() then
		if params.attacker == self:GetParent() and (not self:GetParent():IsIllusion()) then
			if self:GetParent():PassivesDisabled() then
				return 0
			end

			local target = params.target
			if target ~= nil and target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
				local cleaveDamage = (self.great_cleave_damage * params.damage) / 100.0
				DoCleaveAttack(
					self:GetParent(),
					target,
					self:GetAbility(),
					cleaveDamage,
					150,
					360,
					self.great_cleave_radius,
					"particles/units/heroes/hero_sven/sven_spell_great_cleave.vpcf"
				)
			end
		end
	end
	return 0
end