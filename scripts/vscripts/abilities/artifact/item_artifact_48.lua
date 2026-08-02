--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_48"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 11,
		["27"] = 20,
		["28"] = 11,
		["29"] = 20,
		["30"] = 22,
		["31"] = 23,
		["32"] = 22,
		["33"] = 25,
		["34"] = 26,
		["35"] = 25,
		["36"] = 40,
		["37"] = 41,
		["38"] = 42,
		["39"] = 43,
		["42"] = 44,
		["44"] = 44,
		["46"] = 45,
		["47"] = 40,
		["48"] = 20,
		["49"] = 11,
		["50"] = 11,
		["51"] = 11,
		["52"] = 11,
		["53"] = 11,
		["54"] = 11,
		["55"] = 11,
		["56"] = 11,
		["57"] = 11,
		["58"] = 20,
		["60"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_48 = c()
local n = g.item_artifact_48
n.name = "item_artifact_48"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_48"
end
n = e({ j(nil) }, n)
g.item_artifact_48 = n
g.modifier_item_artifact_48 = c()
local o = g.modifier_item_artifact_48
o.name = "modifier_item_artifact_48"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.exp = self:GetAbilitySpecialValueFor("exp")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function o.prototype.OnRoundStart(self)
	local p = self:GetParent():GetPlayerOwnerID()
	local q = GetRandomElement(AbilityShop.pickList)
	if not PlayerData:isAlivePlayer(p) then
		return
	end
	local r = PlayerData:getHero(p)
	if r ~= nil then
		r:addSectExp(q, self.exp)
	end
	Notification:combatToPlayer(
		p,
		{
			message = "notify_artifact_48",
			string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_48",
			string_sect = "DOTA_Tooltip_ability_" .. q,
			int_exp = self.exp,
		}
	)
end
o = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	o
)
g.modifier_item_artifact_48 = o
return g