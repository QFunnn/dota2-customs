--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_grimstroke/boss_grimstroke_3"
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
n.name = "boss_grimstroke_3"
d(n, l)
function n.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.summonRecords = {}
	self.summonedGhostCount = 0
end
function n.prototype.CleanupSummons(self)
	local o = self:GetCaster()
	do
		local p = 0
		while p < #self.summonRecords do
			local q = self.summonRecords[p + 1]
			if IsValid(q) then
				q:Kill(self, o)
			end
			p = p + 1
		end
	end
	self.summonRecords = {}
end
function n.prototype.OnSpellStart(self)
	local o = self:GetCaster()
	local r = self:GetCursorPosition()
	local s = CalcDirection2D(r, o:GetAbsOrigin())
	local t = CalcDistance(r, o)
	local u = 1000
	local v = t / u
	o:AddNewModifier(o, self, "modifier_boss_grimstroke_3", { duration = v })
	o:SimulateCast({ duration = v })
	Bullet:CreateGuidedBullet({
		caster = o,
		spawnOrigin = o:GetAbsOrigin() + Vector(0, 0, 75),
		moveSpeed = u,
		lifeTime = v,
		direction = s,
		ParticleCreator = function(w)
			local x = ParticleManager:CreateParticle(
				"particles/units/boss/boss_grimstroke/phantom_move.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControlTransformForward(x, 0, w.spawnOrigin, w.__velocity:Normalized())
			ParticleManager:SetParticleControlEnt(
				x,
				1,
				w.__thinker,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				w.__thinker:GetAbsOrigin(),
				false
			)
			ParticleManager:SetParticleControl(x, 2, Vector(w.moveSpeed, 0, 0))
			return x
		end,
		OnBulletDestroy = function(w)
			FindClearSpaceForUnit(o, w.__position, true)
			o:StartGesture(ACT_DOTA_FORCESTAFF_END)
			o:RemoveModifierByName("modifier_boss_grimstroke_3")
		end,
	})
	o:EmitSound("Hero_Grimstroke.InkCreature.Cast")
end
function n.prototype.EventListener(self)
	return {
		damage_event = function(y, z)
			local o = self:GetCaster()
			if z.target ~= o or not o:IsAlive() then
				return
			end
			local A = o:GetHealthPercent()
			local B = math.min(3, math.floor((100 - A) / 25))
			if B <= self.summonedGhostCount then
				return
			end
			do
				local p = self.summonedGhostCount
				while p < B do
					self.summonedGhostCount = p + 1
					local q = o:SummonUnit("grimstroke_ghost", o:GetAbsOrigin())
					if IsValid(q) then
						local C = self.summonRecords
						C[#C + 1] = q
						local D = DungeonManager:GetCurrentRoom()
						if D ~= nil then
							D:ApplyDifficultyModifiers(q)
						end
						FindClearSpaceForUnit(q, o:GetAbsOrigin(), true)
						q:AddNewModifier(o, self, "modifier_boss_grimstroke_3_ghost", {})
					end
					p = p + 1
				end
			end
			o:StartGesture(ACT_DOTA_GS_INK_CREATURE)
			self:StartThink(3, "aoe", function()
				for y, q in ipairs(self.summonRecords) do
					if IsValid(q) then
						local E = q:FindModifierByName("modifier_boss_grimstroke_3_ghost")
						if E ~= nil then
							E:Trigger()
						end
					end
				end
			end)
		end,
		entity_killed = function(y, z)
			local F = false
			local G = {}
			do
				local p = 0
				while p < #self.summonRecords do
					do
						local q = self.summonRecords[p + 1]
						if q == z.victim then
							F = true
							goto H
						end
						if IsValid(q) and q:IsAlive() then
							G[#G + 1] = q
						end
					end
					::H::
					p = p + 1
				end
			end
			if F then
				self.summonRecords = G
			end
			if z.victim == self:GetCaster() then
				self:CleanupSummons()
			end
		end,
	}
end
function n.prototype.OnDestroy(self)
	self:CleanupSummons()
end
n = e({ m(nil) }, n)
local I = c()
I.name = "modifier_boss_grimstroke_3"
d(I, h)
function I.prototype.OnCreated(self, J)
	if not IsServer() then
		return
	end
	local K = self:GetParent()
	K:AddNoDraw()
end
function I.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local K = self:GetParent()
	K:RemoveNoDraw()
end
function I.prototype.StaticProperty(self)
	return { [PropertyFunction.AVOID_DAMAGE] = 1 }
end
function I.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
I = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	I
)
local L = c()
L.name = "modifier_boss_grimstroke_3_ghost"
d(L, i)
function L.prototype.OnCreated(self, J)
	local K = self:GetParent()
	if IsServer() then
		local M = RandomVector(1)
		K:SetLocalAngles(0, VectorToAngles(M).y, 0)
		self:ApplyHorizontalMotionController()
		self.bulletID = Bullet:CreateLinearBullet({
			spawnOrigin = K:GetAbsOrigin(),
			moveSpeed = 400,
			direction = M,
			debug = true,
			distance = 100000000,
			bounce = 100000,
			destroyOnBounce = false,
			OnBulletBounceEnd = function(w)
				K:SetLocalAngles(0, VectorToAngles(w.__velocity:Normalized()).y, 0)
			end,
			OnBulletDestroy = function(w)
				self:Destroy()
			end,
		})
	else
		local x = ParticleManager:CreateParticle(
			"particles/units/boss/boss_grimstroke/stroke_ghost.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			K
		)
		ParticleManager:SetParticleControlEnt(x, 1, K, PATTACH_ABSORIGIN_FOLLOW, nil, K:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(x, 2, K, PATTACH_ABSORIGIN_FOLLOW, nil, K:GetAbsOrigin(), true)
		self:AddParticle(x, false, false, -1, false, false)
	end
end
function L.prototype.Trigger(self)
	local K = self:GetParent()
	local x = ParticleManager:CreateParticle(
		"particles/units/boss/boss_grimstroke/stroke_ghost_aoe.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		K
	)
	self:AddParticle(x, false, false, -1, false, false)
	K:EmitSound("Hero_Kez.EchoSlash.Katana.End")
	local N = self:GetAbility()
	if N ~= nil then
		N:CircleWarning(K, 400, 1.15)
	end
	self:StartThink(1.15, DoUniqueString("index"), function()
		if IsValid(K) then
			local O = self:GetAbilitySpecialValueFor("damage")
			local P = FindEnemiesInRadius(K, K:GetAbsOrigin(), 400)
			K:DealDamage(P, self:GetAbility(), O)
			local x = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_grimstroke/grimstroke_ink_swell_aoe.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(x, 0, K:GetAbsOrigin())
			ParticleManager:SetParticleControl(x, 1, Vector(400, 400, 400))
			K:EmitSound("Hero_Grimstroke.InkSwell.Target")
		end
		return -1
	end)
end
function L.prototype.UpdateHorizontalMotion(self, K, Q)
	if self.bulletID == nil then
		return
	end
	local w = Bullet:GetBulletData(self.bulletID)
	K:SetAbsOrigin(w.__position)
end
function L.prototype.OnHorizontalMotionInterrupted(self)
	if not IsServer() then
		return
	end
	self:Destroy()
end
function L.prototype.OnDestroy(self)
	if IsServer() then
		local K = self:GetParent()
		K:RemoveHorizontalMotionController(self)
		if self.bulletID ~= nil then
			Bullet:DestroyBulletByID(self.bulletID)
		end
	end
end
function L.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true, [MODIFIER_STATE_INVULNERABLE] = true }
end
function L.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function L.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CAPTURE
end
function L.prototype.StaticProperty(self)
	return { [PropertyFunction.AVOID_DAMAGE] = 1 }
end
function L.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
L = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	L
)
return f