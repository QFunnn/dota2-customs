--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_114"
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
		["32"] = 23,
		["33"] = 27,
		["34"] = 28,
		["35"] = 27,
		["36"] = 33,
		["37"] = 34,
		["38"] = 33,
		["39"] = 37,
		["40"] = 38,
		["43"] = 42,
		["44"] = 43,
		["45"] = 44,
		["46"] = 45,
		["47"] = 46,
		["48"] = 47,
		["49"] = 48,
		["50"] = 48,
		["51"] = 48,
		["52"] = 48,
		["53"] = 48,
		["54"] = 48,
		["57"] = 37,
		["58"] = 53,
		["59"] = 54,
		["60"] = 53,
		["61"] = 20,
		["62"] = 11,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 11,
		["69"] = 11,
		["70"] = 11,
		["71"] = 20,
		["73"] = 20,
		["74"] = 59,
		["75"] = 68,
		["76"] = 59,
		["77"] = 68,
		["78"] = 71,
		["79"] = 72,
		["80"] = 71,
		["81"] = 75,
		["82"] = 76,
		["83"] = 75,
		["84"] = 68,
		["85"] = 59,
		["86"] = 59,
		["87"] = 59,
		["88"] = 59,
		["89"] = 59,
		["90"] = 59,
		["91"] = 59,
		["92"] = 59,
		["93"] = 59,
		["94"] = 68,
		["96"] = 68,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_114 = c()
local n = g.item_equipment_114
n.name = "item_equipment_114"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_114"
end
n = e({ j(nil) }, n)
g.item_equipment_114 = n
g.modifier_item_equipment_114 = c()
local o = g.modifier_item_equipment_114
o.name = "modifier_item_equipment_114"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.bonus_mana_regen = self:GetAbilitySpecialValueFor("bonus_mana_regen")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BONUS }
end
function o.prototype.OnBattleStart(self, p)
	if not IsServer() then
		return
	end
	local q = self:GetParent()
	local r = PlayerData:getHero(q:GetPlayerOwnerID())
	if r:getbattleFieldPlayerID() == q:GetPlayerOwnerID() then
		self:SetStackCount(1)
		local s = q:GetEnemy()
		if IsValid(s) then
			s:AddNewModifier(q, self:GetAbility(), "modifier_item_equipment_114_debuff", {})
		end
	end
end
function o.prototype.EOM_GetModifierManaRegenBonus(self)
	return self.bonus_mana_regen * self:GetStackCount()
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
g.modifier_item_equipment_114 = o
g.modifier_item_equipment_114_debuff = c()
local t = g.modifier_item_equipment_114_debuff
t.name = "modifier_item_equipment_114_debuff"
d(t, l)
function t.prototype.GetAbilitySpecialValue(self)
	self.fury_reduce = self:GetAbilitySpecialValueFor("fury_reduce")
end
function t.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_STACK_BONUS] = -self.fury_reduce }
end
t = e(
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
	t
)
g.modifier_item_equipment_114_debuff = t
return g