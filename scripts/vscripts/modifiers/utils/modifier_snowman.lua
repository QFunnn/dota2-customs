--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/modifiers/utils/modifier_snowman.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__ClassExtends
local f = c.__TS__Decorate
local g = c.__TS__SourceMapTraceBack
g(
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
		["24"] = 21,
		["25"] = 21,
		["26"] = 21,
		["27"] = 21,
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
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
h.modifier_custom_snowman = d()
local l = h.modifier_custom_snowman
l.name = "modifier_custom_snowman"
e(l, j)
function l.prototype.OnCreated(self, m)
	if IsServer() then
		print("modifier_snowman OnCreated")
	else
	end
end
function l.prototype.OnDestroy(self)
	if IsServer() then
		print("modifier_snowman OnDestroy")
		local n = ParticleManager:CreateParticle(
			"particles/econ/events/snowman/snowman_death.vpcf",
			PATTACH_ABSORIGIN,
			self:GetParent()
		)
	else
	end
end
function l.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE }
end
function l.prototype.GetModifierModelChange(self)
	return "models/props_frostivus/frostivus_snowman.vmdl"
end
l = f(
	{
		k(
			nil,
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
	l
)
h.modifier_custom_snowman = l
return h