--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


marci_special_delivery = marci_special_delivery or class({})


function marci_special_delivery:OnOwnerSpawned()
	print("special delivery spawned!")

	local caster = self:GetCaster()

	local tower = GameLoop.towers[caster:GetTeam()]

	if not tower then
		print("TOWER NOT FOUND")
		return
	end

	local ms_modifier = tower:FindModifierByName("modifier_fountain_movespeed_lua")
	if not ms_modifier or ms_modifier:IsNull() then
		print("MS MODIFIER NOT FOUND")
		return
	end

	local expected_duration = self:GetSpecialValueFor("fountain_buff_duration")
	ms_modifier:SetStackCount(expected_duration)
end


function marci_special_delivery:Spawn()
	self:OnOwnerSpawned()
end