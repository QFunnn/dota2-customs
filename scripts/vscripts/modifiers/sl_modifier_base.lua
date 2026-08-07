--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__FunctionBind = ____lualib.__TS__FunctionBind
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local BaseModifier = ____dota_ts_adapter.BaseModifier
--- 所有SL修饰器的基类
-- 默认隐藏，不可净化，不是负面效果，永久存在，不会死亡时移除
____exports.SLModifierBase = __TS__Class()
local SLModifierBase = ____exports.SLModifierBase
SLModifierBase.name = "SLModifierBase"
__TS__ClassExtends(SLModifierBase, BaseModifier)
function SLModifierBase.prototype.____constructor(self)
	BaseModifier.prototype.____constructor(self)
	self._attr_map = {}
	self._stack_id_counter = 0
	self._statk_dur_map = {}
	self._stack_queue = {}
	if not IsServer() then
		return
	end
	if self.GetModifierSpellAmplify_Percentage then
		local original_callback = __TS__FunctionBind(self.GetModifierSpellAmplify_Percentage, self)
		self.GetModifierSpellAmplify_Percentage = function(____, event)
			local original_result = original_callback(nil, event)
			if not original_result or not event or not IsServer() then
				return original_result
			end
			local ability = event.inflictor
			local attacker = event.attacker
			if IsValid(ability) and IsValid(attacker) then
				local ability_name = ability.GetAbilityName and ability:GetAbilityName()
				if ability_name then
					local factor = GetAbilitySpellAmplifyFactor(ability_name)
					return original_result * factor
				end
			end
			return original_result
		end
	end
	local ____table_OnDestroy_0
	if self.OnDestroy then
		____table_OnDestroy_0 = __TS__FunctionBind(self.OnDestroy, self)
	else
		____table_OnDestroy_0 = nil
	end
	local original_on_destroy = ____table_OnDestroy_0
	self.OnDestroy = function()
		self:_RemoveParentAllAttrs()
		if original_on_destroy then
			original_on_destroy(nil)
		end
	end
end
function SLModifierBase.prototype.IsHidden(self)
	return true
end
function SLModifierBase.prototype.IsPurgable(self)
	return false
end
function SLModifierBase.prototype.IsDebuff(self)
	return false
end
function SLModifierBase.prototype.IsPermanent(self)
	return true
end
function SLModifierBase.prototype.RemoveOnDeath(self)
	return false
end
function SLModifierBase.prototype.CreateParticle(self, name, attach, owner)
	local ability = self:GetAbility()
	if ability:IsItem() then
		return SParticleManager:CreateItemParticle(ability, name, attach, owner)
	else
		return SParticleManager:CreateAbilityParticle(ability, name, attach, owner)
	end
end
function SLModifierBase.prototype.CreateParticleForPlayer(self, name, attach, owner, player)
	local ability = self:GetAbility()
	if ability:IsItem() then
		return SParticleManager:CreateItemParticle(ability, name, attach, owner, player)
	else
		return SParticleManager:CreateAbilityParticle(ability, name, attach, owner, player)
	end
end
function SLModifierBase.prototype.DestroyParticle(self, particle, immediate)
	SParticleManager:DestroyParticle(particle, immediate)
end
function SLModifierBase.prototype.ReleaseParticleIndex(self, particle)
	SParticleManager:ReleaseParticleIndex(particle)
end
function SLModifierBase.prototype.SetParticleControl(self, particle, control_point, value)
	SParticleManager:SetParticleControl(particle, control_point, value)
end
function SLModifierBase.prototype.SetParticleControlEnt(
	self,
	particle,
	control_point,
	unit,
	particle_attach,
	attachment,
	offset,
	lock_orientation
)
	SParticleManager:SetParticleControlEnt(
		particle,
		control_point,
		unit,
		particle_attach,
		attachment,
		offset,
		lock_orientation
	)
end
function SLModifierBase.prototype.SetParticleControlTransform(self, fx_index, point, origin, q_angles)
	SParticleManager:SetParticleControlTransform(fx_index, point, origin, q_angles)
