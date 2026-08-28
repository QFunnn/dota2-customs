--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_031"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.PrivilegeValue
local j = g.RegisterPrivilege
local k = c()
k.name = "privilege_myth_031"
d(k, h)
function k.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.hasStaticProperty = false
end
function k.prototype.OnCreated(self)
	self:RefreshStaticProperties(true)
	self:StartThink(0.2, "privilege_myth_031_static_property", function()
		self:RefreshStaticProperties()
		return 0.2
	end)
end
function k.prototype.OnRefresh(self)
	h.prototype.OnRefresh(self)
	self:RefreshStaticProperties(true)
end
function k.prototype.RefreshStaticProperties(self, l)
	if l == nil then
		l = false
	end
	local m = self:GetCaster()
	if not IsValid(m) then
		return
	end
	if m:HasModifier("modifier_privilege_myth_030") then
		if not self.hasStaticProperty or l then
			PropertySystem:AddStaticProperty(m:entindex(), "bleed_damage_boost", self.privilegeName, self.value)
			PropertySystem:AddStaticProperty(m:entindex(), "movespeed_amplify", self.privilegeName, self.value)
			self.hasStaticProperty = true
		end
		return
	end
	if self.hasStaticProperty or l then
		PropertySystem:RemoveStaticProperty(m:entindex(), self.privilegeName, "bleed_damage_boost")
		PropertySystem:RemoveStaticProperty(m:entindex(), self.privilegeName, "movespeed_amplify")
		self.hasStaticProperty = false
	end
end
e({ i(nil) }, k.prototype, "value", nil)
k = e({ j(nil) }, k)
return f