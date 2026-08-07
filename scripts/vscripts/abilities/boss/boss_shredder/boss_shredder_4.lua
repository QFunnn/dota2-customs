--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_shredder/boss_shredder_4"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "boss_shredder_4"
d(j, h)
function j.prototype.OnAbilityPhaseStart(self)
	local k = self:GetCaster()
	self:CircleWarning(k, self:GetSpecialValueFor("distance"), self:GetCastPoint())
	return true
end
function j.prototype.OnChannelFinish(self, l)
	self:StartThink(-1, "channel")
end
function j.prototype.OnSpellStart(self)
	local k = self:GetCaster()
	local m = k:GetForwardVector()
	self:Chakram(m)
	self:StartThink(1.5, "channel", function()
		m = Rotation2D(m, 30, true)
		self:Chakram(m)
	end)
end
function j.prototype.Chakram(self, m)
	local k = self:GetCaster()
	local n = k:GetAbsOrigin()
	local o = self:GetSpecialValueFor("distance")
	local p = self:GetSpecialValueFor("radius")
	local q = self:GetSpecialValueFor("damage")
	local r = k:FindAbilityByName("boss_shredder_1")
	Bullet:SplitAction(m, 3, 120, function(s, t)
		self:LineWarning(n + t * p, n + t * o, p, 1)
	end)
	self:StartThink(1, DoUniqueString("chakram"), function()
		k:EmitSound("Hero_Shredder.Chakram.Cast")
		Bullet:SplitAction(m, 3, 120, function(s, t)
			Bullet:CreateLinearBullet({
				caster = k,
				spawnOrigin = n + t * p,
				moveSpeed = o / 2,
				direction = t,
				distance = o,
				radius = p,
				ignoreBlock = true,
				reflectable = true,
				teamFilter = DOTA_UNIT_TARGET_TEAM_BOTH,
				typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				flagFilter = DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
				ParticleCreator = function(u)
					local v = ParticleManager:CreateParticle(
						"particles/econ/items/shredder/hero_shredder_icefx/shredder_chakram_ice.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					ParticleManager:SetParticleControl(v, 0, u.spawnOrigin)
					ParticleManager:SetParticleControl(v, 1, u.direction * u.distance / 2)
					return v
				end,
				OnBulletHit = function(w, x, u)
					if k:IsFriendly(w) then
						if IsValid(r) and w:GetUnitName() == "shredder_tree" then
							r:CutDownTree(w)
						end
					else
						k:DealDamage(w, self, q)
					end
				end,
			})
		end)
		return -1
	end)
end
j = e({ i(nil, {}) }, j)
return f