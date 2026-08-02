--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_34"
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
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 12,
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["30"] = 22,
		["31"] = 23,
		["32"] = 24,
		["33"] = 25,
		["35"] = 22,
		["36"] = 29,
		["37"] = 30,
		["38"] = 30,
		["39"] = 30,
		["40"] = 30,
		["41"] = 29,
		["42"] = 35,
		["43"] = 36,
		["44"] = 35,
		["45"] = 39,
		["46"] = 40,
		["47"] = 41,
		["48"] = 42,
		["49"] = 43,
		["50"] = 44,
		["51"] = 45,
		["52"] = 46,
		["53"] = 46,
		["55"] = 47,
		["56"] = 47,
		["57"] = 47,
		["58"] = 47,
		["59"] = 47,
		["60"] = 47,
		["61"] = 47,
		["62"] = 47,
		["63"] = 47,
		["65"] = 39,
		["66"] = 19,
		["67"] = 12,
		["68"] = 12,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 12,
		["74"] = 19,
		["76"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_34 = c()
local n = g.trait_34
n.name = "trait_34"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_34"
end
n = e({ j(nil) }, n)
g.trait_34 = n
g.modifier_trait_34 = c()
local o = g.modifier_trait_34
o.name = "modifier_trait_34"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.exp = self:GetAbilitySpecialValueFor("exp")
	if IsServer() then
		self.enable = true
	end
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 },
	}
end
function o.prototype.OnRoundChange(self, p)
	self.enable = true
end
function o.prototype.OnAbilityBuy(self, p)
	if self.enable then
		self.enable = false
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:getHero(q)
		local s = GetRandomElement(AbilityShop.pickList)
		local t = self.exp
		if r ~= nil then
			r:addSectExp(s, t)
		end
		Notification:combatToPlayer(
			q,
			{
				message = "notify_artifact_48",
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
				string_sect = "DOTA_Tooltip_ability_" .. s,
				int_exp = t,
			}
		)
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_34 = o
return g