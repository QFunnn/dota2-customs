--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_explosion"
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
m.name = "enemy_explosion"
d(m, h)
function m.prototype.GetIntrinsicModifierName(self)
	return "modifier_enemy_explosion"
end
m = e({ i(nil) }, m)
local n = c()
n.name = "modifier_enemy_explosion"
d(n, k)
function n.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.delay = 0
end
function n.prototype.GetAbilitySpecialValue(self)
	self.delay = self:GetAbilitySpecialValueFor("delay")
end
function n.prototype.EventListener(self)
	return {
		entity_killed = function(o, p)
			if IsServer() and p.victim == self.parent then
				CreateModifierThinker(
					self.parent,
					self:GetAbility(),
					"modifier_enemy_explosion_thinker",
					{ duration = self.delay },
					self.parent:GetAbsOrigin(),
					self.parent:GetTeamNumber(),
					false
				)
			end
		end,
	}
end
n = e(
	{ l(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	n
)
local q = c()
q.name = "modifier_enemy_explosion_thinker"
d(q, k)
function q.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.damage = 0
	self.ally_damage = 0
	self.radius = 0
end
function q.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.ally_damage = self:GetAbilitySpecialValueFor("ally_damage")
	self.radius = self:GetAbilitySpecialValueFor("radius")
end
function q.prototype.OnCreated(self, r)
	if IsServer() then
		local s = self.parent:GetAbsOrigin()
		local t = ParticleManager:CreateParticle("particles/warning/circular.vpcf", PATTACH_WORLDORIGIN, self.parent)
		ParticleManager:SetParticleControl(t, 0, s)
		ParticleManager:SetParticleControl(t, 1, s)
		ParticleManager:SetParticleControl(t, 2, Vector(self.radius, self:GetDuration(), 0))
	end
end
function q.prototype.OnDestroy(self)
	if IsServer() then
		local u = self:GetParent()
		u:EmitSound("Hero_LifeStealer.Consume")
		local t = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_explode.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			u
		)
		ParticleManager:SetParticleControl(t, 1, Vector(self.radius, self.radius, self.radius))
		ParticleManager:ReleaseParticleIndex(t)
		local v = FindEnemiesInRadius(u, u:GetAbsOrigin(), self.radius)
		for w, x in ipairs(v) do
			if x:IsFriendly(u) then
				u:DealDamage(x, self.ability, self.ally_damage)
			else
				u:DealDamage(x, self.ability, self.damage)
			end
		end
		u:RemoveSelf()
	end
end
function q.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_INVULNERABLE] = true }
end
q = e(
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
	q
)
return f