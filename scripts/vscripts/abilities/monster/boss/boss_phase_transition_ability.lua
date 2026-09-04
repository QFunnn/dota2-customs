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
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Spread = ____lualib.__TS__Spread
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local BOSS_PHASE_TRANSITION_RETURN_TO_SPAWN_DURATION = 0.8
local BOSS_PHASE_TRANSITION_WINDOW_DURATION = 6
local BOSS_PHASE_TRANSITION_GESTURE_INTERVAL = 1
local BOSS_PHASE_TWO_DAMAGE_BONUS_PCT = 10
local BOSS_PHASE_TWO_MOVESPEED_BONUS_PCT = 20
local BOSS_PHASE_TWO_ATTACK_SPEED_BONUS = 20
--- Boss 转阶段技能基类：由 AI 识别并在血量低于阈值时主动释放。
____exports.BossPhaseTransitionAbility_CS = __TS__Class()
local BossPhaseTransitionAbility_CS = ____exports.BossPhaseTransitionAbility_CS
BossPhaseTransitionAbility_CS.name = "BossPhaseTransitionAbility_CS"
__TS__ClassExtends(BossPhaseTransitionAbility_CS, MonsterAbility_CS)
function BossPhaseTransitionAbility_CS.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.phaseTransitionTriggered = false
end
function BossPhaseTransitionAbility_CS.prototype.IsBossPhaseTransitionAbility(self)
	return true
end
function BossPhaseTransitionAbility_CS.prototype.IsHiddenAbilityCastable(self)
	return true
end
function BossPhaseTransitionAbility_CS.prototype.GetBossPhaseTransitionHealthThresholdPct(self)
	return 60
end
function BossPhaseTransitionAbility_CS.prototype.GetBossPhaseTransitionReturnToSpawnDuration(self)
	return BOSS_PHASE_TRANSITION_RETURN_TO_SPAWN_DURATION
end
function BossPhaseTransitionAbility_CS.prototype.GetBossPhaseTransitionWindowDuration(self)
	return BOSS_PHASE_TRANSITION_WINDOW_DURATION
end
function BossPhaseTransitionAbility_CS.prototype.GetBossPhaseTransitionGesture(self)
	return nil
end
function BossPhaseTransitionAbility_CS.prototype.GetBossPhaseTransitionGesturePlaybackRate(self)
	return 1
end
function BossPhaseTransitionAbility_CS.prototype.ShouldApplyDefaultBossPhaseTransitionWindow(self)
	return true
end
function BossPhaseTransitionAbility_CS.prototype.ShouldApplyDefaultBossPhaseTwoBuff(self)
	return true
end
function BossPhaseTransitionAbility_CS.prototype.GetMosnterAbilityConfig(self)
	local cfg = self:GetBossPhaseTransitionConfig()
	local originalOnStart = cfg.OnStart
	local originalOnFinish = cfg.OnFinish
	return __TS__ObjectAssign({}, cfg, {
		OnStart = function()
			return self:StartBossPhaseTransition(originalOnStart)
		end,
		OnFinish = function()
			if originalOnFinish ~= nil then
				originalOnFinish(nil)
			end
			local caster = self:GetCaster()
			if IsValidAlive(nil, caster) then
				caster:SetBossPhaseTransitionState(BossPhaseTransitionState.AFTER)
			end
		end,
	})
end
function BossPhaseTransitionAbility_CS.prototype.HasBossPhaseTransitionTriggered(self)
	return self.phaseTransitionTriggered
end
function BossPhaseTransitionAbility_CS.prototype.CanTriggerBossPhaseTransition(self, caster)
	if self:HasBossPhaseTransitionTriggered() then
		return false
	end
	if not IsValidAlive(nil, caster) then
		return false
	end
	local maxHealth = math.max(1, caster:GetMaxHealth())
	local healthPct = math.max(0, caster:GetHealth()) / maxHealth * 100
	return healthPct <= self:GetBossPhaseTransitionHealthThresholdPct()
