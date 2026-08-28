--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_suit_029"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayFilter
local g = {}
local h
local i = require("lib.tstl-utils")
local j = i.reloadable
local k = require("modifiers.eom_modifier.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = require("abilities.eom_privilege")
local o = n.EOMPrivilege
local p = n.RegisterPrivilege
local q = c()
q.name = "privilege_suit_029"
d(q, o)
function q.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.exposeBuffer = 0
end
function q.prototype.EventListener(self)
	return {
		expose_event = function(r, s)
			local t = self:GetCaster()
			if s.caster ~= t then
				return
			end
			self.exposeBuffer = self.exposeBuffer + s.addStack
			local u = self:GetSpecialValueFor("stack_per_bonus")
			while self.exposeBuffer >= u do
				self.exposeBuffer = self.exposeBuffer - u
				t:AddNewModifier(t, nil, h.name, { duration = self:GetSpecialValueFor("duration") })
			end
		end,
	}
end
q = e({ j, p(nil) }, q)
h = c()
h.name = "modifier_privilege_suit_029_stack"
d(h, l)
function h.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.expiredTimes = {}
end
function h.prototype.OnCreated(self, v)
	if IsServer() then
		self.stackLimit = Privilege:GetPrivilegeSpecialValue("privilege_suit_029", 1, "stack_limit", nil)
		self.damagePerStack = Privilege:GetPrivilegeSpecialValue("privilege_suit_029", 1, "damage_per_stack", nil)
		if self:GetStackCount() < self.stackLimit then
			self:IncrementStackCount()
		end
		local w = self.expiredTimes
		w[#w + 1] = self:GetElapsedTime() + self:GetDuration()
		self:StartIntervalThink(1)
	end
end
function h.prototype.OnRefresh(self, v)
	if IsServer() then
		if self:GetStackCount() < self.stackLimit then
			self:IncrementStackCount()
		end
		local x = self.expiredTimes
		x[#x + 1] = self:GetElapsedTime() + self:GetDuration()
	end
end
function h.prototype.OnIntervalThink(self)
	if not self:GetParent():IsAlive() then
		self:StartIntervalThink(-1)
		return
	end
	local y = self:GetElapsedTime()
	local z = 0
	for r, A in ipairs(self.expiredTimes) do
		if A <= y then
			z = z + 1
		end
	end
	if z > 0 then
		self.expiredTimes = f(self.expiredTimes, function(r, B)
			return B > y
		end)
		local C = math.max(0, self:GetStackCount() - z)
		self:SetStackCount(C)
		if C <= 0 then
			self:Destroy()
		end
	end
end
function h.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.LIGHTNING_DAMAGE_AMPLIFY] = function()
			return self:GetStackCount() * self.damagePerStack
		end,
		[PropertyFunction.SHOCK_DAMAGE_AMPLIFY] = function()
			return self:GetStackCount() * self.damagePerStack
		end,
	}
end
h = e(
	{
		m(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	h
)
return g