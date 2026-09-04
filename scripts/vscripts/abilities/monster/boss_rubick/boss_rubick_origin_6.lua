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
local SwitchRubickBossAbilitySlot, KeepRubickBossSwitchAbilityReady, EnsureRubickBossAbility, EnsureRubickBossAbilityReady, RUBICK_ORIGIN_6_SWITCH_ABILITY, RUBICK_ORIGIN_6_STYLE_SLOT_COUNT
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____base_rubick_origin_ability = require("abilities.monster.boss_rubick.base_rubick_origin_ability")
local RubickOriginAbility = ____base_rubick_origin_ability.RubickOriginAbility
function SwitchRubickBossAbilitySlot(self, caster, slotIndex, targetName)
	local currentAbility = caster:GetAbilityByIndex(slotIndex)
	local currentName = currentAbility and currentAbility:GetAbilityName()
	if currentName == targetName then
		EnsureRubickBossAbilityReady(nil, currentAbility)
		return
	end
	local targetAbility = EnsureRubickBossAbility(nil, caster, targetName)
	if not targetAbility then
		return
	end
	if currentName then
		caster:SwapAbilities(currentName, targetName, false, true)
		return
	end
	EnsureRubickBossAbilityReady(nil, targetAbility)
end
function KeepRubickBossSwitchAbilityReady(self, caster)
	local switchAbility = EnsureRubickBossAbility(nil, caster, RUBICK_ORIGIN_6_SWITCH_ABILITY)
	if not switchAbility then
		return
	end
	EnsureRubickBossAbilityReady(nil, switchAbility)
	local slotAbility = caster:GetAbilityByIndex(RUBICK_ORIGIN_6_STYLE_SLOT_COUNT)
	local slotName = slotAbility and slotAbility:GetAbilityName()
	if slotName and slotName ~= RUBICK_ORIGIN_6_SWITCH_ABILITY then
		caster:SwapAbilities(slotName, RUBICK_ORIGIN_6_SWITCH_ABILITY, false, true)
	end
end
function EnsureRubickBossAbility(self, caster, abilityName)
	local ability = caster:FindAbilityByName(abilityName)
	if not ability then
		ability = caster:AddAbility(abilityName)
	end
	EnsureRubickBossAbilityReady(nil, ability)
	return ability
end
function EnsureRubickBossAbilityReady(self, ability)
	if not ability then
		return
	end
	if ability:GetLevel() <= 0 then
		ability:SetLevel(1)
	end
end
--- 技能最大索敌距离。
local RUBICK_ORIGIN_6_CAST_RANGE = 3000
--- 环境切换前的定身演出时间。
local RUBICK_ORIGIN_6_CAST_POINT = 1.2
--- 玩家被眩晕的持续时间，覆盖天气和地板翻转的主演出窗口。
local RUBICK_ORIGIN_6_STUN_DURATION = 2.8
--- Boss 自身切换环境的动作。
local RUBICK_ORIGIN_6_CAST_ANIMATION = "rubick_spell_steal"
--- Boss 自身奥术聚能特效。
local RUBICK_ORIGIN_6_SELF_PARTICLE = "particles/units/heroes/hero_rubick/rubick_spell_steal.vpcf"
--- 中心收缩范围预警特效。
local RUBICK_ORIGIN_6_COLLAPSE_PARTICLE =
	"particles/rebuild/spell/rubick_boss/hd_rubick_boss_sand_passive/main_effect/effect.vpcf"