end
function BossPhaseTransitionAbility_CS.prototype.MarkBossPhaseTransitionTriggered(self)
	self.phaseTransitionTriggered = true
end
function BossPhaseTransitionAbility_CS.prototype.StartBossPhaseTransition(self, onStart)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:MarkBossPhaseTransitionTriggered()
	caster:SetBossPhaseTransitionState(BossPhaseTransitionState.TRANSITIONING)
	local delay = math.max(0, self:GetBossPhaseTransitionReturnToSpawnDuration())
	self:Timer(delay, function()
		if not IsValid(nil, self) or self:IsNull() then
			return
		end
		if not IsValidAlive(nil, caster) then
			return
		end
		self:ApplyDefaultPhaseTransitionWindow(caster)
		if onStart ~= nil then
			onStart(nil)
		end
	end)
	local ____opt_4 = caster.GetSpawnPoint
	local spawnPoint = ____opt_4 and ____opt_4(caster)
	if spawnPoint and delay > 0 then
		pcall(function()
			return caster:Mover(spawnPoint, delay, nil, true, true)
		end)
	end
end
function BossPhaseTransitionAbility_CS.prototype.ApplyDefaultPhaseTransitionWindow(self, caster)
	local duration = math.max(0, self:GetBossPhaseTransitionWindowDuration())
	if duration <= 0 then
		return
	end
	if self:ShouldApplyDefaultBossPhaseTransitionWindow() then
		local gesture = self:GetBossPhaseTransitionGesture()
		____exports.modifier_boss_phase_transition_window:applys(caster, caster, self, {
			duration = duration,
			gesture = gesture == nil and -1 or gesture,
			gesture_playback_rate = self:GetBossPhaseTransitionGesturePlaybackRate(),
		})
	end
	if self:ShouldApplyDefaultBossPhaseTwoBuff() then
		self:Timer(duration, function()
			if not IsValid(nil, self) or self:IsNull() then
				return
			end
			if not IsValidAlive(nil, caster) then
				return
			end
			____exports.modifier_boss_phase_two_buff:applys(caster, caster, self, {})
		end)
	end
end
____exports.modifier_boss_phase_transition_window = __TS__Class()
local modifier_boss_phase_transition_window = ____exports.modifier_boss_phase_transition_window
modifier_boss_phase_transition_window.name = "modifier_boss_phase_transition_window"
__TS__ClassExtends(modifier_boss_phase_transition_window, MonsterModifier_CS)
function modifier_boss_phase_transition_window.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.gesturePlaybackRate = 1
end
function modifier_boss_phase_transition_window.prototype.IsHidden(self)
	return true
end
function modifier_boss_phase_transition_window.prototype.IsPurgable(self)
	return false
end
function modifier_boss_phase_transition_window.prototype.IsDebuff(self)
	return false
end
function modifier_boss_phase_transition_window.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local ____temp_6
	if params.gesture ~= nil and params.gesture >= 0 then
		____temp_6 = params.gesture
	else
		____temp_6 = nil
	end
	self.gesture = ____temp_6
	self.gesturePlaybackRate = params.gesture_playback_rate or 1
	local parent = self:GetParent()
	local ability = self:GetAbility()
	local ____print_13 = print
	local ____opt_7 = ability and ability.GetAbilityName
	local ____temp_12 = ____opt_7 and ____opt_7(ability) or "<unknown>"
	local ____IsValid_result_11
	if IsValid(nil, parent) then
		____IsValid_result_11 = parent:GetUnitName()
	else
		____IsValid_result_11 = "<invalid>"
	end
	____print_13(
		(
			(
				(
					(
						(("[BossPhaseTransition] Window:OnCreated ability=" .. ____temp_12) .. " caster=")
						.. ____IsValid_result_11
					) .. " duration="
				) .. tostring(params.duration)
			) .. " gesture="
		) .. tostring(self.gesture == nil and -1 or self.gesture)
	)
	self:HideBossBar()
	self:PlayTransitionGesture()
	if self.gesture ~= nil then
		self:StartIntervalThink(BOSS_PHASE_TRANSITION_GESTURE_INTERVAL)
	end
