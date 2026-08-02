--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_boss_pugna_nether_blast"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.bt_ability_ai")
local k = j.EOMBTAbilityAI
local l = require("abilities.eom_ability")
local m = l.registerEOMAbility
local n = c()
n.name = "enemy_boss_pugna_nether_blast"
d(n, k)
function n.prototype.OnAbilityPhaseStart(self)
	return true
end
function n.prototype.OnSpellStart(self)
	local o = self:GetCaster()
	local p = self:GetCursorTarget()
	if not IsValid(p) then
		return
	end
	o:AddNewModifier(
		p,
		self,
		"modifier_enemy_boss_pugna_nether_blast",
		{ duration = self:GetSpecialValueFor("duration") }
	)
	o:EmitSound("Hero_Pugna.NetherBlastPreCast")
end
n = e({ m(nil) }, n)
local q = c()
q.name = "modifier_enemy_boss_pugna_nether_blast"
d(q, h)
function q.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.delay = self:GetAbilitySpecialValueFor("delay")
	self.speed = self:GetAbilitySpecialValueFor("speed")
end
function q.prototype.OnCreated(self, r)
	if IsServer() then
		local p = self:GetCaster()
		if not IsValid(p) then
			self:Destroy()
			return
		end
		self.target = p
		self.start_pos = p:GetAbsOrigin()
		self.forward = p:GetForwardVector()
		self:OnIntervalThink()
		self:StartIntervalThink(self.interval)
	end
end
function q.prototype.OnIntervalThink(self)
	if IsServer() then
		if not IsValid(self.target) then
			self:Destroy()
			return
		end
		local s = self.start_pos + self.forward * self.interval * self.speed * self:GetStackCount()
		CreateModifierThinker(
			self.parent,
			self.ability,
			"modifier_enemy_boss_pugna_nether_blast_thinker",
			{ duration = self.delay },
			s,
			self.parent:GetTeamNumber(),
			false
		)
		self:IncrementStackCount()
	end
end
function q.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_SILENCED] = true }
end
q = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
local t = c()
t.name = "modifier_enemy_boss_pugna_nether_blast_thinker"
d(t, h)
function t.prototype.GetAbilitySpecialValue(self)
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.blast_damage = self:GetAbilitySpecialValueFor("blast_damage")
end
function t.prototype.OnCreated(self, r)
	if IsServer() then
		local u = self.parent:GetAbsOrigin()
		local v = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_pugna/pugna_netherblast_pre.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(v, 0, u)
		ParticleManager:SetParticleControl(v, 1, Vector(self.radius, self:GetDuration(), 1))
		self:AddParticle(v, false, false, -1, false, false)
		local w = ParticleManager:CreateParticle("particles/warning/circular.vpcf", PATTACH_WORLDORIGIN, self.parent)
		ParticleManager:SetParticleControl(w, 0, u)
		ParticleManager:SetParticleControl(w, 1, u)
		ParticleManager:SetParticleControl(w, 2, Vector(self.radius, self:GetDuration(), 0))
		self:AddParticle(w, false, false, -1, false, false)
		EmitSoundOnLocationForAllies(self.parent:GetAbsOrigin(), "Hero_Pugna.NetherBlastPreCast", self.caster)
	end
end
function t.prototype.OnDestroy(self)
	if IsServer() then
		local x = self.parent:GetAbsOrigin()
		local v = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_pugna/pugna_netherblast.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(v, 0, x)
		ParticleManager:SetParticleControl(v, 1, Vector(self.radius, self.radius, self.radius))
		ParticleManager:ReleaseParticleIndex(v)
		if IsValid(self.caster) then
			local y =
				FindUnitsInRadiusWithAbility(self.parent, self.parent:GetAbsOrigin(), self.radius, self.ability, nil)
			self.caster:DealDamage(y, self.ability, self.blast_damage)
			EmitSoundOnLocationWithCaster(x, "Hero_Pugna.NetherBlast", self.caster)
		end
		self.parent:RemoveSelf()
	end
end
t = e(
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
	t
)
return f