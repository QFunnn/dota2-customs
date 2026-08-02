--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/combo_events/modifier_cdreduce"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_combo_skill_cdreduce"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.cdReduce = 0
end
function j.prototype.OnCreated(self, k)
	if IsServer() then
		self.cdReduce = toFiniteNumber(k.cdreduce, 0)
		print("[modifier_combo_skill_cdreduce] created with cdReduce =", self.cdReduce)
	end
end
function j.prototype.StaticProperty(self)
	return { [PropertyFunction.SKILL_COOLDOWN_REDUCTION] = self.cdReduce }
end
j = e(
	{
		i(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	j
)
local l = c()
l.name = "modifier_combo_evade_cdreduce"
d(l, h)
function l.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.cdReduce = 0
end
function l.prototype.OnCreated(self, k)
	if IsServer() then
		self.cdReduce = toFiniteNumber(k.cdreduce, 0)
		print("[modifier_combo_evade_cdreduce] created with cdReduce =", self.cdReduce)
	end
end
function l.prototype.StaticProperty(self)
	return { [PropertyFunction.EVADE_COOLDOWN_REDUCTION] = self.cdReduce }
end
l = e(
	{
		i(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	l
)
local m = c()
m.name = "modifier_combo_block_cdreduce"
d(m, h)
function m.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.cdReduce = 0
end
function m.prototype.OnCreated(self, k)
	if IsServer() then
		self.cdReduce = toFiniteNumber(k.cdreduce, 0)
		print("[modifier_combo_block_cdreduce] created with cdReduce =", self.cdReduce)
	end
end
function m.prototype.StaticProperty(self)
	return { [PropertyFunction.BLOCK_COOLDOWN_REDUCTION] = self.cdReduce }
end
m = e(
	{
		i(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	m
)
local n = c()
n.name = "modifier_combo_ultimate_cdreduce"
d(n, h)
function n.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.cdReduce = 0
end
function n.prototype.OnCreated(self, k)
	if IsServer() then
		self.cdReduce = toFiniteNumber(k.cdreduce, 0)
		print("[modifier_combo_ultimate_cdreduce] created with cdReduce =", self.cdReduce)
	end
end
function n.prototype.StaticProperty(self)
	return { [PropertyFunction.ULTIMATE_COOLDOWN_REDUCTION] = self.cdReduce }
end
n = e(
	{
		i(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	n
)
return f