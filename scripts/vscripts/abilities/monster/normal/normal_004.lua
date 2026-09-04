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
--- 施法距离 / 单次跳跃最大位移
local CAST_RANGE = 400
--- 搜敌范围（可大于施法距离，用于取向与选点）
local SEARCH_RANGE = 600
local JUMP_HEIGHT = 350
local JUMP_DURATION = 0.5
local CAST_POINT = 0.35
local LAND_DAMAGE_RADIUS = 175
local LAND_DAMAGE_RATE = 5
local BLUR_FX = "particles/units/heroes/hero_tiny/tiny_toss_blur.vpcf"
local THROW_SOUND = "Ability.TossThrow"
local LAND_SOUND = "Hero_Omniknight.Attack"
local function toGroundPos(self, v, context)
	local z = GetGroundHeight(v, context)
	local ____v_x_1 = v.x
	local ____v_y_2 = v.y
	local ____temp_0
	if z ~= nil then
		____temp_0 = z
	else
		____temp_0 = v.z
	end
	return Vector(____v_x_1, ____v_y_2, ____temp_0)
end
--- 普通技能4：600 内 FindHeroesInRadius 任一敌方取向，朝其方向最多跃 400；无则朝面向跃 400；落地小范围伤害；位移 tiny 模糊（CP0 绑自身）
____exports.normal_004 = __TS__Class()
local normal_004 = ____exports.normal_004
normal_004.name = "normal_004"
__TS__ClassExtends(normal_004, MonsterAbility_CS)
function normal_004.prototype.Precache(self, context)
	PrecacheResource("particle", BLUR_FX, context)
end
function normal_004.prototype.computeJump(self, caster)
	local origin = toGroundPos(nil, caster:GetAbsOrigin(), caster)
	local enemy
	for ____, u in ipairs(self:FindHeroesInRadius(SEARCH_RANGE)) do
		do
			if not IsValidAlive(nil, u) then
				goto __continue5
			end
			enemy = u
			break
		end
		::__continue5::
	end
	local face
	local landFlat
	if enemy then
		local ep = toGroundPos(nil, enemy:GetAbsOrigin(), enemy)
		local delta = ep:__sub(origin)
		local dist = delta:Length2D()
		if dist > 0.001 then
			face = Vector(delta.x / dist, delta.y / dist, 0)
		else
			local f = caster:GetForwardVector()
			local len2 = math.sqrt(f.x * f.x + f.y * f.y) or 1
			face = Vector(f.x / len2, f.y / len2, 0)
		end
		local leap = math.min(CAST_RANGE, dist)
		landFlat = origin:__add(face:__mul(leap))
	else
		local f = caster:GetForwardVector()
		local len2 = math.sqrt(f.x * f.x + f.y * f.y) or 1
		face = Vector(f.x / len2, f.y / len2, 0)
		landFlat = origin:__add(face:__mul(CAST_RANGE))
	end
	local landPos = toGroundPos(nil, landFlat, caster)
	return { origin = origin, landPos = landPos, face = face }
end
function normal_004.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING,
		castPoint = CAST_POINT,
		castDuration = 0.5,
		castRange = CAST_RANGE,
		castAnimation = "",
		canCast = function()
			local ____IsValidAlive_result_3
			if IsValidAlive(nil, self:GetCaster()) then
				____IsValidAlive_result_3 = UF_SUCCESS
			else
				____IsValidAlive_result_3 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_3
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			for ____, u in ipairs(self:FindHeroesInRadius(SEARCH_RANGE)) do
				do
					if not IsValidAlive(nil, u) then
						goto __continue16
					end
					caster:LockTargetForSpeed(u, CAST_POINT)
					break
				end
				::__continue16::
			end
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local ____temp_4 = self:computeJump(caster)
			local origin = ____temp_4.origin
			local landPos = ____temp_4.landPos
			local face = ____temp_4.face
			local peak = origin:__add(Vector(0, 0, JUMP_HEIGHT))
			caster:SetForwardVector(face)
			EmitSoundOn(THROW_SOUND, caster)
			local blur = ParticleManager:CreateParticle(BLUR_FX, PATTACH_ABSORIGIN_FOLLOW, caster)
			ParticleManager:SetParticleControlEnt(
				blur,
				0,
				caster,
				PATTACH_ABSORIGIN_FOLLOW,
				"attach_hitloc",
				Vector(0, 0, 0),
				true
			)
			caster:Bezier2Mover({ origin, peak, landPos }, JUMP_DURATION, nil, true, true)
			self:Timer(JUMP_DURATION, function()
				ParticleManager:DestroyParticle(blur, false)
				ParticleManager:ReleaseParticleIndex(blur)
				if not IsValidAlive(nil, caster) then
					return
				end
				local pos = toGroundPos(nil, caster:GetAbsOrigin(), caster)
				EmitSoundOnLocationWithCaster(pos, LAND_SOUND, caster)
				for ____, v in ipairs(self:FindHeroesInRadius(LAND_DAMAGE_RADIUS, pos)) do
					do
						if not IsValidAlive(nil, v) then
							goto __continue23
						end
						caster:MonsterDamage({ victim = v, damage_rate = LAND_DAMAGE_RATE, ability = self })
					end
					::__continue23::
				end
			end)
		end,
	}
end
normal_004 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_004)
____exports.normal_004 = normal_004
return ____exports