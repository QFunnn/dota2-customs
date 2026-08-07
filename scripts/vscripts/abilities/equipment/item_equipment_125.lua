--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_125"
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
		["32"] = 25,
		["33"] = 23,
		["34"] = 27,
		["35"] = 28,
		["36"] = 28,
		["37"] = 30,
		["38"] = 30,
		["39"] = 30,
		["40"] = 28,
		["41"] = 28,
		["42"] = 27,
		["43"] = 35,
		["44"] = 36,
		["47"] = 37,
		["48"] = 38,
		["49"] = 39,
		["50"] = 40,
		["51"] = 41,
		["52"] = 42,
		["53"] = 43,
		["54"] = 43,
		["55"] = 43,
		["56"] = 43,
		["57"] = 43,
		["58"] = 43,
		["59"] = 44,
		["60"] = 44,
		["61"] = 44,
		["62"] = 44,
		["63"] = 44,
		["64"] = 44,
		["65"] = 45,
		["69"] = 35,
		["70"] = 50,
		["71"] = 51,
		["72"] = 50,
		["73"] = 20,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 11,
		["78"] = 11,
		["79"] = 11,
		["80"] = 11,
		["81"] = 11,
		["82"] = 11,
		["83"] = 20,
		["85"] = 20,
		["86"] = 54,
		["87"] = 64,
		["88"] = 54,
		["89"] = 64,
		["91"] = 64,
		["92"] = 66,
		["93"] = 54,
		["94"] = 67,
		["95"] = 68,
		["96"] = 67,
		["97"] = 70,
		["98"] = 71,
		["99"] = 72,
		["100"] = 72,
		["101"] = 71,
		["102"] = 70,
		["103"] = 75,
		["104"] = 76,
		["105"] = 75,
		["106"] = 78,
		["107"] = 79,
		["108"] = 80,
		["109"] = 81,
		["110"] = 82,
		["111"] = 82,
		["112"] = 82,
		["113"] = 82,
		["114"] = 82,
		["115"] = 82,
		["117"] = 78,
		["118"] = 64,
		["119"] = 54,
		["120"] = 54,
		["121"] = 54,
		["122"] = 54,
		["123"] = 54,
		["124"] = 54,
		["125"] = 54,
		["126"] = 54,
		["127"] = 64,
		["129"] = 64,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_125 = c()
local n = g.item_equipment_125
n.name = "item_equipment_125"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_125"
end
n = e({ j(nil) }, n)
g.item_equipment_125 = n
g.modifier_item_equipment_125 = c()
local o = g.modifier_item_equipment_125
o.name = "modifier_item_equipment_125"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
	}
end
function o.prototype.OnCustomTakeDamage(self, p)
	if not IsInjurable(p.target) then
		return
	end
	if p.target:GetHealthPercent() <= self.threshold then
		if self:GetStackCount() > 0 then
			self:DecrementStackCount()
			local q = self:GetParent()
			local r = q:GetEnemy()
			if IsInjurable(r, q) then
				AddSilence(q, r, self:GetAbility(), self.duration)
				r:AddNewModifier(
					q,
					self:GetAbility(),
					"modifier_item_equipment_125_debuff",
					{ duration = self.duration }
				)
				q:EmitSound("DOTA_Item.Orchid.Activate")
			end
		end
	end
end
function o.prototype.OnBattleStart(self, s)
	self:SetStackCount(1)
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
g.modifier_item_equipment_125 = o
g.modifier_item_equipment_125_debuff = c()
local t = g.modifier_item_equipment_125_debuff
t.name = "modifier_item_equipment_125_debuff"
d(t, l)
function t.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.record = 0
end
function t.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function t.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() } }
end
function t.prototype.OnCustomTakeDamage(self, p)
	self.record = self.record + p.damage
end
function t.prototype.OnDestroy(self)
	if IsServer() then
		local u = self:GetCaster()
		local q = self:GetParent()
		u:DealDamage(q, self:GetAbility(), self.record * self.damage * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	end
end
t = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	t
)
g.modifier_item_equipment_125_debuff = t
return g