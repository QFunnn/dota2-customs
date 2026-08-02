--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/solthra/solthra_3"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.ability_ai")
local k = j.EOMAbilityAI
local l = require("abilities.eom_ability")
local m = l.registerEOMAbility
local n = c()
n.name = "solthra_3"
d(n, k)
function n.prototype.GetCastCooldown(self)
	return 0.5
end
function n.prototype.GetCooldown(self, o)
	return math.max(k.prototype.GetCooldown(self, o) - self:GetSpecialValueFor("cooldown_reduction"), 0)
end
function n.prototype.OnSpellStart(self)
	local p = self:GetCaster()
	p:AddNewModifier(p, self, "modifier_solthra_3", { duration = self:GetSpecialValueFor("duration") })
	p:EmitSound("Hero_Lina.FlameCloak.Cast")
end
n = e({ m(nil, {
	funcCondition = function(q, r)
		return r:GetAutoCastState()
	end,
}) }, n)
local s = c()
s.name = "modifier_solthra_3"
d(s, h)
function s.prototype.GetAbilitySpecialValue(self)
	self.aura_radius = self:GetAbilitySpecialValueFor("aura_radius")
	self.shield = self:GetAbilitySpecialValueFor("shield")
	self.shield_attenuation_reduction = self:GetAbilitySpecialValueFor("shield_attenuation_reduction")
	self.spell_amp = self:GetAbilitySpecialValueFor("spell_amp")
	self.mana_regen = self:GetAbilitySpecialValueFor("mana_regen")
	self.attack_interval = self:GetAbilitySpecialValueFor("attack_interval")
	self.fire_ball_interval = self:GetAbilitySpecialValueFor("fire_ball_interval")
	self.shild_ball_damage_boost = self:GetAbilitySpecialValueFor("shild_ball_damage_boost")
	self.ring_speed_amplify = self:GetAbilitySpecialValueFor("ring_speed_amplify")
	local t = self:GetAbilitySpecialValueFor("shield_pct")
	if t > 0 then
		self.shield = self.shield * (1 + t * 0.01)
	end
end
function s.prototype.GetAuraRadius(self)
	return self.aura_radius
end
function s.prototype.GetModifierAura(self)
	return "modifier_solthra_3_buff"
end
function s.prototype.OnCreated(self, u)
	local v = self:GetParent()
	if IsServer() then
		v:AddShield(self.shield, "modifier_solthra_3", "override")
		if self.attack_interval > 0 then
			self:StartThink(self.attack_interval, "attack_interval")
			self:OnThink("attack_interval")
		end
		if self.fire_ball_interval > 0 then
			self:StartThink(self.fire_ball_interval, "fire_ball_interval")
		end
	else
		local w = ParticleManager:CreateParticle(
			"particles/econ/items/ember_spirit/ember_ti9/ember_ti9_flameguard.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			v
		)
		ParticleManager:SetParticleControlEnt(w, 1, v, PATTACH_ABSORIGIN_FOLLOW, nil, v:GetAbsOrigin(), true)
		ParticleManager:SetParticleControl(w, 2, Vector(self.aura_radius, 1, 1))
		self:AddParticle(w, false, false, -1, false, false)
	end
end
function s.prototype.OnThink(self, x)
	if x == "attack_interval" then
		local v = self:GetParent()
		local y = v:GetAbilityByTag(AbilityTag.Attack)
		if IsValid(y) then
			local z = FindEnemiesInRadius(v, v:GetAbsOrigin(), self.aura_radius)
			local A = IsValid(z[1]) and z[1]:GetAbsOrigin() or v:GetAbsOrigin() + RandomVector(100)
			y:StartAttack({ caster = v, position = A, damage = y:GetSpecialValueFor("damage"), isAOEAttack = true })
		end
	end
	if x == "fire_ball_interval" then
		local v = self:GetParent()
		local B = v:GetAbilityByTag(AbilityTag.Skill)
		if IsValid(B) then
			local z = FindEnemiesInRadius(v, v:GetAbsOrigin(), self.aura_radius)
			local A = IsValid(z[1]) and z[1]:GetAbsOrigin() or v:GetAbsOrigin() + RandomVector(100)
			local C = CalcDirection(A, v:GetAbsOrigin())
			local D = B:GetSpecialValueFor("damage") * self.shild_ball_damage_boost * 0.01
			B:CreateAttack(v:GetAttachmentPosition("attach_hitloc"), C, z[1], D, DoUniqueString("solthra_1"))
		end
	end
end
function s.prototype.OnRefresh(self, u)
	if IsServer() then
		local v = self:GetParent()
		v:AddShield(self.shield, "modifier_solthra_3", "override")
	end
end
function s.prototype.OnDestroy(self)
	if IsServer() then
		local v = self:GetParent()
		v:RemoveShield("modifier_solthra_3")
	end
end
function s.prototype.StaticProperty(self)
	return {
		[PropertyFunction.SHIELD_ATTENUATION_REDUCTION] = self.shield_attenuation_reduction,
		[PropertyFunction.SPELL_DAMAGE_AMPLIFY] = self.spell_amp,
		[PropertyFunction.FURY_REGEN] = self.mana_regen,
		[PropertyFunction.RING_SPEED_AMPLIFY] = self.ring_speed_amplify,
	}
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
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
				IsAura = true,
				GetAuraSearchFlags = DOTA_UNIT_TARGET_FLAG_NONE,
				GetAuraSearchTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
				GetAuraSearchType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			}
		),
	},
	s
)
local E = c()
E.name = "modifier_solthra_3_buff"
d(E, h)
function E.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.shield_pct = self:GetAbilitySpecialValueFor("shield_pct")
end
function E.prototype.OnCreated(self, u)
	if IsServer() then
		self:StartIntervalThink(self.interval)
	end
end
function E.prototype.OnIntervalThink(self)
	if IsServer() then
		local p = self:GetCaster()
		if not IsValid(p) then
			self:Destroy()
			return
		end
		if self.shield_pct > 0 then
			self.parent:ReduceShield(self.parent:GetMaxHealth() * self.shield_pct * 0.02, nil, true)
		end
		p:DealDamage(self.parent, self.ability, self.damage * self.interval)
	end
end
E = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	E
)
return f