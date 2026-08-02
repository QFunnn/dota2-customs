--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_suit_023"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g
local h = require("lib.tstl-utils")
local i = h.reloadable
local j = require("modifiers.eom_modifier.eom_modifier")
local k = j.EOMModifier
local l = j.registerEOMModifier
local m = j.TransmitterData
local n = require("abilities.eom_privilege")
local o = n.EOMPrivilege
local p = n.RegisterPrivilege
local q = c()
q.name = "privilege_suit_023"
d(q, o)
function q.prototype.OnCreated(self)
	self.cd_reduce_pct = self:GetSpecialValueFor("cd_reduce_pct")
	self.damage_pct = self:GetSpecialValueFor("damage_pct")
	self.mana_consume_pct = self:GetSpecialValueFor("mana_consume_pct")
	local r = self:GetCaster()
	if IsValid(r) then
		r:AddNewModifier(
			r,
			nil,
			g.name,
			{ cd_reduce_pct = self.cd_reduce_pct, damage_pct = self.damage_pct, mana_consume_pct = -self.mana_consume_pct }
		)
	end
end
function q.prototype.OnDestroy(self)
	local r = self:GetCaster()
	if IsValid(r) then
		r:RemoveModifierByName(g.name)
	end
end
q = e({ i, p(nil) }, q)
g = c()
g.name = "modifier_privilege_suit_023"
d(g, k)
function g.prototype.OnCreated(self, s)
	if IsServer() then
		self.cd_reduce_pct = s.cd_reduce_pct
		self.damage_pct = s.damage_pct
		self.mana_consume_pct = s.mana_consume_pct
	end
end
function g.prototype.StaticProperty(self)
	return {
		[PropertyFunction.ULTIMATE_COOLDOWN_REDUCTION] = self.cd_reduce_pct,
		[PropertyFunction.ULTIMATE_DAMAGE_AMPLIFY] = self.damage_pct,
		[PropertyFunction.ULTIMATE_MANA_COST_REDUCE] = self.mana_consume_pct,
	}
end
e({ m(nil) }, g.prototype, "cd_reduce_pct", nil)
e({ m(nil) }, g.prototype, "damage_pct", nil)
e({ m(nil) }, g.prototype, "mana_consume_pct", nil)
g = e(
	{ l(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	g
)
return f