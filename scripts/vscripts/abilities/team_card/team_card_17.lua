--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/team_card/team_card_17"
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
		["13"] = 4,
		["14"] = 5,
		["15"] = 6,
		["16"] = 6,
		["17"] = 6,
		["18"] = 6,
		["20"] = 8,
		["21"] = 8,
		["22"] = 8,
		["23"] = 8,
		["24"] = 8,
		["25"] = 8,
		["27"] = 8,
		["28"] = 9,
		["29"] = 4,
		["30"] = 11,
		["31"] = 12,
		["32"] = 13,
		["33"] = 14,
		["34"] = 14,
		["35"] = 14,
		["37"] = 14,
		["38"] = 15,
		["39"] = 16,
		["40"] = 17,
		["41"] = 18,
		["42"] = 20,
		["43"] = 21,
		["44"] = 22,
		["45"] = 23,
		["46"] = 24,
		["47"] = 25,
		["49"] = 31,
		["52"] = 11,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.team_card_17 = c()
local i = f.team_card_17
i.name = "team_card_17"
d(i, h)
function i.prototype.spawn(self)
	if not PlayerData:loadData(self.playerID, "team_card_17_count") then
		self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_DRAW_ATTRIBUTE, function(j, ...)
			return self:OnDrawAttribute(...)
		end)
	end
	local k = PlayerData
	local l = PlayerData.saveData
	local m = self.playerID
	local n = PlayerData:loadData(self.playerID, "team_card_17_count")
	if n == nil then
		n = 0
	end
	l(k, m, "team_card_17_count", n + 1)
	TeamCard:DrawAttributeForPlayer(self:getPlayerID())
end
function i.prototype.OnDrawAttribute(self, o, p)
	if p == self:getPlayerID() then
		local q = self:getSpecialValueFor("count")
		local r = PlayerData:loadData(self.playerID, "team_card_17_buy")
		if r == nil then
			r = 0
		end
		local s = r
		local t = PlayerData:loadData(self.playerID, "team_card_17_count")
		if t * q > s then
			s = s + 1
			if s % 3 == 0 then
				local p = self.playerID
				local u = PlayerData:getHero(p)
				local v = AbilityShop:getAbilityPoolNew("r", nil, AbilityShop.banList, false)
				local w = v:random()
				u:learnAbility(w, true)
				Notification:combatToPlayer(
					p,
					{
						message = "notify_artifact_ability_r",
						string_itemname_artifact = "DOTA_Tooltip_ability_team_card_17",
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. w,
					}
				)
			end
			PlayerData:saveData(self.playerID, "team_card_17_buy", s)
		end
	end
end
return f