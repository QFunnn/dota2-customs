--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_017"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_bless_017"
d(j, h)
function j.prototype.EventListener(self)
	return {
		regen_well_trigger = function(k, l)
			local m = self:GetCaster()
			if not IsValid(m) or m ~= l.target then
				return
			end
			local n = self:GetSpecialValueFor("lucky_chance") or 0
			local o = RollPercentage(n) and self:GetSpecialValueFor("lucky_count")
				or self:GetSpecialValueFor("base_count")
			local p = self:GetPlayerID()
			do
				local q = 0
				while q < o do
					local r = RandomInt(1, 5)
					if r == 1 then
						Bless:DrawBlessSelection(p, 3)
					elseif r == 2 then
						BlessUpgrade:RequestEnqueueBlessUpgrade(p, 3)
					elseif r == 3 then
						Artifact:RequestEnqueueArtifactSelection(p, 3)
					elseif r == 4 then
						m:AddItemByName("item_gold_pouch_single")
					elseif r == 5 then
						m:AddItemByName("item_hammer_weapon_single")
					end
					q = q + 1
				end
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f