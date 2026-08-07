--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/modifier_illusion_appearance"
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
		["11"] = 3,
		["12"] = 11,
		["13"] = 3,
		["14"] = 11,
		["15"] = 12,
		["16"] = 13,
		["17"] = 14,
		["18"] = 15,
		["19"] = 15,
		["20"] = 15,
		["21"] = 15,
		["22"] = 15,
		["23"] = 16,
		["24"] = 16,
		["25"] = 16,
		["26"] = 16,
		["27"] = 16,
		["28"] = 17,
		["29"] = 17,
		["30"] = 17,
		["31"] = 17,
		["32"] = 17,
		["33"] = 18,
		["34"] = 18,
		["35"] = 18,
		["36"] = 18,
		["37"] = 18,
		["38"] = 18,
		["39"] = 18,
		["40"] = 18,
		["41"] = 19,
		["43"] = 12,
		["44"] = 22,
		["45"] = 23,
		["46"] = 24,
		["47"] = 25,
		["48"] = 26,
		["49"] = 26,
		["50"] = 26,
		["51"] = 26,
		["52"] = 26,
		["54"] = 22,
		["55"] = 11,
		["56"] = 3,
		["57"] = 3,
		["58"] = 3,
		["59"] = 3,
		["60"] = 3,
		["61"] = 3,
		["62"] = 3,
		["63"] = 3,
		["64"] = 11,
		["66"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_illusion_appearance = c()
local k = g.modifier_illusion_appearance
k.name = "modifier_illusion_appearance"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		local m = self:GetParent()
		local n = ParticleManager:CreateParticle(
			"particles/econ/events/fall_2022/teleport/teleport_fall2022_end_lvl1.vpcf",
			PATTACH_WORLDORIGIN,
			self:GetParent()
		)
		ParticleManager:SetParticleControl(n, 0, m:GetAbsOrigin())
		ParticleManager:SetParticleControl(n, 1, m:GetAbsOrigin())
		self:AddParticle(n, false, true, -1, false, false)
		m:AddNoDraw()
	end
end
function k.prototype.OnDestroy(self)
	if IsServer() then
		local m = self:GetParent()
		m:RemoveNoDraw()
		EmitSoundOnLocationWithCaster(m:GetAbsOrigin(), "Portal.Hero_Disappear", m)
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
g.modifier_illusion_appearance = k
return g