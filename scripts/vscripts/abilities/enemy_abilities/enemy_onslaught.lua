--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_onslaught"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifierMotionHorizontal
local i = g.registerEOMModifier
local j = require("abilities.bt_ability_ai")
local k = j.EOMBTAbilityAI
local l = require("abilities.eom_ability")
local m = l.registerEOMAbility
local n = c()
n.name = "enemy_onslaught"
d(n, k)
function n.prototype.GetLinearStartWidth(self)
	return self:GetSpecialValueFor("width")
end
function n.prototype.OnAbilityPhaseStart(self)
	local o = self:GetCaster()
	self.width = self:GetSpecialValueFor("width")
	local p = o:GetAbsOrigin()
	self.direction = CalcDirection(self:GetCursorPosition(), p)
	local q = p + self.direction * self:GetCastRange(vec3_zero, nil)
	self:LineWarning(p, q, self.width, self:GetCastPoint())
	o:EmitSound("Hero_PrimalBeast.Onslaught.Cast")
	return true
end
function n.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticle(true)
end
function n.prototype.OnSpellStart(self)
	self:DestroyWarningParticle()
	local o = self:GetCaster()
	local r = self:GetSpecialValueFor("speed")
	local s = self:GetCastRange(vec3_zero, nil)
	o:AddNewModifier(
		o,
		self,
		"modifier_enemy_onslaught",
		{ direction = VectorToString(self.direction), duration = s / r }
	)
end
n = e({ m(nil) }, n)
local t = c()
t.name = "modifier_enemy_onslaught"
d(t, h)
function t.prototype.GetAbilitySpecialValue(self)
	self.width = self:GetAbilitySpecialValueFor("width")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.speed = self:GetAbilitySpecialValueFor("speed")
end
function t.prototype.OnCreated(self, u)
	self.hit_target = false
	if IsServer() then
		self.direction = StringToVector(u.direction)
		self:ApplyHorizontalMotionController()
		self.bulletID = Bullet:CreateLinearBullet({
			caster = self.parent,
			direction = self.direction,
			distance = self.speed * self:GetDuration(),
			moveSpeed = self.speed,
			radius = self.width,
			ability = self.ability,
			spawnOrigin = self.parent:GetAbsOrigin(),
			interval = 0.3,
			OnBulletHit = function(v, w, x)
				self.hit_target = true
				self.parent:DealDamage(v, self.ability, self.damage)
				v:KnockBack(CalcDirection2D(v, w), 200, 100, 0.5)
				self.parent:EmitSound("Hero_PrimalBeast.Onslaught.Hit")
			end,
		})
	end
end
function t.prototype.OnDestroy(self)
	if IsServer() then
		local y = self:GetParent()
		y:RemoveHorizontalMotionController(self)
		if self.bulletID ~= nil then
			Bullet:DestroyBulletByID(self.bulletID)
		end
		if self.hit_target then
			y:Stagger(1.5, ACT_DOTA_CAST_ABILITY_4, 1.2)
		else
			y:Stagger(1.5, ACT_DOTA_VICTORY, 1.2)
		end
	end
end
function t.prototype.UpdateHorizontalMotion(self, y, z)
	if not IsServer() or not IsValid(y) then
		return
	end
	local A = y:GetAbsOrigin() + self.direction * self.speed * z
	if not GridNav:IsTraversable(A) or GridNav:IsBlocked(A) then
		self:Destroy()
		return
	end
	y:SetAbsOrigin(A)
end
function t.prototype.OnHorizontalMotionInterrupted(self)
	if not IsServer() then
		return
	end
	self:Destroy()
end
function t.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_SILENCED] = true }
end
function t.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
end
function t.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_RUN
end
function t.prototype.GetOverrideAnimationRate(self)
	return 1.5
end
function t.prototype.GetActivityTranslationModifiers(self)
	return "haste"
end
t = e(
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
	t
)
return f