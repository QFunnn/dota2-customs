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
local ____base_ability = require("abilities._base.base_ability")
local BaseAbility_CS = ____base_ability.BaseAbility_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____Sync = require("modules.Sync")
local SyncGameEvent = ____Sync.SyncGameEvent
local MINI_GAME_AVATAR_DEFAULT_FULL_CHARGE_DURATION = 3
local MINI_GAME_AVATAR_MIN_FULL_CHARGE_DURATION = 2.5
local MINI_GAME_AVATAR_MAX_FULL_CHARGE_DURATION = 3.5
local MINI_GAME_AVATAR_MIN_JUMP_DISTANCE = 180
local MINI_GAME_AVATAR_MAX_JUMP_DISTANCE = 700
local MINI_GAME_AVATAR_JUMP_DURATION = 0.35
local MINI_GAME_AVATAR_JUMP_COOLDOWN = MINI_GAME_AVATAR_JUMP_DURATION
local MINI_GAME_AVATAR_JUMP_HEIGHT = 120
local MINI_GAME_AVATAR_LANDING_PREVIEW_PARTICLE = "particles/lizi/ui_mouseactions/range_finder_targeted_aoe_b1.vpcf"
local MINI_GAME_AVATAR_CHARGE_ABILITY_NAME = "minigame_avatar_charge"
local MINI_GAME_AVATAR_KNOCKBACK_MODIFIER = "modifier_knockback_custom_power"
local MINI_GAME_AVATAR_STOP_ABILITY_NAME = "minigame_avatar_stop_charge"
local MINI_GAME_AVATAR_CHARGE_CHANNEL_ID_PREFIX = "minigame_avatar_charge"
local MINI_GAME_AVATAR_CHARGE_LABEL = "蓄力跳跃"
local MINI_GAME_AVATAR_SNAPFIRE_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_snapfire.vsndevts"
local MINI_GAME_AVATAR_CHARGE_START_SOUND = "Hero_Snapfire.FeedCookie.Consume"
local MINI_GAME_AVATAR_JUMP_START_SOUND = "Hero_Snapfire.FeedCookie.Cast"
local MINI_GAME_AVATAR_LAND_SUCCESS_SOUND = "Hero_Snapfire.FeedCookie.Impact"
local MINI_GAME_AVATAR_LAND_FAILED_SOUND = "Hero_Snapfire.SpitOut.Projectile"
____exports.minigame_avatar_charge = __TS__Class()
local minigame_avatar_charge = ____exports.minigame_avatar_charge
minigame_avatar_charge.name = "minigame_avatar_charge"
__TS__ClassExtends(minigame_avatar_charge, BaseAbility_CS)
function minigame_avatar_charge.prototype.____constructor(self, ...)
	BaseAbility_CS.prototype.____constructor(self, ...)
	self.chargeStartTime = 0
	self.fullChargeDuration = MINI_GAME_AVATAR_DEFAULT_FULL_CHARGE_DURATION
	self.isCharging = false
end
function minigame_avatar_charge.prototype.Precache(self, context)
	PrecacheResource("particle", MINI_GAME_AVATAR_LANDING_PREVIEW_PARTICLE, context)
	PrecacheResource("soundfile", MINI_GAME_AVATAR_SNAPFIRE_SOUND_EVENTS, context)
end
function minigame_avatar_charge.prototype.GetAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0.01,
		cooldown = MINI_GAME_AVATAR_JUMP_COOLDOWN,
		manaCost = 0,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
	}
end
function minigame_avatar_charge.prototype.OnAbilityPhaseStart(self)
	if IsServer() then
		self.fullChargeDuration = self:RollFullChargeDuration()
	end
	return true
end
function minigame_avatar_charge.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if caster:HasModifier(____exports.modifier_minigame_avatar_jump.name) then
		return
	end
	if ____exports.modifier_minigame_avatar_charging:find_on(caster) then
		return
	end
	self.chargeStartTime = GameRules:GetGameTime()
	self.isCharging = true
	____exports.modifier_minigame_avatar_charging:applys(
		caster,
		caster,
		self,
		{ duration = -1, charge_duration = self.fullChargeDuration }
	)
	if MyGameMiniGame ~= nil then
		MyGameMiniGame:NotifyAvatarChargeStart(caster, self)
	end
	EmitSoundOn(MINI_GAME_AVATAR_CHARGE_START_SOUND, caster)
