--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_lock_custom"
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
		["12"] = 4,
		["13"] = 12,
		["14"] = 4,
		["15"] = 12,
		["16"] = 13,
		["17"] = 14,
		["19"] = 16,
		["20"] = 17,
		["21"] = 18,
		["22"] = 18,
		["23"] = 18,
		["24"] = 18,
		["25"] = 18,
		["26"] = 18,
		["27"] = 18,
		["28"] = 18,
		["30"] = 13,
		["31"] = 21,
		["32"] = 22,
		["33"] = 21,
		["34"] = 27,
		["35"] = 28,
		["36"] = 27,
		["37"] = 12,
		["38"] = 4,
		["39"] = 4,
		["40"] = 4,
		["41"] = 4,
		["42"] = 4,
		["43"] = 4,
		["44"] = 4,
		["45"] = 4,
		["46"] = 12,
		["48"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_lock_custom = c()
local k = g.modifier_lock_custom
k.name = "modifier_lock_custom"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
	else
		local m = self:GetParent()
		local n = ParticleManager:CreateParticle(
			"particles/status_fx/status_effect_faceless_chronosphere.vpcf",
			PATTACH_INVALID,
			m
		)
		self:AddParticle(n, false, true, 10, false, false)
	end
end
function k.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = -BUFF_VALUE.LockReduce,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BASE] = -BUFF_VALUE.LockManaRegenBaseReduce,
	}
end
function k.prototype.CheckState(self)
	return { [MODIFIER_STATE_FROZEN] = true }
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	k
)
g.modifier_lock_custom = k
return g