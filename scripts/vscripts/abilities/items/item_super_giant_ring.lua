--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local sl_modifier_item_super_giant_ring, sl_modifier_item_super_giant_ring_aura_check_debuff, sl_modifier_item_super_giant_ring_strike_debuff, sl_modifier_item_super_giant_ring_strike_cooldown_debuff
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifier_ItemIntrinsic = ____sl_modifier_base.SLModifier_ItemIntrinsic
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_item_base = require("abilities.items._sl_item_base")
local SLItemBase = _____sl_item_base.SLItemBase
--- 巨人刚戒
-- <h1>被动：巨人行猎</h1>当一个敌方英雄在你的行猎范围内停留时间达到%stay_time%秒时，你会盯上他。%strike_debuff_dur%秒内，你的下一次攻击会对目标造成一次%strike_dmg%+%strike_dmg_hp_pct%%%装备者最大生命值的魔法伤害，并将这次伤害（原始伤害）的%dmg_to_hp_pct%%%转化为该装备的永久生命值，可无限叠加。<br><br>当目标脱离你的行猎范围时，你有%stay_stick_time%秒的时间重新靠近他。<br><br>对同一个目标在%strike_cooldown%秒内只能触发一次。<br><br>行猎范围：%radius%\n\n<h1>被动：巨人身躯</h1>你的最大生命值越高，体型越大。每%scale_hp_per_stack%生命值提升%scale_bonus%%%体型，最大提升%scald_bonus_max%%%
____exports.item_super_giant_ring = __TS__Class()
local item_super_giant_ring = ____exports.item_super_giant_ring
item_super_giant_ring.name = "item_super_giant_ring"
__TS__ClassExtends(item_super_giant_ring, SLItemBase)
function item_super_giant_ring.prototype.____constructor(self, ...)
	SLItemBase.prototype.____constructor(self, ...)
	self._manual_toggle_state = false
end
function item_super_giant_ring.prototype.GetIntrinsicModifierName(self)
	return sl_modifier_item_super_giant_ring.name
end
function item_super_giant_ring.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("radius")
end
function item_super_giant_ring.prototype.OnSpellStart(self)
	self._manual_toggle_state = not self._manual_toggle_state
	self:SetSecondaryCharges(self._manual_toggle_state and 1 or 0)
end
function item_super_giant_ring.prototype.GetAbilityTextureName(self)
	if self:GetSecondaryCharges() == 1 then
		return "item_super_giant_ring_magic"
	end
	return "item_super_giant_ring"
end
item_super_giant_ring = __TS__Decorate({ registerAbility(nil) }, item_super_giant_ring)
____exports.item_super_giant_ring = item_super_giant_ring
sl_modifier_item_super_giant_ring = __TS__Class()
sl_modifier_item_super_giant_ring.name = "sl_modifier_item_super_giant_ring"
__TS__ClassExtends(sl_modifier_item_super_giant_ring, SLModifier_ItemIntrinsic)
function sl_modifier_item_super_giant_ring.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_STATS_STRENGTH_BONUS, MODIFIER_PROPERTY_HEALTH_BONUS, MODIFIER_PROPERTY_MODEL_SCALE }
end
function sl_modifier_item_super_giant_ring.prototype.OnCreated(self, params)
	self._scale_hp_per_stack = self:GetAbilitySpecialValueFor("scale_hp_per_stack")
	self._scale_bonus = self:GetAbilitySpecialValueFor("scale_bonus")
	self._scald_bonus_max = self:GetAbilitySpecialValueFor("scald_bonus_max")
	self:StartIntervalThink(1)
end
function sl_modifier_item_super_giant_ring.prototype.OnIntervalThink(self)
	local parent = self:GetParent()
	local health = parent:GetMaxHealth()
	self._scale = math.min(health / self._scale_hp_per_stack * self._scale_bonus, self._scald_bonus_max)
end
function sl_modifier_item_super_giant_ring.prototype.GetModifierModelScale(self)
	return self._scale
end
function sl_modifier_item_super_giant_ring.prototype.GetModifierBonusStats_Strength(self)
	return self:GetAbilitySpecialValueFor("bonus_strength")
end
function sl_modifier_item_super_giant_ring.prototype.GetModifierHealthBonus(self)
	local ability = self:GetAbility()
	local base = ability:GetSpecialValueFor("bonus_hp")
	if ability:IsItem() then
		base = base + ability:GetCurrentCharges()
	end
	return base