end
function minigame_avatar_charge.prototype.FinishCustomCharge(self, caster)
	if not IsServer() then
		return
	end
	if not self.isCharging then
		return
	end
	self.isCharging = false
	local fallbackChargeDuration = math.max(0, GameRules:GetGameTime() - self.chargeStartTime)
	local chargeDuration = MyGameMiniGame and MyGameMiniGame:NotifyAvatarChargeStop(caster, self, false)
		or fallbackChargeDuration
	self:JumpForward(caster, chargeDuration, self.fullChargeDuration)
end
function minigame_avatar_charge.prototype.CancelCustomCharge(self, caster, interrupted)
	if not IsServer() then
		return
	end
	if not self.isCharging then
		return
	end
	self.isCharging = false
	if MyGameMiniGame ~= nil then
		MyGameMiniGame:NotifyAvatarChargeStop(caster, self, interrupted)
	end
end
function minigame_avatar_charge.prototype.JumpForward(self, caster, chargeDuration, fullChargeDuration)
	if not IsValidAlive(nil, caster) then
		return
	end
	if chargeDuration <= 0 then
		return
	end
	local chargeRate = math.min(chargeDuration / math.max(0.03, fullChargeDuration), 1)
	local distance = MINI_GAME_AVATAR_MIN_JUMP_DISTANCE
		+ (MINI_GAME_AVATAR_MAX_JUMP_DISTANCE - MINI_GAME_AVATAR_MIN_JUMP_DISTANCE) * chargeRate
	____exports.modifier_minigame_avatar_jump:remove(caster)
	self:EndCooldown()
	self:StartCooldown(MINI_GAME_AVATAR_JUMP_COOLDOWN)
	EmitSoundOn(MINI_GAME_AVATAR_JUMP_START_SOUND, caster)
	____exports.modifier_minigame_avatar_jump:applys(
		caster,
		caster,
		self,
		{ duration = MINI_GAME_AVATAR_JUMP_DURATION, distance = distance, height = MINI_GAME_AVATAR_JUMP_HEIGHT }
	)
end
function minigame_avatar_charge.prototype.RollFullChargeDuration(self)
	return RandomFloat(MINI_GAME_AVATAR_MIN_FULL_CHARGE_DURATION, MINI_GAME_AVATAR_MAX_FULL_CHARGE_DURATION)
end
minigame_avatar_charge = __TS__DecorateLegacy({ registerAbility(nil) }, minigame_avatar_charge)
____exports.minigame_avatar_charge = minigame_avatar_charge
____exports.minigame_avatar_stop_charge = __TS__Class()
local minigame_avatar_stop_charge = ____exports.minigame_avatar_stop_charge
minigame_avatar_stop_charge.name = "minigame_avatar_stop_charge"
__TS__ClassExtends(minigame_avatar_stop_charge, BaseAbility_CS)
function minigame_avatar_stop_charge.prototype.GetAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING,
		castPoint = 0,
		cooldown = 0,
		manaCost = 0,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
	}
end
function minigame_avatar_stop_charge.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local chargeModifier = ____exports.modifier_minigame_avatar_charging:find_on(caster)
	if not chargeModifier then
		return
	end
	chargeModifier:FinishCharge()
end
minigame_avatar_stop_charge = __TS__DecorateLegacy({ registerAbility(nil) }, minigame_avatar_stop_charge)
____exports.minigame_avatar_stop_charge = minigame_avatar_stop_charge
____exports.modifier_minigame_avatar_charging = __TS__Class()
local modifier_minigame_avatar_charging = ____exports.modifier_minigame_avatar_charging
modifier_minigame_avatar_charging.name = "modifier_minigame_avatar_charging"
__TS__ClassExtends(modifier_minigame_avatar_charging, BaseModifier_CS)
function modifier_minigame_avatar_charging.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.chargeDuration = MINI_GAME_AVATAR_DEFAULT_FULL_CHARGE_DURATION
	self.shouldJump = false
	self.chargeInterrupted = true
	self.channelId = MINI_GAME_AVATAR_CHARGE_CHANNEL_ID_PREFIX
end
function modifier_minigame_avatar_charging.prototype.IsHidden(self)
	return true
end
function modifier_minigame_avatar_charging.prototype.IsPurgable(self)
	return false
end
function modifier_minigame_avatar_charging.prototype.DeclareFunctions(self)
	return { MODIFIER_EVENT_ON_ORDER }
