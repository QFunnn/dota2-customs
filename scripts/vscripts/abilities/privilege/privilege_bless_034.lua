--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_034"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayIncludes
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("abilities.eom_privilege")
local i = h.EOMPrivilege
local j = h.RegisterPrivilege
local k = c()
k.name = "privilege_bless_034"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.damageBonus = 0
end
function k.prototype.EventListener(self)
	return {
		GameModeStarted = function(l, m)
			if m.modeId ~= GameModeEnum.Dungeon or not e(m.participantPlayerIds, self:GetPlayerID()) then
				return
			end
			local n = math.max
			local o = toFiniteNumber
			local p = Match:GetKey()
			local q = n(0, o(p and p.key_data.intensity))
			self.damageBonus = q * self:GetSpecialValueFor("damage_per_intensity")
		end,
		GameModeExited = function()
			self.damageBonus = 0
		end,
	}
end
function k.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.DAMAGE_BOOST_MULT] = function()
			return self.damageBonus
		end,
	}
end
k = f({ j(nil) }, k)
return g