--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_treant/boss_treant_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMAbility
local l = j.registerEOMAbility
local m = c()
m.name = "boss_treant_1"
d(m, k)
function m.prototype.OnAbilityPhaseStart(self)
	local n = self:GetCaster()
	local o = self:GetCursorPosition()
	local p = CalcDirection2D(o, n)
	local q = n:GetAbsOrigin()
	local r = self:GetCastRange(vec3_zero, nil)
	local s = q + p * r
	self:LineWarning(q, s, 100, self:GetCastPoint())
	return true
end
function m.prototype.OnSpellStart(self)
	local n = self:GetCaster()
	local o = self:GetCursorPosition()
	local p = CalcDirection2D(o, n)
	local r = self:GetCastRange(vec3_zero, nil)
	local t = self:GetSpecialValueFor("duration")
	local u = self:GetSpecialValueFor("damage")
	Bullet:CreateLinearBullet({
		caster = n,
		spawnOrigin = n:GetAbsOrigin(),
		direction = p,
		moveSpeed = r,
		distance = r,
		interval = 0.12,
		radius = 100,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		OnIntervalThink = function(v)
			CreateModifierThinker(
				n,
				self,
				"modifier_boss_treant_1_thinker",
				{ duration = t },
				v.__position,
				n:GetTeamNumber(),
				false
			)
		end,
		OnBulletHit = function(w)
			n:DealDamage(w, self, u)
		end,
	})
	n:EmitSound("Hero_Treant.NaturesGrasp.Cast")
end
m = e({ l(nil) }, m)
local x = c()
x.name = "modifier_boss_treant_1_thinker"
d(x, h)
function x.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.interval = 0.2
end
function x.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.radius = self:GetAbilitySpecialValueFor("radius")
end
function x.prototype.OnCreated(self, y)
	local z = self:GetParent()
	if IsServer() then
		self:StartIntervalThink(self.interval)
		self:OnIntervalThink()
	else
		local A = ParticleManager:CreateParticle("particles/units/enemy/treant_bramble.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(A, 0, z:GetAbsOrigin())
		ParticleManager:SetParticleControl(A, 2, Vector(self:GetDuration(), 0, 0))
		ParticleManager:ReleaseParticleIndex(A)
	end
end
function x.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():RemoveSelf()
	end
end
function x.prototype.OnIntervalThink(self)
	local n = self:GetCaster()
	if not IsValid(n) then
		self:Destroy()
		return
	end
	local z = self:GetParent()
	local B = self:GetAbility()
	local C = FindEnemiesInRadius(z, z:GetAbsOrigin(), self.radius)
	for D, E in ipairs(C) do
		E:AddNewModifier(n, B, "modifier_boss_treant_1_movespeed", { duration = self.interval })
	end
end
function x.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
x = e(
	{
		i(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	x
)
local F = c()
F.name = "modifier_boss_treant_1_movespeed"
d(F, h)
function F.prototype.StaticProperty(self)
	return { [PropertyFunction.MOVESPEED_AMPLIFY] = -70 }
end
F = e(
	{
		i(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	F
)
return f