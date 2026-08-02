--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/vespera/vespera_2"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMAbility
local l = j.registerEOMAbility
local m = c()
m.name = "vespera_2"
d(m, k)
function m.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.vespera_upgrade_23_enable = true
end
function m.prototype.OnController(self, n, o)
	local p = self:GetCaster()
	if n == nil then
		n = p:GetAbsOrigin() + o * self:GetSpecialValueFor("distance")
	end
	p:ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, self, n)
end
function m.prototype.OnCreated(self)
	local p = self:GetCaster()
	self:StartThink(0, function()
		local q = DungeonManager:GetCurrentRoom()
		if
			self:GetAutoCastState()
			and self:IsCooldownReady()
			and (q and q:IsCombatRoom() and not q:IsCombatEnd() or AbyssalHordeManager:IsRunning())
		then
			local o = Controller:GetInputDirection(p)
			if VectorIsZero(o) then
				o = p:GetForwardVector()
			end
			self:OnController(p:GetAbsOrigin() + o * self:GetSpecialValueFor("distance"), o)
		end
	end)
end
function m.prototype.CreateDashDamageBullet(self, r, s)
	if s == nil then
		s = EOM_DAMAGE_FLAGS.NONE
	end
	if r <= 0 then
		return
	end
	local p = self:GetCaster()
	local t = Bullet:CreateCustomBullet({
		caster = p,
		spawnOrigin = p:GetAbsOrigin(),
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		radius = self:GetSpecialValueFor("dash_width"),
		lifeTime = 2,
		PathFunction = function(n, u)
			return p:GetAbsOrigin()
		end,
		FuncUnitFinder = function(v, n, w, u)
			return FindUnitsInRadius(
				p:GetTeamNumber(),
				n,
				nil,
				w,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)
		end,
		OnBulletHit = function(x, y, z)
			p:DealDamage(x, self, r, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL, s)
		end,
	})
	if t ~= nil then
		if self.bulletID == nil then
			self.bulletID = {}
		end
		local A = self.bulletID
		A[#A + 1] = t
	end
end
function m.prototype.EventListener(self)
	return {
		dash_start = function(B, C)
			local p = self:GetCaster()
			if C.caster ~= p then
				return
			end
			local D = self:GetSpecialValueFor("dash_damage")
			self:CreateDashDamageBullet(D)
			if AbilityUpgrade:HasAbilityUpgrade(p, "vespera_upgrade_12") then
				p:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK_EVENT_BASH, 2)
			end
		end,
		dash_end = function(B, C)
			local p = self:GetCaster()
			if C.caster ~= p then
				return
			end
			if AbilityUpgrade:HasAbilityUpgrade(p, "vespera_upgrade_12") then
				local E = p:GetAbilityByTag(AbilityTag.Attack)
				if IsValid(E) then
					local F = -p:GetForwardVector()
					local G = p:Script_GetAttackRange()
					p:SetForwardVector(F)
					p:SetCursorPosition(p:GetAbsOrigin() + F * G)
					p:AddNewModifier(
						p,
						E,
						"modifier_vespera_combo_final",
						{ duration = p:GetSecondsPerAttack(false) + 60 }
					)
					p:AddNewModifier(p, E, "modifier_vespera_upgrade_12_backstab", { duration = 1 })
					E:Attack(C.start, C["end"])
					p:RemoveModifierByName("modifier_vespera_upgrade_12_backstab")
				end
			end
			if AbilityUpgrade:HasAbilityUpgrade(p, "vespera_upgrade_7") then
				if p:HasAbilityUpgrade("vespera_upgrade_7") then
					local H = p:GetAbilityByTag(AbilityTag.Attack)
					p:AddNewModifier(
						p,
						H,
						"modifier_vespera_combo_final",
						{ duration = p:GetSecondsPerAttack(false) + 60 }
					)
				end
			end
			if self.bulletID ~= nil then
				for B, t in ipairs(self.bulletID) do
					Bullet:DestroyBulletByID(t)
				end
			end
		end,
	}
end
function m.prototype.GetCastCooldown(self)
	return self:GetSpecialValueFor("duration")
end
function m.prototype.GetCooldown(self, I)
	return math.max(
		(k.prototype.GetCooldown(self, I) - self:GetSpecialValueFor("cooldown_reduction"))
			* (1 - self:GetSpecialValueFor("cooldown_pct") * 0.01),
		0
	)
