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
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_item_base = require("abilities.items._sl_item_base")
local SLItemBase = _____sl_item_base.SLItemBase
____exports.item_bless_10139 = __TS__Class()
local item_bless_10139 = ____exports.item_bless_10139
item_bless_10139.name = "item_bless_10139"
__TS__ClassExtends(item_bless_10139, SLItemBase)
function item_bless_10139.prototype.CastFilterResultTarget(self, target)
	if not target:IsRealHero() then
		return UF_FAIL_CREEP
	end
	local caster = self:GetCaster()
	if not caster:IsRealHero() then
		return UF_FAIL_CREEP
	end
	if target == caster then
		return UF_FAIL_OTHER
	end
	if target:GetTeamNumber() ~= caster:GetTeamNumber() then
		return UF_FAIL_ENEMY
	end
	return UF_SUCCESS
end
function item_bless_10139.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if not IsValidAlive(caster) or not IsValidAlive(target) then
		return
	end
	if not target:IsRealHero() then
		return
	end
	if not caster:IsRealHero() then
		return
	end
	if not target:IsAssignedHero() then
		return
	end
	if target:HasSLModifier(____exports.sl_modifier_bless_10139_self) then
		return
	end
	if caster:HasSLModifier(____exports.sl_modifier_bless_10139_self) then
		return
	end
	caster:AddSLModifier(____exports.sl_modifier_bless_10139_self, {
		caster = caster,
		modifierTable = __TS__ObjectAssign({}, self._attrs, { bind_entity_id = target:GetEntityIndex() }),
	})
	target:AddSLModifier(____exports.sl_modifier_bless_10139_ally, {
		caster = caster,
		modifierTable = __TS__ObjectAssign({}, self._attrs, { bind_entity_id = caster:GetEntityIndex() }),
	})
	self:Destroy()
end
function item_bless_10139.prototype.SetItemBless10139Attribute(self, attrs)
	self._attrs = attrs
end
item_bless_10139 = __TS__Decorate({ registerAbility(nil) }, item_bless_10139)
____exports.item_bless_10139 = item_bless_10139
____exports.sl_modifier_bless_10139_self = __TS__Class()
local sl_modifier_bless_10139_self = ____exports.sl_modifier_bless_10139_self
sl_modifier_bless_10139_self.name = "sl_modifier_bless_10139_self"
__TS__ClassExtends(sl_modifier_bless_10139_self, sl_modifier_transmitter_data)
function sl_modifier_bless_10139_self.prototype.____constructor(self, ...)
	sl_modifier_transmitter_data.prototype.____constructor(self, ...)
	self._invalid_pos_timecount = 0
end
function sl_modifier_bless_10139_self.prototype.CheckState(self)
	local ____MODIFIER_STATE_ROOTED_2 = MODIFIER_STATE_ROOTED
	local ____temp_0
	if self:GetStackCount() == 1 then
		____temp_0 = true
	else
		____temp_0 = nil
	end
	local ____MODIFIER_STATE_NO_UNIT_COLLISION_3 = MODIFIER_STATE_NO_UNIT_COLLISION
	local ____temp_1
	if self:GetStackCount() == 1 then
		____temp_1 = true
	else
		____temp_1 = nil
	end
	return { [____MODIFIER_STATE_ROOTED_2] = ____temp_0, [____MODIFIER_STATE_NO_UNIT_COLLISION_3] = ____temp_1 }
end
function sl_modifier_bless_10139_self.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	}
end
function sl_modifier_bless_10139_self.prototype.OnCreated(self, params)
	sl_modifier_transmitter_data.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	Timers:CreateTimer(function()
		if not IsValid(self) then
			return nil
		end
		self:_OnTimerThink()
		return StaticFrameTime
	end)
end
function sl_modifier_bless_10139_self.prototype._OnTimerThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if parent:IsCurrentlyAnyMotionControlled() then
		return
	end
	local bind_hero = self:_GetBindHero()
	local parent_pos = parent:GetAbsOrigin()
	if not IsValidAlive(bind_hero) or not IsValidAlive(parent) then
		if self:GetStackCount() == 1 then
			self:SetStackCount(0)
			if IsValid(self._effect) then
				self._effect:Destroy()
			end
			FindClearSpaceForUnit(parent, parent_pos, false)
		end
		return
	else
		if self:GetStackCount() == 0 then
			self._effect = SParticleManager:AddStatusEffect(
				parent,
				BLESS_PARTICLES.bless_10139_status_effect,
				0,
				nil,
				MODIFIER_PRIORITY_SUPER_ULTRA
			)
			self:SetStackCount(1)
		end
	end
	local bind_pos = bind_hero:GetAbsOrigin()
	if not self:_IsValidPos(bind_pos) and not self:_IsValidPos(parent_pos) then
		self._invalid_pos_timecount = self._invalid_pos_timecount + StaticFrameTime
		if self._invalid_pos_timecount >= 3 then
			FindClearSpaceForUnit(parent, parent_pos, true)
			FindClearSpaceForUnit(bind_hero, bind_pos, true)
			self._invalid_pos_timecount = 0
		end
	else
		self._invalid_pos_timecount = 0
		local height = 100
		local ____self__params_4 = self._params
		local range = ____self__params_4.range
		local dir_vec = parent_pos:__sub(bind_pos)
		local total_hull = bind_hero:GetHullRadius() * bind_hero:GetModelScale()
			+ parent:GetHullRadius() * parent:GetModelScale()
		local target_pos = bind_pos:__add(SLVector:Normalized2D(dir_vec):__mul(total_hull + range))
		parent:SetAbsOrigin(target_pos:__add(Vector(0, 0, height)))
	end
