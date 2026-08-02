--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_127"
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
		["27"] = 20,
		["28"] = 11,
		["29"] = 20,
		["30"] = 24,
		["31"] = 25,
		["32"] = 26,
		["33"] = 27,
		["34"] = 24,
		["35"] = 31,
		["36"] = 32,
		["37"] = 31,
		["38"] = 37,
		["39"] = 38,
		["40"] = 37,
		["41"] = 42,
		["42"] = 43,
		["43"] = 44,
		["44"] = 45,
		["45"] = 46,
		["46"] = 47,
		["47"] = 47,
		["48"] = 47,
		["49"] = 47,
		["50"] = 47,
		["51"] = 47,
		["52"] = 47,
		["53"] = 47,
		["54"] = 52,
		["55"] = 52,
		["56"] = 52,
		["57"] = 52,
		["58"] = 52,
		["60"] = 42,
		["61"] = 56,
		["62"] = 57,
		["63"] = 58,
		["64"] = 59,
		["65"] = 60,
		["66"] = 61,
		["67"] = 62,
		["68"] = 63,
		["69"] = 64,
		["73"] = 68,
		["74"] = 56,
		["75"] = 71,
		["76"] = 72,
		["77"] = 71,
		["78"] = 20,
		["79"] = 11,
		["80"] = 11,
		["81"] = 11,
		["82"] = 11,
		["83"] = 11,
		["84"] = 11,
		["85"] = 11,
		["86"] = 11,
		["87"] = 11,
		["88"] = 20,
		["90"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_127 = c()
local n = g.item_artifact_127
n.name = "item_artifact_127"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_127"
end
n = e({ j(nil) }, n)
g.item_artifact_127 = n
g.modifier_item_artifact_127 = c()
local o = g.modifier_item_artifact_127
o.name = "modifier_item_artifact_127"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.base_gold = self:GetAbilitySpecialValueFor("base_gold")
	self.sect_level = self:GetAbilitySpecialValueFor("sect_level")
	self.reduce_gold = self:GetAbilitySpecialValueFor("reduce_gold")
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_RARE_CHANCE_BONUS }
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function o.prototype.OnRoundStart(self, p)
	if IsServer() then
		local q = self.parent:GetPlayerOwnerID()
		local r = self:GetAddGold()
		PlayerData:modifyGold(q, r)
		Notification:combatToPlayer(
			q,
			{
				message = "notify_bonus_gold",
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
				int_gold = r,
			}
		)
		PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", r)
	end
end
function o.prototype.GetSectLevel2Cnt(self)
	local s = 0
	local q = self:GetParent():GetPlayerOwnerID()
	local t = PlayerData:getHero(q)
	if t then
		local u = t:getAbilityData()
		for v, w in pairs(u) do
			if w.level >= self.sect_level then
				s = s + 1
			end
		end
	end
	return s
end
function o.prototype.GetAddGold(self)
	return self.base_gold - self:GetSectLevel2Cnt() * self.reduce_gold
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	o
)
g.modifier_item_artifact_127 = o
return g