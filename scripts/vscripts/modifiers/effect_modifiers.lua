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
local BaseModifier = ____dota_ts_adapter.BaseModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifierMotionHorizontal_CS = ____modifier_base.BaseModifierMotionHorizontal_CS
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local pfx5 = "particles/status_fx/status_effect_void_spirit_pulse_buff.vpcf"
--- 获取可被普通营救流程处理的假死状态。
local function FindRescueableFakeDeath(self, unit)
	return unit:FindModifierByName("modifier_generic_fake_death")
end
____exports.modifier_game_dda_dynamic_difficulty = __TS__Class()
local modifier_game_dda_dynamic_difficulty = ____exports.modifier_game_dda_dynamic_difficulty
modifier_game_dda_dynamic_difficulty.name = "modifier_game_dda_dynamic_difficulty"
__TS__ClassExtends(modifier_game_dda_dynamic_difficulty, BaseModifier_CS)
function modifier_game_dda_dynamic_difficulty.prototype.IsHidden(self)
	return true
end
function modifier_game_dda_dynamic_difficulty.prototype.IsDebuff(self)
	return false
end
function modifier_game_dda_dynamic_difficulty.prototype.IsPurgable(self)
	return false
end
function modifier_game_dda_dynamic_difficulty.prototype.IsPurgeException(self)
	return false
end
function modifier_game_dda_dynamic_difficulty.prototype.IsPermanent(self)
	return true
end
function modifier_game_dda_dynamic_difficulty.prototype.RemoveOnDeath(self)
	return false
end
modifier_game_dda_dynamic_difficulty =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_game_dda_dynamic_difficulty)
____exports.modifier_game_dda_dynamic_difficulty = modifier_game_dda_dynamic_difficulty
____exports.modifier_game_dda_daily_luck = __TS__Class()
local modifier_game_dda_daily_luck = ____exports.modifier_game_dda_daily_luck
modifier_game_dda_daily_luck.name = "modifier_game_dda_daily_luck"
__TS__ClassExtends(modifier_game_dda_daily_luck, BaseModifier_CS)
function modifier_game_dda_daily_luck.GetLocalizationCN(self)
	return {
		name = "每日好运",
		description = "提高%dMODIFIER_PROPERTY_TOOLTIP%点幸运，每次进地图消耗1点，每天刷新。",
	}
end
function modifier_game_dda_daily_luck.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function modifier_game_dda_daily_luck.prototype.OnTooltip(self)
	return self:GetAttributeBonus().item_drop_luck or 0
end
function modifier_game_dda_daily_luck.prototype.GetAttributeBonus(self)
	return { item_drop_luck = self:GetStackCount() * 10 }
end
function modifier_game_dda_daily_luck.prototype.IsHidden(self)
	if self:GetStackCount() > 0 then
		return false
	end
	return true
end
function modifier_game_dda_daily_luck.prototype.IsDebuff(self)
	return false
end
function modifier_game_dda_daily_luck.prototype.IsPurgable(self)
	return false
end
function modifier_game_dda_daily_luck.prototype.IsPurgeException(self)
	return false
end
function modifier_game_dda_daily_luck.prototype.IsPermanent(self)
	return true
end
function modifier_game_dda_daily_luck.prototype.RemoveOnDeath(self)
	return false
end
function modifier_game_dda_daily_luck.prototype.GetTexture(self)
	return "antimage/immortal/antimage_blink_gold"
end
modifier_game_dda_daily_luck = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_game_dda_daily_luck)
____exports.modifier_game_dda_daily_luck = modifier_game_dda_daily_luck
____exports.modifier_game_dda_daily_fatigue = __TS__Class()
local modifier_game_dda_daily_fatigue = ____exports.modifier_game_dda_daily_fatigue
modifier_game_dda_daily_fatigue.name = "modifier_game_dda_daily_fatigue"
__TS__ClassExtends(modifier_game_dda_daily_fatigue, BaseModifier_CS)
function modifier_game_dda_daily_fatigue.GetLocalizationCN(self)
	return {
		name = "疲劳",
		description = "当前疲劳不足，地图掉落数量减少%dMODIFIER_PROPERTY_TOOLTIP%%%。每日疲劳于北京时间零点刷新。",
	}
