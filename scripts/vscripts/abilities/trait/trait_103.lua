--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_103"
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
		["44"] = 35,
		["45"] = 36,
		["48"] = 39,
		["49"] = 40,
		["50"] = 41,
		["51"] = 42,
		["52"] = 43,
		["53"] = 44,
		["54"] = 44,
		["55"] = 44,
		["56"] = 44,
		["57"] = 44,
		["58"] = 44,
		["59"] = 44,
		["60"] = 44,
		["61"] = 49,
		["62"] = 49,
		["63"] = 49,
		["64"] = 49,
		["65"] = 49,
		["67"] = 35,
		["68"] = 19,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 12,
		["74"] = 12,
		["75"] = 12,
		["76"] = 19,
		["78"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_103 = c()
local n = g.trait_103
n.name = "trait_103"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_103"
end
n = e({ j(nil) }, n)
g.trait_103 = n
g.modifier_trait_103 = c()
local o = g.modifier_trait_103
o.name = "modifier_trait_103"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.refresh = self:GetAbilitySpecialValueFor("refresh")
	self.gold = self:GetAbilitySpecialValueFor("gold")
	if IsServer() then
		PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			:modifyArtifactExtraData(self:GetAbility():entindex(), "DOTA_Tooltip_ability_trait_103_effect", 0)
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 } }
end
function o.prototype.OnBattleEnd(self, p)
	if p.isNeutral ~= nil then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	if p.illusionPlayerID ~= q and p.losePlayerID == q then
		PlayerData:ModifyFreeRefresh(q, self.refresh)
		PlayerData:ModifyFreeRefreshByKey(q, "trait_103", self.refresh)
		PlayerData:modifyGold(q, self.gold)
		Notification:combatToPlayer(
			q,
			{
				message = "notify_bonus_gold",
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
				int_gold = self.gold,
			}
		)
		PlayerData:getplayerData(q)
			:modifyArtifactExtraData(self:GetAbility():entindex(), "DOTA_Tooltip_ability_trait_103_effect", 1)
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_103 = o
return g