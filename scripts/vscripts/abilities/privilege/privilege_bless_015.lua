--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_015"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__ArrayPushArray
local g = b.__TS__DecorateLegacy
local h = {}
local i = require("abilities.eom_privilege")
local j = i.EOMPrivilege
local k = i.RegisterPrivilege
local l = c()
l.name = "privilege_bless_015"
d(l, j)
function l.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.factor = 1
	self.BallList = {}
end
function l.prototype.GetCircleRadius(self)
	return self:GetCaster():Script_GetAttackRange() * self.factor
end
function l.prototype.OnDestroy(self)
	e(self.BallList, function(m, n)
		Bullet:DestroyBulletByID(n)
	end)
end
function l.prototype.EventListener(self)
	return {
		dungeon_room_complete = function(m, o)
			if o.room:GetRoomType() ~= RoomType.BOSS then
				return
			end
			local p = {
				fire = "particles/econ/items/invoker/invoker_ti6/invoker_ti6_immolation_orb.vpcf",
				ice = "particles/econ/items/invoker/invoker_ti6/invoker_ti6_quas_orb.vpcf",
				lightning = "particles/econ/items/invoker/invoker_ti6/invoker_ti6_exort_orb.vpcf",
			}
			local q = self:GetSpecialValueFor("ball_count")
			local r = self:GetCaster()
			self.factor = r:IsRangedAttacker() and 0.6 or 1
			local s = ({ "fire", "ice", "lightning" })[RandomInt(0, 2) + 1]
			local t = p[s]
			local u = Bullet:CreateGroupSurroundBullet(q, {
				caster = r,
				group = "privilege_bless_015" .. tostring(r:entindex()),
				circleRadius = self:GetCircleRadius(),
				angularVelocity = self:GetSpecialValueFor("speed"),
				offset = 128,
				interval = 1,
				teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
				typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				radius = 100,
				OnBulletThink = function(v, w)
					if w.circleRadius < self:GetCircleRadius() then
						w.circleRadius = w.circleRadius + 1
					end
				end,
				ParticleCreator = function(w)
					local x = ParticleManager:CreateParticle(t, PATTACH_CUSTOMORIGIN, nil)
					ParticleManager:SetParticleControl(x, 0, r:GetAbsOrigin())
					ParticleManager:SetParticleControl(x, 2, r:GetAbsOrigin())
					ParticleManager:SetParticleControl(x, 3, r:GetAbsOrigin())
					ParticleManager:SetParticleControlEnt(
						x,
						1,
						w.__thinker,
						PATTACH_ABSORIGIN_FOLLOW,
						nil,
						w.__thinker:GetAbsOrigin(),
						true
					)
					return x
				end,
				OnBulletHit = function(y, z, A)
					r:DealDamage(
						y,
						nil,
						self:GetSpecialValueFor("damage"),
						EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
						EOM_DAMAGE_FLAGS.RING_DAMAGE
					)
				end,
			})
			f(self.BallList, u)
		end,
	}
end
l = g({ k(nil) }, l)
return h