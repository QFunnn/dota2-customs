--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_ice_dash"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.registerAbility
local i = require("modifiers.eom_modifier.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("abilities.eom_ability")
local m = l.AbilityValue
local n = l.EOMItem
local o = c()
o.name = "item_ice_dash"
d(o, n)
function o.prototype.EventListener(self)
	return {
		dash_start = function(p, q)
			local r = self:GetCaster()
			if q.caster == r then
				r:AddNewModifier(r, self, "modifier_item_ice_dash", { duration = 2 })
			end
		end,
		dash_end = function(p, q)
			local r = self:GetCaster()
			if q.caster == r then
				r:RemoveModifierByName("modifier_item_ice_dash")
			end
		end,
	}
end
o = e({ h(nil) }, o)
local s = c()
s.name = "modifier_item_ice_dash"
d(s, j)
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
				u:Frozen(A, self.frozen)
				u:DealDamage(A, v, self.damage, nil, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE)
			end,
		})
	else
		local D = ParticleManager:CreateParticle(
			"particles/econ/events/winter_major_2017/force_staff_wm07.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControlEnt(D, 0, u, PATTACH_POINT_FOLLOW, "attach_hitloc", u:GetAbsOrigin(), true)
		self:AddParticle(D, false, false, -1, false, false)
	end
end
function s.prototype.OnDestroy(self)
	if IsServer() and self.bulletID then
		Bullet:DestroyBulletByID(self.bulletID)
	end
end
e({ m(nil) }, s.prototype, "frozen", nil)
e({ m(nil) }, s.prototype, "damage", nil)
s = e(
	{
		k(
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