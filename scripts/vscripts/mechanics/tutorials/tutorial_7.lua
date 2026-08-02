--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/tutorials/tutorial_7"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = {}
local f = require("mechanics.tutorials.tutorial_base")
local g = f.TutorialBase
e.tutorial_7 = c()
local h = e.tutorial_7
h.name = "tutorial_7"
d(h, g)
function h.prototype.spawn(self)
	g.prototype.spawn(self)
	self:RegisterEvent("dungeon_room_open_gates", function(i, j)
		if j.room ~= self:GetRoom() then
			return
		end
		self:GameTimer(5, function()
			self:AddTutorialUpper("Text", "tutorial_7_2_upper", 3, function()
				local k = GameModeTutorial:OpenTutorialExitGates()
				if k ~= nil then
					self:ShowPing("Tips", k)
				end
			end, function()
				GameModeTutorial:SendCameraFollowHero()
				self:Complete()
			end)
		end)
	end)
end
function h.prototype.Activate(self)
	local l = self:GetRoom():GetPosition()
	self:AddTutorialUpper("Interact", "tutorial_7_1_upper", 5, function()
		GameModeTutorial:SendCameraFollowPosition(l)
		self:ShowPing("Tips", l, 5)
	end, function()
		GameModeTutorial:SendCameraFollowHero()
	end)
end
return e