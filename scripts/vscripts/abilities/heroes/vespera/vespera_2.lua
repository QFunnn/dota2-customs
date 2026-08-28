--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		local r = DungeonAdventure:IsPlayerInRunningAdventure(p:GetPlayerOwnerID())
		if
			self:IsCooldownReady()
			and (
				Demo.force_dash_auto_cast
				or self:GetAutoCastState()
					and (q and q:IsCombatRoom() and not q:IsCombatEnd() or AbyssalHordeManager:IsRunning() or r)
			)
		then
			if Demo.force_dash_auto_cast and not Demo:CanForceDashAutoCast(p) then
				return
			end
			local o = Demo.force_dash_auto_cast and Demo:GetForceDashDirection(p, self)
				or Controller:GetInputDirection(p)
			if VectorIsZero(o) then
				o = p:GetForwardVector()
			end
			self:OnController(p:GetAbsOrigin() + o * self:GetSpecialValueFor("distance"), o)
			if Demo.force_dash_auto_cast then
				Demo:MarkForceDashAutoCast(p)
			end
		end
	end)
end
function m.prototype.CreateDashDamageBullet(self, s, t)
	if t == nil then
		t = EOM_DAMAGE_FLAGS.NONE
	end
	if s <= 0 then
		return
	end
	local p = self:GetCaster()
	local u = Bullet:CreateCustomBullet({
		caster = p,
		spawnOrigin = p:GetAbsOrigin(),
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		radius = self:GetSpecialValueFor("dash_width"),
		lifeTime = 2,
		PathFunction = function(n, v)
			return p:GetAbsOrigin()
		end,
		FuncUnitFinder = function(w, n, x, v)
			return FindUnitsInRadius(
				p:GetTeamNumber(),
				n,
				nil,
				x,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)
		end,
		OnBulletHit = function(y, z, A)
			p:DealDamage(y, self, s, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL, t)
		end,
	})
	if u ~= nil then
		if self.bulletID == nil then
			self.bulletID = {}
		end
		local B = self.bulletID
		B[#B + 1] = u
	end
end
function m.prototype.EventListener(self)
	return {
		dash_start = function(C, D)
			local p = self:GetCaster()
			if D.caster ~= p then
				return
			end
			local E = self:GetSpecialValueFor("dash_damage")
			self:CreateDashDamageBullet(E)
			if AbilityUpgrade:HasAbilityUpgrade(p, "vespera_upgrade_12") then
				p:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK_EVENT_BASH, 2)
			end
		end,
		dash_end = function(C, D)
			local p = self:GetCaster()
			if D.caster ~= p then
				return
			end
			if AbilityUpgrade:HasAbilityUpgrade(p, "vespera_upgrade_12") then
				local F = p:GetAbilityByTag(AbilityTag.Attack)
				if IsValid(F) then
					local G = -p:GetForwardVector()
					local H = p:Script_GetAttackRange()
					p:SetForwardVector(G)
					p:SetCursorPosition(p:GetAbsOrigin() + G * H)
					p:AddNewModifier(
						p,
						F,
						"modifier_vespera_combo_final",
						{ duration = p:GetSecondsPerAttack(false) + 60 }
					)
					p:AddNewModifier(p, F, "modifier_vespera_upgrade_12_backstab", { duration = 1 })
					F:Attack(D.start, D["end"])
					p:RemoveModifierByName("modifier_vespera_upgrade_12_backstab")
				end
			end
			if AbilityUpgrade:HasAbilityUpgrade(p, "vespera_upgrade_7") then
				if p:HasAbilityUpgrade("vespera_upgrade_7") then
					local I = p:GetAbilityByTag(AbilityTag.Attack)
					p:AddNewModifier(
						p,
						I,
						"modifier_vespera_combo_final",
						{ duration = p:GetSecondsPerAttack(false) + 60 }
					)
				end
			end
			if self.bulletID ~= nil then
				for C, u in ipairs(self.bulletID) do
					Bullet:DestroyBulletByID(u)
				end
			end
		end,
	}
end
function m.prototype.GetCastCooldown(self)
	return self:GetSpecialValueFor("duration")
