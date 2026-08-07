--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_ghost"
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
		["19"] = 16,
		["21"] = 12,
		["22"] = 19,
		["23"] = 20,
		["24"] = 21,
		["25"] = 22,
		["27"] = 24,
		["28"] = 25,
		["29"] = 26,
		["30"] = 27,
		["31"] = 27,
		["32"] = 27,
		["33"] = 27,
		["34"] = 27,
		["35"] = 27,
		["36"] = 27,
		["37"] = 27,
		["38"] = 28,
		["39"] = 29,
		["40"] = 29,
		["41"] = 29,
		["42"] = 29,
		["43"] = 29,
		["44"] = 29,
		["45"] = 29,
		["46"] = 29,
		["48"] = 19,
		["49"] = 32,
		["50"] = 33,
		["51"] = 32,
		["52"] = 11,
		["53"] = 3,
		["54"] = 3,
		["55"] = 3,
		["56"] = 3,
		["57"] = 3,
		["58"] = 3,
		["59"] = 3,
		["60"] = 3,
		["61"] = 11,
		["63"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_ghost = c()
local k = g.modifier_ghost
k.name = "modifier_ghost"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:StartIntervalThink(2)
	else
		self:StartIntervalThink(2)
	end
end
function k.prototype.OnIntervalThink(self)
	if IsServer() then
		self:SetStackCount(1)
		self:StartIntervalThink(-1)
	else
		self:StartIntervalThink(-1)
		local m = self:GetParent()
		local n = ParticleManager:CreateParticle(
			"particles/gameplay/courier_ghosts_ambient.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			m
		)
		self:AddParticle(n, false, false, -1, false, false)
		local o = ParticleManager:CreateParticle(
			"particles/status_fx/status_effect_wraithking_ghosts.vpcf",
			PATTACH_INVALID,
			m
		)
		self:AddParticle(o, false, true, 100, false, false)
	end
end
function k.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = self:GetStackCount() == 0 }
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	k
)
g.modifier_ghost = k
return g