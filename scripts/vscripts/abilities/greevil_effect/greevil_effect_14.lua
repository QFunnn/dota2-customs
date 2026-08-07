--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_effect/greevil_effect_14"
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
		["13"] = 4,
		["14"] = 4,
		["15"] = 4,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 5,
		["20"] = 11,
		["21"] = 20,
		["22"] = 11,
		["23"] = 20,
		["24"] = 24,
		["25"] = 25,
		["26"] = 26,
		["27"] = 24,
		["28"] = 28,
		["29"] = 29,
		["30"] = 30,
		["32"] = 28,
		["33"] = 33,
		["34"] = 34,
		["35"] = 33,
		["36"] = 38,
		["37"] = 39,
		["40"] = 40,
		["41"] = 41,
		["42"] = 42,
		["43"] = 43,
		["44"] = 44,
		["46"] = 38,
		["47"] = 20,
		["48"] = 11,
		["49"] = 11,
		["50"] = 11,
		["51"] = 11,
		["52"] = 11,
		["53"] = 11,
		["54"] = 11,
		["55"] = 11,
		["56"] = 11,
		["57"] = 20,
		["59"] = 20,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = require("abilities.greevil_effect.greevil_effect_base")
local l = k.GreevilEffectBase
g.greevil_effect_14 = c()
local m = g.greevil_effect_14
m.name = "greevil_effect_14"
d(m, l)
function m.prototype.spawn(self)
	self:AddCourierBuff("modifier_greevil_effect_14", {})
end
g.modifier_greevil_effect_14 = c()
local n = g.modifier_greevil_effect_14
n.name = "modifier_greevil_effect_14"
d(n, i)
function n.prototype.GetAbilitySpecialValue(self)
	self.round_ban = self:GetGreevilEffectValueFor("greevil_effect_14", "round_ban")
	self.gold_get = self:GetGreevilEffectValueFor("greevil_effect_14", "gold_get")
end
function n.prototype.OnCreated(self, o)
	if IsServer() then
		self:SetStackCount(self.round_ban)
	end
end
function n.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function n.prototype.OnRoundStart(self, o)
	if self:GetStackCount() <= 0 then
		return
	end
	self:DecrementStackCount()
	if self:GetStackCount() <= 0 then
		local p = self:GetParent():GetPlayerOwnerID()
		PlayerData:modifyGold(p, self.gold_get)
		Notification:combatToPlayer(
			p,
			{
				message = "notify_bonus_gold",
				int_gold = self.gold_get,
				string_itemname_artifact = "DOTA_Tooltip_ability_greevil_effect_14",
			}
		)
	end
end
n = e(
	{
		j(
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
	n
)
g.modifier_greevil_effect_14 = n
return g