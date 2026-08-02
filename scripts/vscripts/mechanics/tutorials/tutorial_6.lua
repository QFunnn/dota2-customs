--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/tutorials/tutorial_6"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringEndsWith
local f = {}
local g = require("mechanics.tutorials.tutorial_base")
local h = g.TutorialBase
f.tutorial_6 = c()
local i = f.tutorial_6
i.name = "tutorial_6"
d(i, h)
function i.prototype.spawn(self)
	h.prototype.spawn(self)
	print(self.constructor.name, "spawned")
	local j = self:GetRoom()
	local k = j:GetSpawnGroup()
	local l = Entities:FindAllByClassname("info_target")
	local m
	for n, o in ipairs(l) do
		if o:GetSpawnGroupHandle() == k and e(o:GetName(), "info_boss_spawn") then
			m = o
			break
		end
	end
	local p = m and m:GetAbsOrigin() or j:GetPosition()
	self:ShowPing("Battle", p, 3)
	self:AddTutorialUpper("Text", "tutorial_6_1_upper", 3)
	GameModeTutorial:SetTutorialTask("tutorial_6", { { key = "tutorial_6_1", text = "tutorial_6_1", success = false } })
	self:RegisterEvent("dungeon_room_open_gates", function(n, q)
		if q.room ~= self:GetRoom() then
			return
		end
		GameModeTutorial:FinishTutorialTask("tutorial_6_1")
		self:GameTimer(3, function()
			self:AddTutorialUpper("Text", "tutorial_6_2_upper", 3, function()
				local r = GameModeTutorial:OpenTutorialExitGates()
				if r ~= nil then
					self:ShowPing("Tips", r)
				end
				self:Complete()
			end, function()
				GameModeTutorial:SendCameraFollowHero()
			end)
		end)
	end)
end
function i.prototype.Activate(self)
	h.prototype.Activate(self)
end
return f