--- 框外方块碎裂特效。
local RUBICK_ORIGIN_6_BREAK_PARTICLE = "particles/tower_bad_destroy3.vpcf"
--- 坠入虚空时玩家身上的操控特效。
local RUBICK_ORIGIN_6_VOID_FALL_PARTICLE = "particles/status_fx/status_effect_void_spirit_astral_step_debuff.vpcf"
--- 中央拉比克投影模型。
local RUBICK_ORIGIN_6_PROJECTION_MODEL = "models/heroes/rubick/rubick.vmdl"
--- 中央木偶操控模型。
local RUBICK_ORIGIN_6_PUPPET_MODEL = "models/items/rubick/puppet_master_doll/puppet_master_doll.vmdl"
--- Boss 自身特效保留时间。
local RUBICK_ORIGIN_6_SELF_PARTICLE_DURATION = 2.4
--- 每次切换后保留的中心正方形边长，按阶段逐步收缩。
local RUBICK_ORIGIN_6_COLLAPSE_TARGET_SIZES = { 14, 12, 10 }
--- 中心收缩时补位方块飞行时间。
local RUBICK_ORIGIN_6_COLLAPSE_DURATION = 0.75
--- 中心收缩时补位方块抛物线高度。
local RUBICK_ORIGIN_6_COLLAPSE_ARC_HEIGHT = 420
--- 中心收缩时补位方块依次起飞间隔。
local RUBICK_ORIGIN_6_COLLAPSE_STAGGER_DELAY = 0.035
--- 范围特效 CP1 固定值。
local RUBICK_ORIGIN_6_COLLAPSE_CP1_VALUE = 500
--- 范围特效保留时间。
local RUBICK_ORIGIN_6_COLLAPSE_PARTICLE_DURATION = 1.6
--- 框外方块碎裂特效保留时间。
local RUBICK_ORIGIN_6_BREAK_PARTICLE_DURATION = 1.8
--- 框外方块开始碎裂后，到虚空坠落判定的延迟。
local RUBICK_ORIGIN_6_PUNISH_AFTER_BREAK_DELAY = 0.08
--- 虚空坠落判定后，到环境翻转请求的延迟。
local RUBICK_ORIGIN_6_PHASE_APPLY_AFTER_PUNISH_DELAY = 0.35
--- 虚空坠落惩罚持续时间。
local RUBICK_ORIGIN_6_VOID_FALL_DURATION = 1.4
--- 虚空坠落惩罚下沉距离。
local RUBICK_ORIGIN_6_VOID_FALL_DISTANCE = 220
--- 虚空坠落惩罚伤害系数。
local RUBICK_ORIGIN_6_VOID_FALL_DAMAGE_RATE = 15
--- 中央操控投影保留时间。
local RUBICK_ORIGIN_6_PUPPET_SHOW_DURATION = 1.45
--- 木偶模型相对拉比克投影头顶高度。
local RUBICK_ORIGIN_6_PUPPET_OVERHEAD_Z = 280
RUBICK_ORIGIN_6_SWITCH_ABILITY = "boss_rubick_origin_6"
RUBICK_ORIGIN_6_STYLE_SLOT_COUNT = 5
--- 各环境阶段对应的 1-5 号技能组，第 6 技能始终保留原始切换。
local RUBICK_ORIGIN_6_STYLE_ABILITIES = {
	origin = {
		"boss_rubick_origin_1",
		"boss_rubick_origin_2",
		"boss_rubick_origin_3",
		"boss_rubick_origin_4",
		"boss_rubick_origin_5",
	},
	snow = {
		"boss_rubick_frost_1",
		"boss_rubick_frost_2",
		"boss_rubick_frost_3",
		"boss_rubick_frost_4",
		"boss_rubick_frost_5",
	},
	sand = {
		"boss_rubick_sand_1",
		"boss_rubick_sand_2",
		"boss_rubick_sand_3",
		"boss_rubick_sand_4",
		"boss_rubick_sand_5",
	},
	ash = {
		"boss_rubick_ash_1",
		"boss_rubick_ash_2",
		"boss_rubick_ash_3",
		"boss_rubick_ash_4",
		"boss_rubick_ash_5",
	},
}
--- 按当前环境阶段同步拉比克 1-5 号技能，第 6 技能固定保留切换。
function ____exports.SyncRubickBossStyleAbilities(self, caster, phaseId)
	if not phaseId or not IsValidAlive(nil, caster) then
		return
	end
	local targetAbilities = RUBICK_ORIGIN_6_STYLE_ABILITIES[phaseId]
	if not targetAbilities then
		return
	end
	do
		local index = 0
		while index < RUBICK_ORIGIN_6_STYLE_SLOT_COUNT do
			local targetName = targetAbilities[index + 1]
			if targetName then
				SwitchRubickBossAbilitySlot(nil, caster, index, targetName)
			end
			index = index + 1
		end
	end
	KeepRubickBossSwitchAbilityReady(nil, caster)
