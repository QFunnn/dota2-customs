--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_5"
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
		["30"] = 22,
		["31"] = 23,
		["32"] = 22,
		["33"] = 25,
		["34"] = 26,
		["35"] = 27,
		["36"] = 28,
		["37"] = 29,
		["38"] = 30,
		["39"] = 31,
		["40"] = 32,
		["42"] = 25,
		["43"] = 35,
		["44"] = 36,
		["45"] = 37,
		["46"] = 37,
		["47"] = 37,
		["48"] = 36,
		["49"] = 38,
		["50"] = 38,
		["51"] = 38,
		["52"] = 36,
		["53"] = 36,
		["54"] = 35,
		["55"] = 41,
		["56"] = 42,
		["57"] = 43,
		["58"] = 44,
		["59"] = 45,
		["60"] = 46,
		["61"] = 47,
		["63"] = 41,
		["64"] = 50,
		["65"] = 51,
		["66"] = 52,
		["67"] = 50,
		["68"] = 20,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 11,
		["78"] = 20,
		["80"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_5 = c()
local n = g.item_artifact_5
n.name = "item_artifact_5"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_5"
end
n = e({ j(nil) }, n)
g.item_artifact_5 = n
g.modifier_item_artifact_5 = c()
local o = g.modifier_item_artifact_5
o.name = "modifier_item_artifact_5"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.free_time = self:GetAbilitySpecialValueFor("free_time")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:GetLossHealth(q) * self.free_time
		PlayerData:ModifyFreeRefresh(q, r)
		PlayerData:ModifyFreeRefreshByKey(q, "item_artifact_5", r)
		local s = self:GetAbility()
		s:SetCurrentCharges(PlayerData:GetFreeRefreshByKey(q, "item_artifact_5"))
	end
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_TAKEDAMAGE] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_REFRESH] = { self:GetParent(), -1 },
	}
end
function o.prototype.OnPlayerTakeDamage(self, p)
	if p then
		local q = self:GetParent():GetPlayerOwnerID()
		PlayerData:ModifyFreeRefresh(q, self.free_time * p.damage)
		PlayerData:ModifyFreeRefreshByKey(q, "item_artifact_5", self.free_time * p.damage)
		local s = self:GetAbility()
		s:SetCurrentCharges(PlayerData:GetFreeRefreshByKey(q, "item_artifact_5"))
	end
end
function o.prototype.OnAbilityRefresh(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	self:GetAbility():SetCurrentCharges(PlayerData:GetFreeRefreshByKey(q, "item_artifact_5"))
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
g.modifier_item_artifact_5 = o
return g