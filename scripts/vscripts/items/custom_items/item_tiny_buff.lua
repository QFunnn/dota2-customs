--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


item_tiny_buff = class({})

function item_tiny_buff:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	caster:AddNewModifier(self:GetCaster(), nil, "modifier_rune_arcane", { duration = 45 })
	caster:AddNewModifier(self:GetCaster(), nil, "modifier_rune_doubledamage", { duration = 45 })
	caster:AddNewModifier(self:GetCaster(), nil, "modifier_rune_haste", { duration = 45 })
	caster:AddNewModifier(self:GetCaster(), nil, "modifier_rune_illusion", { duration = FrameTime() })
	caster:AddNewModifier(self:GetCaster(), nil, "modifier_rune_invis", { duration = 45 })
	caster:AddNewModifier(self:GetCaster(), nil, "modifier_rune_regen", { duration = 45 })
	self:SpendCharge(0)
end