end
function modifier_game_dda_daily_fatigue.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function modifier_game_dda_daily_fatigue.prototype.OnTooltip(self)
	return self:GetStackCount()
end
function modifier_game_dda_daily_fatigue.prototype.IsHidden(self)
	return false
end
function modifier_game_dda_daily_fatigue.prototype.IsDebuff(self)
	return true
end
function modifier_game_dda_daily_fatigue.prototype.IsPurgable(self)
	return false
end
function modifier_game_dda_daily_fatigue.prototype.IsPurgeException(self)
	return false
end
function modifier_game_dda_daily_fatigue.prototype.IsPermanent(self)
	return true
end
function modifier_game_dda_daily_fatigue.prototype.RemoveOnDeath(self)
	return false
end
function modifier_game_dda_daily_fatigue.prototype.GetTexture(self)
	return "item_spirit_vessel"
end
modifier_game_dda_daily_fatigue = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_game_dda_daily_fatigue)
____exports.modifier_game_dda_daily_fatigue = modifier_game_dda_daily_fatigue
____exports.modifier_invulnerable_and_hide_health_bar = __TS__Class()
local modifier_invulnerable_and_hide_health_bar = ____exports.modifier_invulnerable_and_hide_health_bar
modifier_invulnerable_and_hide_health_bar.name = "modifier_invulnerable_and_hide_health_bar"
__TS__ClassExtends(modifier_invulnerable_and_hide_health_bar, BaseModifier)
function modifier_invulnerable_and_hide_health_bar.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
end
function modifier_invulnerable_and_hide_health_bar.prototype.CheckState(self)
	local state = { [MODIFIER_STATE_NO_HEALTH_BAR] = true, [MODIFIER_STATE_INVULNERABLE] = true }
	return state
end
modifier_invulnerable_and_hide_health_bar =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_invulnerable_and_hide_health_bar)
____exports.modifier_invulnerable_and_hide_health_bar = modifier_invulnerable_and_hide_health_bar
____exports.modifier_cs_damage_reduction = __TS__Class()
local modifier_cs_damage_reduction = ____exports.modifier_cs_damage_reduction
modifier_cs_damage_reduction.name = "modifier_cs_damage_reduction"
__TS__ClassExtends(modifier_cs_damage_reduction, BaseModifierMotionHorizontal_CS)
function modifier_cs_damage_reduction.prototype.OnCreated(self, kv)
	BaseModifierMotionHorizontal_CS.prototype.OnCreated(self, kv)
	self.damage_reduction_pct = kv.damage_reduction_pct
end
function modifier_cs_damage_reduction.prototype.GetAttributeBonus(self)
	return { damage_reduction_pct = self.damage_reduction_pct }
end
function modifier_cs_damage_reduction.prototype.IsHidden(self)
	return true
end
modifier_cs_damage_reduction = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_cs_damage_reduction)
____exports.modifier_cs_damage_reduction = modifier_cs_damage_reduction
____exports.modifier_hunter_tracker_boost = __TS__Class()
local modifier_hunter_tracker_boost = ____exports.modifier_hunter_tracker_boost
modifier_hunter_tracker_boost.name = "modifier_hunter_tracker_boost"
__TS__ClassExtends(modifier_hunter_tracker_boost, BaseModifier_CS)
function modifier_hunter_tracker_boost.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.bonusPct = 0
end
function modifier_hunter_tracker_boost.prototype.OnCreated(self, params)
	self.bonusPct = tonumber(params and params.bonus_pct or 0) or 0
end
function modifier_hunter_tracker_boost.prototype.OnRefresh(self, params)
	self.bonusPct = tonumber(params and params.bonus_pct or 0) or 0
end
function modifier_hunter_tracker_boost.prototype.IsHidden(self)
	return false
end
function modifier_hunter_tracker_boost.prototype.IsPurgable(self)
	return true
end
function modifier_hunter_tracker_boost.prototype.GetTexture(self)
	return "bounty_hunter_track"
