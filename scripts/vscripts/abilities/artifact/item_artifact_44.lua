--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_44"
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
		["32"] = 25,
		["33"] = 23,
		["34"] = 27,
		["35"] = 28,
		["36"] = 27,
		["37"] = 32,
		["38"] = 33,
		["39"] = 32,
		["40"] = 37,
		["41"] = 38,
		["42"] = 39,
		["43"] = 39,
		["44"] = 39,
		["45"] = 39,
		["46"] = 44,
		["47"] = 45,
		["48"] = 46,
		["49"] = 46,
		["50"] = 46,
		["51"] = 46,
		["52"] = 46,
		["53"] = 47,
		["55"] = 37,
		["56"] = 51,
		["57"] = 52,
		["58"] = 53,
		["59"] = 54,
		["61"] = 51,
		["62"] = 20,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 11,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 20,
		["74"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_44 = c()
local n = g.item_artifact_44
n.name = "item_artifact_44"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_44"
end
n = e({ j(nil) }, n)
g.item_artifact_44 = n
g.modifier_item_artifact_44 = c()
local o = g.modifier_item_artifact_44
o.name = "modifier_item_artifact_44"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.invic_chance = self:GetAbilitySpecialValueFor("invic_chance")
	self.round_cd = self:GetAbilitySpecialValueFor("round_cd")
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PLAYER_DAMAGE_REDUCE }
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function o.prototype.EOM_GetModifierPlayerDamageReduce(self, p)
	if self:PRD(self.invic_chance) and self:GetStackCount() == 0 then
		Notification:combatToPlayer(
			self:GetParent():GetPlayerOwnerID(),
			{
				message = "notify_artifact_44_reduce",
				string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_44",
				int_damage = p.damage,
			}
		)
		self:SetStackCount(self.round_cd)
		self:GetAbility():SetCurrentCharges(self.round_cd - 1)
		PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			:modifyArtifactExtraData(self:GetAbility():entindex(), "resist_damage", p.damage)
		return p.damage
	end
end
function o.prototype.OnRoundStart(self, p)
	if self:GetStackCount() > 0 then
		self:DecrementStackCount()
		self:GetAbility():SetCurrentCharges(self:GetStackCount())
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	o
)
g.modifier_item_artifact_44 = o
return g