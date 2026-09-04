--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ELITE_024_PRIMARY_SPEED = 1400
local ELITE_024_SPLIT_SPEED = 800
local ELITE_024_PRIMARY_RANGE = 1200
local ELITE_024_SPLIT_DISTANCE = 550
local ELITE_024_SPLIT_FAN_ANGLE = 45
local ELITE_024_RECOIL_DURATION = 0.4
local ELITE_024_RECOIL_DISTANCE = 80
local ELITE_024_PRIMARY_AOE_RADIUS = 300
local ELITE_024_SPLIT_AOE_RADIUS = 150
local ELITE_024_PRIMARY_DAMAGE_RATE = 18
local ELITE_024_SPLIT_DAMAGE_RATE = 10
--- 精英技能24 - 原始兽岩石投掷：落地后向后方分裂出三块岩石
____exports.elite_024 = __TS__Class()
local elite_024 = ____exports.elite_024
elite_024.name = "elite_024"
__TS__ClassExtends(elite_024, MonsterAbility_CS)
function elite_024.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_impact.vpcf",
		context
	)
end
function elite_024.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = ELITE_024_PRIMARY_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_POINT,
		castPoint = 0.8,
		castDuration = 0.7,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		OnPhaseStart = function()
			self:WarningRingEffect(self:GetCursorPosition(), ELITE_024_PRIMARY_AOE_RADIUS, 0.8)
		end,
		OnStart = function()
			if not IsServer() then
				return
			end
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:EmitSound("Hero_PrimalBeast.RockThrow.Cast")
			local casterPos = caster:GetAbsOrigin()
			local cursorPos = self:GetCursorPosition()
			local direction = GetDirection(nil, cursorPos, casterPos)
			caster:Mover(
				caster:GetAbsOrigin():__add(direction:__mul(-ELITE_024_RECOIL_DISTANCE)),
				ELITE_024_RECOIL_DURATION,
				nil,
				true
			)
			CreateProjectile(nil, {
				ability = self,
				caster = caster,
				effect_name = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw.vpcf",
				projectile_type = "collideground",
				projectile_speed = ELITE_024_PRIMARY_SPEED,
				start_point = caster:GetAttachmentOrigin(caster:ScriptLookupAttachment("attach_attack1")),
				target = cursorPos,
				on_hit = function(____, _hitTarget, location)
					if not IsServer() or not IsValidAlive(nil, caster) then
						return true
					end
					local groundZ = GetGroundHeight(location, caster) or location.z
					local hitPos = Vector(location.x, location.y, groundZ)
					self:PlayImpactEffect(hitPos)
					self:DealDamageInRadius(caster, hitPos, ELITE_024_PRIMARY_AOE_RADIUS, ELITE_024_PRIMARY_DAMAGE_RATE)
					local baseDir = hitPos:__sub(caster:GetAbsOrigin())
					local len = baseDir:Length2D()
					local dir
					if len > 0 then
						dir = baseDir:__mul(1 / len)
					else
						dir = caster:GetForwardVector()
					end
					local halfFan = ELITE_024_SPLIT_FAN_ANGLE * 0.5
					local angles = { -halfFan, 0, halfFan }
					for ____, a in ipairs(angles) do
						local backDir = dir:__mul(-1)
						local splitDir = RotateVector2D(nil, backDir, a)
						local landPos = hitPos:__sub(splitDir:__mul(ELITE_024_SPLIT_DISTANCE))
						landPos.z = GetGroundPosition(landPos, caster).z
						local speed = ELITE_024_SPLIT_SPEED
						self:WarningRingEffect(landPos, ELITE_024_SPLIT_AOE_RADIUS, 0.8)
						CreateProjectile(nil, {
							ability = self,
							caster = caster,
							effect_name = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw.vpcf",
							projectile_type = "collideground",
							projectile_speed = speed,
							start_point = hitPos + Vector(0, 0, 96),
							target = landPos,
							on_hit = function(____, _t2, loc2)
								if not IsServer() or not IsValidAlive(nil, caster) then
									return true
								end
								local gz = GetGroundHeight(loc2, caster) or loc2.z
								local pos2 = Vector(loc2.x, loc2.y, gz)
								self:PlayImpactEffect(pos2)
								self:DealDamageInRadius(
									caster,
									pos2,
									ELITE_024_SPLIT_AOE_RADIUS,
									ELITE_024_SPLIT_DAMAGE_RATE
								)
								return true
							end,
						})
					end
					return true
				end,
			})
		end,
	}
end
function elite_024.prototype.DealDamageInRadius(self, caster, center, radius, damageRate)
	if not IsServer() or not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue18
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = damageRate, ability = self })
		end
		::__continue18::
	end
end
function elite_024.prototype.PlayImpactEffect(self, origin)
	if not IsServer() then
		return
	end
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_impact.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 1, origin)
	ParticleManager:SetParticleControl(pfx, 3, origin)
	ParticleManager:ReleaseParticleIndex(pfx)
end
elite_024 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_024)
____exports.elite_024 = elite_024
return ____exports