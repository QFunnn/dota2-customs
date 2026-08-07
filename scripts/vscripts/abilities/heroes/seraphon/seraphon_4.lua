--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/seraphon/seraphon_4"
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
o.name = "seraphon_4"
d(o, k)
function o.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.punishment_chance = 0
	self.punishment_charge = 0
end
function o.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("radius")
end
function o.prototype.GetCooldown(self, p)
	return math.max(k.prototype.GetCooldown(self, p) - self:GetSpecialValueFor("cooldown_reduction"), 0)
end
function o.prototype.GetManaCost(self, p)
	return k.prototype.GetManaCost(self, p) - GetUltimateManaCostReduce(self:GetCaster()) - self.mana_reduce
end
function o.prototype.OnSpellStart(self)
	local q = self:GetCaster()
	self:CreateAura(q:GetAbsOrigin())
	q:EmitSound("Hero_Omniknight.GuardianAngel.Cast")
end
function o.prototype.OnCreated(self)
	local q = self:GetCaster()
	self:StartThink(0.5, "punishment", function()
		if self.punishment_charge > 0 then
			self.punishment_charge = self.punishment_charge - 1
			local r = FindEnemiesInRadius(q, q:GetAbsOrigin(), 900)
			local s = GetRandomElement(r)
			if IsValid(s) then
				self:Punishment(s)
			end
		end
	end)
end
function o.prototype.CreateAura(self, t, u, v)
	if u == nil then
		u = 100
	end
	if v == nil then
		v = 100
	end
	local q = self:GetCaster()
	local w = self:GetSpecialValueFor("duration") * v / 100
	local x = self:GetSpecialValueFor("radius") * u / 100
	if q:HasAbilityUpgrade("seraphon_4_upgrade_8") then
		q:AddNewModifier(q, self, "modifier_seraphon_4", { duration = w, radius = x })
	else
		CreateModifierThinker(
			q,
			self,
			"modifier_seraphon_4",
			{ duration = w, radius = x },
			t,
			self:GetTeamNumber(),
			false
		)
	end
end
function o.prototype.Punishment(self, s)
	local q = self:GetCaster()
	local y = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_omniknight/omniknight_shard_hammer_of_purity_target.vpcf",
		PATTACH_ABSORIGIN,
		s
	)
	ParticleManager:ReleaseParticleIndex(y)
	local z = self:GetSpecialValueFor("punishment_stun")
	if z > 0 then
		s:Stun(q, self, z)
	end
	local A = EOM_DAMAGE_FLAGS.IGNORE_BARRIER
	local B = PUNISHMENT_DAMAGE + self:GetSpecialValueFor("punishment_damage")
	if q:HasAbilityUpgrade("seraphon_upgrade_33") then
		q:LightningStrike(s, B)
	end
	q:DealDamage(s, self, PUNISHMENT_DAMAGE + self:GetSpecialValueFor("punishment_damage"), self:GetDamageType(), A)
	s:EmitSound("Hero_Omniknight.HammerOfPurity.Target")
end
function o.prototype.EventListener(self)
	return {
		ability_upgrade_added = function(C, D)
			if D.unit == self:GetCaster() then
				if D.upgradeName == "seraphon_upgrade_28" then
					local q = self:GetCaster()
					local E = self:GetSpecialValueFor("punishment_interval")
					self:StartThink(E, "punishment_interval", function()
						if q:HasAbilityUpgrade("seraphon_upgrade_28") then
							self.punishment_charge = self.punishment_charge + 1
						else
							return -1
						end
					end)
				end
				if D.upgradeName == "seraphon_upgrade_26" then
					self.punishment_chance = self:GetSpecialValueFor("punishment_chance")
				end
			end
		end,
		damage_event = function(C, F)
			if
				F.attacker == self:GetCaster()
				and F.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK
				and self:PRD(self.punishment_chance)
			then
				self:Punishment(F.target)
			end
		end,
	}
end
e({ m(nil) }, o.prototype, "mana_reduce", nil)
o = e({ n(nil, {
	funcCondition = function(C, G)
		return G:GetAutoCastState()
	end,
}) }, o)
local H = c()
H.name = "modifier_seraphon_4"
d(H, h)
function H.prototype.GetAuraRadius(self)
	return self.radius
