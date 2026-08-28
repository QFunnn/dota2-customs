--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_cosmetic_003"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFind
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("abilities.eom_privilege")
local i = h.EOMPrivilege
local j = h.RegisterPrivilege
local k = c()
k.name = "privilege_cosmetic_003"
d(k, i)
function k.prototype.OnCreated(self)
	Bless:ClearGuaranteedSuit(self.playerID)
	self:LoadGuaranteedSuit()
end
function k.prototype.EventListener(self)
	return {
		GameModeStarted = function()
			return self:LoadGuaranteedSuit()
		end,
	}
end
function k.prototype.LoadGuaranteedSuit(self)
	CommonService:CallAction("/v1/key/fetch", self.playerID, { type = "privilege_cosmetic_003" }, function(l, m, n)
		local o = toFiniteNumber(n.code, -1)
		if not self:IsValidPrivilege() or o ~= 0 and o ~= 200 then
			return
		end
		local p = n.data
		if p ~= nil then
			local q = n.data
			p = e(q and q.player_key_values, function(l, r)
				return r.key == "bless_suit"
			end)
		end
		local s = p and p.value
		Bless:SetGuaranteedSuit(self.playerID, s)
	end)
end
function k.prototype.OnDestroy(self)
	Bless:ClearGuaranteedSuit(self.playerID)
	i.prototype.OnDestroy(self)
end
k = f({ j(nil) }, k)
return g