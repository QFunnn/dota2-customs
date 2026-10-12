--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- abilities/items/_item_bless_box_base.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
____debugRuntime.register(
	"abilities/items/_item_bless_box_base.lua",
	{
		["9"] = "1:1",
		["10"] = "1:10",
		["11"] = "3:1",
		["12"] = "3:23",
		["13"] = "3:1",
		["14"] = "3:44",
		["16"] = "3:52",
		["17"] = "10:5",
		["18"] = "3:1",
		["19"] = "13:5",
		["20"] = "14:9",
		["21"] = "13:5",
		["22"] = "17:5",
		["23"] = "18:14",
		["26"] = "19:15",
		["27"] = "20:15",
		["28"] = "21:15",
		["29"] = "23:14",
		["30"] = "24:13",
		["33"] = "27:15",
		["34"] = "28:14",
		["35"] = "29:13",
		["38"] = "33:14",
		["39"] = "34:13",
		["41"] = "37:15",
		["42"] = "38:9",
		["43"] = "38:36",
		["44"] = "38:41",
		["45"] = "38:44",
		["46"] = "38:9",
		["47"] = "38:85",
		["48"] = "38:9",
		["49"] = "40:9",
		["50"] = "40:27",
		["51"] = "40:39",
		["52"] = "40:9",
		["53"] = "42:9",
		["54"] = "42:49",
		["55"] = "42:60",
		["56"] = "42:79",
		["57"] = "43:13",
		["58"] = "44:13",
		["59"] = "45:13",
		["60"] = "46:13",
		["61"] = "42:79",
		["62"] = "42:9",
		["63"] = "49:9",
		["64"] = "17:5",
	}
)
local ____exports = {}
local _____sl_item_base = require("abilities.items._sl_item_base")
local SLItemBase = _____sl_item_base.SLItemBase
____exports._item_bless_box_base = __TS__Class()
local _item_bless_box_base = ____exports._item_bless_box_base
_item_bless_box_base.name = "_item_bless_box_base"
__TS__ClassExtends(_item_bless_box_base, SLItemBase)
function _item_bless_box_base.prototype.____constructor(self, ...)
	SLItemBase.prototype.____constructor(self, ...)
	self._ignore_use_limit = false
end
function _item_bless_box_base.prototype.SetIgnoreUseLimit(self, ignore)
	self._ignore_use_limit = ignore
end
function _item_bless_box_base.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local player_id = IsValid(caster) and caster:GetPlayerOwnerID()
	local ignore_use_limit = self._ignore_use_limit
	if
		not player_id
		or not ignore_use_limit and PlayerResource:Custom_PlayerGetRecord(player_id, self._check_record_key) == true
	then
		ShowErrorTip(nil, player_id, "item_already_used")
		return
	end
	local bless_manager = SLModules.Bless
	if not bless_manager:CanPlayerDrawSelectableBless(player_id) then
		ShowErrorTip(nil, player_id, "has_chosing_bless_pool")
		return
	end
	if not ignore_use_limit then
		PlayerResource:Custom_PlayerSetRecord(player_id, self._check_record_key, true)
	end
	local pid = self:CreateParticle(BLESS_PARTICLES.bless_10037_core, PATTACH_ABSORIGIN_FOLLOW, caster)
	self:SetParticleControlEnt(pid, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc")
	EmitSoundOnClient("treasure", PlayerResource:GetPlayer(player_id))
	bless_manager:PlayerDrawSelectableBless(player_id, self._draw_reason, {
		count = HTTP.setting:GetServerSet("gameBasic").BLESS_DRAW_COUNT,
		quality = self._bless_quality,
		is_selectable_draw = true,
		gain_reason_key = "DOTA_Tooltip_Ability_" .. self:GetAbilityName(),
	})
	self:Destroy()
end
return ____exports