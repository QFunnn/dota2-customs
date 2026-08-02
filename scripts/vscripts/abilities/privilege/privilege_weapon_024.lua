--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_weapon_024"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_weapon_024"
d(j, h)
function j.prototype.EventListener(self)
	return {
		GameModeStarted = function(k, l)
			local m = self:GetSpecialValueFor("rarity")
			local n = self:GetUnavailableArtifactNames()
			Artifact:AppendCurrentGameModeExcludedArtifacts(n)
			local o = DrawPool:PickShopItemNameByRarity(m, n)
			if o == nil then
				o = DrawPool:Draw("items", n)
			end
			local p = self:GetCaster()
			if o ~= nil and IsValid(p) then
				p:AddItemByName(o, m)
				local q = p:GetPlayerID()
				Notification:CombatToPlayer(
					q,
					{ message = "Notify_privilege_weapon_024", item_name = o, item_name_rarity = m }
				)
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f