end
function m.prototype.GetCooldown(self, J)
	return math.max(
		(k.prototype.GetCooldown(self, J) - self:GetSpecialValueFor("cooldown_reduction"))
			* (1 - self:GetSpecialValueFor("cooldown_pct") * 0.01),
		0
	)
end
function m.prototype.OnSpellStart(self)
	local p = self:GetCaster()
	local K = p:GetAbsOrigin()
	p:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1)
	local n = self:GetCursorPosition()
	n.z = K.z
	local o = CalcDirection2D(n, p)
	local L = math.min(self:GetSpecialValueFor("distance"), CalcDistance(n, p))
	local M = self:GetSpecialValueFor("duration")
	local N = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_fx_chongci_01.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		p
	)
	ParticleManager:SetParticleControlTransformForward(N, 0, p:GetAbsOrigin(), o)
	p:Dash(o, L, 0, M)
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
		local O = self:GetSpecialValueFor("smoke_duration")
		CreateModifierThinker(p, self, "modifier_vespera_upgrade_23", { duration = O }, K, p:GetTeamNumber(), false)
		p:EmitSound("Hero_Riki.Smoke_Screen")
	end
end
function m.prototype.FanOfKnives(self)
	local p = self:GetCaster()
	local P = self:GetSpecialValueFor("dagger_count")
	local L = self:GetSpecialValueFor("dagger_distance")
	local Q = self:GetSpecialValueFor("dagger_width")
	local R = self:GetSpecialValueFor("dagger_speed")
	local s = self:GetSpecialValueFor("dagger_damage")
	local o = self:GetForwardVector()
	Bullet:SplitAction(o, P, 360 / P, function(C, S)
		Bullet:CreateLinearBullet({
			ability = self,
			caster = p,
			effectName = "particles/units/heroes/hero_phantom_assassin/phantom_assassin_2_dagger.vpcf",
			spawnOrigin = p:GetAttachmentPosition("attach_hitloc"),
			direction = S,
			moveSpeed = R,
			distance = L,
			radius = Q,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			OnBulletHit = function(y, z, A)
				p:DealDamage(y, self, s, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
			end,
		})
	end)
end
m = e({ l(nil) }, m)
local T = c()
T.name = "modifier_vespera_2_attackspeed"
d(T, h)
function T.prototype.StaticProperty(self)
	return { [PropertyFunction.ATTACKSPEED] = self:GetAbilitySpecialValueFor("attackspeed") }
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
U.name = "modifier_vespera_2_upgrade_7"
d(U, h)
function U.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.ATTACK_DAMAGE_PROC] = function()
			self:Destroy()
			return self:GetAbilitySpecialValueFor("bonus_attack_damage")
		end,
	}
end
U = e(
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
	U
)
local V = c()
V.name = "modifier_vespera_upgrade_23"
d(V, h)
function V.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.smoke_radius = 0
end
function V.prototype.GetAbilitySpecialValue(self)
	self.smoke_radius = self:GetAbilitySpecialValueFor("smoke_radius")
end
function V.prototype.OnCreated(self, W)
	local X = self:GetParent()
	if IsServer() then
		local Y = FindEnemiesInRadius(X, X:GetAbsOrigin(), self.smoke_radius)
		for Z, y in ipairs(Y) do
			y:AddNewModifier(X, nil, "modifier_vespera_upgrade_23_blind", { duration = self:GetDuration() })
			y:Stop()
		end
	else
		local N = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_riki/riki_smokebomb.vpcf",
			PATTACH_CUSTOMORIGIN,
			X
		)
		ParticleManager:SetParticleControl(N, 0, X:GetAbsOrigin())
		ParticleManager:SetParticleControl(N, 1, Vector(self.smoke_radius, self.smoke_radius, self.smoke_radius))
		self:AddParticle(N, false, false, -1, false, false)
	end
end
function V.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():RemoveSelf()
	end
end
V = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	V
)
local _ = c()
_.name = "modifier_vespera_upgrade_23_blind"
d(_, h)
function _.prototype.StaticState(self)
	return { [StateEnum.BLIND] = true }
end
_ = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	_
)
return f