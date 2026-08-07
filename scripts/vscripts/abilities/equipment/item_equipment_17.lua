--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_17"
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
		["31"] = 24,
		["32"] = 25,
		["33"] = 26,
		["34"] = 24,
		["35"] = 28,
		["36"] = 29,
		["37"] = 30,
		["38"] = 30,
		["39"] = 29,
		["40"] = 28,
		["41"] = 33,
		["42"] = 34,
		["43"] = 35,
		["44"] = 36,
		["45"] = 37,
		["46"] = 38,
		["47"] = 38,
		["48"] = 38,
		["49"] = 38,
		["50"] = 38,
		["51"] = 38,
		["52"] = 39,
		["54"] = 33,
		["55"] = 21,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 12,
		["65"] = 21,
		["67"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_17 = c()
local n = g.item_equipment_17
n.name = "item_equipment_17"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_17"
end
n = e({ j(nil) }, n)
g.item_equipment_17 = n
g.modifier_item_equipment_17 = c()
local o = g.modifier_item_equipment_17
o.name = "modifier_item_equipment_17"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.cooldown = self:GetAbilitySpecialValueFor("cooldown")
	self.hp_regen = self:GetAbilitySpecialValueFor("hp_regen")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { -1, self:GetParent() } }
end
function o.prototype.OnCritical(self, p)
	if self:GetAbility():IsCooldownReady() then
		local q = self:GetParent()
		ParticleManager:CreateParticle("particles/items3_fx/fish_bones_active.vpcf", PATTACH_ABSORIGIN, q)
		q:EmitSound("DOTA_Item.FaerieSpark.Activate")
		Heal(q, self.hp_regen, self:GetAbility():GetAbilityName(), "Ability")
		self:GetAbility():StartCooldown(self.cooldown)
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
g.modifier_item_equipment_17 = o
return g