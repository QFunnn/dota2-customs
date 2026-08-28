--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_decision_whip"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_artifact_decision_whip"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.interval = self:GetSpecialValueFor("interval")
	self.radius = self:GetSpecialValueFor("radius")
	self.chance = self:GetSpecialValueFor("chance")
end
function j.prototype.OnCreated(self)
	self:StartThink(self.interval, "bomb_interval", function()
		local k = self:GetCaster()
		for l, m in pairs(Bullet.surroundGroup) do
			for n, o in ipairs(m.bulletList) do
				local p = Bullet:GetBulletData(o)
				local q = FindEnemiesInRadius(k, p.__position, self.radius)
				local r = GetRandomElement(q)
				if r then
					k:LightningStrike(r, self:GetSpecialValueFor("damage"))
				end
			end
		end
	end)
end
j = e({ i(nil) }, j)
return f