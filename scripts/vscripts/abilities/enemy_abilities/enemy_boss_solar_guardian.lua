--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_boss_solar_guardian"
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
n.name = "enemy_boss_solar_guardian"
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
	local q = self:GetSpecialValueFor("cast_duration")
	o:EmitSound("Hero_Dawnbreaker.Solar_Guardian.Channel")
	o:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	CreateModifierThinker(
		o,
		self,
		"modifier_enemy_boss_solar_guardian_thinker",
		{ duration = q, target_index = p:entindex() },
		p:GetAbsOrigin(),
		o:GetTeamNumber(),
		false
	)
end
n = e({ m(nil) }, n)
local r = c()
r.name = "modifier_enemy_boss_solar_guardian_thinker"
d(r, h)
function r.prototype.GetAbilitySpecialValue(self)
	self.move_speed = self:GetAbilitySpecialValueFor("move_speed")
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.airtime_duration = self:GetAbilitySpecialValueFor("airtime_duration")
end
function r.prototype.OnCreated(self, s)
	local o = self:GetCaster()
	if not IsValid(o) then
		self:Destroy()
		return
	end
	if IsServer() then
		local p = EntIndexToHScript(s.target_index)
		if not IsValid(p) then
			self:Destroy()
			return
		end
		self.target = p
		local t = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_aoe.vpcf",
			PATTACH_CUSTOMORIGIN_FOLLOW,
			self.parent
		)
		ParticleManager:SetParticleControl(t, 0, self.parent:GetAbsOrigin())
		ParticleManager:SetParticleControl(t, 1, self.parent:GetAbsOrigin())
		ParticleManager:SetParticleControl(t, 2, Vector(self.radius, 0, 0))
		self:AddParticle(t, false, false, -1, false, false)
		self.particleID = t
		self:StartIntervalThink(0.1)
	end
end
function r.prototype.OnIntervalThink(self)
	if IsServer() then
		local u = CalcDirection(self.target, self.parent)
		local v = self.parent:GetOrigin() + u * self.move_speed * 0.1
		v = GetGroundPosition(v, self.parent)
		self.parent:SetLocalOrigin(v)
		ParticleManager:SetParticleControl(self.particleID, 0, v)
		ParticleManager:SetParticleControl(self.particleID, 1, v)
	end
end
function r.prototype.OnDestroy(self)
	if IsServer() then
		local o = self:GetCaster()
		if not IsValid(o) then
			return
		end
		o:AddNewModifier(
			o,
			self.ability,
			"modifier_enemy_boss_solar_guardian",
			{ position = self:GetParent():GetAbsOrigin(), duration = self.airtime_duration }
		)
		self:GetParent():RemoveSelf()
	end
end
r = e(
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
	r
)
local w = c()
w.name = "modifier_enemy_boss_solar_guardian"
d(w, h)
function w.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_SILENCED] = true }
end
function w.prototype.GetAbilitySpecialValue(self)
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.stagger_duration = self:GetAbilitySpecialValueFor("stagger_duration")
end
function w.prototype.OnCreated(self, s)
	if IsServer() then
		local x = StringToVector(s.position)
		local u = CalcDirection(x, self.parent)
		local y = CalcDistance(x, self.parent)
		self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_4_END)
		self.parent:Dash(u, y, 1000, self:GetDuration())
		self.parent:EmitSound("Hero_Dawnbreaker.Solar_Guardian.BlastOff")
	end
end
function w.prototype.OnDestroy(self)
	if IsServer() then
		self.parent:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
		ParticleManager:CreateParticle(
			"particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_landing.vpcf",
			PATTACH_POINT,
			self.parent
		)
		local z = FindUnitsInRadiusWithAbility(self.parent, self.parent:GetAbsOrigin(), self.radius, self.ability)
		self.parent:DealDamage(z, self.ability, self.damage)
		self.parent:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_stagger",
			{ animation = ACT_DOTA_GENERIC_CHANNEL_1, duration = self.stagger_duration }
		)
	end
end
w = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	w
)
return f