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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local THUNDER_GRASS_ROOM_ID = "M014"
local THUNDERIZED_MODIFIER_NAME = "modifier_item_M223_thunderized"
local THUNDERIZED_MOVE_SPEED_BONUS_PCT = 50
local THUNDERIZED_LOOP_SOUND = "Hero_StormSpirit.BallLightning.Loop"
local THUNDERIZED_PERFECT_CAST_REMAINING_PCT_MAX = 10
local THUNDERIZED_PERFECT_MOVE_SPEED_BONUS_PCT = 300
local THUNDERIZED_PERFECT_ATTACK_DAMAGE_PCT = 500
local THUNDERIZED_PERFECT_SEARCH_RADIUS = 99999
____exports.THUNDERIZED_PERFECT_HIT_EFFECT = "particles/blink_dagger_fall_2021_start_lvl2_2.vpcf"
--- 雷化状态视觉特效（复用项目已有的雷电系粒子）。
____exports.THUNDERIZED_STATUS_EFFECT = "particles/lizi/status_fx/storm_spirit_static_remnant.vpcf"
____exports.THUNDERIZED_AMBIENT_EFFECT = "particles/units/heroes/hero_arc_warden/arc_warden_flux_tempest_tgt.vpcf"
____exports.THUNDERIZED_STATIC_STORM_EFFECT = "particles/disruptor_2022_immortal_static_storm_hero_debuff_2.vpcf"
--- 判断单位是否处于雷化状态。
function ____exports.IsUnitThunderized(self, unit)
	if not unit or not IsValid(nil, unit) then
		return false
	end
	return unit:HasModifier(THUNDERIZED_MODIFIER_NAME)
end
--- 判断玩家英雄是否处于雷化状态。
function ____exports.IsPlayerThunderized(self, playerId)
	local hero = PlayerResource:GetSelectedHeroEntity(playerId)
	return ____exports.IsUnitThunderized(nil, hero)
end
--- 雷化状态 modifier 名，供其它脚本（如装备）复用同款效果。
____exports.THUNDERIZED_MODIFIER = THUNDERIZED_MODIFIER_NAME
--- 判断施法者附近是否有足够的雷电力量（即是否处于雷霆草所在房间）。
function ____exports.HasNearbyThunderPower(self, caster)
	local playerId = caster:GetPlayerOwnerID()
	if playerId == nil or playerId < 0 then
		return false
	end
	local room = MyGameRoomManager and MyGameRoomManager:GetPlayerRoom(playerId)
	return (room and room:GetRoomId()) == THUNDER_GRASS_ROOM_ID
end
____exports.item_M223 = __TS__Class()
local item_M223 = ____exports.item_M223
item_M223.name = "item_M223"
__TS__ClassExtends(item_M223, BaseItem_CS)
function item_M223.prototype.Precache(self, context)
	PrecacheResource("particle", ____exports.THUNDERIZED_STATUS_EFFECT, context)
	PrecacheResource("particle", ____exports.THUNDERIZED_AMBIENT_EFFECT, context)
	PrecacheResource("particle", ____exports.THUNDERIZED_STATIC_STORM_EFFECT, context)
	PrecacheResource("particle", ____exports.THUNDERIZED_PERFECT_HIT_EFFECT, context)
end
function item_M223.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 0.1,
		onSuccess = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			if self:HasNearbyThunderPower(caster) then
				local ability_duration = self:GetSpecialValueFor("ability_duration")
				caster:AddNewModifier(caster, self, THUNDERIZED_MODIFIER_NAME, { duration = ability_duration })
				local effect = ParticleManager:CreateParticle(
					"particles/dd/small_lightning_strike_blue_cyan.vpcf",
					PATTACH_CENTER_FOLLOW,
					caster
				)
				ParticleManager:ReleaseParticleIndex(effect)
				ParticleManager:DestroyParticle(effect, false)
				caster:EmitSound("Hero_Zuus.Pick")
			else
				ErrorMsg(nil, caster:GetPlayerId(), "附近没有足够的雷电力量，什么都没发生...")
			end
			self:CostItemCharge(1)
		end,
		onInterrupted = function() end,
	}
end
function item_M223.prototype.HasNearbyThunderPower(self, caster)
	return ____exports.HasNearbyThunderPower(nil, caster)
end
item_M223 = __TS__DecorateLegacy({ registerAbility(nil) }, item_M223)
____exports.item_M223 = item_M223
____exports.modifier_item_M223_thunderized = __TS__Class()
local modifier_item_M223_thunderized = ____exports.modifier_item_M223_thunderized
modifier_item_M223_thunderized.name = "modifier_item_M223_thunderized"
__TS__ClassExtends(modifier_item_M223_thunderized, BaseModifier_CS)
function modifier_item_M223_thunderized.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.hasLoopSound = false
	self.isPerfectTiming = false
	self.allowAttackCounterBreak = true
	self.allowPerfectTiming = true
	self.consumeOnAttack = true