end
function modifier_hunter_tracker_boost.prototype.GetStatusEffectName(self)
	return pfx5
end
function modifier_hunter_tracker_boost.prototype.GetAttributeBonus(self)
	if self.bonusPct <= 0 then
		return {}
	end
	return { outgoing_damage_pct = self.bonusPct, base_health_pct = self.bonusPct }
end
modifier_hunter_tracker_boost =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_hunter_tracker_boost") }, modifier_hunter_tracker_boost)
____exports.modifier_hunter_tracker_boost = modifier_hunter_tracker_boost
____exports.modifier_pause_actions = __TS__Class()
local modifier_pause_actions = ____exports.modifier_pause_actions
modifier_pause_actions.name = "modifier_pause_actions"
__TS__ClassExtends(modifier_pause_actions, BaseModifierMotionHorizontal_CS)
function modifier_pause_actions.prototype.IsPurgable(self)
	return false
end
function modifier_pause_actions.prototype.IsHidden(self)
	return true
end
function modifier_pause_actions.prototype.CheckState(self)
	local state = { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_STUNNED] = true }
	return state
end
modifier_pause_actions = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_pause_actions)
____exports.modifier_pause_actions = modifier_pause_actions
____exports.modifier_pause_actions_2 = __TS__Class()
local modifier_pause_actions_2 = ____exports.modifier_pause_actions_2
modifier_pause_actions_2.name = "modifier_pause_actions_2"
__TS__ClassExtends(modifier_pause_actions_2, BaseModifierMotionHorizontal_CS)
function modifier_pause_actions_2.prototype.IsPurgable(self)
	return false
end
function modifier_pause_actions_2.prototype.IsHidden(self)
	return true
end
function modifier_pause_actions_2.prototype.CheckState(self)
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
	return state
end
modifier_pause_actions_2 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_pause_actions_2)
____exports.modifier_pause_actions_2 = modifier_pause_actions_2
--- 地图创建期间的专用传送锁定状态；只用状态锁，不用 Motion，避免与 FindClearSpace 冲突把人拽回原地。
____exports.modifier_room_entry_waiting = __TS__Class()
local modifier_room_entry_waiting = ____exports.modifier_room_entry_waiting
modifier_room_entry_waiting.name = "modifier_room_entry_waiting"
__TS__ClassExtends(modifier_room_entry_waiting, BaseModifier_CS)
function modifier_room_entry_waiting.prototype.IsPurgable(self)
	return false
end
function modifier_room_entry_waiting.prototype.IsHidden(self)
	return true
end
function modifier_room_entry_waiting.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_STUNNED] = true }
end
modifier_room_entry_waiting = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_room_entry_waiting)
____exports.modifier_room_entry_waiting = modifier_room_entry_waiting
____exports.modifier_evacuate_disable_auto_attack = __TS__Class()
local modifier_evacuate_disable_auto_attack = ____exports.modifier_evacuate_disable_auto_attack
modifier_evacuate_disable_auto_attack.name = "modifier_evacuate_disable_auto_attack"
__TS__ClassExtends(modifier_evacuate_disable_auto_attack, BaseModifier_CS)
function modifier_evacuate_disable_auto_attack.prototype.IsHidden(self)
	return true
end
function modifier_evacuate_disable_auto_attack.prototype.IsDebuff(self)
	return false
end
function modifier_evacuate_disable_auto_attack.prototype.IsPurgable(self)
	return false
end
function modifier_evacuate_disable_auto_attack.prototype.IsPurgeException(self)
	return false
end
function modifier_evacuate_disable_auto_attack.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DISABLE_AUTOATTACK }
end
function modifier_evacuate_disable_auto_attack.prototype.GetDisableAutoAttack(self)
	return 1
end
modifier_evacuate_disable_auto_attack =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_evacuate_disable_auto_attack)
____exports.modifier_evacuate_disable_auto_attack = modifier_evacuate_disable_auto_attack
____exports.modifier_ations_tower = __TS__Class()
local modifier_ations_tower = ____exports.modifier_ations_tower
modifier_ations_tower.name = "modifier_ations_tower"
__TS__ClassExtends(modifier_ations_tower, BaseModifier)
function modifier_ations_tower.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
end
function modifier_ations_tower.prototype.IsPurgable(self)
	return false
