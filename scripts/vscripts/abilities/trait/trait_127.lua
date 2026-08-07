--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_127"
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
		["30"] = 24,
		["31"] = 25,
		["32"] = 26,
		["33"] = 27,
		["34"] = 28,
		["35"] = 29,
		["37"] = 24,
		["38"] = 32,
		["39"] = 33,
		["40"] = 32,
		["41"] = 37,
		["42"] = 38,
		["45"] = 39,
		["46"] = 40,
		["47"] = 41,
		["48"] = 42,
		["49"] = 43,
		["50"] = 44,
		["51"] = 44,
		["52"] = 45,
		["53"] = 45,
		["54"] = 46,
		["55"] = 47,
		["56"] = 48,
		["58"] = 50,
		["59"] = 51,
		["60"] = 51,
		["61"] = 51,
		["62"] = 51,
		["63"] = 51,
		["64"] = 51,
		["65"] = 51,
		["66"] = 51,
		["67"] = 56,
		["68"] = 56,
		["69"] = 56,
		["70"] = 56,
		["71"] = 56,
		["74"] = 37,
		["75"] = 19,
		["76"] = 12,
		["77"] = 12,
		["78"] = 12,
		["79"] = 12,
		["80"] = 12,
		["81"] = 12,
		["82"] = 12,
		["83"] = 19,
		["85"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_127 = c()
local n = g.trait_127
n.name = "trait_127"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_127"
end
n = e({ j(nil) }, n)
g.trait_127 = n
g.modifier_trait_127 = c()
local o = g.modifier_trait_127
o.name = "modifier_trait_127"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.win = self:GetAbilitySpecialValueFor("win")
	self.base_gold = self:GetAbilitySpecialValueFor("base_gold")
	self.bonus_gold = self:GetAbilitySpecialValueFor("bonus_gold")
	if IsServer() then
		self.record = 0
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 } }
end
function o.prototype.OnBattleEnd(self, p)
	if p.isNeutral then
		return
	end
	local q = self:GetCaster():GetPlayerOwnerID()
	if p.illusionPlayerID ~= q and p.winPlayerID == q then
		self.record = self.record + 1
		if self.record >= self.win then
			self.record = 0
			local r = PlayerData:getplayerData(q)
			local s = r and r.health or 0
			local t = PlayerData:getplayerData(p.losePlayerID)
			local u = t and t.health or 0
			local v = self.base_gold
			if s <= u then
				v = self.bonus_gold
			end
			PlayerData:modifyGold(q, v)
			Notification:combatToPlayer(
				q,
				{
					message = "notify_bonus_gold",
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
					int_gold = v,
				}
			)
			PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", v)
		end
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_127 = o
return g