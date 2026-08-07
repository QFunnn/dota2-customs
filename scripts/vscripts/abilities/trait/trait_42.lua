--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_42"
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
		["30"] = 23,
		["31"] = 24,
		["32"] = 25,
		["33"] = 23,
		["34"] = 27,
		["35"] = 28,
		["36"] = 29,
		["37"] = 30,
		["39"] = 27,
		["40"] = 33,
		["41"] = 34,
		["42"] = 33,
		["43"] = 39,
		["44"] = 40,
		["45"] = 41,
		["46"] = 42,
		["47"] = 43,
		["49"] = 39,
		["50"] = 46,
		["51"] = 47,
		["54"] = 50,
		["57"] = 53,
		["58"] = 54,
		["59"] = 55,
		["60"] = 56,
		["61"] = 57,
		["62"] = 58,
		["63"] = 58,
		["64"] = 58,
		["65"] = 58,
		["66"] = 58,
		["67"] = 58,
		["68"] = 58,
		["69"] = 58,
		["70"] = 63,
		["71"] = 63,
		["72"] = 63,
		["73"] = 63,
		["74"] = 63,
		["76"] = 46,
		["77"] = 19,
		["78"] = 12,
		["79"] = 12,
		["80"] = 12,
		["81"] = 12,
		["82"] = 12,
		["83"] = 12,
		["84"] = 12,
		["85"] = 19,
		["87"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_42 = c()
local n = g.trait_42
n.name = "trait_42"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_42"
end
n = e({ j(nil) }, n)
g.trait_42 = n
g.modifier_trait_42 = c()
local o = g.modifier_trait_42
o.name = "modifier_trait_42"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self:SetStackCount(self.round)
		self.enable = true
	end
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 },
	}
end
function o.prototype.OnRoundChange(self, p)
	self:IncrementStackCount()
	if self:GetStackCount() >= self.round then
		self.enable = true
		self:SetStackCount(0)
	end
end
function o.prototype.OnBattleEnd(self, p)
	if p.isNeutral ~= nil then
		return
	end
	if not self.enable then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	if p.winPlayerID == q and p.illusionPlayerID ~= p.winPlayerID then
		self.enable = false
		self:SetStackCount(0)
		PlayerData:modifyGold(q, self.gold)
		Notification:combatToPlayer(
			q,
			{
				message = "notify_bonus_gold",
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
				int_gold = self.gold,
			}
		)
		PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.gold)
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_42 = o
return g