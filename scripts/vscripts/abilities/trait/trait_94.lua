--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_94"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__StringSplit
local g = b.__TS__StringIncludes
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 2,
		["11"] = 2,
		["12"] = 2,
		["13"] = 3,
		["14"] = 3,
		["15"] = 3,
		["16"] = 6,
		["17"] = 7,
		["18"] = 6,
		["19"] = 7,
		["20"] = 8,
		["21"] = 9,
		["22"] = 8,
		["23"] = 7,
		["24"] = 6,
		["25"] = 7,
		["27"] = 7,
		["28"] = 13,
		["29"] = 20,
		["30"] = 13,
		["31"] = 20,
		["32"] = 22,
		["33"] = 23,
		["34"] = 22,
		["35"] = 25,
		["36"] = 26,
		["37"] = 25,
		["38"] = 30,
		["39"] = 31,
		["40"] = 32,
		["41"] = 33,
		["42"] = 34,
		["45"] = 37,
		["46"] = 38,
		["47"] = 39,
		["48"] = 40,
		["49"] = 41,
		["50"] = 42,
		["51"] = 43,
		["54"] = 47,
		["55"] = 48,
		["56"] = 49,
		["58"] = 51,
		["59"] = 52,
		["60"] = 53,
		["61"] = 54,
		["62"] = 55,
		["64"] = 56,
		["65"] = 56,
		["66"] = 57,
		["67"] = 58,
		["70"] = 56,
		["73"] = 62,
		["74"] = 63,
		["75"] = 64,
		["76"] = 64,
		["77"] = 64,
		["78"] = 64,
		["79"] = 64,
		["80"] = 64,
		["81"] = 64,
		["82"] = 64,
		["83"] = 69,
		["84"] = 69,
		["85"] = 69,
		["86"] = 69,
		["87"] = 69,
		["91"] = 30,
		["92"] = 20,
		["93"] = 13,
		["94"] = 13,
		["95"] = 13,
		["96"] = 13,
		["97"] = 13,
		["98"] = 13,
		["99"] = 13,
		["100"] = 20,
		["102"] = 20,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseAbility
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
i.trait_94 = c()
local p = i.trait_94
p.name = "trait_94"
d(p, k)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_94"
end
p = e({ l(nil) }, p)
i.trait_94 = p
i.modifier_trait_94 = c()
local q = i.modifier_trait_94
q.name = "modifier_trait_94"
d(q, n)
function q.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 } }
end
function q.prototype.OnBattleEnd(self, r)
	local s = ""
	local t = self:GetParent():GetPlayerOwnerID()
	local u = r.illusionPlayerID == t
	if u or r.winPlayerID ~= t then
		return
	end
	local v = PlayerData:getplayerData(t)
	if v and v.heroName then
		local w
		if r.isNeutral ~= nil then
			local x = GameState:getState()
			if x:getStateName() == "GameState_Neutral" then
				w = x.neutralName
			end
		else
			local y = r.losePlayerID
			local z = PlayerData:getplayerData(y)
			w = z and z.heroName
		end
		if w then
			s = AbilityShop:GetRecommendSectByHeroName(w)
			local A = AbilityShop:GetRecommendSectByHeroName(v.heroName)
			local B = f(A, "|")
			local C = false
			do
				local D = 0
				while D < #B do
					if g(s, B[D + 1]) then
						C = true
						break
					end
					D = D + 1
				end
			end
			if C then
				PlayerData:modifyGold(t, self.gold)
				Notification:combatToPlayer(
					t,
					{
						message = "notify_bonus_gold",
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
						int_gold = self.gold,
					}
				)
				PlayerData:getplayerData(t)
					:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.gold)
			end
		end
	end
end
q = e(
	{ o(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
i.modifier_trait_94 = q
return i