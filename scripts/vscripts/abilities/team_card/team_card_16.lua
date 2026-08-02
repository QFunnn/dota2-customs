--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/team_card/team_card_16"
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
		["14"] = 6,
		["15"] = 7,
		["17"] = 9,
		["18"] = 10,
		["19"] = 10,
		["20"] = 10,
		["21"] = 10,
		["22"] = 5,
		["23"] = 12,
		["24"] = 13,
		["25"] = 14,
		["27"] = 12,
		["28"] = 17,
		["29"] = 18,
		["30"] = 18,
		["31"] = 18,
		["33"] = 18,
		["34"] = 19,
		["35"] = 19,
		["36"] = 19,
		["38"] = 19,
		["39"] = 20,
		["40"] = 21,
		["41"] = 22,
		["42"] = 23,
		["43"] = 24,
		["44"] = 26,
		["45"] = 27,
		["46"] = 28,
		["47"] = 30,
		["48"] = 31,
		["49"] = 32,
		["50"] = 34,
		["51"] = 35,
		["52"] = 36,
		["54"] = 17,
		["55"] = 39,
		["56"] = 40,
		["57"] = 41,
		["58"] = 42,
		["59"] = 43,
		["60"] = 44,
		["61"] = 45,
		["62"] = 46,
		["64"] = 39,
		["65"] = 49,
		["66"] = 50,
		["67"] = 51,
		["69"] = 52,
		["70"] = 52,
		["71"] = 53,
		["72"] = 54,
		["73"] = 55,
		["74"] = 52,
		["77"] = 57,
		["78"] = 57,
		["79"] = 57,
		["80"] = 57,
		["81"] = 61,
		["82"] = 62,
		["83"] = 63,
		["84"] = 64,
		["85"] = 65,
		["86"] = 57,
		["87"] = 57,
		["88"] = 49,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.team_card_16 = c()
local i = f.team_card_16
i.name = "team_card_16"
d(i, h)
function i.prototype.spawn(self)
	if IsServer() then
		self:CheckCanGetEquipment()
	end
	TeamCard:DrawAttributeForPlayer(self:getPlayerID())
	self.id = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_DRAW_ATTRIBUTE, function(j, ...)
		return self:OnDrawAttribute(...)
	end)
end
function i.prototype.OnDrawAttribute(self, k, l)
	if l == self:getPlayerID() then
		self:CheckCanGetEquipment()
	end
end
function i.prototype.CheckCanGetEquipment(self)
	local m = PlayerData:loadData(self.playerID, "Draw_Attribute")
	if m == nil then
		m = 0
	end
	local n = m
	local o = PlayerData:loadData(self.playerID, "team_card_16_level")
	if o == nil then
		o = 0
	end
	local p = o
	local q = 0
	if p < 4 and n > self:getSpecialValueFor("level_three") then
		q = 4
		self:GetEquipment(q)
		self:RemoveModifierEvent(self.id)
	elseif p < 3 and n > self:getSpecialValueFor("level_two") then
		q = 3
		self:GetEquipment(q)
	elseif p < 2 and n > self:getSpecialValueFor("level_one") then
		q = 2
		self:GetEquipment(q)
	elseif p == 0 then
		q = 1
		self:GetEquipment(q)
	end
end
function i.prototype.ResetEquiment(self, l)
	local r = PlayerData:getplayerData(l)
	local s = r.hero.hero
	local t = 4
	local u = s:GetItemInSlot(t)
	if IsValid(u) then
		s:TakeItem(u)
		u:Remove()
	end
end
function i.prototype.GetEquipment(self, q)
	local v = PlayerData:getEquipmentPoolWithLevel(self.playerID, q, false)
	local w = {}
	do
		local x = 0
		while x < 3 do
			local u = v:random()
			v:remove(u)
			w[#w + 1] = u
			x = x + 1
		end
	end
	Selection:AddSpecialSelection(self.playerID, "equipment", w, function(j, y)
		self:ResetEquiment(self.playerID)
		PlayerData:getHero(self.playerID):addItemForPlayer(y, false, 4)
		PlayerData:saveData(self.playerID, "team_card_16_level", q)
		return true
	end)
end
return f