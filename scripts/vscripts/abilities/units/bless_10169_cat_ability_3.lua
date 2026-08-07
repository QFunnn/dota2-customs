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
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_shield_all = ____sl_modifier_simple.sl_modifier_shield_all
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____bless_10169_cat_ability_base = require("abilities.units._bless_10169_cat_ability_base")
local _bless_10169_cat_ability_base = _____bless_10169_cat_ability_base._bless_10169_cat_ability_base
--- 使目标己方英雄获得20%×其最大生命值的护盾
____exports.bless_10169_cat_ability_3 = __TS__Class()
local bless_10169_cat_ability_3 = ____exports.bless_10169_cat_ability_3
bless_10169_cat_ability_3.name = "bless_10169_cat_ability_3"
__TS__ClassExtends(bless_10169_cat_ability_3, _bless_10169_cat_ability_base)
function bless_10169_cat_ability_3.prototype.____constructor(self, ...)
	_bless_10169_cat_ability_base.prototype.____constructor(self, ...)
	self._command_particle = BLESS_PARTICLES.bless_10169_def_head
end
function bless_10169_cat_ability_3.prototype.OnSpellStart(self)
	local target = self:GetCursorTarget()
	if not IsValidAlive(target) then
		return
	end
	local caster = self:GetCaster()
	local player_id = caster:GetPlayerOwnerID()
	EmitAnnouncerSoundForTeam("cat_ability_3", caster:GetTeam())
	Custom_SendChatMessage({
		message = "#bless_10169_cat_ability_3_msg",
		send_player = player_id,
		team_only = true,
		args = {
			GetPlayerColorHex(player_id),
			"#" .. caster:GetUnitName(),
			"#" .. target:GetUnitName(),
		},
	})
	local hp_pct = self:GetSpecialValueFor("hp_pct")
	local shield_amount = target:GetMaxHealth() * hp_pct * 0.01
	local buff = target:AddSLModifier(
		____exports.sl_modifier_bless_10169_cat_ability_3,
		{
			ability = self,
			caster = caster,
			modifierTable = { shield_amount_max = shield_amount, shield_amount = shield_amount },
			no_error = true,
		}
	)
	if IsValid(buff) then
		local pid = self:CreateParticle(BLESS_PARTICLES.bless_10169_def_buff, PATTACH_ABSORIGIN_FOLLOW, target)
		buff:AddParticle(pid, false, false, 5, false, false)
	end
	_bless_10169_cat_ability_base.prototype.OnSpellStart(self)
end
bless_10169_cat_ability_3 = __TS__Decorate({ registerAbility(nil) }, bless_10169_cat_ability_3)
____exports.bless_10169_cat_ability_3 = bless_10169_cat_ability_3
____exports.sl_modifier_bless_10169_cat_ability_3 = __TS__Class()
local sl_modifier_bless_10169_cat_ability_3 = ____exports.sl_modifier_bless_10169_cat_ability_3
sl_modifier_bless_10169_cat_ability_3.name = "sl_modifier_bless_10169_cat_ability_3"
__TS__ClassExtends(sl_modifier_bless_10169_cat_ability_3, sl_modifier_shield_all)
function sl_modifier_bless_10169_cat_ability_3.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
sl_modifier_bless_10169_cat_ability_3 = __TS__Decorate(
	{ registerModifier(nil, "abilities/units/bless_10169_cat_ability_3") },
	sl_modifier_bless_10169_cat_ability_3
)
____exports.sl_modifier_bless_10169_cat_ability_3 = sl_modifier_bless_10169_cat_ability_3
return ____exports