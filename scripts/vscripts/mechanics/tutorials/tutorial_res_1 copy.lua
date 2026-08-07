--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/tutorials/tutorial_res_1 copy"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["7"] = 1,
		["8"] = 1,
		["9"] = 3,
		["10"] = 3,
		["11"] = 3,
		["12"] = 3,
		["13"] = 5,
		["14"] = 3,
		["15"] = 7,
		["16"] = 9,
		["17"] = 9,
		["18"] = 9,
		["19"] = 9,
		["20"] = 9,
		["21"] = 9,
		["22"] = 10,
		["23"] = 10,
		["24"] = 10,
		["25"] = 11,
		["26"] = 11,
		["27"] = 11,
		["28"] = 11,
		["29"] = 12,
		["30"] = 12,
		["31"] = 12,
		["32"] = 13,
		["33"] = 14,
		["34"] = 15,
		["35"] = 12,
		["36"] = 17,
		["37"] = 18,
		["38"] = 19,
		["39"] = 12,
		["40"] = 12,
		["41"] = 12,
		["42"] = 10,
		["43"] = 10,
		["44"] = 5,
		["45"] = 24,
		["46"] = 25,
		["47"] = 26,
		["48"] = 27,
		["50"] = 24,
	}
)
local f = {}
local g = require("mechanics.tutorials.tutorial_base")
local h = g.TutorialBase
f.tutorial_res_1 = c()
local i = f.tutorial_res_1
i.name = "tutorial_res_1"
d(i, h)
function i.prototype.spawn(self)
	h.prototype.spawn(self)
	local j = self:GetHero()
	PropertySystem:AddStaticProperty(j:entindex(), "break_drop_chance", "tutorial_res_1", 100)
	self.eventListenerID = Event:Register("break_drop", function(k, l)
		PropertySystem:RemoveStaticProperty(j:entindex(), "tutorial_res_1")
		GameModeTutorial:AddTutorialTextUpper("tutorial_break", 2, function()
			self:ShowPing("Tips", l.drop_item.position)
			GameModeTutorial:SendCameraFollowPosition(l.drop_item.position)
		end, function()
			GameModeTutorial:SendCameraFollowHero()
			self:dispose()
		end, 0.2)
	end)
end
function i.prototype.dispose(self)
	if self.eventListenerID ~= nil then
		Event:Unregister(self.eventListenerID)
		self.eventListenerID = nil
	end
end
return f