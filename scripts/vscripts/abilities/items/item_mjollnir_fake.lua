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
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifier_ItemIntrinsic = ____sl_modifier_base.SLModifier_ItemIntrinsic
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_item_base = require("abilities.items._sl_item_base")
local SLItemBase = _____sl_item_base.SLItemBase
--- 雷神之锤（伪）
-- <h1>被动：静电护盾</h1>自身在受到攻击时，若攻击者处于自身%shock_range%范围内，则有%shock_chance%%%的概率对攻击者释放闪电冲击，造成%shock_damage%点魔法伤害。\n\n<h1>被动：连环闪电</h1>攻击有%chain_chance%%%几率释放一道连环闪电，在%chain_radius%范围内%chain_strikes%个目标之间跳跃，每次造成%chain_damage%点魔法伤害。触发闪电时无视闪避。
____exports.item_mjollnir_fake = __TS__Class()
local item_mjollnir_fake = ____exports.item_mjollnir_fake
item_mjollnir_fake.name = "item_mjollnir_fake"
__TS__ClassExtends(item_mjollnir_fake, SLItemBase)
function item_mjollnir_fake.prototype.GetIntrinsicModifierName(self)
	return ____exports.sl_modifier_item_mjollnir_fake.name
end
item_mjollnir_fake = __TS__Decorate({ registerAbility(nil) }, item_mjollnir_fake)
____exports.item_mjollnir_fake = item_mjollnir_fake
____exports.sl_modifier_item_mjollnir_fake = __TS__Class()
local sl_modifier_item_mjollnir_fake = ____exports.sl_modifier_item_mjollnir_fake
sl_modifier_item_mjollnir_fake.name = "sl_modifier_item_mjollnir_fake"
__TS__ClassExtends(sl_modifier_item_mjollnir_fake, SLModifier_ItemIntrinsic)
function sl_modifier_item_mjollnir_fake.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end
function sl_modifier_item_mjollnir_fake.prototype.GetModifierPreAttack_BonusDamage(self)
	return self:GetAbilitySpecialValueFor("bonus_damage")
end
function sl_modifier_item_mjollnir_fake.prototype.GetModifierAttackSpeedBonus_Constant(self)
	return self:GetAbilitySpecialValueFor("bonus_attack_speed")
end
function sl_modifier_item_mjollnir_fake.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
end
function sl_modifier_item_mjollnir_fake.prototype.OnAttackLanded(self, event)
	local ____event_0 = event
	local attacker = ____event_0.attacker
	local target = ____event_0.target
	local record = ____event_0.record
	if not IsServer() then
		return
	end
	if not self:IsLatestSource() then
		return
	end
	local parent = self:GetParent()
	if parent:IsIllusion() then
		return
	end
	if parent == target then
		self:_TryTriggerShock(parent, attacker)
	elseif parent == attacker then
		self:_TryTriggerChain(parent, target)
	end
end
function sl_modifier_item_mjollnir_fake.prototype._TryTriggerShock(self, parent, target)
	if
		UnitFilter(
			target,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			DOTA_UNIT_TARGET_FLAG_NO_INVIS,
			parent:GetTeam()
		) ~= UF_SUCCESS
	then
		return
	end
	local shock_range = self:GetAbilitySpecialValueFor("shock_range")
	local distance = SLVector:Distance2D(parent:GetAbsOrigin(), target:GetAbsOrigin())
	if distance > shock_range then
		return
	end
	local shock_chance = self:GetAbilitySpecialValueFor("shock_chance")
	if not RollPseudoRandomPercentage(shock_chance, 1001, parent) then
		return
	end
	local pid = self:CreateParticle(ITEM_PARTICLES.item_mjollnir_fake_shock, PATTACH_ABSORIGIN_FOLLOW, parent)
	self:SetParticleControlEnt(pid, 0, parent, PATTACH_POINT_FOLLOW, "attach_hitloc", parent:GetAbsOrigin())
	self:SetParticleControlEnt(pid, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin())
	self:ReleaseParticleIndex(pid)
	local damage = self:GetAbilitySpecialValueFor("shock_damage")
	ApplyDamage({
		attacker = parent,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		victim = target,
		ability = self:GetAbility(),
	})
