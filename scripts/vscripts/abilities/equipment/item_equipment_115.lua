--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_115"
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
		["30"] = 22,
		["31"] = 22,
		["32"] = 25,
		["33"] = 26,
		["34"] = 25,
		["35"] = 31,
		["36"] = 32,
		["39"] = 36,
		["40"] = 37,
		["41"] = 38,
		["42"] = 39,
		["43"] = 39,
		["44"] = 39,
		["45"] = 39,
		["46"] = 39,
		["47"] = 39,
		["49"] = 31,
		["50"] = 20,
		["51"] = 11,
		["52"] = 11,
		["53"] = 11,
		["54"] = 11,
		["55"] = 11,
		["56"] = 11,
		["57"] = 11,
		["58"] = 11,
		["59"] = 11,
		["60"] = 20,
		["62"] = 20,
		["63"] = 45,
		["64"] = 54,
		["65"] = 45,
		["66"] = 54,
		["67"] = 59,
		["68"] = 60,
		["69"] = 61,
		["70"] = 62,
		["71"] = 59,
		["72"] = 65,
		["73"] = 66,
		["74"] = 67,
		["75"] = 67,
		["76"] = 66,
		["77"] = 65,
		["78"] = 71,
		["79"] = 72,
		["80"] = 71,
		["81"] = 78,
		["82"] = 79,
		["85"] = 82,
		["86"] = 83,
		["87"] = 78,
		["88"] = 86,
		["89"] = 87,
		["90"] = 88,
		["91"] = 89,
		["92"] = 90,
		["93"] = 91,
		["94"] = 92,
		["96"] = 95,
		["97"] = 95,
		["98"] = 95,
		["99"] = 95,
		["100"] = 96,
		["101"] = 97,
		["104"] = 86,
		["105"] = 102,
		["106"] = 103,
		["107"] = 102,
		["108"] = 106,
		["109"] = 107,
		["110"] = 108,
		["112"] = 106,
		["113"] = 112,
		["114"] = 113,
		["115"] = 114,
		["117"] = 112,
		["118"] = 54,
		["119"] = 45,
		["120"] = 45,
		["121"] = 45,
		["122"] = 45,
		["123"] = 45,
		["124"] = 45,
		["125"] = 45,
		["126"] = 45,
		["127"] = 45,
		["128"] = 54,
		["130"] = 54,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_115 = c()
local n = g.item_equipment_115
n.name = "item_equipment_115"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_115"
end
n = e({ j(nil) }, n)
g.item_equipment_115 = n
g.modifier_item_equipment_115 = c()
local o = g.modifier_item_equipment_115
o.name = "modifier_item_equipment_115"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self) end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function o.prototype.OnBattleStart(self, p)
	if not IsServer() then
		return
	end
	local q = self:GetParent()
	local r = q:GetEnemy()
	if IsValid(r) then
		r:AddNewModifier(q, self:GetAbility(), "modifier_item_equipment_115_debuff", {})
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
g.modifier_item_equipment_115 = o
g.modifier_item_equipment_115_debuff = c()
local s = g.modifier_item_equipment_115_debuff
s.name = "modifier_item_equipment_115_debuff"
d(s, l)
function s.prototype.GetAbilitySpecialValue(self)
	self.stack = self:GetAbilitySpecialValueFor("stack")
	self.mana_regen_reduce = self:GetAbilitySpecialValueFor("mana_regen_reduce")
	self.attackspeed_reduce = self:GetAbilitySpecialValueFor("attackspeed_reduce")
end
function s.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function s.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_LOSS_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
	}
end
function s.prototype.OnCreated(self, p)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.1)
	self:SetStackCount(self.stack)
end
function s.prototype.OnIntervalThink(self)
	if self:GetStackCount() > 0 then
		local q = self:GetParent()
		local t = GetFury(q)
		if self:GetStackCount() >= t then
			ReduceFury(q, t)
			self:SetStackCount(self:GetStackCount() - t)
		else
			ReduceFury(q, self:GetStackCount())
			self:SetStackCount(0)
			self:StartIntervalThink(-1)
		end
	end
end
function s.prototype.OnBattleEnd(self, p)
	self:StartIntervalThink(-1)
end
function s.prototype.EOM_GetModifierManaLossPercentage(self, p)
	if self:GetStackCount() > 0 then
		return self.mana_regen_reduce
	end
end
function s.prototype.EOM_GetModifierAttackDamageBonus(self)
	if self:GetStackCount() > 0 then
		return self.attackspeed_reduce
	end
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_PERMANENT,
			}
		),
	},
	s
)
g.modifier_item_equipment_115_debuff = s
return g