--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_141"
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
		["51"] = 41,
		["52"] = 42,
		["53"] = 43,
		["56"] = 34,
		["57"] = 47,
		["58"] = 48,
		["59"] = 47,
		["60"] = 21,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 12,
		["65"] = 12,
		["66"] = 12,
		["67"] = 12,
		["68"] = 12,
		["69"] = 12,
		["70"] = 21,
		["72"] = 21,
		["73"] = 51,
		["74"] = 60,
		["75"] = 51,
		["76"] = 60,
		["77"] = 62,
		["78"] = 63,
		["79"] = 62,
		["80"] = 65,
		["81"] = 66,
		["83"] = 68,
		["84"] = 69,
		["85"] = 70,
		["86"] = 70,
		["87"] = 70,
		["88"] = 70,
		["89"] = 70,
		["90"] = 70,
		["91"] = 70,
		["92"] = 70,
		["94"] = 65,
		["95"] = 73,
		["96"] = 74,
		["97"] = 73,
		["98"] = 60,
		["99"] = 51,
		["100"] = 51,
		["101"] = 51,
		["102"] = 51,
		["103"] = 51,
		["104"] = 51,
		["105"] = 51,
		["106"] = 51,
		["107"] = 51,
		["108"] = 60,
		["110"] = 60,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_141 = c()
local n = g.item_equipment_141
n.name = "item_equipment_141"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_141"
end
n = e({ j(nil) }, n)
g.item_equipment_141 = n
g.modifier_item_equipment_141 = c()
local o = g.modifier_item_equipment_141
o.name = "modifier_item_equipment_141"
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
	local r = q:GetEnemy()
	local s = self:GetAbility()
	if self:GetStackCount() >= 1 and q:GetHealthPercent() <= self.threshold then
		self:SetStackCount(0)
		q:EmitSound("DOTA_Item.HeavensHalberd.Activate")
		if IsInjurable(r) then
			r:AddNewModifier(q, s, "modifier_item_equipment_141_debuff", { duration = self.duration })
			AddDisarm(q, r, s, self.duration)
		end
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
g.modifier_item_equipment_141 = o
g.modifier_item_equipment_141_debuff = c()
local t = g.modifier_item_equipment_141_debuff
t.name = "modifier_item_equipment_141_debuff"
d(t, l)
function t.prototype.GetAbilitySpecialValue(self)
	self.reduce = self:GetAbilitySpecialValueFor("reduce")
end
function t.prototype.OnCreated(self, u)
	if IsServer() then
	else
		local q = self:GetParent()
		local v = ParticleManager:CreateParticle("particles/items2_fx/heavens_halberd.vpcf", PATTACH_ABSORIGIN, q)
		self:AddParticle(v, false, false, -1, false, false)
	end
end
function t.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_PHYSICAL_DAMAGE_PERCENTAGE] = -self.reduce }
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_PERMANENT,
			}
		),
	},
	t
)
g.modifier_item_equipment_141_debuff = t
return g