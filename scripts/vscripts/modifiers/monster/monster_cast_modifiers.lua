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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_modifier_cs = require("modifiers.monster.monster_modifier_cs")
local MonsterModifier_CS = ____monster_modifier_cs.MonsterModifier_CS
--- 前置移动层占位：用于让 Boss AI 识别移动阶段仍属于怪物施法流程。
____exports.modifier_monster_cast_pre_move = __TS__Class()
local modifier_monster_cast_pre_move = ____exports.modifier_monster_cast_pre_move
modifier_monster_cast_pre_move.name = "modifier_monster_cast_pre_move"
__TS__ClassExtends(modifier_monster_cast_pre_move, MonsterModifier_CS)
function modifier_monster_cast_pre_move.prototype.IsHidden(self)
	return true
end
function modifier_monster_cast_pre_move.prototype.IsPurgable(self)
	return false
end
function modifier_monster_cast_pre_move.prototype.IsDebuff(self)
	return false
end
modifier_monster_cast_pre_move =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_monster_cast_pre_move") }, modifier_monster_cast_pre_move)
____exports.modifier_monster_cast_pre_move = modifier_monster_cast_pre_move
--- 通用施法控制 Modifier：
-- - 自行驱动 castPoint/castDuration 时序，不依赖原生施法前摇（避免被控制原生打断）
-- - 施法期禁：转身/命令/移动/普攻
-- - 仅在 castPoint 结束前 0.2s 窗口内，眩晕才算“打断”
-- - 冷却在 OnFinish 时进入（被打断也会走 OnFinish）
____exports.modifier_monster_cast_controller = __TS__Class()
local modifier_monster_cast_controller = ____exports.modifier_monster_cast_controller
modifier_monster_cast_controller.name = "modifier_monster_cast_controller"
__TS__ClassExtends(modifier_monster_cast_controller, MonsterModifier_CS)
function modifier_monster_cast_controller.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.lockActions = 1
end
function modifier_monster_cast_controller.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	self.lockActions = kv.__lock_actions or 1
end
function modifier_monster_cast_controller.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self._parent:SetPostureLocked(false)
	local ability = self._ability
	if not ability then
		return
	end
	local cfg = ability and ability:GetMosnterAbilityConfig()
	SafelyCall(nil, function()
		local ____opt_2 = cfg and cfg.OnFinish
		return ____opt_2 and ____opt_2(cfg)
	end, "modifier_monster_cast_controller.OnFinish")
end
function modifier_monster_cast_controller.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DISABLE_TURNING }
end
function modifier_monster_cast_controller.prototype.GetModifierDisableTurning(self)
	return self.lockActions
end
function modifier_monster_cast_controller.prototype.CheckState(self)
	if not self.lockActions then
		return {}
	end
	local ____MODIFIER_STATE_COMMAND_RESTRICTED_9 = MODIFIER_STATE_COMMAND_RESTRICTED
	local ____temp_6
	if self.lockActions == 1 then
		____temp_6 = true
	else
		____temp_6 = nil
	end
	local ____MODIFIER_STATE_DISARMED_10 = MODIFIER_STATE_DISARMED
	local ____temp_7
	if self.lockActions == 1 then
		____temp_7 = true
	else
		____temp_7 = nil
	end
	local ____MODIFIER_STATE_NO_UNIT_COLLISION_11 = MODIFIER_STATE_NO_UNIT_COLLISION
	local ____temp_8
	if self.lockActions == 1 then
		____temp_8 = true
	else
		____temp_8 = nil
	end
	return {
		[____MODIFIER_STATE_COMMAND_RESTRICTED_9] = ____temp_6,
		[____MODIFIER_STATE_DISARMED_10] = ____temp_7,
		[____MODIFIER_STATE_NO_UNIT_COLLISION_11] = ____temp_8,
		[MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true,
	}
end
function modifier_monster_cast_controller.prototype.IsHidden(self)
	return true
end
function modifier_monster_cast_controller.prototype.IsPurgable(self)
	return false
end
function modifier_monster_cast_controller.prototype.IsDebuff(self)
	return false
end
modifier_monster_cast_controller = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_monster_cast_controller") },
	modifier_monster_cast_controller
)
____exports.modifier_monster_cast_controller = modifier_monster_cast_controller
--- 前摇 Debuff 免疫：用于避免控制导致原生施法前摇被打断
____exports.modifier_monster_cast_debuff_immune = __TS__Class()
local modifier_monster_cast_debuff_immune = ____exports.modifier_monster_cast_debuff_immune
modifier_monster_cast_debuff_immune.name = "modifier_monster_cast_debuff_immune"
__TS__ClassExtends(modifier_monster_cast_debuff_immune, MonsterModifier_CS)
function modifier_monster_cast_debuff_immune.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self._window_time = false
end
function modifier_monster_cast_debuff_immune.prototype.IsHidden(self)
	return true
