--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_6"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
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
		["28"] = 19,
		["29"] = 12,
		["30"] = 19,
		["31"] = 20,
		["32"] = 21,
		["33"] = 22,
		["34"] = 22,
		["35"] = 21,
		["36"] = 20,
		["37"] = 25,
		["38"] = 26,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 27,
		["43"] = 27,
		["44"] = 27,
		["45"] = 25,
		["46"] = 19,
		["47"] = 12,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 12,
		["54"] = 19,
		["56"] = 19,
		["57"] = 31,
		["58"] = 39,
		["59"] = 31,
		["60"] = 39,
		["62"] = 39,
		["63"] = 42,
		["64"] = 31,
		["65"] = 43,
		["66"] = 44,
		["67"] = 45,
		["68"] = 46,
		["69"] = 43,
		["70"] = 48,
		["71"] = 49,
		["72"] = 50,
		["73"] = 51,
		["75"] = 53,
		["77"] = 48,
		["78"] = 56,
		["79"] = 57,
		["80"] = 57,
		["81"] = 57,
		["82"] = 57,
		["83"] = 57,
		["84"] = 57,
		["85"] = 56,
		["86"] = 39,
		["87"] = 31,
		["88"] = 31,
		["89"] = 31,
		["90"] = 31,
		["91"] = 31,
		["92"] = 31,
		["93"] = 31,
		["94"] = 31,
		["95"] = 39,
		["97"] = 39,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.trait_6 = c()
local o = h.trait_6
o.name = "trait_6"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_6"
end
o = e({ k(nil) }, o)
h.trait_6 = o
h.modifier_trait_6 = c()
local p = h.modifier_trait_6
p.name = "modifier_trait_6"
d(p, m)
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function p.prototype.OnTraitInit(self, q)
	q.hero:RemoveModifierByName("modifier_trait_6_buff")
	q.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_6_buff", {})
end
p = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
h.modifier_trait_6 = p
h.modifier_trait_6_buff = c()
local r = h.modifier_trait_6_buff
r.name = "modifier_trait_6_buff"
d(r, m)
function r.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.mul = 1
end
function r.prototype.GetAbilitySpecialValue(self)
	self.health = self:GetAbilitySpecialValueFor("health")
	self.armor = self:GetAbilitySpecialValueFor("armor")
	self:CheckMul()
end
function r.prototype.CheckMul(self)
	if IsServer() then
		if f(AbilityShop.banList, "sect_regen") then
			self.mul = math.max(0, 1 + BUFF_VALUE.RegenDisablePct * 0.01)
		end
		self:SetStackCount(self.mul * 100)
	end
end
function r.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS_PERCENTAGE] = self.health * self:GetStackCount() * 0.01,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE] = -self.armor
			* self:GetStackCount()
			* 0.01,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE] = -self.armor
			* self:GetStackCount()
			* 0.01,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_HEAL_PERCENTAGE] = 1000,
	}
end
r = e(
	{
		n(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetStatusEffectName = "particles/status_fx/status_effect_wraithking_ghosts.vpcf",
			}
		),
	},
	r
)
h.modifier_trait_6_buff = r
return h