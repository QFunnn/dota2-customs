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
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
local ____sl_modifier_bless_10073_display = require("modifiers.bless_modifiers.sl_modifier_bless_10073_display")
local sl_modifier_bless_10073_display = ____sl_modifier_bless_10073_display.sl_modifier_bless_10073_display
--- 10073 灼烧debuff，每层独立计时
____exports.sl_modifier_bless_10073 = __TS__Class()
local sl_modifier_bless_10073 = ____exports.sl_modifier_bless_10073
sl_modifier_bless_10073.name = "sl_modifier_bless_10073"
__TS__ClassExtends(sl_modifier_bless_10073, SLModifierBase_Debuff)
function sl_modifier_bless_10073.prototype.GetDmgPct(self)
	return self._dmg_pct
end
function sl_modifier_bless_10073.prototype.IsHidden(self)
	return true
end
function sl_modifier_bless_10073.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10073.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_bless_10073.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	if not IsValid(caster) or not IsValid(parent) then
		return
	end
	self._dmg_pct = params.dmg_pct
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
	self:StartIntervalThink(1)
	local pid = SParticleManager:CreateGenericParticle(BLESS_PARTICLES.bless_10073, PATTACH_ABSORIGIN_FOLLOW, parent)
	self:AddParticle(pid, false, false, -1, false, false)
	self:_UpdateDisplayModifier()
end
function sl_modifier_bless_10073.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	if IsValid(parent) and IsValid(caster) then
		Timers:CreateTimer(0, function()
			if IsValid(parent) and IsValid(caster) then
				____exports.sl_modifier_bless_10073:_UpdateDisplayModifierStackOnly(parent, caster)
			end
		end)
	end
end
function sl_modifier_bless_10073.prototype.SetSourceBless(self, bless)
	self._source_bless = bless
end
function sl_modifier_bless_10073.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	if not IsValid(caster) or not IsValid(parent) then
		return
	end
	local damage = parent:GetMaxHealth() * self._dmg_pct * 0.01
	local ____table__source_bless_ApplyDamage_result_0 = self._source_bless
	if ____table__source_bless_ApplyDamage_result_0 ~= nil then
		____table__source_bless_ApplyDamage_result_0 = ____table__source_bless_ApplyDamage_result_0:ApplyDamage({
			attacker = caster,
			victim = parent,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
		})
	end
	SLModules.ClientData:PushNumberData(parent, damage, 6)
end
function sl_modifier_bless_10073.prototype.HandleCustomTransmitterData(self, data)
	self._dmg_pct = data.dmg_pct
end
function sl_modifier_bless_10073.prototype.AddCustomTransmitterData(self)
	return { dmg_pct = self._dmg_pct }
end
function sl_modifier_bless_10073.prototype.OnTooltip(self)
	return self._dmg_pct
