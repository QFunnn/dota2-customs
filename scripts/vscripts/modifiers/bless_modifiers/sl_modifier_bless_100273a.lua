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
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_100273a = __TS__Class()
local sl_modifier_bless_100273a = ____exports.sl_modifier_bless_100273a
sl_modifier_bless_100273a.name = "sl_modifier_bless_100273a"
__TS__ClassExtends(sl_modifier_bless_100273a, sl_modifier_transmitter_data)
function sl_modifier_bless_100273a.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_100273a.prototype.GetTexture(self)
	return "buff/bless/100273a"
end
function sl_modifier_bless_100273a.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_EVENT_ON_TREE_CUT_DOWN,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end
function sl_modifier_bless_100273a.prototype.SetBless(self, bless)
	self._bless = bless
end
function sl_modifier_bless_100273a.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local ____params_1 = params
	local ____params_pct_0 = params.pct
	if ____params_pct_0 == nil then
		____params_pct_0 = 0
	end
	____params_1.pct = ____params_pct_0
	local ____params_3 = params
	local ____params_total_gold_2 = params.total_gold
	if ____params_total_gold_2 == nil then
		____params_total_gold_2 = 0
	end
	____params_3.total_gold = ____params_total_gold_2
	local ____params_5 = params
	local ____params_total_hp_4 = params.total_hp
	if ____params_total_hp_4 == nil then
		____params_total_hp_4 = 0
	end
	____params_5.total_hp = ____params_total_hp_4
	local ____params_7 = params
	local ____params_total_spell_amp_6 = params.total_spell_amp
	if ____params_total_spell_amp_6 == nil then
		____params_total_spell_amp_6 = 0
	end
	____params_7.total_spell_amp = ____params_total_spell_amp_6
	local ____params_9 = params
	local ____params_gold_per_tree_8 = params.gold_per_tree
	if ____params_gold_per_tree_8 == nil then
		____params_gold_per_tree_8 = 0
	end
	____params_9.gold_per_tree = ____params_gold_per_tree_8
	local ____params_11 = params
	local ____params_hp_per_tree_10 = params.hp_per_tree
	if ____params_hp_per_tree_10 == nil then
		____params_hp_per_tree_10 = 0
	end
	____params_11.hp_per_tree = ____params_hp_per_tree_10
	local ____params_13 = params
	local ____params_spell_amp_per_tree_12 = params.spell_amp_per_tree
	if ____params_spell_amp_per_tree_12 == nil then
		____params_spell_amp_per_tree_12 = 0
	end
	____params_13.spell_amp_per_tree = ____params_spell_amp_per_tree_12
	params.update_data = 1
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParams(params)
	self:SetStackCount(0)
end
function sl_modifier_bless_100273a.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	if self._params then
		local ____self__params_15 = self._params
		local ____params_pct_14 = params.pct
		if ____params_pct_14 == nil then
			____params_pct_14 = self._params.pct
		end
		____self__params_15.pct = ____params_pct_14
		local ____self__params_17 = self._params
		local ____params_gold_per_tree_16 = params.gold_per_tree
		if ____params_gold_per_tree_16 == nil then
			____params_gold_per_tree_16 = self._params.gold_per_tree
		end
		____self__params_17.gold_per_tree = ____params_gold_per_tree_16
		local ____self__params_19 = self._params
		local ____params_hp_per_tree_18 = params.hp_per_tree
		if ____params_hp_per_tree_18 == nil then
			____params_hp_per_tree_18 = self._params.hp_per_tree
		end
		____self__params_19.hp_per_tree = ____params_hp_per_tree_18
		local ____self__params_21 = self._params
		local ____params_spell_amp_per_tree_20 = params.spell_amp_per_tree
		if ____params_spell_amp_per_tree_20 == nil then
			____params_spell_amp_per_tree_20 = self._params.spell_amp_per_tree
		end
		____self__params_21.spell_amp_per_tree = ____params_spell_amp_per_tree_20
		self._params.update_data = 1
		self:_ApplyParams(self._params)
	end