end
function modifier_ations_tower.prototype.IsHidden(self)
	return true
end
function modifier_ations_tower.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CUSTOM_TOWER_IDLE
end
function modifier_ations_tower.prototype.GetOverrideAnimationRate(self)
	return 1
end
function modifier_ations_tower.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE }
end
modifier_ations_tower = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_ations_tower)
____exports.modifier_ations_tower = modifier_ations_tower
____exports.modifier_monster_born = __TS__Class()
local modifier_monster_born = ____exports.modifier_monster_born
modifier_monster_born.name = "modifier_monster_born"
__TS__ClassExtends(modifier_monster_born, BaseModifier)
function modifier_monster_born.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	parent:StartGesture(ACT_DOTA_SPAWN)
end
function modifier_monster_born.prototype.CheckState(self)
	local state =
		{ [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_NO_HEALTH_BAR] = true }
	return state
end
function modifier_monster_born.prototype.GetEffectName(self)
	return "particles/econ/items/dazzle/dazzle_ti9/dazzle_shadow_wave_ti9_impact_damage.vpcf"
end
modifier_monster_born = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_monster_born)
____exports.modifier_monster_born = modifier_monster_born
____exports.modifier_monster_born_full_health = __TS__Class()
local modifier_monster_born_full_health = ____exports.modifier_monster_born_full_health
modifier_monster_born_full_health.name = "modifier_monster_born_full_health"
__TS__ClassExtends(modifier_monster_born_full_health, BaseModifier)
function modifier_monster_born_full_health.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	parent:SetHealth(parent:GetMaxHealth())
end
function modifier_monster_born_full_health.prototype.CheckState(self)
	local state = { [MODIFIER_STATE_NO_HEALTH_BAR] = false }
	if self:GetParent():GetHealth() == self:GetParent():GetMaxHealth() then
		state[MODIFIER_STATE_NO_HEALTH_BAR] = true
	end
	return state
end
modifier_monster_born_full_health = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_monster_born_full_health)
____exports.modifier_monster_born_full_health = modifier_monster_born_full_health
____exports.modifier_resource_invulnerable = __TS__Class()
local modifier_resource_invulnerable = ____exports.modifier_resource_invulnerable
modifier_resource_invulnerable.name = "modifier_resource_invulnerable"
__TS__ClassExtends(modifier_resource_invulnerable, BaseHeroModifier)
function modifier_resource_invulnerable.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	ScreenShake(self:GetParent():GetAbsOrigin(), 10, 10, 1, 3000, 0, true)
	local enemies = self:FindMonsterEnemies(self:GetParent():GetAbsOrigin(), 500)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue77
			end
			enemy:KnockBack(self:GetCaster(), self:GetAbility(), {
				duration = 0.5,
				stun = true,
				destroyTreesType = "onDestroy",
				heightType = "parabola",
				particleName = "",
				distance = 375,
				height = 0,
				stunDuration = 0.6,
				removeOnDeath = true,
				origin_pos = self:GetParent():GetAbsOrigin(),
			})
		end
		::__continue77::
	end
end
function modifier_resource_invulnerable.prototype.GetEffectName(self)
	return "particles/items3_fx/lotus_orb_shield.vpcf"
end
function modifier_resource_invulnerable.prototype.CheckState(self)
	local state = { [MODIFIER_STATE_NO_HEALTH_BAR] = true, [MODIFIER_STATE_INVULNERABLE] = true }
	return state
