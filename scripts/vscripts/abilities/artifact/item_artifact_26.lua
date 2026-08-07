--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_26"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 4,
		["16"] = 5,
		["17"] = 4,
		["18"] = 5,
		["19"] = 6,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 4,
		["24"] = 5,
		["26"] = 5,
		["27"] = 11,
		["28"] = 19,
		["29"] = 11,
		["30"] = 19,
		["31"] = 22,
		["32"] = 23,
		["33"] = 22,
		["34"] = 43,
		["35"] = 44,
		["36"] = 43,
		["37"] = 48,
		["38"] = 49,
		["41"] = 50,
		["42"] = 51,
		["45"] = 52,
		["46"] = 53,
		["47"] = 56,
		["48"] = 57,
		["49"] = 58,
		["50"] = 58,
		["51"] = 58,
		["52"] = 58,
		["53"] = 58,
		["54"] = 58,
		["55"] = 58,
		["56"] = 59,
		["57"] = 60,
		["58"] = 65,
		["59"] = 65,
		["60"] = 65,
		["61"] = 65,
		["62"] = 65,
		["63"] = 58,
		["64"] = 58,
		["67"] = 48,
		["68"] = 19,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 19,
		["79"] = 19,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseItem
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.item_artifact_26 = c()
local o = h.item_artifact_26
o.name = "item_artifact_26"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_26"
end
o = e({ k(nil) }, o)
h.item_artifact_26 = o
h.modifier_item_artifact_26 = c()
local p = h.modifier_item_artifact_26
p.name = "modifier_item_artifact_26"
d(p, m)
function p.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 } }
end
function p.prototype.OnBattleEnd(self, q)
	if q.isNeutral then
		return
	end
	local r = self:GetParent():GetPlayerOwnerID()
	if q.illusionPlayerID ~= nil and q.illusionPlayerID == r then
		return
	end
	if r == q.winPlayerID then
		local s = AbilityShop:getRandomAbility(r, self.count, { isAbilityShop = false })
		local t = PlayerData:getHero(r)
		if t then
			f(s, function(u, v, w)
				local x
				local y
				y = v.aid
				x = v.rarity
				t:learnAbility(y, true)
				Notification:combatToPlayer(
					r,
					{
						message = "notify_artifact_ability_" .. x,
						string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_26",
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. y,
					}
				)
				PlayerData:getplayerData(r):addArtifactAbilities(self:GetAbility():entindex(), y, w == #s - 1)
			end)
		end
	end
end
p = e(
	{
		n(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	p
)
h.modifier_item_artifact_26 = p
return h