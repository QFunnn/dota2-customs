--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
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
local p = 15
local q = 0.2
local r = c()
r.name = "solthra_1"
d(r, m)
function r.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.bulletList = {}
	self.distanceRecord = 0
end
function r.prototype.GetAICastRange(self)
	return self:GetSpecialValueFor("distance")
end
function r.prototype.GetCooldown(self, s)
	return math.max(m.prototype.GetCooldown(self, s) - self:GetSpecialValueFor("cooldown_reduction"), 0)
end
function r.prototype.OnCreated(self)
	local t = self:GetCaster()
	self.position = t:GetAbsOrigin()
	self:StartThink(0, function()
		local u = self:GetSpecialValueFor("move_distance")
		if u > 0 then
			local v = t:GetAbsOrigin()
			local w = v:__sub(self.position):Length2D()
			if w < 2000 then
				self.distanceRecord = self.distanceRecord + w
			end
			self.position = v
			if self.distanceRecord >= u then
				self.distanceRecord = 0
				self:OnSpellStart()
				Event:Fire(
					"ability_cast_complete",
					{ ability = self, caster = t, position = t:GetAbsOrigin(), abilityTag = self:GetAbilityTag() }
				)
			end
		end
	end)
end
function r.prototype.OnDestroy(self)
	e(self.bulletList, function(x, y)
		Bullet:DestroyBulletByID(y)
	end)
end
function r.prototype.OnSpellStart(self)
	local t = self:GetCaster()
	local z = self:GetCursorPosition()
	if z == vec3_zero then
		local A = FindEnemiesInRadius(t, t:GetAbsOrigin(), self:GetSpecialValueFor("distance"), FIND_CLOSEST)
		if IsValid(A[1]) then
			z = A[1]:GetAbsOrigin()
		end
	end
	local B = CalcDirection(z, t:GetAbsOrigin())
	local C = self:GetSpecialValueFor("distance")
	local D = t:GetAttachmentPosition("attach_hitloc")
	local E = self:GetSpecialValueFor("fire_ball_damage_boost")
	local F = self:GetSpecialValueFor("fire_ball_damage_amplify")
	local G = self:GetSpecialValueFor("damage") * (1 + F * 0.01) * (100 + E) / 100
	local H = DoUniqueString("solthra_1")
	local I = t:HasAbilityUpgrade("solthra_upgrade_3")
	if true then
		local A = I and FindEnemiesInRadius(t, t:GetAbsOrigin(), C, FIND_CLOSEST) or {}
		self:CreateAttack(D, B, A[1], G, H)
	end
	if AbilityUpgrade:HasAbilityUpgrade(t, "solthra_1_upgrade_8") then
		local A = I and FindEnemiesInRadius(t, z, C, FIND_CLOSEST) or {}
		local J = z
		J.z = D.z
		self:CreateAttack(J, B, A[1], G, DoUniqueString("solthra_1"))
	end
	if t:HasAbilityUpgrade("solthra_upgrade_28") then
		local K = t:Script_GetAttackRange() * 0.5
		local L = self:GetSpecialValueFor("ring_duration")
		do
			local M = #self.bulletList - 1
			while M >= 0 do
				local N = self.bulletList[M + 1]
				if Bullet:GetBulletData(N) == nil then
					table.remove(self.bulletList, M)
				end
				M = M - 1
			end
		end
		local O = math.min(self:GetSpecialValueFor("ring_count"), p - #self.bulletList)
		if O <= 0 then
			return
		end
		local P = Bullet:CreateGroupSurroundBullet(O, {
			caster = t,
			ability = self,
			group = "solthra_ring" .. tostring(t:entindex()),
			circleRadius = K,
			angularVelocity = self:GetSpecialValueFor("ring_speed"),
			offset = 128,
			lifeTime = L,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = UNIT_AND_BUILDING,
			radius = 100,
			ParticleCreator = function(Q)
				local R = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_solthra/fire_ball_ring.vpcf",
					PATTACH_CUSTOMORIGIN,
					t
				)
				ParticleManager:SetParticleControl(R, 0, t:GetAbsOrigin())
				ParticleManager:SetParticleControlEnt(
					R,
					3,
					Q.__thinker,
					PATTACH_ABSORIGIN_FOLLOW,
					nil,
					Q.__thinker:GetAbsOrigin(),
					true
				)
				return R
			end,
			OnBulletHit = function(S, T, U)
				t:DealDamage(
					S,
					self,
					self:GetSpecialValueFor("damage"),
					self:GetDamageType(),
					EOM_DAMAGE_FLAGS.RING_DAMAGE
				)
			end,
		})
		self.bulletList = f(self.bulletList, P)
	end
	t:EmitSound("Hero_Batrider.Firefly.Cast")
