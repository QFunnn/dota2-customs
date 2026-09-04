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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
--- 残影移速（单位/秒）
local COMMON_002_MOVE_SPEED = 400
--- 无接触时最长移动时间（秒），超时则进入延迟再爆炸
local COMMON_002_MAX_MOVE_TIME = 3
--- 触发引爆条件后，延迟（秒）再结算伤害并移除 thinker
local COMMON_002_FUSE_DELAY = 0.7
--- 触碰检测半径
local COMMON_002_TOUCH_RADIUS = 50
--- 爆炸伤害范围半径
local COMMON_002_EXPLOSION_RADIUS = 300
--- 伤害倍率（与 MonsterDamage.damage_rate 语义一致）
local COMMON_002_DAMAGE_RATE = 15
--- 索敌 / 移动时朝向目标范围
local COMMON_002_SEARCH_RANGE = 2500
--- thinker 上 modifier 持续时间（需大于「最长移动 + 延迟」）
local COMMON_002_THINKER_MODIFIER_DURATION = 30
--- 位移轨迹粒子 CP0 相对地面原点抬高的 Z（码）
local COMMON_002_TRAIL_CP0_Z_OFFSET = 125
local PARTICLE_MOVE_TRAIL = "particles/monster/axe_cinder_battle_hunger.vpcf"
local PARTICLE_EXPLOSION = "particles/econ/items/huskar/huskar_2022_immortal/huskar_2022_immortal_life_break.vpcf"
--- !!无效技能,保存代码
-- 怪物通用技能2 - 遗言：拥有者死亡时生成 thinker ，以恒定速度追最近敌人；
-- 位移时播放轨迹粒子（CP0 为原点 Z+125），引爆时播放 huskar life_break（CP0/1 均为爆炸原点）。
____exports.common_002 = __TS__Class()
local common_002 = ____exports.common_002
common_002.name = "common_002"
__TS__ClassExtends(common_002, MonsterAbility_CS)
function common_002.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE_MOVE_TRAIL, context)
	PrecacheResource("particle", PARTICLE_EXPLOSION, context)
