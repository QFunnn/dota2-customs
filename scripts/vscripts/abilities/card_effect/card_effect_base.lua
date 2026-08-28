--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_base"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__SourceMapTraceBack
d(
	debug.getinfo(1).short_src,
	{
		["7"] = 3,
		["8"] = 3,
		["9"] = 3,
		["10"] = 12,
		["11"] = 10,
		["12"] = 13,
		["13"] = 14,
		["14"] = 15,
		["15"] = 16,
		["16"] = 17,
		["17"] = 18,
		["18"] = 12,
		["19"] = 20,
		["20"] = 20,
		["21"] = 22,
		["22"] = 22,
		["23"] = 24,
		["24"] = 25,
		["25"] = 26,
		["26"] = 27,
		["28"] = 29,
		["30"] = 32,
		["31"] = 33,
		["32"] = 34,
		["33"] = 35,
		["35"] = 37,
		["36"] = 37,
		["37"] = 38,
		["38"] = 39,
		["40"] = 24,
		["41"] = 43,
		["42"] = 44,
		["43"] = 45,
		["44"] = 43,
		["45"] = 48,
		["46"] = 49,
		["47"] = 48,
		["48"] = 52,
		["49"] = 52,
		["50"] = 52,
		["52"] = 53,
		["53"] = 54,
		["54"] = 55,
		["56"] = 57,
		["57"] = 52,
		["58"] = 60,
		["59"] = 61,
		["60"] = 60,
		["61"] = 63,
		["62"] = 64,
		["63"] = 63,
		["64"] = 66,
		["65"] = 68,
		["66"] = 69,
		["67"] = 70,
		["68"] = 66,
		["69"] = 72,
		["70"] = 73,
		["71"] = 74,
		["73"] = 72,
		["74"] = 77,
		["75"] = 78,
		["76"] = 78,
		["78"] = 78,
		["80"] = 78,
		["81"] = 78,
		["82"] = 78,
		["84"] = 78,
		["85"] = 77,
		["86"] = 80,
		["87"] = 80,
	}
)
local e = {}
e.CardEffectBase = c()
local f = e.CardEffectBase
f.name = "CardEffectBase"
function f.prototype.____constructor(self, g, h)
	self._stackCount = 0
	self.cardName = h
	self.playerID = g
	self.modifierEventIDList = {}
	self.kv = KeyValues.CardEffectKV[h]
	self.type = self.kv.CardType
	self.round = Rounds:getCurrentRound()
end
function f.prototype.spawn(self) end
function f.prototype.stacking(self) end
function f.prototype.dispose(self)
	if self.modifierEventIDList then
		for i, j in pairs(self.modifierEventIDList) do
			RemoveModifierEvent(j, i)
		end
		self.modifierEventIDList = {}
	end
	local k = "modifier_" .. self.cardName
	local l = PlayerResource:GetSelectedHeroEntity(self.playerID)
	if IsValid(l) then
		l:RemoveModifierByName(k)
	end
	local m = PlayerData:getHero(self.playerID)
	local n = m and m.hero
	if IsValid(n) then
		n:RemoveModifierByName(k)
	end
end
function f.prototype._stackBase(self)
	self._stackCount = self._stackCount + 1
	self:stacking()
end
function f.prototype.GetStackCount(self)
	return self._stackCount
end
function f.prototype.PRD(self, o, p)
	if p == nil then
		p = self.cardName
	end
	local q = PlayerResource:GetSelectedHeroEntity(self.playerID)
	if q == nil then
		return RollPercentage(o)
	end
	return PRD(q, o, p)
end
function f.prototype.getPlayerID(self)
	return self.playerID
end
function f.prototype.getType(self)
	return self.type
end
function f.prototype.ModifierEvent(self, r, s)
	local i = ModifierEvent(r, s, self)
	self.modifierEventIDList[i] = r
	return i
end
function f.prototype.RemoveModifierEvent(self, i)
	if self.modifierEventIDList[i] ~= nil then
		RemoveModifierEvent(self.modifierEventIDList[i], i)
	end
end
function f.prototype.getSpecialValueFor(self, j)
	local t = self.kv
	local u = t and t.AbilityValues
	if u ~= nil then
		u = u[j]
	end
	local v = u
	if v == nil then
		v = 0
	end
	return v
end
function f.prototype.addProperty(self, w, x) end
return e