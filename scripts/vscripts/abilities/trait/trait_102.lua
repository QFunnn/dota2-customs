--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_102"
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
		["33"] = 26,
		["34"] = 27,
		["35"] = 27,
		["36"] = 27,
		["37"] = 27,
		["38"] = 27,
		["40"] = 23,
		["41"] = 30,
		["42"] = 31,
		["43"] = 30,
		["44"] = 36,
		["45"] = 37,
		["48"] = 40,
		["51"] = 43,
		["52"] = 44,
		["53"] = 45,
		["54"] = 46,
		["55"] = 47,
		["56"] = 47,
		["57"] = 47,
		["58"] = 47,
		["59"] = 47,
		["60"] = 47,
		["61"] = 47,
		["62"] = 47,
		["63"] = 52,
		["64"] = 52,
		["65"] = 52,
		["66"] = 52,
		["67"] = 52,
		["69"] = 36,
		["70"] = 55,
		["71"] = 56,
		["72"] = 57,
		["73"] = 58,
		["74"] = 59,
		["75"] = 59,
		["76"] = 59,
		["77"] = 59,
		["78"] = 59,
		["80"] = 55,
		["81"] = 19,
		["82"] = 12,
		["83"] = 12,
		["84"] = 12,
		["85"] = 12,
		["86"] = 12,
		["87"] = 12,
		["88"] = 12,
		["89"] = 19,
		["91"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_102 = c()
local n = g.trait_102
n.name = "trait_102"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_102"
end
n = e({ j(nil) }, n)
g.trait_102 = n
g.modifier_trait_102 = c()
local o = g.modifier_trait_102
o.name = "modifier_trait_102"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
	self.gold = self:GetAbilitySpecialValueFor("gold")
	if IsServer() then
		PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID()):modifyArtifactExtraStringData(
			self:GetAbility():entindex(),
			"DOTA_Tooltip_ability_trait_102_effect",
			tostring(self.round)
		)
	end
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END] = { -1, -1 },
	}
end
function o.prototype.OnBattleEnd(self, p)
	if p.isNeutral ~= nil then
		return
	end
	if self.round == 0 then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	self.flag = true
	if p.illusionPlayerID ~= q and p.winPlayerID == q then
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
function o.prototype.OnBattleEndStateEnd(self, r)
	if self.flag then
		self.flag = false
		self.round = self.round - 1
		PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID()):modifyArtifactExtraStringData(
			self:GetAbility():entindex(),
			"DOTA_Tooltip_ability_trait_102_effect",
			tostring(self.round)
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
g.modifier_trait_102 = o
return g