end
--- 拉比克原始技能六：切换状态。
--
-- 技能形态：
-- 1. 点击后锁定当前动态地板和同房间玩家。
-- 2. 前摇开始时眩晕所有房间玩家，Boss 自身播放切换演出。
-- 3. 前摇结束后调用拉比克环境状态机，复用方块测试中的天气、灯光、地板翻转切换效果。
____exports.boss_rubick_origin_6 = __TS__Class()
local boss_rubick_origin_6 = ____exports.boss_rubick_origin_6
boss_rubick_origin_6.name = "boss_rubick_origin_6"
__TS__ClassExtends(boss_rubick_origin_6, RubickOriginAbility)
function boss_rubick_origin_6.prototype.____constructor(self, ...)
	RubickOriginAbility.prototype.____constructor(self, ...)
	self.castToken = 0
	self.lockedPlayerIds = {}
	self.collapseStep = 0
end
function boss_rubick_origin_6.prototype.Precache(self, context)
	PrecacheResource("particle", RUBICK_ORIGIN_6_SELF_PARTICLE, context)
	PrecacheResource("particle", RUBICK_ORIGIN_6_COLLAPSE_PARTICLE, context)
	PrecacheResource("particle", RUBICK_ORIGIN_6_BREAK_PARTICLE, context)
	PrecacheResource("particle", RUBICK_ORIGIN_6_VOID_FALL_PARTICLE, context)
	PrecacheResource("model", RUBICK_ORIGIN_6_PROJECTION_MODEL, context)
	PrecacheResource("model", RUBICK_ORIGIN_6_PUPPET_MODEL, context)
end
function boss_rubick_origin_6.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = RUBICK_ORIGIN_6_CAST_RANGE,
		castAnimation = "",
		castPoint = RUBICK_ORIGIN_6_CAST_POINT,
		castDuration = RUBICK_ORIGIN_6_STUN_DURATION - RUBICK_ORIGIN_6_CAST_POINT,
		canCast = function()
			if not MyGameDynamicFloor or not MyGameRubickBossEnvironment then
				return UF_FAIL_CUSTOM
			end
			local ____table_FindEnvironmentFloorId_result_4
			if self:FindEnvironmentFloorId() then
				____table_FindEnvironmentFloorId_result_4 = UF_SUCCESS
			else
				____table_FindEnvironmentFloorId_result_4 = UF_FAIL_CUSTOM
			end
			return ____table_FindEnvironmentFloorId_result_4
		end,
		OnPhaseStart = function()
			return self:PrepareEnvironmentSwitch()
		end,
		OnStart = function()
			return self:SwitchEnvironment(self.castToken)
		end,
		OnInterrupt = function()
			self.castToken = self.castToken + 1
			self:ClearSelfParticle()
		end,
		OnFinish = function()
			self:ClearSelfParticle()
		end,
	}
end
function boss_rubick_origin_6.prototype.PrepareEnvironmentSwitch(self)
	local caster = self:GetCaster()
	self.castToken = self.castToken + 1
	self.lockedFloorId = self:FindEnvironmentFloorId()
	self.lockedPlayerIds = self:FindRoomPlayerIds()
	self.lockedHero = self:FindPresentationHero()
	self:ClearSelfParticle()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:NormalizeCasterToEnvironmentFloor(caster)
	caster:SetAnimation(RUBICK_ORIGIN_6_CAST_ANIMATION)
	self:StunRoomPlayers(caster)
	self:PlaySelfParticle(caster)
end
function boss_rubick_origin_6.prototype.SwitchEnvironment(self, token)
	if token ~= self.castToken or not self.lockedFloorId or not MyGameRubickBossEnvironment then
		return
	end
	if not self:PlayCenteredCollapse() then
		return
	end
	local punishDelay = RUBICK_ORIGIN_6_COLLAPSE_PARTICLE_DURATION + RUBICK_ORIGIN_6_PUNISH_AFTER_BREAK_DELAY
	SysTimers:CreateTimer(punishDelay, function()
		self:PunishPlayersOnVoidTiles(token)
		return nil
	end)
	local phaseDelay = punishDelay + RUBICK_ORIGIN_6_PHASE_APPLY_AFTER_PUNISH_DELAY
	SysTimers:CreateTimer(phaseDelay, function()
		self:ApplyEnvironmentPhase(token)
		return nil
	end)
