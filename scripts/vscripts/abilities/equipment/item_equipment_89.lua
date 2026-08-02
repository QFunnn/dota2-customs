--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_89"
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
		["30"] = 24,
		["31"] = 25,
		["32"] = 26,
		["33"] = 24,
		["34"] = 29,
		["35"] = 30,
		["36"] = 31,
		["37"] = 31,
		["38"] = 30,
		["39"] = 29,
		["40"] = 35,
		["41"] = 36,
		["42"] = 37,
		["43"] = 38,
		["44"] = 39,
		["45"] = 40,
		["46"] = 41,
		["47"] = 43,
		["48"] = 44,
		["49"] = 45,
		["50"] = 45,
		["51"] = 45,
		["52"] = 45,
		["53"] = 45,
		["54"] = 45,
		["55"] = 45,
		["56"] = 45,
		["57"] = 45,
		["58"] = 46,
		["59"] = 46,
		["60"] = 46,
		["61"] = 46,
		["62"] = 46,
		["63"] = 46,
		["64"] = 46,
		["65"] = 46,
		["66"] = 46,
		["67"] = 47,
		["68"] = 48,
		["72"] = 35,
		["73"] = 20,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 11,
		["78"] = 11,
		["79"] = 11,
		["80"] = 11,
		["81"] = 11,
		["82"] = 11,
		["83"] = 20,
		["85"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_89 = c()
local n = g.item_equipment_89
n.name = "item_equipment_89"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_89"
end
n = e({ j(nil) }, n)
g.item_equipment_89 = n
g.modifier_item_equipment_89 = c()
local o = g.modifier_item_equipment_89
o.name = "modifier_item_equipment_89"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function o.prototype.OnCustomAttackLanded(self, p)
	if IsServer() then
		local q = p.target
		if IsInjurable(q) then
			if self:PRD(self.chance) then
				local r = self:GetParent()
				local s = self:GetAbility()
				q:AddNewModifier(r, s, "modifier_lock_custom", { duration = self.duration })
				local t = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_faceless_void/faceless_void_time_lock_bash.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					q,
					r
				)
				ParticleManager:SetParticleControlEnt(
					t,
					1,
					q,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					q:GetAbsOrigin(),
					false
				)
				ParticleManager:SetParticleControlEnt(t, 2, r, PATTACH_ABSORIGIN_FOLLOW, nil, q:GetAbsOrigin(), false)
				ParticleManager:ReleaseParticleIndex(t)
				q:EmitSound("Hero_FacelessVoid.TimeLockImpact")
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
g.modifier_item_equipment_89 = o
return g