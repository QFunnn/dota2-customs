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
--- 爆炸伤害范围半径
local COMMON_003_EXPLOSION_RADIUS = 250
--- 伤害倍率（与 MonsterDamage.damage_rate 语义一致，与 common_001/002 默认一致）
local COMMON_003_DAMAGE_RATE = 15
local PARTICLE_EXPLOSION = "particles/units/heroes/hero_ember_spirit/ember_spirit_hit.vpcf"
local function Common003GetDamageAttacker(self, owner)
	local ____this_1
	____this_1 = owner
	local ____opt_0 = ____this_1.GetRoomId
	local roomId = ____opt_0 and ____opt_0(____this_1)
	if roomId == nil or roomId == nil then
		return owner
	end
	local room = MyGameRoomManager:GetRoom(tostring(roomId))
	return room and room:GetRoomDummy() or owner
end
--- 怪物通用技能3 - 遗言：拥有者死亡时于死亡位置立即爆炸；
-- 特效 `ember_spirit_hit` 的 CP0 为地面原点，范围 250 内对敌方英雄造成伤害。
____exports.common_003 = __TS__Class()
local common_003 = ____exports.common_003
common_003.name = "common_003"
__TS__ClassExtends(common_003, MonsterAbility_CS)
function common_003.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE_EXPLOSION, context)
end
function common_003.prototype.GetMosnterAbilityConfig(self)
	return { castPoint = 0, castDuration = 0, behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function common_003.prototype.OnOwnerDied(self)
	if not IsServer() then
		return
	end
	local owner = self:GetCaster()
	if not owner or not IsValid(nil, owner) or owner:IsNull() then
		return
	end
	local origin = owner:GetAbsOrigin()
	local groundZ = GetGroundHeight(origin, owner)
	local ____origin_x_5 = origin.x
	local ____origin_y_6 = origin.y
	local ____temp_4
	if groundZ ~= nil then
		____temp_4 = groundZ
	else
		____temp_4 = origin.z
	end
	local center = Vector(____origin_x_5, ____origin_y_6, ____temp_4)
	local attackSnapshot = 0
	if MyGameAttribute:HasAttributes(owner) then
		attackSnapshot = MyGameAttribute:GetAttribute(owner, "total_attack_damage") or 0
	end
	local attackSource = Common003GetDamageAttacker(nil, owner)
	local pid = ParticleManager:CreateParticle(PARTICLE_EXPLOSION, PATTACH_CUSTOMORIGIN, attackSource)
	ParticleManager:SetParticleShouldCheckFoW(pid, false)
	ParticleManager:SetParticleControl(pid, 0, center)
	local pidKeep = pid
	Timers:CreateTimer(5, function()
		ParticleManager:DestroyParticle(pidKeep, false)
		ParticleManager:ReleaseParticleIndex(pidKeep)
	end)
	local team = owner:GetTeamNumber()
	local enemies = FindUnitsInRadius(
		team,
		center,
		nil,
		COMMON_003_EXPLOSION_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, victim in ipairs(enemies) do
		do
			if not IsValidAlive(nil, victim) then
				goto __continue11
			end
			ApplyMonsterDamage(nil, attackSource, {
				victim = victim,
				damage_rate = COMMON_003_DAMAGE_RATE,
				attack_damage_override = attackSnapshot,
				damage_type = 2,
				ability = self,
			})
		end
		::__continue11::
	end
end
common_003 = __TS__DecorateLegacy({ registerAbility(nil) }, common_003)
____exports.common_003 = common_003
return ____exports