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
____exports.sl_modifier_bless_10176 = __TS__Class()
local sl_modifier_bless_10176 = ____exports.sl_modifier_bless_10176
sl_modifier_bless_10176.name = "sl_modifier_bless_10176"
__TS__ClassExtends(sl_modifier_bless_10176, sl_modifier_transmitter_data)
function sl_modifier_bless_10176.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK, MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10176.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	if not IsServer() then
		return
	end
	if not self:_IsActiveUpSide() then
		return
	end
	local ____table__params_pct_0 = self._params
	if ____table__params_pct_0 ~= nil then
		____table__params_pct_0 = ____table__params_pct_0.pct
	end
	return ____table__params_pct_0
end
function sl_modifier_bless_10176.prototype._IsActiveUpSide(self)
	local ____table__params_hp_pct_2 = self._params
	if ____table__params_hp_pct_2 ~= nil then
		____table__params_hp_pct_2 = ____table__params_hp_pct_2.hp_pct
	end
	if ____table__params_hp_pct_2 ~= nil then
		local parent = self:GetParent()
		local hp_pct = parent:GetHealthPercent()
		if hp_pct <= self._params.hp_pct then
			return false
		end
	end
	return true
end
function sl_modifier_bless_10176.prototype.SetParentBless(self, bless)
	self._parent_bless = bless
end
function sl_modifier_bless_10176.prototype.GetModifierTotal_ConstantBlock(self, event)
	if not IsServer() then
		return
	end
	local ____event_4 = event
	local damage = ____event_4.damage
	local target = ____event_4.target
	local parent = self:GetParent()
	if target ~= parent then
		return
	end
	if self:_IsActiveUpSide() then
		return
	end
	local ____self__params_5 = self._params
	local block_pct = ____self__params_5.block_pct
	local pct = ____self__params_5.pct
	local dmg = ____self__params_5.dmg
	if not block_pct or not pct or not dmg then
		return
	end
	if damage <= dmg then
		return
	end
	if RollPseudoRandomPercentage(pct, 1007, parent) then
		local block_value = damage * block_pct * 0.01
		local particle = SParticleManager:CreateBlessParticle(
			self._parent_bless,
			BLESS_PARTICLES.bless_10176_block,
			PATTACH_ABSORIGIN,
			parent
		)
		SParticleManager:SetParticleControlEnt(particle, 1, parent, PATTACH_POINT_FOLLOW, "attach_hitloc")
		self:ReleaseParticleIndex(particle)
		parent:EmitSound("bless_10176_block")
		return block_value
	end
end
sl_modifier_bless_10176 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10176") },
	sl_modifier_bless_10176
)
____exports.sl_modifier_bless_10176 = sl_modifier_bless_10176
return ____exports