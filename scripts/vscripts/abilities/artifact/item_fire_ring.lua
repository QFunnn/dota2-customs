--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_fire_ring"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("abilities.eom_ability")
local i = h.EOMItem
local j = h.registerEOMAbility
local k = c()
k.name = "item_fire_ring"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.bulletList = {}
	self.factor = 1
end
function k.prototype.GetCircleRadius(self, l)
	if l == nil then
		if not IsValid(self) then
			return 0
		end
		l = self:GetCaster()
	end
	if not IsValid(l) then
		return 0
	end
	return l:Script_GetAttackRange() * self.factor
end
function k.prototype.EventListener(self)
	return {
		property_changed = function(m, n)
			if not IsValid(self) then
				return
			end
			local l = self:GetCaster()
			if not IsValid(l) or n.key ~= l:entindex() then
				return
			end
			if n.propertyId == "ring_count" then
				self:OnDestroy()
				self:OnCreated()
			elseif n.propertyId == "ring_speed_amplify" then
				local o = Bullet.surroundGroup["element_ring" .. tostring(l:entindex())]
				if o ~= nil then
					o.angularVelocity = self:GetSpecialValueFor("speed")
				end
			end
		end,
		dungeon_room_start = function()
			self:OnDestroy()
			self:OnCreated()
		end,
	}
end
function k.prototype.OnCreated(self)
	self:StartThink(1, "check", function()
		if #self.bulletList <= 0 then
			self:RefreshBullet()
		end
	end)
	self:RefreshBullet()
end
function k.prototype.OnDestroy(self)
	e(self.bulletList, function(m, p)
		Bullet:DestroyBulletByID(p)
	end)
	self.bulletList = {}
end
function k.prototype.RefreshBullet(self)
	local l = self:GetCaster()
	local q = self:GetSpecialValueFor("count")
	self.factor = l:IsRangedAttacker() and 0.6 or 1
	self.bulletList = Bullet:CreateGroupSurroundBullet(q, {
		caster = l,
		ability = self,
		group = "element_ring" .. tostring(l:entindex()),
		circleRadius = self:GetCircleRadius(l),
		angularVelocity = self:GetSpecialValueFor("speed"),
		offset = 128,
		interval = 1,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		radius = 100,
		OnBulletThink = function(r, s)
			local t = self:GetCircleRadius(l)
			if s.circleRadius < t then
				s.circleRadius = s.circleRadius + 1
			end
		end,
		ParticleCreator = function(s)
			local u = ParticleManager:CreateParticle(
				"particles/econ/items/invoker/invoker_ti6/invoker_ti6_exort_orb.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(u, 0, l:GetAbsOrigin())
			ParticleManager:SetParticleControl(u, 2, l:GetAbsOrigin())
			ParticleManager:SetParticleControl(u, 3, l:GetAbsOrigin())
			ParticleManager:SetParticleControlEnt(
				u,
				1,
				s.__thinker,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				s.__thinker:GetAbsOrigin(),
				true
			)
			return u
		end,
		OnBulletHit = function(v, w, x)
			if not IsValid(l) or not IsValid(self) then
				return
			end
			l:DealDamage(
				v,
				self,
				self:GetSpecialValueFor("damage"),
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
				EOM_DAMAGE_FLAGS.RING_DAMAGE
			)
		end,
	})
end
k = f({ j(nil) }, k)
return g