--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "mechanics/tutorials/tutorial_5"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayReduce
local f = {}
local g = require("mechanics.tutorials.tutorial_base")
local h = g.TutorialBase
f.tutorial_5 = c()
local i = f.tutorial_5
i.name = "tutorial_5"
d(i, h)
function i.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.upperConfig = { tutorial_5_1_upper = { type = "TEXT", duration = 3 }, tutorial_5_2_upper = {
		type = "INTERACT",
		duration = 3,
	} }
	self.tips = { "tutorial_5_1_upper", "tutorial_5_2_upper" }
	self.index = 0
	self.exitStarted = false
end
function i.prototype.spawn(self)
	h.prototype.spawn(self)
	self:ShowNextTips()
end
function i.prototype.Activate(self)
	h.prototype.Activate(self)
	local j = self:GetRoom()
	local k = j:GetShopItems()
	if #k > 0 then
		local l = e(k, function(m, n, o)
			return n + o.position.y
		end, 0) / #k
		local p = j:GetPosition()
		p.y = l
		GameModeTutorial:SendCameraFollowPosition(p)
	end
	self:RegisterEvent("shop_item_purchased", function(m, q)
		if q.playerID ~= self:GetPlayerID() or self.exitStarted then
			return
		end
		self.exitStarted = true
		local r = GameModeTutorial:OpenTutorialExitGates()
		if r then
			self:ShowPing("Tips", r)
		end
		self:AddTutorialUpper("Text", "tutorial_5_4_upper", 3, function()
			self:Complete()
		end, function()
			GameModeTutorial:SendCameraFollowHero()
		end)
	end)
end
function i.prototype.ShowNextTips(self)
	local s = self.tips[self.index + 1]
	if not s or not self.upperConfig[s] then
		GameModeTutorial:SendCameraFollowHero()
		local j = self:GetRoom()
		j:OpenGates()
		return
	end
	local t = self.upperConfig[s]
	local function u()
		self.index = self.index + 1
		if self.index == 2 then
			local k = self:GetRoom():GetShopItems()
			do
				local v = 0
				while v < #k do
					self:ShowPing("Tips", k[v + 1].position)
					v = v + 1
				end
			end
		end
	end
	local function w()
		self:GameTimer(1, function()
			self:ShowNextTips()
		end)
	end
	if t.type == "INTERACT" then
		self:AddTutorialUpper("Interact", s, t.duration, u, w)
	else
		self:AddTutorialUpper("Text", s, t.duration, u, w)
	end
end
return f