end
function modifier_resource_invulnerable.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local effect2 =
		ParticleManager:CreateParticle("particles/hero/glass_endcap.vpcf", PATTACH_CENTER_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(
		effect2,
		3,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetCaster():GetAbsOrigin(),
		false
	)
	ParticleManager:ReleaseParticleIndex(effect2)
end
modifier_resource_invulnerable = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_resource_invulnerable)
____exports.modifier_resource_invulnerable = modifier_resource_invulnerable
____exports.modifier_rescue = __TS__Class()
local modifier_rescue = ____exports.modifier_rescue
modifier_rescue.name = "modifier_rescue"
__TS__ClassExtends(modifier_rescue, BaseModifier)
function modifier_rescue.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.caster = self:GetCaster()
	local parent = self:GetParent()
	if not self.caster or self.caster:IsNull() or not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	if parent:GetTeamNumber() ~= self.caster:GetTeamNumber() then
		self:Destroy()
		return
	end
	local modifier = FindRescueableFakeDeath(nil, self.caster)
	if not modifier then
		self:Destroy()
		return
	end
	local target_p = parent:GetAbsOrigin()
	target_p.z = self.caster:GetAbsOrigin().z
	local fwv = (self.caster:GetAbsOrigin() - target_p):Normalized()
	parent:SetForwardVector(fwv)
	local pfx_name = "particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_back_ambient_ti8_l.vpcf"
	self.pfx1 = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		self.pfx1,
		0,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(self.pfx1, false, false, -1, false, false)
	self.pfx2 = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		self.pfx2,
		0,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(self.pfx2, false, false, -1, false, false)
	self:StartIntervalThink(0.1)
	self.caster:AddNewModifier(parent, nil, "modifier_ations_ability1", {})
	modifier:AddRescuer(parent:entindex())
end
function modifier_rescue.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self.caster
	local rescuer = self:GetParent()
	if not caster or not IsValid(nil, caster) or caster:IsNull() or not IsValidAlive(nil, rescuer) then
		self:Destroy()
		return
	end
	if rescuer:GetTeamNumber() ~= caster:GetTeamNumber() then
		self:Destroy()
		return
	end
	if GetDistance(nil, caster:GetAbsOrigin(), self:GetParent():GetAbsOrigin()) > 250 then
		self:Destroy()
		return
	end
	local modifier = FindRescueableFakeDeath(nil, self.caster)
	if not modifier then
		self:StartIntervalThink(-1)
		self:Destroy()
	end
end
function modifier_rescue.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_GENERIC_CHANNEL_1
end
function modifier_rescue.prototype.GetOverrideAnimationRate(self)
	return 1
end
function modifier_rescue.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE }
end
function modifier_rescue.prototype.IsPurgable(self)
	return false
end
function modifier_rescue.prototype.IsHidden(self)
	return true
end
function modifier_rescue.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	print("移除营救3")
	local modifier = FindRescueableFakeDeath(nil, self.caster)
	if modifier then
		modifier:RemoveRescuer(self:GetParent():entindex())
	end
	if self.caster and not self.caster:IsNull() then
		self.caster:RemoveModifierByName("modifier_ations_ability1")
	end
end
function modifier_rescue.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_STUNNED] = true }
end
modifier_rescue = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_rescue)
____exports.modifier_rescue = modifier_rescue
____exports.modifier_ations_ability1 = __TS__Class()
local modifier_ations_ability1 = ____exports.modifier_ations_ability1
modifier_ations_ability1.name = "modifier_ations_ability1"
__TS__ClassExtends(modifier_ations_ability1, BaseModifier)
function modifier_ations_ability1.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.3)
end
function modifier_ations_ability1.prototype.IsPurgable(self)
	return false
end
function modifier_ations_ability1.prototype.OnIntervalThink(self)
	ScreenShake(self:GetParent():GetAbsOrigin(), 3, 3, 0.1, 1200, 0, true)
end
function modifier_ations_ability1.prototype.GetEffectName(self)
	return "particles/econ/items/underlord/underlord_2021_immortal/underlord_2021_immortal_portal_buildup_crimson_streaks.vpcf"
end
function modifier_ations_ability1.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CHANNEL_ABILITY_1
end
function modifier_ations_ability1.prototype.GetOverrideAnimationRate(self)
	return 1
