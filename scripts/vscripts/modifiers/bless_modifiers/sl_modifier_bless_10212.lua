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
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
--- 不屈逻辑管理（隐藏）；数字展示走独立 mark Buff
____exports.sl_modifier_bless_10212 = __TS__Class()
local sl_modifier_bless_10212 = ____exports.sl_modifier_bless_10212
sl_modifier_bless_10212.name = "sl_modifier_bless_10212"
__TS__ClassExtends(sl_modifier_bless_10212, SLModifierBase)
function sl_modifier_bless_10212.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._numbers = {}
end
function sl_modifier_bless_10212.prototype.IsHidden(self)
	return true
end
function sl_modifier_bless_10212.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._params = params
	self:_StartClearLoop()
end
function sl_modifier_bless_10212.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	if not params then
		return
	end
	local ____params_debuff_count_2 = params.debuff_count
	if ____params_debuff_count_2 == nil then
		local ____table__params_debuff_count_0 = self._params
		if ____table__params_debuff_count_0 ~= nil then
			____table__params_debuff_count_0 = ____table__params_debuff_count_0.debuff_count
		end
		____params_debuff_count_2 = ____table__params_debuff_count_0
	end
	local ____params_clear_interval_5 = params.clear_interval
	if ____params_clear_interval_5 == nil then
		local ____table__params_clear_interval_3 = self._params
		if ____table__params_clear_interval_3 ~= nil then
			____table__params_clear_interval_3 = ____table__params_clear_interval_3.clear_interval
		end
		____params_clear_interval_5 = ____table__params_clear_interval_3
	end
	self._params = { debuff_count = ____params_debuff_count_2, clear_interval = ____params_clear_interval_5 }
	self:_StartClearLoop()
end
function sl_modifier_bless_10212.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:_StopClearLoop()
	self:_DestroyAllMarks()
end
function sl_modifier_bless_10212.prototype.TryRollLethalImmune(self)
	local ____math_max_10 = math.max
	local ____math_floor_9 = math.floor
	local ____table__params_debuff_count_6 = self._params
	if ____table__params_debuff_count_6 ~= nil then
		____table__params_debuff_count_6 = ____table__params_debuff_count_6.debuff_count
	end
	local ____table__params_debuff_count_6_8 = ____table__params_debuff_count_6
	if ____table__params_debuff_count_6_8 == nil then
		____table__params_debuff_count_6_8 = 1
	end
	local max = ____math_max_10(1, ____math_floor_9(____table__params_debuff_count_6_8))
	local num = RandomInt(1, max)
	for ____, exist in ipairs(self._numbers) do
		if exist == num then
			return { immune = false, number = num }
		end
	end
	return { immune = true, number = num }
