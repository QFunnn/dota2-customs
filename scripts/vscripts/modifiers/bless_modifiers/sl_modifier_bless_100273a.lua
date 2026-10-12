--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_100273a.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_100273a.lua",
	{
		["10"] = "2:1",
		["11"] = "2:10",
		["12"] = "4:1",
		["13"] = "4:10",
		["14"] = "6:1",
		["15"] = "7:14",
		["16"] = "6:1",
		["17"] = "7:40",
		["18"] = "8:5",
		["19"] = "9:9",
		["20"] = "8:5",
		["21"] = "12:5",
		["22"] = "13:9",
		["23"] = "12:5",
		["24"] = "16:5",
		["25"] = "17:9",
		["26"] = "16:5",
		["27"] = "26:5",
		["28"] = "27:9",
		["29"] = "26:5",
		["30"] = "30:5",
		["31"] = "31:14",
		["34"] = "32:9",
		["35"] = "32:22",
		["37"] = "32:22",
		["39"] = "32:9",
		["40"] = "33:9",
		["41"] = "33:29",
		["43"] = "33:29",
		["45"] = "33:9",
		["46"] = "34:9",
		["47"] = "34:27",
		["49"] = "34:27",
		["51"] = "34:9",
		["52"] = "35:9",
		["53"] = "35:34",
		["55"] = "35:34",
		["57"] = "35:9",
		["58"] = "36:9",
		["59"] = "36:32",
		["61"] = "36:32",
		["63"] = "36:9",
		["64"] = "37:9",
		["65"] = "37:30",
		["67"] = "37:30",
		["69"] = "37:9",
		["70"] = "38:9",
		["71"] = "38:37",
		["73"] = "38:37",
		["75"] = "38:9",
		["76"] = "39:9",
		["77"] = "40:9",
		["78"] = "41:9",
		["79"] = "42:9",
		["80"] = "30:5",
		["81"] = "45:5",
		["82"] = "46:14",
		["85"] = "47:13",
		["86"] = "48:13",
		["87"] = "48:32",
		["89"] = "48:32",
		["91"] = "48:13",
		["92"] = "49:13",
		["93"] = "49:42",
		["95"] = "49:42",
		["97"] = "49:13",
		["98"] = "50:13",
		["99"] = "50:40",
		["101"] = "50:40",
		["103"] = "50:13",
		["104"] = "51:13",
		["105"] = "51:47",
		["107"] = "51:47",
		["109"] = "51:13",
		["110"] = "52:13",
		["111"] = "53:13",
		["113"] = "45:5",
		["114"] = "57:5",
		["115"] = "58:14",
		["118"] = "59:15",
		["119"] = "60:14",
		["122"] = "61:15",
		["123"] = "62:13",
		["126"] = "63:15",
		["127"] = "64:15",
		["128"] = "65:13",
		["131"] = "66:14",
		["134"] = "67:21",
		["136"] = "67:21",
		["138"] = "67:15",
		["139"] = "68:13",
		["140"] = "70:19",
		["141"] = "71:18",
		["144"] = "72:13",
		["145"] = "73:13",
		["146"] = "74:19",
		["147"] = "75:17",
		["148"] = "76:17",
		["149"] = "77:17",
		["150"] = "78:17",
		["151"] = "74:36",
		["152"] = "80:13",
		["153"] = "81:17",
		["154"] = "82:17",
		["155"] = "83:17",
		["156"] = "84:17",
		["157"] = "80:36",
		["160"] = "88:22",
		["162"] = "88:22",
		["164"] = "88:15",
		["165"] = "89:20",
		["167"] = "89:20",
		["169"] = "89:15",
		["170"] = "90:26",
		["172"] = "90:26",
		["174"] = "90:15",
		["175"] = "91:15",
		["176"] = "92:9",
		["177"] = "93:13",
		["178"] = "94:13",
		["179"] = "95:13",
		["180"] = "96:13",
		["181"] = "96:40",
		["183"] = "96:40",
		["185"] = "96:13",
		["186"] = "97:13",
		["187"] = "97:13",
		["188"] = "97:24",
		["189"] = "97:13",
		["190"] = "98:20",
		["191"] = "99:13",
		["192"] = "99:38",
		["194"] = "99:38",
		["196"] = "99:13",
		["197"] = "100:13",
		["198"] = "101:13",
		["199"] = "101:13",
		["200"] = "101:24",
		["201"] = "101:13",
		["202"] = "102:20",
		["203"] = "103:13",
		["204"] = "103:45",
		["206"] = "103:45",
		["208"] = "103:13",
		["209"] = "104:13",
		["210"] = "104:13",
		["211"] = "104:24",
		["212"] = "104:13",
		["214"] = "106:9",
		["215"] = "107:9",
		["216"] = "57:5",
		["217"] = "110:5",
		["218"] = "111:16",
		["219"] = "111:16",
		["220"] = "111:16",
		["222"] = "111:16",
		["224"] = "111:16",
		["226"] = "111:9",
		["227"] = "110:5",
		["228"] = "114:5",
		["229"] = "115:16",
		["230"] = "115:16",
		["231"] = "115:16",
		["233"] = "115:16",
		["235"] = "115:16",
		["237"] = "115:9",
		["238"] = "114:5",
		["239"] = "118:5",
		["240"] = "120:16",
		["241"] = "120:16",
		["242"] = "120:16",
		["244"] = "120:16",
		["246"] = "120:16",
		["248"] = "120:9",
		["249"] = "118:5",
		["250"] = "7:14",
		["251"] = "6:2",
		["252"] = "6:2",
		["253"] = "6:19",
		["254"] = "6:2",
		["256"] = "6:2",
		["257"] = "7:14",
		["259"] = "7:14",
	}
)
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_100273a", nil, getfenv()) },
	sl_modifier_bless_100273a
)
____exports.sl_modifier_bless_100273a = sl_modifier_bless_100273a
return ____exports