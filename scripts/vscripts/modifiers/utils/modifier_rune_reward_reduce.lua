--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_rune_reward_reduce"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 2,
		["9"] = 2,
		["10"] = 2,
		["11"] = 4,
		["12"] = 12,
		["13"] = 4,
		["14"] = 12,
		["15"] = 13,
		["16"] = 14,
		["17"] = 13,
		["18"] = 16,
		["19"] = 17,
		["20"] = 16,
		["21"] = 21,
		["22"] = 22,
		["23"] = 21,
		["24"] = 24,
		["25"] = 25,
		["26"] = 26,
		["27"] = 27,
		["28"] = 28,
		["29"] = 29,
		["30"] = 30,
		["32"] = 32,
		["33"] = 33,
		["35"] = 35,
		["37"] = 37,
		["40"] = 24,
		["41"] = 41,
		["42"] = 42,
		["43"] = 41,
		["44"] = 46,
		["45"] = 47,
		["46"] = 46,
		["47"] = 12,
		["48"] = 4,
		["49"] = 4,
		["50"] = 4,
		["51"] = 4,
		["52"] = 4,
		["53"] = 4,
		["54"] = 4,
		["55"] = 4,
		["56"] = 12,
		["58"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_rune_reward_reduce = c()
local k = g.modifier_rune_reward_reduce
k.name = "modifier_rune_reward_reduce"
d(k, i)
function k.prototype.OnCreated(self, l)
	self:RefreshRuneReduce()
end
function k.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function k.prototype.OnBattleStartBefore(self, l)
	self:RefreshRuneReduce()
end
function k.prototype.RefreshRuneReduce(self)
	if IsServer() then
		local m = PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
		if m then
			local n = 0
			if m.trait and KeyValues.TraitAbilitiesKv[m.trait] then
				n = n + 1
			end
			if m.trait2 and KeyValues.TraitAbilitiesKv[m.trait2] then
				n = n + 1
			end
			self:SetStackCount(n)
		else
			self:SetStackCount(0)
		end
	end
end
function k.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_RUNE_REWARD_INCOMING_DAMAGE_REDUCE_PERCENTAGE }
end
function k.prototype.EOM_GetModifierRuneRewardIncomingDamageReducePercentage(self, l)
	return self:GetStackCount() * BUFF_VALUE.RuneDamageReduce
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = true,
				IsPurgeException = true,
				RemoveOnDeath = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	k
)
g.modifier_rune_reward_reduce = k
return g