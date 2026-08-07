--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_holy_shield_retaliate"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_holy_shield_retaliate"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.enableTime = GameRules:GetGameTime()
end
function j.prototype.OnCreated(self)
	self:SetStackCount(0)
end
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			local m = self:GetCaster()
			if IsValid(l.attacker) and l.target == m and m:GetShield() > 0 then
				local n = self:GetSpecialValueFor("trigger_count")
				self:IncrementStackCount()
				if self:GetStackCount() >= n then
					if self.enableTime > GameRules:GetGameTime() then
						return
					end
					self:SetStackCount(0)
					self.enableTime = GameRules:GetGameTime() + COUNTER_CD
					local o = l.attacker
					local p = self:GetSpecialValueFor("damage")
					local q = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_mars/mars_shield_bash_crit.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					local r = CalcDirection(l.attacker, m)
					local s = Vector(0, 0, 1)
					local t = s:Cross(r):Normalized()
					ParticleManager:SetParticleControl(q, 1, l.attacker:GetAbsOrigin())
					ParticleManager:SetParticleControlOrientationFLU(q, 1, r, t, s)
					ParticleManager:ReleaseParticleIndex(q)
					m:DealDamage(o, nil, p)
					m:EmitSound("Hero_DragonKnight.DragonTail.DragonFormCast")
				end
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f