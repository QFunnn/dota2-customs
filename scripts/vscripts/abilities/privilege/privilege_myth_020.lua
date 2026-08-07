--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_020"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g
local h = require("modifiers.eom_modifier.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = h.TransmitterData
local l = require("abilities.eom_privilege")
local m = l.EOMPrivilege
local n = l.PrivilegeValue
local o = l.RegisterPrivilege
local p = c()
p.name = "privilege_myth_020"
d(p, m)
function p.prototype.EventListener(self)
	return {
		damage_event = function(q, r)
			local s = self:GetCaster()
			if
				r.attacker == s
				and not r.target:IsBoss()
				and BitAndEquals(r.damage_flags, EOM_DAMAGE_FLAGS.POISON_DAMAGE)
			then
				r.target:AddNewModifier(
					s,
					nil,
					g.name,
					{ value = self.value, duration = self:GetSpecialValueFor("duration") }
				)
			end
		end,
	}
end
e({ n(nil) }, p.prototype, "value", nil)
p = e({ o(nil) }, p)
g = c()
g.name = "modifier_privilege_myth_020"
d(g, i)
function g.prototype.OnCreated(self, t)
	if IsServer() then
		self.stack_limit = Privilege:GetPrivilegeSpecialValue("privilege_myth_020", 1, "stack_limit", nil)
		self.value = t.value
		self:IncrementStackCount()
	end
end
function g.prototype.OnRefresh(self, t)
	if IsServer() then
		if self:GetStackCount() < self.stack_limit then
			self:IncrementStackCount()
		end
	end
end
function g.prototype.StaticProperty(self)
	return { [PropertyFunction.DAMAGE_AMPLIFY] = -toFiniteNumber(self.value) * self:GetStackCount() }
end
e({ k(nil) }, g.prototype, "value", nil)
g = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	g
)
return f