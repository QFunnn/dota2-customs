--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/christmas_tree"
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
		["14"] = 4,
		["15"] = 9,
		["16"] = 10,
		["17"] = 9,
		["18"] = 10,
		["19"] = 11,
		["20"] = 12,
		["21"] = 13,
		["22"] = 14,
		["24"] = 11,
		["25"] = 17,
		["26"] = 18,
		["27"] = 17,
		["28"] = 10,
		["29"] = 9,
		["30"] = 10,
		["32"] = 10,
		["33"] = 22,
		["34"] = 29,
		["35"] = 22,
		["36"] = 29,
		["37"] = 31,
		["38"] = 32,
		["39"] = 33,
		["41"] = 31,
		["42"] = 36,
		["43"] = 37,
		["44"] = 36,
		["45"] = 41,
		["46"] = 42,
		["47"] = 41,
		["48"] = 48,
		["49"] = 49,
		["50"] = 50,
		["51"] = 51,
		["53"] = 48,
		["54"] = 54,
		["55"] = 55,
		["56"] = 56,
		["57"] = 57,
		["58"] = 58,
		["59"] = 59,
		["62"] = 54,
		["63"] = 63,
		["64"] = 64,
		["65"] = 65,
		["68"] = 68,
		["69"] = 69,
		["71"] = 71,
		["74"] = 63,
		["75"] = 29,
		["76"] = 22,
		["77"] = 22,
		["78"] = 22,
		["79"] = 22,
		["80"] = 22,
		["81"] = 22,
		["82"] = 22,
		["83"] = 29,
		["85"] = 29,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = {
	undestroyed = "frostivus_ancient_undestroyed",
	destroying = "frostivus_ancient_destroy",
	destroyed = "frostivus_ancient_destroy",
}
g.christmas_tree = c()
local o = g.christmas_tree
o.name = "christmas_tree"
d(o, i)
function o.prototype.Spawn(self)
	if IsServer() then
		self:GetCaster():SetSequence(n.undestroyed)
		self:SetLevel(1)
	end
end
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_christmas_tree"
end
o = e({ j(nil) }, o)
g.christmas_tree = o
g.modifier_christmas_tree = c()
local p = g.modifier_christmas_tree
p.name = "modifier_christmas_tree"
d(p, l)
function p.prototype.OnCreated(self, q)
	if IsServer() then
		self.count = RandomInt(5, 10)
	end
end
function p.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_NO_HEALTH_BAR] = true }
end
function p.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_HEALTH_BAR] = true, [MODIFIER_STATE_INVULNERABLE] = true }
end
function p.prototype.OnIntervalThink(self)
	if IsServer() then
		self:GetParent():SetSequence(n.destroyed)
		self:StartIntervalThink(-1)
	end
end
function p.prototype.OnStackCountChanged(self, r)
	if IsServer() then
		if self:GetStackCount() == 1 then
			self:GetParent():SetModel("models/props_frostivus/frostivus_ancient/frostivus_ancient_destruction.vmdl")
			self:GetParent():SetSequence(n.destroying)
			self:StartIntervalThink(5)
		end
	end
end
function p.prototype.SnowBall(self)
	if IsServer() then
		if self:GetStackCount() == 1 then
			return
		end
		if self.count <= 0 then
			self:SetStackCount(1)
		else
			self.count = self.count - 1
		end
	end
end
p = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
g.modifier_christmas_tree = p
return g