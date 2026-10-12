--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- abilities/items/item_apothesis.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"abilities/items/item_apothesis.lua",
	{
		["10"] = "1:1",
		["11"] = "1:20",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "4:1",
		["15"] = "5:14",
		["16"] = "4:1",
		["17"] = "5:29",
		["18"] = "8:5",
		["19"] = "9:15",
		["20"] = "10:14",
		["23"] = "11:9",
		["24"] = "12:9",
		["25"] = "8:5",
		["26"] = "15:5",
		["27"] = "16:15",
		["28"] = "17:9",
		["29"] = "18:9",
		["30"] = "19:9",
		["31"] = "20:13",
		["34"] = "21:14",
		["37"] = "22:15",
		["38"] = "23:15",
		["39"] = "24:15",
		["40"] = "25:15",
		["41"] = "27:15",
		["42"] = "28:15",
		["43"] = "30:9",
		["44"] = "31:9",
		["45"] = "15:5",
		["46"] = "5:14",
		["47"] = "4:2",
		["48"] = "4:2",
		["49"] = "4:2",
		["51"] = "4:2",
		["52"] = "5:14",
		["54"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local _____sl_item_base = require("abilities.items._sl_item_base")
local SLItemBase = _____sl_item_base.SLItemBase
____exports.item_apothesis = __TS__Class()
local item_apothesis = ____exports.item_apothesis
item_apothesis.name = "item_apothesis"
__TS__ClassExtends(item_apothesis, SLItemBase)
function item_apothesis.prototype.OnSpellStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(caster) then
		return
	end
	caster:StartGesture(ACT_DOTA_GENERIC_CHANNEL_1)
	self._channel_pid = self:CreateParticle(ITEM_PARTICLES.item_apothesis_channel, PATTACH_ABSORIGIN_FOLLOW, caster)
end
function item_apothesis.prototype.OnChannelFinish(self, interrupted)
	local caster = self:GetCaster()
	caster:FadeGesture(ACT_DOTA_GENERIC_CHANNEL_1)
	self:DestroyParticle(self._channel_pid, false)
	self:ReleaseParticleIndex(self._channel_pid)
	if interrupted then
		return
	end
	if not IsValidAlive(caster) then
		return
	end
	local hp_regen_constant = self:GetSpecialValueFor("hp_regen_constant")
	local hp_regen_total_pct = self:GetSpecialValueFor("hp_regen_total_pct")
	local mana_regen_constant = self:GetSpecialValueFor("mana_regen_constant")
	local mana_regen_total_pct = self:GetSpecialValueFor("mana_regen_total_pct")
	local total_amount = hp_regen_constant + caster:GetMaxHealth() * (hp_regen_total_pct / 100)
	local total_mana_amount = mana_regen_constant + caster:GetMaxMana() * (mana_regen_total_pct / 100)
	CustomHeal(caster, total_amount, { inflictor = self, particle_path = ITEM_PARTICLES.item_apothesis_heal })
	CustomGiveMana(caster, total_mana_amount, { particle_path = "" })
end
item_apothesis = __TS__Decorate({ registerAbility(nil, nil, getfenv()) }, item_apothesis)
____exports.item_apothesis = item_apothesis
return ____exports