end
function sl_modifier_bless_10212.prototype.CommitNumber(self, num)
	for ____, exist in ipairs(self._numbers) do
		if exist == num then
			return
		end
	end
	local ____self__numbers_11 = self._numbers
	____self__numbers_11[#____self__numbers_11 + 1] = num
	self:_AddMarkModifier(num)
	local parent = self:GetParent()
	if IsValid(parent) then
		EmitSoundOn("bless_10212", parent)
	end
end
function sl_modifier_bless_10212.prototype.ClearAllNumbers(self)
	self._numbers = {}
	self:_DestroyAllMarks()
end
function sl_modifier_bless_10212.prototype._AddMarkModifier(self, num)
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	for ____, mod in ipairs(parent:FindAllSLModifiers(____exports.sl_modifier_bless_10212_mark, parent)) do
		if mod:GetMarkNumber() == num then
			return
		end
	end
	local mark = parent:AddSLModifier(
		____exports.sl_modifier_bless_10212_mark,
		{ caster = parent, modifierTable = { mark = num, update_data = 1 } }
	)
	if IsValid(mark) then
		mark:SetStackCount(num)
	end
end
function sl_modifier_bless_10212.prototype._DestroyAllMarks(self)
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	for ____, mod in ipairs(parent:FindAllSLModifiers(____exports.sl_modifier_bless_10212_mark, parent)) do
		mod:Destroy()
	end
end
function sl_modifier_bless_10212.prototype._StartClearLoop(self)
	self:_StopClearLoop()
	local ____table__params_clear_interval_12 = self._params
	if ____table__params_clear_interval_12 ~= nil then
		____table__params_clear_interval_12 = ____table__params_clear_interval_12.clear_interval
	end
	local ____table__params_clear_interval_12_14 = ____table__params_clear_interval_12
	if ____table__params_clear_interval_12_14 == nil then
		____table__params_clear_interval_12_14 = 1
	end
	local interval = ____table__params_clear_interval_12_14
	self._clear_timer = Timers:CreateTimer(interval, function()
		if not IsValid(self) then
			return nil
		end
		self:_ClearOneNumber()
		return interval
	end)
end
function sl_modifier_bless_10212.prototype._StopClearLoop(self)
	if self._clear_timer and Timers:IsValid(self._clear_timer) then
		Timers:RemoveTimer(self._clear_timer)
	end
	self._clear_timer = nil
end
function sl_modifier_bless_10212.prototype._ClearOneNumber(self)
	if #self._numbers == 0 then
		return
	end
	local idx = RandomInt(0, #self._numbers - 1)
	local removed = self._numbers[idx + 1]
	__TS__ArraySplice(self._numbers, idx, 1)
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	for ____, mod in ipairs(parent:FindAllSLModifiers(____exports.sl_modifier_bless_10212_mark, parent)) do
		if mod:GetMarkNumber() == removed then
			mod:Destroy()
			break
		end
	end
end
sl_modifier_bless_10212 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10212") },
	sl_modifier_bless_10212
)
____exports.sl_modifier_bless_10212 = sl_modifier_bless_10212
--- 单个不屈数字的独立显示 Buff
____exports.sl_modifier_bless_10212_mark = __TS__Class()
local sl_modifier_bless_10212_mark = ____exports.sl_modifier_bless_10212_mark
sl_modifier_bless_10212_mark.name = "sl_modifier_bless_10212_mark"
__TS__ClassExtends(sl_modifier_bless_10212_mark, sl_modifier_transmitter_data)
function sl_modifier_bless_10212_mark.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10212_mark.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10212_mark.prototype.IsDebuff(self)
	return true
end
function sl_modifier_bless_10212_mark.prototype.RemoveOnDeath(self)
	return true
end
function sl_modifier_bless_10212_mark.prototype.GetTexture(self)
	return "buff/bless/10212"
end
function sl_modifier_bless_10212_mark.prototype.OnCreated(self, params)
	sl_modifier_transmitter_data.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local ____self_SetStackCount_18 = self.SetStackCount
	local ____params_mark_15 = params
	if ____params_mark_15 ~= nil then
		____params_mark_15 = ____params_mark_15.mark
	end
	local ____params_mark_15_17 = ____params_mark_15
	if ____params_mark_15_17 == nil then
		____params_mark_15_17 = 0
	end
	____self_SetStackCount_18(self, ____params_mark_15_17)
end
function sl_modifier_bless_10212_mark.prototype.GetMarkNumber(self)
	local ____table__params_mark_19 = self._params
	if ____table__params_mark_19 ~= nil then
		____table__params_mark_19 = ____table__params_mark_19.mark
	end
	local ____table__params_mark_19_21 = ____table__params_mark_19
	if ____table__params_mark_19_21 == nil then
		____table__params_mark_19_21 = self:GetStackCount()
	end
	return ____table__params_mark_19_21
end
function sl_modifier_bless_10212_mark.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_bless_10212_mark.prototype.OnTooltip(self)
	return self:GetMarkNumber()
end
sl_modifier_bless_10212_mark = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10212") },
	sl_modifier_bless_10212_mark
)
____exports.sl_modifier_bless_10212_mark = sl_modifier_bless_10212_mark
return ____exports