--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_39"
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
		["15"] = 5,
		["16"] = 6,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 8,
		["21"] = 7,
		["22"] = 6,
		["23"] = 5,
		["24"] = 6,
		["26"] = 6,
		["27"] = 12,
		["28"] = 21,
		["29"] = 12,
		["30"] = 21,
		["31"] = 25,
		["32"] = 26,
		["33"] = 27,
		["34"] = 28,
		["35"] = 25,
		["36"] = 30,
		["37"] = 31,
		["38"] = 32,
		["39"] = 32,
		["40"] = 31,
		["41"] = 30,
		["42"] = 35,
		["43"] = 36,
		["44"] = 37,
		["45"] = 38,
		["46"] = 39,
		["47"] = 40,
		["48"] = 41,
		["50"] = 43,
		["51"] = 44,
		["54"] = 47,
		["55"] = 47,
		["56"] = 47,
		["57"] = 47,
		["58"] = 48,
		["59"] = 49,
		["60"] = 49,
		["61"] = 49,
		["62"] = 49,
		["63"] = 49,
		["64"] = 50,
		["65"] = 51,
		["66"] = 52,
		["68"] = 47,
		["69"] = 47,
		["70"] = 47,
		["72"] = 35,
		["73"] = 21,
		["74"] = 12,
		["75"] = 12,
		["76"] = 12,
		["77"] = 12,
		["78"] = 12,
		["79"] = 12,
		["80"] = 12,
		["81"] = 12,
		["82"] = 12,
		["83"] = 21,
		["85"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_39 = c()
local n = g.item_equipment_39
n.name = "item_equipment_39"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_39"
end
n = e({ j(nil) }, n)
g.item_equipment_39 = n
g.modifier_item_equipment_39 = c()
local o = g.modifier_item_equipment_39
o.name = "modifier_item_equipment_39"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.interval = 0.4
	self.chance_2x = self:GetAbilitySpecialValueFor("chance_2x")
	self.chance_3x = self:GetAbilitySpecialValueFor("chance_3x")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 } }
end
function o.prototype.OnCustomAbilityFullyCast(self, p)
	if p.ability:GetAbilityIndex() == 1 then
		local q = self:GetParent()
		local r = q:GetEnemy()
		local s = 0
		if self:PRD(self.chance_3x, "chance_3x") then
			s = 2
		else
			if self:PRD(self.chance_2x, "chance_2x") then
				s = 1
			end
		end
		ForWithInterval(self.interval, s, function(t)
			local u = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf",
				PATTACH_OVERHEAD_FOLLOW,
				q
			)
			ParticleManager:SetParticleControl(u, 1, Vector(t + 1, 0, 0))
			if IsInjurable(q, r) then
				p.ability:OnSpellStart()
				FireModifierEvent(
					EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
					{ ability = p.ability, unit = q, target = r, multicast = true },
					q,
					r
				)
			end
		end, true)
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
g.modifier_item_equipment_39 = o
return g