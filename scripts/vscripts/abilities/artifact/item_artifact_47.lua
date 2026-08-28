--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_47"
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
		["35"] = 29,
		["36"] = 30,
		["37"] = 32,
		["38"] = 32,
		["39"] = 30,
		["40"] = 29,
		["41"] = 44,
		["42"] = 45,
		["43"] = 46,
		["44"] = 47,
		["45"] = 48,
		["46"] = 49,
		["47"] = 50,
		["48"] = 50,
		["49"] = 50,
		["50"] = 50,
		["51"] = 50,
		["52"] = 51,
		["53"] = 52,
		["56"] = 55,
		["57"] = 44,
		["58"] = 20,
		["59"] = 11,
		["60"] = 11,
		["61"] = 11,
		["62"] = 11,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 20,
		["70"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_47 = c()
local n = g.item_artifact_47
n.name = "item_artifact_47"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_47"
end
n = e({ j(nil) }, n)
g.item_artifact_47 = n
g.modifier_item_artifact_47 = c()
local o = g.modifier_item_artifact_47
o.name = "modifier_item_artifact_47"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.free = self:GetAbilitySpecialValueFor("free")
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.max_stack = self:GetAbilitySpecialValueFor("max_stack")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_REFRESH] = { self:GetParent(), -1 } }
end
function o.prototype.OnAbilityRefresh(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	if self:PRD(self.chance) then
		local r = PlayerData:GetFreeRefreshByKey(q, "item_artifact_47")
		local s = math.max(0, r + self.free >= self.max_stack and self.max_stack - r or self.free)
		if s > 0 then
			PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "free_refresh_count", s)
			PlayerData:ModifyFreeRefresh(q, s)
			PlayerData:ModifyFreeRefreshByKey(q, "item_artifact_47", s)
		end
	end
	self:GetAbility():SetCurrentCharges(PlayerData:GetFreeRefreshByKey(q, "item_artifact_47"))
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
g.modifier_item_artifact_47 = o
return g