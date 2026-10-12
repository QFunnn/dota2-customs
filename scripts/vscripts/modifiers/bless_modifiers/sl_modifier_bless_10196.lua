--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10196.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10196.lua",
	{
		["10"] = "2:1",
		["11"] = "2:10",
		["12"] = "4:1",
		["13"] = "4:10",
		["14"] = "9:1",
		["15"] = "10:14",
		["16"] = "9:1",
		["17"] = "10:44",
		["19"] = "10:52",
		["20"] = "57:5",
		["21"] = "58:5",
		["22"] = "9:1",
		["23"] = "11:5",
		["24"] = "12:9",
		["25"] = "11:5",
		["26"] = "15:5",
		["27"] = "16:9",
		["28"] = "15:5",
		["29"] = "20:5",
		["30"] = "21:9",
		["31"] = "20:5",
		["32"] = "24:5",
		["33"] = "25:9",
		["34"] = "25:16",
		["35"] = "25:16",
		["36"] = "25:16",
		["37"] = "25:16",
		["38"] = "25:16",
		["39"] = "25:16",
		["41"] = "25:16",
		["42"] = "24:5",
		["43"] = "36:5",
		["44"] = "37:17",
		["45"] = "37:17",
		["46"] = "37:17",
		["48"] = "37:17",
		["50"] = "37:17",
		["52"] = "37:9",
		["53"] = "36:5",
		["54"] = "40:5",
		["55"] = "41:17",
		["56"] = "41:17",
		["57"] = "41:17",
		["59"] = "41:17",
		["61"] = "41:17",
		["63"] = "41:9",
		["64"] = "40:5",
		["65"] = "44:5",
		["66"] = "46:9",
		["67"] = "44:5",
		["68"] = "49:5",
		["69"] = "50:16",
		["70"] = "50:16",
		["71"] = "50:16",
		["73"] = "50:16",
		["75"] = "50:16",
		["77"] = "50:9",
		["78"] = "49:5",
		["79"] = "53:5",
		["80"] = "54:16",
		["81"] = "54:16",
		["82"] = "54:16",
		["84"] = "54:9",
		["85"] = "53:5",
		["86"] = "59:5",
		["87"] = "61:14",
		["90"] = "62:26",
		["91"] = "62:17",
		["92"] = "63:15",
		["93"] = "64:13",
		["96"] = "67:15",
		["97"] = "67:54",
		["98"] = "67:79",
		["99"] = "67:28",
		["100"] = "68:15",
		["101"] = "69:9",
		["102"] = "69:9",
		["103"] = "71:13",
		["104"] = "71:13",
		["105"] = "71:13",
		["107"] = "71:13",
		["108"] = "72:17",
		["109"] = "73:21",
		["110"] = "75:21",
		["114"] = "79:20",
		["115"] = "80:17",
		["116"] = "80:17",
		["117"] = "81:17",
		["120"] = "85:15",
		["121"] = "86:13",
		["122"] = "87:13",
		["123"] = "88:13",
		["125"] = "59:5",
		["126"] = "92:5",
		["127"] = "93:14",
		["130"] = "94:38",
		["131"] = "94:17",
		["132"] = "94:27",
		["133"] = "95:15",
		["134"] = "96:13",
		["135"] = "97:13",
		["136"] = "98:13",
		["138"] = "92:5",
		["139"] = "102:5",
		["140"] = "103:14",
		["143"] = "104:13",
		["144"] = "105:13",
		["146"] = "107:9",
		["147"] = "108:13",
		["148"] = "109:17",
		["149"] = "110:17",
		["150"] = "110:53",
		["151"] = "110:71",
		["152"] = "110:17",
		["154"] = "112:13",
		["156"] = "102:5",
		["157"] = "10:14",
		["158"] = "9:2",
		["159"] = "9:2",
		["160"] = "9:19",
		["161"] = "9:2",
		["163"] = "9:2",
		["164"] = "10:14",
		["166"] = "10:14",
		["167"] = "128:1",
		["168"] = "129:14",
		["169"] = "128:1",
		["170"] = "129:45",
		["171"] = "130:5",
		["172"] = "131:9",
		["173"] = "130:5",
		["174"] = "134:5",
		["175"] = "135:9",
		["176"] = "134:5",
		["177"] = "138:5",
		["178"] = "139:9",
		["179"] = "138:5",
		["180"] = "142:5",
		["181"] = "143:9",
		["182"] = "142:5",
		["183"] = "151:5",
		["184"] = "152:17",
		["185"] = "152:17",
		["186"] = "152:17",
		["188"] = "152:17",
		["190"] = "152:17",
		["192"] = "152:9",
		["193"] = "151:5",
		["194"] = "155:5",
		["195"] = "156:17",
		["196"] = "156:17",
		["197"] = "156:17",
		["199"] = "156:17",
		["201"] = "156:17",
		["203"] = "156:9",
		["204"] = "155:5",
		["205"] = "159:5",
		["206"] = "160:17",
		["207"] = "160:17",
		["208"] = "160:17",
		["210"] = "160:17",
		["212"] = "160:17",
		["214"] = "160:9",
		["215"] = "159:5",
		["216"] = "163:5",
		["217"] = "164:17",
		["218"] = "164:17",
		["219"] = "164:17",
		["221"] = "164:17",
		["223"] = "164:17",
		["225"] = "164:9",
		["226"] = "163:5",
		["227"] = "129:14",
		["228"] = "128:2",
		["229"] = "128:2",
		["230"] = "128:19",
		["231"] = "128:2",
		["233"] = "128:2",
		["234"] = "129:14",
		["236"] = "129:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10196_belly = __TS__Class()
local sl_modifier_bless_10196_belly = ____exports.sl_modifier_bless_10196_belly
sl_modifier_bless_10196_belly.name = "sl_modifier_bless_10196_belly"
__TS__ClassExtends(sl_modifier_bless_10196_belly, sl_modifier_transmitter_data)
function sl_modifier_bless_10196_belly.prototype.____constructor(self, ...)
	sl_modifier_transmitter_data.prototype.____constructor(self, ...)
	self._total_killed = 0
	self._last_sync_time = 0
end
function sl_modifier_bless_10196_belly.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10196_belly.prototype.GetTexture(self)
	return "buff/bless/10196"
end
function sl_modifier_bless_10196_belly.prototype.SetSourceBless(self, bless)
	self._source_bless = bless
end
function sl_modifier_bless_10196_belly.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_EVENT_ON_UNIT_MOVED,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_EVENT_ON_HERO_KILLED,
	}