end
function H.prototype.GetModifierAura(self)
	return "modifier_seraphon_4_buff"
end
function H.prototype.OnCreated(self, I)
	if IsServer() then
		self.radius = toFiniteNumber(I.radius)
		local J = self:GetParent()
		local y = ParticleManager:CreateParticle(
			"particles/mushi_fx/mushi_fx_fazhen_01.vpcf",
			PATTACH_CUSTOMORIGIN,
			self:GetCaster()
		)
		ParticleManager:SetParticleControlEnt(y, 0, J, PATTACH_ABSORIGIN_FOLLOW, nil, J:GetAbsOrigin(), true)
		ParticleManager:SetParticleControl(y, 1, Vector(self.radius, 0, 0))
		self:AddParticle(y, false, false, -1, false, false)
		local q = self:GetCaster()
		local K = self:GetAbilitySpecialValueFor("interval")
		if q and q:HasAbilityUpgrade("seraphon_upgrade_24") then
			self:StartThink(K, "punishment", function()
				local L = FindEnemiesInRadius(J, J:GetAbsOrigin(), self.radius)
				local s = GetRandomElement(L)
				local G = self:GetAbility()
				if IsValid(s) and IsValid(q) and IsValid(G) then
					G:Punishment(s)
				end
			end)
		end
	end
end
function H.prototype.OnDestroy(self)
	if IsServer() then
		local J = self:GetParent()
		if J ~= self:GetCaster() then
			self:GetParent():RemoveSelf()
		end
	end
end
H = e(
	{
		i(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				IsAura = true,
				GetAuraSearchFlags = DOTA_UNIT_TARGET_FLAG_NONE,
				GetAuraSearchTeam = DOTA_UNIT_TARGET_TEAM_BOTH,
				GetAuraSearchType = UNIT_AND_BUILDING,
			}
		),
	},
	H
)
local M = c()
M.name = "modifier_seraphon_4_buff"
d(M, h)
function M.prototype.GetAbilitySpecialValue(self)
	self.ult_attack_speed_bonus = self:GetAbilitySpecialValueFor("ult_attack_speed_bonus")
	self.require_count_reduce = self:GetAbilitySpecialValueFor("require_count_reduce")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	local N = self:GetAbilitySpecialValueFor("shield_pct")
	self.shield = self:GetAbilitySpecialValueFor("shield") * (1 + N * 0.01)
	self.crit_damage_amplify = self:GetAbilitySpecialValueFor("crit_damage_amplify")
	self.damage_reduce_pct = self:GetAbilitySpecialValueFor("damage_reduce_pct")
end
function M.prototype.OnCreated(self, I)
	if IsServer() then
		self:SetStackCount(self.require_count_reduce)
		self:StartIntervalThink(self.interval)
	end
end
function M.prototype.StaticProperty(self)
	local q = self:GetCaster()
	if not IsValid(q) then
		return {}
	end
	if self:GetParent():IsFriendly(q) then
		return {
			[PropertyFunction.ATTACKSPEED] = self.ult_attack_speed_bonus,
			[PropertyFunction.CRIT_DAMAGE_AMPLIFY] = self.crit_damage_amplify,
			[PropertyFunction.DAMAGE_REDUCTION] = self.damage_reduce_pct,
		}
	end
	return {}
end
function M.prototype.OnIntervalThink(self)
	local q = self:GetCaster()
	if not IsValid(q) then
		return
	end
	local J = self:GetParent()
	if J:IsFriendly(q) then
		J:AddShield(self.shield, "seraphon_4", "add")
	else
		local O = q.DealDamage
		local P = self:GetAbility()
		local Q = self.damage * self.interval
		local R = self:GetAbility()
		O(q, J, P, Q, R and R:GetDamageType())
		local s = BehaviorTree:GetTarget(J)
		if s ~= nil and BehaviorTree:GetTarget(J) ~= q then
			BehaviorTree:SetTarget(J, q)
			J:Stop()
		end
	end
end
M = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	M
)
return f