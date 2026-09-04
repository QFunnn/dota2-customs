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
local __TS__ArrayFindIndex = ____lualib.__TS__ArrayFindIndex
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_tiny_ab2_multi_wave
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
--- 预警特效（持续 3 秒）
local WARNING_PARTICLE = "particles/boss/tiny/furion_teleport_end_team_sufferwood_model.vpcf"
--- 延迟后播放的两种爆炸特效
local EXPLOSION_PARTICLE_TREE = "particles/world_destruction_fx/dire_tree001.vpcf"
local EXPLOSION_PARTICLE_MINE = "particles/techies_remote_mines_detonate_base.vpcf"
--- 投射物特效：cp0 原点、cp1 终点，固定 2 秒到达
local PROJECTILE_PARTICLE = "particles/hoodwink_acorn_shot_tracking.vpcf"
local DESTROY_PARTICLE = "particles/techies_remote_mines_detonate_base_del.vpcf"
local RANDOM_POINTS_MIN_DIST = 250
--- 三波抛掷：每一波的落点数量（可在这里配置）
local WAVE_PROJECTILE_COUNTS = { 5, 6, 7, 8 }
--- 手动播放特效的飞行时间，到达目标点后触发落地逻辑
local TRAVEL_TIME = 1.2
local DELAY_SECONDS = 1
local DAMAGE_RADIUS = 260
local DAMAGE_RATE = 18
--- 种下的树木特效持续时间，到期后移除并从 __tree_pos__ 中删除
local TREE_EFFECT_DURATION = 18
--- 落地爆炸矿粒子保留时长（秒）
local EXPLOSION_MINE_PFX_LIFETIME = 2.5
--- 小小身上存储的「已种下的树」列表，供其他技能（如拔树）通过 caster['__tree_pos__'] 搜索。每项为 { pos, pfx, endTime }，30 秒后自动移除。
____exports.TREE_POS_KEY = "__tree_pos__"
local TREE_UNIT_NAME = "tiny_boss_tree"
--- 小小 Boss 技能2 - 指定位置预警，3 秒后范围伤害
____exports.tiny_ab2 = __TS__Class()
local tiny_ab2 = ____exports.tiny_ab2
tiny_ab2.name = "tiny_ab2"
__TS__ClassExtends(tiny_ab2, MonsterAbility_CS)
function tiny_ab2.prototype.Precache(self, context)
	PrecacheResource("particle", WARNING_PARTICLE, context)
	PrecacheResource("particle", EXPLOSION_PARTICLE_TREE, context)
	PrecacheResource("particle", EXPLOSION_PARTICLE_MINE, context)
	PrecacheResource("particle", PROJECTILE_PARTICLE, context)
	PrecacheResource("particle", DESTROY_PARTICLE, context)
end
function tiny_ab2.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 1.3,
		castDuration = 3.7,
		animationPlaybackRate = 1,
		castAnimation = ACT_TINY_TOSS,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:Timer(0.65, function()
				caster:StartGestureWithPlaybackRate(ACT_TINY_TOSS, 1)
			end)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			modifier_tiny_ab2_multi_wave:applys(caster, caster, self, { duration = 3.5 })
		end,
	}
end
function tiny_ab2.prototype.GetCastRange(self, _location, _target)
	return 1800