end
function sl_modifier_bless_100273a.prototype.OnTreeCutDown(self, event)
	if not IsServer() then
		return
	end
	local bless = self._bless
	if not bless then
		return
	end
	local isGotBook = bless:IsGotBook()
	if isGotBook then
		return
	end
	local parent = self:GetParent()
	local unit = event.unit
	if unit ~= parent then
		return
	end
	if not self._params then
		return
	end
	local ____self__params_pct_22 = self._params.pct
	if ____self__params_pct_22 == nil then
		____self__params_pct_22 = 0
	end
	local pct = ____self__params_pct_22
	if pct > 0 and RollPercentage(pct) then
		local box = SLAddItemToHeroAndDropWhenInventoryFull("item_bless_box_3", parent)
		if not IsValid(box) then
			return
		end
		box:SetSellable(false)
		bless:SetGotBook(true)
		local args = {
			BlessUtils.GetBlessQuaHexColor(bless:GetQuality()),
			"#bless_100273a",
			BlessUtils.GetBlessQuaHexColor(3),
			"#DOTA_Tooltip_Ability_item_bless_box_3",
		}
		Custom_SendChatMessage({
			message = "#bless_100273a_msg",
			send_player = parent:GetPlayerOwnerID(),
			team_only = false,
			args = args,
		})
		return
	end
	local ____self__params_gold_per_tree_23 = self._params.gold_per_tree
	if ____self__params_gold_per_tree_23 == nil then
		____self__params_gold_per_tree_23 = 0
	end
	local gold = ____self__params_gold_per_tree_23
	local ____self__params_hp_per_tree_24 = self._params.hp_per_tree
	if ____self__params_hp_per_tree_24 == nil then
		____self__params_hp_per_tree_24 = 0
	end
	local hp = ____self__params_hp_per_tree_24
	local ____self__params_spell_amp_per_tree_25 = self._params.spell_amp_per_tree
	if ____self__params_spell_amp_per_tree_25 == nil then
		____self__params_spell_amp_per_tree_25 = 0
	end
	local spellAmp = ____self__params_spell_amp_per_tree_25
	local rewardType = RandomInt(1, 3)
	self:IncrementStackCount()
	if rewardType == 1 and gold > 0 then
		parent:ModifyGoldFiltered(gold, true, DOTA_ModifyGold_AbilityGold)
		SLModules.ClientData:PushNumberData(parent, gold, 4)
		local ____self__params_27 = self._params
		local ____self__params_total_gold_26 = self._params.total_gold
		if ____self__params_total_gold_26 == nil then
			____self__params_total_gold_26 = 0
		end
		____self__params_27.total_gold = ____self__params_total_gold_26 + gold
		DebugPrint(nil, (("获得金币: " .. tostring(gold)) .. " 总金币: ") .. tostring(self._params.total_gold))
	elseif rewardType == 2 and hp > 0 then
		local ____self__params_29 = self._params
		local ____self__params_total_hp_28 = self._params.total_hp
		if ____self__params_total_hp_28 == nil then
			____self__params_total_hp_28 = 0
		end
		____self__params_29.total_hp = ____self__params_total_hp_28 + hp
		parent:CalculateStatBonus(true)
		DebugPrint(
			nil,
			(("获得最大生命值: " .. tostring(hp)) .. " 总最大生命值: ") .. tostring(self._params.total_hp)
		)
	elseif rewardType == 3 and spellAmp > 0 then
		local ____self__params_31 = self._params
		local ____self__params_total_spell_amp_30 = self._params.total_spell_amp
		if ____self__params_total_spell_amp_30 == nil then
			____self__params_total_spell_amp_30 = 0
		end
		____self__params_31.total_spell_amp = ____self__params_total_spell_amp_30 + spellAmp
		DebugPrint(
			nil,
			(("获得技能增强: " .. tostring(spellAmp)) .. " 总技能增强: ")
				.. tostring(self._params.total_spell_amp)
		)
	end
	self._params.update_data = 1
	self:_ApplyParams(self._params)
end
function sl_modifier_bless_100273a.prototype.GetModifierHealthBonus(self)
	local ____table__params_total_hp_32 = self._params
	if ____table__params_total_hp_32 ~= nil then
		____table__params_total_hp_32 = ____table__params_total_hp_32.total_hp
	end
	local ____table__params_total_hp_32_34 = ____table__params_total_hp_32
	if ____table__params_total_hp_32_34 == nil then
		____table__params_total_hp_32_34 = 0
	end
	return ____table__params_total_hp_32_34
end
function sl_modifier_bless_100273a.prototype.GetModifierSpellAmplify_Percentage(self, event)
	local ____table__params_total_spell_amp_35 = self._params
	if ____table__params_total_spell_amp_35 ~= nil then
		____table__params_total_spell_amp_35 = ____table__params_total_spell_amp_35.total_spell_amp
	end
	local ____table__params_total_spell_amp_35_37 = ____table__params_total_spell_amp_35
	if ____table__params_total_spell_amp_35_37 == nil then
		____table__params_total_spell_amp_35_37 = 0
	end
	return ____table__params_total_spell_amp_35_37
end
function sl_modifier_bless_100273a.prototype.OnTooltip(self)
	local ____table__params_total_gold_38 = self._params
	if ____table__params_total_gold_38 ~= nil then
		____table__params_total_gold_38 = ____table__params_total_gold_38.total_gold
	end
	local ____table__params_total_gold_38_40 = ____table__params_total_gold_38
	if ____table__params_total_gold_38_40 == nil then
		____table__params_total_gold_38_40 = 0
	end
	return ____table__params_total_gold_38_40
end
sl_modifier_bless_100273a = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_100273a") },
	sl_modifier_bless_100273a
)
____exports.sl_modifier_bless_100273a = sl_modifier_bless_100273a
return ____exports