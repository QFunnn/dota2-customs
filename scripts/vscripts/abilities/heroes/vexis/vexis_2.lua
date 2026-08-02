--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/vexis/vexis_2"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "vexis_2"
d(j, h)
function j.prototype.OnCreated(self)
	local k = self:GetCaster()
	self:StartThink(0, function()
		local l = DungeonManager:GetCurrentRoom()
		if
			self:GetAutoCastState()
			and self:IsCooldownReady()
			and (l and l:IsCombatRoom() and not l:IsCombatEnd() or AbyssalHordeManager:IsRunning())
		then
			local m = Controller:GetInputDirection(k)
			if VectorIsZero(m) then
				m = k:GetForwardVector()
			end
			self:OnController(k:GetAbsOrigin() + m * self:GetSpecialValueFor("distance"), m)
		end
	end)
end
function j.prototype.OnController(self, n, m)
	local k = self:GetCaster()
	if n == nil then
		n = k:GetAbsOrigin() + m * self:GetSpecialValueFor("distance")
	end
	k:ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, self, n)
end
function j.prototype.GetCastCooldown(self)
	return self:GetSpecialValueFor("distance") / self:GetSpecialValueFor("speed")
end
function j.prototype.GetCooldown(self, o)
	return math.max(h.prototype.GetCooldown(self, o) - self:GetSpecialValueFor("cooldown_reduction"), 0)
end
function j.prototype.StaticProperty(self)
	return { [PropertyFunction.ATTACKSPEED] = self:GetStackCount() * self:GetSpecialValueFor("attackspeed_bonus") }
