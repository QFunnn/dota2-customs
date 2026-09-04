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
local DUEL_CUSTOM_TAG = "item_0594_duel"
____exports.item_0594 = __TS__Class()
local item_0594 = ____exports.item_0594
item_0594.name = "item_0594"
__TS__ClassExtends(item_0594, BaseItem_CS)
function item_0594.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0594.name
end
item_0594 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0594)
____exports.item_0594 = item_0594
--- 固有监听：单挑目标（周围无其他敌人）→ 对其增伤 + 受其减伤。
____exports.modifier_item_0594 = __TS__Class()
local modifier_item_0594 = ____exports.modifier_item_0594
modifier_item_0594.name = "modifier_item_0594"
__TS__ClassExtends(modifier_item_0594, BaseModifier_CS)
function modifier_item_0594.GetLocalizationCN(self)
	return {
		name = "孤军之王",
		description = "周围没有其他敌人的目标：你对其造成的伤害提高，受到其造成的伤害降低。",
	}
end
function modifier_item_0594.prototype.DeclareEvents(self)
	return {
		BusinessEvents.ON_DAMAGE_PRE_APPLY_ATTACKER,
		BusinessEvents.ON_DAMAGE_PRE_APPLY,
		{ event = BusinessEvents.ON_HP_LOSS, target = { scope = "global" } },
	}
end
function modifier_item_0594.prototype.IsHidden(self)
	return true
end
function modifier_item_0594.prototype.IsPurgable(self)
	return false
end
function modifier_item_0594.prototype.OnDamagePreApplyAttacker_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.ctx.spec.attacker ~= parent then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ____opt_0 = event.ctx.spec.source
	if (____opt_0 and ____opt_0.custom_tag) == DUEL_CUSTOM_TAG then
		return
	end
	local victim = event.ctx.spec.victim
	if not victim or not IsValidAlive(nil, victim) or victim:IsBuilding() then
		return
	end
	if victim:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local bonusPct = math.max(0, ability:GetSpecialValueFor("ability_damage_bonus_pct"))
	if bonusPct <= 0 or not self:IsDueling(victim) then
		return
	end
	local ____event_final_2, ____mul_3 = event.final, "mul"
	if ____event_final_2[____mul_3] == nil then
		____event_final_2[____mul_3] = {}
	end
	local ____event_final_mul_4 = event.final.mul
	____event_final_mul_4[#____event_final_mul_4 + 1] =
		{ value = 1 + bonusPct / 100, source = "item_0594:孤军之王" }
end
function modifier_item_0594.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.ctx.spec.victim ~= parent then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local attacker = event.ctx.spec.attacker
	if not attacker or attacker == parent or not IsValidAlive(nil, attacker) or attacker:IsBuilding() then
		return
	end
	if attacker:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local reductionPct = math.max(0, ability:GetSpecialValueFor("ability_damage_reduction_pct"))
	if reductionPct <= 0 or not self:IsDueling(attacker) then
		return
	end
	local ____event_final_5, ____mul_6 = event.final, "mul"
	if ____event_final_5[____mul_6] == nil then
		____event_final_5[____mul_6] = {}
	end
	local ____event_final_mul_7 = event.final.mul
	____event_final_mul_7[#____event_final_mul_7 + 1] = {
		value = math.max(0, 1 - reductionPct / 100),
		source = "item_0594:孤军之王",
	}
end
function modifier_item_0594.prototype.OnHpLoss_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local victim = event.victim
	if not victim or victim == parent or not IsValidAlive(nil, victim) then
		return
	end
	if victim:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if victim:IsBuilding() then
		return
	end
	local source = event.source
	local isDotDamage = (source and source.debuff_status) == DebuffStatusType.BLEED
		or (source and source.debuff_status) == DebuffStatusType.POISON
		or (source and source.debuff_status) == DebuffStatusType.BURN
		or CheckTag(nil, source and source.damage_tags, DamageTag.DOT)
	if not isDotDamage then
		return
	end
	local dotDamage = math.max(0, event.final_damage or 0)
	if dotDamage <= 0 then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local bonusPct = math.max(0, ability:GetSpecialValueFor("ability_damage_bonus_pct"))
	if bonusPct <= 0 or not self:IsDueling(victim) then
		return
	end
	Damage:ApplyDamage({
		victim = victim,
		attacker = parent,
		damage = dotDamage * (bonusPct / 100),
		damage_type = 4,
		ability = ability,
		extra_data = {
			damage_tags = DamageTag.NO_PROC,
			custom_tag = DUEL_CUSTOM_TAG,
			source_name = "item_0594:孤军之王",
		},
	})
end
function modifier_item_0594.prototype.IsDueling(self, target)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability then
		return false
	end
	local radius = math.max(0, ability:GetSpecialValueFor("ability_duel_radius"))
	if radius <= 0 then
		return false
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		target:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if enemy == target then
				goto __continue35
			end
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue35
			end
			return false
		end
		::__continue35::
	end
	return true
end
modifier_item_0594 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0594)
____exports.modifier_item_0594 = modifier_item_0594
return ____exports