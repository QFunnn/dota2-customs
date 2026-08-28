--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "mechanics/tutorials/tutorial_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = {}
local f = require("mechanics.tutorials.tutorial_base")
local g = f.TutorialBase
e.tutorial_1 = c()
local h = e.tutorial_1
h.name = "tutorial_1"
d(h, g)
function h.prototype.spawn(self)
	g.prototype.spawn(self)
end
function h.prototype.Activate(self)
	self:MoveTask()
end
function h.prototype.MoveTask(self)
	self.upper_id = self:AddTutorialUpper("Movement", "tutorial_1_upper", 999)
	GameModeTutorial:SetTutorialTask(
		"tutorial_1",
		{ { key = "tutorial_1_move", text = "tutorial_1_move", success = false } }
	)
	local i = self:GetHero():GetAbsOrigin()
	self.moveListener = self:GameTimer(0, function()
		local j = self:GetHero()
		local k = j:GetAbsOrigin()
		if CalcDistance(i, k) > 50 then
			self:FinishMoveTask()
			return
		end
		return 0
	end)
	self.eventID = Event:Register("tutorial_task_completed", function(l, m)
		if m.tutorialKey == "tutorial_1" then
			if self.upper_id then
				GameModeTutorial:CloseTutorialUpper(self.upper_id)
			end
			print("教学完成")
			self:Complete()
		end
	end, self)
end
function h.prototype.FinishMoveTask(self)
	self:GameTimer(2, function()
		GameModeTutorial:FinishTutorialTask("tutorial_1_move")
	end)
end
function h.prototype.dispose(self)
	g.prototype.dispose(self)
	if self.moveListener ~= nil then
		Timer:StopTimer(self.moveListener)
		self.moveListener = nil
	end
	if self.eventID ~= nil then
		Event:Unregister(self.eventID)
		self.eventID = nil
	end
end
return e