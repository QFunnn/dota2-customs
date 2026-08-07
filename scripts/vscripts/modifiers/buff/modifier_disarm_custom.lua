--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_disarm_custom"
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
		["20"] = 18,
		["21"] = 19,
		["22"] = 20,
		["23"] = 20,
		["24"] = 20,
		["25"] = 20,
		["26"] = 20,
		["27"] = 20,
		["28"] = 20,
		["29"] = 20,
		["31"] = 14,
		["32"] = 24,
		["33"] = 25,
		["34"] = 26,
		["36"] = 24,
		["37"] = 29,
		["38"] = 30,
		["39"] = 31,
		["40"] = 31,
		["41"] = 31,
		["42"] = 31,
		["43"] = 31,
		["44"] = 31,
		["46"] = 29,
		["47"] = 34,
		["48"] = 35,
		["49"] = 34,
		["50"] = 37,
		["51"] = 38,
		["52"] = 37,
		["53"] = 13,
		["54"] = 4,
		["55"] = 4,
		["56"] = 4,
		["57"] = 4,
		["58"] = 4,
		["59"] = 4,
		["60"] = 4,
		["61"] = 4,
		["62"] = 4,
		["63"] = 13,
		["65"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_disarm_custom = c()
local k = g.modifier_disarm_custom
k.name = "modifier_disarm_custom"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:StartIntervalThink(l.duration)
	else
		local m = self:GetParent()
		local n = ParticleManager:CreateParticle("particles/items2_fx/heavens_halberd.vpcf", PATTACH_ABSORIGIN, m)
		self:AddParticle(n, false, false, -1, false, false)
	end
end
function k.prototype.OnRefresh(self, l)
	if IsServer() then
		self:StartIntervalThink(l.duration)
	end
end
function k.prototype.OnDestroy(self)
	if IsServer() then
		CombatLog:recordState(self:GetParent(), nil, "Disarm", "loss")
	end
end
function k.prototype.OnIntervalThink(self)
	self:Destroy()
end
function k.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
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
g.modifier_disarm_custom = k
return g