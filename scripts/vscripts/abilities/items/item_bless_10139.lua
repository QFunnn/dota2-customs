--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- abilities/items/item_bless_10139.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"abilities/items/item_bless_10139.lua",
	{
		["11"] = "2:1",
		["12"] = "2:10",
		["13"] = "3:1",
		["14"] = "3:10",
		["15"] = "3:27",
		["16"] = "4:1",
		["17"] = "4:10",
		["18"] = "6:1",
		["19"] = "7:14",
		["20"] = "6:1",
		["21"] = "7:31",
		["22"] = "8:5",
		["23"] = "9:14",
		["24"] = "9:35",
		["26"] = "10:15",
		["27"] = "11:14",
		["28"] = "11:35",
		["30"] = "12:13",
		["31"] = "12:31",
		["33"] = "13:13",
		["34"] = "13:64",
		["36"] = "14:9",
		["37"] = "8:5",
		["38"] = "17:5",
		["39"] = "18:14",
		["42"] = "20:15",
		["43"] = "21:15",
		["44"] = "22:14",
		["47"] = "23:14",
		["50"] = "24:14",
		["53"] = "25:14",
		["56"] = "27:13",
		["59"] = "29:13",
		["62"] = "32:9",
		["63"] = "32:9",
		["64"] = "32:60",
		["65"] = "33:13",
		["66"] = "34:13",
		["67"] = "34:28",
		["68"] = "34:33",
		["69"] = "34:28",
		["70"] = "34:28",
		["71"] = "32:60",
		["72"] = "32:9",
		["73"] = "36:9",
		["74"] = "36:9",
		["75"] = "36:60",
		["76"] = "37:13",
		["77"] = "38:13",
		["78"] = "38:28",
		["79"] = "38:33",
		["80"] = "38:28",
		["81"] = "38:28",
		["82"] = "36:60",
		["83"] = "36:9",
		["84"] = "40:9",
		["85"] = "17:5",
		["86"] = "44:5",
		["87"] = "45:9",
		["88"] = "44:5",
		["89"] = "7:14",
		["90"] = "6:2",
		["91"] = "6:2",
		["92"] = "6:2",
		["94"] = "6:2",
		["95"] = "7:14",
		["97"] = "7:14",
		["98"] = "60:1",
		["99"] = "61:14",
		["100"] = "60:1",
		["101"] = "61:43",
		["103"] = "61:51",
		["104"] = "84:5",
		["105"] = "60:1",
		["106"] = "62:5",
		["107"] = "64:13",
		["108"] = "64:37",
		["109"] = "64:37",
		["110"] = "64:65",
		["112"] = "64:72",
		["114"] = "65:13",
		["115"] = "65:48",
		["116"] = "65:48",
		["117"] = "65:76",
		["119"] = "65:83",
		["121"] = "63:9",
		["122"] = "62:5",
		["123"] = "69:5",
		["124"] = "70:9",
		["125"] = "69:5",
		["126"] = "73:5",
		["127"] = "61:51",
		["128"] = "75:14",
		["131"] = "76:9",
		["132"] = "77:18",
		["133"] = "77:33",
		["135"] = "78:13",
		["136"] = "79:13",
		["137"] = "76:28",
		["138"] = "73:5",
		["139"] = "85:5",
		["140"] = "86:14",
		["143"] = "87:15",
		["144"] = "89:13",
		["147"] = "91:15",
		["148"] = "92:15",
		["149"] = "93:14",
		["150"] = "94:17",
		["151"] = "95:17",
		["152"] = "97:21",
		["153"] = "98:21",
		["155"] = "100:17",
		["159"] = "104:17",
		["160"] = "105:17",
		["161"] = "106:21",
		["162"] = "107:21",
		["163"] = "108:21",
		["164"] = "109:21",
		["166"] = "105:32",
		["167"] = "112:17",
		["170"] = "117:15",
		["171"] = "118:14",
		["172"] = "119:13",
		["173"] = "120:17",
		["174"] = "121:17",
		["175"] = "122:17",
		["176"] = "123:17",
		["179"] = "126:13",
		["180"] = "127:19",
		["181"] = "128:31",
		["182"] = "128:21",
		["183"] = "129:19",
		["184"] = "130:19",
		["185"] = "131:19",
		["186"] = "132:13",
		["188"] = "85:5",
		["189"] = "136:5",
		["190"] = "137:9",
		["191"] = "136:5",
		["192"] = "140:5",
		["193"] = "141:14",
		["196"] = "142:13",
		["197"] = "143:13",
		["199"] = "145:15",
		["200"] = "146:9",
		["201"] = "146:31",
		["202"] = "146:39",
		["203"] = "146:62",
		["204"] = "146:9",
		["205"] = "140:5",
		["206"] = "150:5",
		["207"] = "151:15",
		["208"] = "152:13",
		["209"] = "152:30",
		["211"] = "153:9",
		["212"] = "154:9",
		["213"] = "150:5",
		["214"] = "157:5",
		["215"] = "158:16",
		["216"] = "158:16",
		["217"] = "158:44",
		["219"] = "158:71",
		["221"] = "158:9",
		["222"] = "157:5",
		["223"] = "161:5",
		["224"] = "162:16",
		["225"] = "162:16",
		["226"] = "162:44",
		["228"] = "162:71",
		["230"] = "162:9",
		["231"] = "161:5",
		["232"] = "165:5",
		["233"] = "166:16",
		["234"] = "166:16",
		["235"] = "166:44",
		["237"] = "166:72",
		["239"] = "166:9",
		["240"] = "165:5",
		["241"] = "61:14",
		["242"] = "60:2",
		["243"] = "60:2",
		["244"] = "60:19",
		["245"] = "60:2",
		["247"] = "60:2",
		["248"] = "61:14",
		["250"] = "61:14",
		["251"] = "169:1",
		["252"] = "170:14",
		["253"] = "169:1",
		["254"] = "170:43",
		["255"] = "171:5",
		["256"] = "172:9",
		["257"] = "171:5",
		["258"] = "176:5",
		["259"] = "177:15",
		["260"] = "178:13",
		["261"] = "178:30",
		["263"] = "179:9",
		["264"] = "180:9",
		["265"] = "176:5",
		["266"] = "183:5",
		["267"] = "184:9",
		["268"] = "183:5",
		["269"] = "187:5",
		["270"] = "170:51",
		["271"] = "189:9",
		["272"] = "187:5",
		["273"] = "192:5",
		["274"] = "193:14",
		["277"] = "194:15",
		["278"] = "195:13",
		["279"] = "196:17",
		["280"] = "197:17",
		["283"] = "200:17",
		["284"] = "201:17",
		["287"] = "192:5",
		["288"] = "206:5",
		["289"] = "207:9",
		["290"] = "206:5",
		["291"] = "210:5",
		["292"] = "211:13",
		["293"] = "211:40",
		["295"] = "212:28",
		["296"] = "212:17",
		["297"] = "213:15",
		["298"] = "214:15",
		["299"] = "214:59",
		["300"] = "214:89",
		["301"] = "214:28",
		["302"] = "215:9",
		["303"] = "210:5",
		["304"] = "170:14",
		["305"] = "169:2",
		["306"] = "169:2",
		["307"] = "169:19",
		["308"] = "169:2",
		["310"] = "169:2",
		["311"] = "170:14",
		["313"] = "170:14",
	}
)
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
item_bless_10139 = __TS__Decorate({ registerAbility(nil, nil, getfenv()) }, item_bless_10139)
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
sl_modifier_bless_10139_self = __TS__Decorate(
	{ registerModifier(nil, "abilities/items/item_bless_10139", nil, getfenv()) },
	sl_modifier_bless_10139_self
)
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
sl_modifier_bless_10139_ally = __TS__Decorate(
	{ registerModifier(nil, "abilities/items/item_bless_10139", nil, getfenv()) },
	sl_modifier_bless_10139_ally
)
____exports.sl_modifier_bless_10139_ally = sl_modifier_bless_10139_ally
return ____exports