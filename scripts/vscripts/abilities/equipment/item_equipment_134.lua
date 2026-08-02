--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_134"
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
		["51"] = 40,
		["52"] = 40,
		["53"] = 40,
		["54"] = 40,
		["55"] = 40,
		["56"] = 40,
		["58"] = 34,
		["59"] = 43,
		["60"] = 44,
		["61"] = 43,
		["62"] = 21,
		["63"] = 12,
		["64"] = 12,
		["65"] = 12,
		["66"] = 12,
		["67"] = 12,
		["68"] = 12,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 21,
		["74"] = 21,
		["75"] = 48,
		["76"] = 57,
		["77"] = 48,
		["78"] = 57,
		["79"] = 59,
		["80"] = 60,
		["81"] = 59,
		["82"] = 62,
		["83"] = 63,
		["84"] = 64,
		["85"] = 65,
		["86"] = 66,
		["88"] = 68,
		["89"] = 69,
		["90"] = 69,
		["91"] = 69,
		["92"] = 69,
		["93"] = 69,
		["94"] = 69,
		["95"] = 69,
		["96"] = 69,
		["98"] = 62,
		["99"] = 73,
		["100"] = 74,
		["101"] = 73,
		["102"] = 57,
		["103"] = 48,
		["104"] = 48,
		["105"] = 48,
		["106"] = 48,
		["107"] = 48,
		["108"] = 48,
		["109"] = 48,
		["110"] = 48,
		["111"] = 48,
		["112"] = 57,
		["114"] = 57,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_134 = c()
local n = g.item_equipment_134
n.name = "item_equipment_134"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_134"
end
n = e({ j(nil) }, n)
g.item_equipment_134 = n
g.modifier_item_equipment_134 = c()
local o = g.modifier_item_equipment_134
o.name = "modifier_item_equipment_134"
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
		q:AddNewModifier(q, r, "modifier_item_equipment_134_buff", { duration = self.duration })
		AddStateImmunity(q, q, r, self.duration, true)
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
g.modifier_item_equipment_134 = o
g.modifier_item_equipment_134_buff = c()
local s = g.modifier_item_equipment_134_buff
s.name = "modifier_item_equipment_134_buff"
d(s, l)
function s.prototype.GetAbilitySpecialValue(self)
	self.reduce = self:GetAbilitySpecialValueFor("reduce")
end
function s.prototype.OnCreated(self, t)
	local q = self:GetParent()
	if IsServer() then
		PurgeDebuff(q)
		q:EmitSound("DOTA_Item.MinotaurHorn.Cast")
	else
		local u = ParticleManager:CreateParticle("particles/items5_fx/minotaur_horn.vpcf", PATTACH_ABSORIGIN, q)
		self:AddParticle(u, false, false, -1, false, false)
	end
end
function s.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE] = -1000 }
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
g.modifier_item_equipment_134_buff = s
return g