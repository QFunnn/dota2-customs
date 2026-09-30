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
	local Z = t:FindModifierByName("modifier_solthra_1_ball_boost")
	local _ = IsValid(Z) and 1 + Z:GetBoostPct() * 0.01 or 1
	local C = self:GetSpecialValueFor("distance")
	local a0 = self:GetSpecialValueFor("speed") * _
	local a1 = G * _
	local a2 = self:GetSpecialValueFor("width")
	local a3 = self:GetSpecialValueFor("angular_velocity")
	local a4 = 0
	local U = {
		caster = t,
		direction = B,
		target = S,
		ability = self,
		effectName = "particles/units/heroes/hero_solthra/fire_ball_guide.vpcf",
		spawnOrigin = V,
		moveSpeed = a0,
		radius = a2,
		lifeTime = C / a0,
		angularVelocity = a3,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = UNIT_AND_BUILDING,
		flagFilter = DOTA_UNIT_TARGET_FLAG_NONE,
		OnBulletThink = function(a5, Q)
			if IsValid(Q.target) and Q.target:IsAlive() then
				return
			end
			Q.target = nil
			local a6 = GameRules:GetGameTime()
			if a6 < a4 then
				return
			end
			local a7 = FindEnemiesInRadius(t, a5, 300, FIND_CLOSEST)
			if IsValid(a7[1]) and a7[1]:IsAlive() then
				Q.target = a7[1]
				a4 = 0
			else
				a4 = a6 + q
			end
		end,
		OnBulletHit = function(a8, a5, Q)
			local a9 = self:GetSpecialValueFor("combo_damage_pct")
			local aa = a8:FindModifierByName("modifier_solthra_2_upgrade_5")
			local ab = a1
			if IsValid(aa) then
				ab = a1 * (1 + a9 * aa:GetSpellCastCount(H) / 100)
			end
			t:DealDamage(a8, self, ab, nil, EOM_DAMAGE_FLAGS.SPLIT_DAMAGE)
			if t:HasAbilityUpgrade("solthra_upgrade_5") then
				a8:AddNewModifier(t, self, "modifier_solthra_2_upgrade_5", { duration = 5, spellID = H })
			end
			return true
		end,
	}
	Bullet:CreateGuidedBullet(U)
end
function r.prototype.EventListener(self)
	return {
		ability_cast_complete = function(x, ac)
			local t = self:GetCaster()
			if ac.caster ~= t or ac.abilityTag ~= AbilityTag.Ultimate then
				return
			end
			if not t:HasAbilityUpgrade("solthra_1_upgrade_wp44") then
				return
			end
			t:AddNewModifier(
				t,
				self,
				"modifier_solthra_1_ball_boost",
				{
					duration = self:GetSpecialValueFor("ball_boost_duration"),
					boost_pct = self:GetSpecialValueFor("ball_speed_and_damage"),
				}
			)
		end,
		property_changed = function(x, ac)
			if not IsValid(self) or not IsValid(self:GetCaster()) then
				return
			end
			if ac.key ~= self:GetCaster():entindex() then
				return
			end
			if ac.propertyId == "ring_speed_amplify" then
				local ad = Bullet.surroundGroup["solthra_ring" .. tostring(self:GetCaster():entindex())]
				if ad ~= nil then
					ad.angularVelocity = self:GetSpecialValueFor("ring_speed")
				end
			end
		end,
	}
end
r = g(
	{
		o(nil, {
			funcCondition = function(x, ae)
				return ae:GetAutoCastState()
			end,
			searchBehavior = AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_NONE,
			orderType = FIND_CLOSEST,
		}),
	},
	r
)
local af = c()
af.name = "modifier_solthra_1_ball_boost"
d(af, j)
function af.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.boostPct = 0
end
function af.prototype.OnCreated(self, ag)
	if not IsServer() then
		return
	end
	self.boostPct = ag.boost_pct
	print(string.format("[Solthra] Fireball boost created: %.1f%%", self.boostPct))
end
function af.prototype.OnRefresh(self, ag)
	if not IsServer() then
		return
	end
	self.boostPct = ag.boost_pct
	print(string.format("[Solthra] Fireball boost refreshed: %.1f%%", self.boostPct))
end
function af.prototype.GetBoostPct(self)
	return self.boostPct
end
af = g(
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
				RemoveOnDeath = true,
			}
		),
	},
	af
)
local ah = c()
ah.name = "modifier_solthra_2_upgrade_5"
d(ah, j)
function ah.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.spellRecord = {}
end
function ah.prototype.OnCreated(self, ag)
	if IsServer() then
		self.spellRecord[ag.spellID] = (self.spellRecord[ag.spellID] or 0) + 1
	end
end
function ah.prototype.OnRefresh(self, ag)
	if IsServer() then
		self.spellRecord[ag.spellID] = (self.spellRecord[ag.spellID] or 0) + 1
	end
end
function ah.prototype.GetSpellCastCount(self, ai)
	return self.spellRecord[ai] or 0
end
ah = g(
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
	ah
)
return h