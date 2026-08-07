--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/tutorials/tutorial_res_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = {}
local f = require("mechanics.tutorials.tutorial_base")
local g = f.TutorialBase
e.tutorial_res_1 = c()
local h = e.tutorial_res_1
h.name = "tutorial_res_1"
d(h, g)
function h.prototype.spawn(self)
	g.prototype.spawn(self)
	local i = self:GetHero()
	self:RegisterEvent("break_drop", function(j, k)
		if PropertySystem:GetStaticPropertyValue(PropertyScope.UNIT, i:entindex(), "break_drop_chance") > 100 then
			PropertySystem:AddStaticProperty(i:entindex(), "break_drop_chance", "tutorial_drop", -1000)
			PropertySystem:RemoveStaticProperty(i:entindex(), "tutorial_drop")
			GameModeTutorial:AddTutorialTextUpper("tutorial_break", 3, function()
				self:ShowPing("Tips", k.drop_item.position)
				GameModeTutorial:SendCameraFollowPosition(k.drop_item.position)
			end, function()
				GameModeTutorial:SendCameraFollowHero()
			end, 0.2)
			self:dispose()
		end
	end)
end
return e