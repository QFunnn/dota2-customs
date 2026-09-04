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
local COMMON_001_MOVE_SPEED = 400
--- 无接触时最长移动时间（秒），超时则进入延迟再爆炸
local COMMON_001_MAX_MOVE_TIME = 1.8
--- 死亡生成后等待一小段时间，再开始索敌与触碰自爆
local COMMON_001_ACTIVATE_DELAY = 0.6
--- 触发引爆条件后，延迟（秒）再结算伤害并移除 thinker
local COMMON_001_FUSE_DELAY = 0.3
--- 触碰检测半径
local COMMON_001_TOUCH_RADIUS = 120
--- 爆炸伤害范围半径
local COMMON_001_EXPLOSION_RADIUS = 300
--- 伤害倍率（与 MonsterDamage.damage_rate 语义一致）
local COMMON_001_DAMAGE_RATE = 50
--- 死亡后先播放聚能特效，再延迟生成雷魂（秒）
local COMMON_001_SPAWN_DELAY = 0.5
--- 索敌 / 移动时朝向目标范围
local COMMON_001_SEARCH_RANGE = 2500
--- thinker 上 modifier 持续时间（需大于「最长移动 + 延迟」）
local COMMON_001_THINKER_MODIFIER_DURATION = 30
--- 主残影：CP0=原点，随 thinker 移动，modifier 结束时销毁
local PARTICLE_REMNANT = "particles/monster/ability/stormspirit_moving_remnant.vpcf"
--- 与主残影同绑定方式；在「即将引爆」前移除（触碰触发或移动超时触发，进入 COMMON_001_FUSE_DELAY 之前）
local PARTICLE_REMNANT_F1 = "particles/monster/ability/stormspirit_moving_remnantf1.vpcf"
--- 静止准备引爆时使用的残影，替换移动残影避免停下后方向乱转
local PARTICLE_REMNANT_F2 = "particles/monster/ability/stormspirit_moving_remnantf2.vpcf"
--- 最终爆炸：CP0 为爆炸原点
local PARTICLE_REMNANT_B = "particles/monster/ability/stormspirit_moving_remnante.vpcf"
--- 死亡瞬间的雷电吸取/聚能特效，播放结束后再生成雷魂
local PARTICLE_DEATH_ABSORB = "particles/units/heroes/hero_stormspirit/storm_spirit_new_loadout.vpcf"
local REMNANT_SPAWN_SOUND = "Hero_StormSpirit.StaticRemnantPlant"
local REMNANT_EXPLODE_SOUND = "Hero_StormSpirit.StaticRemnantExplode"
--- 怪物通用技能1 - 遗言：拥有者死亡时生成 thinker ，以恒定速度追最近敌人；
____exports.common_001 = __TS__Class()
local common_001 = ____exports.common_001
common_001.name = "common_001"
__TS__ClassExtends(common_001, MonsterAbility_CS)
function common_001.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE_REMNANT, context)
	PrecacheResource("particle", PARTICLE_REMNANT_F1, context)
	PrecacheResource("particle", PARTICLE_REMNANT_F2, context)
	PrecacheResource("particle", PARTICLE_REMNANT_B, context)
	PrecacheResource("particle", PARTICLE_DEATH_ABSORB, context)
