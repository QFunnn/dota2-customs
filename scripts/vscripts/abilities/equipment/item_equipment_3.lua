--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_3"
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
		["34"] = 27,
		["35"] = 28,
		["36"] = 29,
		["37"] = 29,
		["38"] = 28,
		["39"] = 27,
		["40"] = 32,
		["41"] = 33,
		["42"] = 34,
		["43"] = 35,
		["44"] = 36,
		["45"] = 37,
		["46"] = 37,
		["47"] = 37,
		["48"] = 37,
		["49"] = 37,
		["50"] = 37,
		["51"] = 38,
		["52"] = 39,
		["53"] = 39,
		["54"] = 39,
		["55"] = 39,
		["56"] = 39,
		["57"] = 39,
		["58"] = 39,
		["59"] = 39,
		["60"] = 39,
		["61"] = 40,
		["62"] = 41,
		["65"] = 32,
		["66"] = 20,
		["67"] = 11,
		["68"] = 11,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 20,
		["78"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_3 = c()
local n = g.item_equipment_3
n.name = "item_equipment_3"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_3"
end
n = e({ j(nil) }, n)
g.item_equipment_3 = n
g.modifier_item_equipment_3 = c()
local o = g.modifier_item_equipment_3
o.name = "modifier_item_equipment_3"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_LOSS] = { self:GetParent(), -1 } }
end
function o.prototype.OnShieldLoss(self, p)
	if p and self:PRD(self.chance) then
		local q = self:GetParent()
		local r = q:GetEnemy()
		if IsInjurable(r, q) then
			q:DealDamage(r, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
			local s = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_centaur/centaur_return.vpcf",
				PATTACH_CENTER_FOLLOW,
				q
			)
			ParticleManager:SetParticleControlEnt(s, 1, r, PATTACH_CENTER_FOLLOW, nil, vec3_invalid, false)
			ParticleManager:ReleaseParticleIndex(s)
			EmitSoundOn("DOTA_Item.BladeMail.Damage", r)
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
g.modifier_item_equipment_3 = o
return g