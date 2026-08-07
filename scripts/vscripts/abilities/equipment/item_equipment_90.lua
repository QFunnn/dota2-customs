--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_90"
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
		["30"] = 24,
		["31"] = 25,
		["32"] = 26,
		["33"] = 24,
		["34"] = 29,
		["35"] = 30,
		["36"] = 31,
		["37"] = 31,
		["38"] = 31,
		["39"] = 30,
		["40"] = 30,
		["41"] = 30,
		["42"] = 29,
		["43"] = 36,
		["44"] = 37,
		["45"] = 38,
		["46"] = 39,
		["47"] = 40,
		["48"] = 41,
		["49"] = 41,
		["50"] = 41,
		["51"] = 41,
		["52"] = 41,
		["53"] = 41,
		["55"] = 36,
		["56"] = 45,
		["57"] = 46,
		["58"] = 45,
		["59"] = 20,
		["60"] = 11,
		["61"] = 11,
		["62"] = 11,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 11,
		["69"] = 20,
		["71"] = 20,
		["72"] = 51,
		["73"] = 60,
		["74"] = 51,
		["75"] = 60,
		["76"] = 63,
		["77"] = 64,
		["78"] = 65,
		["79"] = 67,
		["80"] = 68,
		["81"] = 68,
		["82"] = 68,
		["83"] = 68,
		["84"] = 68,
		["85"] = 69,
		["86"] = 69,
		["87"] = 69,
		["88"] = 69,
		["89"] = 69,
		["90"] = 69,
		["91"] = 69,
		["92"] = 69,
		["93"] = 69,
		["94"] = 70,
		["95"] = 70,
		["96"] = 70,
		["97"] = 70,
		["98"] = 70,
		["99"] = 70,
		["100"] = 70,
		["101"] = 70,
		["103"] = 63,
		["104"] = 74,
		["105"] = 75,
		["106"] = 74,
		["107"] = 78,
		["108"] = 79,
		["109"] = 78,
		["110"] = 84,
		["111"] = 85,
		["112"] = 86,
		["114"] = 84,
		["115"] = 60,
		["116"] = 51,
		["117"] = 51,
		["118"] = 51,
		["119"] = 51,
		["120"] = 51,
		["121"] = 51,
		["122"] = 51,
		["123"] = 51,
		["124"] = 51,
		["125"] = 60,
		["127"] = 60,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_90 = c()
local n = g.item_equipment_90
n.name = "item_equipment_90"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_90"
end
n = e({ j(nil) }, n)
g.item_equipment_90 = n
g.modifier_item_equipment_90 = c()
local o = g.modifier_item_equipment_90
o.name = "modifier_item_equipment_90"
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
	if self:GetStackCount() >= 1 and q:GetHealthPercent() <= self.threshold then
		self:SetStackCount(0)
		q:EmitSound("Item.CrimsonGuard.Cast")
		q:AddNewModifier(q, self:GetAbility(), "modifier_item_equipment_90_buff", { duration = self.duration })
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
g.modifier_item_equipment_90 = o
g.modifier_item_equipment_90_buff = c()
local r = g.modifier_item_equipment_90_buff
r.name = "modifier_item_equipment_90_buff"
d(r, l)
function r.prototype.OnCreated(self, s)
	if IsServer() then
		local q = self:GetParent()
		local t = ParticleManager:CreateParticle("particles/items2_fx/vanguard_active.vpcf", PATTACH_OVERHEAD_FOLLOW, q)
		ParticleManager:SetParticleControl(t, 0, q:GetAbsOrigin())
		ParticleManager:SetParticleControlEnt(t, 1, q, PATTACH_ABSORIGIN_FOLLOW, nil, q:GetAbsOrigin(), true)
		self:AddParticle(t, false, false, -1, false, false)
	end
end
function r.prototype.GetAbilitySpecialValue(self)
	self.block = self:GetAbilitySpecialValueFor("block")
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PARRY_DAMAGE }
end
function r.prototype.EOM_GetModifierParryDamage(self, s)
	if s.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		return self.block
	end
end
r = e(
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
	r
)
g.modifier_item_equipment_90_buff = r
return g