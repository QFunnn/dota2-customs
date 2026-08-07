--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/consumables/consumables_3"
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
		["15"] = 7,
		["16"] = 8,
		["17"] = 7,
		["18"] = 8,
		["19"] = 9,
		["20"] = 10,
		["21"] = 11,
		["22"] = 12,
		["24"] = 14,
		["25"] = 9,
		["26"] = 16,
		["27"] = 17,
		["28"] = 16,
		["29"] = 19,
		["30"] = 20,
		["31"] = 21,
		["32"] = 22,
		["33"] = 23,
		["34"] = 24,
		["35"] = 25,
		["36"] = 25,
		["37"] = 25,
		["38"] = 25,
		["39"] = 25,
		["40"] = 25,
		["41"] = 31,
		["42"] = 32,
		["43"] = 33,
		["44"] = 25,
		["45"] = 25,
		["46"] = 19,
		["47"] = 8,
		["48"] = 7,
		["49"] = 8,
		["51"] = 8,
		["52"] = 39,
		["53"] = 47,
		["54"] = 39,
		["55"] = 47,
		["56"] = 47,
		["57"] = 39,
		["58"] = 39,
		["59"] = 39,
		["60"] = 39,
		["61"] = 39,
		["62"] = 39,
		["63"] = 39,
		["64"] = 39,
		["65"] = 47,
		["67"] = 47,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = { "cast_error_christmas_tree1", "cast_error_christmas_tree2" }
g.consumables_3 = c()
local o = g.consumables_3
o.name = "consumables_3"
d(o, i)
function o.prototype.CastFilterResultTarget(self, p)
	if p:HasModifier("modifier_christmas_tree") then
		self.error = n[RandomInt(0, #n - 1) + 1]
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function o.prototype.GetCustomCastErrorTarget(self, p)
	return self.error
end
function o.prototype.OnSpellStart(self)
	local q = self:GetCaster()
	local p = self:GetCursorTarget()
	local r = self:GetSpecialValueFor("speed")
	local s = self:GetSpecialValueFor("duration")
	q:EmitSound("Item.Paintball.Cast")
	Projectile:CreateTrackingProjectile({
		EffectName = "models/eom/courier/jinitaimei_1/particles/attack/jinitaimei_base_attack_1.vpcf",
		hCaster = q,
		vSpawnOrigin = q:GetAbsOrigin(),
		hTarget = p,
		iMoveSpeed = r,
		OnProjectileHit = function(t, u, v)
			t:AddNewModifier(q, self, "modifier_consumables_3", { duration = s })
			q:EmitSound("sounds/misc/ti9_balloon_impact.vsnd")
		end,
	})
end
o = e({ j(nil) }, o)
g.consumables_3 = o
g.modifier_consumables_3 = c()
local w = g.modifier_consumables_3
w.name = "modifier_consumables_3"
d(w, l)
w = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetEffectName = "particles/status_fx/status_effect_phantom_assassin_fall20_active_blur.vpcf",
			}
		),
	},
	w
)
g.modifier_consumables_3 = w
return g