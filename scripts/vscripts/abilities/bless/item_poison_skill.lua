--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_poison_skill"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_poison_skill"
d(j, h)
function j.prototype.EventListener(self)
	return {
		ability_cast_complete = function(k, l)
			if l.caster == self:GetCaster() and l.abilityTag == AbilityTag.Skill then
				local m = self:GetCaster()
				local n = CalcDirection(self:GetCursorPosition(), m:GetAbsOrigin())
				local o = self:GetSpecialValueFor("pulse_count")
				local p = self:GetSpecialValueFor("distance")
				local q = self:GetSpecialValueFor("speed")
				local r = self:GetSpecialValueFor("angular_velocity")
				Bullet:SplitAction(n, o, 360 / o, function(k, s)
					local t = {
						caster = m,
						direction = s,
						ability = self,
						effectName = "particles/units/benediction/necrolyte_pulse_enemy.vpcf",
						spawnOrigin = m:GetAttachmentPosition("attach_hitloc"),
						moveSpeed = q,
						radius = 100,
						lifeTime = p / q,
						angularVelocity = r,
						teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
						typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
						OnBulletHit = function(u, v, w)
							m:Poison(u, self:GetSpecialValueFor("poison"))
							return true
						end,
					}
					Bullet:CreateGuidedBullet(t)
				end)
				m:EmitSound("Hero_Necrolyte.DeathPulse")
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f