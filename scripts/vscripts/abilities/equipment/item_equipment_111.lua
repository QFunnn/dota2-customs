--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_111"
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
		["30"] = 26,
		["31"] = 27,
		["32"] = 28,
		["33"] = 29,
		["34"] = 30,
		["35"] = 26,
		["36"] = 33,
		["37"] = 34,
		["38"] = 33,
		["39"] = 39,
		["40"] = 40,
		["41"] = 41,
		["42"] = 41,
		["43"] = 40,
		["44"] = 39,
		["45"] = 45,
		["46"] = 46,
		["49"] = 49,
		["50"] = 45,
		["51"] = 52,
		["52"] = 53,
		["53"] = 54,
		["54"] = 55,
		["55"] = 56,
		["56"] = 56,
		["57"] = 56,
		["58"] = 56,
		["59"] = 58,
		["60"] = 59,
		["61"] = 59,
		["62"] = 59,
		["63"] = 59,
		["64"] = 59,
		["65"] = 59,
		["66"] = 59,
		["67"] = 59,
		["68"] = 59,
		["69"] = 60,
		["70"] = 60,
		["71"] = 60,
		["72"] = 60,
		["73"] = 60,
		["74"] = 60,
		["75"] = 60,
		["76"] = 60,
		["77"] = 60,
		["78"] = 61,
		["79"] = 63,
		["80"] = 64,
		["83"] = 52,
		["84"] = 20,
		["85"] = 11,
		["86"] = 11,
		["87"] = 11,
		["88"] = 11,
		["89"] = 11,
		["90"] = 11,
		["91"] = 11,
		["92"] = 11,
		["93"] = 11,
		["94"] = 20,
		["96"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_111 = c()
local n = g.item_equipment_111
n.name = "item_equipment_111"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_111"
end
n = e({ j(nil) }, n)
g.item_equipment_111 = n
g.modifier_item_equipment_111 = c()
local o = g.modifier_item_equipment_111
o.name = "modifier_item_equipment_111"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.bonus_gold = self:GetAbilitySpecialValueFor("bonus_gold")
	self.limit = self:GetAbilitySpecialValueFor("limit")
end
function o.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_DAMAGE_OUTGOING_TO_WISP] = self.bonus_damage }
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE] = { self:GetParent(), -1 } }
end
function o.prototype.OnCreated(self, p)
	if not IsServer() then
		return
	end
	self:SetStackCount(self.limit)
end
function o.prototype.OnWispDie(self, p)
	if self:PRD(self.chance) then
		local q = self:GetParent()
		if IsValid(q) and self:GetStackCount() > 0 then
			PlayerData:modifyGold(q:GetPlayerOwnerID(), self.bonus_gold)
			local r =
				ParticleManager:CreateParticle("particles/items2_fx/hand_of_midas.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, q)
			ParticleManager:SetParticleControlEnt(r, 0, p.wisp, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0, 0, 0), true)
			ParticleManager:SetParticleControlEnt(r, 1, q, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
			ParticleManager:ReleaseParticleIndex(r)
			EmitSoundOn("DOTA_Item.Hand_Of_Midas", q)
			self:DecrementStackCount()
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
g.modifier_item_equipment_111 = o
return g