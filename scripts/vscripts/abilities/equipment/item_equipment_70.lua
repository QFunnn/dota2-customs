--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_70"
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
		["38"] = 30,
		["39"] = 35,
		["40"] = 36,
		["41"] = 35,
		["42"] = 38,
		["43"] = 39,
		["44"] = 40,
		["45"] = 40,
		["46"] = 39,
		["47"] = 38,
		["48"] = 43,
		["49"] = 44,
		["50"] = 46,
		["51"] = 47,
		["52"] = 47,
		["53"] = 47,
		["54"] = 47,
		["55"] = 47,
		["56"] = 47,
		["57"] = 53,
		["58"] = 54,
		["59"] = 47,
		["60"] = 47,
		["62"] = 43,
		["63"] = 21,
		["64"] = 12,
		["65"] = 12,
		["66"] = 12,
		["67"] = 12,
		["68"] = 12,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 21,
		["75"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_70 = c()
local n = g.item_equipment_70
n.name = "item_equipment_70"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_70"
end
n = e({ j(nil) }, n)
g.item_equipment_70 = n
g.modifier_item_equipment_70 = c()
local o = g.modifier_item_equipment_70
o.name = "modifier_item_equipment_70"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.poison_interval_reduce = self:GetAbilitySpecialValueFor("poison_interval_reduce")
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.ispeed = self:GetAbilitySpecialValueFor("ispeed")
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_INTERVAL }
end
function o.prototype.EOM_GetModifierPoisonInterval(self)
	return -self.poison_interval_reduce
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_POISON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function o.prototype.OnPoisonTakeDamage(self, p)
	if p and IsInjurable(p.target, p.attacker) and p.ability ~= self:GetAbility() and self:PRD(self.chance) then
		p.attacker:EmitSound("DOTA_Item.EtherealBlade.Activate")
		Projectile:CreateTrackingProjectile({
			EffectName = "particles/items_fx/ethereal_blade.vpcf",
			hCaster = p.attacker,
			vSpawnOrigin = p.attacker:GetAttachmentPosition("attach_attack1"),
			hTarget = p.target,
			iMoveSpeed = self.ispeed,
			OnProjectileHit = function(q, r, s)
				TriggerPoison(q)
			end,
		})
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
g.modifier_item_equipment_70 = o
return g