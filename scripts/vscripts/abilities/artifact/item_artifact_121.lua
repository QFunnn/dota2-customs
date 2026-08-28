--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_121"
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
		["30"] = 22,
		["31"] = 23,
		["32"] = 24,
		["33"] = 22,
		["34"] = 26,
		["35"] = 27,
		["36"] = 28,
		["37"] = 29,
		["38"] = 30,
		["39"] = 31,
		["40"] = 32,
		["41"] = 33,
		["42"] = 33,
		["43"] = 33,
		["44"] = 33,
		["45"] = 33,
		["46"] = 34,
		["47"] = 35,
		["48"] = 35,
		["49"] = 35,
		["50"] = 35,
		["52"] = 37,
		["53"] = 37,
		["54"] = 37,
		["55"] = 37,
		["56"] = 37,
		["57"] = 37,
		["58"] = 37,
		["59"] = 37,
		["61"] = 26,
		["62"] = 44,
		["63"] = 45,
		["65"] = 44,
		["66"] = 19,
		["67"] = 11,
		["68"] = 11,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 19,
		["77"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_121 = c()
local n = g.item_artifact_121
n.name = "item_artifact_121"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_121"
end
n = e({ j(nil) }, n)
g.item_artifact_121 = n
g.modifier_item_artifact_121 = c()
local o = g.modifier_item_artifact_121
o.name = "modifier_item_artifact_121"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.min_gold = self:GetAbilitySpecialValueFor("min_gold")
	self.max_gold = self:GetAbilitySpecialValueFor("max_gold")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self.parent:GetPlayerOwnerID()
		local r = PlayerData:getplayerData(q)
		local s = Round(self.max_gold / 10)
		local t = RandomInt(self.min_gold, s) * 10
		PlayerData:modifyGold(q, t)
		r:modifyArtifactExtraData(self.ability:entindex(), "bonus_gold", t)
		if t > 0 then
			EmitAnnouncerSoundForPlayer("General.Coins", self.parent:GetPlayerOwnerID())
		end
		Notification:combatToPlayer(
			q,
			{
				message = "notify_bonus_gold",
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.ability:GetAbilityName(),
				int_gold = t,
			}
		)
	end
end
function o.prototype.OnDestroy(self)
	if IsServer() then
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
g.modifier_item_artifact_121 = o
return g