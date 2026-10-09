--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_weapon_021"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_weapon_021"
d(j, h)
function j.prototype.OnCreated(self)
	self:RefreshBonus()
	print(string.format("[%s] Player %d privilege created", self.privilegeName, self:GetPlayerID()))
end
function j.prototype.OnRefresh(self)
	h.prototype.OnRefresh(self)
	self:RefreshBonus()
	print(string.format("[%s] Player %d privilege refreshed", self.privilegeName, self:GetPlayerID()))
end
function j.prototype.OnDestroy(self)
	h.prototype.OnDestroy(self)
	print(string.format("[%s] Player %d privilege destroyed", self.privilegeName, self:GetPlayerID()))
end
function j.prototype.EventListener(self)
	return {
		bless_suit_changed = function(k, l)
			if l.playerID ~= self:GetPlayerID() then
				return
			end
			self:RefreshBonus()
		end,
	}
end
function j.prototype.RefreshBonus(self)
	local m = self:GetCaster()
	if not IsValid(m) then
		return
	end
	local n = Bless:GetSuitLevel(self:GetPlayerID(), "crit")
	local o = n * self:GetSpecialValueFor("attack_scale")
	PropertySystem:AddStaticProperty(m:entindex(), "attack", self.privilegeName, o)
end
j = e({ i(nil) }, j)
return f