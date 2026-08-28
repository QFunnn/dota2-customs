--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_bleed_fury_blessing"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_bleed_fury_blessing"
d(j, h)
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			local m = self:GetCaster()
			if m ~= l.attacker then
				return
			end
			if l.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then
				return
			end
			if not self:IsCooldownReady() then
				return
			end
			local n = self:GetSpecialValueFor("damage_pct")
			local o = m:GetAttackDamage() * n * 0.01
			m:Bleed(l.target, o)
			self:StartCooldown(self:GetSpecialValueFor("cd"))
		end,
	}
end
j = e({ i(nil) }, j)
return f