--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_123"
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
		["35"] = 30,
		["36"] = 31,
		["37"] = 32,
		["38"] = 32,
		["39"] = 32,
		["40"] = 33,
		["41"] = 34,
		["42"] = 35,
		["43"] = 36,
		["44"] = 37,
		["45"] = 38,
		["46"] = 39,
		["47"] = 39,
		["48"] = 39,
		["49"] = 39,
		["50"] = 39,
		["51"] = 39,
		["55"] = 32,
		["56"] = 32,
		["58"] = 30,
		["59"] = 20,
		["60"] = 11,
		["61"] = 11,
		["62"] = 11,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 11,
		["69"] = 20,
		["71"] = 20,
		["72"] = 54,
		["73"] = 62,
		["74"] = 54,
		["75"] = 62,
		["76"] = 64,
		["77"] = 65,
		["78"] = 64,
		["79"] = 67,
		["80"] = 68,
		["81"] = 67,
		["82"] = 62,
		["83"] = 54,
		["84"] = 54,
		["85"] = 54,
		["86"] = 54,
		["87"] = 54,
		["88"] = 54,
		["89"] = 54,
		["90"] = 54,
		["91"] = 62,
		["93"] = 62,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_123 = c()
local n = g.item_equipment_123
n.name = "item_equipment_123"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_123"
end
n = e({ j(nil) }, n)
g.item_equipment_123 = n
g.modifier_item_equipment_123 = c()
local o = g.modifier_item_equipment_123
o.name = "modifier_item_equipment_123"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.crit_damage_reduce = self:GetAbilitySpecialValueFor("crit_damage_reduce")
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL, function(q, p, r, s)
			if s == self:GetParent() then
				if
					bit.band(p.damage_flags, DamageFlags.DAMAGE_FLAG_REFLECTION) ~= DamageFlags.DAMAGE_FLAG_REFLECTION
				then
					p.damage = p.damage * (1 - self.crit_damage_reduce * 0.01)
					if self:PRD(self.chance) then
						local t = self:GetParent()
						local s = t:GetEnemy()
						t:AddNewModifier(
							t,
							self:GetAbility(),
							"modifier_item_equipment_123_buf",
							{ duration = self.duration }
						)
					end
				end
			end
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
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_PERMANENT,
			}
		),
	},
	o
)
g.modifier_item_equipment_123 = o
g.modifier_item_equipment_123_buf = c()
local u = g.modifier_item_equipment_123_buf
u.name = "modifier_item_equipment_123_buf"
d(u, l)
function u.prototype.GetAbilitySpecialValue(self)
	self.extra_counter_critcal_chance = self:GetAbilitySpecialValueFor("extra_counter_critcal_chance")
end
function u.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_COUNTER_CRITICAL_CHANCE] = self.extra_counter_critcal_chance }
end
u = e(
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
	u
)
g.modifier_item_equipment_123_buf = u
return g