--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_87"
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
		["43"] = 39,
		["44"] = 40,
		["45"] = 41,
		["46"] = 42,
		["47"] = 43,
		["48"] = 44,
		["49"] = 45,
		["50"] = 45,
		["51"] = 45,
		["52"] = 45,
		["53"] = 45,
		["54"] = 45,
		["55"] = 47,
		["56"] = 48,
		["57"] = 48,
		["58"] = 48,
		["59"] = 48,
		["60"] = 48,
		["61"] = 49,
		["62"] = 50,
		["67"] = 37,
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
g.item_equipment_87 = c()
local n = g.item_equipment_87
n.name = "item_equipment_87"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_87"
end
n = e({ j(nil) }, n)
g.item_equipment_87 = n
g.modifier_item_equipment_87 = c()
local o = g.modifier_item_equipment_87
o.name = "modifier_item_equipment_87"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	self.fury_factor = self:GetAbilitySpecialValueFor("fury_factor")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED] = { self:GetParent(), -1 } }
end
function o.prototype.OnFuryGained(self, p)
	if IsServer() then
		local q = self:GetParent()
		if q.GetEnemy then
			local r = q:GetEnemy()
			if IsInjurable(r) then
				if self:PRD(self.chance) then
					local s = self:GetAbility()
					q:DealDamage(
						r,
						s,
						self.bonus_damage + GetFury(q) * self.fury_factor,
						EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
					)
					local t = ParticleManager:CreateParticle(
						"particles/items5_fx/havoc_hammer.vpcf",
						PATTACH_ABSORIGIN_FOLLOW,
						q
					)
					ParticleManager:SetParticleControl(t, 1, Vector(500, 500, 500))
					ParticleManager:ReleaseParticleIndex(t)
					q:EmitSound("DOTA_Item.HavocHammer.Cast")
				end
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
g.modifier_item_equipment_87 = o
return g