end
function m.prototype.OnSpellStart(self)
	local p = self:GetCaster()
	local J = p:GetAbsOrigin()
	p:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1)
	local n = self:GetCursorPosition()
	n.z = J.z
	local o = CalcDirection2D(n, p)
	local K = math.min(self:GetSpecialValueFor("distance"), CalcDistance(n, p))
	local L = self:GetSpecialValueFor("duration")
	local M = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_fx_chongci_01.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		p
	)
	ParticleManager:SetParticleControlTransformForward(M, 0, p:GetAbsOrigin(), o)
	p:Dash(o, K, 0, L)
	p:EmitSound("Hero_PhantomAssassin.Strike.End")
	if AbilityUpgrade:HasAbilityUpgrade(p, "vespera_upgrade_3") then
		p:AddNewModifier(
			p,
			self,
			"modifier_vespera_2_attackspeed",
			{ duration = self:GetSpecialValueFor("attackspeed_duration") }
		)
	end
	if AbilityUpgrade:HasAbilityUpgrade(p, "vespera_upgrade_4") then
		self:FanOfKnives()
	end
	if p:HasAbilityUpgrade("vespera_upgrade_23") and self.vespera_upgrade_23_enable then
		self.vespera_upgrade_23_enable = false
		self:StartThink(self:GetSpecialValueFor("blind_cd"), "vespera_upgrade_23_enable", function()
			self.vespera_upgrade_23_enable = true
			return -1
		end)
		local N = self:GetSpecialValueFor("smoke_duration")
		CreateModifierThinker(p, self, "modifier_vespera_upgrade_23", { duration = N }, J, p:GetTeamNumber(), false)
		p:EmitSound("Hero_Riki.Smoke_Screen")
	end
end
function m.prototype.FanOfKnives(self)
	local p = self:GetCaster()
	local O = self:GetSpecialValueFor("dagger_count")
	local K = self:GetSpecialValueFor("dagger_distance")
	local P = self:GetSpecialValueFor("dagger_width")
	local Q = self:GetSpecialValueFor("dagger_speed")
	local r = self:GetSpecialValueFor("dagger_damage")
	local o = self:GetForwardVector()
	Bullet:SplitAction(o, O, 360 / O, function(B, R)
		Bullet:CreateLinearBullet({
			ability = self,
			caster = p,
			effectName = "particles/units/heroes/hero_phantom_assassin/phantom_assassin_2_dagger.vpcf",
			spawnOrigin = p:GetAttachmentPosition("attach_hitloc"),
			direction = R,
			moveSpeed = Q,
			distance = K,
			radius = P,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			OnBulletHit = function(x, y, z)
				p:DealDamage(x, self, r, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
			end,
		})
	end)
end
m = e({ l(nil) }, m)
local S = c()
S.name = "modifier_vespera_2_attackspeed"
d(S, h)
function S.prototype.StaticProperty(self)
	return { [PropertyFunction.ATTACKSPEED] = self:GetAbilitySpecialValueFor("attackspeed") }
end
S = e(
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
	S
)
local T = c()
T.name = "modifier_vespera_2_upgrade_7"
d(T, h)
function T.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.ATTACK_DAMAGE_PROC] = function()
			self:Destroy()
			return self:GetAbilitySpecialValueFor("bonus_attack_damage")
		end,
	}
end
T = e(
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
	T
)
local U = c()
U.name = "modifier_vespera_upgrade_23"
d(U, h)
function U.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.smoke_radius = 0
end
function U.prototype.GetAbilitySpecialValue(self)
	self.smoke_radius = self:GetAbilitySpecialValueFor("smoke_radius")
end
function U.prototype.OnCreated(self, V)
	local W = self:GetParent()
	if IsServer() then
		local X = FindEnemiesInRadius(W, W:GetAbsOrigin(), self.smoke_radius)
		for Y, x in ipairs(X) do
			x:AddNewModifier(W, nil, "modifier_vespera_upgrade_23_blind", { duration = self:GetDuration() })
			x:Stop()
		end
	else
		local M = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_riki/riki_smokebomb.vpcf",
			PATTACH_CUSTOMORIGIN,
			W
		)
		ParticleManager:SetParticleControl(M, 0, W:GetAbsOrigin())
		ParticleManager:SetParticleControl(M, 1, Vector(self.smoke_radius, self.smoke_radius, self.smoke_radius))
		self:AddParticle(M, false, false, -1, false, false)
	end
end
function U.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():RemoveSelf()
	end
end
U = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	U
)
local Z = c()
Z.name = "modifier_vespera_upgrade_23_blind"
d(Z, h)
function Z.prototype.StaticState(self)
	return { [StateEnum.BLIND] = true }
end
Z = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	Z
)
return f