end
function modifier_monster_cast_debuff_immune.prototype.IsPurgable(self)
	return false
end
function modifier_monster_cast_debuff_immune.prototype.IsDebuff(self)
	return false
end
function modifier_monster_cast_debuff_immune.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if not IsValid(nil, self._parent) then
		return
	end
	MyGameMonsterCounterBreak:ClearWindow(self._parent)
	self._parent:RemoveModifierByName("modifier_monster_cast_stun")
end
function modifier_monster_cast_debuff_immune.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.point = params.point
	self.damageReduction = params.damageReduction or 0
	MyGameMonsterCounterBreak:ClearWindow(self._parent)
	if self:GetRemainingTime() <= self.point then
		self:EnterCounterBreakWindow()
		return
	end
	self:StartIntervalThink(FrameTime())
end
function modifier_monster_cast_debuff_immune.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if self:GetRemainingTime() <= self.point then
		self:EnterCounterBreakWindow()
	end
end
function modifier_monster_cast_debuff_immune.prototype.EnterCounterBreakWindow(self)
	self._window_time = true
	MyGameMonsterCounterBreak:EnterWindow(self._parent)
	self:RefreshAttributes()
	self:StartIntervalThink(-1)
end
function modifier_monster_cast_debuff_immune.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DISABLE_TURNING }
end
function modifier_monster_cast_debuff_immune.prototype.GetAttributeBonus(self)
	return { damage_reduction_pct = self._window_time and 0 or self.damageReduction }
end
function modifier_monster_cast_debuff_immune.prototype.GetModifierDisableTurning(self)
	return 1
end
function modifier_monster_cast_debuff_immune.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_DEBUFF_IMMUNE] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true,
	}
end
modifier_monster_cast_debuff_immune = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_monster_cast_debuff_immune") },
	modifier_monster_cast_debuff_immune
)
____exports.modifier_monster_cast_debuff_immune = modifier_monster_cast_debuff_immune
--- 通用前摇进度条（复用 phantome_ab1 的实现思路）
-- - kv.time 表示前摇总时间
-- - kv.interruptWindow 表示前摇末尾可破招时长
-- - 魔法护盾蓝色段表示保护期，物理护盾红色段表示可破招期
-- - StackCount 表示 0~100 的进度百分比
-- - GetEffectName 播放蓄力特效，modifier 销毁时自动释放
____exports.modifier_monster_cast_pre_progress = __TS__Class()
local modifier_monster_cast_pre_progress = ____exports.modifier_monster_cast_pre_progress
modifier_monster_cast_pre_progress.name = "modifier_monster_cast_pre_progress"
__TS__ClassExtends(modifier_monster_cast_pre_progress, MonsterModifier_CS)
function modifier_monster_cast_pre_progress.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.time = 0
	self.max = 0
	self.interruptWindowPct = 0
end
function modifier_monster_cast_pre_progress.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.time = params.time or 0
	self.max = self.time or 0
	local interruptWindow = math.min(math.max(params.interruptWindow or 0, 0), self.max)
	local ____temp_12
	if self.max > 0 then
		____temp_12 = interruptWindow / self.max * 100
	else
		____temp_12 = 0
	end
	self.interruptWindowPct = ____temp_12
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
	self:SetStackCount(100)
	self:StartIntervalThink(FrameTime())
	ScreenShake(self:GetCaster():GetAbsOrigin(), 2, 10, params.time, 2000, 0, true)
	self:PlayEffect()
