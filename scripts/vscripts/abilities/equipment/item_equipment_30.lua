--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_30"
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
		["31"] = 26,
		["32"] = 27,
		["33"] = 28,
		["34"] = 29,
		["35"] = 30,
		["36"] = 26,
		["37"] = 32,
		["38"] = 33,
		["39"] = 34,
		["40"] = 35,
		["41"] = 36,
		["42"] = 37,
		["44"] = 32,
		["45"] = 40,
		["46"] = 41,
		["47"] = 41,
		["48"] = 41,
		["49"] = 41,
		["50"] = 41,
		["51"] = 40,
		["52"] = 43,
		["53"] = 45,
		["54"] = 45,
		["55"] = 45,
		["56"] = 45,
		["57"] = 45,
		["58"] = 45,
		["60"] = 45,
		["61"] = 43,
		["62"] = 48,
		["63"] = 49,
		["64"] = 50,
		["65"] = 50,
		["66"] = 50,
		["67"] = 50,
		["68"] = 51,
		["69"] = 51,
		["70"] = 51,
		["71"] = 51,
		["72"] = 51,
		["74"] = 48,
		["75"] = 54,
		["76"] = 55,
		["77"] = 54,
		["78"] = 59,
		["79"] = 60,
		["80"] = 59,
		["81"] = 62,
		["82"] = 63,
		["83"] = 64,
		["84"] = 64,
		["85"] = 63,
		["86"] = 62,
		["87"] = 67,
		["88"] = 68,
		["89"] = 69,
		["90"] = 70,
		["91"] = 71,
		["93"] = 73,
		["94"] = 74,
		["96"] = 76,
		["97"] = 67,
		["98"] = 21,
		["99"] = 12,
		["100"] = 12,
		["101"] = 12,
		["102"] = 12,
		["103"] = 12,
		["104"] = 12,
		["105"] = 12,
		["106"] = 12,
		["107"] = 12,
		["108"] = 21,
		["110"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_30 = c()
local n = g.item_equipment_30
n.name = "item_equipment_30"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_30"
end
n = e({ j(nil) }, n)
g.item_equipment_30 = n
g.modifier_item_equipment_30 = c()
local o = g.modifier_item_equipment_30
o.name = "modifier_item_equipment_30"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.base_stack = self:GetAbilitySpecialValueFor("base_stack")
	self.ult_power = self:GetAbilitySpecialValueFor("ult_power")
	self.victory_stack = self:GetAbilitySpecialValueFor("victory_stack")
	self.defeat_stack = self:GetAbilitySpecialValueFor("defeat_stack")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self:Init()
		local q = self:LoadStack()
		self:SetStackCount(q)
		self:GetAbility():SetCurrentCharges(q)
	end
end
function o.prototype.SaveStack(self)
	PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), "item_equipment_30", self:GetStackCount())
end
function o.prototype.LoadStack(self)
	local r = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "item_equipment_30")
	if r == nil then
		r = self.base_stack
	end
	return r
end
function o.prototype.Init(self)
	local s = self:GetParent()
	if PlayerData:loadData(s:GetPlayerOwnerID(), "item_equipment_30") == nil then
		PlayerData:saveData(s:GetPlayerOwnerID(), "item_equipment_30", self.base_stack)
	end
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER }
end
function o.prototype.EOM_GetModifierUltiPower(self)
	return self:GetStackCount() * self.ult_power
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function o.prototype.OnBattleEnd(self, p)
	if p.winPlayerID == self:GetParent():GetPlayerOwnerID() then
		self:IncrementStackCount(self.victory_stack)
	elseif p.losePlayerID == self:GetParent():GetPlayerOwnerID() then
		self:DecrementStackCount(self.defeat_stack)
	end
	if self:GetStackCount() < 0 then
		self:SetStackCount(0)
	end
	self:SaveStack()
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
g.modifier_item_equipment_30 = o
return g