--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_88"
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
		["35"] = 29,
		["36"] = 30,
		["37"] = 30,
		["38"] = 30,
		["39"] = 30,
		["40"] = 31,
		["41"] = 32,
		["44"] = 27,
		["45"] = 37,
		["46"] = 38,
		["47"] = 39,
		["48"] = 39,
		["49"] = 38,
		["50"] = 37,
		["51"] = 43,
		["52"] = 44,
		["53"] = 45,
		["54"] = 46,
		["55"] = 47,
		["56"] = 47,
		["57"] = 47,
		["58"] = 47,
		["59"] = 47,
		["61"] = 43,
		["62"] = 51,
		["63"] = 52,
		["64"] = 51,
		["65"] = 57,
		["66"] = 58,
		["67"] = 57,
		["68"] = 20,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 11,
		["78"] = 20,
		["80"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_88 = c()
local n = g.item_equipment_88
n.name = "item_equipment_88"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_88"
end
n = e({ j(nil) }, n)
g.item_equipment_88 = n
g.modifier_item_equipment_88 = c()
local o = g.modifier_item_equipment_88
o.name = "modifier_item_equipment_88"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.round_attack = self:GetAbilitySpecialValueFor("round_attack")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent()
		local r = PlayerData:loadData(q:GetPlayerOwnerID(), "item_equipment_88")
		if r then
			self:SetStackCount(r)
		end
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function o.prototype.OnBattleEnd(self, p)
	if IsServer() then
		local r = self:GetStackCount()
		local q = self:GetParent()
		PlayerData:saveData(q:GetPlayerOwnerID(), "item_equipment_88", r + 1)
	end
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS }
end
function o.prototype.EOM_GetModifierAttackDamageBonus(self)
	return self:GetStackCount() * self.round_attack
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
g.modifier_item_equipment_88 = o
return g