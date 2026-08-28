--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


item_cheese_lua = class({})

function item_cheese_lua:OnSpellStart()
	if IsServer() then
		self.caster = self:GetCaster()
		self.all = self:GetSpecialValueFor("all")
		self.caster:SetBaseStrength(self.caster:GetBaseStrength() + self.all)
		self.caster:SetBaseAgility(self.caster:GetBaseAgility() + self.all)
		self.caster:SetBaseIntellect(self.caster:GetBaseIntellect() + self.all)
		UTIL_Remove(self)
	end
end