end
function modifier_ations_ability1.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE }
end
modifier_ations_ability1 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_ations_ability1)
____exports.modifier_ations_ability1 = modifier_ations_ability1
____exports.modifier_monster_leashing = __TS__Class()
local modifier_monster_leashing = ____exports.modifier_monster_leashing
modifier_monster_leashing.name = "modifier_monster_leashing"
__TS__ClassExtends(modifier_monster_leashing, BaseModifier_CS)
function modifier_monster_leashing.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.targetPos = Vector(params.posX, params.posY, params.posZ)
	local parent = self:GetParent()
	parent:Stop()
	parent:MoveToPosition(self.targetPos)
	self:StartIntervalThink(0.5)
end
function modifier_monster_leashing.prototype.OnIntervalThink(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	parent:MoveToPosition(self.targetPos)
	parent:SetHealth(parent:GetMaxHealth())
end
function modifier_monster_leashing.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end
function modifier_monster_leashing.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE }
end
function modifier_monster_leashing.prototype.GetModifierMoveSpeed_Absolute(self)
	return 800
end
modifier_monster_leashing = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_monster_leashing)
____exports.modifier_monster_leashing = modifier_monster_leashing
____exports.modifier_material_override = __TS__Class()
local modifier_material_override = ____exports.modifier_material_override
modifier_material_override.name = "modifier_material_override"
__TS__ClassExtends(modifier_material_override, BaseModifier)
function modifier_material_override.prototype.OnCreated(self, params)
	self.effectName = params.effectName
end
function modifier_material_override.prototype.GetStatusEffectName(self)
	return self.effectName
end
modifier_material_override = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_material_override)
____exports.modifier_material_override = modifier_material_override
local HIT_EFFECT_PARTICLE = "particles/events/crownfall/survivors/status/status_effect_generic_hit.vpcf"
local PLAYER_HIT_EFFECT_PARTICLE = "particles/events/crownfall/survivors/status/status_effect_player_hit.vpcf"
____exports.modifier_hit_effect = __TS__Class()
local modifier_hit_effect = ____exports.modifier_hit_effect
modifier_hit_effect.name = "modifier_hit_effect"
__TS__ClassExtends(modifier_hit_effect, BaseModifier)
function modifier_hit_effect.prototype.IsHidden(self)
	return true
end
function modifier_hit_effect.prototype.IsPurgable(self)
	return false
end
function modifier_hit_effect.prototype.RemoveOnDeath(self)
	return false
end
function modifier_hit_effect.prototype.OnCreated(self)
	if not IsClient() then
		return
	end
	local parent = self:GetParent()
	local pfx = ParticleManager:CreateParticle(HIT_EFFECT_PARTICLE, PATTACH_CUSTOM_GAME_STATE_1, parent)
	self:AddParticle(pfx, false, true, -1, false, false)
end
modifier_hit_effect = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_hit_effect)
____exports.modifier_hit_effect = modifier_hit_effect
____exports.modifier_player_hit_effect = __TS__Class()
local modifier_player_hit_effect = ____exports.modifier_player_hit_effect
modifier_player_hit_effect.name = "modifier_player_hit_effect"
__TS__ClassExtends(modifier_player_hit_effect, BaseModifier)
function modifier_player_hit_effect.prototype.IsHidden(self)
	return true
end
function modifier_player_hit_effect.prototype.IsPurgable(self)
	return false
end
function modifier_player_hit_effect.prototype.RemoveOnDeath(self)
	return false
end
function modifier_player_hit_effect.prototype.OnCreated(self)
	if not IsClient() then
		return
	end
	local parent = self:GetParent()
	local pfx = ParticleManager:CreateParticle(PLAYER_HIT_EFFECT_PARTICLE, PATTACH_CUSTOM_GAME_STATE_1, parent)
	self:AddParticle(pfx, false, true, -1, false, false)
end
modifier_player_hit_effect = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_player_hit_effect)
____exports.modifier_player_hit_effect = modifier_player_hit_effect
local pfx = "particles/status_effect_void_spirit_pulse_buff_qs.vpcf"
local function GetNpcLockStatusEffectName(self, parent)
	if IsServer() then
		return ""
	end
	local playerId = GetLocalPlayerID()
	if playerId == nil or playerId < 0 then
		return pfx
	end
	local isUnlock = tonumber(GetPlayerCustomValue(nil, playerId, parent:GetUnitName())) > 0
	if not isUnlock then
		return pfx
	end
	return ""