end
function sl_modifier_bless_10196_belly.prototype.GetModifierIncomingDamage_Percentage(self, event)
	local ____table__params_csshI_0 = self._params
	if ____table__params_csshI_0 ~= nil then
		____table__params_csshI_0 = ____table__params_csshI_0.csshI
	end
	local ____table__params_csshI_0_2 = ____table__params_csshI_0
	if ____table__params_csshI_0_2 == nil then
		____table__params_csshI_0_2 = 0
	end
	return ____table__params_csshI_0_2 * self:GetStackCount()
end
function sl_modifier_bless_10196_belly.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	local ____table__params_ms_3 = self._params
	if ____table__params_ms_3 ~= nil then
		____table__params_ms_3 = ____table__params_ms_3.ms
	end
	local ____table__params_ms_3_5 = ____table__params_ms_3
	if ____table__params_ms_3_5 == nil then
		____table__params_ms_3_5 = 0
	end
	return ____table__params_ms_3_5 * self:GetStackCount()
end
function sl_modifier_bless_10196_belly.prototype.GetModifierModelScale(self)
	return 5 * self:GetStackCount()
end
function sl_modifier_bless_10196_belly.prototype.OnTooltip(self)
	local ____table__params_total_moved_6 = self._params
	if ____table__params_total_moved_6 ~= nil then
		____table__params_total_moved_6 = ____table__params_total_moved_6.total_moved
	end
	local ____table__params_total_moved_6_8 = ____table__params_total_moved_6
	if ____table__params_total_moved_6_8 == nil then
		____table__params_total_moved_6_8 = 0
	end
	return ____table__params_total_moved_6_8
end
function sl_modifier_bless_10196_belly.prototype.OnTooltip2(self)
	local ____table__params_move_9 = self._params
	if ____table__params_move_9 ~= nil then
		____table__params_move_9 = ____table__params_move_9.move
	end
	return ____table__params_move_9
end
function sl_modifier_bless_10196_belly.prototype.OnUnitMoved(self, event)
	if not IsServer() then
		return
	end
	local ____event_11 = event
	local unit = ____event_11.unit
	local parent = self:GetParent()
	if unit ~= parent then
		return
	end
	local move_speed = unit:GetMoveSpeedModifier(unit:GetBaseMoveSpeed(), false)
	local moved_distance = move_speed * FrameTime()
	local ____self__params_12, ____total_moved_13 = self._params, "total_moved"
	____self__params_12[____total_moved_13] = ____self__params_12[____total_moved_13] + moved_distance
	local ____table__params_move_14 = self._params
	if ____table__params_move_14 ~= nil then
		____table__params_move_14 = ____table__params_move_14.move
	end
	if ____table__params_move_14 ~= nil and self:GetStackCount() > 0 then
		if self._params.move <= 0 then
			if IsServer() then
				SLError(
					"bless_10196_belly move <= 0",
					nil,
					"modifiers/bless_modifiers/sl_modifier_bless_10196.ts:75:21"
				)
			end
			return
		end
		while self._params.total_moved >= self._params.move do
			local ____self__params_16, ____total_moved_17 = self._params, "total_moved"
			____self__params_16[____total_moved_17] = ____self__params_16[____total_moved_17] - self._params.move
			self:_LostOneStackBelly()
		end
	end
	local now = GameRules:GetGameTime()
	if now - self._last_sync_time >= 0.5 then
		self._last_sync_time = now
		self:_SendBuffRefreshToClientsAndRecord()
	end