end
function sl_modifier_item_super_giant_ring.prototype.IsAura(self)
	return true
end
function sl_modifier_item_super_giant_ring.prototype.GetAuraRadius(self)
	return self:GetAbilitySpecialValueFor("radius")
end
function sl_modifier_item_super_giant_ring.prototype.GetAuraDuration(self)
	return self:GetAbilitySpecialValueFor("stay_stick_time")
end
function sl_modifier_item_super_giant_ring.prototype.GetAuraSearchFlags(self)
	return DOTA_UNIT_TARGET_FLAG_NONE + DOTA_UNIT_TARGET_FLAG_NO_INVIS
end
function sl_modifier_item_super_giant_ring.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function sl_modifier_item_super_giant_ring.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HERO
end
function sl_modifier_item_super_giant_ring.prototype.GetModifierAura(self)
	return sl_modifier_item_super_giant_ring_aura_check_debuff.name
end
function sl_modifier_item_super_giant_ring.prototype.IsAuraActiveOnDeath(self)
	return false
end
function sl_modifier_item_super_giant_ring.prototype.GetAuraEntityReject(self, entity)
	if not self:IsLatestSource() then
		return true
	end
	if not IsValidAlive(entity) or not entity:IsRealHero() then
		return true
	end
	local caster = self:GetCaster()
	if caster:IsIllusion() then
		return true
	end
	local strike_debuff = entity:FindSLModifier(sl_modifier_item_super_giant_ring_strike_debuff, caster)
	if IsValid(strike_debuff) then
		return true
	end
	local cooldown_debuff = entity:FindSLModifier(sl_modifier_item_super_giant_ring_strike_cooldown_debuff, caster)
	if IsValid(cooldown_debuff) then
		return true
	end
	return false
end
sl_modifier_item_super_giant_ring = __TS__Decorate(
	{ registerModifier(nil, "abilities/items/item_super_giant_ring") },
	sl_modifier_item_super_giant_ring
)
--- 巨人刚戒检测光环debuff
sl_modifier_item_super_giant_ring_aura_check_debuff = __TS__Class()
sl_modifier_item_super_giant_ring_aura_check_debuff.name = "sl_modifier_item_super_giant_ring_aura_check_debuff"
__TS__ClassExtends(sl_modifier_item_super_giant_ring_aura_check_debuff, SLModifierBase_Debuff)
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype.____constructor(self, ...)
	SLModifierBase_Debuff.prototype.____constructor(self, ...)
	self._progress_sound_steps = 4
	self._progress_sound_steps_record = {}
	self._pid_progress = 0
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype.GetTexture(self)
	return self:GetCaster():GetName()
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype.IsPurgable(self)
	return false
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype.IsPurgeException(self)
	return false
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._interval = 0.33
	self._time_count = 0
	self._last_remain_time = self:GetRemainingTime()
	self._strike_debuff_need = self:GetAbilitySpecialValueFor("stay_time")
	self:StartIntervalThink(self._interval)
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype.OnIntervalThink(self)
	if not IsValid(self:GetAbility()) then
		return
	end
	local parent = self:GetParent()
	local remain_time = self:GetRemainingTime()
	local last_remain_time = self._last_remain_time
	self._last_remain_time = remain_time
	local strike_debuff_need = self._strike_debuff_need
	local progress_before = 100 - (strike_debuff_need - self._time_count) / strike_debuff_need * 100
	if remain_time < last_remain_time then
		self:_UpdateProgressParticle(progress_before, true)
		return
	end
	self._time_count = self._time_count + self._interval
	local progress_after = 100 - (strike_debuff_need - self._time_count) / strike_debuff_need * 100
	local sound_step = math.floor(self._progress_sound_steps * progress_after / 100)
	if sound_step > 0 and not self._progress_sound_steps_record[sound_step] then
		self._progress_sound_steps_record[sound_step] = true
		local volume = 1.25 + sound_step * 1.75
		local pitch = sound_step >= self._progress_sound_steps and 3 or 1
		parent:EmitSoundParams("item_super_giant_ring.step", pitch, volume, 0)
	end
	if self._time_count >= strike_debuff_need then
		if IsValidAlive(parent) then
			parent:AddSLModifier(sl_modifier_item_super_giant_ring_strike_debuff, {
				ability = self:GetAbility(),
				caster = self:GetCaster(),
				duration = self:GetAbilitySpecialValueFor("strike_debuff_dur"),
				no_error = true,
			})
		end
		self:StartIntervalThink(-1)
		self:Destroy()
	else
		self:_UpdateProgressParticle(progress_after, false)
	end
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype.OnDestroy(self)
	self:_RemoveProgressParticle()
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype._UpdateProgressParticle(self, progress, out)
	local caster = self:GetCaster()
	local parent = self:GetParent()
	if not self._progress_pid then
		self._progress_pid = self:CreateParticleForPlayer(
			ITEM_PARTICLES.item_hunter_marklink,
			PATTACH_ABSORIGIN_FOLLOW,
			caster,
			caster:GetFixedPlayerOwner()
		)
		self:SetParticleControlEnt(self._progress_pid, 7, parent, PATTACH_ABSORIGIN_FOLLOW, nil)
		self:SetParticleControl(self._progress_pid, 4, Vector(0, 0, 0))
	end
	if self._pid_progress ~= progress then
		self._pid_progress = progress
		self:SetParticleControl(self._progress_pid, 2, Vector(self._pid_progress, 0, 0))
	end
	if self._is_out == nil or out ~= nil and out ~= self._is_out then
		self._is_out = out
		local set_out_value = out and 1 or 0
		self:SetParticleControl(self._progress_pid, 3, Vector(set_out_value, 0, 0))
	end
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype._RemoveProgressParticle(self)
	if self._progress_pid then
		self:DestroyParticle(self._progress_pid, true)
		self._progress_pid = nil
	end
