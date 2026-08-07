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
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____bless_10169_cat_ability_base = require("abilities.units._bless_10169_cat_ability_base")
local _bless_10169_cat_ability_base = _____bless_10169_cat_ability_base._bless_10169_cat_ability_base
--- 集火：使目标承受伤害+20%，持续10秒，可以对建筑使用
____exports.bless_10169_cat_ability_2 = __TS__Class()
local bless_10169_cat_ability_2 = ____exports.bless_10169_cat_ability_2
bless_10169_cat_ability_2.name = "bless_10169_cat_ability_2"
__TS__ClassExtends(bless_10169_cat_ability_2, _bless_10169_cat_ability_base)
function bless_10169_cat_ability_2.prototype.____constructor(self, ...)
	_bless_10169_cat_ability_base.prototype.____constructor(self, ...)
	self._command_particle = BLESS_PARTICLES.bless_10169_att_head
end
function bless_10169_cat_ability_2.prototype.OnSpellStart(self)
	local target = self:GetCursorTarget()
	if not IsValidAlive(target) then
		return
	end
	local caster = self:GetCaster()
	local player_id = caster:GetPlayerOwnerID()
	EmitAnnouncerSoundForTeam("cat_ability_2", caster:GetTeam())
	Custom_SendChatMessage({
		message = "#bless_10169_cat_ability_2_msg",
		send_player = player_id,
		team_only = true,
		args = {
			GetPlayerColorHex(player_id),
			"#" .. caster:GetUnitName(),
			"#" .. target:GetUnitName(),
		},
	})
	if IsValidAlive(target) then
		local buff = target:AddSLModifier(____exports.sl_modifier_bless_10169_cat_ability_2, {
			ability = self,
			caster = caster,
			duration = self:GetSpecialValueFor("dmg_dur"),
			no_error = true,
		})
		if IsValid(buff) then
			local pid = self:CreateParticle(BLESS_PARTICLES.bless_10169_att_buff, PATTACH_ABSORIGIN_FOLLOW, target)
			buff:AddParticle(pid, false, false, 5, false, false)
		end
	end
	_bless_10169_cat_ability_base.prototype.OnSpellStart(self)
end
bless_10169_cat_ability_2 = __TS__Decorate({ registerAbility(nil) }, bless_10169_cat_ability_2)
____exports.bless_10169_cat_ability_2 = bless_10169_cat_ability_2
____exports.sl_modifier_bless_10169_cat_ability_2 = __TS__Class()
local sl_modifier_bless_10169_cat_ability_2 = ____exports.sl_modifier_bless_10169_cat_ability_2
sl_modifier_bless_10169_cat_ability_2.name = "sl_modifier_bless_10169_cat_ability_2"
__TS__ClassExtends(sl_modifier_bless_10169_cat_ability_2, SLModifierBase_Debuff)
function sl_modifier_bless_10169_cat_ability_2.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10169_cat_ability_2.prototype.IsPurgable(self)
	return false
end
function sl_modifier_bless_10169_cat_ability_2.prototype.IsPurgeException(self)
	return false
end
function sl_modifier_bless_10169_cat_ability_2.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10169_cat_ability_2.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function sl_modifier_bless_10169_cat_ability_2.prototype.GetModifierIncomingDamage_Percentage(self, event)
	return self:GetAbilitySpecialValueFor("dmg_pct")
end
sl_modifier_bless_10169_cat_ability_2 = __TS__Decorate(
	{ registerModifier(nil, "abilities/units/bless_10169_cat_ability_2") },
	sl_modifier_bless_10169_cat_ability_2
)
____exports.sl_modifier_bless_10169_cat_ability_2 = sl_modifier_bless_10169_cat_ability_2
return ____exports