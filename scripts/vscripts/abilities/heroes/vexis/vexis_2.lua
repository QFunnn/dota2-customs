--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		local m = DungeonAdventure:IsPlayerInRunningAdventure(k:GetPlayerOwnerID())
		if
			self:IsCooldownReady()
			and (
				Demo.force_dash_auto_cast
				or self:GetAutoCastState()
					and (l and l:IsCombatRoom() and not l:IsCombatEnd() or AbyssalHordeManager:IsRunning() or m)
			)
		then
			if Demo.force_dash_auto_cast and not Demo:CanForceDashAutoCast(k) then
				return
			end
			local n = Demo.force_dash_auto_cast and Demo:GetForceDashDirection(k, self)
				or Controller:GetInputDirection(k)
			if VectorIsZero(n) then
				n = k:GetForwardVector()
			end
			self:OnController(k:GetAbsOrigin() + n * self:GetSpecialValueFor("distance"), n)
			if Demo.force_dash_auto_cast then
				Demo:MarkForceDashAutoCast(k)
			end
		end
	end)
end
function j.prototype.OnController(self, o, n)
	local k = self:GetCaster()
	if o == nil then
		o = k:GetAbsOrigin() + n * self:GetSpecialValueFor("distance")
	end
	k:ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, self, o)
end
function j.prototype.GetCastCooldown(self)
	return self:GetSpecialValueFor("distance") / self:GetSpecialValueFor("speed")
end
function j.prototype.GetCooldown(self, p)
	return math.max(h.prototype.GetCooldown(self, p) - self:GetSpecialValueFor("cooldown_reduction"), 0)
end
function j.prototype.StaticProperty(self)
	return { [PropertyFunction.ATTACKSPEED] = self:GetStackCount() * self:GetSpecialValueFor("attackspeed_bonus") }
end
function j.prototype.EventListener(self)
	return {
		dash_start = function(q, r)
			local k = self:GetCaster()
			if r.caster ~= k then
				return
			end
			local s = self:GetSpecialValueFor("dash_damage")
			if s > 0 then
				self.bulletID = Bullet:CreateCustomBullet({
					caster = k,
					spawnOrigin = k:GetAbsOrigin(),
					teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
					typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
					radius = self:GetSpecialValueFor("dash_width"),
					lifeTime = 2,
					PathFunction = function(o, t)
						return k:GetAbsOrigin()
					end,
					FuncUnitFinder = function(u, o, v, t)
						return FindUnitsInRadius(
							k:GetTeamNumber(),
							o,
							nil,
							v,
							DOTA_UNIT_TARGET_TEAM_ENEMY,
							DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
							DOTA_UNIT_TARGET_FLAG_NONE,
							FIND_ANY_ORDER,
							false
						)
					end,
					OnBulletHit = function(w, x, y)
						k:DealDamage(w, self, s, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
					end,
				})
			end
			if k:HasAbilityUpgrade("vexis_upgrade_holy_1") then
				local z = LASER_LENGTH + GetBulletRange(k)
				local A = FindUnitsInRadiusWithAbility(k, k:GetAbsOrigin(), z, self)
				local w = GetRandomElement(A)
				local o = IsValid(w) and w:GetAbsOrigin() or k:GetAbsOrigin() + RandomVector(300)
				k:Laser(CalcDirection2D(o, k), self:GetSpecialValueFor("laser_damage"))
			end
		end,
		dash_end = function(q, r)
			local k = self:GetCaster()
			if k == r.caster then
				if AbilityUpgrade:HasAbilityUpgrade(k, "vexis_upgrade_4") then
					local z = CalcDistance(r.start, r["end"])
					local B = 0.5
					local C = self:GetSpecialValueFor("grenade_damage")
					local D = self:GetSpecialValueFor("grenade_radius")
					local E = self:GetSpecialValueFor("grenade_count")
					local F = self:GetSpecialValueFor("grenade_knockback")
					do
						local G = 0
						while G < E do
							local o = G == 0 and r.start or r.start + RandomVector(150)
							local H = ParticleManager:CreateParticle(
								"models/eom/hero/shooter_1/particles/shooter_1_elude_01_fx.vpcf",
								PATTACH_CUSTOMORIGIN,
								nil
							)
							ParticleManager:SetParticleControl(H, 0, r["end"])
							ParticleManager:SetParticleControl(H, 1, Vector(z / B, 0, 0))
							ParticleManager:SetParticleControl(H, 5, o)
							self:StartThink(B + G * 0.15, DoUniqueString("dash_end"), function()
								if k:HasAbilityUpgrade("vexis_upgrade_4_2") then
									Bullet:CreateCustomBullet({
										caster = k,
										spawnOrigin = o,
										lifeTime = 10,
										radius = D,
										teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
										typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
										OnBulletHit = function(t)
											return true
										end,
										FuncUnitFinder = function(u, o, v, t)
											return FindEnemiesInRadius(k, o, v)
										end,
										OnBulletDestroy = function(t)
											ParticleManager:DestroyParticle(H, false)
											local A = FindUnitsInRadiusWithAbility(k, o, D, self)
											for I, w in ipairs(A) do
												k:DealDamage(w, self, C)
												w:KnockBack(CalcDirection2D(w, o), F, 0, 0.3)
											end
											k:EmitSound("Hero_Sniper.ConcussiveGrenade")
										end,
									})
								else
									ParticleManager:DestroyParticle(H, false)
									local A = FindUnitsInRadiusWithAbility(k, o, D, self)
									for I, w in ipairs(A) do
										k:DealDamage(w, self, C)
										w:KnockBack(CalcDirection2D(w, o), F, 0, 0.3)
									end
									k:EmitSound("Hero_Sniper.ConcussiveGrenade")
								end
								return -1
							end)
							G = G + 1
						end
					end
				end
				if AbilityUpgrade:HasAbilityUpgrade(k, "vexis_upgrade_13") then
					local J = k:GetAbilityByTag(AbilityTag.Skill)
					if IsValid(J) then
						J:PowerShot(k:GetAttachmentPosition("attach_attack3"), CalcDirection2D(r.start, r["end"]), 1)
						Event:Fire(
							"ability_cast_complete",
							{
								ability = J,
								caster = k,
								position = J:GetCursorPosition(),
								abilityTag = J:GetAbilityTag(),
								record = "vexis_upgrade_13",
							}
						)
					end
				end
				if k:HasAbilityUpgrade("vexis_upgrade_poison_1") then
					local E = 1
					do
						local G = 0
						while G < E do
							local B = 0.5 + G * 0.15
							local o = G == 0 and r.start or r.start + RandomVector(150)
							k:ThrowPoisonBottle(o, self, 2, B)
							G = G + 1
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
	local o = self:GetCursorPosition()
	k:StartGesture(ACT_DOTA_CAST_ABILITY_3)
	local n = CalcDirection2D(o, k:GetAbsOrigin())
	k:SetForwardVector(n)
	local H = ParticleManager:CreateParticle(
		"models/eom/hero/shooter_1/particles/shooter_1_elude_fx.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		k
	)
	ParticleManager:SetParticleControlTransformForward(H, 1, k:GetAbsOrigin(), n)
	local z = math.min(self:GetSpecialValueFor("distance"), CalcDistance(o, k))
	local K = self:GetSpecialValueFor("speed")
	local B = z / K
	local L = 0
	k:Dash(n, z, L, B)
	k:EmitSound("Hero_QueenOfPain.Blink_in.Layer")
end
j = e({ i(nil) }, j)
return f