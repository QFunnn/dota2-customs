--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_38"
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
		["37"] = 29,
		["38"] = 31,
		["39"] = 31,
		["40"] = 31,
		["41"] = 29,
		["42"] = 29,
		["43"] = 28,
		["44"] = 34,
		["45"] = 35,
		["46"] = 34,
		["47"] = 37,
		["48"] = 38,
		["49"] = 37,
		["50"] = 40,
		["51"] = 41,
		["52"] = 42,
		["53"] = 43,
		["54"] = 43,
		["55"] = 43,
		["56"] = 43,
		["57"] = 43,
		["58"] = 43,
		["59"] = 43,
		["60"] = 43,
		["61"] = 43,
		["62"] = 44,
		["63"] = 45,
		["64"] = 45,
		["65"] = 45,
		["66"] = 45,
		["67"] = 46,
		["68"] = 46,
		["69"] = 46,
		["70"] = 46,
		["71"] = 47,
		["72"] = 47,
		["73"] = 47,
		["74"] = 47,
		["75"] = 40,
		["76"] = 21,
		["77"] = 12,
		["78"] = 12,
		["79"] = 12,
		["80"] = 12,
		["81"] = 12,
		["82"] = 12,
		["83"] = 12,
		["84"] = 12,
		["85"] = 12,
		["86"] = 21,
		["88"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.registerEOMModifier
local m = k.EOMModifier
g.item_equipment_38 = c()
local n = g.item_equipment_38
n.name = "item_equipment_38"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_38"
end
n = e({ j(nil) }, n)
g.item_equipment_38 = n
g.modifier_item_equipment_38 = c()
local o = g.modifier_item_equipment_38
o.name = "modifier_item_equipment_38"
d(o, m)
function o.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.stack_reduce = self:GetAbilitySpecialValueFor("stack_reduce")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function o.prototype.OnBattleStart(self)
	self:StartIntervalThink(self.interval)
end
function o.prototype.OnBattleEnd(self)
	self:StartIntervalThink(-1)
end
function o.prototype.OnIntervalThink(self)
	local p = self:GetParent()
	local q = ParticleManager:CreateParticle("particles/items3_fx/lotus_orb_reflect.vpcf", PATTACH_CUSTOMORIGIN, p)
	ParticleManager:SetParticleControlEnt(q, 0, p, PATTACH_POINT_FOLLOW, "attach_hitloc", p:GetAbsOrigin(), false)
	p:EmitSound("Item.LotusOrb.Target")
	ReduceIce(p, math.ceil(GetIce(p) * self.stack_reduce * 0.01))
	ReducePoison(p, math.ceil(GetPoison(p) * self.stack_reduce * 0.01))
	ReduceInjury(p, math.ceil(GetInjury(p) * self.stack_reduce * 0.01))
end
o = e(
	{
		l(
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
g.modifier_item_equipment_38 = o
return g