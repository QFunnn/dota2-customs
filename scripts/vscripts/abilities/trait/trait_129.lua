--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_129"
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
		["34"] = 26,
		["35"] = 27,
		["36"] = 27,
		["37"] = 27,
		["38"] = 27,
		["39"] = 27,
		["41"] = 29,
		["42"] = 29,
		["43"] = 29,
		["44"] = 29,
		["45"] = 29,
		["48"] = 22,
		["49"] = 33,
		["50"] = 34,
		["51"] = 33,
		["52"] = 38,
		["53"] = 39,
		["56"] = 40,
		["57"] = 41,
		["58"] = 42,
		["59"] = 43,
		["60"] = 43,
		["61"] = 43,
		["63"] = 43,
		["65"] = 43,
		["66"] = 44,
		["67"] = 45,
		["68"] = 46,
		["69"] = 46,
		["70"] = 46,
		["71"] = 46,
		["72"] = 46,
		["73"] = 46,
		["74"] = 46,
		["75"] = 46,
		["76"] = 51,
		["77"] = 51,
		["78"] = 51,
		["79"] = 51,
		["80"] = 51,
		["82"] = 53,
		["83"] = 54,
		["84"] = 55,
		["85"] = 55,
		["86"] = 55,
		["87"] = 55,
		["88"] = 55,
		["90"] = 57,
		["91"] = 57,
		["92"] = 57,
		["93"] = 57,
		["94"] = 57,
		["97"] = 38,
		["98"] = 19,
		["99"] = 12,
		["100"] = 12,
		["101"] = 12,
		["102"] = 12,
		["103"] = 12,
		["104"] = 12,
		["105"] = 12,
		["106"] = 19,
		["108"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_129 = c()
local n = g.trait_129
n.name = "trait_129"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_129"
end
n = e({ j(nil) }, n)
g.trait_129 = n
g.modifier_trait_129 = c()
local o = g.modifier_trait_129
o.name = "modifier_trait_129"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
	if IsServer() then
		self.state = true
		if self.state then
			PlayerData:getplayerData(self:GetCaster():GetPlayerOwnerID()):modifyArtifactExtraStringData(
				self:GetAbility():entindex(),
				"CustomAbility_Trigger",
				"#HandBook_Sub_Nav_Win"
			)
		else
			PlayerData:getplayerData(self:GetCaster():GetPlayerOwnerID()):modifyArtifactExtraStringData(
				self:GetAbility():entindex(),
				"CustomAbility_Trigger",
				"#HandBook_Sub_Nav_Lose"
			)
		end
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
	if p.illusionPlayerID ~= q and (p.winPlayerID == q or p.losePlayerID == q) then
		local r = PlayerData:getplayerData(q)
		local s
		if self.state then
			s = p.winPlayerID == q
		else
			s = p.losePlayerID == q
		end
		local t = s
		if t then
			PlayerData:modifyGold(q, self.gold)
			Notification:combatToPlayer(
				q,
				{
					message = "notify_bonus_gold",
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
					int_gold = self.gold,
				}
			)
			r:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.gold)
		end
		self.state = not self.state
		if self.state then
			r:modifyArtifactExtraStringData(
				self:GetAbility():entindex(),
				"CustomAbility_Trigger",
				"#HandBook_Sub_Nav_Win"
			)
		else
			r:modifyArtifactExtraStringData(
				self:GetAbility():entindex(),
				"CustomAbility_Trigger",
				"#HandBook_Sub_Nav_Lose"
			)
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
g.modifier_trait_129 = o
return g