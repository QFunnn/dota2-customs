--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_14"
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
		["30"] = 21,
		["31"] = 22,
		["32"] = 22,
		["33"] = 24,
		["34"] = 24,
		["35"] = 24,
		["36"] = 22,
		["37"] = 22,
		["38"] = 21,
		["39"] = 27,
		["40"] = 28,
		["41"] = 27,
		["42"] = 32,
		["43"] = 33,
		["44"] = 35,
		["46"] = 32,
		["47"] = 38,
		["48"] = 39,
		["49"] = 40,
		["50"] = 41,
		["51"] = 42,
		["53"] = 38,
		["54"] = 45,
		["55"] = 64,
		["56"] = 45,
		["57"] = 66,
		["58"] = 67,
		["59"] = 68,
		["60"] = 68,
		["61"] = 68,
		["62"] = 68,
		["63"] = 68,
		["64"] = 68,
		["65"] = 66,
		["66"] = 70,
		["67"] = 71,
		["68"] = 72,
		["69"] = 70,
		["70"] = 20,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 11,
		["78"] = 11,
		["79"] = 11,
		["80"] = 20,
		["82"] = 20,
		["83"] = 75,
		["84"] = 83,
		["85"] = 75,
		["86"] = 83,
		["87"] = 84,
		["88"] = 85,
		["89"] = 84,
		["90"] = 83,
		["91"] = 75,
		["92"] = 75,
		["93"] = 75,
		["94"] = 75,
		["95"] = 75,
		["96"] = 75,
		["97"] = 75,
		["98"] = 75,
		["99"] = 83,
		["101"] = 83,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_14 = c()
local n = g.item_equipment_14
n.name = "item_equipment_14"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_14"
end
n = e({ j(nil) }, n)
g.item_equipment_14 = n
g.modifier_item_equipment_14 = c()
local o = g.modifier_item_equipment_14
o.name = "modifier_item_equipment_14"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SECT_LEVEL_BONUS }
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self:StartIntervalThink(0)
	end
end
function o.prototype.OnIntervalThink(self)
	self:StartIntervalThink(-1)
	local q = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
	for r, s in ipairs(AbilityShop.pickList) do
		q:addSectExp(s, 0)
	end
end
function o.prototype.EOM_GetModifierSectLevelBonus(self, p)
	return 1
end
function o.prototype.OnBattleStart(self)
	local t = self:GetParent()
	t:AddNewModifier(t, self:GetAbility(), "modifier_item_equipment_14_buff", {})
end
function o.prototype.OnBattleEnd(self)
	local t = self:GetParent()
	t:RemoveModifierByName("modifier_item_equipment_14_buff")
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
g.modifier_item_equipment_14 = o
g.modifier_item_equipment_14_buff = c()
local u = g.modifier_item_equipment_14_buff
u.name = "modifier_item_equipment_14_buff"
d(u, l)
function u.prototype.EFunctionValues(self)
	return {}
end
u = e(
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
			}
		),
	},
	u
)
g.modifier_item_equipment_14_buff = u
return g