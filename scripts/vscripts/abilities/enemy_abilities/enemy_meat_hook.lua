--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_meat_hook"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.EOMModifierMotionHorizontal
local j = g.registerEOMModifier
local k = require("abilities.eom_ability")
local l = k.EOMAbility
local m = k.registerEOMAbility
local n = c()
n.name = "enemy_meat_hook"
d(n, l)
function n.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.hookOffset = Vector(0, 0, 96)
end
function n.prototype.OnSpellStart(self)
	self:DestroyWarningParticles()
	local o = self:GetCaster()
	local p = o:GetAbsOrigin()
	local q = self:GetCursorPosition()
	local r = self:GetSpecialValueFor("hook_speed")
	local s = self:GetSpecialValueFor("hook_distance")
	local t = self:GetSpecialValueFor("hook_width")
	local u = CalcDirection(q, p)
	local v = p + u * s
	o:AddNewModifier(o, self, "modifier_enemy_meat_hook", { duration = s / r * 3 })
	o:EmitSound("Hero_Pudge.AttackHookExtend")
	local w = s / r * 3
	local x = Vector(w, 0, 0)
	local y =
		ParticleManager:CreateParticle("particles/units/heroes/hero_pudge/pudge_meathook.vpcf", PATTACH_CUSTOMORIGIN, o)
	ParticleManager:SetParticleAlwaysSimulate(y)
	ParticleManager:SetParticleControlEnt(
		y,
		0,
		o,
		PATTACH_POINT_FOLLOW,
		"attach_weapon_chain_rt",
		o:GetAbsOrigin() + self.hookOffset,
		true
	)
	ParticleManager:SetParticleControl(y, 1, v + self.hookOffset)
	ParticleManager:SetParticleControl(y, 2, Vector(r, s, t))
	ParticleManager:SetParticleControl(y, 3, x)
	ParticleManager:SetParticleControl(y, 4, Vector(1, 0, 0))
	ParticleManager:SetParticleControl(y, 5, Vector(0, 0, 0))
	Bullet:CreateLinearBullet({
		ability = self,
		caster = o,
		spawnOrigin = o:GetAttachmentPosition("attach_attack1"),
		direction = u,
		moveSpeed = r,
		distance = s,
		radius = t,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		OnBulletHit = function(z, A, B)
			z:EmitSound("Hero_Pudge.AttackHookImpact")
			z:AddNewModifier(
				o,
				self,
				"modifier_meat_hook_debuff",
				{ duration = math.max(0, CalcDistance(o, z) / r - 0.1) }
			)
			return true
		end,
		OnBulletDestroy = function(B)
			Bullet:CreateTrackingBullet({
				caster = o,
				ability = self,
				target = o,
				spawnOrigin = B.__position,
				moveSpeed = r,
				ignoreBlock = true,
				FuncUnitFinder = function()
					return { o }
				end,
				OnBulletThink = function(q, C)
					if CalcDistance(q, o) < 500 and not Bullet:GetData(C.__projIndex, "endanim", false) then
						o:StartGesture(ACT_DOTA_CHANNEL_ABILITY_1)
						Bullet:SaveData(C.__projIndex, "endanim", true)
					end
				end,
				ParticleCreator = function(C)
					ParticleManager:SetParticleControlEnt(
						y,
						1,
						o,
						PATTACH_POINT_FOLLOW,
						"attach_weapon_chain_rt",
						o:GetOrigin() + self.hookOffset,
						true
					)
					return y
				end,
				OnBulletDestroy = function(C)
					o:RemoveModifierByName("modifier_enemy_meat_hook")
					o:StopSound("Hero_Pudge.AttackHookExtend")
				end,
			})
		end,
	})
end
function n.prototype.OnAbilityPhaseStart(self)
	local p = self:GetCaster():GetAbsOrigin()
	local D = CalcDirection(self:GetCursorPosition(), p)
	local v = p + D * self:GetSpecialValueFor("hook_distance")
	self:LineWarning(p, v, self:GetSpecialValueFor("hook_width"), self:GetCastPoint())
	return true
end
function n.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles()
	self:GetCaster():RemoveGesture(ACT_DOTA_OVERRIDE_ABILITY_1)
end
n = e({ m(nil) }, n)
local E = c()
E.name = "modifier_meat_hook_debuff"
d(E, i)
function E.prototype.GetAbilitySpecialValue(self)
	self.speed = self:GetAbilitySpecialValueFor("hook_speed")
end
function E.prototype.OnCreated(self, F)
	if not IsServer() then
		return
	end
	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
		return
	end
end
function E.prototype.OnHorizontalMotionInterrupted(self)
	self:Destroy()
end
function E.prototype.UpdateHorizontalMotion(self, G, H)
	local o = self:GetCaster()
	if not IsValid(o) then
		self:Destroy()
		return
	end
	local D = CalcDirection2D(o, G)
	local I = G:GetOrigin() + D * self.speed * H
	I = GetGroundPosition(I, G)
	G:SetOrigin(I)
end
function E.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true }
end
E = e(
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
	E
)
local J = c()
J.name = "modifier_enemy_meat_hook"
d(J, h)
function J.prototype.StaticDeclare(self)
	return { [MODIFIER_PROPERTY_OVERRIDE_ANIMATION] = ACT_SCRIPT_CUSTOM_23 }
end
function J.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true }
end
J = e(
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
	J
)
return f