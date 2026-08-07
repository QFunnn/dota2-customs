--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/tutorials/tutorial_res_2"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = {}
local f = require("mechanics.tutorials.tutorial_base")
local g = f.TutorialBase
e.tutorial_res_2 = c()
local h = e.tutorial_res_2
h.name = "tutorial_res_2"
d(h, g)
function h.prototype.spawn(self)
	g.prototype.spawn(self)
	local i = self:GetHero()
	self:RegisterEvent("pre_attack_event", function(j, k)
		print("pre_attack_event", k.attacker:GetUnitName(), k.position)
		if k.attacker:GetTeamNumber() == DOTA_TEAM_BADGUYS then
			self:dispose()
			GameModeTutorial:AddTutorialTextUpper("tutorial_attack", 3, function()
				self:ShowPing("warning", k.position)
			end, function() end, 0.2)
		end
	end)
end
return e