end
function modifier_minigame_avatar_charging.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.chargeDuration =
		math.max(0.03, tonumber(params and params.charge_duration) or MINI_GAME_AVATAR_DEFAULT_FULL_CHARGE_DURATION)
	self.channelId = (MINI_GAME_AVATAR_CHARGE_CHANNEL_ID_PREFIX .. "_") .. tostring(self:GetParent():entindex())
	self:StartIntervalThink(0.03)
	self:SendChargeBarPlay()
	self:CreateLandingPreviewParticle()
	self:UpdateLandingPreviewParticle()
end
function modifier_minigame_avatar_charging.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	local parent = self:GetParent()
	if not ability or not parent or not IsValid(nil, parent) or parent:IsNull() then
		self:Destroy()
		return
	end
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	self:UpdateLandingPreviewParticle()
	if GameRules:GetGameTime() - self:GetCreationTime() >= self.chargeDuration then
		self:FinishCharge()
	end
end
function modifier_minigame_avatar_charging.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:SendChargeBarStop(self.chargeInterrupted)
	self:DestroyLandingPreviewParticle()
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not parent or not IsValid(nil, parent) or parent:IsNull() or not ability or not IsValid(nil, ability) then
		return
	end
	if not self.shouldJump then
		ability:CancelCustomCharge(parent, self.chargeInterrupted)
		return
	end
	ability:FinishCustomCharge(parent)
