--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_hero_pangolier_runic_blade",
	"heroes/hero_pangolier/hero_pangolier_runic_blade/hero_pangolier_runic_blade",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_hero_pangolier_runic_blade_stack",
	"heroes/hero_pangolier/hero_pangolier_runic_blade/hero_pangolier_runic_blade",
	LUA_MODIFIER_MOTION_NONE
)

hero_pangolier_runic_blade = class({})

function hero_pangolier_runic_blade:GetIntrinsicModifierName()
	return "modifier_hero_pangolier_runic_blade"
end

---------------------------------------------------------------------------------

modifier_hero_pangolier_runic_blade = class({})

function modifier_hero_pangolier_runic_blade:IsHidden()
	return self:GetStackCount() == 0
end

function modifier_hero_pangolier_runic_blade:IsDebuff()
	return false
end

function modifier_hero_pangolier_runic_blade:IsPurgable()
	return false
end

function modifier_hero_pangolier_runic_blade:OnCreated(kv)
	self.current_stack = 0
end

function modifier_hero_pangolier_runic_blade:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}
	return funcs
end

function modifier_hero_pangolier_runic_blade:OnAbilityFullyCast(params)
	if IsServer() then
		if
			params.unit ~= self:GetParent()
			or self:GetParent():PassivesDisabled()
			or params.ability:IsItem()
			or not params.unit:IsAlive()
		then
			return
		end
		self:AddStack()
	end
end

function modifier_hero_pangolier_runic_blade:GetModifierPreAttack_CriticalStrike()
	return 100 + self:GetStackCount()
end

function modifier_hero_pangolier_runic_blade:RefreshStack()
	self.crit_per_stack = self:GetAbility():GetSpecialValueFor("crit_per_stack")
	local ability = self:GetCaster():FindAbilityByName("pango_2")
	if ability ~= nil and ability:GetLevel() > 0 then
		self.crit_per_stack = self.crit_per_stack + 10
	end

	self:SetStackCount(self.current_stack * self.crit_per_stack)
end

function modifier_hero_pangolier_runic_blade:AddStack()
	self.stack_duration = self:GetAbility():GetSpecialValueFor("stack_duration")
	local ability = self:GetCaster():FindAbilityByName("pango_1")
	if ability ~= nil and ability:GetLevel() > 0 then
		self.stack_duration = self.stack_duration + 1
	end

	self.current_stack = self.current_stack + 1
	self:RefreshStack()

	local parent = self:GetAbility():AddATValue(self)
	self:GetParent():AddNewModifier(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"modifier_hero_pangolier_runic_blade_stack", -- modifier name
		{
			duration = self.stack_duration,
			parent = parent,
		} -- kv
	)
end

function modifier_hero_pangolier_runic_blade:RemoveStack()
	self.current_stack = self.current_stack - 1
	self:RefreshStack()
end

------------------------------------------------------

modifier_hero_pangolier_runic_blade_stack = class({})

function modifier_hero_pangolier_runic_blade_stack:IsHidden()
	return true
end

function modifier_hero_pangolier_runic_blade_stack:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_hero_pangolier_runic_blade_stack:IsPurgable()
	return false
end

function modifier_hero_pangolier_runic_blade_stack:OnCreated(kv)
	if IsServer() then
		self.parent = self:GetAbility():RetATValue(kv.parent)
	end
end

function modifier_hero_pangolier_runic_blade_stack:OnRemoved()
	if IsServer() then
		self.parent:RemoveStack()
	end
end

----------------------------------------------------

function hero_pangolier_runic_blade:GetAT()
	if self.abilityTable == nil then
		self.abilityTable = {}
	end
	return self.abilityTable
end

function hero_pangolier_runic_blade:GetATEmptyKey()
	local table = self:GetAT()
	local i = 1
	while table[i] ~= nil do
		i = i + 1
	end
	return i
end

function hero_pangolier_runic_blade:AddATValue(value)
	local table = self:GetAT()
	local i = self:GetATEmptyKey()
	table[i] = value
	return i
end

function hero_pangolier_runic_blade:RetATValue(key)
	local table = self:GetAT()
	local ret = table[key]
	table[key] = nil
	return ret
end