end
function modifier_item_M223_thunderized.GetLocalizationCN(self)
	return { name = "雷化", description = "大幅减少受到的雷电伤害，并可以通过雷墙。" }
end
function modifier_item_M223_thunderized.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self:RefreshBehaviorFlags(params)
	self:RefreshPerfectTiming(parent)
	if (params and params.play_loop_sound) == 1 then
		self.hasLoopSound = true
		parent:EmitSound(THUNDERIZED_LOOP_SOUND)
	end
	self.ambientParticle =
		ParticleManager:CreateParticle(____exports.THUNDERIZED_AMBIENT_EFFECT, PATTACH_CENTER_FOLLOW, parent)
	ParticleManager:SetParticleControl(self.ambientParticle, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.ambientParticle, 4, Vector(2, 0, 0))
	self.staticStormParticle =
		ParticleManager:CreateParticle(____exports.THUNDERIZED_STATIC_STORM_EFFECT, PATTACH_CENTER_FOLLOW, parent)
	ParticleManager:SetParticleControl(self.staticStormParticle, 0, parent:GetAbsOrigin())
end
function modifier_item_M223_thunderized.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self:RefreshBehaviorFlags(params)
	self:RefreshPerfectTiming(parent)
end
function modifier_item_M223_thunderized.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if self.hasLoopSound and IsValid(nil, parent) then
		StopSoundOn(THUNDERIZED_LOOP_SOUND, parent)
		self.hasLoopSound = false
	end
	if self.ambientParticle ~= nil then
		ParticleManager:DestroyParticle(self.ambientParticle, false)
		ParticleManager:ReleaseParticleIndex(self.ambientParticle)
		self.ambientParticle = nil
	end
	if self.staticStormParticle ~= nil then
		ParticleManager:DestroyParticle(self.staticStormParticle, false)
		ParticleManager:ReleaseParticleIndex(self.staticStormParticle)
		self.staticStormParticle = nil
	end
end
function modifier_item_M223_thunderized.prototype.IsHidden(self)
	return false
end
function modifier_item_M223_thunderized.prototype.IsDebuff(self)
	return false
end
function modifier_item_M223_thunderized.prototype.IsPurgable(self)
	return false
end
function modifier_item_M223_thunderized.prototype.GetTexture(self)
	return "item_icon_m223"
end
function modifier_item_M223_thunderized.prototype.GetStatusEffectName(self)
	return ____exports.THUNDERIZED_STATUS_EFFECT
end
function modifier_item_M223_thunderized.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_item_M223_thunderized.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_item_M223_thunderized.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end
function modifier_item_M223_thunderized.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	return self.isPerfectTiming and THUNDERIZED_PERFECT_MOVE_SPEED_BONUS_PCT or THUNDERIZED_MOVE_SPEED_BONUS_PCT
end
function modifier_item_M223_thunderized.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED, BusinessEvents.ON_ATTACK_MISS, BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_item_M223_thunderized.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if not self:IsMainAttackByParent(event) then
		return
	end
	if self.allowPerfectTiming then
		self:TryApplyPerfectTimingBonusDamage(event.attacker, event.target)
	end
	if self.allowAttackCounterBreak then
		self:TryTriggerThunderizedCounterBreak(event.attacker, event.target)
	end
	if self.consumeOnAttack then
		self:ConsumeThunderized()
	end
end
function modifier_item_M223_thunderized.prototype.OnAttackMiss_CS(self, event)
	if not IsServer() then
		return
	end
	if not self:IsMainAttackByParent(event) then
		return
	end
	if self.consumeOnAttack then
		self:ConsumeThunderized()
	end
end
function modifier_item_M223_thunderized.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	if not self:CanImmuneMonsterAbilityDamage(event) then
		return
	end
	event.prevent_apply = true
end
function modifier_item_M223_thunderized.prototype.IsMainAttackByParent(self, event)
	local parent = self:GetParent()
	return IsValidAlive(nil, parent) and event.attacker == parent and event.is_sub_attack ~= true
end
function modifier_item_M223_thunderized.prototype.TryTriggerThunderizedCounterBreak(self, attacker, target)
	if not IsValidAlive(nil, attacker) or not IsValidAlive(nil, target) then
		return
	end
	if not self:IsMonsterTarget(target) then
		return
	end
	local ____this_7
	____this_7 = target
	local ____opt_6 = ____this_7.IsMonsterCasting
	if (____opt_6 and ____opt_6(____this_7)) ~= true then
		return
	end
	local ability = self:GetCurrentMonsterAbility(target)
	local ____opt_8 = ability and ability.TryTriggerThunderizedCounterBreak
	if ____opt_8 ~= nil then
		____opt_8(ability, attacker)
	end
