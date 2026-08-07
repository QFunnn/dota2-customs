--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_81"
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
		["21"] = 9,
		["22"] = 10,
		["23"] = 11,
		["24"] = 12,
		["26"] = 9,
		["27"] = 5,
		["28"] = 4,
		["29"] = 5,
		["31"] = 5,
		["32"] = 17,
		["33"] = 26,
		["34"] = 17,
		["35"] = 26,
		["36"] = 31,
		["37"] = 32,
		["38"] = 33,
		["39"] = 34,
		["40"] = 35,
		["41"] = 31,
		["42"] = 38,
		["43"] = 39,
		["44"] = 40,
		["46"] = 38,
		["47"] = 44,
		["48"] = 45,
		["49"] = 44,
		["50"] = 50,
		["51"] = 51,
		["52"] = 52,
		["53"] = 52,
		["54"] = 51,
		["55"] = 50,
		["56"] = 57,
		["57"] = 58,
		["58"] = 59,
		["59"] = 60,
		["60"] = 61,
		["61"] = 62,
		["62"] = 63,
		["63"] = 64,
		["64"] = 64,
		["65"] = 64,
		["66"] = 64,
		["67"] = 65,
		["68"] = 66,
		["71"] = 57,
		["72"] = 71,
		["73"] = 72,
		["74"] = 73,
		["75"] = 74,
		["76"] = 74,
		["77"] = 74,
		["78"] = 74,
		["79"] = 75,
		["80"] = 76,
		["82"] = 71,
		["83"] = 26,
		["84"] = 17,
		["85"] = 17,
		["86"] = 17,
		["87"] = 17,
		["88"] = 17,
		["89"] = 17,
		["90"] = 17,
		["91"] = 17,
		["92"] = 17,
		["93"] = 26,
		["95"] = 26,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_81 = c()
local n = g.item_equipment_81
n.name = "item_equipment_81"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_81"
end
function n.prototype.Spawn(self)
	if IsServer() then
		local o = self:GetSpecialValueFor("max_charge")
		self:SetCurrentCharges(o)
	end
end
n = e({ j(nil) }, n)
g.item_equipment_81 = n
g.modifier_item_equipment_81 = c()
local p = g.modifier_item_equipment_81
p.name = "modifier_item_equipment_81"
d(p, l)
function p.prototype.GetAbilitySpecialValue(self)
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
	self.mana_restore = self:GetAbilitySpecialValueFor("mana_restore")
	self.max_charge = self:GetAbilitySpecialValueFor("max_charge")
	self.damage_reduce = self:GetAbilitySpecialValueFor("damage_reduce")
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		PlayerData:getHero(self:GetCaster():GetPlayerOwnerID()):setItemCharge("item_equipment_81", self.max_charge)
	end
end
function p.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PARRY_DAMAGE }
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 } }
end
function p.prototype.EOM_GetModifierParryDamage(self, q)
	if IsServer() then
		local r = self:GetAbility()
		if q.damage > self.threshold and r:GetCurrentCharges() > 0 then
			local s = self:GetParent()
			Restore(s, self.mana_restore, true)
			r:SpendCharge()
			PlayerData:getHero(s:GetPlayerOwnerID()):setItemCharge("item_equipment_81", r:GetCurrentCharges())
			s:EmitSound("DOTA_Item.InfusedRaindrop")
			return self.damage_reduce
		end
	end
end
function p.prototype.OnCustomAbilityFullyCast(self, t)
	if IsServer() then
		local r = self:GetAbility()
		local u = math.min(self.max_charge, r:GetCurrentCharges() + 1)
		r:SetCurrentCharges(u)
		PlayerData:getHero(self:GetCaster():GetPlayerOwnerID()):setItemCharge("item_equipment_81", u)
	end
end
p = e(
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
	p
)
g.modifier_item_equipment_81 = p
return g