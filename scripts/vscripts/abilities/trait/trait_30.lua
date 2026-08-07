--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_30"
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
		["30"] = 26,
		["31"] = 27,
		["32"] = 28,
		["33"] = 29,
		["34"] = 30,
		["35"] = 31,
		["36"] = 32,
		["37"] = 26,
		["38"] = 34,
		["39"] = 35,
		["40"] = 36,
		["42"] = 34,
		["43"] = 39,
		["44"] = 40,
		["45"] = 41,
		["46"] = 42,
		["47"] = 44,
		["48"] = 45,
		["49"] = 46,
		["50"] = 47,
		["51"] = 47,
		["52"] = 47,
		["53"] = 47,
		["54"] = 47,
		["55"] = 47,
		["56"] = 47,
		["57"] = 47,
		["58"] = 52,
		["59"] = 52,
		["60"] = 52,
		["61"] = 52,
		["62"] = 52,
		["63"] = 53,
		["66"] = 39,
		["67"] = 58,
		["68"] = 59,
		["69"] = 58,
		["70"] = 63,
		["71"] = 64,
		["72"] = 63,
		["73"] = 66,
		["74"] = 67,
		["75"] = 66,
		["76"] = 19,
		["77"] = 12,
		["78"] = 12,
		["79"] = 12,
		["80"] = 12,
		["81"] = 12,
		["82"] = 12,
		["83"] = 12,
		["84"] = 19,
		["86"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_30 = c()
local n = g.trait_30
n.name = "trait_30"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_30"
end
n = e({ j(nil) }, n)
g.trait_30 = n
g.modifier_trait_30 = c()
local o = g.modifier_trait_30
o.name = "modifier_trait_30"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
	self.gold_reduce = self:GetAbilitySpecialValueFor("gold_reduce")
	self.gold1 = self:GetAbilitySpecialValueFor("gold1")
	self.gold2 = self:GetAbilitySpecialValueFor("gold2")
	self.gold3 = self:GetAbilitySpecialValueFor("gold3")
	self.gold4 = self:GetAbilitySpecialValueFor("gold4")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self:SetStackCount(self.round)
	end
end
function o.prototype.OnStackCountChanged(self, q)
	if IsServer() then
		if self:GetStackCount() == self.round then
			local r = self:GetParent():GetPlayerOwnerID()
			local s = { self.gold1, self.gold2, self.gold3, self.gold4 }
			local t = s[RandomInt(0, #s - 1) + 1]
			PlayerData:modifyGold(r, t)
			Notification:combatToPlayer(
				r,
				{
					message = "notify_bonus_gold",
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
					int_gold = t,
				}
			)
			PlayerData:getplayerData(r):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", t)
			self:SetStackCount(0)
		end
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 } }
end
function o.prototype.OnRoundChange(self, p)
	self:IncrementStackCount()
end
function o.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_WAGES] = -self.gold_reduce }
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_30 = o
return g