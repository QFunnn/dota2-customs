--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_59"
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
		["33"] = 26,
		["34"] = 27,
		["35"] = 28,
		["37"] = 26,
		["38"] = 32,
		["39"] = 33,
		["40"] = 32,
		["41"] = 38,
		["42"] = 39,
		["43"] = 38,
		["44"] = 42,
		["45"] = 43,
		["46"] = 42,
		["47"] = 48,
		["48"] = 49,
		["49"] = 48,
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
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_59 = c()
local n = g.item_artifact_59
n.name = "item_artifact_59"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_59"
end
n = e({ j(nil) }, n)
g.item_artifact_59 = n
g.modifier_item_artifact_59 = c()
local o = g.modifier_item_artifact_59
o.name = "modifier_item_artifact_59"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		PlayerData:OnPrepareReady({ PlayerID = self:GetParent():GetPlayerOwnerID() })
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE] = { -1, -1 } }
end
function o.prototype.OnPrepare(self, p)
	PlayerData:OnPrepareReady({ PlayerID = self:GetParent():GetPlayerOwnerID() })
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PLAYER_DAMAGE_REDUCE }
end
function o.prototype.EOM_GetModifierPlayerDamageReduce(self, p)
	return -self.bonus_damage
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
g.modifier_item_artifact_59 = o
return g