--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_zeus_holy"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFilter
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("abilities.eom_ability")
local i = h.EOMItem
local j = h.registerEOMAbility
local k = c()
k.name = "item_zeus_holy"
d(k, i)
function k.prototype.OnCreated(self)
	self:StartThink(self:GetSpecialValueFor("interval"), function()
		local l = self:GetCaster()
		if l:IsAlive() then
			local m = self:GetSpecialValueFor("damage")
			local n = self:GetSpecialValueFor("radius")
			Bullet:CreateRingBullet({
				caster = l,
				spawnOrigin = l:GetAbsOrigin(),
				followEntity = l,
				lifeTime = 2,
				width = 100,
				moveSpeed = n,
				interval = 1,
				teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
				typeFilter = UNIT_AND_BUILDING,
				OnIntervalThink = function(o)
					if o.__particleID ~= nil then
						ParticleManager:SetParticleControl(o.__particleID, 1, Vector(n, 0, 0))
					end
					o.moveSpeed = -n
					o.__hitRecord = {}
					return -1
				end,
				OnBulletThink = function(p, o)
					local q = e(Bullet:GetBulletInRadius(l:GetAbsOrigin(), o.__radius + o.width), function(r, s)
						return (s.__position - l:GetAbsOrigin()):Length2D() >= o.__radius
					end)
					l:ShootDown(q)
				end,
				ParticleCreator = function(o)
					local t = ParticleManager:CreateParticle(
						"particles/units/benediction/razor_plasmafield.vpcf",
						PATTACH_ABSORIGIN_FOLLOW,
						l
					)
					ParticleManager:SetParticleControl(t, 1, Vector(n, n, 0))
					return t
				end,
				OnBulletHit = function(u, o, v)
					l:DealDamage(u, self, m, nil, EOM_DAMAGE_FLAGS.LIGHTNING_DAMAGE)
				end,
			})
			l:EmitSound("Ability.PlasmaField")
		end
		return self:GetSpecialValueFor("interval")
	end)
end
k = f({ j(nil) }, k)
return g