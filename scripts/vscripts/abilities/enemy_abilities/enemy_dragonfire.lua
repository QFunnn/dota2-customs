--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_dragonfire"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
local g = {}
local h = require("modifiers.eom_modifier.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = require("abilities.bt_ability_ai")
local l = k.EOMBTAbilityAI
local m = require("abilities.eom_ability")
local n = m.registerEOMAbility
local o = c()
o.name = "enemy_dragonfire"
d(o, l)
function o.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("radius")
end
function o.prototype.OnAbilityPhaseStart(self)
	local p = self:GetCursorPosition()
	self:CreateRadiusWarningParticle(p)
	return true
end
function o.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticle(true)
end
function o.prototype.OnSpellStart(self)
	self:DestroyWarningParticle()
	local q = self:GetCaster()
	local p = self:GetCursorPosition()
	local r = self:GetSpecialValueFor("duration")
	q:EmitSound("Hero_DragonKnight.Fireball.Cast")
	CreateModifierThinker(q, self, "modifier_enemy_dragonfire_thinker", { duration = r }, p, q:GetTeamNumber(), false)
end
o = e({ n(nil) }, o)
local s = c()
s.name = "modifier_enemy_dragonfire_thinker"
d(s, i)
function s.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.radius = 0
	self.debuff_duration = 0
	self.interval = 0
end
function s.prototype.GetAbilitySpecialValue(self)
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.debuff_duration = self:GetAbilitySpecialValueFor("debuff_duration")
	self.interval = self:GetAbilitySpecialValueFor("interval")
end
function s.prototype.OnCreated(self, t)
	if IsServer() then
		self:StartIntervalThink(self.interval)
	else
		local u = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_dragon_knight/dragon_knight_shard_fireball.vpcf",
			PATTACH_CUSTOMORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControl(u, 0, self.parent:GetAbsOrigin())
		ParticleManager:SetParticleControl(u, 1, self.parent:GetAbsOrigin())
		ParticleManager:SetParticleControl(u, 2, Vector(self:GetDuration(), 0, 0))
		self:AddParticle(u, false, false, -1, false, false)
	end
end
function s.prototype.OnRefresh(self, t)
	if IsServer() then
	end
end
function s.prototype.OnDestroy(self)
	if IsServer() then
	end
end
function s.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
function s.prototype.OnIntervalThink(self)
	local v = self:GetParent()
	local w = self:GetAbility()
	local x = v:GetAbsOrigin()
	local y = FindUnitsInRadiusWithAbility(v, x, self.radius, w)
	f(y, function(z, A)
		A:AddNewModifier(v, w, "modifier_enemy_dragonfire", { duration = self.debuff_duration })
	end)
end
s = e(
	{
		j(
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
local B = c()
B.name = "modifier_enemy_dragonfire"
d(B, i)
function B.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.damage = 0
	self.interval = 0
end
function B.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.interval = self:GetAbilitySpecialValueFor("interval")
end
function B.prototype.OnCreated(self, t)
	if IsServer() then
		print(self.interval)
		self:StartIntervalThink(self.interval)
	end
end
function B.prototype.OnRefresh(self, t)
	if IsServer() then
	end
end
function B.prototype.OnIntervalThink(self)
	if IsServer() then
		local q = self:GetCaster()
		if IsValid(q) then
			q:DealDamage(self:GetParent(), self:GetAbility(), self.damage * self.interval)
		end
	end
end
B = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = true,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	B
)
return g