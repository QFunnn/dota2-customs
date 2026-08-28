--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_130"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 11,
		["27"] = 20,
		["28"] = 11,
		["29"] = 20,
		["30"] = 25,
		["31"] = 26,
		["32"] = 27,
		["33"] = 28,
		["34"] = 25,
		["35"] = 30,
		["36"] = 31,
		["37"] = 30,
		["38"] = 35,
		["39"] = 36,
		["42"] = 39,
		["43"] = 40,
		["44"] = 41,
		["45"] = 42,
		["46"] = 43,
		["48"] = 46,
		["49"] = 35,
		["50"] = 48,
		["51"] = 49,
		["52"] = 50,
		["53"] = 51,
		["54"] = 52,
		["55"] = 53,
		["58"] = 56,
		["59"] = 56,
		["60"] = 56,
		["61"] = 56,
		["62"] = 56,
		["64"] = 48,
		["65"] = 20,
		["66"] = 11,
		["67"] = 11,
		["68"] = 11,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 20,
		["77"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_130 = c()
local n = g.item_equipment_130
n.name = "item_equipment_130"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_130"
end
n = e({ j(nil) }, n)
g.item_equipment_130 = n
g.modifier_item_equipment_130 = c()
local o = g.modifier_item_equipment_130
o.name = "modifier_item_equipment_130"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.exp_damage = self:GetAbilitySpecialValueFor("exp_damage")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function o.prototype.OnBattleStartBefore(self, p)
	if not IsServer() then
		return
	end
	self.exp_record = 0
	local q = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
	local r = q and q:getAbilityData(true)
	if r and r.sect_chaos then
		self.exp_record = r.sect_chaos.exp
	end
	self:StartIntervalThink(self.interval)
end
function o.prototype.OnIntervalThink(self)
	if IsServer() then
		local s = self:GetParent()
		local t = s:GetEnemy()
		if not IsInjurable(s, t) then
			self:StartIntervalThink(-1)
			return
		end
		s:DealChaosDamage(t, self:GetAbility(), self.base_damage + self.exp_record * self.exp_damage)
	end
end
o = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_PERMANENT,
			}
		),
	},
	o
)
g.modifier_item_equipment_130 = o
return g