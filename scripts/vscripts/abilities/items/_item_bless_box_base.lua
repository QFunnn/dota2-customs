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
local ____exports = {}
local _____sl_item_base = require("abilities.items._sl_item_base")
local SLItemBase = _____sl_item_base.SLItemBase
____exports._item_bless_box_base = __TS__Class()
local _item_bless_box_base = ____exports._item_bless_box_base
_item_bless_box_base.name = "_item_bless_box_base"
__TS__ClassExtends(_item_bless_box_base, SLItemBase)
function _item_bless_box_base.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local player_id = IsValid(caster) and caster:GetPlayerOwnerID()
	if not player_id or PlayerResource:Custom_PlayerGetRecord(player_id, self._check_record_key) == true then
		ShowErrorTip(nil, player_id, "item_already_used")
		return
	end
	local bless_manager = SLModules.Bless
	if not bless_manager:CanPlayerDrawSelectableBless(player_id) then
		ShowErrorTip(nil, player_id, "has_chosing_bless_pool")
		return
	end
	PlayerResource:Custom_PlayerSetRecord(player_id, self._check_record_key, true)
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