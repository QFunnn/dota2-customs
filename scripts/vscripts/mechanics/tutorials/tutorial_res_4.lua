--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/tutorials/tutorial_res_4"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = {}
local f = require("mechanics.tutorials.tutorial_base")
local g = f.TutorialBase
e.tutorial_res_4 = c()
local h = e.tutorial_res_4
h.name = "tutorial_res_4"
d(h, g)
function h.prototype.spawn(self)
	g.prototype.spawn(self)
	local i = self:GetHero()
	PropertySystem:AddStaticProperty(i:entindex(), "exp_gain_amount", "tutorial_exp", 1000)
end
function h.prototype.Activate(self)
	Player:ModifyGold(self:GetPlayerID(), 150, true)
end
function h.prototype.dispose(self)
	g.prototype.dispose(self)
	PropertySystem:RemoveStaticProperty(self:GetHero():entindex(), "tutorial_exp")
end
return e