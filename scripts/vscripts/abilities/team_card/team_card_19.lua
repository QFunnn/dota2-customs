--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/team_card/team_card_19"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFilter
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 3,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 7,
		["18"] = 8,
		["19"] = 8,
		["20"] = 8,
		["21"] = 8,
		["22"] = 7,
		["23"] = 10,
		["24"] = 11,
		["25"] = 12,
		["26"] = 13,
		["27"] = 14,
		["28"] = 15,
		["29"] = 16,
		["30"] = 17,
		["31"] = 17,
		["32"] = 17,
		["33"] = 17,
		["35"] = 19,
		["37"] = 21,
		["38"] = 21,
		["39"] = 21,
		["40"] = 21,
		["43"] = 10,
	}
)
local g = {}
local h = require("abilities.card_effect.card_effect_base")
local i = h.CardEffectBase
g.team_card_19 = c()
local j = g.team_card_19
j.name = "team_card_19"
d(j, i)
function j.prototype.stacking(self)
	TeamCard:DrawAttributeForPlayer(self:getPlayerID())
end
function j.prototype.spawn(self)
	self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_DRAW_ATTRIBUTE, function(k, ...)
		return self:OnDrawAttribute(...)
	end)
end
function j.prototype.OnDrawAttribute(self, l, m)
	if m == self:getPlayerID() then
		local n = PlayerData:getplayerData(m)
		if n then
			local o = n.hero
			local p = {}
			if n.bannedSect ~= nil then
				p = e(AbilityShop.pickList, function(k, q)
					return n.bannedSect
				end)
			else
				p = shallowcopy(AbilityShop.pickList)
			end
			o:addSectExp(GetRandomElement(p), self:GetStackCount() * self:getSpecialValueFor("exp"))
		end
	end
end
return g