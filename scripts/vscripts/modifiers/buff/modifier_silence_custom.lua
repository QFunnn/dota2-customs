--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_silence_custom"
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
		["13"] = 13,
		["14"] = 4,
		["15"] = 13,
		["16"] = 14,
		["17"] = 15,
		["18"] = 16,
		["19"] = 16,
		["20"] = 16,
		["21"] = 16,
		["22"] = 16,
		["23"] = 16,
		["24"] = 17,
		["26"] = 19,
		["27"] = 20,
		["28"] = 21,
		["29"] = 21,
		["30"] = 21,
		["31"] = 21,
		["32"] = 21,
		["33"] = 21,
		["34"] = 21,
		["35"] = 21,
		["37"] = 14,
		["38"] = 25,
		["39"] = 26,
		["40"] = 27,
		["41"] = 28,
		["42"] = 28,
		["43"] = 28,
		["44"] = 28,
		["45"] = 28,
		["46"] = 28,
		["48"] = 25,
		["49"] = 31,
		["50"] = 32,
		["51"] = 33,
		["52"] = 33,
		["53"] = 33,
		["54"] = 33,
		["55"] = 33,
		["56"] = 33,
		["57"] = 34,
		["58"] = 34,
		["59"] = 34,
		["60"] = 34,
		["61"] = 34,
		["62"] = 34,
		["64"] = 31,
		["65"] = 37,
		["66"] = 38,
		["67"] = 37,
		["68"] = 40,
		["69"] = 41,
		["70"] = 40,
		["71"] = 13,
		["72"] = 4,
		["73"] = 4,
		["74"] = 4,
		["75"] = 4,
		["76"] = 4,
		["77"] = 4,
		["78"] = 4,
		["79"] = 4,
		["80"] = 4,
		["81"] = 13,
		["83"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_silence_custom = c()
local k = g.modifier_silence_custom
k.name = "modifier_silence_custom"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_SILENCE_ADD, {}, self:GetCaster(), self:GetParent())
		self:StartIntervalThink(l.duration)
	else
		local m = self:GetParent()
		local n = ParticleManager:CreateParticle(
			"particles/generic_gameplay/generic_silence.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			m
		)
		self:AddParticle(n, false, false, -1, false, true)
	end
end
function k.prototype.OnRefresh(self, l)
	if IsServer() then
		self:StartIntervalThink(l.duration)
		FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_SILENCE_ADD, {}, self:GetCaster(), self:GetParent())
	end
end
function k.prototype.OnDestroy(self)
	if IsServer() then
		CombatLog:recordState(self:GetParent(), nil, "Silence", "loss")
		FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_SILENCE_END, {}, self:GetCaster(), self:GetParent())
	end
end
function k.prototype.OnIntervalThink(self)
	self:Destroy()
end
function k.prototype.CheckState(self)
	return { [MODIFIER_STATE_SILENCED] = true }
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
				DestroyOnExpire = false,
			}
		),
	},
	k
)
g.modifier_silence_custom = k
return g