--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_7"
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
		["30"] = 23,
		["31"] = 24,
		["32"] = 25,
		["33"] = 23,
		["34"] = 27,
		["35"] = 27,
		["36"] = 29,
		["37"] = 30,
		["38"] = 29,
		["39"] = 34,
		["40"] = 35,
		["41"] = 34,
		["42"] = 39,
		["43"] = 40,
		["44"] = 41,
		["45"] = 41,
		["46"] = 41,
		["47"] = 41,
		["48"] = 42,
		["50"] = 39,
		["51"] = 45,
		["52"] = 46,
		["53"] = 47,
		["54"] = 48,
		["55"] = 48,
		["56"] = 48,
		["57"] = 48,
		["58"] = 48,
		["59"] = 49,
		["60"] = 50,
		["61"] = 51,
		["63"] = 45,
		["64"] = 20,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 11,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 20,
		["76"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_7 = c()
local n = g.item_artifact_7
n.name = "item_artifact_7"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_7"
end
n = e({ j(nil) }, n)
g.item_artifact_7 = n
g.modifier_item_artifact_7 = c()
local o = g.modifier_item_artifact_7
o.name = "modifier_item_artifact_7"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.damage_per_gold = self:GetAbilitySpecialValueFor("damage_per_gold")
	self.max_gold = self:GetAbilitySpecialValueFor("max_gold")
end
function o.prototype.OnCreated(self, p) end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 } }
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_WAGES }
end
function o.prototype.OnBattleEnd(self, p)
	if self:GetParent():GetPlayerOwnerID() == p.winPlayerID and p.isNeutral == nil then
		self:SetStackCount(math.min(self.max_gold, PlayerData:getPlayerDamage(p.winPlayerID) * self.damage_per_gold))
		self:GetAbility():SetCurrentCharges(self:GetStackCount())
	end
end
function o.prototype.EOM_GetModifierExtraWages(self)
	if IsServer() then
		local q = self:GetStackCount()
		PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", q)
		self:SetStackCount(0)
		self:GetAbility():SetCurrentCharges(0)
		return q
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	o
)
g.modifier_item_artifact_7 = o
return g