--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- kobold_disarm rewrite

LinkLuaModifier("modifier_devour_disarm", "abilities/heroes/doom/devour_disarm.lua", LUA_MODIFIER_MOTION_NONE)

devour_disarm = devour_disarm or class({})

function devour_disarm:GetIntrinsicModifierName()
	return "modifier_devour_disarm"
end


modifier_devour_disarm = modifier_devour_disarm or class({})

function modifier_devour_disarm:IsHidden() return self:GetStackCount() == 0 end

function modifier_devour_disarm:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_devour_disarm:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not self.caster or self.caster:IsNull() then return end
	if not self.ability or self.ability:IsNull() then return end

	self.duration = self.ability:GetSpecialValueFor("duration")
	self.stack_count_proc = self.ability:GetSpecialValueFor("stack_count_proc")
end

function modifier_devour_disarm:OnRefresh()
	self:OnCreated()
end

function modifier_devour_disarm:GetModifierProcAttack_Feedback(kv)
	if not IsServer() then return end
	if kv.damage <= 0 then return end
	if kv.attacker ~= self.caster then return end
	if kv.target:GetTeamNumber() == kv.attacker:GetTeamNumber() then return end
	if kv.target:IsOther() then return end

	if not self.ability:IsCooldownReady() then return end
	self:IncrementStackCount()
	if self:GetStackCount() == self.stack_count_proc then
		kv.target:AddNewModifier(self.caster, self.ability, "modifier_disarmed", {duration = self.duration * (1 - kv.target:GetStatusResistance())})
		self:SetStackCount(0)
		self.ability:UseResources(false, false, false, true)
	end
end