end
function r.prototype.RequiresFacing(self)
	return false
end
function r.prototype.CreateAttack(self, V, B, S, G, H)
	local W = self:GetSpecialValueFor("pulse_count")
	local X = self:GetSpecialValueFor("angle")
	Bullet:SplitAction(B, W, X / W, function(x, Y)
		self:CreateGuidedBullet(Y, V, S, G, H)
	end)
end
function r.prototype.CreateGuidedBullet(self, B, V, S, G, H)
	local t = self:GetCaster()
	local C = self:GetSpecialValueFor("distance")
	local Z = self:GetSpecialValueFor("speed")
	local _ = self:GetSpecialValueFor("width")
	local a0 = self:GetSpecialValueFor("angular_velocity")
	local a1 = 0
	local U = {
		caster = t,
		direction = B,
		target = S,
		ability = self,
		effectName = "particles/units/heroes/hero_solthra/fire_ball_guide.vpcf",
		spawnOrigin = V,
		moveSpeed = Z,
		radius = _,
		lifeTime = C / Z,
		angularVelocity = a0,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = UNIT_AND_BUILDING,
		flagFilter = DOTA_UNIT_TARGET_FLAG_NONE,
		OnBulletThink = function(a2, Q)
			if IsValid(Q.target) and Q.target:IsAlive() then
				return
			end
			Q.target = nil
			local a3 = GameRules:GetGameTime()
			if a3 < a1 then
				return
			end
			local a4 = FindEnemiesInRadius(t, a2, 300, FIND_CLOSEST)
			if IsValid(a4[1]) and a4[1]:IsAlive() then
				Q.target = a4[1]
				a1 = 0
			else
				a1 = a3 + q
			end
		end,
		OnBulletHit = function(a5, a2, Q)
			local a6 = self:GetSpecialValueFor("combo_damage_pct")
			local a7 = a5:FindModifierByName("modifier_solthra_2_upgrade_5")
			local a8 = G
			if IsValid(a7) then
				a8 = G * (1 + a6 * a7:GetSpellCastCount(H) / 100)
			end
			t:DealDamage(a5, self, a8, nil, EOM_DAMAGE_FLAGS.SPLIT_DAMAGE)
			if t:HasAbilityUpgrade("solthra_upgrade_5") then
				a5:AddNewModifier(t, self, "modifier_solthra_2_upgrade_5", { duration = 5, spellID = H })
			end
			return true
		end,
	}
	Bullet:CreateGuidedBullet(U)
end
function r.prototype.EventListener(self)
	return {
		property_changed = function(x, a9)
			if not IsValid(self) or not IsValid(self:GetCaster()) then
				return
			end
			if a9.key ~= self:GetCaster():entindex() then
				return
			end
			if a9.propertyId == "ring_speed_amplify" then
				local aa = Bullet.surroundGroup["solthra_ring" .. tostring(self:GetCaster():entindex())]
				if aa ~= nil then
					aa.angularVelocity = self:GetSpecialValueFor("ring_speed")
				end
			end
		end,
	}
end
r = g(
	{
		o(nil, {
			funcCondition = function(x, ab)
				return ab:GetAutoCastState()
			end,
			searchBehavior = AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_NONE,
			orderType = FIND_CLOSEST,
		}),
	},
	r
)
local ac = c()
ac.name = "modifier_solthra_2_upgrade_5"
d(ac, j)
function ac.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.spellRecord = {}
end
function ac.prototype.OnCreated(self, ad)
	if IsServer() then
		self.spellRecord[ad.spellID] = (self.spellRecord[ad.spellID] or 0) + 1
	end
end
function ac.prototype.OnRefresh(self, ad)
	if IsServer() then
		self.spellRecord[ad.spellID] = (self.spellRecord[ad.spellID] or 0) + 1
	end
end
function ac.prototype.GetSpellCastCount(self, ae)
	return self.spellRecord[ae] or 0
end
ac = g(
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
	ac
)
return h