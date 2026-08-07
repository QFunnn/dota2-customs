--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_35"
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
		["31"] = 24,
		["32"] = 25,
		["33"] = 26,
		["34"] = 24,
		["35"] = 28,
		["36"] = 29,
		["37"] = 30,
		["38"] = 30,
		["39"] = 30,
		["40"] = 29,
		["41"] = 29,
		["42"] = 29,
		["43"] = 28,
		["44"] = 34,
		["45"] = 35,
		["46"] = 36,
		["47"] = 37,
		["48"] = 38,
		["49"] = 39,
		["50"] = 40,
		["52"] = 34,
		["53"] = 43,
		["54"] = 44,
		["55"] = 43,
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
		["69"] = 48,
		["70"] = 57,
		["71"] = 48,
		["72"] = 57,
		["73"] = 59,
		["74"] = 60,
		["75"] = 59,
		["76"] = 62,
		["77"] = 63,
		["78"] = 64,
		["79"] = 68,
		["81"] = 70,
		["82"] = 71,
		["83"] = 71,
		["84"] = 71,
		["85"] = 71,
		["86"] = 71,
		["87"] = 71,
		["88"] = 71,
		["89"] = 71,
		["91"] = 62,
		["92"] = 75,
		["93"] = 76,
		["94"] = 75,
		["95"] = 57,
		["96"] = 48,
		["97"] = 48,
		["98"] = 48,
		["99"] = 48,
		["100"] = 48,
		["101"] = 48,
		["102"] = 48,
		["103"] = 48,
		["104"] = 48,
		["105"] = 57,
		["107"] = 57,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_35 = c()
local n = g.item_equipment_35
n.name = "item_equipment_35"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_35"
end
n = e({ j(nil) }, n)
g.item_equipment_35 = n
g.modifier_item_equipment_35 = c()
local o = g.modifier_item_equipment_35
o.name = "modifier_item_equipment_35"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
	}
end
function o.prototype.OnCustomTakeDamage(self, p)
	local q = self:GetParent()
	local r = self:GetAbility()
	if self:GetStackCount() >= 1 and q:GetHealthPercent() <= self.threshold then
		self:SetStackCount(0)
		q:EmitSound("DOTA_Item.MinotaurHorn.Cast")
		q:AddNewModifier(q, r, "modifier_item_equipment_35_buff", { duration = self.duration })
	end
end
function o.prototype.OnBattleStart(self)
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
g.modifier_item_equipment_35 = o
g.modifier_item_equipment_35_buff = c()
local s = g.modifier_item_equipment_35_buff
s.name = "modifier_item_equipment_35_buff"
d(s, l)
function s.prototype.GetAbilitySpecialValue(self)
	self.reduce = self:GetAbilitySpecialValueFor("reduce")
end
function s.prototype.OnCreated(self, t)
	local q = self:GetParent()
	if IsServer() then
		PurgeDebuff(q)
	else
		local u = ParticleManager:CreateParticle("particles/items5_fx/minotaur_horn.vpcf", PATTACH_ABSORIGIN, q)
		self:AddParticle(u, false, false, -1, false, false)
	end
end
function s.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE] = -self.reduce }
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	s
)
g.modifier_item_equipment_35_buff = s
return g