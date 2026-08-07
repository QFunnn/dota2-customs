--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/tutorials/tutorial_4"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Delete
local f = b.__TS__ArrayForEach
local g = {}
local h = require("mechanics.tutorials.tutorial_base")
local i = h.TutorialBase
g.tutorial_4 = c()
local j = g.tutorial_4
j.name = "tutorial_4"
d(j, i)
function j.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.enemyList = {}
end
function j.prototype.spawn(self)
	i.prototype.spawn(self)
	local k = self:GetHero()
end
function j.prototype.Activate(self)
	i.prototype.Activate(self)
	local l = self:GetRoom()
	self:AddTutorialUpper("Text", "tutorial_4_0_upper", 3, nil, function()
		self:GameTimer(1, function()
			self:CustomWave()
		end)
	end)
	self:RegisterEvent("entity_killed", function(m, n)
		local o = n.victim
		if #self.enemyList > 0 then
			ArrayRemove(self.enemyList, o)
			if #self.enemyList == 0 and self.task_key then
				GameModeTutorial:FinishTutorialTask(self.task_key)
				if self.task_key == "tutorial_4_1" then
					self:GetRoom():OpenGates()
					return
				end
				self:GameTimer(1, function()
					return self:CustomWave()
				end)
			end
		end
	end)
	self:RegisterEvent("dungeon_room_open_gates", function(m, n)
		if n.room ~= self:GetRoom() then
			return
		end
		self:AddTutorialUpper("Text", "tutorial_3_upper", 3, function()
			local p = GameModeTutorial:OpenTutorialExitGates()
			if p ~= nil then
				self:ShowPing("Tips", p)
			end
			self:Complete()
		end, function()
			GameModeTutorial:SendCameraFollowHero()
		end)
	end)
end
function j.prototype.CustomWave(self)
	local l = self:GetRoom()
	local q = l:GetPosition()
	q.y = q.y + 384
	if self.task_key == nil then
		self.task_key = "tutorial_4_1"
		q.y = q.y - 400
		self.enemyList = l:CreateEnemyForTutorial("skeleton_minion", 4, q)
		GameModeTutorial:SetTutorialTask(
			"tutorial_4",
			{
				{ key = "tutorial_4_1", text = "tutorial_4_1", success = false },
				{ key = "tutorial_4_2", text = "tutorial_4_2", success = false },
				{ key = "tutorial_4_3", text = "tutorial_4_3", success = false },
			}
		)
	elseif self.task_key == "tutorial_4_1" then
		self.task_key = "tutorial_4_2"
		self.enemyList = l:CreateEnemyForTutorial("skeleton_mage", 2, q)
		self.attackLisnter = Event:Register("attack_event", function(m, n)
			if n.attacker:GetTeamNumber() ~= DOTA_TEAM_BADGUYS then
				return
			end
			if n.attacker:GetUnitName() == "skeleton_mage" then
				if self.attackLisnter then
					Event:Unregister(self.attackLisnter)
					e(self, "attackLisnter")
				end
				self:ShowPing("warning", n.attacker)
				self:GameTimer(0.2, function()
					self.dodge_listener = self:RegisterEvent("ability_cast_complete", function(m, n)
						if n.caster ~= self:GetHero() then
							return
						end
						if n.ability:GetAbilityTag() ~= AbilityTag.Dodge then
							return
						end
						if self.dodge_upper_id then
							GameModeTutorial:CloseTutorialUpper(self.dodge_upper_id)
							self.dodge_upper_id = nil
							if self.dodge_listener then
								self:UnregisterEvent(self.dodge_listener)
								self.dodge_listener = nil
							end
						end
					end)
					self.dodge_upper_id =
						self:AddTutorialUpper("Ability", "tutorial_4_2_upper", 5, nil, nil, 0.2, AbilityTag.Dodge)
				end)
			end
		end)
	elseif self.task_key == "tutorial_4_2" then
		self.task_key = "tutorial_4_3"
		self.enemyList = l:CreateEnemyForTutorial("skeleton_spear", 1, q, true)
		local r = self.enemyList[1]
		self:GameTimer(1, function()
			self:AddTutorialUpper("Text", "tutorial_4_4_upper", 5, function()
				if IsValid(r) then
					self:ShowPing("warning", r)
				end
			end, function() end)
		end)
	end
end
function j.prototype.dispose(self)
	i.prototype.dispose(self)
	if self.attackLisnter then
		Event:Unregister(self.attackLisnter)
		e(self, "attackLisnter")
	end
	if #self.enemyList > 0 then
		f(self.enemyList, function(m, s)
			return s:SafeRemoveUnit()
		end)
	end
	self.enemyList = {}
end
return g