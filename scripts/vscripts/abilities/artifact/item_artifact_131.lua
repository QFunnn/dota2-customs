--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_131"
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
		["27"] = 19,
		["28"] = 11,
		["29"] = 19,
		["30"] = 23,
		["31"] = 24,
		["32"] = 25,
		["33"] = 23,
		["34"] = 28,
		["35"] = 29,
		["36"] = 30,
		["37"] = 30,
		["38"] = 30,
		["39"] = 30,
		["41"] = 28,
		["42"] = 34,
		["43"] = 35,
		["44"] = 34,
		["45"] = 40,
		["46"] = 41,
		["49"] = 42,
		["50"] = 43,
		["51"] = 44,
		["52"] = 45,
		["55"] = 46,
		["56"] = 47,
		["57"] = 47,
		["58"] = 47,
		["59"] = 47,
		["60"] = 47,
		["61"] = 48,
		["62"] = 48,
		["63"] = 48,
		["64"] = 48,
		["65"] = 48,
		["66"] = 48,
		["67"] = 48,
		["68"] = 48,
		["69"] = 40,
		["70"] = 55,
		["71"] = 56,
		["72"] = 57,
		["73"] = 57,
		["74"] = 57,
		["75"] = 57,
		["77"] = 55,
		["78"] = 19,
		["79"] = 11,
		["80"] = 11,
		["81"] = 11,
		["82"] = 11,
		["83"] = 11,
		["84"] = 11,
		["85"] = 11,
		["86"] = 11,
		["87"] = 19,
		["89"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_131 = c()
local n = g.item_artifact_131
n.name = "item_artifact_131"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_131"
end
n = e({ j(nil) }, n)
g.item_artifact_131 = n
g.modifier_item_artifact_131 = c()
local o = g.modifier_item_artifact_131
o.name = "modifier_item_artifact_131"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
	self.refresh_gold_bonus = self:GetAbilitySpecialValueFor("refresh_gold_bonus")
end
function o.prototype.OnCreated(self)
	if IsServer() then
		PlayerData:setRefreshGoldCost(self:GetParent():GetPlayerOwnerID(), self.refresh_gold_bonus)
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function o.prototype.OnRoundStart(self)
	if not IsServer() then
		return
	end
	local p = self:GetParent():GetPlayerOwnerID()
	local q = PlayerData:getplayerData(p)
	local r = self:GetAbility()
	if not q or not r then
		return
	end
	PlayerData:modifyGold(p, self.gold)
	q:modifyArtifactExtraData(r:entindex(), "bonus_gold", self.gold)
	Notification:combatToPlayer(
		p,
		{
			message = "notify_bonus_gold",
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. r:GetAbilityName(),
			int_gold = self.gold,
		}
	)
end
function o.prototype.OnDestroy(self)
	if IsServer() then
		PlayerData:setRefreshGoldCost(self:GetParent():GetPlayerOwnerID(), -self.refresh_gold_bonus)
	end
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
			}
		),
	},
	o
)
g.modifier_item_artifact_131 = o
return g