end
function common_001.prototype.GetMosnterAbilityConfig(self)
	return { castPoint = 0, castDuration = 0, behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function common_001.prototype.OnOwnerDied(self)
	if not IsServer() then
		return
	end
	local owner = self:GetCaster()
	if not owner or not IsValid(nil, owner) or owner:IsNull() then
		return
	end
	local origin = owner:GetAbsOrigin()
	local groundZ = GetGroundHeight(origin, owner)
	local ____origin_x_1 = origin.x
	local ____origin_y_2 = origin.y
	local ____temp_0
	if groundZ ~= nil then
		____temp_0 = groundZ
	else
		____temp_0 = origin.z
	end
	local spawnPos = Vector(____origin_x_1, ____origin_y_2, ____temp_0)
	local attackSnapshot = 0
	if MyGameAttribute:HasAttributes(owner) then
		attackSnapshot = MyGameAttribute:GetAttribute(owner, "total_attack_damage") or 0
	end
	local fv = owner:GetForwardVector()
	local ____opt_3 = owner.GetRoomId
	local roomId = ____opt_3 and ____opt_3(owner)
	local team = owner:GetTeamNumber()
	local parentModel = owner:GetModelName()
	EmitSoundOnLocationWithCaster(spawnPos, REMNANT_SPAWN_SOUND, owner)
	self:playDeathAbsorbParticle(spawnPos)
	Timers:CreateTimer(COMMON_001_SPAWN_DELAY, function()
		SafelyCall(nil, function()
			CreateModifierThinker(owner, self, "modifier_common_001_thinker", {
				duration = COMMON_001_THINKER_MODIFIER_DURATION,
				attack_snapshot = attackSnapshot,
				damage_rate = COMMON_001_DAMAGE_RATE,
				forward_x = fv.x,
				forward_y = fv.y,
				parent_model = parentModel,
				room_id = roomId,
			}, spawnPos, team, false)
		end)
	end)
end
function common_001.prototype.playDeathAbsorbParticle(self, position)
	if not IsServer() then
		return
	end
	local particle = ParticleManager:CreateParticle(PARTICLE_DEATH_ABSORB, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(particle, false)
	ParticleManager:SetParticleControl(particle, 0, position)
	Timers:CreateTimer(COMMON_001_SPAWN_DELAY, function()
		ParticleManager:DestroyParticle(particle, false)
		ParticleManager:ReleaseParticleIndex(particle)
	end)
end
function common_001.prototype.GetIntrinsicModifierName(self)
	return "modifier_common_001_thinker_buff"
end
common_001 = __TS__DecorateLegacy({ registerAbility(nil) }, common_001)
____exports.common_001 = common_001
local modifier_common_001_thinker = __TS__Class()
modifier_common_001_thinker.name = "modifier_common_001_thinker"
__TS__ClassExtends(modifier_common_001_thinker, MonsterModifier_CS)
function modifier_common_001_thinker.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.attackSnapshot = 0
	self.damageRate = COMMON_001_DAMAGE_RATE
	self.fallbackDir = Vector(1, 0, 0)
	self.exploded = false
	self.moving = true
	self.fuseScheduled = false
	self.moveElapsed = 0
end
function modifier_common_001_thinker.prototype.IsHidden(self)
	return true
end
function modifier_common_001_thinker.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	local thinker = self:GetParent()
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	self.attackSnapshot = kv and kv.attack_snapshot or 0
	self.damageRate = kv and kv.damage_rate or COMMON_001_DAMAGE_RATE
	self.roomId = kv and kv.room_id
	local fx = kv and kv.forward_x or 1
	local fy = kv and kv.forward_y or 0
	local len = math.sqrt(fx * fx + fy * fy) or 1
	self.fallbackDir = Vector(fx / len, fy / len, 0)
	if self.roomId ~= nil then
		thinker.__room_id__ = self.roomId
	end
	self._parent:SetOriginalModel(kv and kv.parent_model or "")
	self._parent:SetModel(kv and kv.parent_model or "")
	self._parent:SetModelScale(0.01)
	self:createRemnantParticle(thinker)
	self:createRemnantF1Particle(thinker)
	Timers:CreateTimer(COMMON_001_ACTIVATE_DELAY, function()
		SafelyCall(nil, function()
			if self.exploded or self:IsRemoved() then
				return
			end
			local parent = self:GetParent()
			if not IsValid(nil, parent) or parent:IsNull() then
				self:Destroy()
				return
			end
			self:StartIntervalThink(0.03)
		end)
	end)
end
function modifier_common_001_thinker.prototype.createRemnantParticle(self, thinker)
	if not IsServer() or self.pfxRemnant ~= nil then
		return
	end
	self.pfxRemnant = ParticleManager:CreateParticle(PARTICLE_REMNANT, PATTACH_CUSTOMORIGIN, thinker)
	ParticleManager:SetParticleShouldCheckFoW(self.pfxRemnant, false)
	ParticleManager:SetParticleControl(self.pfxRemnant, 0, thinker:GetAbsOrigin())
end
function modifier_common_001_thinker.prototype.updateRemnantParticleOrigin(self, origin)
	if self.pfxRemnant == nil then
		return
	end
	ParticleManager:SetParticleControl(self.pfxRemnant, 0, origin)
end
function modifier_common_001_thinker.prototype.destroyRemnantParticle(self)
	if self.pfxRemnant == nil then
		return
	end
	ParticleManager:DestroyParticle(self.pfxRemnant, false)
	ParticleManager:ReleaseParticleIndex(self.pfxRemnant)
	self.pfxRemnant = nil
end
function modifier_common_001_thinker.prototype.createRemnantF1Particle(self, thinker)
	if not IsServer() or self.pfxRemnantF1 ~= nil then
		return
	end
	self.pfxRemnantF1 = ParticleManager:CreateParticle(PARTICLE_REMNANT_F1, PATTACH_CUSTOMORIGIN, thinker)
	ParticleManager:SetParticleShouldCheckFoW(self.pfxRemnantF1, false)
	ParticleManager:SetParticleControl(self.pfxRemnantF1, 0, thinker:GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(
		self.pfxRemnantF1,
		1,
		thinker,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
end
function modifier_common_001_thinker.prototype.updateRemnantF1ParticleOrigin(self, origin)
	if self.pfxRemnantF1 == nil then
		return
	end
	ParticleManager:SetParticleControl(self.pfxRemnantF1, 0, origin)
end
function modifier_common_001_thinker.prototype.destroyRemnantF1Particle(self)
	if self.pfxRemnantF1 == nil then
		return
	end
	ParticleManager:DestroyParticle(self.pfxRemnantF1, false)
	ParticleManager:ReleaseParticleIndex(self.pfxRemnantF1)
	self.pfxRemnantF1 = nil
end
function modifier_common_001_thinker.prototype.createRemnantF2Particle(self, pos, fuseMoveDir)
	if not IsServer() or self.pfxRemnantF2 ~= nil then
		return
	end
	local dirLen = math.sqrt(fuseMoveDir.x * fuseMoveDir.x + fuseMoveDir.y * fuseMoveDir.y) or 1
	local forward = Vector(fuseMoveDir.x / dirLen, fuseMoveDir.y / dirLen, 0)
	self.pfxRemnantF2 = ParticleManager:CreateParticle(PARTICLE_REMNANT_F2, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(self.pfxRemnantF2, false)
	ParticleManager:SetParticleControlTransformForward(self.pfxRemnantF2, 0, pos, forward)
	ParticleManager:SetParticleControlForward(self.pfxRemnantF2, 0, forward)
end
function modifier_common_001_thinker.prototype.destroyRemnantF2Particle(self)
	if self.pfxRemnantF2 == nil then
		return
	end
	ParticleManager:DestroyParticle(self.pfxRemnantF2, false)
	ParticleManager:ReleaseParticleIndex(self.pfxRemnantF2)
	self.pfxRemnantF2 = nil
end
function modifier_common_001_thinker.prototype.playExplosionParticle(self, center)
	if not IsServer() then
		return
	end
	local pid = ParticleManager:CreateParticle(PARTICLE_REMNANT_B, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pid, false)
	ParticleManager:SetParticleControl(pid, 0, center)
	Timers:CreateTimer(5, function()
		ParticleManager:DestroyParticle(pid, false)
		ParticleManager:ReleaseParticleIndex(pid)
	end)
end
function modifier_common_001_thinker.prototype.getChaseDir(self, thinker, origin)
	if not IsValidAlive(nil, thinker) then
		return self.fallbackDir
	end
	local target = thinker:GetMinDistanceUnit(COMMON_001_SEARCH_RANGE, origin)
	local dir = self.fallbackDir
	if target and IsValidAlive(nil, target) then
		local to = target:GetAbsOrigin() - origin
		local len = math.sqrt(to.x * to.x + to.y * to.y) or 1
		dir = Vector(to.x / len, to.y / len, 0)
	end
	return dir
end
function modifier_common_001_thinker.prototype.GetDamageAttacker(self, thinker)
	local ____self_roomId_21 = self.roomId
	if ____self_roomId_21 == nil then
		local ____this_20
		____this_20 = thinker
		local ____opt_19 = ____this_20.GetRoomId
		____self_roomId_21 = ____opt_19 and ____opt_19(____this_20)
	end
	local roomId = ____self_roomId_21
	if roomId == nil or roomId == nil then
		return thinker
	end
	local room = MyGameRoomManager:GetRoom(tostring(roomId))
	return room and room:GetRoomDummy() or thinker
end
function modifier_common_001_thinker.prototype.scheduleFuse(self, fuseMoveDir)
	if self.exploded or self.fuseScheduled then
		return
	end
	local thinker = self:GetParent()
	if not IsValidAlive(nil, thinker) then
		return
	end
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	self:destroyRemnantF1Particle()
	self:destroyRemnantParticle()
	self:createRemnantF2Particle(thinker:GetAbsOrigin(), fuseMoveDir)
	self.fuseScheduled = true
	self.moving = false
	self:StartIntervalThink(-1)
	Timers:CreateTimer(COMMON_001_FUSE_DELAY, function()
		SafelyCall(nil, function()
			if self.exploded or self:IsRemoved() then
				return
			end
			self:Destroy()
		end)
	end)
end
function modifier_common_001_thinker.prototype.OnIntervalThink(self)
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
		COMMON_001_TOUCH_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, u in ipairs(touchUnits) do
		if IsValidAlive(nil, u) then
			self:scheduleFuse(self:getChaseDir(thinker, origin))
			return
		end
	end
	if self.moveElapsed >= COMMON_001_MAX_MOVE_TIME then
		self:scheduleFuse(self:getChaseDir(thinker, origin))
		return
	end
	local dir = self:getChaseDir(thinker, origin)
	local move = dir * (COMMON_001_MOVE_SPEED * 0.03)
	local newPos = origin + move
	local gz = GetGroundHeight(newPos, thinker)
	local ____temp_24
	if gz ~= nil then
		____temp_24 = gz
	else
		____temp_24 = newPos.z
	end
	newPos.z = ____temp_24
	thinker:SetForwardVector(dir)
	thinker:SetAbsOrigin(newPos)
	self:updateRemnantParticleOrigin(newPos)
	self:updateRemnantF1ParticleOrigin(newPos)
end
function modifier_common_001_thinker.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:destroyRemnantF1Particle()
	self:destroyRemnantF2Particle()
	self:destroyRemnantParticle()
	local thinker = self:GetParent()
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	local center = thinker:GetAbsOrigin()
	EmitSoundOnLocationWithCaster(center, REMNANT_EXPLODE_SOUND, thinker)
	self:playExplosionParticle(center)
	local team = thinker:GetTeamNumber()
	local enemies = FindUnitsInRadius(
		team,
		center,
		nil,
		COMMON_001_EXPLOSION_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	ScreenShake(center, 10, 10, 0.1, 2000, 0, true)
	for ____, victim in ipairs(enemies) do
		do
			if not IsValidAlive(nil, victim) then
				goto __continue65
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
			victim:AddNewModifier(thinker, self:GetAbility(), "modifier_slow", { duration = 3, slow_pct = 0.5 })
		end
		::__continue65::
	end
	thinker:SelfRemoveSelf()
end
function modifier_common_001_thinker.prototype.IsPurgable(self)
	return false
end
modifier_common_001_thinker =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_common_001_thinker") }, modifier_common_001_thinker)
local modifier_common_001_thinker_buff = __TS__Class()
modifier_common_001_thinker_buff.name = "modifier_common_001_thinker_buff"
__TS__ClassExtends(modifier_common_001_thinker_buff, MonsterModifier_CS)
function modifier_common_001_thinker_buff.prototype.IsHidden(self)
	return true
end
function modifier_common_001_thinker_buff.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_dark_willow/dark_willow_wisp_spell_fear_debuff.vpcf"
end
modifier_common_001_thinker_buff = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_common_001_thinker_buff") },
	modifier_common_001_thinker_buff
)
return ____exports