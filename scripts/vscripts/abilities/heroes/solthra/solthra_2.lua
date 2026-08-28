--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/solthra/solthra_2"
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
m.name = "solthra_2"
d(m, k)
function m.prototype.OnCreated(self)
	local n = self:GetCaster()
	self:StartThink(0, function()
		local o = DungeonManager:GetCurrentRoom()
		local p = DungeonAdventure:IsPlayerInRunningAdventure(n:GetPlayerOwnerID())
		if
			self:IsCooldownReady()
			and (
				Demo.force_dash_auto_cast
				or self:GetAutoCastState()
					and (o and o:IsCombatRoom() and not o:IsCombatEnd() or AbyssalHordeManager:IsRunning() or p)
			)
		then
			if Demo.force_dash_auto_cast and not Demo:CanForceDashAutoCast(n) then
				return
			end
			local q = Demo.force_dash_auto_cast and Demo:GetForceDashDirection(n, self)
				or Controller:GetInputDirection(n)
			if VectorIsZero(q) then
				q = n:GetForwardVector()
			end
			self:OnController(n:GetAbsOrigin() + q * self:GetSpecialValueFor("distance"), q)
			if Demo.force_dash_auto_cast then
				Demo:MarkForceDashAutoCast(n)
			end
		end
	end)
end
function m.prototype.OnController(self, r, q)
	local n = self:GetCaster()
	if r == nil then
		r = n:GetAbsOrigin() + q * self:GetSpecialValueFor("distance")
	end
	n:ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, self, r)
end
function m.prototype.GetCooldown(self, s)
	return math.max(k.prototype.GetCooldown(self, s) - self:GetSpecialValueFor("cooldown_reduction"), 0)
end
function m.prototype.GetCastCooldown(self)
	return self:GetSpecialValueFor("distance") / self:GetSpecialValueFor("speed")
end
function m.prototype.StaticProperty(self)
	return {
		[PropertyFunction.ATTACKSPEED] = self:GetStackCount() * self:GetSpecialValueFor("attackspeed_bonus"),
		[PropertyFunction.ABILITY_CHARGE_DODGE] = self:GetSpecialValueFor("charge"),
	}
end
function m.prototype.EventListener(self)
	return {
		dash_end = function(t, u)
			local n = self:GetCaster()
			if u.caster == n and n:HasAbilityUpgrade("solthra_upgrade_8") then
				local v = self:GetSpecialValueFor("burn_path_duration")
				local w = self:GetSpecialValueFor("burn_path_damage")
				local x = CalcDistance(u.start, u["end"])
				local y = CalcDirection2D(u["end"], u.start)
				local z = math.floor(x / 128)
				do
					local A = 0
					while A <= z do
						local B = u.start + y * A * 128
						local C = u.start + y * math.min((A + 1) * 128, x)
						local D = ParticleManager:CreateParticle(
							"particles/units/heroes/hero_mars/mars_spear_burning_trail.vpcf",
							PATTACH_CUSTOMORIGIN,
							nil
						)
						ParticleManager:SetParticleControl(D, 0, B)
						ParticleManager:SetParticleControl(D, 1, C)
						ParticleManager:SetParticleControl(D, 2, Vector(v, 0, 0))
						ParticleManager:ReleaseParticleIndex(D)
						A = A + 1
					end
				end
				self:StartThink(0, DoUniqueString("solthra_upgrade_8"), function()
					if v > 0 then
						local E = FindEnemiesInLine(n, u.start, u["end"], 160)
						for A, F in ipairs(E) do
							n:Burning(F, self, w)
						end
						v = v - 0.1
						return 0.1
					end
					return -1
				end)
			end
		end,
	}
end
function m.prototype.OnSpellStart(self)
	local n = self:GetCaster()
	local r = self:GetCursorPosition()
	n:FadeGesture(ACT_DOTA_ATTACK_EVENT)
	local q = CalcDirection2D(r, n:GetAbsOrigin())
	n:SetForwardVector(q)
	local G = math.min(self:GetSpecialValueFor("distance"), CalcDistance(r, n))
	local H = self:GetSpecialValueFor("speed")
	local I = G / H
	local J = 0
	n:AddNewModifier(n, self, "modifier_solthra_2_dash", { duration = I })
	local K = self:GetSpecialValueFor("bouns_duration")
	if K > 0 then
		n:AddNewModifier(n, self, "modifier_solthra_2_upgrade_7", { duration = K })
	end
	n:Dash(q, G, J, I)
	n:EmitSound("Hero_EmberSpirit.FireRemnant.Create")
	local L = self:GetSpecialValueFor("fury_gain")
	if L > 0 then
		n:GiveMana(L)
	end
end
m = e({ l(nil) }, m)
local M = c()
M.name = "modifier_solthra_2_dash"
d(M, h)
function M.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function M.prototype.OnCreated(self, N)
	local O = self:GetParent()
	if IsServer() then
		local P = self:GetAbility()
		Bullet:CreateCustomBullet({
			caster = O,
			spawnOrigin = O:GetAbsOrigin(),
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = UNIT_AND_BUILDING,
			radius = 160,
			lifeTime = self:GetDuration(),
			PathFunction = function(r, Q)
				return O:GetAbsOrigin()
			end,
			FuncUnitFinder = function(R, r, S, Q)
				return FindUnitsInRadius(
					O:GetTeamNumber(),
					r,
					nil,
					S,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					UNIT_AND_BUILDING,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
			end,
			OnBulletHit = function(T, U, V)
				O:DealDamage(T, P, self.damage)
			end,
		})
	else
		local D = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_ember_spirit/ember_spirit_remnant_dash.vpcf",
			PATTACH_CUSTOMORIGIN,
			O
		)
		ParticleManager:SetParticleControlEnt(D, 0, O, PATTACH_POINT_FOLLOW, "attach_hitloc", O:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(D, 1, O, PATTACH_POINT_FOLLOW, "attach_hitloc", O:GetAbsOrigin(), true)
		self:AddParticle(D, false, false, -1, false, false)
	end
end
function M.prototype.StaticProperty(self)
	return { [PropertyFunction.AVOID_DAMAGE] = 1 }
end
function M.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true, [StateEnum.STUN_IMMUNE] = true, [StateEnum.KNOCKBACK_IMMUNE] = true }
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
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	M
)
local W = c()
W.name = "modifier_solthra_2_upgrade_7"
d(W, h)
function W.prototype.GetAbilitySpecialValue(self)
	self.bouns_count = self:GetAbilitySpecialValueFor("bouns_count")
	self.bouns_duration = self:GetAbilitySpecialValueFor("bouns_duration")
end
function W.prototype.OnCreated(self, N)
	if IsServer() then
		self:AddStackCountDuration(1, self.bouns_duration)
	end
end
function W.prototype.OnRefresh(self, N)
	if IsServer() then
		self:AddStackCountDuration(1, self.bouns_duration)
	end
end
function W.prototype.StaticProperty(self)
	return { [PropertyFunction.SPLIT_COUNT] = self.bouns_count * self:GetStackCount() }
end
W = e(
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
	W
)
return f