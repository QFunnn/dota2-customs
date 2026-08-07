--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_custom_snowman"
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
		["20"] = 12,
		["21"] = 18,
		["22"] = 19,
		["23"] = 20,
		["24"] = 20,
		["25"] = 20,
		["26"] = 20,
		["27"] = 20,
		["28"] = 21,
		["31"] = 18,
		["32"] = 25,
		["33"] = 26,
		["34"] = 25,
		["35"] = 30,
		["36"] = 31,
		["37"] = 30,
		["38"] = 11,
		["39"] = 3,
		["40"] = 3,
		["41"] = 3,
		["42"] = 3,
		["43"] = 3,
		["44"] = 3,
		["45"] = 3,
		["46"] = 3,
		["47"] = 11,
		["49"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_custom_snowman = c()
local k = g.modifier_custom_snowman
k.name = "modifier_custom_snowman"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:GetParent():EmitSound("FrostivusConsumable.Snowman.Spawn")
	else
	end
end
function k.prototype.OnDestroy(self)
	if IsServer() then
		local m = ParticleManager:CreateParticle(
			"particles/econ/events/snowman/snowman_death.vpcf",
			PATTACH_ABSORIGIN,
			self:GetParent()
		)
		self:GetParent():EmitSound("FrostivusConsumable.Snowman.Destroyed")
	else
	end
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE }
end
function k.prototype.GetModifierModelChange(self)
	return "models/props_frostivus/frostivus_snowman.vmdl"
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
				GetPriority = MODIFIER_PRIORITY_SUPER_ULTRA,
			}
		),
	},
	k
)
g.modifier_custom_snowman = k
return g