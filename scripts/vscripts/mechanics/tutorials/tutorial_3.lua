--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/tutorials/tutorial_3"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = {}
local f = require("mechanics.tutorials.tutorial_base")
local g = f.TutorialBase
e.tutorial_3 = c()
local h = e.tutorial_3
h.name = "tutorial_3"
d(h, g)
function h.prototype.Activate(self)
	g.prototype.Activate(self)
	self:AddTutorialUpper("Text", "tutorial_3_upper", 3, function()
		local i = GameModeTutorial:OpenTutorialExitGates()
		if i ~= nil then
			self:ShowPing("Tips", i)
		end
		self:Complete()
	end, function()
		GameModeTutorial:SendCameraFollowHero()
	end)
end
return e