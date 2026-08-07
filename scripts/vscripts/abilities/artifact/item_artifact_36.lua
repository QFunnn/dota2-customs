--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_36"
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
		["32"] = 23,
		["33"] = 26,
		["34"] = 27,
		["35"] = 28,
		["36"] = 29,
		["39"] = 26,
		["40"] = 33,
		["41"] = 34,
		["42"] = 33,
		["43"] = 40,
		["44"] = 42,
		["45"] = 43,
		["46"] = 44,
		["47"] = 45,
		["48"] = 45,
		["49"] = 45,
		["50"] = 45,
		["51"] = 45,
		["52"] = 40,
		["53"] = 20,
		["54"] = 11,
		["55"] = 11,
		["56"] = 11,
		["57"] = 11,
		["58"] = 11,
		["59"] = 11,
		["60"] = 11,
		["61"] = 11,
		["62"] = 11,
		["63"] = 20,
		["65"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_36 = c()
local n = g.item_artifact_36
n.name = "item_artifact_36"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_36"
end
n = e({ j(nil) }, n)
g.item_artifact_36 = n
g.modifier_item_artifact_36 = c()
local o = g.modifier_item_artifact_36
o.name = "modifier_item_artifact_36"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.round_refresh_free_amounts = self:GetAbilitySpecialValueFor("round_refresh_free_amounts")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		if GameState:getStateName() == "GameState_Prepare" then
			self:OnPrepare({})
		end
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE] = { -1, -1 } }
end
function o.prototype.OnPrepare(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	PlayerData:ModifyFreeRefresh(q, self.round_refresh_free_amounts)
	PlayerData:ModifyFreeRefreshByKey(q, "item_artifact_36", self.round_refresh_free_amounts)
	PlayerData:getplayerData(q)
		:modifyArtifactExtraData(self:GetAbility():entindex(), "free_refresh_count", self.round_refresh_free_amounts)
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
g.modifier_item_artifact_36 = o
return g