end
function modifier_item_M223_thunderized.prototype.TryApplyPerfectTimingBonusDamage(self, attacker, target)
	if not self.isPerfectTiming then
		return
	end
	if not IsValidAlive(nil, attacker) or not IsValidAlive(nil, target) then
		return
	end
	if target:GetTeamNumber() == attacker:GetTeamNumber() then
		return
	end
	local attackDamage = MyGameAttribute:GetAttribute(attacker, "total_attack_damage") or 0
	local damage = attackDamage * THUNDERIZED_PERFECT_ATTACK_DAMAGE_PCT / 100
	if damage <= 0 then
		return
	end
	Damage:ApplyDamage({
		victim = target,
		attacker = attacker,
		ability = self:GetAbility(),
		damage = damage,
		damage_type = 2,
		extra_data = { custom_tag = "thunderized_perfect_timing", source_name = "雷化精准时机" },
	})
	self:PlayPerfectTimingHitEffect(target)
end
function modifier_item_M223_thunderized.prototype.PlayPerfectTimingHitEffect(self, target)
	local effect =
		ParticleManager:CreateParticle(____exports.THUNDERIZED_PERFECT_HIT_EFFECT, PATTACH_CENTER_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(
		effect,
		0,
		target,
		PATTACH_CENTER_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(effect)
end
function modifier_item_M223_thunderized.prototype.IsMonsterTarget(self, target)
	local ____this_13
	____this_13 = target
	local ____opt_12 = ____this_13.GetUnitType
	local unitType = ____opt_12 and ____opt_12(____this_13)
	return unitType == UnitType.MONSTER_NORMAL
		or unitType == UnitType.MONSTER_ELITE
		or unitType == UnitType.MONSTER_MINIBOSS
		or unitType == UnitType.MONSTER_BOSS
end
function modifier_item_M223_thunderized.prototype.CanImmuneMonsterAbilityDamage(self, event)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or event.ctx.spec.victim ~= parent then
		return false
	end
	if not self:IsMonsterTarget(event.ctx.spec.attacker) then
		return false
	end
	if event.ctx.spec.is_base_attack == true then
		return false
	end
	local ability = event.ctx.spec.ability
	local ____opt_14 = ability and ability.GetMosnterAbilityConfig
	local cfg = ____opt_14 and ____opt_14(ability)
	return (cfg and cfg.thunderizedDamageImmune) == true
end
function modifier_item_M223_thunderized.prototype.RefreshPerfectTiming(self, parent)
	self.isPerfectTiming = self.allowPerfectTiming and self:HasPerfectThunderizedTiming(parent)
end
function modifier_item_M223_thunderized.prototype.RefreshBehaviorFlags(self, params)
	self.allowAttackCounterBreak = (params and params.allow_attack_counter_break) ~= 0
	self.allowPerfectTiming = (params and params.allow_perfect_timing) ~= 0
	self.consumeOnAttack = (params and params.consume_on_attack) ~= 0
end
function modifier_item_M223_thunderized.prototype.HasPerfectThunderizedTiming(self, parent)
	local playerId = parent:GetPlayerOwnerID()
	if playerId == nil or playerId < 0 then
		return false
	end
	local ____opt_26 = MyGameRoomManager and MyGameRoomManager:GetPlayerRoom(playerId)
	local roomId = ____opt_26 and ____opt_26:GetRoomId()
	if not roomId then
		return false
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		THUNDERIZED_PERFECT_SEARCH_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue72
			end
			if not self:IsMonsterTarget(enemy) then
				goto __continue72
			end
			local ____opt_30 = enemy.GetRoomId
			if (____opt_30 and ____opt_30(enemy)) ~= roomId then
				goto __continue72
			end
			local ability = self:GetCurrentMonsterAbility(enemy)
			local ____opt_32 = ability and ability.GetMosnterAbilityConfig
			local cfg = ____opt_32 and ____opt_32(ability)
			if (cfg and cfg.thunderizedDamageImmune) ~= true then
				goto __continue72
			end
			local precastModifier = enemy:FindModifierByName("modifier_monster_cast_pre_progress")
			if not precastModifier then
				goto __continue72
			end
			local remainingPct = math.max(0, math.min(100, precastModifier:GetStackCount()))
			if remainingPct <= THUNDERIZED_PERFECT_CAST_REMAINING_PCT_MAX then
				return true
			end
		end
		::__continue72::
	end
	return false
end
function modifier_item_M223_thunderized.prototype.GetCurrentMonsterAbility(self, target)
	local precastModifier = target:FindModifierByName("modifier_monster_cast_pre_progress")
	local durationModifier = target:FindModifierByName("modifier_monster_cast_controller")
	local ____opt_38 = precastModifier and precastModifier.GetAbility
	local ____temp_46 = ____opt_38 and ____opt_38(precastModifier)
	if ____temp_46 == nil then
		local ____opt_42 = durationModifier and durationModifier.GetAbility
		____temp_46 = ____opt_42 and ____opt_42(durationModifier)
	end
	return ____temp_46
end
function modifier_item_M223_thunderized.prototype.ConsumeThunderized(self)
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	parent:RemoveModifierByName(THUNDERIZED_MODIFIER_NAME)
end
modifier_item_M223_thunderized = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_M223_thunderized)
____exports.modifier_item_M223_thunderized = modifier_item_M223_thunderized
return ____exports