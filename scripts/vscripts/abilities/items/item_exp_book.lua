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
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local _____sl_item_base = require("abilities.items._sl_item_base")
local SLItemBase = _____sl_item_base.SLItemBase
____exports.item_exp_book = __TS__Class()
local item_exp_book = ____exports.item_exp_book
item_exp_book.name = "item_exp_book"
__TS__ClassExtends(item_exp_book, SLItemBase)
function item_exp_book.prototype.CastFilterResult(self)
	local caster = self:GetCaster()
	if not caster:IsRealHero() or caster:GetLevel() >= 30 then
		return UF_FAIL_CONSIDERED_HERO
	end
	return UF_SUCCESS
end
function item_exp_book.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not caster:IsRealHero() then
		return
	end
	local gain_level = self:GetSpecialValueFor("gain_level")
	do
		local index = 0
		while index < gain_level do
			caster:HeroLevelUp(true)
			index = index + 1
		end
	end
	self:SpendCharge(0)
end
function item_exp_book.prototype.OnChargeCountChanged(self)
	if not IsServer() then
		return
	end
	if self:GetCurrentCharges() <= 0 then
		self:Destroy()
	end
end
item_exp_book = __TS__Decorate({ registerAbility(nil) }, item_exp_book)
____exports.item_exp_book = item_exp_book
return ____exports