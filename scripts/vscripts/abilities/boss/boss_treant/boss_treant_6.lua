--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_treant/boss_treant_6"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifierMotionBoth
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMAbility
local l = j.registerEOMAbility
local m = c()
m.name = "boss_treant_6"
d(m, k)
function m.prototype.OnSpellStart(self)
	local n = self:GetCaster()
	local o = self:GetCursorPosition()
	local p = n:FindAbilityByName("boss_treant_5")
	self:CircleWarning(o, 300, 1)
	if IsValid(p) then
		local q = p:GetCatchUnit()
		if IsValid(q) and q:IsAlive() then
			q:RemoveModifierByName("modifier_boss_treant_5")
			q:AddNewModifier(n, self, "modifier_boss_treant_6", { position = VectorToString(o), duration = 1 })
		end
	end
	n:SimulateCast({ duration = 0.8 })
end
m = e({ l(nil, {}) }, m)
local r = c()
r.name = "modifier_boss_treant_6"
d(r, h)
function r.prototype.OnCreated(self, s)
	if IsServer() then
		local t = self:GetParent()
		self.position = StringToVector(s.position)
		self.startPosition = t:GetAbsOrigin()
		local u = self:GetDuration()
		local v = self.position
		local w = self.startPosition
		local n = self:GetCaster()
		local p = self:GetAbility()
		local x = p:GetSpecialValueFor("radius")
		local y = p:GetSpecialValueFor("damage")
		self.bulletID = Bullet:CreateCustomBullet({
			caster = t,
			spawnOrigin = w,
			lifeTime = u,
			PathFunction = function(o, z)
				local A = z.lifeTime
				local B = z.__lifeTimeRemaining
				local C = A - B
				local D = C / A
				local E = w.x + (v.x - w.x) * D
				local F = w.y + (v.y - w.y) * D
				local G = 600
				local H = w.z + (v.z - w.z) * D + G * 4 * D * (1 - D)
				return Vector(E, F, H)
			end,
			OnBulletDestroy = function(z)
				if IsValid(n) then
					local I = FindEnemiesInRadius(n, v, x)
					n:DealDamage(I, p, y)
					local J = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_centaur/centaur_warstomp.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					ParticleManager:SetParticleControl(J, 0, v)
					ParticleManager:SetParticleControl(J, 1, Vector(x, x, x))
					n:EmitSound("Hero_Centaur.HoofStomp")
				end
			end,
		})
		if not self:ApplyHorizontalMotionController() or not self:ApplyVerticalMotionController() then
			self:Destroy()
			return
		end
	end
end
function r.prototype.OnDestroy(self)
	if IsServer() then
	end
end
function r.prototype.OnHorizontalMotionInterrupted(self)
	if IsServer() then
		self:Destroy()
	end
end
function r.prototype.OnVerticalMotionInterrupted(self)
	if IsServer() then
		self:Destroy()
	end
end
function r.prototype.UpdateVerticalMotion(self, K, L)
	if self.bulletID == nil then
		return
	end
	local z = Bullet:GetBulletData(self.bulletID)
	if z == nil then
		return
	end
	K:SetAbsOrigin(z.__position)
end
function r.prototype.UpdateHorizontalMotion(self, K, L)
	if self.bulletID == nil then
		return
	end
	local z = Bullet:GetBulletData(self.bulletID)
	if z == nil then
		return
	end
	K:SetAbsOrigin(z.__position)
end
function r.prototype.StaticDeclare(self)
	return { [MODIFIER_PROPERTY_OVERRIDE_ANIMATION] = ACT_DOTA_FLAIL }
end
function r.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function r.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true, [MODIFIER_STATE_INVULNERABLE] = true }
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
return f