--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
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
____exports.sl_modifier_bless_10212 = __TS__Class()
local sl_modifier_bless_10212 = ____exports.sl_modifier_bless_10212
sl_modifier_bless_10212.name = "sl_modifier_bless_10212"
__TS__ClassExtends(sl_modifier_bless_10212, sl_modifier_transmitter_data)
function sl_modifier_bless_10212.prototype.____constructor(self, ...)
	sl_modifier_transmitter_data.prototype.____constructor(self, ...)
	self._numbers = {}
end
function sl_modifier_bless_10212.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10212.prototype.GetTexture(self)
	return "buff/bless/10212"
end
function sl_modifier_bless_10212.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	params.update_data = 1
	self:_ApplyParams(params)
	self:_StartClearLoop()
end
function sl_modifier_bless_10212.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	if not self._params then
		return
	end
	local ____self__params_1 = self._params
	local ____params_debuff_count_0 = params.debuff_count
	if ____params_debuff_count_0 == nil then
		____params_debuff_count_0 = self._params.debuff_count
	end
	____self__params_1.debuff_count = ____params_debuff_count_0
	local ____self__params_3 = self._params
	local ____params_clear_interval_2 = params.clear_interval
	if ____params_clear_interval_2 == nil then
		____params_clear_interval_2 = self._params.clear_interval
	end
	____self__params_3.clear_interval = ____params_clear_interval_2
	self._params.update_data = 1
	self:_ApplyParams(self._params)
	self:_StartClearLoop()
end
function sl_modifier_bless_10212.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self._clear_timer and Timers:IsValid(self._clear_timer) then
		Timers:RemoveTimer(self._clear_timer)
	end
	local parent = self:GetParent()
	if IsValid(parent) then
		for ____, mod in ipairs(parent:FindAllSLModifiers(____exports.sl_modifier_bless_10212_mark, parent)) do
			mod:Destroy()
		end
	end
end
function sl_modifier_bless_10212.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_bless_10212.prototype.OnTooltip(self)
	return #self._numbers
end
function sl_modifier_bless_10212.prototype.TryRollLethalImmune(self)
	local ____math_max_8 = math.max
	local ____math_floor_7 = math.floor
	local ____table__params_debuff_count_4 = self._params
	if ____table__params_debuff_count_4 ~= nil then
		____table__params_debuff_count_4 = ____table__params_debuff_count_4.debuff_count
	end
	local ____table__params_debuff_count_4_6 = ____table__params_debuff_count_4
	if ____table__params_debuff_count_4_6 == nil then
		____table__params_debuff_count_4_6 = 1
	end
	local max = ____math_max_8(1, ____math_floor_7(____table__params_debuff_count_4_6))
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
	local ____self__numbers_9 = self._numbers
	____self__numbers_9[#____self__numbers_9 + 1] = num
	self:_AddMarkModifier(num)
	self:SetStackCount(#self._numbers)
	self:SendBuffRefreshToClients()
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
	mark:SetStackCount(num)
end
function sl_modifier_bless_10212.prototype._StartClearLoop(self)
	if self._clear_timer and Timers:IsValid(self._clear_timer) then
		Timers:RemoveTimer(self._clear_timer)
	end
	local ____table__params_clear_interval_10 = self._params
	if ____table__params_clear_interval_10 ~= nil then
		____table__params_clear_interval_10 = ____table__params_clear_interval_10.clear_interval
	end
	local ____table__params_clear_interval_10_12 = ____table__params_clear_interval_10
	if ____table__params_clear_interval_10_12 == nil then
		____table__params_clear_interval_10_12 = 1
	end
	local interval = ____table__params_clear_interval_10_12
	self._clear_timer = Timers:CreateTimer(interval, function()
		if not IsValid(self) then
			return nil
		end
		self:_ClearOneNumber()
		return interval
	end)
end
function sl_modifier_bless_10212.prototype._ClearOneNumber(self)
	if #self._numbers == 0 then
		return
	end
	local idx = RandomInt(0, #self._numbers - 1)
	local removed = self._numbers[idx + 1]
	__TS__ArraySplice(self._numbers, idx, 1)
	local parent = self:GetParent()
	if IsValid(parent) then
		for ____, mod in ipairs(parent:FindAllSLModifiers(____exports.sl_modifier_bless_10212_mark, parent)) do
			if mod:GetMarkNumber() == removed then
				mod:Destroy()
				break
			end
		end
	end
	self:SetStackCount(#self._numbers)
	self:SendBuffRefreshToClients()
end
sl_modifier_bless_10212 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10212") },
	sl_modifier_bless_10212
)
____exports.sl_modifier_bless_10212 = sl_modifier_bless_10212
____exports.sl_modifier_bless_10212_mark = __TS__Class()
local sl_modifier_bless_10212_mark = ____exports.sl_modifier_bless_10212_mark
sl_modifier_bless_10212_mark.name = "sl_modifier_bless_10212_mark"
__TS__ClassExtends(sl_modifier_bless_10212_mark, sl_modifier_transmitter_data)
function sl_modifier_bless_10212_mark.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10212_mark.prototype.IsDebuff(self)
	return true
end
function sl_modifier_bless_10212_mark.prototype.GetTexture(self)
	return "buff/bless/10212"
end
function sl_modifier_bless_10212_mark.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	params.update_data = 1
	self:_ApplyParams(params)
	local ____self_SetStackCount_14 = self.SetStackCount
	local ____params_mark_13 = params.mark
	if ____params_mark_13 == nil then
		____params_mark_13 = 0
	end
	____self_SetStackCount_14(self, ____params_mark_13)
end
function sl_modifier_bless_10212_mark.prototype.GetMarkNumber(self)
	local ____table__params_mark_15 = self._params
	if ____table__params_mark_15 ~= nil then
		____table__params_mark_15 = ____table__params_mark_15.mark
	end
	local ____table__params_mark_15_17 = ____table__params_mark_15
	if ____table__params_mark_15_17 == nil then
		____table__params_mark_15_17 = self:GetStackCount()
	end
	return ____table__params_mark_15_17
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