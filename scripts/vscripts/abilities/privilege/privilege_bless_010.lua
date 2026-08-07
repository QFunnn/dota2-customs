--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_010"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_bless_010"
d(j, h)
function j.prototype.EventListener(self)
	return {
		GameModeStarted = function()
			local k = self:GetCaster()
			if not k then
				return
			end
			local l = Bless:DrawBlessBySuit(self.playerID, "Wind", 1)
			if #l == 0 then
				print("[privilege_bless_010] 没有找到符合条件的御风祝福")
				return
			end
			local m = l[1]
			local n = Bless:GetBlessRarityRange(m)
			local o, p = unpack(n, 1, 2)
			local q = {}
			do
				local r = o
				while r <= p do
					if r >= 2 then
						q[#q + 1] = r
					end
					r = r + 1
				end
			end
			local s = GetRandomElement(q) or p
			Bless:AddBless(k, { name = m, rarity = s })
			local t = self:GetPlayerID()
			Notification:CombatToPlayer(
				t,
				{ message = "Notify_privilege_bless_010", item_name = m, item_name_rarity = s }
			)
		end,
	}
end
j = e({ i(nil) }, j)
return f