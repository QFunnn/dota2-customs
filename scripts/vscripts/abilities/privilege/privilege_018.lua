--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_018"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_018"
d(j, h)
function j.prototype.GetPriority(self)
	return 150
end
function j.prototype.EventListener(self)
	return {
		GameModeStarted = function(k, l)
			local m = self:GetPlayerID()
			if m == nil then
				print(("[Player] 玩家 " .. tostring(m)) .. " 无效")
				return
			end
			local n = SkillUpgrade:GetRandomUpgradeOptions(m)
			if #n <= 0 then
				print(("[Player] 玩家 " .. tostring(m)) .. " 没有可用升级效果")
				return
			end
			local o = n[math.floor(math.random() * #n) + 1]
			local p = PlayerResource:GetSelectedHeroEntity(m)
			if not IsValid(p) then
				print(("[Player] 玩家 " .. tostring(m)) .. " 没有可用英雄")
				return
			end
			SkillUpgrade:AddUpgradeToHero(p, o.id)
			Notification:CombatToPlayer(m, { message = "Notify_privilege_018", upgrade_id = o.id })
		end,
	}
end
j = e({ i(nil) }, j)
return f