end
function sl_modifier_item_mjollnir_fake.prototype._TryTriggerChain(self, parent, target)
	if Timers:IsValid(self._cd_timer) then
		return
	end
	if
		UnitFilter(
			target,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			DOTA_UNIT_TARGET_FLAG_NO_INVIS,
			parent:GetTeam()
		) ~= UF_SUCCESS
	then
		return
	end
	local chain_chance = self:GetAbilitySpecialValueFor("chain_chance")
	if not RollPseudoRandomPercentage(chain_chance, 1002, parent) then
		return
	end
	self:_ShootChain(parent, target)
end
function sl_modifier_item_mjollnir_fake.prototype._ShootChain(self, parent, target)
	local cd = self:GetAbilitySpecialValueFor("chain_cooldown")
	self._cd_timer = Timers:CreateTimer(cd, function() end)
	local chain_delay = self:GetAbilitySpecialValueFor("chain_delay")
	local chain_radius = self:GetAbilitySpecialValueFor("chain_radius")
	local chain_strikes = self:GetAbilitySpecialValueFor("chain_strikes")
	local left_jump_times = chain_strikes
	self:_ShootLightningChain(parent, target)
	target:EmitSound("item_mjollnir_fake.Chain_Lightning")
	local hitted_targets = {}
	hitted_targets[target] = true
	local parent_team = parent:GetTeam()
	local current_unit = target
	Timers:CreateTimer(chain_delay, function()
		if not IsValid(self) then
			return
		end
		if not IsValid(current_unit) then
			return
		end
		left_jump_times = left_jump_times - 1
		if left_jump_times <= 0 then
			return
		end
		local valid_targets = FindUnitsInRadius(
			parent_team,
			current_unit:GetAbsOrigin(),
			nil,
			chain_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			DOTA_UNIT_TARGET_FLAG_NO_INVIS,
			FIND_CLOSEST,
			false
		)
		local next_target = nil
		for ____, target in ipairs(valid_targets) do
			do
				if hitted_targets[target] then
					goto __continue28
				end
				next_target = target
				break
			end
			::__continue28::
		end
		if not IsValidAlive(next_target) then
			return
		end
		hitted_targets[next_target] = true
		next_target:EmitSound("item_mjollnir_fake.Chain_Lightning.Jump")
		self:_ShootLightningChain(current_unit, next_target)
		current_unit = next_target
		return chain_delay
	end)
end
function sl_modifier_item_mjollnir_fake.prototype._ShootLightningChain(self, from, to)
	local pid = self:CreateParticle(ITEM_PARTICLES.item_mjollnir_fake_chain, PATTACH_ABSORIGIN_FOLLOW, from)
	self:SetParticleControlEnt(pid, 0, from, PATTACH_POINT_FOLLOW, "attach_hitloc", from:GetAbsOrigin())
	self:SetParticleControlEnt(pid, 1, to, PATTACH_POINT_FOLLOW, "attach_hitloc", to:GetAbsOrigin())
	self:ReleaseParticleIndex(pid)
	local chain_damage = self:GetAbilitySpecialValueFor("chain_damage")
	ApplyDamage({
		attacker = self:GetParent(),
		damage = chain_damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		victim = to,
		ability = self:GetAbility(),
	})
end
sl_modifier_item_mjollnir_fake =
	__TS__Decorate({ registerModifier(nil, "abilities/items/item_mjollnir_fake") }, sl_modifier_item_mjollnir_fake)
____exports.sl_modifier_item_mjollnir_fake = sl_modifier_item_mjollnir_fake
return ____exports