end
sl_modifier_item_super_giant_ring_aura_check_debuff = __TS__Decorate(
	{ registerModifier(nil, "abilities/items/item_super_giant_ring") },
	sl_modifier_item_super_giant_ring_aura_check_debuff
)
--- 巨人刚戒额外伤害debuff
sl_modifier_item_super_giant_ring_strike_debuff = __TS__Class()
sl_modifier_item_super_giant_ring_strike_debuff.name = "sl_modifier_item_super_giant_ring_strike_debuff"
__TS__ClassExtends(sl_modifier_item_super_giant_ring_strike_debuff, SLModifierBase_Debuff)
function sl_modifier_item_super_giant_ring_strike_debuff.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_item_super_giant_ring_strike_debuff.prototype.IsPurgable(self)
	return false
end
function sl_modifier_item_super_giant_ring_strike_debuff.prototype.IsPurgeException(self)
	return false
end
function sl_modifier_item_super_giant_ring_strike_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_item_super_giant_ring_strike_debuff.prototype.GetTexture(self)
	return self:GetCaster():GetName()
end
function sl_modifier_item_super_giant_ring_strike_debuff.prototype.DeclareFunctions(self)
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end
function sl_modifier_item_super_giant_ring_strike_debuff.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	local pid = self:CreateParticleForPlayer(
		ITEM_PARTICLES.item_hunter_marklink,
		PATTACH_ABSORIGIN_FOLLOW,
		caster,
		caster:GetFixedPlayerOwner()
	)
	self:SetParticleControl(pid, 2, Vector(100, 0, 0))
	self:SetParticleControl(pid, 3, Vector(1, 0, 0))
	self:SetParticleControl(pid, 4, Vector(1, 0, 0))
	self:SetParticleControlEnt(pid, 7, parent, PATTACH_ABSORIGIN_FOLLOW, nil)
	self:AddParticle(pid, false, false, 1, false, false)