end
function modifier_minigame_avatar_charging.prototype.OnOrder(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.unit ~= parent then
		return
	end
	if event.order_type == DOTA_UNIT_ORDER_STOP then
		self:FinishCharge()
		return
	end
	local abilityEvent = event
	local ability = abilityEvent.ability
	if
		event.order_type == DOTA_UNIT_ORDER_CAST_NO_TARGET
		and ability
		and ability:GetAbilityName() == MINI_GAME_AVATAR_STOP_ABILITY_NAME
	then
		return
	end
	local facingPoint = self:ResolveFacingPointFromOrder(event)
	if facingPoint then
		self:FaceTowardPoint(parent, facingPoint)
	end
end
function modifier_minigame_avatar_charging.prototype.FinishCharge(self)
	if self.shouldJump then
		return
	end
	self.shouldJump = true
	self.chargeInterrupted = false
	self:Destroy()
end
function modifier_minigame_avatar_charging.prototype.SendChargeBarPlay(self)
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	local playerId = parent:GetPlayerOwnerID()
	local player = PlayerResource:GetPlayer(playerId)
	if not player then
		return
	end
	local ability = self:GetAbility()
	local ____SyncGameEvent_12 = SyncGameEvent
	local ____SyncGameEvent_Send_ServerToPlayer_13 = SyncGameEvent.Send_ServerToPlayer
	local ____self_channelId_9 = self.channelId
	local ____self_chargeDuration_10 = self.chargeDuration
	local ____temp_11 = GameRules:GetGameTime()
	local ____temp_8
	if ability and IsValid(nil, ability) then
		____temp_8 = ability:entindex()
	else
		____temp_8 = nil
	end
	____SyncGameEvent_Send_ServerToPlayer_13(____SyncGameEvent_12, player, "s2c_custom_channel_bar_play", {
		action = "play",
		channel_id = ____self_channelId_9,
		channel_time = ____self_chargeDuration_10,
		start_time = ____temp_11,
		is_slow_channel = true,
		context_entity_index = ____temp_8,
		icon_type = "ability",
		show_icon = MINI_GAME_AVATAR_CHARGE_ABILITY_NAME,
		label = MINI_GAME_AVATAR_CHARGE_LABEL,
	})
end
function modifier_minigame_avatar_charging.prototype.SendChargeBarStop(self, interrupted)
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	local playerId = parent:GetPlayerOwnerID()
	local player = PlayerResource:GetPlayer(playerId)
	if not player then
		return
	end
	SyncGameEvent:Send_ServerToPlayer(
		player,
		"s2c_custom_channel_bar_play",
		{ action = "stop", channel_id = self.channelId, channel_time = 0, interrupted = interrupted }
	)
end
function modifier_minigame_avatar_charging.prototype.CreateLandingPreviewParticle(self)
	self:DestroyLandingPreviewParticle()
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	local landingPosition = self:GetCurrentLandingPreviewPosition(parent, parent:GetAbsOrigin())
	local thinker = CreateModifierThinker(
		parent,
		nil,
		"modifier_dummy_thinker",
		{ duration = self.chargeDuration + 1 },
		landingPosition,
		parent:GetTeamNumber(),
		false
	)
	if not thinker or not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	self.landingPreviewThinker = thinker
	self.landingPreviewParticle =
		ParticleManager:CreateParticle(MINI_GAME_AVATAR_LANDING_PREVIEW_PARTICLE, PATTACH_POINT, parent)
	ParticleManager:SetParticleShouldCheckFoW(self.landingPreviewParticle, false)
	ParticleManager:SetParticleControl(self.landingPreviewParticle, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(
		self.landingPreviewParticle,
		1,
		thinker,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		false
	)
end
function modifier_minigame_avatar_charging.prototype.DestroyLandingPreviewParticle(self)
	if self.landingPreviewParticle ~= nil then
		ParticleManager:DestroyParticle(self.landingPreviewParticle, false)
		ParticleManager:ReleaseParticleIndex(self.landingPreviewParticle)
		self.landingPreviewParticle = nil
	end
	if
		self.landingPreviewThinker
		and IsValid(nil, self.landingPreviewThinker)
		and not self.landingPreviewThinker:IsNull()
	then
		self.landingPreviewThinker:RemoveSelf()
	end
	self.landingPreviewThinker = nil
end
function modifier_minigame_avatar_charging.prototype.UpdateLandingPreviewParticle(self)
	if self.landingPreviewParticle == nil or not self.landingPreviewThinker then
		return
	end
	local parent = self:GetParent()
	local thinker = self.landingPreviewThinker
	if not parent or not IsValid(nil, parent) or parent:IsNull() or not IsValid(nil, thinker) or thinker:IsNull() then
		self:DestroyLandingPreviewParticle()
		return
	end
	local origin = parent:GetAbsOrigin()
	local landingPosition = self:GetCurrentLandingPreviewPosition(parent, origin)
	thinker:SetAbsOrigin(landingPosition)
	ParticleManager:SetParticleControl(self.landingPreviewParticle, 0, origin)
end
function modifier_minigame_avatar_charging.prototype.GetCurrentLandingPreviewPosition(self, parent, origin)
	local elapsed = math.max(0, GameRules:GetGameTime() - self:GetCreationTime())
	local chargeRate = math.min(elapsed / self.chargeDuration, 1)
	local distance = MINI_GAME_AVATAR_MIN_JUMP_DISTANCE
		+ (MINI_GAME_AVATAR_MAX_JUMP_DISTANCE - MINI_GAME_AVATAR_MIN_JUMP_DISTANCE) * chargeRate
	local forward = self:GetCurrentForward(parent)
	return Vector(origin.x + forward.x * distance, origin.y + forward.y * distance, origin.z)
end
function modifier_minigame_avatar_charging.prototype.GetCurrentForward(self, parent)
	local forward = parent:GetForwardVector()
	forward.z = 0
	if forward:Length2D() <= 0.01 then
		return Vector(1, 0, 0)
	end
	return forward:Normalized()
end
function modifier_minigame_avatar_charging.prototype.ResolveFacingPointFromOrder(self, event)
	local abilityEvent = event
	local target = self:ResolveOrderTargetUnit(abilityEvent)
	if target and self:OrderTypeShouldFaceTarget(event.order_type) then
		return target:GetAbsOrigin()
	end
	if event.new_pos then
		return event.new_pos
	end
	return nil
end
function modifier_minigame_avatar_charging.prototype.ResolveOrderTargetUnit(self, event)
	local idx = event.entindex_target
	if idx ~= nil and idx > 0 then
		local ent = EntIndexToHScript(idx)
		if IsValid(nil, ent) and not ent:IsNull() and ent:IsBaseNPC() then
			return ent
		end
	end
	local target = event.target
	if target and IsValid(nil, target) and not target:IsNull() and target:IsBaseNPC() then
		return target
	end
	return nil
end
function modifier_minigame_avatar_charging.prototype.OrderTypeShouldFaceTarget(self, orderType)
	return orderType == DOTA_UNIT_ORDER_ATTACK_TARGET
		or orderType == DOTA_UNIT_ORDER_MOVE_TO_TARGET
		or orderType == DOTA_UNIT_ORDER_CAST_TARGET
		or orderType == DOTA_UNIT_ORDER_CAST_TARGET_TREE
		or orderType == DOTA_UNIT_ORDER_ATTACK_MOVE
end
function modifier_minigame_avatar_charging.prototype.FaceTowardPoint(self, parent, point)
	local origin = parent:GetAbsOrigin()
	local direction = point:__sub(origin)
	direction.z = 0
	if direction:Length2D() <= 0.01 then
		return
	end
	parent:SetForwardVector(direction:Normalized())
	self:UpdateLandingPreviewParticle()
end
modifier_minigame_avatar_charging = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_minigame_avatar_charging)
____exports.modifier_minigame_avatar_charging = modifier_minigame_avatar_charging
____exports.modifier_minigame_avatar_jump = __TS__Class()
local modifier_minigame_avatar_jump = ____exports.modifier_minigame_avatar_jump
modifier_minigame_avatar_jump.name = "modifier_minigame_avatar_jump"
__TS__ClassExtends(modifier_minigame_avatar_jump, BaseModifier_CS)
function modifier_minigame_avatar_jump.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.startTime = 0
	self.startPosition = Vector(0, 0, 0)
	self.forward = Vector(1, 0, 0)
	self.distance = 0
	self.jumpDuration = MINI_GAME_AVATAR_JUMP_DURATION
	self.height = MINI_GAME_AVATAR_JUMP_HEIGHT
	self.finishedNaturally = false
	self.finalFlatPosition = Vector(0, 0, 0)
end
function modifier_minigame_avatar_jump.prototype.IsHidden(self)
	return true
end
function modifier_minigame_avatar_jump.prototype.IsPurgable(self)
	return false
end
function modifier_minigame_avatar_jump.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true, [MODIFIER_STATE_COMMAND_RESTRICTED] = true }
end
function modifier_minigame_avatar_jump.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function modifier_minigame_avatar_jump.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_OVERRIDE_ABILITY_2
end
function modifier_minigame_avatar_jump.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self.startTime = GameRules:GetGameTime()
	self.startPosition = parent:GetAbsOrigin()
	self.forward = parent:GetForwardVector()
	self.forward.z = 0
	if self.forward:Length2D() <= 0.01 then
		self.forward = Vector(1, 0, 0)
	else
		self.forward = self.forward:Normalized()
	end
	self.distance = math.max(0, tonumber(params and params.distance) or 0)
	self.jumpDuration = math.max(0.03, tonumber(params and params.duration) or MINI_GAME_AVATAR_JUMP_DURATION)
	self.height = math.max(0, tonumber(params and params.height) or MINI_GAME_AVATAR_JUMP_HEIGHT)
	self.finishedNaturally = false
	self.finalFlatPosition = self.startPosition:__add(self.forward:__mul(self.distance))
	self:StartIntervalThink(FrameTime())
	self:OnIntervalThink()
