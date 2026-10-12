--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- abilities/items/item_exp_book.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"abilities/items/item_exp_book.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "4:1",
		["15"] = "5:14",
		["16"] = "4:1",
		["17"] = "5:28",
		["18"] = "6:5",
		["19"] = "7:15",
		["20"] = "8:14",
		["21"] = "8:62",
		["23"] = "9:9",
		["24"] = "6:5",
		["25"] = "12:5",
		["26"] = "13:14",
		["29"] = "14:15",
		["30"] = "15:14",
		["33"] = "16:15",
		["35"] = "17:18",
		["36"] = "17:29",
		["37"] = "18:13",
		["38"] = "17:49",
		["41"] = "20:9",
		["42"] = "12:5",
		["43"] = "23:5",
		["44"] = "24:14",
		["47"] = "25:13",
		["48"] = "25:44",
		["50"] = "23:5",
		["51"] = "5:14",
		["52"] = "4:2",
		["53"] = "4:2",
		["54"] = "4:2",
		["56"] = "4:2",
		["57"] = "5:14",
		["59"] = "5:14",
	}
)
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
item_exp_book = __TS__Decorate({ registerAbility(nil, nil, getfenv()) }, item_exp_book)
____exports.item_exp_book = item_exp_book
return ____exports