end
function SLModifierBase.prototype.SetParticleControlTransformForward(self, fx_index, point, origin, forward)
	SParticleManager:SetParticleControlTransformForward(fx_index, point, origin, forward)
end
function SLModifierBase.prototype.SetParticleAlwaysSimulate(self, pid)
	SParticleManager:SetParticleAlwaysSimulate(pid)
end
function SLModifierBase.prototype.AddStatusEffect(self, unit, effect)
	local ability = self:GetAbility()
	local ____type = ability:IsItem() and 2 or 3
	return SParticleManager:AddStatusEffect(unit, effect, ____type, ability)
end
function SLModifierBase.prototype._GetParentAttrManager(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local player_id = parent:GetPlayerOwnerID()
	return GlobalAttrManager:Get(player_id)
end
function SLModifierBase.prototype._SetParentAttr(self, name, value)
	local attr_manager = self:_GetParentAttrManager()
	if not attr_manager then
		return
	end
	self._attr_map[name] = true
	attr_manager:SetAttr(tostring(self), name, value)
end
function SLModifierBase.prototype._RemoveParentAllAttrs(self)
	local attr_manager = self:_GetParentAttrManager()
	if not attr_manager then
		return
	end
	for name in pairs(self._attr_map) do
		attr_manager:RemoveAttr(tostring(self), name)
	end
	self._attr_map = {}
end
function SLModifierBase.prototype.AddIndependentModifierStack(self, max)
	local current_stack = self:GetStackCount()
	if not max or current_stack < max then
		self._stack_id_counter = self._stack_id_counter + 1
		self:_AddStackTimer(self._stack_id_counter)
		self:IncrementStackCount()
	else
		local earliest_stack_id = table.remove(self._stack_queue, 1)
		if earliest_stack_id ~= nil then
			local timer_id = self._statk_dur_map[earliest_stack_id]
			if Timers:IsValid(timer_id) then
				Timers:RemoveTimer(timer_id)
			end
			self._statk_dur_map[earliest_stack_id] = nil
		end
		self._stack_id_counter = self._stack_id_counter + 1
		self:_AddStackTimer(self._stack_id_counter)
	end
	self:SetDuration(self:GetDuration(), true)
end
function SLModifierBase.prototype._AddStackTimer(self, stack_id)
	local ____self__stack_queue_1 = self._stack_queue
	____self__stack_queue_1[#____self__stack_queue_1 + 1] = stack_id
	self._statk_dur_map[stack_id] = Timers:CreateTimer(self:GetDuration(), function()
		if not IsValid(self) then
			return
		end
		self:DecrementStackCount()
		local expired_id = table.remove(self._stack_queue, 1)
		if expired_id ~= nil then
			self._statk_dur_map[expired_id] = nil
		end
		return nil
	end)
end
--- 负面效果基类
-- 默认隐藏，死亡移除，可驱散
____exports.SLModifierBase_Debuff = __TS__Class()
local SLModifierBase_Debuff = ____exports.SLModifierBase_Debuff
SLModifierBase_Debuff.name = "SLModifierBase_Debuff"
__TS__ClassExtends(SLModifierBase_Debuff, ____exports.SLModifierBase)
function SLModifierBase_Debuff.prototype.IsDebuff(self)
	return true
end
function SLModifierBase_Debuff.prototype.RemoveOnDeath(self)
	return true
end
function SLModifierBase_Debuff.prototype.IsPurgable(self)
	return true
end
function SLModifierBase_Debuff.prototype.IsPermanent(self)
	return false
end
____exports.SLModifierBase_MotionBoth = __TS__Class()
local SLModifierBase_MotionBoth = ____exports.SLModifierBase_MotionBoth
SLModifierBase_MotionBoth.name = "SLModifierBase_MotionBoth"
__TS__ClassExtends(SLModifierBase_MotionBoth, ____exports.SLModifierBase)
function SLModifierBase_MotionBoth.prototype.RemoveOnDeath(self)
	return true
end
function SLModifierBase_MotionBoth.prototype.IsPermanent(self)
	return false
end
____exports.SLModifierBase_MotionHorizontal = __TS__Class()
local SLModifierBase_MotionHorizontal = ____exports.SLModifierBase_MotionHorizontal
SLModifierBase_MotionHorizontal.name = "SLModifierBase_MotionHorizontal"
__TS__ClassExtends(SLModifierBase_MotionHorizontal, ____exports.SLModifierBase)
function SLModifierBase_MotionHorizontal.prototype.RemoveOnDeath(self)
	return true
end
function SLModifierBase_MotionHorizontal.prototype.IsPermanent(self)
	return false
end
____exports.SLModifierBase_MotionVertical = __TS__Class()
local SLModifierBase_MotionVertical = ____exports.SLModifierBase_MotionVertical
SLModifierBase_MotionVertical.name = "SLModifierBase_MotionVertical"
__TS__ClassExtends(SLModifierBase_MotionVertical, ____exports.SLModifierBase)
function SLModifierBase_MotionVertical.prototype.RemoveOnDeath(self)
	return true
end
function SLModifierBase_MotionVertical.prototype.IsPermanent(self)
	return false
end
--- 道具自身buff 基类
____exports.SLModifier_ItemIntrinsic = __TS__Class()
local SLModifier_ItemIntrinsic = ____exports.SLModifier_ItemIntrinsic
SLModifier_ItemIntrinsic.name = "SLModifier_ItemIntrinsic"
__TS__ClassExtends(SLModifier_ItemIntrinsic, ____exports.SLModifierBase)
function SLModifier_ItemIntrinsic.prototype.____constructor(self, ...)
	SLModifier_ItemIntrinsic.____super.prototype.____constructor(self, ...)
	self._is_latest_source = true
end
function SLModifier_ItemIntrinsic.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function SLModifier_ItemIntrinsic.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	if self.OnDestroy then
		local original_ondestroy = __TS__FunctionBind(self.OnDestroy, self)
		self.OnDestroy = function()
			if IsServer() then
				self:_ForEachSameSourceModifier(function(____, modifier)
					modifier:OnOtherSourceModifierDestroy(self)
					return false
				end)
			end
			original_ondestroy(nil)
		end
	end
	self:_RefreshIsLatestSource()
end
function SLModifier_ItemIntrinsic.prototype.OnOtherSourceModifierDestroy(self, modifier)
	self:_RefreshIsLatestSource()
end
function SLModifier_ItemIntrinsic.prototype._RefreshIsLatestSource(self, ignore_modifier)
	local creation_time = self:GetCreationTime()
	self._is_latest_source = true
	self:_ForEachSameSourceModifier(function(____, modifier)
		if modifier ~= self and modifier ~= ignore_modifier then
			if modifier:GetCreationTime() > creation_time then
				self._is_latest_source = false
				return true
			end
		end
	end)
end
function SLModifier_ItemIntrinsic.prototype._ForEachSameSourceModifier(self, callback)
	local same_source_modifiers = self:_GetAllSameSourceModifiers()
	for ____, same_source_modifier in ipairs(same_source_modifiers) do
		local all_modifiers = self:GetParent():FindAllModifiersByName(same_source_modifier)
		if not all_modifiers then
			break
		end
		for ____, modifier in ipairs(all_modifiers) do
			do
				if not modifier.OnOtherSourceModifierDestroy then
					SLError(nil, modifier:GetName() .. " has no OnSameSourceModifierDestroy")
					goto __continue72
				end
				if callback(nil, modifier) == true then
					return
				end
			end
			::__continue72::
		end
	end
end
function SLModifier_ItemIntrinsic.prototype.IsLatestSource(self)
	return self._is_latest_source
end
function SLModifier_ItemIntrinsic.prototype._GetAllSameSourceModifiers(self)
	local ____table_GetOtherSameSourceModifiers_2
	if self.GetOtherSameSourceModifiers then
		____table_GetOtherSameSourceModifiers_2 = self:GetOtherSameSourceModifiers()
	else
		____table_GetOtherSameSourceModifiers_2 = {}
	end
	local same_source_modifiers = ____table_GetOtherSameSourceModifiers_2
	same_source_modifiers[#same_source_modifiers + 1] = self:GetName()
	return same_source_modifiers
end
return ____exports