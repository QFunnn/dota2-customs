--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_boss_pugna_nether_ward"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
local g = b.__TS__ArrayForEach
local h = {}
local i = require("modifiers.eom_modifier.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("abilities.bt_ability_ai")
local m = l.EOMBTAbilityAI
local n = require("abilities.eom_ability")
local o = n.registerEOMAbility
local p = c()
p.name = "enemy_boss_pugna_nether_ward"
d(p, m)
function p.prototype.OnSpellStart(self)
	local q = self:GetCaster()
	local r = self:GetCursorPosition()
	local s = q:SummonUnit("nether_ward_custom", r)
	if IsValid(s) then
		s:SetForwardVector(CalcDirection(r, q:GetAbsOrigin()))
		s:StartGesture(ACT_DOTA_IDLE)
		s:AddNewModifier(
			q,
			self,
			"modifier_nether_ward_custom_buff",
			{ duration = self:GetSpecialValueFor("duration") }
		)
	end
end
p = e({ o(nil) }, p)
local t = c()
t.name = "modifier_nether_ward_custom_buff"
d(t, j)
function t.prototype.OnDestroy(self)
	if IsServer() then
		if self.parent:IsAlive() and IsValid(self.caster) then
			CreateModifierThinker(
				self.caster,
				self.ability,
				"modifier_enemy_boss_pugna_nether_ward_thinker3",
				{ duration = 3 },
				self.parent:GetAbsOrigin(),
				self.caster:GetTeamNumber(),
				false
			)
			self.parent:ForceKill(false)
		end
	end
end
t = e(
	{ k(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	t
)
local u = c()
u.name = "modifier_enemy_boss_pugna_nether_ward_thinker3"
d(u, j)
function u.prototype.GetAbilitySpecialValue(self)
	self.speed = self:GetAbilitySpecialValueFor("speed")
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.effectWidth = self:GetAbilitySpecialValueFor("effect_width")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function u.prototype.OnCreated(self, v)
	if IsServer() then
		self.cur_radius = 0
		self.enemies = {}
		local w = self:GetParent()
		self.centerPos = w:GetAbsOrigin()
		self._particleID = ParticleManager:CreateParticle(
			"particles/spell/boss_advanced_3_passive_smash/effect.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(self._particleID, 0, self.centerPos)
		ParticleManager:SetParticleControl(self._particleID, 1, Vector(self.speed, self.radius, 1))
		self:StartIntervalThink(FrameTime())
	end
end
function u.prototype.OnIntervalThink(self)
	local q = self:GetCaster()
	if not q or not q:IsAlive() then
		self:Destroy()
		return
	end
	local x = FindUnitsInRadius(
		q:GetTeamNumber(),
		self.centerPos,
		nil,
		self.cur_radius + self.effectWidth,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)
	for y, z in ipairs(x) do
		if IsValid(z) then
			if
				not f(self.enemies, z)
				and CalcDistance(z:GetAbsOrigin(), self.centerPos) >= self.cur_radius - self.effectWidth
			then
				local A = self.enemies
				A[#A + 1] = z
				q:DealDamage(z, self.ability, self.damage)
			end
		end
	end
	if self.cur_radius >= self.radius then
		self:Destroy()
		return
	end
	self.cur_radius = math.min(self.cur_radius + self.speed * FrameTime(), self.radius)
end
function u.prototype.OnDestroy(self)
	if IsServer() then
		ParticleManager:DestroyParticle(self._particleID, false)
	end
end
u = e(
	{ k(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	u
)
local B = c()
B.name = "modifier_enemy_boss_pugna_nether_ward_thinker2"
d(B, j)
function B.prototype.GetAbilitySpecialValue(self)
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function B.prototype.OnCreated(self, v)
	self.summonUnits = {}
	if IsServer() then
		self:SummonNetherWard()
		self:StartIntervalThink(self.interval)
	end
end
function B.prototype.SummonNetherWard(self)
	local r = self.parent:GetAbsOrigin()
	local C = CalcDirection(r, self.caster)
	C = Rotation2D(C, 90, true)
	local D = { r + C * self.radius, r - C * self.radius }
	for y, E in ipairs(D) do
		local s = self.parent:SummonUnit("nether_ward_custom", E)
		if IsValid(s) then
			local F = self.summonUnits
			F[#F + 1] = s
			s:SetForwardVector(CalcDirection(E, r))
			s:StartGesture(ACT_DOTA_IDLE)
		end
	end
	self.parent:EmitSound("Hero_Pugna.NetherWard")
end
function B.prototype.OnIntervalThink(self)
	if IsServer() then
		local G = false
		do
			local H = 0
			while H < #self.summonUnits do
				do
					if self.summonUnits[H + 1]:IsAlive() == false then
						goto I
					end
					local J = self.summonUnits[H + 1]:GetAbsOrigin()
					do
						local K = H + 1
						while K < #self.summonUnits do
							do
								if self.summonUnits[K + 1]:IsAlive() == false then
									goto L
								end
								local M = self.summonUnits[K + 1]:GetAbsOrigin()
								local N = ParticleManager:CreateParticle(
									"particles/units/heroes/hero_pugna/pugna_ward_attack.vpcf",
									PATTACH_POINT,
									self.summonUnits[H + 1]
								)
								ParticleManager:SetParticleControlEnt(
									N,
									0,
									self.summonUnits[H + 1],
									PATTACH_POINT_FOLLOW,
									"attach_hitloc",
									J,
									false
								)
								ParticleManager:SetParticleControlEnt(
									N,
									1,
									self.summonUnits[K + 1],
									PATTACH_POINT_FOLLOW,
									"attach_hitloc",
									M,
									false
								)
								local O = FindUnitsInLineWithAbility(self.parent, J, M, 50, self.ability)
								self.parent:DealDamage(O, self.ability, self.damage)
								if #O > 0 then
									G = true
								end
							end
							::L::
							K = K + 1
						end
					end
				end
				::I::
				H = H + 1
			end
		end
		if G then
			self.parent:EmitSound("Hero_Pugna.NetherWard.Attack")
		end
	end
end
function B.prototype.OnDestroy(self)
	if IsServer() then
		g(self.summonUnits, function(y, s)
			if IsValid(s) and s:IsAlive() then
				s:Kill(self.ability, self:GetParent())
			end
		end)
		self:GetParent():RemoveSelf()
	end
end
B = e(
	{ k(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	B
)
local P = c()
P.name = "modifier_enemy_boss_pugna_nether_ward_thinker"
d(P, j)
function P.prototype.GetAbilitySpecialValue(self)
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.interval = self:GetAbilitySpecialValueFor("interval")
end
function P.prototype.OnCreated(self, v)
	self.summonUnits = {}
	if IsServer() then
		self:SummonNetherWard()
		self:StartIntervalThink(self.interval)
	end
end
function P.prototype.SummonNetherWard(self)
	local r = self.parent:GetAbsOrigin()
	local D = {}
	do
		local H = 0
		while H < 5 do
			local Q = (72 * H - 90) * math.pi / 180
			local R = r.x + self.radius * math.cos(Q)
			local S = r.y + self.radius * math.sin(Q)
			D[#D + 1] = Vector(R, S, r.z)
			H = H + 1
		end
	end
	for y, E in ipairs(D) do
		local s = self.parent:SummonUnit("nether_ward_custom", E)
		if IsValid(s) then
			local T = self.summonUnits
			T[#T + 1] = s
			s:SetForwardVector(CalcDirection(E, r))
			s:StartGesture(ACT_DOTA_IDLE)
		end
	end
	self.parent:EmitSound("Hero_Pugna.NetherWard")
end
function P.prototype.OnIntervalThink(self)
	if IsServer() then
		do
			local H = 0
			while H < #self.summonUnits do
				do
					if self.summonUnits[H + 1]:IsAlive() == false then
						goto U
					end
					local J = self.summonUnits[H + 1]:GetAbsOrigin()
					do
						local K = H + 1
						while K < #self.summonUnits do
							do
								if self.summonUnits[K + 1]:IsAlive() == false then
									goto V
								end
								local M = self.summonUnits[K + 1]:GetAbsOrigin()
								local N = ParticleManager:CreateParticle(
									"particles/units/heroes/hero_pugna/pugna_ward_attack.vpcf",
									PATTACH_POINT,
									self.summonUnits[H + 1]
								)
								ParticleManager:SetParticleControlEnt(
									N,
									0,
									self.summonUnits[H + 1],
									PATTACH_POINT_FOLLOW,
									"attach_hitloc",
									J,
									false
								)
								ParticleManager:SetParticleControlEnt(
									N,
									1,
									self.summonUnits[K + 1],
									PATTACH_POINT_FOLLOW,
									"attach_hitloc",
									M,
									false
								)
								local O = FindUnitsInLineWithAbility(self.parent, J, M, 50, self.ability)
								self.parent:DealDamage(O, self.ability, 10)
							end
							::V::
							K = K + 1
						end
					end
				end
				::U::
				H = H + 1
			end
		end
	end
end
function P.prototype.OnDestroy(self)
	if IsServer() then
		g(self.summonUnits, function(y, s)
			if IsValid(s) and s:IsAlive() then
				s:Kill(self.ability, self.parent)
			end
		end)
	end
end
P = e(
	{ k(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	P
)
return h