end
function modifier_minigame_avatar_jump.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) or parent:IsNull() then
		self:Destroy()
		return
	end
	if parent:HasModifier(MINI_GAME_AVATAR_KNOCKBACK_MODIFIER) then
		self:Destroy()
		return
	end
	local progress = math.min((GameRules:GetGameTime() - self.startTime) / self.jumpDuration, 1)
	local flatPosition = self.startPosition:__add(self.forward:__mul(self.distance * progress))
	local groundPosition = GetGroundPosition(flatPosition, parent) or flatPosition
	local jumpHeight = self.height * math.sin(math.pi * progress)
	parent:SetAbsOrigin(Vector(groundPosition.x, groundPosition.y, groundPosition.z + jumpHeight))
	if progress >= 1 then
		self.finishedNaturally = true
		self:Destroy()
	end
end
function modifier_minigame_avatar_jump.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	if self.finishedNaturally then
		local currentOrigin = parent:GetAbsOrigin()
		local landingPosition = Vector(self.finalFlatPosition.x, self.finalFlatPosition.y, currentOrigin.z)
		local landingSucceeded = MyGameMiniGame and MyGameMiniGame:NotifyAvatarJumpFinished(parent, landingPosition)
		DebugPrint(nil, "跳到了", landingSucceeded)
		local landingSound = landingSucceeded == false and MINI_GAME_AVATAR_LAND_FAILED_SOUND
			or MINI_GAME_AVATAR_LAND_SUCCESS_SOUND
		EmitSoundOnLocationWithCaster(landingPosition, landingSound, parent)
		return
	end
	EmitSoundOnLocationWithCaster(parent:GetAbsOrigin(), MINI_GAME_AVATAR_LAND_FAILED_SOUND, parent)
end
modifier_minigame_avatar_jump = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_minigame_avatar_jump)
____exports.modifier_minigame_avatar_jump = modifier_minigame_avatar_jump
return ____exports