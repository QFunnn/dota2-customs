--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_gem_suit_014"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g
local h = require("abilities.eom_privilege")
local i = h.EOMPrivilege
local j = h.RegisterPrivilege
local k = require("modifiers.eom_modifier.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = c()
n.name = "privilege_gem_suit_014"
d(n, i)
function n.prototype.EventListener(self)
	return {
		ability_cast_complete = function(o, p)
			local q = self:GetCaster()
			if p.caster ~= q or p.abilityTag ~= AbilityTag.Defense or not IsValid(q) then
				return
			end
			q:AddNewModifier(
				q,
				nil,
				g.name,
				{ duration = self:GetSpecialValueFor("duration"), value = self:GetSpecialValueFor("value") }
			)
		end,
	}
end
function n.prototype.OnDestroy(self)
	local q = self:GetCaster()
	if IsValid(q) then
		q:RemoveModifierByName(g.name)
	end
	i.prototype.OnDestroy(self)
end
n = e({ j(nil) }, n)
g = c()
g.name = "modifier_privilege_gem_suit_014"
d(g, l)
function g.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.value = 0
end
function g.prototype.OnCreated(self, r)
	self.value = toFiniteNumber(r.value)
end
function g.prototype.OnRefresh(self, r)
	self.value = toFiniteNumber(r.value)
end
function g.prototype.StaticProperty(self)
	return { [PropertyFunction.SKILL_DAMAGE_BOOST] = self.value }
end
g = e(
	{
		m(
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