--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_132"
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
		["37"] = 31,
		["38"] = 33,
		["39"] = 33,
		["40"] = 33,
		["41"] = 31,
		["42"] = 31,
		["43"] = 30,
		["44"] = 36,
		["45"] = 37,
		["46"] = 38,
		["47"] = 39,
		["48"] = 40,
		["49"] = 41,
		["50"] = 42,
		["53"] = 45,
		["55"] = 47,
		["56"] = 36,
		["57"] = 49,
		["58"] = 50,
		["59"] = 49,
		["60"] = 52,
		["61"] = 53,
		["62"] = 54,
		["63"] = 55,
		["64"] = 56,
		["65"] = 57,
		["68"] = 60,
		["69"] = 61,
		["70"] = 62,
		["71"] = 62,
		["72"] = 62,
		["73"] = 62,
		["74"] = 62,
		["77"] = 52,
		["78"] = 20,
		["79"] = 11,
		["80"] = 11,
		["81"] = 11,
		["82"] = 11,
		["83"] = 11,
		["84"] = 11,
		["85"] = 11,
		["86"] = 11,
		["87"] = 11,
		["88"] = 20,
		["90"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_132 = c()
local n = g.item_equipment_132
n.name = "item_equipment_132"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_132"
end
n = e({ j(nil) }, n)
g.item_equipment_132 = n
g.modifier_item_equipment_132 = c()
local o = g.modifier_item_equipment_132
o.name = "modifier_item_equipment_132"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.exp_damage = self:GetAbilitySpecialValueFor("exp_damage")
	self.chaos_count = self:GetAbilitySpecialValueFor("chaos_count")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function o.prototype.OnBattleStartBefore(self, p)
	self.exp_record = 0
	local q = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
	if q then
		local r = q and q:getAbilityData(true)
		if r and r.sect_chaos then
			self.exp_record = r.sect_chaos.exp
		end
	else
		debug.traceback("item_equipment_132:hero isinvalid!")
	end
	self:StartIntervalThink(self.interval)
end
function o.prototype.OnBattleEnd(self, p)
	self:StartIntervalThink(-1)
end
function o.prototype.OnIntervalThink(self)
	if IsServer() then
		local s = self:GetParent()
		local t = s:GetEnemy()
		if not IsInjurable(s, t) then
			self:StartIntervalThink(-1)
			return
		end
		local u = self.exp_record * self.exp_damage
		if u > 0 then
			s:DealChaosDamage(t, self:GetAbility(), u)
		end
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
g.modifier_item_equipment_132 = o
return g