end
function sl_modifier_bless_10196_belly.prototype.OnHeroKilled(self, event)
	if not IsServer() then
		return
	end
	local ____event_18 = event
	local attacker = ____event_18.attacker
	local target = ____event_18.target
	local parent = self:GetParent()
	if attacker == parent and self:GetStackCount() > 0 then
		self._total_killed = self._total_killed + 1
		self:_LostOneStackBelly()
	end
end
function sl_modifier_bless_10196_belly.prototype._LostOneStackBelly(self)
	if not IsServer() then
		return
	end
	if self:GetStackCount() <= 0 then
		SLError("stack <= 0 befroe lost", nil, "modifiers/bless_modifiers/sl_modifier_bless_10196.ts:105:13")
	end
	self:DecrementStackCount()
	if self:GetStackCount() <= 0 then
		if self._source_bless and self._source_bless:IsValid() then
			self._source_bless:OnLoseAllBellies(self:GetParent(), self._total_killed)
		end
		self:Destroy()
	end
end
sl_modifier_bless_10196_belly = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10196", nil, getfenv()) },
	sl_modifier_bless_10196_belly
)
____exports.sl_modifier_bless_10196_belly = sl_modifier_bless_10196_belly
____exports.sl_modifier_bless_10196_muscle = __TS__Class()
local sl_modifier_bless_10196_muscle = ____exports.sl_modifier_bless_10196_muscle
sl_modifier_bless_10196_muscle.name = "sl_modifier_bless_10196_muscle"
__TS__ClassExtends(sl_modifier_bless_10196_muscle, sl_modifier_transmitter_data)
function sl_modifier_bless_10196_muscle.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10196_muscle.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10196_muscle.prototype.GetTexture(self)
	return "buff/bless/10196_muscle"
end
function sl_modifier_bless_10196_muscle.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}
end
function sl_modifier_bless_10196_muscle.prototype.GetModifierExtraHealthPercentage(self)
	local ____table__params_pct_19 = self._params
	if ____table__params_pct_19 ~= nil then
		____table__params_pct_19 = ____table__params_pct_19.pct
	end
	local ____table__params_pct_19_21 = ____table__params_pct_19
	if ____table__params_pct_19_21 == nil then
		____table__params_pct_19_21 = 0
	end
	return ____table__params_pct_19_21 * self:GetStackCount()
end
function sl_modifier_bless_10196_muscle.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	local ____table__params_pct_22 = self._params
	if ____table__params_pct_22 ~= nil then
		____table__params_pct_22 = ____table__params_pct_22.pct
	end
	local ____table__params_pct_22_24 = ____table__params_pct_22
	if ____table__params_pct_22_24 == nil then
		____table__params_pct_22_24 = 0
	end
	return ____table__params_pct_22_24 * self:GetStackCount()
end
function sl_modifier_bless_10196_muscle.prototype.GetModifierAttackSpeedPercentage(self)
	local ____table__params_pct_25 = self._params
	if ____table__params_pct_25 ~= nil then
		____table__params_pct_25 = ____table__params_pct_25.pct
	end
	local ____table__params_pct_25_27 = ____table__params_pct_25
	if ____table__params_pct_25_27 == nil then
		____table__params_pct_25_27 = 0
	end
	return ____table__params_pct_25_27 * self:GetStackCount()
end
function sl_modifier_bless_10196_muscle.prototype.GetModifierDamageOutgoing_Percentage(self, event)
	local ____table__params_pct_28 = self._params
	if ____table__params_pct_28 ~= nil then
		____table__params_pct_28 = ____table__params_pct_28.pct
	end
	local ____table__params_pct_28_30 = ____table__params_pct_28
	if ____table__params_pct_28_30 == nil then
		____table__params_pct_28_30 = 0
	end
	return ____table__params_pct_28_30 * self:GetStackCount()
end
sl_modifier_bless_10196_muscle = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10196", nil, getfenv()) },
	sl_modifier_bless_10196_muscle
)
____exports.sl_modifier_bless_10196_muscle = sl_modifier_bless_10196_muscle
return ____exports