--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_92"
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
		["34"] = 28,
		["35"] = 29,
		["36"] = 30,
		["37"] = 31,
		["38"] = 31,
		["39"] = 31,
		["40"] = 32,
		["41"] = 33,
		["42"] = 34,
		["45"] = 31,
		["46"] = 31,
		["48"] = 28,
		["49"] = 40,
		["50"] = 41,
		["51"] = 42,
		["52"] = 42,
		["53"] = 41,
		["54"] = 40,
		["55"] = 45,
		["56"] = 46,
		["57"] = 47,
		["58"] = 47,
		["59"] = 47,
		["60"] = 47,
		["61"] = 47,
		["62"] = 47,
		["63"] = 47,
		["64"] = 48,
		["65"] = 49,
		["67"] = 52,
		["70"] = 45,
		["71"] = 57,
		["72"] = 58,
		["73"] = 57,
		["74"] = 62,
		["75"] = 63,
		["76"] = 64,
		["78"] = 62,
		["79"] = 20,
		["80"] = 11,
		["81"] = 11,
		["82"] = 11,
		["83"] = 11,
		["84"] = 11,
		["85"] = 11,
		["86"] = 11,
		["87"] = 11,
		["88"] = 11,
		["89"] = 20,
		["91"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_92 = c()
local n = g.item_equipment_92
n.name = "item_equipment_92"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_92"
end
n = e({ j(nil) }, n)
g.item_equipment_92 = n
g.modifier_item_equipment_92 = c()
local o = g.modifier_item_equipment_92
o.name = "modifier_item_equipment_92"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent()
		self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START, function(r, p, s, t)
			if s == q and p.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
				if self:PRD(self.chance, "equipment_92") then
					p.item_equipment_92 = 1
				end
			end
		end)
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function o.prototype.OnCustomAttackLanded(self, p)
	if (p and p.item_equipment_92) == 1 then
		p.attacker:DealDamage(
			p.target,
			self:GetAbility(),
			self.bonus_damage,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			DamageFlags.DAMAGE_FLAG_NO_EVASION
		)
		if p.attacker:IsRangedAttacker() then
			p.target:EmitSound("DOTA_Item.MKB.ranged")
		else
			p.target:EmitSound("DOTA_Item.MKB.melee")
		end
	end
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SUREHIT_CHANCE }
end
function o.prototype.EOM_GetModifierSurehitChance(self, p)
	if (p and p.item_equipment_92) == 1 then
		return 100
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
g.modifier_item_equipment_92 = o
return g