end
____exports.modifier_npc_lock_0 = __TS__Class()
local modifier_npc_lock_0 = ____exports.modifier_npc_lock_0
modifier_npc_lock_0.name = "modifier_npc_lock_0"
__TS__ClassExtends(modifier_npc_lock_0, BaseModifier)
function modifier_npc_lock_0.prototype.GetStatusEffectName(self)
	return GetNpcLockStatusEffectName(nil, self:GetParent())
end
modifier_npc_lock_0 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_npc_lock_0)
____exports.modifier_npc_lock_0 = modifier_npc_lock_0
____exports.modifier_npc_lock_1 = __TS__Class()
local modifier_npc_lock_1 = ____exports.modifier_npc_lock_1
modifier_npc_lock_1.name = "modifier_npc_lock_1"
__TS__ClassExtends(modifier_npc_lock_1, BaseModifier)
function modifier_npc_lock_1.prototype.GetStatusEffectName(self)
	return GetNpcLockStatusEffectName(nil, self:GetParent())
end
modifier_npc_lock_1 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_npc_lock_1)
____exports.modifier_npc_lock_1 = modifier_npc_lock_1
____exports.modifier_npc_lock_2 = __TS__Class()
local modifier_npc_lock_2 = ____exports.modifier_npc_lock_2
modifier_npc_lock_2.name = "modifier_npc_lock_2"
__TS__ClassExtends(modifier_npc_lock_2, BaseModifier)
function modifier_npc_lock_2.prototype.GetStatusEffectName(self)
	return GetNpcLockStatusEffectName(nil, self:GetParent())
end
modifier_npc_lock_2 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_npc_lock_2)
____exports.modifier_npc_lock_2 = modifier_npc_lock_2
____exports.modifier_npc_lock_3 = __TS__Class()
local modifier_npc_lock_3 = ____exports.modifier_npc_lock_3
modifier_npc_lock_3.name = "modifier_npc_lock_3"
__TS__ClassExtends(modifier_npc_lock_3, BaseModifier)
function modifier_npc_lock_3.prototype.GetStatusEffectName(self)
	return GetNpcLockStatusEffectName(nil, self:GetParent())
end
modifier_npc_lock_3 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_npc_lock_3)
____exports.modifier_npc_lock_3 = modifier_npc_lock_3
____exports.modifier_wearable_unit_state = __TS__Class()
local modifier_wearable_unit_state = ____exports.modifier_wearable_unit_state
modifier_wearable_unit_state.name = "modifier_wearable_unit_state"
__TS__ClassExtends(modifier_wearable_unit_state, BaseModifier)
function modifier_wearable_unit_state.prototype.____constructor(self, ...)
	BaseModifier.prototype.____constructor(self, ...)
	self.invisibilityLevel = 0
end
function modifier_wearable_unit_state.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.invisibilityLevel = self:normalizeInvisibilityLevel(params and params.invisibility_level)
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end
function modifier_wearable_unit_state.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self.invisibilityLevel = self:normalizeInvisibilityLevel(params and params.invisibility_level)
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end
function modifier_wearable_unit_state.prototype.AddCustomTransmitterData(self)
	return { invisibilityLevel = self.invisibilityLevel }
end
function modifier_wearable_unit_state.prototype.HandleCustomTransmitterData(self, data)
	self.invisibilityLevel = self:normalizeInvisibilityLevel(data and data.invisibilityLevel)
end
function modifier_wearable_unit_state.prototype.IsHidden(self)
	return true
end
function modifier_wearable_unit_state.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end
function modifier_wearable_unit_state.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INVISIBILITY_LEVEL }
end
function modifier_wearable_unit_state.prototype.GetModifierInvisibilityLevel(self)
	return self.invisibilityLevel
end
function modifier_wearable_unit_state.prototype.normalizeInvisibilityLevel(self, rawValue)
	local level = tonumber(rawValue or 0)
	if level ~= level or level <= 0 then
		return 0
	end
	return math.floor(level)
