--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- berserker_troll_break rewrite

LinkLuaModifier("modifier_devour_break", "abilities/heroes/doom/devour_break.lua", LUA_MODIFIER_MOTION_NONE)

devour_break = devour_break or class({})

function devour_break:GetIntrinsicModifierName()
	return "modifier_devour_break"
end


modifier_devour_break = modifier_devour_break or class({})

function modifier_devour_break:IsHidden() return true end

function modifier_devour_break:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_devour_break:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not self.caster or self.caster:IsNull() then return end
	if not self.ability or self.ability:IsNull() then return end

	self.duration = self.ability:GetSpecialValueFor("duration")
end

function modifier_devour_break:OnRefresh()
	self:OnCreated()
end

function modifier_devour_break:GetModifierProcAttack_Feedback(kv)
	if not IsServer() then return end
	if kv.damage <= 0 then return end
	if kv.attacker ~= self.caster then return end
	if kv.target:GetTeamNumber() == kv.attacker:GetTeamNumber() then return end
	if kv.target:IsOther() then return end

	if not self.ability:IsCooldownReady() then return end
	kv.target:AddNewModifier(self.caster, self.ability, "modifier_break", {duration = self.duration * (1 - kv.target:GetStatusResistance())})
	self.ability:UseResources(false, false,  false, true)
end