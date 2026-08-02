--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_33"
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
		["37"] = 28,
		["38"] = 33,
		["39"] = 34,
		["40"] = 35,
		["41"] = 33,
		["42"] = 37,
		["43"] = 38,
		["44"] = 39,
		["45"] = 40,
		["46"] = 41,
		["47"] = 42,
		["48"] = 42,
		["49"] = 42,
		["50"] = 42,
		["51"] = 42,
		["52"] = 42,
		["55"] = 45,
		["56"] = 46,
		["59"] = 37,
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
		["73"] = 52,
		["74"] = 61,
		["75"] = 52,
		["76"] = 61,
		["77"] = 64,
		["78"] = 65,
		["79"] = 66,
		["80"] = 64,
		["81"] = 68,
		["82"] = 69,
		["83"] = 70,
		["84"] = 71,
		["85"] = 72,
		["86"] = 72,
		["87"] = 72,
		["88"] = 72,
		["89"] = 72,
		["90"] = 73,
		["91"] = 73,
		["92"] = 73,
		["93"] = 73,
		["94"] = 73,
		["95"] = 74,
		["96"] = 74,
		["97"] = 74,
		["98"] = 74,
		["99"] = 74,
		["100"] = 75,
		["101"] = 75,
		["102"] = 75,
		["103"] = 75,
		["104"] = 75,
		["105"] = 75,
		["106"] = 75,
		["107"] = 75,
		["109"] = 68,
		["110"] = 78,
		["111"] = 79,
		["112"] = 78,
		["113"] = 61,
		["114"] = 52,
		["115"] = 52,
		["116"] = 52,
		["117"] = 52,
		["118"] = 52,
		["119"] = 52,
		["120"] = 52,
		["121"] = 52,
		["122"] = 52,
		["123"] = 61,
		["125"] = 61,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_33 = c()
local n = g.item_equipment_33
n.name = "item_equipment_33"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_33"
end
n = e({ j(nil) }, n)
g.item_equipment_33 = n
g.modifier_item_equipment_33 = c()
local o = g.modifier_item_equipment_33
o.name = "modifier_item_equipment_33"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function o.prototype.OnBattleStart(self)
	self:SetStackCount(1)
	self:StartIntervalThink(0.1)
end
function o.prototype.OnIntervalThink(self)
	local p = self:GetParent()
	local q = p:HasModifier("modifier_item_equipment_33_buff")
	if p:GetHealthPercent() <= self.threshold then
		if not q then
			p:AddNewModifier(p, self:GetAbility(), "modifier_item_equipment_33_buff", {})
		end
	else
		if q then
			p:RemoveModifierByName("modifier_item_equipment_33_buff")
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
g.modifier_item_equipment_33 = o
g.modifier_item_equipment_33_buff = c()
local r = g.modifier_item_equipment_33_buff
r.name = "modifier_item_equipment_33_buff"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.magical_resist = self:GetAbilitySpecialValueFor("magical_resist")
	self.hp_regen_percent = self:GetAbilitySpecialValueFor("hp_regen_percent")
end
function r.prototype.OnCreated(self, s)
	if IsClient() then
		local p = self:GetParent()
		local t = ParticleManager:CreateParticle("particles/items2_fx/eternal_shroud.vpcf", PATTACH_CUSTOMORIGIN, p)
		ParticleManager:SetParticleControl(t, 0, p:GetAbsOrigin())
		ParticleManager:SetParticleControl(t, 1, p:GetAbsOrigin() + Vector(0, 0, 96))
		ParticleManager:SetParticleControl(t, 2, Vector(100, 0, 0))
		self:AddParticle(t, false, false, -1, false, false)
	end
end
function r.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE] = -self.magical_resist,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_AMPLIFY] = self.hp_regen_percent,
	}
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
g.modifier_item_equipment_33_buff = r
return g