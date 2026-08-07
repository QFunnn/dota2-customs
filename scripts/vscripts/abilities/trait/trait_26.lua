--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_26"
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
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 12,
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["30"] = 21,
		["31"] = 22,
		["32"] = 21,
		["33"] = 24,
		["34"] = 25,
		["35"] = 26,
		["37"] = 24,
		["38"] = 29,
		["39"] = 30,
		["40"] = 31,
		["41"] = 31,
		["42"] = 30,
		["43"] = 29,
		["44"] = 34,
		["45"] = 35,
		["46"] = 36,
		["47"] = 36,
		["48"] = 36,
		["49"] = 36,
		["50"] = 36,
		["51"] = 36,
		["52"] = 34,
		["53"] = 19,
		["54"] = 12,
		["55"] = 12,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 19,
		["63"] = 19,
		["64"] = 40,
		["65"] = 47,
		["66"] = 40,
		["67"] = 47,
		["68"] = 50,
		["69"] = 51,
		["70"] = 52,
		["71"] = 50,
		["72"] = 54,
		["73"] = 55,
		["74"] = 56,
		["75"] = 57,
		["76"] = 58,
		["77"] = 58,
		["78"] = 58,
		["79"] = 58,
		["80"] = 58,
		["81"] = 58,
		["82"] = 58,
		["83"] = 58,
		["84"] = 58,
		["85"] = 59,
		["86"] = 59,
		["87"] = 59,
		["88"] = 59,
		["89"] = 59,
		["90"] = 59,
		["91"] = 59,
		["92"] = 59,
		["94"] = 54,
		["95"] = 62,
		["96"] = 63,
		["97"] = 64,
		["98"] = 64,
		["99"] = 63,
		["100"] = 62,
		["101"] = 67,
		["102"] = 68,
		["103"] = 67,
		["104"] = 74,
		["105"] = 75,
		["106"] = 76,
		["107"] = 76,
		["108"] = 76,
		["109"] = 77,
		["110"] = 78,
		["111"] = 79,
		["112"] = 80,
		["113"] = 81,
		["115"] = 76,
		["116"] = 76,
		["117"] = 74,
		["118"] = 47,
		["119"] = 40,
		["120"] = 40,
		["121"] = 40,
		["122"] = 40,
		["123"] = 40,
		["124"] = 40,
		["125"] = 40,
		["126"] = 47,
		["128"] = 47,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_26 = c()
local n = g.trait_26
n.name = "trait_26"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_26"
end
n = e({ j(nil) }, n)
g.trait_26 = n
g.modifier_trait_26 = c()
local o = g.modifier_trait_26
o.name = "modifier_trait_26"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.interest = self:GetAbilitySpecialValueFor("interest")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self:SetStackCount(1)
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_26_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_26_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_26 = o
g.modifier_trait_26_buff = c()
local q = g.modifier_trait_26_buff
q.name = "modifier_trait_26_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.mana_regen = self:GetAbilitySpecialValueFor("mana_regen")
	self.ulti_power = self:GetAbilitySpecialValueFor("ulti_power")
end
function q.prototype.OnCreated(self, p)
	if IsClient() then
		local r = self:GetParent()
		local s = ParticleManager:CreateParticle(
			"particles/econ/items/storm_spirit/strom_spirit_ti8/storm_spirit_ti8_overload_ambient.vpcf",
			PATTACH_CUSTOMORIGIN,
			r
		)
		ParticleManager:SetParticleControlEnt(s, 0, r, PATTACH_POINT_FOLLOW, "attach_attack1", r:GetAbsOrigin(), false)
		self:AddParticle(s, false, false, -1, false, false)
	end
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 } }
end
function q.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE] = -self.mana_regen,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER] = self.ulti_power,
	}
end
function q.prototype.OnCustomAbilityFullyCast(self, t)
	local r = self:GetParent()
	r:GameTimer(0.3, function()
		local u = r:FindAbilityByName(r:GetUnitName() .. "_ult")
		if IsValid(u) then
			u:OnSpellStart()
			ParticleManager:CreateParticle(
				"particles/econ/items/storm_spirit/strom_spirit_ti8/storm_spirit_ti8_overload_active_e.vpcf",
				PATTACH_ABSORIGIN,
				r
			)
			r:EmitSound("Hero_StormSpirit.Overload")
		end
	end)
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_trait_26_buff = q
return g