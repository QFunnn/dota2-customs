--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/solthra/solthra_4"
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
local m = l.AbilityValue
local n = l.registerEOMAbility
local o = c()
o.name = "solthra_4"
d(o, k)
function o.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.firestorm_charge = 0
end
function o.prototype.GetCooldown(self, p)
	return math.max(k.prototype.GetCooldown(self, p) - self:GetSpecialValueFor("cooldown_reduction"), 0)
end
function o.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("radius")
end
function o.prototype.GetManaCost(self, p)
	return k.prototype.GetManaCost(self, p) - GetUltimateManaCostReduce(self:GetCaster()) - self.mana_reduce
end
function o.prototype.RequiresFacing(self)
	return true
end
function o.prototype.OnCreated(self)
	local q = self:GetCaster()
	self:StartThink(1, "firestorm", function()
		if self.firestorm_charge > 0 then
			self.firestorm_charge = self.firestorm_charge - 1
			local r = self:GetSpecialValueFor("firestorm_radius")
			local s = FindEnemiesInRadius(q, q:GetAbsOrigin(), 900)
			local t = GetRandomElement(s)
			if IsValid(t) then
				local u = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_solthra/firestorm.vpcf",
					PATTACH_CUSTOMORIGIN,
					q
				)
				ParticleManager:SetParticleControl(u, 0, t:GetAbsOrigin())
				ParticleManager:SetParticleControl(u, 4, Vector(r, r, r))
				q:EmitSound("Hero_AbyssalUnderlord.Firestorm")
				local v = FindEnemiesInRadius(q, t:GetAbsOrigin(), r)
				local w = self:GetSpecialValueFor("firestorm_damage")
				local x = self:GetSpecialValueFor("damage")
				for y, z in ipairs(v) do
					q:DealDamage(z, self, w * x * 0.01)
				end
			end
		end
	end)
end
function o.prototype.OnSpellStart(self)
	local q = self:GetCaster()
	local A = self:GetCursorPosition()
	local B = self:GetSpecialValueFor("delay")
	local C = self:GetSpecialValueFor("firestorm_wave")
	local D = self:GetSpecialValueFor("bonus_meteor_chance")
	local E = self:GetSpecialValueFor("bonus_meteor_damage_pct")
	self.firestorm_charge = self.firestorm_charge + C
	local F = self:GetManaCost(self:GetLevel())
	CreateModifierThinker(q, self, "modifier_solthra_4_thinker", { duration = B }, A, q:GetTeamNumber(), false)
	q:EmitSound("Hero_Invoker.ChaosMeteor.Cast")
	self:TrySpawnBonusMeteor(q, A, B, D, E)
	if q:HasAbilityUpgrade("solthra_upgrade_16") then
		self:StartThink(0.4, function()
			if q:GetMana() >= F then
				q:SpendMana(F, self)
				local G = A + RandomVector(RandomInt(100, 200))
				CreateModifierThinker(
					q,
					self,
					"modifier_solthra_4_thinker",
					{ duration = B },
					G,
					q:GetTeamNumber(),
					false
				)
				q:EmitSound("Hero_Invoker.ChaosMeteor.Cast")
				self:TrySpawnBonusMeteor(q, A, B, D, E)
				return 0.4
			end
			return -1
		end)
	end
	if q:HasAbilityUpgrade("solthra_upgrade_15") then
		q:EachAbility(function(H, I)
			if I ~= AbilityTag.Ultimate and I ~= AbilityTag.Attack then
				H:EndCooldown()
				H:RestoreCharges()
			end
		end)
	end
end
function o.prototype.StaticProperty(self)
	return { [PropertyFunction.MANA] = self:GetSpecialValueFor("mana_bonus") }
end
function o.prototype.EventListener(self)
	return {
		ability_upgrade_added = function(J, K)
			if K.unit == self:GetCaster() and K.upgradeName == "solthra_upgrade_31" then
				local q = self:GetCaster()
				local L = self:GetSpecialValueFor("firestorm_interval")
				self:StartThink(L, "firestorm_interval", function()
					if q:HasAbilityUpgrade("solthra_upgrade_31") then
						self.firestorm_charge = self.firestorm_charge + 1
					else
						return -1
					end
				end)
			end
		end,
	}
end
function o.prototype.TrySpawnBonusMeteor(self, q, A, B, M, N)
	if M <= 0 or not self:PRD(M, "solthra_4_bonus_meteor") then
		return
	end
	local s = FindEnemiesInRadius(q, q:GetAbsOrigin(), 900)
	local O = GetRandomElement(s)
	local P = IsValid(O) and O:GetAbsOrigin() or A + RandomVector(400)
	CreateModifierThinker(
		q,
		self,
		"modifier_solthra_4_thinker",
		{ duration = B, bonus_damage_pct = N },
		P,
		q:GetTeamNumber(),
		false
	)
