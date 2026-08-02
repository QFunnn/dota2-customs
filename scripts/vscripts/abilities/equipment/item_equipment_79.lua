--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_79"
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
		["34"] = 28,
		["35"] = 29,
		["36"] = 30,
		["37"] = 30,
		["38"] = 29,
		["39"] = 28,
		["40"] = 34,
		["41"] = 35,
		["42"] = 36,
		["43"] = 37,
		["44"] = 38,
		["45"] = 38,
		["46"] = 38,
		["47"] = 38,
		["48"] = 38,
		["49"] = 38,
		["50"] = 38,
		["51"] = 39,
		["55"] = 34,
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
g.item_equipment_79 = c()
local n = g.item_equipment_79
n.name = "item_equipment_79"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_79"
end
n = e({ j(nil) }, n)
g.item_equipment_79 = n
g.modifier_item_equipment_79 = c()
local o = g.modifier_item_equipment_79
o.name = "modifier_item_equipment_79"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() } }
end
function o.prototype.OnCustomTakeDamage(self, p)
	if IsServer() then
		if
			p.damage > 0
			and p.is_crit
			and p.attacker ~= p.target
			and IsInjurable(p.attacker, p.target)
			and bit.band(p.damage_flags, DamageFlags.DAMAGE_FLAG_REFLECTION) ~= DamageFlags.DAMAGE_FLAG_REFLECTION
		then
			if self:PRD(self.chance) then
				p.target:DealDamage(
					p.attacker,
					self:GetAbility(),
					self.damage_pct * p.damage * 0.01,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE,
					DamageFlags.DAMAGE_FLAG_REFLECTION
				)
				p.target:EmitSound("DOTA_Item.BladeMail.Damage")
			end
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
g.modifier_item_equipment_79 = o
return g