end
function tiny_ab2.prototype.LaunchWaveProjectiles(self, waveIndex)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local count = WAVE_PROJECTILE_COUNTS[waveIndex + 1] or WAVE_PROJECTILE_COUNTS[#WAVE_PROJECTILE_COUNTS]
	local target = self:GetMinDistanceUnit(2000)
	local ____IsValidAlive_result_0
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_0 = target:GetAbsOrigin()
	else
		____IsValidAlive_result_0 = caster:GetAbsOrigin()
	end
	local center = ____IsValidAlive_result_0
	local randomPositions = GetRandomPointsInCircle(nil, center, 800, count, RANDOM_POINTS_MIN_DIST)
	local startPoint = caster:GetAbsOrigin():__add(Vector(0, 0, 200))
	for ____, point in ipairs(randomPositions) do
		local groundZ = GetGroundHeight(point, caster) or point.z
		local targetPoint = Vector(point.x, point.y, groundZ)
		local pfx = ParticleManager:CreateParticle(PROJECTILE_PARTICLE, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(pfx, 0, startPoint)
		ParticleManager:SetParticleControl(pfx, 1, targetPoint)
		local randomTravelTime = math.max(0.1, TRAVEL_TIME + math.random(-10, 10) / 100)
		caster:EmitSound("Hero_Tiny.Toss.Target")
		Timers:CreateTimer(randomTravelTime, function()
			ParticleManager:DestroyParticle(pfx, false)
			ParticleManager:ReleaseParticleIndex(pfx)
			if not IsValid(nil, self) or self:IsNull() then
				return nil
			end
			if not IsValidAlive(nil, caster) then
				return
			end
			self:ExecuteDelayedTreeStomp(targetPoint)
			return nil
		end)
	end
end
function tiny_ab2.prototype.ExecuteDelayedTreeStomp(self, center)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local groundZ = GetGroundHeight(center, caster)
	local ____center_x_2 = center.x
	local ____center_y_3 = center.y
	local ____temp_1
	if groundZ ~= nil then
		____temp_1 = groundZ
	else
		____temp_1 = center.z
	end
	local pos = Vector(____center_x_2, ____center_y_3, ____temp_1)
	local warningPfx = ParticleManager:CreateParticle(WARNING_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(warningPfx, 0, pos)
	ParticleManager:SetParticleControl(warningPfx, 1, pos)
	WarningRing(nil, caster, pos, DAMAGE_RADIUS, DELAY_SECONDS)
	EmitSoundOnLocationWithCaster(pos, "Ability.TossImpact", caster)
	Timers:CreateTimer(DELAY_SECONDS, function()
		local function endWarning()
			ParticleManager:DestroyParticle(warningPfx, false)
			ParticleManager:ReleaseParticleIndex(warningPfx)
		end
		if not IsValid(nil, self) or self:IsNull() then
			endWarning(nil)
			return nil
		end
		if not IsValidAlive(nil, caster) then
			endWarning(nil)
			return nil
		end
		endWarning(nil)
		ScreenShake(caster:GetAbsOrigin(), 10, 10, 0.1, 2000, 0, true)
		local pfxMine = ParticleManager:CreateParticle(EXPLOSION_PARTICLE_MINE, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(pfxMine, 0, pos)
		ParticleManager:SetParticleControl(pfxMine, 1, Vector(DAMAGE_RADIUS, 0, 0))
		Timers:CreateTimer(EXPLOSION_MINE_PFX_LIFETIME, function()
			ParticleManager:DestroyParticle(pfxMine, false)
			ParticleManager:ReleaseParticleIndex(pfxMine)
			return nil
		end)
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			pos,
			nil,
			DAMAGE_RADIUS,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for ____, enemy in ipairs(enemies) do
			if IsValidAlive(nil, enemy) then
				caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			end
		end
		EmitSoundOnLocationWithCaster(pos, "Hero_Pangolier.Gyroshell.Stun", caster)
		local pfxTree = ParticleManager:CreateParticle(EXPLOSION_PARTICLE_TREE, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(pfxTree, 0, pos)
		Timers:CreateTimer(0.5, function()
			ParticleManager:DestroyParticle(pfxTree, false)
			ParticleManager:ReleaseParticleIndex(pfxTree)
		end)
		return nil
	end)
end
function tiny_ab2.prototype.CleanupTreeEntry(self, caster, entry)
	if entry.removed then
		return
	end
	entry.removed = true
	local pos = entry.pos
	local pfxDestroy = ParticleManager:CreateParticle(DESTROY_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfxDestroy, 0, pos)
	ParticleManager:SetParticleControl(pfxDestroy, 1, Vector(DAMAGE_RADIUS, 0, 0))
	Timers:CreateTimer(1, function()
		ParticleManager:DestroyParticle(pfxDestroy, false)
		ParticleManager:ReleaseParticleIndex(pfxDestroy)
		return nil
	end)
	ParticleManager:DestroyParticle(entry.pfx, false)
	ParticleManager:ReleaseParticleIndex(entry.pfx)
	if caster and IsValid(nil, caster) and not caster:IsNull() and caster[____exports.TREE_POS_KEY] then
		local arr = caster[____exports.TREE_POS_KEY]
		local idx = __TS__ArrayFindIndex(arr, function(____, e)
			return e == entry or e.pfx == entry.pfx
		end)
		if idx >= 0 then
			__TS__ArraySplice(arr, idx, 1)
		end
	end
end
tiny_ab2 = __TS__DecorateLegacy({ registerAbility(nil) }, tiny_ab2)
____exports.tiny_ab2 = tiny_ab2
--- 三波 TINY_TOSS（1 倍速）：每波墙钟 0.6s，其中 0.15s 时抛射；总 1.8s 须与技能 castDuration 一致
modifier_tiny_ab2_multi_wave = __TS__Class()
modifier_tiny_ab2_multi_wave.name = "modifier_tiny_ab2_multi_wave"
__TS__ClassExtends(modifier_tiny_ab2_multi_wave, MonsterModifier_CS)
function modifier_tiny_ab2_multi_wave.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self._waveIndex = 0
end
function modifier_tiny_ab2_multi_wave.prototype.IsHidden(self)
	return true
end
function modifier_tiny_ab2_multi_wave.prototype.IsPurgable(self)
	return false
end
function modifier_tiny_ab2_multi_wave.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._waveIndex = 0
	self:StartNextWave()
end
function modifier_tiny_ab2_multi_wave.prototype.StartNextWave(self)
	local ability = self:GetAbility()
	local parent = self:GetParent()
	if not ability or not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	if self._waveIndex >= #WAVE_PROJECTILE_COUNTS then
		self:Destroy()
		return
	end
	local currentWave = self._waveIndex
	parent:StartGestureWithPlaybackRate(ACT_TINY_TOSS, 1)
	self:Timer(0.15, function()
		if not IsValidAlive(nil, parent) or self:IsNull() then
			return nil
		end
		ability:LaunchWaveProjectiles(currentWave)
		return nil
	end)
	self:Timer(0.95, function()
		if IsValidAlive(nil, parent) then
			parent:RemoveGesture(ACT_TINY_TOSS)
		end
		self._waveIndex = self._waveIndex + 1
		if self._waveIndex >= #WAVE_PROJECTILE_COUNTS or self:IsNull() then
			self:Destroy()
		else
			self:StartNextWave()
		end
		return nil
	end)
end
modifier_tiny_ab2_multi_wave =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_tiny_ab2_multi_wave") }, modifier_tiny_ab2_multi_wave)
return ____exports