end
function sl_modifier_bless_10139_self.prototype._IsValidPos(self, pos)
	return GridNav:CanFindPath(pos, pos)
end
function sl_modifier_bless_10139_self.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if IsValid(self._effect) then
		self._effect:Destroy()
	end
	local parent = self:GetParent()
	FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), false)
end
function sl_modifier_bless_10139_self.prototype._GetBindHero(self)
	local id = self._params.bind_entity_id
	if self._bind_hero then
		return self._bind_hero
	end
	self._bind_hero = EntIndexToHScript(id)
	return self._bind_hero
end
function sl_modifier_bless_10139_self.prototype.GetModifierAttackRangeBonus(self)
	local ____temp_5
	if self:GetStackCount() == 1 then
		____temp_5 = self._params.extra_range
	else
		____temp_5 = 0
	end
	return ____temp_5
end
function sl_modifier_bless_10139_self.prototype.GetModifierCastRangeBonusStacking(self)
	local ____temp_6
	if self:GetStackCount() == 1 then
		____temp_6 = self._params.extra_range
	else
		____temp_6 = 0
	end
	return ____temp_6
end
function sl_modifier_bless_10139_self.prototype.GetModifierHealthRegenPercentage(self)
	local ____temp_7
	if self:GetStackCount() == 1 then
		____temp_7 = self._params.hp_regen_pct
	else
		____temp_7 = 0
	end
	return ____temp_7
end
sl_modifier_bless_10139_self =
	__TS__Decorate({ registerModifier(nil, "abilities/items/item_bless_10139") }, sl_modifier_bless_10139_self)
____exports.sl_modifier_bless_10139_self = sl_modifier_bless_10139_self
____exports.sl_modifier_bless_10139_ally = __TS__Class()
local sl_modifier_bless_10139_ally = ____exports.sl_modifier_bless_10139_ally
sl_modifier_bless_10139_ally.name = "sl_modifier_bless_10139_ally"
__TS__ClassExtends(sl_modifier_bless_10139_ally, sl_modifier_transmitter_data)
function sl_modifier_bless_10139_ally.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10139_ally.prototype._GetBindHero(self)
	local id = self._params.bind_entity_id
	if self._bind_hero then
		return self._bind_hero
	end
	self._bind_hero = EntIndexToHScript(id)
	return self._bind_hero
end
function sl_modifier_bless_10139_ally.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT, MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT }
end
function sl_modifier_bless_10139_ally.prototype.OnCreated(self, params)
	sl_modifier_transmitter_data.prototype.OnCreated(self, params)
	self:StartIntervalThink(0.3)
end
function sl_modifier_bless_10139_ally.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local bind_hero = self:_GetBindHero()
	if IsValidAlive(bind_hero) then
		if self:GetStackCount() == 0 then
			self:SetStackCount(1)
		end
	else
		if self:GetStackCount() == 1 then
			self:SetStackCount(0)
		end
	end
end
function sl_modifier_bless_10139_ally.prototype.GetModifierIgnoreMovespeedLimit(self)
	return self:GetStackCount() == 1 and 1 or 0
end
function sl_modifier_bless_10139_ally.prototype.GetModifierMoveSpeedBonus_Constant(self)
	if self:GetStackCount() == 0 then
		return 0
	end
	local ____self__params_8 = self._params
	local mp_pct = ____self__params_8.mp_pct
	local bind_hero = self:_GetBindHero()
	local move_speed = bind_hero:GetMoveSpeedModifier(bind_hero:GetBaseMoveSpeed(), true)
	return move_speed * mp_pct * 0.01
end
sl_modifier_bless_10139_ally =
	__TS__Decorate({ registerModifier(nil, "abilities/items/item_bless_10139") }, sl_modifier_bless_10139_ally)
____exports.sl_modifier_bless_10139_ally = sl_modifier_bless_10139_ally
return ____exports