--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_suit_020"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__Delete
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
q.name = "privilege_suit_020"
d(q, o)
function q.prototype.EventListener(self)
	return {
		damage_event = function(r, s)
			local t = self:GetCaster()
			if s.attacker == t and bit.band(s.damage_flags, EOM_DAMAGE_FLAGS.BLADE) == EOM_DAMAGE_FLAGS.BLADE then
				t:AddNewModifier(
					t,
					nil,
					h.name,
					{ entityIdx = s.target:entindex(), duration = self:GetSpecialValueFor("duration") }
				)
			end
		end,
	}
end
q = e({ j, p(nil) }, q)
h = c()
h.name = "privilege_suit_020_modifier"
d(h, l)
function h.prototype.OnCreated(self, u)
	if IsServer() then
		self.limit_stack = Privilege:GetPrivilegeSpecialValue("privilege_suit_020", 1, "stack_limit", nil)
		self.damage_pct = Privilege:GetPrivilegeSpecialValue("privilege_suit_020", 1, "damage_pct", nil)
		self.stacks = {}
		self:AddStack(u.entityIdx)
		self:StartIntervalThink(1)
	end
end
function h.prototype.OnIntervalThink(self)
	if not self:GetParent():IsAlive() then
		self:StartIntervalThink(-1)
		return
	end
	local v = self:GetElapsedTime()
	local w = {}
	for x, s in pairs(self.stacks) do
		if s.expiredTime <= v then
			w[#w + 1] = x
		end
	end
	for r, y in ipairs(w) do
		f(self.stacks, y)
	end
end
function h.prototype.OnRefresh(self, u)
	if IsServer() then
		self:AddStack(u.entityIdx)
	end
end
function h.prototype.AddStack(self, x)
	if self.stacks[x] == nil then
		self.stacks[x] = { stack = 0, expiredTime = 0 }
	end
	self.stacks[x].stack = math.min(self.stacks[x].stack + 1, self.limit_stack)
	self.stacks[x].expiredTime = self:GetElapsedTime() + self:GetDuration()
end
function h.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.BLADE_DAMAGE_AMPLIFY] = function(r, s)
			if
				s
				and s.damage > 0
				and s.target
				and s.damage_flags
				and bit.band(s.damage_flags, EOM_DAMAGE_FLAGS.BLADE) == EOM_DAMAGE_FLAGS.BLADE
			then
				local z = s.target:entindex()
				if self.stacks[z] ~= nil then
					local A = self:GetParent():GetAttackDamage() * self.stacks[z].stack * self.damage_pct * 0.01
					return A / s.damage * 100
				end
			end
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