end
function sl_modifier_bless_10073.prototype._UpdateDisplayModifier(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	____exports.sl_modifier_bless_10073:_UpdateDisplayModifierStatic(parent)
end
function sl_modifier_bless_10073._GetDisplayModifierForCaster(self, parent, caster)
	local all_display_modifiers = parent:FindAllModifiersByName(sl_modifier_bless_10073_display.name)
	if all_display_modifiers then
		for ____, display_modifier in ipairs(all_display_modifiers) do
			if display_modifier:GetCaster() == caster then
				return display_modifier
			end
		end
	end
	return nil
end
function sl_modifier_bless_10073._RemoveDisplayModifierForCaster(self, parent, caster)
	local display_modifier = ____exports.sl_modifier_bless_10073:_GetDisplayModifierForCaster(parent, caster)
	if display_modifier and IsValid(display_modifier) then
		display_modifier:Destroy()
	end
end
function sl_modifier_bless_10073._CalculateStackInfo(self, modifiers)
	local stack_count = #modifiers
	local max_remaining_time = 0
	local dmg_pct = 0
	for ____, modifier in ipairs(modifiers) do
		local remaining_time = modifier:GetRemainingTime()
		if remaining_time > max_remaining_time then
			max_remaining_time = remaining_time
		end
		dmg_pct = modifier:GetDmgPct()
	end
	return { stack_count = stack_count, max_remaining_time = max_remaining_time, dmg_pct = dmg_pct }
end
function sl_modifier_bless_10073._UpdateDisplayModifierStackAndDuration(
	self,
	display_modifier,
	stack_count,
	max_remaining_time
)
	display_modifier:SetStackCount(stack_count)
	if max_remaining_time > 0 then
		display_modifier:SetDuration(max_remaining_time, true)
	end
end
function sl_modifier_bless_10073._UpdateDisplayModifierStatic(self, parent)
	if not IsServer() then
		return
	end
	if not IsValid(parent) then
		return
	end
	local all_modifiers = parent:FindAllSLModifiers(____exports.sl_modifier_bless_10073)
	if not all_modifiers or #all_modifiers == 0 then
		local all_display_modifiers = parent:FindAllModifiersByName(sl_modifier_bless_10073_display.name)
		if all_display_modifiers then
			for ____, display_modifier in ipairs(all_display_modifiers) do
				display_modifier:Destroy()
			end
		end
		return
	end
	local modifiers_by_caster = {}
	for ____, modifier in ipairs(all_modifiers) do
		do
			local caster = modifier:GetCaster()
			if not IsValid(caster) then
				goto __continue44
			end
			if not (modifiers_by_caster[caster] ~= nil) then
				modifiers_by_caster[caster] = {}
			end
			local caster_modifiers = modifiers_by_caster[caster]
			caster_modifiers[#caster_modifiers + 1] = modifier
		end
		::__continue44::
	end
	local existing_display_casters = {}
	local all_display_modifiers = parent:FindAllModifiersByName(sl_modifier_bless_10073_display.name)
	if all_display_modifiers then
		for ____, display_modifier in ipairs(all_display_modifiers) do
			local caster = display_modifier:GetCaster()
			if IsValid(caster) then
				if existing_display_casters[caster] ~= nil then
					display_modifier:Destroy()
				else
					existing_display_casters[caster] = display_modifier
				end
			end
		end
	end
	for caster, caster_modifiers in pairs(modifiers_by_caster) do
		do
			if not IsValid(caster) or not caster_modifiers or #caster_modifiers == 0 then
				goto __continue54
			end
			local ____temp_2 = ____exports.sl_modifier_bless_10073:_CalculateStackInfo(caster_modifiers)
			local stack_count = ____temp_2.stack_count
			local max_remaining_time = ____temp_2.max_remaining_time
			local dmg_pct = ____temp_2.dmg_pct
			local display_modifier = existing_display_casters[caster]
			if not display_modifier then
				display_modifier = parent:AddSLModifier(
					sl_modifier_bless_10073_display,
					{ caster = caster, modifierTable = { dmg_pct = dmg_pct } }
				)
			else
				display_modifier:OnRefresh({ dmg_pct = dmg_pct })
			end
			if display_modifier then
				____exports.sl_modifier_bless_10073:_UpdateDisplayModifierStackAndDuration(
					display_modifier,
					stack_count,
					max_remaining_time
				)
			end
		end
		::__continue54::
	end
	for caster, display_modifier in pairs(existing_display_casters) do
		if not (modifiers_by_caster[caster] ~= nil) then
			if IsValid(display_modifier) then
				display_modifier:Destroy()
			end
		end
	end
end
function sl_modifier_bless_10073._UpdateDisplayModifierStackOnly(self, parent, caster)
	if not IsServer() then
		return
	end
	if not IsValid(parent) or not IsValid(caster) then
		return
	end
	local caster_modifiers = parent:FindAllSLModifiers(____exports.sl_modifier_bless_10073, caster)
	if not caster_modifiers or #caster_modifiers == 0 then
		____exports.sl_modifier_bless_10073:_RemoveDisplayModifierForCaster(parent, caster)
		return
	end
	local stack_count = #caster_modifiers
	local display_modifier = ____exports.sl_modifier_bless_10073:_GetDisplayModifierForCaster(parent, caster)
	if display_modifier then
		display_modifier:SetStackCount(stack_count)
	end
end
sl_modifier_bless_10073 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10073") },
	sl_modifier_bless_10073
)
____exports.sl_modifier_bless_10073 = sl_modifier_bless_10073
return ____exports