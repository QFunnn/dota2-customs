--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_self_explosion"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.BaseAbility
local i = g.registerAbility
local j = require("modifiers.eom_modifier.eom_modifier")
local k = j.EOMModifier
local l = j.registerEOMModifier
local m = c()
m.name = "enemy_self_explosion"
d(m, h)
function m.prototype.GetIntrinsicModifierName(self)
	return "modifier_enemy_self_explosion"
end
m = e({ i(nil) }, m)
local n = c()
n.name = "modifier_enemy_self_explosion"
d(n, k)
function n.prototype.GetAbilitySpecialValue(self)
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.delay = self:GetAbilitySpecialValueFor("delay")
end
function n.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = self:GetElapsedTime() < 1 }
end
function n.prototype.OnCreated(self, o)
	if IsServer() then
		self:StartIntervalThink(0.1)
	else
		local p = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_techies/techies_land_mine.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		self:AddParticle(p, false, false, -1, false, false)
	end
end
function n.prototype.OnIntervalThink(self)
	if IsServer() then
		if self:GetElapsedTime() < 1 then
			return
		end
		local q = self:GetParent()
		if q:IsAlive() == false then
			return
		end
		local r = FindEnemiesInRadius(q, q:GetAbsOrigin(), self.radius * 0.5)
		if #r > 0 then
			CreateModifierThinker(
				self.parent,
				self:GetAbility(),
				"modifier_enemy_explosion_thinker",
				{ duration = self.delay },
				self.parent:GetAbsOrigin(),
				self.parent:GetTeamNumber(),
				false
			)
			q:EmitSound("Hero_Broodmother.SpawnSpiderlingsCast")
			self:Destroy()
		end
	end
end
function n.prototype.OnDestroy(self)
	if IsServer() then
		local q = self:GetParent()
		if IsValid(q) then
			q:Kill(self.ability, q)
		end
	end
end
n = e(
	{ l(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	n
)
local s = c()
s.name = "modifier_enemy_explosion_thinker"
d(s, k)
function s.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.damage = 0
	self.radius = 0
end
function s.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.radius = self:GetAbilitySpecialValueFor("radius")
end
function s.prototype.OnCreated(self, o)
	if IsServer() then
		local t = self.parent:GetAbsOrigin()
		local u = ParticleManager:CreateParticle("particles/warning/circular.vpcf", PATTACH_WORLDORIGIN, self.parent)
		ParticleManager:SetParticleControl(u, 0, t)
		ParticleManager:SetParticleControl(u, 1, t)
		ParticleManager:SetParticleControl(u, 2, Vector(self.radius, self:GetDuration(), 0))
	end
end
function s.prototype.OnDestroy(self)
	if IsServer() then
		local q = self:GetParent()
		q:EmitSound("Hero_Broodmother.SpawnSpiderlings")
		local u = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_bristleback/bristleback_loadout.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			q
		)
		ParticleManager:ReleaseParticleIndex(u)
		local r = FindUnitsInRadiusWithAbility(q, q:GetAbsOrigin(), self.radius, self.ability)
		q:DealDamage(r, self.ability, self.damage)
		q:RemoveSelf()
	end
end
s = e(
	{
		l(
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
	s
)
return f