--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


donate_pet_ability = class({})

function donate_pet_ability:OnToggle()
	local caster = self:GetCaster()
	local mod = caster:FindModifierByName("modifier_donate_pet")

	if not mod then
		return
	end

	if mod:GetStackCount() == 1 then
		mod:SetStackCount(0)
	else
		mod:SetStackCount(1)
	end
end