end
function modifier_boss_phase_transition_window.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	local ____print_20 = print
	local ____opt_14 = ability and ability.GetAbilityName
	local ____temp_19 = ____opt_14 and ____opt_14(ability) or "<unknown>"
	local ____IsValid_result_18
	if IsValid(nil, parent) then
		____IsValid_result_18 = parent:GetUnitName()
	else
		____IsValid_result_18 = "<invalid>"
	end
	____print_20(
		(("[BossPhaseTransition] Window:OnDestroy ability=" .. ____temp_19) .. " caster=") .. ____IsValid_result_18
	)
	if self.gesture ~= nil and IsValid(nil, parent) and not parent:IsNull() then
		parent:FadeGesture(self.gesture)
	end
	self:RestoreBossBar()
end
function modifier_boss_phase_transition_window.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:PlayTransitionGesture()
end
function modifier_boss_phase_transition_window.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ROOTED] = true,
	}
end
function modifier_boss_phase_transition_window.prototype.HideBossBar(self)
	local parent = self:GetParent()
	local key = tostring(parent:entindex())
	local ____opt_21 = MyGameBossBarManager and MyGameBossBarManager.bossBar
	local entry = ____opt_21 and ____opt_21[key]
	if not entry then
		return
	end
	local ____entry_BossID_26 = entry.BossID
	local ____entry_PlayerIDs_25
	if entry.PlayerIDs then
		____entry_PlayerIDs_25 = { __TS__Spread(entry.PlayerIDs) }
	else
		____entry_PlayerIDs_25 = nil
	end
	self.bossBarEntry = { BossID = ____entry_BossID_26, PlayerIDs = ____entry_PlayerIDs_25 }
	MyGameBossBarManager.bossBar[key] = nil
	MyGameBossBarManager:SyncNetTabel()
end
function modifier_boss_phase_transition_window.prototype.RestoreBossBar(self)
	if not self.bossBarEntry then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local key = tostring(parent:entindex())
	MyGameBossBarManager.bossBar[key] = self.bossBarEntry
	MyGameBossBarManager:SyncNetTabel()
	self.bossBarEntry = nil
end
function modifier_boss_phase_transition_window.prototype.PlayTransitionGesture(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or self.gesture == nil then
		return
	end
	parent:StartGestureWithPlaybackRate(self.gesture, self.gesturePlaybackRate)
end
modifier_boss_phase_transition_window = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_phase_transition_window") },
	modifier_boss_phase_transition_window
)
____exports.modifier_boss_phase_transition_window = modifier_boss_phase_transition_window
____exports.modifier_boss_phase_two_buff = __TS__Class()
local modifier_boss_phase_two_buff = ____exports.modifier_boss_phase_two_buff
modifier_boss_phase_two_buff.name = "modifier_boss_phase_two_buff"
__TS__ClassExtends(modifier_boss_phase_two_buff, MonsterModifier_CS)
function modifier_boss_phase_two_buff.prototype.IsHidden(self)
	return false
end
function modifier_boss_phase_two_buff.prototype.IsPurgable(self)
	return false
end
function modifier_boss_phase_two_buff.prototype.IsDebuff(self)
	return false
end
function modifier_boss_phase_two_buff.prototype.GetAttributeBonus(self)
	return {
		outgoing_damage_pct = BOSS_PHASE_TWO_DAMAGE_BONUS_PCT,
		damage_reduction_pct = BOSS_PHASE_TWO_DAMAGE_BONUS_PCT,
		bonus_movespeed_pct = BOSS_PHASE_TWO_MOVESPEED_BONUS_PCT,
		attack_speed = BOSS_PHASE_TWO_ATTACK_SPEED_BONUS,
	}
end
modifier_boss_phase_two_buff =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_boss_phase_two_buff") }, modifier_boss_phase_two_buff)
____exports.modifier_boss_phase_two_buff = modifier_boss_phase_two_buff
return ____exports