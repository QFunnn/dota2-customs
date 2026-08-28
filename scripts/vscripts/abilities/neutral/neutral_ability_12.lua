--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_12"
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
		["14"] = 3,
		["15"] = 3,
		["16"] = 3,
		["17"] = 5,
		["18"] = 6,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 7,
		["24"] = 6,
		["25"] = 5,
		["26"] = 6,
		["28"] = 6,
		["29"] = 12,
		["30"] = 20,
		["31"] = 12,
		["32"] = 20,
		["33"] = 22,
		["34"] = 23,
		["35"] = 22,
		["36"] = 25,
		["37"] = 26,
		["38"] = 27,
		["39"] = 27,
		["40"] = 26,
		["41"] = 25,
		["42"] = 30,
		["43"] = 31,
		["44"] = 32,
		["46"] = 30,
		["47"] = 20,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 12,
		["54"] = 12,
		["55"] = 12,
		["56"] = 20,
		["58"] = 20,
		["59"] = 37,
		["60"] = 38,
		["61"] = 37,
		["62"] = 38,
		["63"] = 39,
		["64"] = 40,
		["65"] = 41,
		["66"] = 42,
		["67"] = 43,
		["68"] = 43,
		["69"] = 43,
		["70"] = 43,
		["71"] = 43,
		["72"] = 48,
		["73"] = 49,
		["74"] = 50,
		["75"] = 43,
		["76"] = 43,
		["77"] = 39,
		["78"] = 38,
		["79"] = 37,
		["80"] = 38,
		["82"] = 38,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = require("abilities.ability_ai")
local o = n.BaseAbilityAI
local p = n.registerAbilityAI
g.neutral_talent_12 = c()
local q = g.neutral_talent_12
q.name = "neutral_talent_12"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_12"
end
q = e({ j(nil) }, q)
g.neutral_talent_12 = q
g.modifier_neutral_talent_12 = c()
local r = g.modifier_neutral_talent_12
r.name = "modifier_neutral_talent_12"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.damage_increase = self:GetAbilitySpecialValueFor("damage_increase")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 } }
end
function r.prototype.OnCustomAbilityFullyCast(self, s)
	if s and s.ability:GetName() == "neutral_ult_12" then
		self:SetStackCount(self:GetStackCount() + self.damage_increase)
	end
end
r = e(
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
	r
)
g.modifier_neutral_talent_12 = r
g.neutral_ult_12 = c()
local t = g.neutral_ult_12
t.name = "neutral_ult_12"
d(t, o)
function t.prototype.OnSpellStart(self)
	local u = self:GetCaster()
	local v = u:GetEnemy()
	local w = self:GetSpecialValueFor("damage") + u:GetModifierStackCount("modifier_neutral_talent_12", u)
	Projectile:CreateTrackingProjectile({
		hCaster = u,
		hTarget = v,
		iMoveSpeed = 550,
		EffectName = "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_arcane_orb.vpcf",
		OnProjectileHit = function()
			u:DealDamage(v, self, w, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			EmitSoundOn("Hero_ObsidianDestroyer.ArcaneOrb.Impact", v)
		end,
	})
end
t = e({ p(nil) }, t)
g.neutral_ult_12 = t
return g