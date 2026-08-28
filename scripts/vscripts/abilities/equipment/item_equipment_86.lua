--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_86"
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
		["30"] = 25,
		["31"] = 26,
		["32"] = 27,
		["33"] = 28,
		["34"] = 25,
		["35"] = 31,
		["36"] = 32,
		["37"] = 31,
		["38"] = 36,
		["39"] = 37,
		["40"] = 38,
		["41"] = 38,
		["42"] = 38,
		["43"] = 37,
		["44"] = 39,
		["45"] = 39,
		["46"] = 39,
		["47"] = 37,
		["48"] = 37,
		["49"] = 36,
		["50"] = 42,
		["51"] = 43,
		["52"] = 42,
		["53"] = 48,
		["54"] = 49,
		["55"] = 53,
		["56"] = 54,
		["57"] = 55,
		["58"] = 56,
		["59"] = 57,
		["60"] = 58,
		["61"] = 59,
		["62"] = 60,
		["63"] = 60,
		["64"] = 60,
		["65"] = 60,
		["66"] = 60,
		["67"] = 61,
		["68"] = 61,
		["69"] = 61,
		["70"] = 61,
		["74"] = 48,
		["75"] = 67,
		["76"] = 68,
		["77"] = 67,
		["78"] = 72,
		["79"] = 73,
		["80"] = 74,
		["81"] = 75,
		["82"] = 76,
		["83"] = 77,
		["84"] = 78,
		["85"] = 79,
		["86"] = 80,
		["88"] = 82,
		["89"] = 82,
		["90"] = 82,
		["91"] = 82,
		["93"] = 72,
		["94"] = 87,
		["95"] = 88,
		["96"] = 89,
		["97"] = 87,
		["98"] = 20,
		["99"] = 11,
		["100"] = 11,
		["101"] = 11,
		["102"] = 11,
		["103"] = 11,
		["104"] = 11,
		["105"] = 11,
		["106"] = 11,
		["107"] = 11,
		["108"] = 20,
		["110"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_86 = c()
local n = g.item_equipment_86
n.name = "item_equipment_86"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_86"
end
n = e({ j(nil) }, n)
g.item_equipment_86 = n
g.modifier_item_equipment_86 = c()
local o = g.modifier_item_equipment_86
o.name = "modifier_item_equipment_86"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.evade = self:GetAbilitySpecialValueFor("evade")
	self.bonus_hp_pct = self:GetAbilitySpecialValueFor("bonus_hp_pct")
	self.limit = self:GetAbilitySpecialValueFor("limit")
end
function o.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS] = self.evade }
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_HEALTH_PERCENTAGE }
end
function o.prototype.OnWispDie(self, p)
	if IsServer() then
		if self:GetStackCount() > 0 then
			local q = self:GetAbility()
			local r = self:GetParent()
			local s = r:GetPlayerOwnerID()
			if not r:GetHeroBase():isIllusion(r) then
				self:DecrementStackCount()
				q:SetCurrentCharges(q:GetCurrentCharges() + 1)
				PlayerData:saveData(s, "item_equipment_86", q:GetCurrentCharges())
				PlayerData:getHero(s):setItemCharge("item_equipment_86", q:GetCurrentCharges())
			end
		end
	end
end
function o.prototype.OnBattleEnd(self, p)
	self:SetStackCount(0)
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self:SetStackCount(self.limit)
		local r = self:GetParent()
		local s = r:GetPlayerOwnerID()
		local t = PlayerData:loadData(s, "item_equipment_86")
		local q = self:GetAbility()
		if t then
			q:SetCurrentCharges(t)
		end
		PlayerData:getHero(s):setItemCharge("item_equipment_86", q:GetCurrentCharges())
	end
end
function o.prototype.EOM_GetModifierWispHealthPercentage(self, p)
	local q = self:GetAbility()
	return q:GetCurrentCharges() * self.bonus_hp_pct
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
g.modifier_item_equipment_86 = o
return g