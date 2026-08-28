--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_43"
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
		["15"] = 5,
		["16"] = 6,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 8,
		["21"] = 7,
		["22"] = 6,
		["23"] = 5,
		["24"] = 6,
		["26"] = 6,
		["27"] = 12,
		["28"] = 21,
		["29"] = 12,
		["30"] = 21,
		["31"] = 25,
		["32"] = 26,
		["33"] = 27,
		["34"] = 28,
		["35"] = 25,
		["36"] = 30,
		["37"] = 31,
		["38"] = 31,
		["39"] = 33,
		["40"] = 33,
		["41"] = 33,
		["42"] = 31,
		["43"] = 31,
		["44"] = 30,
		["45"] = 36,
		["46"] = 37,
		["47"] = 36,
		["48"] = 39,
		["49"] = 40,
		["50"] = 39,
		["51"] = 42,
		["52"] = 43,
		["53"] = 44,
		["54"] = 45,
		["55"] = 42,
		["56"] = 21,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 12,
		["65"] = 12,
		["66"] = 21,
		["68"] = 21,
		["69"] = 49,
		["70"] = 58,
		["71"] = 49,
		["72"] = 58,
		["73"] = 61,
		["74"] = 62,
		["75"] = 63,
		["76"] = 61,
		["77"] = 65,
		["78"] = 66,
		["79"] = 67,
		["81"] = 65,
		["82"] = 70,
		["83"] = 71,
		["84"] = 70,
		["85"] = 75,
		["86"] = 76,
		["87"] = 77,
		["88"] = 77,
		["89"] = 76,
		["90"] = 75,
		["91"] = 80,
		["92"] = 81,
		["93"] = 82,
		["94"] = 83,
		["96"] = 80,
		["97"] = 58,
		["98"] = 49,
		["99"] = 49,
		["100"] = 49,
		["101"] = 49,
		["102"] = 49,
		["103"] = 49,
		["104"] = 49,
		["105"] = 49,
		["106"] = 49,
		["107"] = 58,
		["109"] = 58,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_43 = c()
local n = g.item_equipment_43
n.name = "item_equipment_43"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_43"
end
n = e({ j(nil) }, n)
g.item_equipment_43 = n
g.modifier_item_equipment_43 = c()
local o = g.modifier_item_equipment_43
o.name = "modifier_item_equipment_43"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function o.prototype.OnBattleStart(self)
	self:StartIntervalThink(self.interval)
end
function o.prototype.OnBattleEnd(self)
	self:StartIntervalThink(-1)
end
function o.prototype.OnIntervalThink(self)
	local p = self:GetParent()
	local q = self:GetAbility()
	p:AddNewModifier(p, q, "modifier_item_equipment_43_buff", { duration = self.duration })
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
g.modifier_item_equipment_43 = o
g.modifier_item_equipment_43_buff = c()
local r = g.modifier_item_equipment_43_buff
r.name = "modifier_item_equipment_43_buff"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.max = self:GetAbilitySpecialValueFor("max")
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function r.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(self.max)
	end
end
function r.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS] = self.chance }
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self:GetParent(), -1 } }
end
function r.prototype.OnEvasion(self)
	self:DecrementStackCount()
	if self:GetStackCount() <= 0 then
		self:Destroy()
	end
end
r = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = true,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	r
)
g.modifier_item_equipment_43_buff = r
return g