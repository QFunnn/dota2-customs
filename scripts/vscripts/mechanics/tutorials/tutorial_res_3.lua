--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/tutorials/tutorial_res_3"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = {}
local f = require("mechanics.tutorials.tutorial_base")
local g = f.TutorialBase
e.tutorial_res_3 = c()
local h = e.tutorial_res_3
h.name = "tutorial_res_3"
d(h, g)
function h.prototype.spawn(self)
	g.prototype.spawn(self)
	self:RegisterEvent("entity_killed", function(i, j)
		local k = j.victim
		if k:GetClassname() ~= "npc_dota_building" then
			return
		end
		local l = k:GetAbsOrigin()
		self:dispose()
		GameModeTutorial:AddTutorialTextUpper("tutorial_build", 3, function()
			GameModeTutorial:SendCameraFollowPosition(l)
			self:ShowPing("Tips", l)
		end, function()
			GameModeTutorial:SendCameraFollowHero()
		end, 0.2)
	end)
end
return e