end
function common_002.prototype.GetMosnterAbilityConfig(self)
	return { castPoint = 0, castDuration = 0, behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
common_002 = __TS__DecorateLegacy({ registerAbility(nil) }, common_002)
____exports.common_002 = common_002
local modifier_common_002_thinker = __TS__Class()
modifier_common_002_thinker.name = "modifier_common_002_thinker"
__TS__ClassExtends(modifier_common_002_thinker, MonsterModifier_CS)
function modifier_common_002_thinker.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.attackSnapshot = 0
	self.damageRate = COMMON_002_DAMAGE_RATE
	self.fallbackDir = Vector(1, 0, 0)
	self.exploded = false
	self.moving = true
	self.fuseScheduled = false
	self.moveElapsed = 0
end
function modifier_common_002_thinker.prototype.IsHidden(self)
	return true
end
function modifier_common_002_thinker.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	local thinker = self:GetParent()
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	self.attackSnapshot = kv and kv.attack_snapshot or 0
	self.damageRate = kv and kv.damage_rate or COMMON_002_DAMAGE_RATE
	self.roomId = kv and kv.room_id
	local fx = kv and kv.forward_x or 1
	local fy = kv and kv.forward_y or 0
	local len = math.sqrt(fx * fx + fy * fy) or 1
	self.fallbackDir = Vector(fx / len, fy / len, 0)
	if self.roomId ~= nil then
		thinker.__room_id__ = self.roomId
	end
	self:createMoveTrailParticle(thinker)
	self:StartIntervalThink(0.03)
end
function modifier_common_002_thinker.prototype.trailCp0FromOrigin(self, origin)
	return Vector(origin.x, origin.y, origin.z + COMMON_002_TRAIL_CP0_Z_OFFSET)
end
function modifier_common_002_thinker.prototype.createMoveTrailParticle(self, thinker)
	if not IsServer() or self.pfxMoveTrail ~= nil then
		return
	end
	self.pfxMoveTrail = ParticleManager:CreateParticle(PARTICLE_MOVE_TRAIL, PATTACH_CUSTOMORIGIN, thinker)
	ParticleManager:SetParticleShouldCheckFoW(self.pfxMoveTrail, false)
	ParticleManager:SetParticleControl(self.pfxMoveTrail, 0, self:trailCp0FromOrigin(thinker:GetAbsOrigin()))
end
function modifier_common_002_thinker.prototype.updateMoveTrailParticle(self, origin)
	if self.pfxMoveTrail == nil then
		return
	end
	ParticleManager:SetParticleControl(self.pfxMoveTrail, 0, self:trailCp0FromOrigin(origin))
end
function modifier_common_002_thinker.prototype.destroyMoveTrailParticle(self)
	if self.pfxMoveTrail == nil then
		return
	end
	ParticleManager:DestroyParticle(self.pfxMoveTrail, false)
	ParticleManager:ReleaseParticleIndex(self.pfxMoveTrail)
	self.pfxMoveTrail = nil
end
function modifier_common_002_thinker.prototype.playExplosionParticle(self, center)
	if not IsServer() then
		return
	end
	local pid = ParticleManager:CreateParticle(PARTICLE_EXPLOSION, PATTACH_ABSORIGIN_FOLLOW, self._parent)
	ParticleManager:SetParticleShouldCheckFoW(pid, false)
	ParticleManager:SetParticleControl(pid, 0, center)
	ParticleManager:SetParticleControl(pid, 1, center)
	local pidKeep = pid
	Timers:CreateTimer(5, function()
		ParticleManager:DestroyParticle(pidKeep, false)
		ParticleManager:ReleaseParticleIndex(pidKeep)
	end)
end
function modifier_common_002_thinker.prototype.getChaseDir(self, thinker, origin)
	if not IsValidAlive(nil, thinker) then
		return self.fallbackDir
	end
	local target = thinker:GetMinDistanceUnit(COMMON_002_SEARCH_RANGE, origin)
	local dir = self.fallbackDir
	if target and IsValidAlive(nil, target) then
		local to = target:GetAbsOrigin() - origin
		local len = math.sqrt(to.x * to.x + to.y * to.y) or 1
		dir = Vector(to.x / len, to.y / len, 0)
	end
	return dir
end
function modifier_common_002_thinker.prototype.GetDamageAttacker(self, thinker)
	local ____self_roomId_12 = self.roomId
	if ____self_roomId_12 == nil then
		local ____this_11
		____this_11 = thinker
		local ____opt_10 = ____this_11.GetRoomId
		____self_roomId_12 = ____opt_10 and ____opt_10(____this_11)
	end
	local roomId = ____self_roomId_12
	if roomId == nil or roomId == nil then
		return thinker
	end
	local room = MyGameRoomManager:GetRoom(tostring(roomId))
	return room and room:GetRoomDummy() or thinker
end
function modifier_common_002_thinker.prototype.scheduleFuse(self)
	if self.exploded or self.fuseScheduled then
		return
	end
	local thinker = self:GetParent()
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	self.fuseScheduled = true
	self.moving = false
	self:StartIntervalThink(-1)
	Timers:CreateTimer(COMMON_002_FUSE_DELAY, function()
		SafelyCall(nil, function()
			if self.exploded or self:IsRemoved() then
				return
			end
			self:Destroy()
		end)
	end)
end
function modifier_common_002_thinker.prototype.OnIntervalThink(self)
	if not IsServer() or not self.moving or self.exploded then
		return
	end
	local thinker = self:GetParent()
	if not IsValidAlive(nil, thinker) then
		return
	end
	if not IsValid(nil, thinker) or thinker:IsNull() then
		self:Destroy()
		return
	end
	self.moveElapsed = self.moveElapsed + 0.03
	local origin = thinker:GetAbsOrigin()
	local team = thinker:GetTeamNumber()
	local touchUnits = FindUnitsInRadius(
		team,
		origin,
		nil,
		COMMON_002_TOUCH_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, u in ipairs(touchUnits) do
		if IsValidAlive(nil, u) then
			self:scheduleFuse()
			return
		end
	end
	if self.moveElapsed >= COMMON_002_MAX_MOVE_TIME then
		self:scheduleFuse()
		return
	end
	local dir = self:getChaseDir(thinker, origin)
	local move = dir * (COMMON_002_MOVE_SPEED * 0.03)
	local newPos = origin + move
	local gz = GetGroundHeight(newPos, thinker)
	local ____temp_15
	if gz ~= nil then
		____temp_15 = gz
	else
		____temp_15 = newPos.z
	end
	newPos.z = ____temp_15
	thinker:SetForwardVector(dir)
	thinker:SetAbsOrigin(newPos)
	self:updateMoveTrailParticle(newPos)
end
function modifier_common_002_thinker.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:destroyMoveTrailParticle()
	local thinker = self:GetParent()
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	local center = thinker:GetAbsOrigin()
	EmitSoundOnLocationWithCaster(center, "Hero_Huskar.Life_Break.Impact", thinker)
	self:playExplosionParticle(center)
	local team = thinker:GetTeamNumber()
	local enemies = FindUnitsInRadius(
		team,
		center,
		nil,
		COMMON_002_EXPLOSION_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, victim in ipairs(enemies) do
		do
			if not IsValidAlive(nil, victim) then
				goto __continue41
			end
			ApplyMonsterDamage(
				nil,
				self:GetDamageAttacker(thinker),
				{
					victim = victim,
					damage_rate = self.damageRate,
					attack_damage_override = self.attackSnapshot,
					damage_type = 2,
				}
			)
		end
		::__continue41::
	end
	thinker:SelfRemoveSelf()
end
function modifier_common_002_thinker.prototype.IsPurgable(self)
	return false
end
modifier_common_002_thinker =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_common_002_thinker") }, modifier_common_002_thinker)
return ____exports