--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_troll_warlord_fervor_lua",
	"heroes/hero_troll_warlord/troll_warlord_fervor_lua/troll_warlord_fervor_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_troll_warlord_fervor_lua_debuff",
	"heroes/hero_troll_warlord/troll_warlord_fervor_lua/troll_warlord_fervor_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_troll_warlord_fervor_lua_debuff_2",
	"heroes/hero_troll_warlord/troll_warlord_fervor_lua/troll_warlord_fervor_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_troll_warlord_fervor_lua_buff",
	"heroes/hero_troll_warlord/troll_warlord_fervor_lua/troll_warlord_fervor_lua",
	LUA_MODIFIER_MOTION_NONE
)

troll_warlord_fervor_lua = class({})

function troll_warlord_fervor_lua:GetIntrinsicModifierName()
	return "modifier_troll_warlord_fervor_lua"
end

----------------------------------------------------------------

modifier_troll_warlord_fervor_lua = class({})

function modifier_troll_warlord_fervor_lua:IsHidden()
	return true
end

function modifier_troll_warlord_fervor_lua:IsPurgable()
	return false
end

function modifier_troll_warlord_fervor_lua:OnCreated()
	self:SetStackCount(1)
	self.count = self:GetAbility():GetSpecialValueFor("count")
	local abil = self:GetCaster():FindAbilityByName("special_bonus_troll_warlord_int3")
	if abil ~= nil and abil:GetLevel() > 0 then
		self.count = self.count - 2
	end
	self.dmg = self:GetAbility():GetSpecialValueFor("dmg")
end

function modifier_troll_warlord_fervor_lua:OnRefresh()
	self:OnCreated()
end

function modifier_troll_warlord_fervor_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
	return funcs
end

function modifier_troll_warlord_fervor_lua:OnAttackLanded(params)
	if not IsServer() then
		return
	end
	if params.attacker ~= self:GetParent() then
		return
	end
	self:AddStack(params.target, params.original_damage)
end

function modifier_troll_warlord_fervor_lua:AddStack(target, original_damage)
	if not self:GetParent():PassivesDisabled() then
		if self:GetStackCount() < self.count then
			self:SetStackCount(self:GetStackCount() + 1)
		end
		if self:GetStackCount() == self.count then
			if self:GetParent():GetAttackCapability() == DOTA_UNIT_CAP_MELEE_ATTACK then
				local damage = original_damage * (self.dmg / 100)

				DoCleaveAttack(
					self:GetParent(),
					target,
					self:GetAbility(),
					damage,
					150,
					360,
					360,
					"particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave.vpcf"
				)
			else
				local attack_range = self:GetParent():Script_GetAttackRange() + 100
				local count = 2
				local units = FindUnitsInRadius(
					self:GetParent():GetTeamNumber(),
					self:GetParent():GetAbsOrigin(),
					self:GetParent(),
					attack_range,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_CREEP,
					DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
						+ DOTA_UNIT_TARGET_FLAG_NO_INVIS
						+ DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
					FIND_CLOSEST,
					false
				)
				if self.split == nil then
					self.split = true
				elseif self.split == false then
					return
				end
				self.split = false
				if count > #units - 1 then
					count = #units - 1
				end

				local index = 1
				local arrow_deal = 0

				while arrow_deal < count do
					if units[index] == target then
					else
						self:GetParent():PerformAttack(units[index], false, false, true, false, true, false, false)
						arrow_deal = arrow_deal + 1
					end
					index = index + 1
				end

				self.split = true
			end
			self:ResetStack()
		end
	end
end

function modifier_troll_warlord_fervor_lua:ResetStack()
	if not self:GetParent():PassivesDisabled() then
		self:SetStackCount(1)
	end
end