--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_pyrrhic_cloak_custom"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_pyrrhic_cloak_custom"
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
			self.enableTime = GameRules:GetGameTime() + COUNTER_CD
			self:UseCooldown()
			self:FanOfKnives()
		end,
	}
end
function j.prototype.FanOfKnives(self)
	local m = self:GetCaster()
	local n = self:GetSpecialValueFor("dagger_count")
	local o = self:GetSpecialValueFor("dagger_distance")
	local p = self:GetSpecialValueFor("dagger_width")
	local q = self:GetSpecialValueFor("dagger_speed")
	local r = self:GetSpecialValueFor("dagger_damage")
	local s = self:GetForwardVector()
	Bullet:SplitAction(s, n, 360 / n, function(k, t)
		Bullet:CreateLinearBullet({
			ability = self,
			caster = m,
			effectName = "particles/units/heroes/hero_phantom_assassin/phantom_assassin_2_dagger.vpcf",
			spawnOrigin = m:GetAttachmentPosition("attach_hitloc"),
			direction = t,
			moveSpeed = q,
			distance = o,
			radius = p,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			OnBulletHit = function(u, v, w)
				m:DealDamage(u, self, r, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE)
			end,
		})
	end)
end
j = e({ i(nil) }, j)
return f