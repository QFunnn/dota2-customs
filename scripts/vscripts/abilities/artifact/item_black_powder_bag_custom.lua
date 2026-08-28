--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_black_powder_bag_custom"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_black_powder_bag_custom"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.enableTime = GameRules:GetGameTime()
end
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			local m = self:GetCaster()
			if m ~= l.target then
				return
			end
			if self.enableTime > GameRules:GetGameTime() then
				return
			end
			if not self:IsCooldownReady() then
				return
			end
			local n = self:GetSpecialValueFor("damage")
			local o = self:GetSpecialValueFor("distance")
			self.enableTime = GameRules:GetGameTime() + COUNTER_CD
			self:UseCooldown()
			local p = FindEnemiesInRadius(m, m:GetAbsOrigin(), o)
			for q, r in ipairs(p) do
				m:DealDamage(r, nil, n)
				r:KnockBack(CalcDirection2D(r, m), 200, 0, 0.3)
			end
			local s =
				ParticleManager:CreateParticle("particles/items3_fx/black_powder_bag.vpcf", PATTACH_ABSORIGIN_FOLLOW, m)
			ParticleManager:SetParticleControl(s, 5, m:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(s)
			m:EmitSound("Hero_Sniper.ConcussiveGrenade")
		end,
	}
end
j = e({ i(nil) }, j)
return f