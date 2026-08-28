--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_69"
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
		["31"] = 26,
		["32"] = 27,
		["33"] = 28,
		["34"] = 29,
		["35"] = 30,
		["36"] = 26,
		["37"] = 32,
		["38"] = 33,
		["39"] = 34,
		["40"] = 34,
		["41"] = 34,
		["42"] = 33,
		["43"] = 33,
		["44"] = 33,
		["45"] = 32,
		["46"] = 38,
		["47"] = 39,
		["48"] = 40,
		["49"] = 41,
		["52"] = 42,
		["53"] = 43,
		["54"] = 44,
		["55"] = 45,
		["56"] = 47,
		["57"] = 47,
		["58"] = 47,
		["59"] = 47,
		["60"] = 47,
		["61"] = 47,
		["62"] = 48,
		["63"] = 48,
		["64"] = 48,
		["65"] = 48,
		["66"] = 48,
		["67"] = 48,
		["69"] = 38,
		["70"] = 51,
		["71"] = 52,
		["72"] = 51,
		["73"] = 21,
		["74"] = 12,
		["75"] = 12,
		["76"] = 12,
		["77"] = 12,
		["78"] = 12,
		["79"] = 12,
		["80"] = 12,
		["81"] = 12,
		["82"] = 12,
		["83"] = 21,
		["85"] = 21,
		["86"] = 56,
		["87"] = 64,
		["88"] = 56,
		["89"] = 64,
		["90"] = 66,
		["91"] = 67,
		["92"] = 66,
		["93"] = 69,
		["94"] = 70,
		["95"] = 69,
		["96"] = 74,
		["97"] = 75,
		["98"] = 74,
		["99"] = 64,
		["100"] = 56,
		["101"] = 56,
		["102"] = 56,
		["103"] = 56,
		["104"] = 56,
		["105"] = 56,
		["106"] = 56,
		["107"] = 56,
		["108"] = 64,
		["110"] = 64,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_69 = c()
local n = g.item_equipment_69
n.name = "item_equipment_69"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_69"
end
n = e({ j(nil) }, n)
g.item_equipment_69 = n
g.modifier_item_equipment_69 = c()
local o = g.modifier_item_equipment_69
o.name = "modifier_item_equipment_69"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.fury_count = self:GetAbilitySpecialValueFor("fury_count")
	self.silent_duration = self:GetAbilitySpecialValueFor("silent_duration")
	self.damage_bonus = self:GetAbilitySpecialValueFor("damage_bonus")
	self.FuryCounter = 0
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
	}
end
function o.prototype.OnFuryGained(self, p)
	local q = self:GetParent()
	local r = q:GetEnemy()
	if not IsValid(r) then
		return
	end
	self.FuryCounter = self.FuryCounter + 1
	if self.FuryCounter >= self.fury_count then
		self.FuryCounter = self.FuryCounter - self.fury_count
		r:EmitSound("DOTA_Item.Bloodthorn.Activate")
		r:AddNewModifier(
			q,
			self:GetAbility(),
			"modifier_item_equipment_69_debuff",
			{ damage_bonus = self.damage_bonus }
		)
		AddSilence(q, r, self:GetAbility(), self.silent_duration)
	end
end
function o.prototype.OnBattleStart(self, p)
	self.FuryCounter = 0
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
g.modifier_item_equipment_69 = o
g.modifier_item_equipment_69_debuff = c()
local s = g.modifier_item_equipment_69_debuff
s.name = "modifier_item_equipment_69_debuff"
d(s, l)
function s.prototype.OnCreated(self, p)
	self.damage_bonus = p.damage_bonus
end
function s.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function s.prototype.EOM_GetModifierIncomingDamagePercentage(self, p)
	return self.damage_bonus
end
s = e(
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
			}
		),
	},
	s
)
g.modifier_item_equipment_69_debuff = s
return g