--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_78"
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
		["30"] = 23,
		["31"] = 24,
		["32"] = 23,
		["33"] = 26,
		["34"] = 27,
		["35"] = 28,
		["36"] = 28,
		["37"] = 28,
		["38"] = 29,
		["39"] = 30,
		["40"] = 31,
		["41"] = 32,
		["42"] = 33,
		["45"] = 28,
		["46"] = 28,
		["48"] = 26,
		["49"] = 39,
		["50"] = 40,
		["51"] = 39,
		["52"] = 44,
		["53"] = 45,
		["54"] = 46,
		["55"] = 47,
		["57"] = 44,
		["58"] = 50,
		["59"] = 51,
		["60"] = 50,
		["61"] = 20,
		["62"] = 11,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 11,
		["69"] = 11,
		["70"] = 11,
		["71"] = 20,
		["73"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_78 = c()
local n = g.item_equipment_78
n.name = "item_equipment_78"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_78"
end
n = e({ j(nil) }, n)
g.item_equipment_78 = n
g.modifier_item_equipment_78 = c()
local o = g.modifier_item_equipment_78
o.name = "modifier_item_equipment_78"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.crit_damage = self:GetAbilitySpecialValueFor("crit_damage")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self.hookID = self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START, function(q, p, r, s)
			if r == self:GetParent() then
				local t = self:GetAbility()
				if IsValid(t) and t:IsCooldownReady() and p.damage_type == DAMAGE_TYPE_PHYSICAL then
					t:StartCooldown(-1)
					p.is_crit = true
				end
			end
		end)
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function o.prototype.OnBattleStart(self, p)
	local t = self:GetAbility()
	if IsValid(t) then
		t:StartCooldown(-1)
	end
end
function o.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE] = self.crit_damage }
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
g.modifier_item_equipment_78 = o
return g