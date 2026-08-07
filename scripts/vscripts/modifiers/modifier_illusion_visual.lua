--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/modifier_illusion_visual"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 2,
		["9"] = 2,
		["10"] = 2,
		["11"] = 4,
		["12"] = 14,
		["13"] = 4,
		["14"] = 14,
		["15"] = 15,
		["16"] = 16,
		["18"] = 18,
		["19"] = 18,
		["20"] = 18,
		["21"] = 18,
		["22"] = 18,
		["23"] = 19,
		["24"] = 19,
		["25"] = 19,
		["26"] = 19,
		["27"] = 19,
		["28"] = 19,
		["29"] = 19,
		["30"] = 19,
		["32"] = 15,
		["33"] = 14,
		["34"] = 4,
		["35"] = 4,
		["36"] = 4,
		["37"] = 4,
		["38"] = 4,
		["39"] = 4,
		["40"] = 4,
		["41"] = 4,
		["42"] = 14,
		["44"] = 14,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_illusion_visual = c()
local k = g.modifier_illusion_visual
k.name = "modifier_illusion_visual"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
	else
		local m = ParticleManager:CreateParticle(
			"particles/status_fx/status_effect_illusion.vpcf",
			PATTACH_INVALID,
			self:GetParent()
		)
		self:AddParticle(m, false, true, 999999999, false, false)
	end
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	k
)
g.modifier_illusion_visual = k
return g