end
e({ m(nil) }, o.prototype, "mana_reduce", nil)
o = e(
	{
		n(nil, {
			searchBehavior = AI_SEARCH_BEHAVIOR.AI_SEARCH_BEHAVIOR_MOST_AOE_TARGET,
			funcCondition = function(J, H)
				return H:GetAutoCastState()
			end,
		}),
	},
	o
)
local Q = c()
Q.name = "modifier_solthra_4_thinker"
d(Q, h)
function Q.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.damage = 0
	self.radius = 0
	self.bonus_damage_pct = 100
end
function Q.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.delay = self:GetAbilitySpecialValueFor("delay")
	self.stun_duration = self:GetAbilitySpecialValueFor("stun_duration")
	self.roll_distance = self:GetAbilitySpecialValueFor("roll_distance")
	self.roll_damage = self:GetAbilitySpecialValueFor("roll_damage")
	self.roll_interval = self:GetAbilitySpecialValueFor("roll_interval")
	self.roll_knockback = self:GetAbilitySpecialValueFor("roll_knockback")
end
function Q.prototype.OnCreated(self, R)
	local q = self:GetCaster()
	if not IsValid(q) then
		self:Destroy()
		return
	end
	local S = R.bonus_damage_pct
	if S == nil then
		S = 100
	end
	self.bonus_damage_pct = S
	if IsServer() then
		self.direction = CalcDirection2D(self.parent, q)
		self.parent:EmitSound("Hero_Invoker.ChaosMeteor.Loop")
		EmitSoundOnLocationWithCaster(self:GetParent():GetAbsOrigin(), "Hero_Invoker.ChaosMeteor.Cast", q)
	else
		local u =
			ParticleManager:CreateParticle("particles/generic_gameplay/solthra_4_meteor.vpcf", PATTACH_CUSTOMORIGIN, q)
		ParticleManager:SetParticleControl(u, 0, q:GetAbsOrigin() + Vector(0, 0, 1000))
		ParticleManager:SetParticleControl(u, 1, self.parent:GetAbsOrigin())
		ParticleManager:SetParticleControl(u, 2, Vector(self.delay, 0, 0))
		self:AddParticle(u, false, false, -1, false, false)
	end
end
function Q.prototype.OnDestroy(self)
	if IsServer() then
		local q = self:GetCaster()
		local T = self:GetParent()
		local H = self:GetAbility()
		T:StopSound("Hero_Invoker.ChaosMeteor.Loop")
		T:EmitSound("Hero_Warlock.RainOfChaos")
		local u = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_warlock/warlock_rain_of_chaos_start.vpcf",
			PATTACH_CUSTOMORIGIN,
			q
		)
		ParticleManager:SetParticleControl(u, 0, T:GetAbsOrigin())
		ParticleManager:SetParticleControl(u, 1, T:GetAbsOrigin())
		if not IsValid(q) then
			return
		end
		local U = FindUnitsInRadius(
			q:GetTeamNumber(),
			T:GetAbsOrigin(),
			nil,
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			UNIT_AND_BUILDING,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		q:DealDamage(U, H, self.damage * self.bonus_damage_pct / 100)
		if self.stun_duration > 0 then
			for y, t in ipairs(U) do
				t:Stun(q, H, self.stun_duration)
			end
		end
		if q:HasAbilityUpgrade("solthra_upgrade_27") then
			local V = q:GetAbilityByTag(AbilityTag.Skill)
			if IsValid(V) then
				V:CreateAttack(
					T:GetAbsOrigin() + 120,
					RandomVector(1),
					U[1],
					V:GetSpecialValueFor("damage"),
					DoUniqueString("solthra_1")
				)
			end
		end
		if q:HasAbilityUpgrade("solthra_upgrade_17") then
			Bullet:CreateLinearBullet({
				ability = H,
				caster = q,
				spawnOrigin = T:GetAbsOrigin(),
				effectName = "particles/units/heroes/hero_invoker/invoker_chaos_meteor.vpcf",
				direction = self.direction,
				moveSpeed = 300,
				distance = self.roll_distance,
				radius = 200,
				interval = self.roll_interval,
				OnIntervalThink = function(W)
					W.__hitRecord = {}
				end,
				OnBulletHit = function(z, A, W)
					q:DealDamage(z, H, self.damage * self.roll_damage * 0.01)
					if self.roll_knockback > 0 then
						z:KnockBack(W.direction, self.roll_knockback, 0, 0.1)
					end
				end,
			})
		end
		self:GetParent():RemoveSelf()
	end
end
Q = e(
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
	Q
)
return f