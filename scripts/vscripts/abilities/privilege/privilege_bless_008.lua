--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_008"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.PrivilegeValue
local j = g.RegisterPrivilege
local k = c()
k.name = "privilege_bless_008"
d(k, h)
function k.prototype.StaticProperty(self)
	return { [PropertyFunction.TRAP_INCOMING_DAMAGE_AMPLIFY] = self:GetSpecialValueFor("incoming_damage_reduce") }
end
function k.prototype.EventListener(self)
	return {
		npc_first_spawned = function(l, m)
			local n = self:GetCaster()
			if (n and n:GetTeamNumber()) == m.unit:GetTeamNumber() then
				return
			end
			if m.unit:IsCreep() or m.unit:IsBoss() or m.unit:IsElite() then
				m.unit:AddProperty(PropertyFunction.TRAP_INCOMING_DAMAGE_AMPLIFY, self.enemy_damage_amplify)
			end
		end,
	}
end
e({ i(nil) }, k.prototype, "incoming_damage_reduce", nil)
e({ i(nil) }, k.prototype, "enemy_damage_amplify", nil)
k = e({ j(nil) }, k)
return f