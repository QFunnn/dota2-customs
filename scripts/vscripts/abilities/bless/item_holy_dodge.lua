--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_holy_dodge"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayConcat
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("abilities.eom_ability")
local i = h.EOMItem
local j = h.registerEOMAbility
local k = c()
k.name = "item_holy_dodge"
d(k, i)
function k.prototype.EventListener(self)
	return {
		dash_start = function(l, m)
			if m.caster == self:GetCaster() then
				self:CallShield()
			end
		end,
		dash_end = function(l, m)
			if m.caster == self:GetCaster() then
				self:OnDestroy()
			end
		end,
	}
end
function k.prototype.OnCreated(self)
	if IsServer() then
		self.bulletGroup = {}
	end
end
function k.prototype.CallShield(self)
	local n = self:GetCaster()
	local o = self:GetSpecialValueFor("damage")
	local p = self:GetSpecialValueFor("count")
	local q = self:GetSpecialValueFor("speed")
	local r = self
	local s = Bullet:CreateGroupSurroundBullet(p, {
		caster = n,
		ability = r,
		group = tostring(r:entindex()),
		circleRadius = 120,
		angularVelocity = q,
		offset = 100,
		lifeTime = 1,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		radius = 50,
		ParticleCreator = function(t)
			local u = ParticleManager:CreateParticle(
				"particles/units/faith_abilities/faith_earth_1_shield.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControlEnt(
				u,
				0,
				t.__thinker,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				t.__thinker:GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControlEnt(u, 1, n, PATTACH_ABSORIGIN_FOLLOW, nil, n:GetAbsOrigin(), true)
			ParticleManager:SetParticleControl(u, 3, Vector(100, 0, 0))
			ParticleManager:SetParticleControl(u, 8, Vector(5, 0, 0))
			return u
		end,
		OnBulletThink = function(v, t)
			local w = Bullet:GetBulletInRadius(t.__position, 50)
			n:ShootDown(w)
		end,
		OnBulletHit = function(x, t)
			n:DealDamage(x, self, o, nil, EOM_DAMAGE_FLAGS.RING_DAMAGE)
		end,
	})
	do
		local y = #self.bulletGroup - 1
		while y >= 0 do
			local z = self.bulletGroup[y + 1]
			if Bullet:GetBulletData(z) == nil then
				table.remove(self.bulletGroup, y)
			end
			y = y - 1
		end
	end
	self.bulletGroup = e(self.bulletGroup, s)
end
function k.prototype.OnDestroy(self)
	if IsServer() then
		for A, z in ipairs(self.bulletGroup) do
			Bullet:DestroyBulletByID(z)
		end
		self.bulletGroup = {}
	end
end
k = f({ j(nil) }, k)
return g