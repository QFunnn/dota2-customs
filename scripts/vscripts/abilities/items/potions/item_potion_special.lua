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
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____item_potion_base = require("abilities.items.potions.item_potion_base")
local BasePotionModifier_CS = ____item_potion_base.BasePotionModifier_CS
local DEFAULT_POTION_DURATION = 120
local P039_BLEED_RATIO = 0.7
local SpecialPotionItemBase = __TS__Class()
SpecialPotionItemBase.name = "SpecialPotionItemBase"
__TS__ClassExtends(SpecialPotionItemBase, BaseItem_CS)
function SpecialPotionItemBase.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 1,
		castAnimation = ACT_DOTA_GENERIC_CHANNEL_1,
		onSuccess = function()
			local caster = self:GetCaster()
			local duration = self:GetPotionDuration()
			self:ApplyPotionModifier(self:GetPotionModifierName(), duration)
			caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
			self:CostItemCharge(1)
		end,
		onInterrupted = function() end,
	}
end
function SpecialPotionItemBase.prototype.GetPotionDuration(self)
	local duration = self:GetSpecialValueFor("ability_duration")
	local ____temp_0
	if duration > 0 then
		____temp_0 = duration
	else
		____temp_0 = DEFAULT_POTION_DURATION
	end
	return ____temp_0
end
____exports.item_P038 = __TS__Class()
local item_P038 = ____exports.item_P038
item_P038.name = "item_P038"
__TS__ClassExtends(item_P038, SpecialPotionItemBase)
function item_P038.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P038_source.name
end
item_P038 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P038)
____exports.item_P038 = item_P038
____exports.modifier_item_P038_source = __TS__Class()
local modifier_item_P038_source = ____exports.modifier_item_P038_source
modifier_item_P038_source.name = "modifier_item_P038_source"
__TS__ClassExtends(modifier_item_P038_source, BasePotionModifier_CS)
function modifier_item_P038_source.GetLocalizationCN(self)
	return { name = "源初", description = "造成伤害时，额外附带纯粹伤害。" }
end
function modifier_item_P038_source.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DEAL_DAMAGE }
end
function modifier_item_P038_source.prototype.OnDealDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) or event.attacker ~= parent then
		return
	end
	if not IsValidAlive(nil, event.victim) or CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ____opt_1 = event.source
	if (____opt_1 and ____opt_1.custom_tag) == "item_P038_extra_pure_damage" then
		return
	end
	local finalDamage = math.max(0, event.final_damage or 0)
	local extraPurePct = math.max(0, ability:GetSpecialValueFor("ability_extra_pure_damage_pct"))
	local extraDamage = finalDamage * (extraPurePct / 100)
	if extraDamage <= 0 then
		return
	end
	Damage:ApplyDamage({
		attacker = parent,
		victim = event.victim,
		damage = extraDamage,
		damage_type = 4,
		ability = ability,
		extra_data = {
			custom_tag = "item_P038_extra_pure_damage",
			source_name = self:GetName(),
		},
	})
end
function modifier_item_P038_source.prototype.GetTexture(self)
	return "item_P038"
end
modifier_item_P038_source = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P038_source)
____exports.modifier_item_P038_source = modifier_item_P038_source
____exports.item_P039 = __TS__Class()
local item_P039 = ____exports.item_P039
item_P039.name = "item_P039"
__TS__ClassExtends(item_P039, SpecialPotionItemBase)
function item_P039.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P039_unyielding.name
end
item_P039 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P039)
____exports.item_P039 = item_P039
____exports.modifier_item_P039_unyielding = __TS__Class()
local modifier_item_P039_unyielding = ____exports.modifier_item_P039_unyielding
modifier_item_P039_unyielding.name = "modifier_item_P039_unyielding"
__TS__ClassExtends(modifier_item_P039_unyielding, BasePotionModifier_CS)
function modifier_item_P039_unyielding.GetLocalizationCN(self)
	return { name = "不屈", description = "将部分直接伤害延后为流血伤害。" }
end
function modifier_item_P039_unyielding.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_item_P039_unyielding.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) or event.ctx.spec.victim ~= parent then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local shiftPct = math.max(0, ability:GetSpecialValueFor("ability_shift_damage_pct"))
	local bleedDuration = math.max(0, ability:GetSpecialValueFor("ability_bleed_duration"))
	if shiftPct <= 0 or bleedDuration <= 0 then
		return
	end
	local shiftedDamage = math.max(0, event.final.base) * (shiftPct / 100)
	if shiftedDamage <= 0 then
		return
	end
	local ____event_final_3, ____add_4 = event.final, "add"
	if ____event_final_3[____add_4] == nil then
		____event_final_3[____add_4] = {}
	end
	local ____event_final_add_5 = event.final.add
	____event_final_add_5[#____event_final_add_5 + 1] = { value = -shiftedDamage, source = "item_P039:伤害转化" }
	local sourceFinalDamage = shiftedDamage / P039_BLEED_RATIO
	Timers:CreateTimer(FrameTime(), function()
		if not IsValidAlive(nil, parent) then
			return
		end
		local roomDamageSource = self:GetRoomDamageSource(parent)
		if not roomDamageSource then
			WarningPrint("item_P039 未找到房间伤害傀儡，流血转化未施加", parent:GetUnitName())
			return
		end
		AddDeBuffStatus(
			nil,
			parent,
			roomDamageSource,
			ability,
			DebuffStatusType.BLEED,
			{ source_final_damage = sourceFinalDamage, duration = bleedDuration }
		)
	end)
end
function modifier_item_P039_unyielding.prototype.GetRoomDamageSource(self, parent)
	local ____this_7
	____this_7 = parent
	local ____opt_6 = ____this_7.IsHero
	if not (____opt_6 and ____opt_6(____this_7)) then
		return nil
	end
	local room = MyGameRoomManager and MyGameRoomManager:GetPlayerRoom(parent:GetPlayerOwnerID())
	local roomDummy = room and room:GetRoomDummy()
	if not roomDummy or not IsValid(nil, roomDummy) or roomDummy:IsNull() then
		return nil
	end
	return roomDummy
end
function modifier_item_P039_unyielding.prototype.GetTexture(self)
	return "item_P039"
end
modifier_item_P039_unyielding = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P039_unyielding)
____exports.modifier_item_P039_unyielding = modifier_item_P039_unyielding
return ____exports