end
function boss_rubick_origin_6.prototype.PlayCenteredCollapse(self)
	if not self.lockedFloorId or not MyGameDynamicFloor then
		return false
	end
	local targetSize = self:GetNextCollapseTargetSize()
	local result = MyGameDynamicFloor:PlayCenteredCollapse(self.lockedFloorId, {
		targetColumns = targetSize,
		targetRows = targetSize,
		duration = RUBICK_ORIGIN_6_COLLAPSE_DURATION,
		arcHeight = RUBICK_ORIGIN_6_COLLAPSE_ARC_HEIGHT,
		staggerDelay = RUBICK_ORIGIN_6_COLLAPSE_STAGGER_DELAY,
		removeTileModel = true,
		breakDelay = RUBICK_ORIGIN_6_COLLAPSE_PARTICLE_DURATION,
		breakParticle = RUBICK_ORIGIN_6_BREAK_PARTICLE,
		breakParticleDuration = RUBICK_ORIGIN_6_BREAK_PARTICLE_DURATION,
	})
	if not result.success then
		PrintToChat(nil, "[rubick_origin_6] 中心收缩失败：" .. (result.reason or "未知原因"))
		return false
	end
	self.collapseStep = self.collapseStep + 1
	self:PlayCollapseParticle(result)
	return true
end
function boss_rubick_origin_6.prototype.ApplyEnvironmentPhase(self, token)
	if token ~= self.castToken or not self.lockedFloorId or not MyGameRubickBossEnvironment then
		return
	end
	local applied = MyGameRubickBossEnvironment:ApplyNextPhase(
		self.lockedFloorId,
		self.lockedPlayerIds[1],
		self.lockedHero,
		self.lockedPlayerIds
	)
	if not applied then
		return
	end
	local phaseId = MyGameRubickBossEnvironment:GetCurrentPhase(self.lockedFloorId)
	self:SwitchStyleAbilities(phaseId)
	self:NotifyStylePhaseChanged(phaseId)
	self:FirePhaseChangedEvent(phaseId)
end
function boss_rubick_origin_6.prototype.NotifyStylePhaseChanged(self, phaseId)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	for ____, stylePhase in ipairs({ "origin", "snow", "sand", "ash" }) do
		local abilities = RUBICK_ORIGIN_6_STYLE_ABILITIES[stylePhase]
		for ____, abilityName in ipairs(abilities) do
			local ability = caster:FindAbilityByName(abilityName)
			local ____opt_5 = ability and ability.OnRubickBossPhaseChanged
			if ____opt_5 ~= nil then
				____opt_5(ability, phaseId, self.lockedFloorId, self.lockedPlayerIds)
			end
		end
	end
end
function boss_rubick_origin_6.prototype.FirePhaseChangedEvent(self, phaseId)
	local caster = self:GetCaster()
	if not phaseId or not self.lockedFloorId or not IsValidAlive(nil, caster) then
		return
	end
	MyGameEvent:FireEvent(BusinessEvents.ON_RUBICK_BOSS_PHASE_CHANGED, {
		caster = caster:entindex(),
		floorId = self.lockedFloorId,
		phaseId = phaseId,
		playerIds = self.lockedPlayerIds,
		changed_at = GameRules:GetGameTime(),
	}, { scope = "global" })
end
function boss_rubick_origin_6.prototype.SwitchStyleAbilities(self, phaseId)
	local caster = self:GetCaster()
	____exports.SyncRubickBossStyleAbilities(nil, caster, phaseId)
