--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_charge_slash"
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
n.name = "enemy_charge_slash"
d(n, k)
function n.prototype.OnSpellStart(self)
	local o = self:GetCaster()
	local p = self:GetSpecialValueFor("duration")
	o:AddNewModifier(o, self, "modifier_enemy_charge_slash", { duration = p })
end
function n.prototype.SlashPhase(self, q, r, s, p, t, u, v)
	if u == nil then
		u = 1
	end
	local o = self:GetCaster()
	if not IsValid(o) or not o:IsAlive() then
		return
	end
	local w = o:GetAbsOrigin() + q * 100
	local x = self:GetSpecialValueFor("speed")
	local y = self:GetSpecialValueFor("distance")
	local z = self:GetSpecialValueFor("width")
	if t > 0 then
		self:LineWarning(w, w + q * y, z, z, t)
	end
	o:SimulateCast({
		castAnimation = r,
		castPoint = s,
		duration = p,
		animationRate = u,
		OnSpellStart = function()
			self:DestroyWarningParticle(true)
			Bullet:CreateLinearBullet({
				ability = self,
				caster = o,
				effectName = "particles/units/enemy/enemy_slash.vpcf",
				spawnOrigin = w,
				direction = q,
				moveSpeed = x,
				distance = y,
				radius = z,
				teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
				typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				OnBulletHit = function(A, B, C)
					o:DealDamage(A, self, self:GetSpecialValueFor("damage"))
				end,
			})
			o:EmitSound("Hero_Juggernaut.BladeDance")
		end,
		OnFinish = function()
			o:RemoveGesture(r)
			if v then
				v(nil, q)
			end
		end,
	})
end
function n.prototype.Slash1(self, q)
	local o = self:GetCaster()
	local w = o:GetAbsOrigin() + q * 100
	local y = self:GetSpecialValueFor("distance")
	local z = self:GetSpecialValueFor("width")
	self:LineWarning(w, w + q * y, z, z, 0.8 + 0.37)
	o:SimulateCast({
		castAnimation = ACT_SCRIPT_CUSTOM_1,
		duration = 0.8,
		OnFinish = function()
			self:SlashPhase(q, ACT_SCRIPT_CUSTOM_2, 0.01, 0.65, 0, 1, function(D, E)
				return self:Slash2(E)
			end)
		end,
	})
end
function n.prototype.Slash2(self, q)
	self:SlashPhase(q, ACT_SCRIPT_CUSTOM_4, 0.4, 0.93, 0.4, 1, function(D, E)
		return self:Slash3(E)
	end)
end
function n.prototype.Slash3(self, q)
	self:SlashPhase(q, ACT_SCRIPT_CUSTOM_4, 0.2, 0.5, 0.2, 2)
end
n = e({ m(nil) }, n)
local F = c()
F.name = "modifier_enemy_charge_slash"
d(F, h)
function F.prototype.GetAbilitySpecialValue(self)
	self.movespeed_min = self:GetAbilitySpecialValueFor("movespeed_min")
	self.movespeed_max = self:GetAbilitySpecialValueFor("movespeed_max")
end
function F.prototype.OnCreated(self, G)
	self.startTime = GameRules:GetGameTime()
	if IsServer() then
		self:StartIntervalThink(0.3)
	else
		local H = ParticleManager:CreateParticle(
			"particles/econ/items/spirit_breaker/spirit_breaker_iron_surge/spirit_breaker_charge_iron.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		self:AddParticle(H, false, false, -1, false, false)
	end
end
function F.prototype.OnIntervalThink(self)
	local I = self:GetParent()
	local J = self:GetAbility()
	if IsValid(J) then
		local K = FindUnitsInRadiusWithAbility(I, I:GetAbsOrigin(), 300, J)
		if #K > 0 then
			local w = I:GetAbsOrigin()
			local L = CalcDirection(K[1]:GetAbsOrigin(), w)
			self.ability:Slash1(L)
			self:Destroy()
		end
	end
end
function F.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT }
end
function F.prototype.GetModifierMoveSpeedBonus_Constant(self)
	local M = GameRules:GetGameTime() - self.startTime
	return math.min(self.movespeed_min + 300 * M, self.movespeed_max)
end
function F.prototype.StaticDeclare(self)
	return { [MODIFIER_PROPERTY_OVERRIDE_ANIMATION] = ACT_SCRIPT_CUSTOM_0 }
end
function F.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_SILENCED] = true }
end
F = e(
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
	F
)
return f