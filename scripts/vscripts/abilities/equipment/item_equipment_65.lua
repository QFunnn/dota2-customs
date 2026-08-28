--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_65"
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
		["31"] = 29,
		["32"] = 30,
		["33"] = 31,
		["34"] = 32,
		["35"] = 33,
		["36"] = 34,
		["37"] = 35,
		["38"] = 36,
		["39"] = 29,
		["40"] = 38,
		["41"] = 39,
		["42"] = 40,
		["43"] = 41,
		["44"] = 42,
		["46"] = 38,
		["47"] = 45,
		["48"] = 46,
		["49"] = 46,
		["50"] = 46,
		["51"] = 46,
		["52"] = 46,
		["53"] = 45,
		["54"] = 48,
		["55"] = 49,
		["56"] = 49,
		["57"] = 49,
		["58"] = 49,
		["59"] = 49,
		["60"] = 49,
		["62"] = 49,
		["63"] = 48,
		["64"] = 52,
		["65"] = 53,
		["66"] = 54,
		["67"] = 54,
		["68"] = 54,
		["69"] = 54,
		["70"] = 55,
		["71"] = 55,
		["72"] = 55,
		["73"] = 55,
		["74"] = 55,
		["76"] = 52,
		["77"] = 58,
		["78"] = 59,
		["79"] = 60,
		["80"] = 60,
		["81"] = 60,
		["82"] = 59,
		["83"] = 61,
		["84"] = 61,
		["85"] = 61,
		["86"] = 59,
		["87"] = 59,
		["88"] = 58,
		["89"] = 64,
		["90"] = 65,
		["91"] = 66,
		["92"] = 67,
		["93"] = 68,
		["94"] = 69,
		["95"] = 69,
		["96"] = 69,
		["97"] = 69,
		["98"] = 69,
		["99"] = 69,
		["100"] = 69,
		["101"] = 69,
		["102"] = 69,
		["103"] = 70,
		["104"] = 70,
		["105"] = 70,
		["106"] = 70,
		["107"] = 70,
		["108"] = 70,
		["109"] = 70,
		["110"] = 70,
		["111"] = 70,
		["113"] = 64,
		["114"] = 73,
		["115"] = 74,
		["116"] = 75,
		["117"] = 76,
		["118"] = 77,
		["120"] = 79,
		["121"] = 80,
		["123"] = 82,
		["124"] = 73,
		["125"] = 21,
		["126"] = 12,
		["127"] = 12,
		["128"] = 12,
		["129"] = 12,
		["130"] = 12,
		["131"] = 12,
		["132"] = 12,
		["133"] = 12,
		["134"] = 12,
		["135"] = 21,
		["137"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_65 = c()
local n = g.item_equipment_65
n.name = "item_equipment_65"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_65"
end
n = e({ j(nil) }, n)
g.item_equipment_65 = n
g.modifier_item_equipment_65 = c()
local o = g.modifier_item_equipment_65
o.name = "modifier_item_equipment_65"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.base_stack = self:GetAbilitySpecialValueFor("base_stack")
	self.victory_stack = self:GetAbilitySpecialValueFor("victory_stack")
	self.defeat_stack = self:GetAbilitySpecialValueFor("defeat_stack")
	self.base_shield = self:GetAbilitySpecialValueFor("base_shield")
	self.shield_param = self:GetAbilitySpecialValueFor("shield_param")
	self.base_heal = self:GetAbilitySpecialValueFor("base_heal")
	self.heal_param = self:GetAbilitySpecialValueFor("heal_param")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self:Init()
		self:SetStackCount(self:LoadStack())
		self:GetAbility():SetCurrentCharges(self:LoadStack())
	end
end
function o.prototype.SaveStack(self)
	PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), "item_equipment_65", self:GetStackCount())
end
function o.prototype.LoadStack(self)
	local q = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "item_equipment_65")
	if q == nil then
		q = self.base_stack
	end
	return q
end
function o.prototype.Init(self)
	local r = self:GetParent()
	if PlayerData:loadData(r:GetPlayerOwnerID(), "item_equipment_65") == nil then
		PlayerData:saveData(r:GetPlayerOwnerID(), "item_equipment_65", self.base_stack)
	end
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 },
	}
end
function o.prototype.OnCustomAbilityFullyCast(self, p)
	if p then
		local s = self:GetParent()
		local t = self.base_shield + self.shield_param * self:GetStackCount()
		local u = self.base_heal + self.heal_param * self:GetStackCount()
		local v = AddShield
		local w = t
		local x = self:GetAbility()
		v(s, w, x and x:GetAbilityName(), "Ability")
		local y = Heal
		local z = u
		local A = self:GetAbility()
		y(s, z, A and A:GetAbilityName(), "Ability")
	end
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
g.modifier_item_equipment_65 = o
return g