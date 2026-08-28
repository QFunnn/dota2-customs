--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_107"
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
		["37"] = 32,
		["38"] = 34,
		["39"] = 34,
		["40"] = 34,
		["41"] = 32,
		["42"] = 35,
		["43"] = 35,
		["44"] = 35,
		["45"] = 32,
		["46"] = 32,
		["47"] = 31,
		["48"] = 39,
		["49"] = 40,
		["52"] = 44,
		["53"] = 45,
		["54"] = 45,
		["55"] = 45,
		["56"] = 45,
		["57"] = 45,
		["58"] = 45,
		["59"] = 39,
		["60"] = 48,
		["61"] = 49,
		["64"] = 53,
		["65"] = 54,
		["66"] = 54,
		["67"] = 54,
		["68"] = 54,
		["69"] = 54,
		["70"] = 54,
		["71"] = 48,
		["72"] = 20,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 11,
		["78"] = 11,
		["79"] = 11,
		["80"] = 11,
		["81"] = 11,
		["82"] = 20,
		["84"] = 20,
		["85"] = 59,
		["86"] = 68,
		["87"] = 59,
		["88"] = 68,
		["89"] = 72,
		["90"] = 73,
		["91"] = 74,
		["92"] = 72,
		["93"] = 77,
		["94"] = 78,
		["95"] = 77,
		["96"] = 83,
		["97"] = 84,
		["98"] = 85,
		["99"] = 85,
		["100"] = 84,
		["101"] = 83,
		["102"] = 89,
		["103"] = 90,
		["106"] = 94,
		["107"] = 89,
		["108"] = 97,
		["109"] = 98,
		["110"] = 97,
		["111"] = 101,
		["112"] = 102,
		["113"] = 103,
		["114"] = 103,
		["115"] = 103,
		["116"] = 103,
		["117"] = 101,
		["118"] = 68,
		["119"] = 59,
		["120"] = 59,
		["121"] = 59,
		["122"] = 59,
		["123"] = 59,
		["124"] = 59,
		["125"] = 59,
		["126"] = 59,
		["127"] = 59,
		["128"] = 68,
		["130"] = 68,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_107 = c()
local n = g.item_equipment_107
n.name = "item_equipment_107"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_107"
end
n = e({ j(nil) }, n)
g.item_equipment_107 = n
g.modifier_item_equipment_107 = c()
local o = g.modifier_item_equipment_107
o.name = "modifier_item_equipment_107"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.regen = self:GetAbilitySpecialValueFor("regen")
	self.injury_reduce = self:GetAbilitySpecialValueFor("injury_reduce")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 },
	}
end
function o.prototype.OnBattleStart(self, p)
	if not IsServer() then
		return
	end
	local q = self:GetParent()
	q:AddNewModifier(q, self:GetAbility(), "modifier_item_equipment_107_buff", { duration = self.duration })
end
function o.prototype.OnCustomAbilityFullyCast(self, r)
	if not IsServer() then
		return
	end
	local q = self:GetParent()
	q:AddNewModifier(q, self:GetAbility(), "modifier_item_equipment_107_buff", { duration = self.duration })
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
g.modifier_item_equipment_107 = o
g.modifier_item_equipment_107_buff = c()
local s = g.modifier_item_equipment_107_buff
s.name = "modifier_item_equipment_107_buff"
d(s, l)
function s.prototype.GetAbilitySpecialValue(self)
	self.regen = self:GetAbilitySpecialValueFor("regen")
	self.injury_reduce = self:GetAbilitySpecialValueFor("injury_reduce")
end
function s.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_STACK_BONUS] = -self.injury_reduce }
end
function s.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function s.prototype.OnCreated(self, p)
	if not IsServer then
		return
	end
	self:StartIntervalThink(1)
end
function s.prototype.OnBattleEnd(self, p)
	self:StartIntervalThink(-1)
end
function s.prototype.OnIntervalThink(self)
	local q = self:GetParent()
	q:Heal(self.regen, self:GetAbility())
end
s = e(
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
				GetAttributes = MODIFIER_ATTRIBUTE_PERMANENT,
			}
		),
	},
	s
)
g.modifier_item_equipment_107_buff = s
return g