end
function boss_rubick_origin_6.prototype.PunishPlayersOnVoidTiles(self, token)
	if token ~= self.castToken or not self.lockedFloorId or not MyGameDynamicFloor then
		return
	end
	local punishedCount = 0
	for ____, playerId in ipairs(self.lockedPlayerIds) do
		do
			local ____opt_9 = MyGamePlayers:getPlayer(playerId)
			local hero = ____opt_9 and ____opt_9:GetHero()
			if not hero or not IsValidAlive(nil, hero) then
				goto __continue51
			end
			if not self:IsHeroOnVoidTile(hero) then
				goto __continue51
			end
			local safeResult = MyGameDynamicFloor:GetNearestAvailableTileCenter(self.lockedFloorId, hero:GetAbsOrigin())
			if not safeResult.success or not safeResult.position then
				goto __continue51
			end
			____exports.modifier_boss_rubick_origin_6_void_fall:applys(hero, self:GetCaster(), self, {
				duration = RUBICK_ORIGIN_6_VOID_FALL_DURATION,
				target_x = safeResult.position.x,
				target_y = safeResult.position.y,
				target_z = safeResult.position.z,
				fall_distance = RUBICK_ORIGIN_6_VOID_FALL_DISTANCE,
				damage_rate = RUBICK_ORIGIN_6_VOID_FALL_DAMAGE_RATE,
			})
			punishedCount = punishedCount + 1
		end
		::__continue51::
	end
	if punishedCount > 0 then
		self:PlayPuppetProjection()
	end
end
function boss_rubick_origin_6.prototype.IsHeroOnVoidTile(self, hero)
	local tile = self:GetUnitTile(hero)
	if not tile then
		return true
	end
	if tile.floorId ~= self.lockedFloorId then
		return false
	end
	return not tile.isAvailable or tile.isDisabled or tile.modelRemoved
end
function boss_rubick_origin_6.prototype.PlayPuppetProjection(self)
	if not self.lockedFloorId or not MyGameDynamicFloor then
		return
	end
	local floor = MyGameDynamicFloor:GetFloor(self.lockedFloorId)
	if not floor then
		return
	end
	local center = floor:GetSurfaceCenter()
	local ____self_CreateProjectionProp_13 = self.CreateProjectionProp
	local ____opt_11 = self:GetCaster()
	local projection = ____self_CreateProjectionProp_13(
		self,
		RUBICK_ORIGIN_6_PROJECTION_MODEL,
		center,
		____opt_11 and ____opt_11:GetForwardVector()
	)
	local puppetOrigin = center:__add(Vector(0, 0, RUBICK_ORIGIN_6_PUPPET_OVERHEAD_Z))
	local ____self_CreateProjectionProp_16 = self.CreateProjectionProp
	local ____opt_14 = self:GetCaster()
	local puppet = ____self_CreateProjectionProp_16(
		self,
		RUBICK_ORIGIN_6_PUPPET_MODEL,
		puppetOrigin,
		____opt_14 and ____opt_14:GetForwardVector()
	)
	SysTimers:CreateTimer(RUBICK_ORIGIN_6_PUPPET_SHOW_DURATION, function()
		if projection and IsValid(nil, projection) then
			projection:RemoveSelf()
		end
		if puppet and IsValid(nil, puppet) then
			puppet:RemoveSelf()
		end
		return nil
	end)
end
function boss_rubick_origin_6.prototype.CreateProjectionProp(self, model, origin, forward)
	local prop = SpawnEntityFromTableSynchronous("prop_dynamic", {
		model = model,
		origin = (((tostring(origin.x) .. " ") .. tostring(origin.y)) .. " ") .. tostring(origin.z),
		angles = "0 0 0",
		solid = "0",
	})
	if not prop or not IsValid(nil, prop) or not IsValidEntity(prop) then
		return nil
	end
	prop:SetAbsOrigin(origin)
	if forward then
		local ____this_18
		____this_18 = prop
		local ____opt_17 = ____this_18.SetForwardVector
		if ____opt_17 ~= nil then
			____opt_17(____this_18, forward)
		end
	end
	return prop
