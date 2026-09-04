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
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__ArraySome = ____lualib.__TS__ArraySome
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local FAKE_DEATH_TOMBSTONE_PARTICLE = "particles/death_tombstonereincarn_tombstone.vpcf"
local FAKE_DEATH_DOWNED_DURATION = 1.5
local FAKE_DEATH_GHOST_MOVE_SPEED = 50
local FAKE_DEATH_GHOST_AMBIENT_EFFECT = "particles/units/heroes/hero_skeletonking/wraith_king_ghosts_ambient.vpcf"
local FAKE_DEATH_GHOST_STATUS_EFFECT = "particles/status_fx/status_effect_wraithking_ghosts.vpcf"
local FAKE_DEATH_COFFIN_MODEL = "models/heroes/wisp/wisp.vmdl"
local FAKE_DEATH_COFFIN_EFFECT = "particles/death_hero/wk_taunt_throne.vpcf"
local FAKE_DEATH_COFFIN_TURN_DEGREES_PER_SECOND = 60
--- 通用假死的视觉表现类型。
____exports.GenericFakeDeathPresentation = GenericFakeDeathPresentation or {}
____exports.GenericFakeDeathPresentation.DOWNED = 0
____exports.GenericFakeDeathPresentation[____exports.GenericFakeDeathPresentation.DOWNED] = "DOWNED"
____exports.GenericFakeDeathPresentation.GHOST = 1
____exports.GenericFakeDeathPresentation[____exports.GenericFakeDeathPresentation.GHOST] = "GHOST"
____exports.GenericFakeDeathPresentation.COFFIN = 2
____exports.GenericFakeDeathPresentation[____exports.GenericFakeDeathPresentation.COFFIN] = "COFFIN"
--- 通用假死 Buff
-- - 播放死亡动作
-- - 眩晕 + 无敌
-- - 禁止一切外部回复（DISABLE_HEALING）
-- - 支持玩家“营救”：记录营救者数量，按人数加速自然恢复
____exports.modifier_generic_fake_death = __TS__Class()
local modifier_generic_fake_death = ____exports.modifier_generic_fake_death
modifier_generic_fake_death.name = "modifier_generic_fake_death"
__TS__ClassExtends(modifier_generic_fake_death, BaseModifier_CS)
function modifier_generic_fake_death.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._rescuerIndices = {}
end
function modifier_generic_fake_death.prototype.GetAttributeBonus(self)
	return { disable_heal = 1 }
end
function modifier_generic_fake_death.prototype.IsPurgable(self)
	return false
end
function modifier_generic_fake_death.prototype.IsPurgeException(self)
	return false
end
function modifier_generic_fake_death.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._parent:Purge(false, true, false, true, true)
	local parent = self:GetParent()
	parent:SetHealth(1)
	local ____opt_result_2
	if params ~= nil then
		____opt_result_2 = params.force_ghost_presentation
	end
	local forceGhostPresentation = ____opt_result_2 == 1
	local ____opt_result_5
	if params ~= nil then
		____opt_result_5 = params.presentation
	end
	local requestedPresentation = ____opt_result_5
	local presentation = requestedPresentation == ____exports.GenericFakeDeathPresentation.COFFIN
			and ____exports.GenericFakeDeathPresentation.COFFIN
		or (
			forceGhostPresentation and ____exports.GenericFakeDeathPresentation.GHOST
			or (
				self:HasLivingTeammate(parent) and ____exports.GenericFakeDeathPresentation.COFFIN
				or ____exports.GenericFakeDeathPresentation.DOWNED
			)
		)
	self:SetStackCount(presentation)
	self._parent:StartGestureWithPlaybackRate(ACT_DOTA_DIE, 1)
	self:PlayEffect()
	self:PlayEffect2()
	if not self:CanEnterPostDownedPresentation() then
		self:PlayTombstoneEffect()
	end
	parent:AddNewModifier(
		parent,
		nil,
		"modifier_invulnerable_and_hide_health_bar",
		{ duration = FAKE_DEATH_DOWNED_DURATION }
	)
	self:Timer(0.1, function()
		SlowDownServerRate(nil, 0.35, 0.1)
	end)
	self:PlayEffect4()
	ScreenShake(parent:GetAbsOrigin(), 35, 35, 0.2, 1500, 0, true)
	EmitSoundOnClient("ui.death_stinger", PlayerResource:GetPlayer(parent:GetPlayerOwnerID()))
	self:StartIntervalThink(0.1)
	if self:CanEnterPostDownedPresentation() then
		Timers:CreateTimer(FAKE_DEATH_DOWNED_DURATION, function()
			if not IsValid(nil, self) or self:IsNull() then
				return
			end
			self:StartPostDownedPresentation()
		end)
	end