end
function modifier_monster_cast_pre_progress.prototype.AddCustomTransmitterData(self)
	return { interruptWindowPct = self.interruptWindowPct }
end
function modifier_monster_cast_pre_progress.prototype.HandleCustomTransmitterData(self, data)
	self.interruptWindowPct = data.interruptWindowPct or 0
end
function modifier_monster_cast_pre_progress.prototype.PlayEffect(self)
	local ability = self:GetAbility()
	local effect =
		ParticleManager:CreateParticle("particles/hero/hero_ability_bk.vpcf", PATTACH_CENTER_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(
		effect,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetCaster():GetAbsOrigin(),
		false
	)
	ParticleManager:SetParticleControlEnt(
		effect,
		1,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetCaster():GetAbsOrigin(),
		false
	)
	local cfg = ability:GetMosnterAbilityConfig()
	local castColor = cfg.castColor or Vector(255, 0, 0)
	ParticleManager:SetParticleControl(effect, 60, castColor)
	ParticleManager:SetParticleControl(effect, 61, Vector(1, 0, 0))
	ParticleManager:SetParticleShouldCheckFoW(effect, false)
	self:AddParticle(effect, false, false, -1, false, false)
end
function modifier_monster_cast_pre_progress.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self.time = self.time - FrameTime()
	local ____temp_13
	if self.max > 0 then
		____temp_13 = self.time / self.max * 100
	else
		____temp_13 = 0
	end
	local rate = ____temp_13
	self:SetStackCount(rate)
	if self.time <= 0 then
		self:Destroy()
	end
end
function modifier_monster_cast_pre_progress.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT, MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT }
end
function modifier_monster_cast_pre_progress.prototype.GetModifierIncomingPhysicalDamageConstant(self, event)
	return self:GetProgressBarValue(event, true)
end
function modifier_monster_cast_pre_progress.prototype.GetModifierIncomingSpellDamageConstant(self, event)
	return self:GetProgressBarValue(event, false)
end
function modifier_monster_cast_pre_progress.prototype.GetProgressBarValue(self, event, interruptible)
	if not IsServer() then
		if event.report_max then
			local ____interruptible_14
			if interruptible then
				____interruptible_14 = self.interruptWindowPct
			else
				____interruptible_14 = math.max(100 - self.interruptWindowPct, 0)
			end
			return ____interruptible_14
		end
		local remainingPct = math.max(self:GetStackCount(), 0)
		if interruptible then
			return math.min(remainingPct, self.interruptWindowPct)
		end
		return math.max(remainingPct - self.interruptWindowPct, 0)
	else
		return 0
	end
end
function modifier_monster_cast_pre_progress.prototype.IsHidden(self)
	return true
end
modifier_monster_cast_pre_progress = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_monster_cast_pre_progress") },
	modifier_monster_cast_pre_progress
)
____exports.modifier_monster_cast_pre_progress = modifier_monster_cast_pre_progress
____exports.modifier_monster_cast_stun = __TS__Class()
local modifier_monster_cast_stun = ____exports.modifier_monster_cast_stun
modifier_monster_cast_stun.name = "modifier_monster_cast_stun"
__TS__ClassExtends(modifier_monster_cast_stun, MonsterModifier_CS)
function modifier_monster_cast_stun.prototype.IsHidden(self)
	return true
end
function modifier_monster_cast_stun.prototype.IsDebuff(self)
	return true
end
function modifier_monster_cast_stun.prototype.IsPurgable(self)
	return false
end
function modifier_monster_cast_stun.prototype.IsPermanent(self)
	return true
end
function modifier_monster_cast_stun.prototype.RemoveOnDeath(self)
	return true
end
function modifier_monster_cast_stun.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true }
end
modifier_monster_cast_stun =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_monster_cast_stun") }, modifier_monster_cast_stun)
____exports.modifier_monster_cast_stun = modifier_monster_cast_stun
return ____exports