end
function boss_rubick_origin_6.prototype.GetNextCollapseTargetSize(self)
	local index = math.min(self.collapseStep, #RUBICK_ORIGIN_6_COLLAPSE_TARGET_SIZES - 1)
	return RUBICK_ORIGIN_6_COLLAPSE_TARGET_SIZES[index + 1]
end
function boss_rubick_origin_6.prototype.PlayCollapseParticle(self, result)
	if not result.effectOrigin or not result.effectWidth or not result.effectHeight then
		return
	end
	local particle = ParticleManager:CreateParticle(RUBICK_ORIGIN_6_COLLAPSE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, result.effectOrigin + Vector(0, 0, 16))
	ParticleManager:SetParticleControl(
		particle,
		1,
		Vector(RUBICK_ORIGIN_6_COLLAPSE_CP1_VALUE, RUBICK_ORIGIN_6_COLLAPSE_CP1_VALUE, 0)
	)
	local cp10 = Vector(result.effectWidth / 2, result.effectHeight / 2, 0)
	ParticleManager:SetParticleControl(particle, 10, cp10)
	print(
		(
			(
				(
					"[RubickOrigin6] 范围特效CP "
					.. ((((("CP0=(" .. tostring(math.floor(result.effectOrigin.x))) .. ",") .. tostring(
						math.floor(result.effectOrigin.y)
					)) .. ",") .. tostring(math.floor(result.effectOrigin.z)))
					.. ") "
				)
				.. ((("CP1=(" .. tostring(RUBICK_ORIGIN_6_COLLAPSE_CP1_VALUE)) .. ",") .. tostring(
					RUBICK_ORIGIN_6_COLLAPSE_CP1_VALUE
				))
				.. ",0) "
			)
			.. ((((("CP10=(" .. tostring(math.floor(cp10.x))) .. ",") .. tostring(math.floor(cp10.y))) .. ",") .. tostring(
				math.floor(cp10.z)
			))
			.. ") "
		)
			.. (("width=" .. tostring(math.floor(result.effectWidth))) .. " height=")
			.. tostring(math.floor(result.effectHeight))
	)
	SysTimers:CreateTimer(RUBICK_ORIGIN_6_COLLAPSE_PARTICLE_DURATION, function()
		ParticleManager:DestroyParticle(particle, false)
		ParticleManager:ReleaseParticleIndex(particle)
		return nil
	end)
end
function boss_rubick_origin_6.prototype.FindEnvironmentFloorId(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	local casterTile = self:GetUnitTile(caster)
	local casterFloorId = self:GetAvailableFloorId(casterTile and casterTile.floorId, caster:GetAbsOrigin())
	if casterFloorId then
		return casterFloorId
	end
	for ____, playerId in ipairs(self:FindRoomPlayerIds()) do
		do
			local ____opt_21 = MyGamePlayers:getPlayer(playerId)
			local hero = ____opt_21 and ____opt_21:GetHero()
			if not hero or not IsValidAlive(nil, hero) then
				goto __continue76
			end
			local heroTile = self:GetUnitTile(hero)
			local heroFloorId = self:GetAvailableFloorId(heroTile and heroTile.floorId, hero:GetAbsOrigin())
			if heroFloorId then
				return heroFloorId
			end
		end
		::__continue76::
	end
	return self:FindNearestRoomFloorId(caster)
end
function boss_rubick_origin_6.prototype.GetAvailableFloorId(self, floorId, origin)
	if not floorId or not MyGameDynamicFloor then
		return nil
	end
	local result = MyGameDynamicFloor:GetNearestAvailableTileCenter(floorId, origin)
	local ____result_success_25
	if result.success then
		____result_success_25 = floorId
	else
		____result_success_25 = nil
	end
	return ____result_success_25
end
function boss_rubick_origin_6.prototype.FindNearestRoomFloorId(self, caster)
	if not MyGameDynamicFloor or not IsValidAlive(nil, caster) then
		return nil
	end
	local ____this_27
	____this_27 = caster
	local ____opt_26 = ____this_27.GetRoomId
	local roomId = ____opt_26 and ____opt_26(____this_27)
	if not roomId then
		return nil
	end
	local bestFloorId
	local bestDistance = 0
	for ____, floor in ipairs(MyGameDynamicFloor:GetFloorsByRoom(roomId)) do
		do
			local result = MyGameDynamicFloor:GetNearestAvailableTileCenter(floor.floorId, caster:GetAbsOrigin())
			if not result.success or not result.position then
				goto __continue85
			end
			local distance = GetDistance(nil, result.position, caster:GetAbsOrigin())
			if not bestFloorId or distance < bestDistance then
				bestFloorId = floor.floorId
				bestDistance = distance
			end
		end
		::__continue85::
	end
	return bestFloorId
end
function boss_rubick_origin_6.prototype.NormalizeCasterToEnvironmentFloor(self, caster)
	if not self.lockedFloorId or not MyGameDynamicFloor or not IsValidAlive(nil, caster) then
		return
	end
	local currentTile = self:GetUnitTile(caster)
	if
		currentTile
		and currentTile.floorId == self.lockedFloorId
		and currentTile.isAvailable
		and not currentTile.isDisabled
		and not currentTile.modelRemoved
	then
		return
	end
	local result = MyGameDynamicFloor:GetNearestAvailableTileCenter(self.lockedFloorId, caster:GetAbsOrigin())
	if result.success and result.position then
		FindClearSpaceForUnit(caster, result.position, true)
	end
end
function boss_rubick_origin_6.prototype.FindRoomPlayerIds(self)
	local caster = self:GetCaster()
	local ____IsValidAlive_result_30
	if IsValidAlive(nil, caster) then
		local ____opt_28 = caster.GetRoomId
		____IsValidAlive_result_30 = ____opt_28 and ____opt_28(caster)
	else
		____IsValidAlive_result_30 = nil
	end
	local casterRoomId = ____IsValidAlive_result_30
	local result = {}
	if not MyGamePlayers then
		return result
	end
	for ____, playerId in ipairs(MyGamePlayers:getAllPlayerIds()) do
		do
			local ____opt_31 = MyGamePlayers:getPlayer(playerId)
			local hero = ____opt_31 and ____opt_31:GetHero()
			if not hero or not IsValidAlive(nil, hero) then
				goto __continue95
			end
			local ____opt_33 = MyGameRoomManager and MyGameRoomManager:GetPlayerRoom(playerId)
			local playerRoomId = ____opt_33 and ____opt_33:GetRoomId()
			if casterRoomId and playerRoomId and playerRoomId ~= casterRoomId then
				goto __continue95
			end
			result[#result + 1] = playerId
		end
		::__continue95::
	end
	return result
end
function boss_rubick_origin_6.prototype.FindPresentationHero(self)
	for ____, playerId in ipairs(self.lockedPlayerIds) do
		local ____opt_37 = MyGamePlayers:getPlayer(playerId)
		local hero = ____opt_37 and ____opt_37:GetHero()
		if hero and IsValidAlive(nil, hero) then
			return hero
		end
	end
	return nil
end
function boss_rubick_origin_6.prototype.StunRoomPlayers(self, caster)
	for ____, playerId in ipairs(self.lockedPlayerIds) do
		do
			local ____opt_39 = MyGamePlayers:getPlayer(playerId)
			local hero = ____opt_39 and ____opt_39:GetHero()
			if not hero or not IsValidAlive(nil, hero) then
				goto __continue104
			end
			AddDeBuffStatus(
				nil,
				hero,
				caster,
				self,
				DebuffStatusType.STUN,
				{ duration = RUBICK_ORIGIN_6_STUN_DURATION }
			)
		end
		::__continue104::
	end
end
function boss_rubick_origin_6.prototype.PlaySelfParticle(self, caster)
	self.selfParticle = ParticleManager:CreateParticle(RUBICK_ORIGIN_6_SELF_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		self.selfParticle,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self.selfParticle,
		1,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		caster:GetAbsOrigin(),
		true
	)
	local particle = self.selfParticle
	SysTimers:CreateTimer(RUBICK_ORIGIN_6_SELF_PARTICLE_DURATION, function()
		if self.selfParticle == particle then
			self:ClearSelfParticle()
		end
		return nil
	end)
end
function boss_rubick_origin_6.prototype.ClearSelfParticle(self)
	if self.selfParticle == nil then
		return
	end
	ParticleManager:DestroyParticle(self.selfParticle, false)
	ParticleManager:ReleaseParticleIndex(self.selfParticle)
	self.selfParticle = nil
end
boss_rubick_origin_6 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_rubick_origin_6)
____exports.boss_rubick_origin_6 = boss_rubick_origin_6
____exports.modifier_boss_rubick_origin_6_void_fall = __TS__Class()
local modifier_boss_rubick_origin_6_void_fall = ____exports.modifier_boss_rubick_origin_6_void_fall
modifier_boss_rubick_origin_6_void_fall.name = "modifier_boss_rubick_origin_6_void_fall"
__TS__ClassExtends(modifier_boss_rubick_origin_6_void_fall, BaseModifier_CS)
function modifier_boss_rubick_origin_6_void_fall.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.fallDistance = RUBICK_ORIGIN_6_VOID_FALL_DISTANCE
	self.damageRate = RUBICK_ORIGIN_6_VOID_FALL_DAMAGE_RATE
	self.elapsed = 0
	self.damageApplied = false
end
function modifier_boss_rubick_origin_6_void_fall.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self.startOrigin = parent:GetAbsOrigin()
	self.targetOrigin = Vector(
		params.target_x or self.startOrigin.x,
		params.target_y or self.startOrigin.y,
		params.target_z or self.startOrigin.z
	)
	self.fallDistance = params.fall_distance or RUBICK_ORIGIN_6_VOID_FALL_DISTANCE
	self.damageRate = params.damage_rate or RUBICK_ORIGIN_6_VOID_FALL_DAMAGE_RATE
	parent:StartGestureWithPlaybackRate(ACT_DOTA_FLAIL, 1.2)
	self.effectParticle =
		ParticleManager:CreateParticle(RUBICK_ORIGIN_6_VOID_FALL_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		self.effectParticle,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		parent:GetAbsOrigin(),
		true
	)
	self:StartIntervalThink(0.03)
end
function modifier_boss_rubick_origin_6_void_fall.prototype.OnIntervalThink(self)
	if not IsServer() or not self.startOrigin then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	self.elapsed = self.elapsed + 0.03
	local duration = math.max(0.03, self:GetDuration())
	local progress = math.min(1, self.elapsed / duration)
	local easedProgress = 1 - (1 - progress) * (1 - progress)
	local target = self.startOrigin:__add(Vector(0, 0, -self.fallDistance * easedProgress))
	parent:SetAbsOrigin(target)
	if not self.damageApplied and progress >= 0.55 then
		self.damageApplied = true
		self:ApplyVoidFallDamage(parent)
	end
end
function modifier_boss_rubick_origin_6_void_fall.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if self.effectParticle ~= nil then
		ParticleManager:DestroyParticle(self.effectParticle, false)
		ParticleManager:ReleaseParticleIndex(self.effectParticle)
		self.effectParticle = nil
	end
	if IsValidAlive(nil, parent) then
		if not self.damageApplied then
			self:ApplyVoidFallDamage(parent)
		end
		if self.targetOrigin then
			FindClearSpaceForUnit(parent, self.targetOrigin, true)
		end
		parent:RemoveGesture(ACT_DOTA_FLAIL)
	end
end
function modifier_boss_rubick_origin_6_void_fall.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE }
end
function modifier_boss_rubick_origin_6_void_fall.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_FLAIL
end
function modifier_boss_rubick_origin_6_void_fall.prototype.GetOverrideAnimationRate(self)
	return 1.2
end
function modifier_boss_rubick_origin_6_void_fall.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function modifier_boss_rubick_origin_6_void_fall.prototype.IsDebuff(self)
	return true
end
function modifier_boss_rubick_origin_6_void_fall.prototype.IsPurgable(self)
	return false
end
function modifier_boss_rubick_origin_6_void_fall.prototype.GetStatusEffectName(self)
	return RUBICK_ORIGIN_6_VOID_FALL_PARTICLE
end
function modifier_boss_rubick_origin_6_void_fall.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_boss_rubick_origin_6_void_fall.prototype.ApplyVoidFallDamage(self, parent)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	if not caster or not IsValid(nil, caster) or caster:IsNull() then
		return
	end
	caster:MonsterDamage({
		victim = parent,
		damage_rate = self.damageRate,
		ability = self:GetAbility(),
	})
end
modifier_boss_rubick_origin_6_void_fall =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_rubick_origin_6_void_fall)
____exports.modifier_boss_rubick_origin_6_void_fall = modifier_boss_rubick_origin_6_void_fall
return ____exports