end
function modifier_generic_fake_death.prototype.PlayEffect(self)
	local parent = self:GetParent()
	local effect = ParticleManager:CreateParticle(
		"particles/econ/misc/kill_effects/default_kill_effect.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControl(effect, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(effect, 1, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(effect, 2, parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(effect)
end
function modifier_generic_fake_death.prototype.PlayEffect2(self)
	local parent = self:GetParent()
	local effect = ParticleManager:CreateParticleForPlayer(
		"particles/generic_gameplay/screen_death_indicator.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		parent,
		parent:GetPlayerOwner()
	)
	ParticleManager:SetParticleControl(effect, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(effect, 1, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(effect, 2, parent:GetAbsOrigin())
	self:AddParticle(effect, false, false, -1, false, false)
end
function modifier_generic_fake_death.prototype.PlayTombstoneEffect(self)
	local parent = self:GetParent()
	local effect = ParticleManager:CreateParticle(FAKE_DEATH_TOMBSTONE_PARTICLE, PATTACH_WORLDORIGIN, parent)
	ParticleManager:SetParticleControl(effect, 0, GetGroundPosition(parent:GetAbsOrigin(), parent))
	self:AddParticle(effect, false, false, -1, false, false)
end
function modifier_generic_fake_death.prototype.PlayEffect4(self)
	local parent = self:GetParent()
	local effect = ParticleManager:CreateParticleForPlayer(
		"particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_death_hole.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		parent,
		parent:GetPlayerOwner()
	)
	ParticleManager:SetParticleControl(effect, 0, parent:GetAbsOrigin())
	self:AddParticle(effect, false, false, -1, false, false)
end
function modifier_generic_fake_death.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	if not IsValid(nil, self._parent) or self._parent:IsNull() then
		return
	end
	____exports.modifier_generic_fake_death_ghost_presentation:remove(self._parent)
	____exports.modifier_generic_fake_death_coffin_presentation:remove(self._parent)
	self._parent:FadeGesture(ACT_DOTA_DIE)
	self._parent:Stop()
	self._parent:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 1)
	self:PlayEffect3()
	self:GetParent()
		:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_generic_fake_death_invulnerable",
			{ duration = 3 }
		)
end
function modifier_generic_fake_death.prototype.PlayEffect3(self)
	local parent = self:GetParent()
	local effect =
		ParticleManager:CreateParticle("particles/generic_hero_status/respawn.vpcf", PATTACH_CENTER_FOLLOW, parent)
	ParticleManager:SetParticleControl(effect, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(effect, 1, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(effect, 2, parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(effect)
end
function modifier_generic_fake_death.prototype.AddRescuer(self, rescuerIndex)
	if not IsServer() then
		return
	end
	if not rescuerIndex or rescuerIndex <= 0 then
		return
	end
	if __TS__ArrayIndexOf(self._rescuerIndices, rescuerIndex) ~= -1 then
		return
	end
	local ____self__rescuerIndices_6 = self._rescuerIndices
	____self__rescuerIndices_6[#____self__rescuerIndices_6 + 1] = rescuerIndex
end
function modifier_generic_fake_death.prototype.RemoveRescuer(self, rescuerIndex)
	if not IsServer() then
		return
	end
	if not rescuerIndex or rescuerIndex <= 0 then
		return
	end
	local idx = __TS__ArrayIndexOf(self._rescuerIndices, rescuerIndex)
	if idx == -1 then
		return
	end
	__TS__ArraySplice(self._rescuerIndices, idx, 1)
end
function modifier_generic_fake_death.prototype.PruneInvalidRescuers(self, parent)
	local validRescuerIndices = {}
	for ____, rescuerIndex in ipairs(self._rescuerIndices) do
		do
			local rescuer = EntIndexToHScript(rescuerIndex)
			if not rescuer or not IsValid(nil, rescuer) or rescuer:IsNull() or not IsValidAlive(nil, rescuer) then
				goto __continue29
			end
			if rescuer:GetTeamNumber() ~= parent:GetTeamNumber() then
				goto __continue29
			end
			local rescueModifier = rescuer:FindModifierByName("modifier_rescue")
			if not rescueModifier or rescueModifier:GetCaster() ~= parent then
				goto __continue29
			end
			validRescuerIndices[#validRescuerIndices + 1] = rescuerIndex
		end
		::__continue29::
	end
	self._rescuerIndices = validRescuerIndices
	return #validRescuerIndices
end
function modifier_generic_fake_death.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		self:Destroy()
		return
	end
	local rescuerCount = self:PruneInvalidRescuers(parent)
	if rescuerCount <= 0 then
		local maxHp = parent:GetMaxHealth()
		local curHp = parent:GetHealth()
		if curHp / maxHp >= 0.03 then
			parent:SetHealth(curHp - math.max(1, maxHp * 0.005))
		end
		return
	end
	local maxHp = parent:GetMaxHealth()
	local curHp = parent:GetHealth()
	if curHp / maxHp >= 0.98 then
		self:Destroy()
		return
	end
	local healPctPerSecond = 0.03 * rescuerCount
	local healAmount = maxHp * healPctPerSecond
	local newHp = curHp + healAmount
	if newHp >= maxHp then
		newHp = maxHp
		parent:SetHealth(newHp)
		self:Destroy()
	else
		parent:SetHealth(newHp)
	end
end
function modifier_generic_fake_death.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_DISABLE_HEALING }
end
function modifier_generic_fake_death.prototype.GetDisableHealing(self)
	return 1
end
function modifier_generic_fake_death.prototype.GetOverrideAnimation(self)
	local ____table_IsDownedPhase_result_7
	if self:IsDownedPhase() then
		____table_IsDownedPhase_result_7 = ACT_DOTA_DIE
	else
		____table_IsDownedPhase_result_7 = ACT_DOTA_RUN
	end
	return ____table_IsDownedPhase_result_7
end
function modifier_generic_fake_death.prototype.CheckState(self)
	local isDownedPhase = self:IsDownedPhase()
	return {
		[MODIFIER_STATE_STUNNED] = isDownedPhase,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_FROZEN] = isDownedPhase and self:GetElapsedTime() >= 1.1,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function modifier_generic_fake_death.prototype.IsHidden(self)
	return true
end
function modifier_generic_fake_death.prototype.IsDebuff(self)
	return false
end
function modifier_generic_fake_death.prototype.StartPostDownedPresentation(self)
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	if parent:FindModifierByName("modifier_generic_fake_death") ~= self then
		return
	end
	if not self:CanEnterPostDownedPresentation() then
		return
	end
	self:ForceRefresh()
	if self:GetPostDownedPresentation() == ____exports.GenericFakeDeathPresentation.COFFIN then
		____exports.modifier_generic_fake_death_coffin_presentation:applys(parent, parent, self:GetAbility(), {})
		return
	end
	____exports.modifier_generic_fake_death_ghost_presentation:applys(parent, parent, self:GetAbility(), {})
end
function modifier_generic_fake_death.prototype.HasLivingTeammate(self, parent)
	local playerId = parent:GetPlayerOwnerID()
	if playerId < 0 then
		return false
	end
	local room = MyGameRoomManager and MyGameRoomManager:GetPlayerRoom(playerId)
	local ____opt_10 = room
	local ____temp_14 = ____opt_10
		and __TS__ArraySome(room and room:GetAlivePlayers(), function(____, roomPlayerId)
			return roomPlayerId ~= playerId
		end)
	if ____temp_14 == nil then
		____temp_14 = false
	end
	return ____temp_14
end
function modifier_generic_fake_death.prototype.GetPostDownedPresentation(self)
	return self:GetStackCount()
end
function modifier_generic_fake_death.prototype.CanEnterPostDownedPresentation(self)
	local presentation = self:GetPostDownedPresentation()
	return presentation == ____exports.GenericFakeDeathPresentation.GHOST
		or presentation == ____exports.GenericFakeDeathPresentation.COFFIN
end
function modifier_generic_fake_death.prototype.IsDownedPhase(self)
	return not self:CanEnterPostDownedPresentation() or self:GetElapsedTime() < FAKE_DEATH_DOWNED_DURATION
end
modifier_generic_fake_death = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_generic_fake_death)
____exports.modifier_generic_fake_death = modifier_generic_fake_death
--- 通用假死附属的绿魂表现 Buff，仅负责特效与移动能力。
____exports.modifier_generic_fake_death_ghost_presentation = __TS__Class()
local modifier_generic_fake_death_ghost_presentation = ____exports.modifier_generic_fake_death_ghost_presentation
modifier_generic_fake_death_ghost_presentation.name = "modifier_generic_fake_death_ghost_presentation"
__TS__ClassExtends(modifier_generic_fake_death_ghost_presentation, BaseModifier_CS)
function modifier_generic_fake_death_ghost_presentation.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.stoppingFromOrder = false
end
function modifier_generic_fake_death_ghost_presentation.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:GetParent():FadeGesture(ACT_DOTA_DIE)
	self:ApplyWearableGhostEffects()
end
function modifier_generic_fake_death_ghost_presentation.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:RemoveWearableGhostEffects()
end
function modifier_generic_fake_death_ghost_presentation.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE, MODIFIER_EVENT_ON_ORDER }
end
function modifier_generic_fake_death_ghost_presentation.prototype.OnOrder(self, event)
	if not IsServer() or event.unit ~= self:GetParent() then
		return
	end
	if event.order_type ~= DOTA_UNIT_ORDER_STOP and event.order_type ~= DOTA_UNIT_ORDER_HOLD_POSITION then
		return
	end
	if self.stoppingFromOrder then
		return
	end
	self.stoppingFromOrder = true
	self:GetParent():Stop()
	self.stoppingFromOrder = false
end
function modifier_generic_fake_death_ghost_presentation.prototype.GetModifierMoveSpeed_Absolute(self)
	return FAKE_DEATH_GHOST_MOVE_SPEED
end
function modifier_generic_fake_death_ghost_presentation.prototype.GetEffectName(self)
	return FAKE_DEATH_GHOST_AMBIENT_EFFECT
end
function modifier_generic_fake_death_ghost_presentation.prototype.GetStatusEffectName(self)
	return FAKE_DEATH_GHOST_STATUS_EFFECT
end
function modifier_generic_fake_death_ghost_presentation.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_generic_fake_death_ghost_presentation.prototype.IsHidden(self)
	return true
end
function modifier_generic_fake_death_ghost_presentation.prototype.IsPurgable(self)
	return false
end
function modifier_generic_fake_death_ghost_presentation.prototype.IsPurgeException(self)
	return false
end
function modifier_generic_fake_death_ghost_presentation.prototype.ApplyWearableGhostEffects(self)
	local parent = self:GetParent()
	local ____opt_15 = parent.GetManagedWearableUnits
	for ____, wearable in ipairs(____opt_15 and ____opt_15(parent) or {}) do
		do
			if not wearable or not IsValid(nil, wearable) or wearable:IsNull() then
				goto __continue76
			end
			____exports.modifier_generic_fake_death_wearable_ghost:applys(wearable, parent, self:GetAbility(), {})
		end
		::__continue76::
	end
end
function modifier_generic_fake_death_ghost_presentation.prototype.RemoveWearableGhostEffects(self)
	local parent = self:GetParent()
	local ____opt_17 = parent.GetManagedWearableUnits
	for ____, wearable in ipairs(____opt_17 and ____opt_17(parent) or {}) do
		do
			if not wearable or not IsValid(nil, wearable) or wearable:IsNull() then
				goto __continue80
			end
			____exports.modifier_generic_fake_death_wearable_ghost:remove(wearable)
		end
		::__continue80::
	end
end
modifier_generic_fake_death_ghost_presentation =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_generic_fake_death_ghost_presentation)
____exports.modifier_generic_fake_death_ghost_presentation = modifier_generic_fake_death_ghost_presentation
--- 通用假死附属的棺材表现 Buff，仅负责 WISP 外观、棺材特效与受限转向。
____exports.modifier_generic_fake_death_coffin_presentation = __TS__Class()
local modifier_generic_fake_death_coffin_presentation = ____exports.modifier_generic_fake_death_coffin_presentation
modifier_generic_fake_death_coffin_presentation.name = "modifier_generic_fake_death_coffin_presentation"
__TS__ClassExtends(modifier_generic_fake_death_coffin_presentation, BaseModifier_CS)
function modifier_generic_fake_death_coffin_presentation.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.stoppingFromOrder = false
end
function modifier_generic_fake_death_coffin_presentation.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	parent:FadeGesture(ACT_DOTA_DIE)
	parent:AddNoDrawToManagedWearables()
	self:PlayCoffinEffect(parent)
	self:StartIntervalThink(FrameTime())
end
function modifier_generic_fake_death_coffin_presentation.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	self:ClearFacingTarget()
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	parent:RemoveNoDrawFromManagedWearables()
end
function modifier_generic_fake_death_coffin_presentation.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_DISABLE_TURNING,
		MODIFIER_EVENT_ON_ORDER,
	}
end
function modifier_generic_fake_death_coffin_presentation.prototype.GetModifierMoveSpeed_Absolute(self)
	return FAKE_DEATH_GHOST_MOVE_SPEED
end
function modifier_generic_fake_death_coffin_presentation.prototype.GetModifierModelChange(self)
	return FAKE_DEATH_COFFIN_MODEL
end
function modifier_generic_fake_death_coffin_presentation.prototype.GetModifierDisableTurning(self)
	return 1
end
function modifier_generic_fake_death_coffin_presentation.prototype.OnOrder(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.unit ~= parent then
		return
	end
	if event.order_type == DOTA_UNIT_ORDER_STOP or event.order_type == DOTA_UNIT_ORDER_HOLD_POSITION then
		self:ClearFacingTarget()
		if self.stoppingFromOrder then
			return
		end
		self.stoppingFromOrder = true
		parent:Stop()
		self.stoppingFromOrder = false
		return
	end
	local target = self:ResolveOrderTargetUnit(event)
	if target and self:OrderTypeShouldFaceTarget(event.order_type) then
		self.facingTargetUnit = target
		self.facingTargetPosition = nil
		return
	end
	if event.new_pos then
		self.facingTargetUnit = nil
		self.facingTargetPosition = event.new_pos
	end
end
function modifier_generic_fake_death_coffin_presentation.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) or parent:IsNull() then
		self:Destroy()
		return
	end
	local targetPosition = self:GetFacingTargetPosition()
	if not targetPosition then
		return
	end
	self:RotateTowardTarget(parent, targetPosition)
end
function modifier_generic_fake_death_coffin_presentation.prototype.IsHidden(self)
	return true
end
function modifier_generic_fake_death_coffin_presentation.prototype.IsPurgable(self)
	return false
end
function modifier_generic_fake_death_coffin_presentation.prototype.IsPurgeException(self)
	return false
end
function modifier_generic_fake_death_coffin_presentation.prototype.PlayCoffinEffect(self, parent)
	local effect = ParticleManager:CreateParticle(FAKE_DEATH_COFFIN_EFFECT, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		effect,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(effect, 2, Vector(1, 0, 0))
	ParticleManager:SetParticleControl(effect, 3, Vector(2, 0, 0))
	ParticleManager:SetParticleControl(effect, 4, Vector(3, 0, 0))
	ParticleManager:SetParticleControl(effect, 5, Vector(4, 0, 0))
	ParticleManager:SetParticleControl(effect, 7, Vector(1, 0, 0))
	ParticleManager:SetParticleControl(effect, 8, Vector(99, 0, 0))
	self:AddParticle(effect, false, false, -1, false, false)
end
function modifier_generic_fake_death_coffin_presentation.prototype.ResolveOrderTargetUnit(self, event)
	local orderEvent = event
	local targetIndex = orderEvent.entindex_target
	if targetIndex ~= nil and targetIndex > 0 then
		local target = EntIndexToHScript(targetIndex)
		if target and IsValid(nil, target) and not target:IsNull() and target:IsBaseNPC() then
			return target
		end
	end
	local target = orderEvent.target
	if target and IsValid(nil, target) and not target:IsNull() and target:IsBaseNPC() then
		return target
	end
	return nil
end
function modifier_generic_fake_death_coffin_presentation.prototype.OrderTypeShouldFaceTarget(self, orderType)
	return orderType == DOTA_UNIT_ORDER_ATTACK_TARGET
		or orderType == DOTA_UNIT_ORDER_MOVE_TO_TARGET
		or orderType == DOTA_UNIT_ORDER_CAST_TARGET
		or orderType == DOTA_UNIT_ORDER_CAST_TARGET_TREE
		or orderType == DOTA_UNIT_ORDER_ATTACK_MOVE
end
function modifier_generic_fake_death_coffin_presentation.prototype.GetFacingTargetPosition(self)
	if self.facingTargetUnit then
		if IsValid(nil, self.facingTargetUnit) and not self.facingTargetUnit:IsNull() then
			return self.facingTargetUnit:GetAbsOrigin()
		end
		self.facingTargetUnit = nil
	end
	return self.facingTargetPosition
end
function modifier_generic_fake_death_coffin_presentation.prototype.RotateTowardTarget(self, parent, targetPosition)
	local direction = targetPosition:__sub(parent:GetAbsOrigin())
	direction.z = 0
	if direction:Length2D() <= 0.01 then
		return
	end
	local targetForward = direction:Normalized()
	local currentForward = parent:GetForwardVector()
	currentForward.z = 0
	if currentForward:Length2D() <= 0.01 then
		parent:SetForwardVector(targetForward)
		return
	end
	local normalizedCurrentForward = currentForward:Normalized()
	local cross = normalizedCurrentForward.x * targetForward.y - normalizedCurrentForward.y * targetForward.x
	local dot = math.max(
		-1,
		math.min(1, normalizedCurrentForward.x * targetForward.x + normalizedCurrentForward.y * targetForward.y)
	)
	local deltaDegrees = math.atan2(cross, dot) * (180 / math.pi)
	local maxStepDegrees = FAKE_DEATH_COFFIN_TURN_DEGREES_PER_SECOND * FrameTime()
	local stepDegrees = math.max(-maxStepDegrees, math.min(maxStepDegrees, deltaDegrees))
	parent:SetForwardVector(RotateVector2D(nil, normalizedCurrentForward, stepDegrees):Normalized())
end
function modifier_generic_fake_death_coffin_presentation.prototype.ClearFacingTarget(self)
	self.facingTargetUnit = nil
	self.facingTargetPosition = nil
end
modifier_generic_fake_death_coffin_presentation =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_generic_fake_death_coffin_presentation)
____exports.modifier_generic_fake_death_coffin_presentation = modifier_generic_fake_death_coffin_presentation
--- 通用假死附属的饰品绿魂状态特效，仅承载状态特效。
____exports.modifier_generic_fake_death_wearable_ghost = __TS__Class()
local modifier_generic_fake_death_wearable_ghost = ____exports.modifier_generic_fake_death_wearable_ghost
modifier_generic_fake_death_wearable_ghost.name = "modifier_generic_fake_death_wearable_ghost"
__TS__ClassExtends(modifier_generic_fake_death_wearable_ghost, BaseModifier_CS)
function modifier_generic_fake_death_wearable_ghost.prototype.GetStatusEffectName(self)
	return FAKE_DEATH_GHOST_STATUS_EFFECT
end
function modifier_generic_fake_death_wearable_ghost.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_generic_fake_death_wearable_ghost.prototype.IsHidden(self)
	return true
end
function modifier_generic_fake_death_wearable_ghost.prototype.IsPurgable(self)
	return false
end
function modifier_generic_fake_death_wearable_ghost.prototype.IsPurgeException(self)
	return false
end
modifier_generic_fake_death_wearable_ghost =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_generic_fake_death_wearable_ghost)
____exports.modifier_generic_fake_death_wearable_ghost = modifier_generic_fake_death_wearable_ghost
--- 复活后的无敌buff
____exports.modifier_generic_fake_death_invulnerable = __TS__Class()
local modifier_generic_fake_death_invulnerable = ____exports.modifier_generic_fake_death_invulnerable
modifier_generic_fake_death_invulnerable.name = "modifier_generic_fake_death_invulnerable"
__TS__ClassExtends(modifier_generic_fake_death_invulnerable, BaseModifier_CS)
function modifier_generic_fake_death_invulnerable.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
end
function modifier_generic_fake_death_invulnerable.prototype.GetStatusEffectName(self)
	return "particles/status_fx/status_effect_dark_willow_shadow_realm.vpcf"
end
function modifier_generic_fake_death_invulnerable.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
function modifier_generic_fake_death_invulnerable.prototype.DeclareFunctions(self)
	return { MODIFIER_EVENT_ON_ORDER }
end
function modifier_generic_fake_death_invulnerable.prototype.OnOrder(self, event)
	if not IsServer() then
		return
	end
	if event.unit == self:GetParent() then
		self:Destroy()
	end
end
modifier_generic_fake_death_invulnerable =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_generic_fake_death_invulnerable)
____exports.modifier_generic_fake_death_invulnerable = modifier_generic_fake_death_invulnerable
return ____exports