end
modifier_wearable_unit_state = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_wearable_unit_state)
____exports.modifier_wearable_unit_state = modifier_wearable_unit_state
--- 饰品系统独占的英雄本体模型替换，移除 Modifier 即可恢复引擎原始模型。
____exports.modifier_wearable_hero_model = __TS__Class()
local modifier_wearable_hero_model = ____exports.modifier_wearable_hero_model
modifier_wearable_hero_model.name = "modifier_wearable_hero_model"
__TS__ClassExtends(modifier_wearable_hero_model, BaseModifier)
function modifier_wearable_hero_model.prototype.____constructor(self, ...)
	BaseModifier.prototype.____constructor(self, ...)
	self.modelPath = ""
end
function modifier_wearable_hero_model.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:updateModelPath(params and params.model_path)
end
function modifier_wearable_hero_model.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:updateModelPath(params and params.model_path)
end
function modifier_wearable_hero_model.prototype.AddCustomTransmitterData(self)
	return { modelPath = self.modelPath }
end
function modifier_wearable_hero_model.prototype.HandleCustomTransmitterData(self, data)
	self.modelPath = data.modelPath or ""
end
function modifier_wearable_hero_model.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE }
end
function modifier_wearable_hero_model.prototype.GetModifierModelChange(self)
	return self.modelPath
end
function modifier_wearable_hero_model.prototype.IsHidden(self)
	return true
end
function modifier_wearable_hero_model.prototype.IsPurgable(self)
	return false
end
function modifier_wearable_hero_model.prototype.RemoveOnDeath(self)
	return false
end
function modifier_wearable_hero_model.prototype.updateModelPath(self, modelPath)
	self.modelPath = modelPath or ""
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end
modifier_wearable_hero_model = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_wearable_hero_model)
____exports.modifier_wearable_hero_model = modifier_wearable_hero_model
--- 饰品系统独占的全局动作翻译；允许多个饰品共同提供不同的翻译标识。
____exports.modifier_wearable_hero_activity = __TS__Class()
local modifier_wearable_hero_activity = ____exports.modifier_wearable_hero_activity
modifier_wearable_hero_activity.name = "modifier_wearable_hero_activity"
__TS__ClassExtends(modifier_wearable_hero_activity, BaseModifier)
function modifier_wearable_hero_activity.prototype.____constructor(self, ...)
	BaseModifier.prototype.____constructor(self, ...)
	self.activityName = ""
end
function modifier_wearable_hero_activity.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:updateActivityName(params and params.activity_name)
end
function modifier_wearable_hero_activity.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:updateActivityName(params and params.activity_name)
end
function modifier_wearable_hero_activity.prototype.AddCustomTransmitterData(self)
	return { activityName = self.activityName }
end
function modifier_wearable_hero_activity.prototype.HandleCustomTransmitterData(self, data)
	self.activityName = data.activityName or ""
end
function modifier_wearable_hero_activity.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_wearable_hero_activity.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function modifier_wearable_hero_activity.prototype.GetActivityTranslationModifiers(self)
	return self.activityName
end
function modifier_wearable_hero_activity.prototype.IsHidden(self)
	return true
end
function modifier_wearable_hero_activity.prototype.IsPurgable(self)
	return false
end
function modifier_wearable_hero_activity.prototype.RemoveOnDeath(self)
	return false
end
function modifier_wearable_hero_activity.prototype.updateActivityName(self, activityName)
	self.activityName = activityName or ""
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end
modifier_wearable_hero_activity = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_wearable_hero_activity)
____exports.modifier_wearable_hero_activity = modifier_wearable_hero_activity
____exports.modifier_pet_effect = __TS__Class()
local modifier_pet_effect = ____exports.modifier_pet_effect
modifier_pet_effect.name = "modifier_pet_effect"
__TS__ClassExtends(modifier_pet_effect, BaseModifier)
function modifier_pet_effect.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
modifier_pet_effect = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_pet_effect)
____exports.modifier_pet_effect = modifier_pet_effect
return ____exports