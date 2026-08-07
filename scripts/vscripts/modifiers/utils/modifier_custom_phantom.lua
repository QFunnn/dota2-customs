--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_custom_phantom"
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
		["18"] = 12,
		["19"] = 16,
		["20"] = 17,
		["22"] = 16,
		["23"] = 20,
		["24"] = 21,
		["25"] = 22,
		["26"] = 20,
		["27"] = 26,
		["28"] = 27,
		["29"] = 27,
		["30"] = 27,
		["31"] = 27,
		["32"] = 27,
		["33"] = 27,
		["34"] = 27,
		["35"] = 27,
		["36"] = 26,
		["37"] = 32,
		["38"] = 33,
		["39"] = 33,
		["40"] = 33,
		["41"] = 33,
		["42"] = 33,
		["43"] = 33,
		["44"] = 33,
		["45"] = 32,
		["46"] = 11,
		["47"] = 3,
		["48"] = 3,
		["49"] = 3,
		["50"] = 3,
		["51"] = 3,
		["52"] = 3,
		["53"] = 3,
		["54"] = 3,
		["55"] = 11,
		["57"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_custom_phantom = c()
local k = g.modifier_custom_phantom
k.name = "modifier_custom_phantom"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
	end
end
function k.prototype.OnDestroy(self)
	if IsServer() then
	end
end
function k.prototype.EDeclareEvents(self)
	local m = self:GetParent()
	return { [MODIFIER_EVENT_ON_ATTACK_LANDED] = { m, -1 } }
end
function k.prototype.OnAttackLanded(self, l)
	FireModifierEvent(
		EOMModifierEvents.MODIFIER_EVENT_ON_ILLUSION_ATTACK,
		{ attacker = self:GetParent(), target = l.target },
		self:GetCaster()
	)
end
function k.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
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
g.modifier_custom_phantom = k
return g