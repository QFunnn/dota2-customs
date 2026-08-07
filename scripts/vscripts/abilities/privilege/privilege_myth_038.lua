--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_038"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_privilege")
local k = j.EOMPrivilege
local l = j.PrivilegeValue
local m = j.RegisterPrivilege
local n = c()
n.name = "privilege_myth_038"
d(n, k)
function n.prototype.EventListener(self)
	return {
		dash_start = function(o, p)
			local q = self:GetCaster()
			if p.caster == q then
				local r = q:GetShield() * self.value * 0.01
				q:AddNewModifier(q, nil, "privilege_myth_038_dash", { duration = 2, damage = r })
			end
		end,
		dash_end = function(o, p)
			local q = self:GetCaster()
			if p.caster == q then
				q:RemoveModifierByName("modifier_item_ice_dash")
			end
		end,
	}
end
e({ l(nil) }, n.prototype, "value", nil)
n = e({ m(nil) }, n)
local s = c()
s.name = "privilege_myth_038_dash"
d(s, h)
function s.prototype.OnCreated(self, t)
	local u = self:GetParent()
	if IsServer() then
		local v = self:GetAbility()
		self.bulletID = Bullet:CreateCustomBullet({
			caster = u,
			spawnOrigin = u:GetAbsOrigin(),
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			radius = 160,
			lifeTime = self:GetDuration(),
			PathFunction = function(w, x)
				return u:GetAbsOrigin()
			end,
			FuncUnitFinder = function(y, w, z, x)
				return FindUnitsInRadius(
					u:GetTeamNumber(),
					w,
					nil,
					z,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
			end,
			OnBulletHit = function(A, B, C)
				u:DealDamage(A, nil, t.damage, nil, EOM_DAMAGE_FLAGS.SHIELD_DAMAGE)
			end,
		})
	else
	end
end
function s.prototype.OnDestroy(self)
	if IsServer() and self.bulletID then
		Bullet:DestroyBulletByID(self.bulletID)
	end
end
s = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	s
)
return f