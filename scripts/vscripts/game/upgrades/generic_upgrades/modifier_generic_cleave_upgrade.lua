--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_cleave_upgrade = class(modifier_base_generic_upgrade)


function modifier_generic_cleave_upgrade:RecalculateBonusPerUpgrade()
	self.cleave_damage = self:CalculateBonusPerUpgrade("cleave_damage") / 100
	self.cleave_width = self:GetUpgradeValueFor("fixed_cleave_width")
	self.cleave_distance = self:GetUpgradeValueFor("fixed_cleave_distance")
end


function modifier_generic_cleave_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_cleave_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_cleave_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK, -- GetModifierProcAttack_Feedback
	}
end


function modifier_generic_cleave_upgrade:GetModifierProcAttack_Feedback(params)
	local target = params.target
	if not IsValidEntity(target) then return end

	local parent = self:GetParent()
	if not IsValidEntity(parent) then return end

	DoCleaveAttack(
		parent,
		target,
		nil,
		params.damage * self.cleave_damage,
		0,
		self.cleave_width,
		self.cleave_distance,
		"particles/items_fx/battlefury_cleave.vpcf"
	)
end