end
function sl_modifier_item_super_giant_ring_strike_debuff.prototype.OnAttackLanded(self, event)
	if not IsServer() then
		return
	end
	local ____event_0 = event
	local attacker = ____event_0.attacker
	local target = ____event_0.target
	if not IsValidAlive(attacker) or not IsValidAlive(target) then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if target == parent and attacker == caster then
		local strike_dmg = self:GetAbilitySpecialValueFor("strike_dmg")
		local strike_dmg_hp_pct = self:GetAbilitySpecialValueFor("strike_dmg_hp_pct")
		local caster_hp_max = caster:GetMaxHealth()
		local total_dmg = strike_dmg + caster_hp_max * strike_dmg_hp_pct * 0.01
		local item = self:GetAbility()
		local dmg_to_hp_pct = self:GetAbilitySpecialValueFor("dmg_to_hp_pct")
		local bonus_hp = math.floor(total_dmg * dmg_to_hp_pct * 0.01)
		local ____GlobalAttrManager_3 = GlobalAttrManager
		local ____GlobalAttrManager_Get_4 = GlobalAttrManager.Get
		local ____item_GetCaster_result_GetPlayerOwnerID_result_1 = item:GetCaster()
		if ____item_GetCaster_result_GetPlayerOwnerID_result_1 ~= nil then
			____item_GetCaster_result_GetPlayerOwnerID_result_1 =
				____item_GetCaster_result_GetPlayerOwnerID_result_1:GetPlayerOwnerID()
		end
		local attr_manager =
			____GlobalAttrManager_Get_4(____GlobalAttrManager_3, ____item_GetCaster_result_GetPlayerOwnerID_result_1)
		local ____temp_5 = attr_manager and attr_manager:GetAttr("gangpct")
		if ____temp_5 == nil then
			____temp_5 = 0
		end
		local extra_pct = ____temp_5
		local bonus_chargets = bonus_hp * (1 + extra_pct / 100)
		item:SetCurrentCharges(item:GetCurrentCharges() + bonus_chargets)
		caster:CalculateStatBonus(true)
		local particle_path = item:GetSecondaryCharges() == 1 and ITEM_PARTICLES.item_hunter_hit_magic
			or ITEM_PARTICLES.item_hunter_hit
		local hit_particle = self:CreateParticle(particle_path, PATTACH_CUSTOMORIGIN, nil)
		self:SetParticleControlEnt(hit_particle, 0, parent, PATTACH_POINT_FOLLOW, "attach_hitloc")
		self:SetParticleControlEnt(hit_particle, 1, caster, PATTACH_ABSORIGIN_FOLLOW, nil)
		target:EmitSound("item_super_giant_ring.hit")
		parent:AddSLModifier(sl_modifier_item_super_giant_ring_strike_cooldown_debuff, {
			ability = item,
			caster = caster,
			duration = self:GetAbilitySpecialValueFor("strike_cooldown"),
			no_error = true,
		})
		local ____temp_6
		if item:GetSecondaryCharges() == 1 then
			____temp_6 = DAMAGE_TYPE_MAGICAL
		else
			____temp_6 = DAMAGE_TYPE_PHYSICAL
		end
		local dmg_type = ____temp_6
		ApplyDamage({
			attacker = caster,
			damage = total_dmg,
			damage_type = dmg_type,
			victim = parent,
			ability = item,
		})
		self:Destroy()
	end
end
sl_modifier_item_super_giant_ring_strike_debuff = __TS__Decorate(
	{ registerModifier(nil, "abilities/items/item_super_giant_ring") },
	sl_modifier_item_super_giant_ring_strike_debuff
)
--- 巨人刚戒冷却时间debuff
sl_modifier_item_super_giant_ring_strike_cooldown_debuff = __TS__Class()
sl_modifier_item_super_giant_ring_strike_cooldown_debuff.name =
	"sl_modifier_item_super_giant_ring_strike_cooldown_debuff"
__TS__ClassExtends(sl_modifier_item_super_giant_ring_strike_cooldown_debuff, SLModifierBase_Debuff)
function sl_modifier_item_super_giant_ring_strike_cooldown_debuff.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_item_super_giant_ring_strike_cooldown_debuff.prototype.IsPurgable(self)
	return false
end
function sl_modifier_item_super_giant_ring_strike_cooldown_debuff.prototype.IsPurgeException(self)
	return false
end
function sl_modifier_item_super_giant_ring_strike_cooldown_debuff.prototype.RemoveOnDeath(self)
	return false
end
function sl_modifier_item_super_giant_ring_strike_cooldown_debuff.prototype.IsPermanent(self)
	return true
end
function sl_modifier_item_super_giant_ring_strike_cooldown_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_item_super_giant_ring_strike_cooldown_debuff.prototype.GetTexture(self)
	return self:GetCaster():GetName()
end
sl_modifier_item_super_giant_ring_strike_cooldown_debuff = __TS__Decorate(
	{ registerModifier(nil, "abilities/items/item_super_giant_ring") },
	sl_modifier_item_super_giant_ring_strike_cooldown_debuff
)
return ____exports