end
function j.prototype.EventListener(self)
	return {
		dash_start = function(p, q)
			local k = self:GetCaster()
			if q.caster ~= k then
				return
			end
			local r = self:GetSpecialValueFor("dash_damage")
			if r > 0 then
				self.bulletID = Bullet:CreateCustomBullet({
					caster = k,
					spawnOrigin = k:GetAbsOrigin(),
					teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
					typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
					radius = self:GetSpecialValueFor("dash_width"),
					lifeTime = 2,
					PathFunction = function(n, s)
						return k:GetAbsOrigin()
					end,
					FuncUnitFinder = function(t, n, u, s)
						return FindUnitsInRadius(
							k:GetTeamNumber(),
							n,
							nil,
							u,
							DOTA_UNIT_TARGET_TEAM_ENEMY,
							DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
							DOTA_UNIT_TARGET_FLAG_NONE,
							FIND_ANY_ORDER,
							false
						)
					end,
					OnBulletHit = function(v, w, x)
						k:DealDamage(v, self, r, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
					end,
				})
			end
			if k:HasAbilityUpgrade("vexis_upgrade_holy_1") then
				local y = LASER_LENGTH + GetBulletRange(k)
				local z = FindUnitsInRadiusWithAbility(k, k:GetAbsOrigin(), y, self)
				local v = GetRandomElement(z)
				local n = IsValid(v) and v:GetAbsOrigin() or k:GetAbsOrigin() + RandomVector(300)
				k:Laser(CalcDirection2D(n, k), self:GetSpecialValueFor("laser_damage"))
			end
		end,
		dash_end = function(p, q)
			local k = self:GetCaster()
			if k == q.caster then
				if AbilityUpgrade:HasAbilityUpgrade(k, "vexis_upgrade_4") then
					local y = CalcDistance(q.start, q["end"])
					local A = 0.5
					local B = self:GetSpecialValueFor("grenade_damage")
					local C = self:GetSpecialValueFor("grenade_radius")
					local D = self:GetSpecialValueFor("grenade_count")
					local E = self:GetSpecialValueFor("grenade_knockback")
					do
						local F = 0
						while F < D do
							local n = F == 0 and q.start or q.start + RandomVector(150)
							local G = ParticleManager:CreateParticle(
								"models/eom/hero/shooter_1/particles/shooter_1_elude_01_fx.vpcf",
								PATTACH_CUSTOMORIGIN,
								nil
							)
							ParticleManager:SetParticleControl(G, 0, q["end"])
							ParticleManager:SetParticleControl(G, 1, Vector(y / A, 0, 0))
							ParticleManager:SetParticleControl(G, 5, n)
							self:StartThink(A + F * 0.15, DoUniqueString("dash_end"), function()
								if k:HasAbilityUpgrade("vexis_upgrade_4_2") then
									Bullet:CreateCustomBullet({
										caster = k,
										spawnOrigin = n,
										lifeTime = 10,
										radius = C,
										teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
										typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
										OnBulletHit = function(s)
											return true
										end,
										FuncUnitFinder = function(t, n, u, s)
											return FindEnemiesInRadius(k, n, u)
										end,
										OnBulletDestroy = function(s)
											ParticleManager:DestroyParticle(G, false)
											local z = FindUnitsInRadiusWithAbility(k, n, C, self)
											for H, v in ipairs(z) do
												k:DealDamage(v, self, B)
												v:KnockBack(CalcDirection2D(v, n), E, 0, 0.3)
											end
											k:EmitSound("Hero_Sniper.ConcussiveGrenade")
										end,
									})
								else
									ParticleManager:DestroyParticle(G, false)
									local z = FindUnitsInRadiusWithAbility(k, n, C, self)
									for H, v in ipairs(z) do
										k:DealDamage(v, self, B)
										v:KnockBack(CalcDirection2D(v, n), E, 0, 0.3)
									end
									k:EmitSound("Hero_Sniper.ConcussiveGrenade")
								end
								return -1
							end)
							F = F + 1
						end
					end
				end
				if AbilityUpgrade:HasAbilityUpgrade(k, "vexis_upgrade_13") then
					local I = k:GetAbilityByTag(AbilityTag.Skill)
					if IsValid(I) then
						I:PowerShot(k:GetAttachmentPosition("attach_attack3"), CalcDirection2D(q.start, q["end"]), 1)
						Event:Fire(
							"ability_cast_complete",
							{
								ability = I,
								caster = k,
								position = I:GetCursorPosition(),
								abilityTag = I:GetAbilityTag(),
								record = "vexis_upgrade_13",
							}
						)
					end
				end
				if k:HasAbilityUpgrade("vexis_upgrade_poison_1") then
					local D = 1
					do
						local F = 0
						while F < D do
							local A = 0.5 + F * 0.15
							local n = F == 0 and q.start or q.start + RandomVector(150)
							k:ThrowPoisonBottle(n, self, 2, A)
							F = F + 1
						end
					end
				end
				if self.bulletID ~= nil then
					Bullet:DestroyBulletByID(self.bulletID)
				end
				self:SetStackCount(1, false)
				self:StartThink(self:GetSpecialValueFor("attackspeed_duration"), "attackspeed_duration", function()
					self:SetStackCount(0, false)
					return -1
				end)
			end
		end,
	}
end
function j.prototype.OnSpellStart(self)
	local k = self:GetCaster()
	local n = self:GetCursorPosition()
	k:StartGesture(ACT_DOTA_CAST_ABILITY_3)
	local m = CalcDirection2D(n, k:GetAbsOrigin())
	k:SetForwardVector(m)
	local G = ParticleManager:CreateParticle(
		"models/eom/hero/shooter_1/particles/shooter_1_elude_fx.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		k
	)
	ParticleManager:SetParticleControlTransformForward(G, 1, k:GetAbsOrigin(), m)
	local y = math.min(self:GetSpecialValueFor("distance"), CalcDistance(n, k))
	local J = self:GetSpecialValueFor("speed")
	local A = y / J
	local K = 0
	k:Dash(m, y, K, A)
	k:EmitSound("Hero_QueenOfPain.Blink_in.Layer")
end
j = e({ i(nil) }, j)
return f