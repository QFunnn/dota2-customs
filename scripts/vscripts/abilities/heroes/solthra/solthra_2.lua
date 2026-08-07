--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
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
		if
			self:GetAutoCastState()
			and self:IsCooldownReady()
			and (o and o:IsCombatRoom() and not o:IsCombatEnd() or AbyssalHordeManager:IsRunning())
		then
			local p = Controller:GetInputDirection(n)
			if VectorIsZero(p) then
				p = n:GetForwardVector()
			end
			self:OnController(n:GetAbsOrigin() + p * self:GetSpecialValueFor("distance"), p)
		end
	end)
end
function m.prototype.OnController(self, q, p)
	local n = self:GetCaster()
	if q == nil then
		q = n:GetAbsOrigin() + p * self:GetSpecialValueFor("distance")
	end
	n:ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, self, q)
end
function m.prototype.GetCooldown(self, r)
	return math.max(k.prototype.GetCooldown(self, r) - self:GetSpecialValueFor("cooldown_reduction"), 0)
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
		dash_end = function(s, t)
			local n = self:GetCaster()
			if t.caster == n and n:HasAbilityUpgrade("solthra_upgrade_8") then
				local u = self:GetSpecialValueFor("burn_path_duration")
				local v = self:GetSpecialValueFor("burn_path_damage")
				local w = CalcDistance(t.start, t["end"])
				local x = CalcDirection2D(t["end"], t.start)
				local y = math.floor(w / 128)
				do
					local z = 0
					while z <= y do
						local A = t.start + x * z * 128
						local B = t.start + x * math.min((z + 1) * 128, w)
						local C = ParticleManager:CreateParticle(
							"particles/units/heroes/hero_mars/mars_spear_burning_trail.vpcf",
							PATTACH_CUSTOMORIGIN,
							nil
						)
						ParticleManager:SetParticleControl(C, 0, A)
						ParticleManager:SetParticleControl(C, 1, B)
						ParticleManager:SetParticleControl(C, 2, Vector(u, 0, 0))
						ParticleManager:ReleaseParticleIndex(C)
						z = z + 1
					end
				end
				self:StartThink(0, DoUniqueString("solthra_upgrade_8"), function()
					if u > 0 then
						local D = FindEnemiesInLine(n, t.start, t["end"], 160)
						for z, E in ipairs(D) do
							n:Burning(E, self, v)
						end
						u = u - 0.1
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
	local q = self:GetCursorPosition()
	n:FadeGesture(ACT_DOTA_ATTACK_EVENT)
	local p = CalcDirection2D(q, n:GetAbsOrigin())
	n:SetForwardVector(p)
	local F = math.min(self:GetSpecialValueFor("distance"), CalcDistance(q, n))
	local G = self:GetSpecialValueFor("speed")
	local H = F / G
	local I = 0
	n:AddNewModifier(n, self, "modifier_solthra_2_dash", { duration = H })
	local J = self:GetSpecialValueFor("bouns_duration")
	if J > 0 then
		n:AddNewModifier(n, self, "modifier_solthra_2_upgrade_7", { duration = J })
	end
	n:Dash(p, F, I, H)
	n:EmitSound("Hero_EmberSpirit.FireRemnant.Create")
	local K = self:GetSpecialValueFor("fury_gain")
	if K > 0 then
		n:GiveMana(K)
	end
end
m = e({ l(nil) }, m)
local L = c()
L.name = "modifier_solthra_2_dash"
d(L, h)
function L.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function L.prototype.OnCreated(self, M)
	local N = self:GetParent()
	if IsServer() then
		local O = self:GetAbility()
		Bullet:CreateCustomBullet({
			caster = N,
			spawnOrigin = N:GetAbsOrigin(),
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = UNIT_AND_BUILDING,
			radius = 160,
			lifeTime = self:GetDuration(),
			PathFunction = function(q, P)
				return N:GetAbsOrigin()
			end,
			FuncUnitFinder = function(Q, q, R, P)
				return FindUnitsInRadius(
					N:GetTeamNumber(),
					q,
					nil,
					R,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					UNIT_AND_BUILDING,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
			end,
			OnBulletHit = function(S, T, U)
				N:DealDamage(S, O, self.damage)
			end,
		})
	else
		local C = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_ember_spirit/ember_spirit_remnant_dash.vpcf",
			PATTACH_CUSTOMORIGIN,
			N
		)
		ParticleManager:SetParticleControlEnt(C, 0, N, PATTACH_POINT_FOLLOW, "attach_hitloc", N:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(C, 1, N, PATTACH_POINT_FOLLOW, "attach_hitloc", N:GetAbsOrigin(), true)
		self:AddParticle(C, false, false, -1, false, false)
	end
end
function L.prototype.StaticProperty(self)
	return { [PropertyFunction.AVOID_DAMAGE] = 1 }
end
function L.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true, [StateEnum.STUN_IMMUNE] = true, [StateEnum.KNOCKBACK_IMMUNE] = true }
end
L = e(
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
	L
)
local V = c()
V.name = "modifier_solthra_2_upgrade_7"
d(V, h)
function V.prototype.GetAbilitySpecialValue(self)
	self.bouns_count = self:GetAbilitySpecialValueFor("bouns_count")
	self.bouns_duration = self:GetAbilitySpecialValueFor("bouns_duration")
end
function V.prototype.OnCreated(self, M)
	if IsServer() then
		self:AddStackCountDuration(1, self.bouns_duration)
	end
end
function V.prototype.OnRefresh(self, M)
	if IsServer() then
		self:AddStackCountDuration(1, self.bouns_duration)
	end
end
function V.prototype.StaticProperty(self)
	return { [PropertyFunction.SPLIT_COUNT] = self.bouns_count * self:GetStackCount() }
end
V = e(
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
	V
)
return f