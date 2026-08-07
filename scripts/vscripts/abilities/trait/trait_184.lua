--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_184"
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
		["19"] = 6,
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 9,
		["27"] = 16,
		["28"] = 9,
		["29"] = 16,
		["31"] = 16,
		["32"] = 19,
		["33"] = 9,
		["34"] = 20,
		["35"] = 21,
		["36"] = 22,
		["37"] = 20,
		["38"] = 24,
		["39"] = 25,
		["40"] = 26,
		["41"] = 26,
		["42"] = 26,
		["43"] = 25,
		["44"] = 25,
		["45"] = 25,
		["46"] = 24,
		["47"] = 30,
		["48"] = 31,
		["49"] = 30,
		["50"] = 33,
		["51"] = 34,
		["54"] = 37,
		["55"] = 38,
		["56"] = 39,
		["57"] = 40,
		["58"] = 41,
		["59"] = 41,
		["60"] = 41,
		["61"] = 41,
		["62"] = 41,
		["63"] = 42,
		["64"] = 43,
		["65"] = 43,
		["66"] = 43,
		["67"] = 43,
		["68"] = 43,
		["69"] = 43,
		["70"] = 43,
		["71"] = 43,
		["73"] = 49,
		["74"] = 33,
		["75"] = 16,
		["76"] = 9,
		["77"] = 9,
		["78"] = 9,
		["79"] = 9,
		["80"] = 9,
		["81"] = 9,
		["82"] = 9,
		["83"] = 16,
		["85"] = 16,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_184 = c()
local n = g.trait_184
n.name = "trait_184"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_184"
end
n = e({ j(nil) }, n)
g.trait_184 = n
g.modifier_trait_184 = c()
local o = g.modifier_trait_184
o.name = "modifier_trait_184"
d(o, l)
function o.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.purchasedThisRound = false
end
function o.prototype.GetAbilitySpecialValue(self)
	self.refreshCount = self:GetAbilitySpecialValueFor("refresh_count")
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 },
	}
end
function o.prototype.OnAbilityBuy(self)
	self.purchasedThisRound = true
end
function o.prototype.OnRoundChange(self)
	if not IsServer() then
		return
	end
	if not self.purchasedThisRound then
		local p = self:GetParent():GetPlayerOwnerID()
		PlayerData:ModifyFreeRefresh(p, self.refreshCount)
		PlayerData:ModifyFreeRefreshByKey(p, "trait_184", self.refreshCount)
		PlayerData:getplayerData(p)
			:modifyArtifactExtraData(self:GetAbility():entindex(), "AbilityFreeRefreshCount", self.refreshCount)
		PlayerData:modifyGold(p, self.gold)
		Notification:combatToPlayer(
			p,
			{
				message = "notify_bonus_gold",
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
				int_gold = self.gold,
			}
		)
	end
	self.purchasedThisRound = false
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_184 = o
return g