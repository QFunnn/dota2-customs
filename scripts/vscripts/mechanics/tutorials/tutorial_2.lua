--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/tutorials/tutorial_2"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayIndexOf
local f = b.__TS__ArrayIncludes
local g = {}
local h = require("mechanics.tutorials.tutorial_base")
local i = h.TutorialBase
g.tutorial_2 = c()
local j = g.tutorial_2
j.name = "tutorial_2"
d(j, i)
function j.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.dummyList = {}
	self.flow_ability =
		{ AbilityTag.Attack, AbilityTag.Skill, AbilityTag.Dodge, AbilityTag.Defense, AbilityTag.Ultimate }
	self.completedAbilityTags = {}
end
function j.prototype.Activate(self)
	local k = self:GetHero()
	self:AddTutorialUpper("Text", "tutorial_2_upper", 3, nil, function()
		self:RefreshHeroAbilities()
		GameModeTutorial:SetTutorialTask(
			"tutorial_2_1_upper",
			{
				{ key = "tutorial_2_1", text = "tutorial_2_1", ability = AbilityTag.Attack, success = false },
				{ key = "tutorial_2_2", text = "tutorial_2_2", ability = AbilityTag.Skill, success = false },
				{ key = "tutorial_2_3", text = "tutorial_2_3", ability = AbilityTag.Dodge, success = false },
				{ key = "tutorial_2_4", text = "tutorial_2_4", ability = AbilityTag.Defense, success = false },
				{ key = "tutorial_2_5", text = "tutorial_2_5", ability = AbilityTag.Ultimate, success = false },
			}
		)
		self.eventID = Event:Register("ability_cast_complete", function(l, m)
			if m.caster ~= k then
				return
			end
			local n = e(self.flow_ability, m.abilityTag)
			if n == -1 or f(self.completedAbilityTags, m.abilityTag) then
				return
			end
			local o = self.completedAbilityTags
			o[#o + 1] = m.abilityTag
			GameModeTutorial:FinishTutorialTask("tutorial_2_" .. tostring(n + 1))
			self:RefreshHeroAbilities()
			if #self.completedAbilityTags == #self.flow_ability then
				self:Complete()
			end
		end, self)
	end)
	local p = self:GetRoom():GetPosition()
	local q = { Vector(0, 300, 0), Vector(259, -150, 0), Vector(-259, -150, 0) }
	do
		local r = 0
		while r < #q do
			local s = q[r + 1]
			local t = CreateUnitByName("demo_dummy", p + s, false, nil, nil, DOTA_TEAM_BADGUYS)
			t:AddNewModifier(t, nil, "modifier_spawn_skeleton", nil)
			t:SetForwardVector(vec3_bottom)
			local u = self.dummyList
			u[#u + 1] = t
			r = r + 1
		end
	end
end
function j.prototype.RefreshHeroAbilities(self)
	local k = self:GetHero()
	do
		local r = 0
		while r < k:GetAbilityCount() do
			local v = k:GetAbilityByIndex(r)
			if v ~= nil then
				v:EndCooldown()
				v:RestoreCharges(10)
			end
			r = r + 1
		end
	end
	k:SetMana(k:GetMaxMana())
end
function j.prototype.dispose(self)
	i.prototype.dispose(self)
	if self.eventID ~= nil then
		Event:Unregister(self.eventID)
		self.eventID = nil
	end
	do
		local r = 0
		while r < #self.dummyList do
			local t = self.dummyList[r + 1]
			if IsValid(t) then
				t:RemoveSelf()
			end
			r = r + 1
		end
	end
	self.dummyList = {}
end
return g