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
local ____item_0409_shared = require("abilities.items.item_0409_shared")
local IsRealNonItemAbility = ____item_0409_shared.IsRealNonItemAbility
local ____tianping_set = require("shared.tianping_set")
local TIANPING_ABSORBED_MANA_KEY = ____tianping_set.TIANPING_ABSORBED_MANA_KEY
local HARVEST_INTERVAL = 0.25
____exports.item_0574 = __TS__Class()
local item_0574 = ____exports.item_0574
item_0574.name = "item_0574"
__TS__ClassExtends(item_0574, BaseItem_CS)
function item_0574.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0574.name
end
item_0574 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0574)
____exports.item_0574 = item_0574
--- 【均衡蓄能】固有被动：耗蓝蓄层（层数可见），技能伤害时全数消费爆发。
____exports.modifier_item_0574 = __TS__Class()
local modifier_item_0574 = ____exports.modifier_item_0574
modifier_item_0574.name = "modifier_item_0574"
__TS__ClassExtends(modifier_item_0574, BaseModifier_CS)
function modifier_item_0574.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.accumulatedMana = 0
	self.consumePending = false
end
function modifier_item_0574.GetLocalizationCN(self)
	return {
		name = "均衡蓄能",
		description = "消耗魔法积蓄能量；下一次技能伤害将消耗全部层数，每层提高该次伤害。",
	}
end
function modifier_item_0574.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST, BusinessEvents.ON_DAMAGE_PRE_APPLY_ATTACKER }
end
function modifier_item_0574.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(HARVEST_INTERVAL)
end
function modifier_item_0574.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0574.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local acc = math.max(0, tonumber(parent:GetCustomValue(TIANPING_ABSORBED_MANA_KEY) or 0) or 0)
	if acc <= 0 then
		return
	end
	parent:SetCustomValue(TIANPING_ABSORBED_MANA_KEY, 0)
	self:AddSpentMana(acc)
end
function modifier_item_0574.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or event.caster ~= parent:GetEntityIndex() then
		return
	end
	if event.is_trigger == true then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not IsRealNonItemAbility(nil, castAbility) then
		return
	end
	local level = math.max(0, castAbility:GetLevel() - 1)
	local manaCost = math.max(0, castAbility:GetManaCost(level))
	if manaCost <= 0 then
		return
	end
	self:AddSpentMana(manaCost)
end
function modifier_item_0574.prototype.AddSpentMana(self, mana)
	local ability = self:GetAbility()
	if not ability or mana <= 0 then
		return
	end
	self.accumulatedMana = self.accumulatedMana + mana
	local perStack = math.max(1, ability:GetSpecialValueFor("ability_mana_per_stack"))
	self:SetStackCount(math.floor(self.accumulatedMana / perStack))
end
function modifier_item_0574.prototype.OnDamagePreApplyAttacker_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.ctx.spec.attacker ~= parent then
		return
	end
	if event.ctx.spec.is_base_attack then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ____CheckTag_2 = CheckTag
	local ____opt_0 = event.ctx.spec.source
	if ____CheckTag_2(nil, ____opt_0 and ____opt_0.damage_tags, DamageTag.NO_PROC) then
		return
	end
	local perStack = math.max(1, ability:GetSpecialValueFor("ability_mana_per_stack"))
	local stacks = math.floor(self.accumulatedMana / perStack)
	if stacks <= 0 then
		return
	end
	local pctPerStack = math.max(0, ability:GetSpecialValueFor("ability_pct_per_stack"))
	local ampPct = stacks * pctPerStack
	if ampPct <= 0 then
		return
	end
	local ____event_final_3, ____mul_4 = event.final, "mul"
	if ____event_final_3[____mul_4] == nil then
		____event_final_3[____mul_4] = {}
	end
	local ____event_final_mul_5 = event.final.mul
	____event_final_mul_5[#____event_final_mul_5 + 1] =
		{ value = 1 + ampPct / 100, source = "item_0574:均衡之右·蓄能爆发" }
	if not self.consumePending then
		self.consumePending = true
		SysTimers:CreateTimer(0.05, function()
			self.consumePending = false
			self.accumulatedMana = 0
			if IsValid(nil, self) and not self:IsNull() then
				self:SetStackCount(0)
			end
			return nil
		end)
	end
end
function modifier_item_0574.prototype.IsHidden(self)
	return false
end
function modifier_item_0574.prototype.IsDebuff(self)
	return false
end
function modifier_item_0574.prototype.IsPurgable(self)
	return false
end
function modifier_item_0574.prototype.GetTexture(self)
	return "item_kaya"
end
modifier_item_0574 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0574)
____exports.modifier_item_0574 = modifier_item_0574
return ____exports