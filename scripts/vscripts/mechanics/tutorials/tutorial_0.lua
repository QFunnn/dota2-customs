--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/tutorials/tutorial_0"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = {}
local f = require("mechanics.tutorials.tutorial_base")
local g = f.TutorialBase
e.tutorial_0 = c()
local h = e.tutorial_0
h.name = "tutorial_0"
d(h, g)
function h.prototype.spawn(self)
	g.prototype.spawn(self)
	local i = self:GetHero()
	local j = self:GetRoom():GetPosition()
	FindClearSpaceForUnit(i, j + Vector(0, -384, 0), true)
	i:SetForwardVector(vec3_top)
	self:AddTutorialUpper("Text", "tutorial_0_upper", 3, nil, function()
		self:Complete()
	end)
end
return e