--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/solthra/solthra_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__ArrayConcat
local g = b.__TS__DecorateLegacy
local h = {}
local i = require("modifiers.eom_modifier.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("abilities.ability_ai")
local m = l.EOMAbilityAI
local n = require("abilities.eom_ability")
local o = n.registerEOMAbility
local p = 40
local q = c()
q.name = "solthra_1"
d(q, m)
function q.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.bulletList = {}
	self.distanceRecord = 0
end
function q.prototype.GetAICastRange(self)
	return self:GetSpecialValueFor("distance")
end
function q.prototype.GetCooldown(self, r)
	return math.max(m.prototype.GetCooldown(self, r) - self:GetSpecialValueFor("cooldown_reduction"), 0)
end
function q.prototype.OnCreated(self)
	local s = self:GetCaster()
	self.position = s:GetAbsOrigin()
	self:StartThink(0, function()
		local t = self:GetSpecialValueFor("move_distance")
		if t > 0 then
			local u = s:GetAbsOrigin()
			local v = u:__sub(self.position):Length2D()
			if v < 2000 then
				self.distanceRecord = self.distanceRecord + v
			end
			self.position = u
			if self.distanceRecord >= t then
				self.distanceRecord = 0
				self:OnSpellStart()
				Event:Fire(
					"ability_cast_complete",
					{ ability = self, caster = s, position = s:GetAbsOrigin(), abilityTag = self:GetAbilityTag() }
				)
			end
		end
	end)
end
function q.prototype.OnDestroy(self)
	e(self.bulletList, function(w, x)
		Bullet:DestroyBulletByID(x)
	end)
end
function q.prototype.OnSpellStart(self)
	local s = self:GetCaster()
	local y = self:GetCursorPosition()
	if y == vec3_zero then
		local z = FindEnemiesInRadius(s, s:GetAbsOrigin(), self:GetSpecialValueFor("distance"), FIND_CLOSEST)
		if IsValid(z[1]) then
			y = z[1]:GetAbsOrigin()
		end
	end
	local A = CalcDirection(y, s:GetAbsOrigin())
	local B = self:GetSpecialValueFor("distance")
	local C = s:GetAttachmentPosition("attach_hitloc")
	local D = self:GetSpecialValueFor("fire_ball_damage_boost")
	local E = self:GetSpecialValueFor("fire_ball_damage_amplify")
	local F = self:GetSpecialValueFor("damage") * (1 + E * 0.01) * (100 + D) / 100
	local G = DoUniqueString("solthra_1")
	local H = s:HasAbilityUpgrade("solthra_upgrade_3")
	if true then
		local z = H and FindEnemiesInRadius(s, s:GetAbsOrigin(), B, FIND_CLOSEST) or {}
		self:CreateAttack(C, A, z[1], F, G)
	end
	if AbilityUpgrade:HasAbilityUpgrade(s, "solthra_1_upgrade_8") then
		local z = H and FindEnemiesInRadius(s, y, B, FIND_CLOSEST) or {}
		local I = y
		I.z = C.z
		self:CreateAttack(I, A, z[1], F, DoUniqueString("solthra_1"))
	end
	if s:HasAbilityUpgrade("solthra_upgrade_28") then
		local J = s:Script_GetAttackRange() * 0.5
		local K = self:GetSpecialValueFor("ring_duration")
		do
			local L = #self.bulletList - 1
			while L >= 0 do
				local M = self.bulletList[L + 1]
				if Bullet:GetBulletData(M) == nil then
					table.remove(self.bulletList, L)
				end
				L = L - 1
			end
		end
		local N = math.min(self:GetSpecialValueFor("ring_count"), p - #self.bulletList)
		if N <= 0 then
			return
		end
		local O = Bullet:CreateGroupSurroundBullet(N, {
			caster = s,
			ability = self,
			group = "solthra_ring" .. tostring(s:entindex()),
			circleRadius = J,
			angularVelocity = self:GetSpecialValueFor("ring_speed"),
			offset = 128,
			lifeTime = K,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = UNIT_AND_BUILDING,
			radius = 100,
			ParticleCreator = function(P)
				local Q = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_solthra/fire_ball_ring.vpcf",
					PATTACH_CUSTOMORIGIN,
					s
				)
				ParticleManager:SetParticleControl(Q, 0, s:GetAbsOrigin())
				ParticleManager:SetParticleControlEnt(
					Q,
					3,
					P.__thinker,
					PATTACH_ABSORIGIN_FOLLOW,
					nil,
					P.__thinker:GetAbsOrigin(),
					true
				)
				return Q
			end,
			OnBulletHit = function(R, S, T)
				s:DealDamage(
					R,
					self,
					self:GetSpecialValueFor("damage"),
					self:GetDamageType(),
					EOM_DAMAGE_FLAGS.RING_DAMAGE
				)
			end,
		})
		self.bulletList = f(self.bulletList, O)
	end
	s:EmitSound("Hero_Batrider.Firefly.Cast")
end
function q.prototype.RequiresFacing(self)
	return false
end
function q.prototype.CreateAttack(self, U, A, R, F, G)
	local V = self:GetSpecialValueFor("pulse_count")
	local W = self:GetSpecialValueFor("angle")
	Bullet:SplitAction(A, V, W / V, function(w, X)
		self:CreateGuidedBullet(X, U, R, F, G)
	end)
end
function q.prototype.CreateGuidedBullet(self, A, U, R, F, G)
	local s = self:GetCaster()
	local B = self:GetSpecialValueFor("distance")
	local Y = self:GetSpecialValueFor("speed")
	local Z = self:GetSpecialValueFor("width")
	local _ = self:GetSpecialValueFor("angular_velocity")
	local T = {
		caster = s,
		direction = A,
		target = R,
		ability = self,
		effectName = "particles/units/heroes/hero_solthra/fire_ball_guide.vpcf",
		spawnOrigin = U,
		moveSpeed = Y,
		radius = Z,
		lifeTime = B / Y,
		angularVelocity = _,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = UNIT_AND_BUILDING,
		flagFilter = DOTA_UNIT_TARGET_FLAG_NONE,
		OnBulletThink = function(a0, P)
			local a1 = FindEnemiesInRadius(s, a0, 300, FIND_CLOSEST)
			if #a1 > 0 then
				P.target = a1[1]
			end
		end,
		OnBulletHit = function(a2, a0, P)
			local a3 = self:GetSpecialValueFor("combo_damage_pct")
			local a4 = a2:FindModifierByName("modifier_solthra_2_upgrade_5")
			local a5 = F
			if IsValid(a4) then
				a5 = F * (1 + a3 * a4:GetSpellCastCount(G) / 100)
			end
			s:DealDamage(a2, self, a5, nil, EOM_DAMAGE_FLAGS.SPLIT_DAMAGE)
			if s:HasAbilityUpgrade("solthra_upgrade_5") then
				a2:AddNewModifier(s, self, "modifier_solthra_2_upgrade_5", { duration = 5, spellID = G })
			end
			return true
		end,
	}
	Bullet:CreateGuidedBullet(T)
end
function q.prototype.EventListener(self)
	return {
		property_changed = function(w, a6)
			if not IsValid(self) or not IsValid(self:GetCaster()) then
				return
			end
			if a6.key ~= self:GetCaster():entindex() then
				return
			end
			if a6.propertyId == "ring_speed_amplify" then
				local a7 = Bullet.surroundGroup["solthra_ring" .. tostring(self:GetCaster():entindex())]
				if a7 ~= nil then
					a7.angularVelocity = self:GetSpecialValueFor("ring_speed")
				end
			end
		end,
	}
end
q = g(
	{
		o(nil, {
			funcCondition = function(w, a8)
				return a8:GetAutoCastState()
			end,
			searchBehavior = AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_NONE,
			orderType = FIND_CLOSEST,
		}),
	},
	q
)
local a9 = c()
a9.name = "modifier_solthra_2_upgrade_5"
d(a9, j)
function a9.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.spellRecord = {}
end
function a9.prototype.OnCreated(self, aa)
	if IsServer() then
		self.spellRecord[aa.spellID] = (self.spellRecord[aa.spellID] or 0) + 1
	end
end
function a9.prototype.OnRefresh(self, aa)
	if IsServer() then
		self.spellRecord[aa.spellID] = (self.spellRecord[aa.spellID] or 0) + 1
	end
end
function a9.prototype.GetSpellCastCount(self, ab)
	return self.spellRecord[ab] or 0
end
a9 = g(
	{
		k(
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
	a9
)
return h