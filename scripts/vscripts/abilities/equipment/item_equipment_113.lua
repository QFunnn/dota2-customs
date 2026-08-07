--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_113"
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
		["30"] = 25,
		["31"] = 26,
		["32"] = 27,
		["33"] = 28,
		["34"] = 25,
		["35"] = 31,
		["36"] = 32,
		["37"] = 33,
		["38"] = 33,
		["39"] = 32,
		["40"] = 31,
		["41"] = 37,
		["42"] = 38,
		["45"] = 42,
		["46"] = 43,
		["47"] = 44,
		["48"] = 45,
		["49"] = 46,
		["50"] = 47,
		["51"] = 48,
		["52"] = 49,
		["55"] = 37,
		["56"] = 20,
		["57"] = 11,
		["58"] = 11,
		["59"] = 11,
		["60"] = 11,
		["61"] = 11,
		["62"] = 11,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 20,
		["68"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_113 = c()
local n = g.item_equipment_113
n.name = "item_equipment_113"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_113"
end
n = e({ j(nil) }, n)
g.item_equipment_113 = n
g.modifier_item_equipment_113 = c()
local o = g.modifier_item_equipment_113
o.name = "modifier_item_equipment_113"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.damagePool = 0
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() } }
end
function o.prototype.OnCustomTakeDamage(self, p)
	if not IsServer() then
		return
	end
	if p.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_POISON then
		self.damagePool = self.damagePool + p.damage
		if self.damagePool >= self.threshold then
			local q = self:GetParent()
			local r = p.attacker
			local s = self:GetAbility()
			q:DealDamage(r, s, self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			self.damagePool = 0
		end
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_PERMANENT,
			}
		),
	},
	o
)
g.modifier_item_equipment_113 = o
return g