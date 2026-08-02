--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_110"
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
		["33"] = 27,
		["34"] = 28,
		["35"] = 27,
		["36"] = 33,
		["37"] = 34,
		["40"] = 38,
		["41"] = 39,
		["42"] = 40,
		["43"] = 41,
		["44"] = 41,
		["45"] = 41,
		["46"] = 42,
		["47"] = 43,
		["48"] = 44,
		["49"] = 45,
		["50"] = 41,
		["51"] = 41,
		["53"] = 33,
		["54"] = 20,
		["55"] = 11,
		["56"] = 11,
		["57"] = 11,
		["58"] = 11,
		["59"] = 11,
		["60"] = 11,
		["61"] = 11,
		["62"] = 11,
		["63"] = 11,
		["64"] = 20,
		["66"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_110 = c()
local n = g.item_equipment_110
n.name = "item_equipment_110"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_110"
end
n = e({ j(nil) }, n)
g.item_equipment_110 = n
g.modifier_item_equipment_110 = c()
local o = g.modifier_item_equipment_110
o.name = "modifier_item_equipment_110"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.wisp_health_reduce = self:GetAbilitySpecialValueFor("wisp_health_reduce")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function o.prototype.OnBattleStart(self, p)
	if not IsServer() then
		return
	end
	local q = self:GetParent()
	local r = q:GetEnemy()
	if IsValid(r) then
		EachWisp(r, function(s)
			local t = s:GetMaxHealth() * (100 - self.wisp_health_reduce) * 0.01
			s:SetBaseMaxHealth(t)
			s:SetMaxHealth(t)
			s:SetHealth(t)
		end)
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
				GetPriority = MODIFIER_PRIORITY_ULTRA,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_PERMANENT,
			}
		),
	},
	o
)
g.modifier_item_equipment_110 = o
return g