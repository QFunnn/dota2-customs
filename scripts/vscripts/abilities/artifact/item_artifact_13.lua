--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_13"
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
		["20"] = 8,
		["22"] = 6,
		["23"] = 11,
		["24"] = 12,
		["25"] = 11,
		["26"] = 5,
		["27"] = 4,
		["28"] = 5,
		["30"] = 5,
		["31"] = 17,
		["32"] = 26,
		["33"] = 17,
		["34"] = 26,
		["35"] = 27,
		["36"] = 28,
		["37"] = 29,
		["38"] = 31,
		["39"] = 32,
		["40"] = 32,
		["41"] = 32,
		["42"] = 32,
		["43"] = 33,
		["44"] = 33,
		["45"] = 33,
		["46"] = 33,
		["47"] = 33,
		["49"] = 27,
		["50"] = 37,
		["51"] = 38,
		["52"] = 39,
		["53"] = 39,
		["54"] = 38,
		["55"] = 37,
		["56"] = 43,
		["57"] = 44,
		["58"] = 45,
		["59"] = 46,
		["60"] = 46,
		["61"] = 46,
		["62"] = 46,
		["64"] = 43,
		["65"] = 26,
		["66"] = 17,
		["67"] = 17,
		["68"] = 17,
		["69"] = 17,
		["70"] = 17,
		["71"] = 17,
		["72"] = 17,
		["73"] = 17,
		["74"] = 17,
		["75"] = 26,
		["77"] = 26,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_13 = c()
local n = g.item_artifact_13
n.name = "item_artifact_13"
d(n, i)
function n.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(self:GetSpecialValueFor("charges"))
	end
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_13"
end
n = e({ j(nil) }, n)
g.item_artifact_13 = n
g.modifier_item_artifact_13 = c()
local o = g.modifier_item_artifact_13
o.name = "modifier_item_artifact_13"
d(o, l)
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetCaster()
		local r = self:GetAbilitySpecialValueFor("charges")
		PlayerData:ModifyFreeRefresh(q:GetPlayerOwnerID(), r)
		PlayerData:ModifyFreeRefreshByKey(q:GetPlayerOwnerID(), "item_artifact_13", r)
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_REFRESH] = { self:GetParent(), -1 } }
end
function o.prototype.OnAbilityRefresh(self, p)
	if IsServer() then
		local s = self:GetAbility()
		s:SetCurrentCharges(PlayerData:GetFreeRefreshByKey(self:GetCaster():GetPlayerOwnerID(), "item_artifact_13"))
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
g.modifier_item_artifact_13 = o
return g