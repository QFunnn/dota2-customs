--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_dragon_egg"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_dragon_egg"
d(j, h)
function j.prototype.OnCreated(self)
	self:SetStackCount(self:GetSpecialValueFor("kill"))
end
function j.prototype.EventListener(self)
	return {
		entity_killed = function(k, l)
			if l.attacker == self:GetCaster() and self:GetStackCount() > 0 then
				self:DecrementStackCount()
				if self:GetStackCount() <= 0 then
					local m = self:GetCaster()
					Notification:Combat({
						message = "Notify_item_artifact_upgrade",
						player_id = l.attacker:GetPlayerOwnerID(),
						item_name = "item_dragon_egg",
						item_name_rarity = 3,
						item_name2 = "item_dragon_baby",
						item_name2_rarity = 4,
					})
					local n = m:AddItemByName("item_dragon_baby", 4)
					if IsValid(n) then
						Event:Fire(
							"dragon_egg_hatched",
							{
								playerID = m:GetPlayerOwnerID(),
								hero = m,
								babyItemName = n:GetAbilityName(),
								babyRarity = n:GetLevel(),
								baseCount = 1,
							}
						)
					end
					m:RemoveItem(self)
				end
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f