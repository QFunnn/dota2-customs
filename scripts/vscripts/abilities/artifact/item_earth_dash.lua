--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_earth_dash"
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
k.name = "item_earth_dash"
d(k, i)
function k.prototype.OnCreated(self)
	if IsServer() then
		self.bulletGroup = {}
	end
end
function k.prototype.EventListener(self)
	return {
		dash_start = function(l, m)
			local n = self:GetCaster()
			if m.caster ~= n then
				return
			end
			local o = self:GetSpecialValueFor("bullet_radius")
			local p = self:GetSpecialValueFor("life_time")
			local q = self
			local r = Bullet:CreateGroupSurroundBullet(1, {
				lifeTime = p,
				caster = n,
				ability = q,
				effectName = "particles/abilities/item_earth_dash.vpcf",
				circleRadius = 200,
				radius = o,
				angularVelocity = 200,
				offset = 80,
				group = "earth" .. tostring(self:entindex()),
				OnBulletCreated = function(s)
					if s.__particleID ~= nil then
						ParticleManager:SetParticleControlEnt(
							s.__particleID,
							1,
							n,
							PATTACH_ABSORIGIN_FOLLOW,
							nil,
							n:GetAbsOrigin(),
							false
						)
					end
				end,
				OnBulletThink = function(t, u)
					local v = Bullet:GetBulletInRadius(t, o)
					for w, s in ipairs(v) do
						if IsValid(s.caster) and not s.caster:IsFriendly(n) then
							Bullet:DestroyBulletByID(s.__projIndex)
						end
					end
				end,
				OnBulletHit = function(x, t, s)
					if not IsValid(q) then
						return
					end
					local y = q:GetSpecialValueFor("damage")
					n:DealDamage(x, q, y, nil, EOM_DAMAGE_FLAGS.RING_DAMAGE)
					n:EmitSound("Hero_mars.Shield.Cast.Small")
				end,
				OnBulletDestroy = function(m)
					ArrayRemove(self.bulletGroup, m.__projIndex)
				end,
			})
			for w = #self.bulletGroup, 0, -1 do
				local z = self.bulletGroup[w + 1]
				if Bullet:GetBulletData(z) == nil then
					table.remove(self.bulletGroup, w)
				end
			end
			self.bulletGroup = e(self.bulletGroup, r)
		end,
	}
end
k = f({ j(nil) }, k)
return g