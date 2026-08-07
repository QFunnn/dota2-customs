--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_171"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArraySlice
local g = b.__TS__ArrayIncludes
local h = b.__TS__ObjectKeys
local i = b.__TS__ArrayFilter
local j = b.__TS__ArraySort
local k = b.__TS__SourceMapTraceBack
k(
	debug.getinfo(1).short_src,
	{
		["13"] = 1,
		["14"] = 1,
		["15"] = 1,
		["16"] = 2,
		["17"] = 2,
		["18"] = 2,
		["19"] = 5,
		["20"] = 6,
		["21"] = 5,
		["22"] = 6,
		["23"] = 7,
		["24"] = 8,
		["25"] = 7,
		["26"] = 6,
		["27"] = 5,
		["28"] = 6,
		["30"] = 6,
		["31"] = 12,
		["32"] = 19,
		["33"] = 12,
		["34"] = 19,
		["35"] = 23,
		["36"] = 24,
		["37"] = 25,
		["38"] = 23,
		["39"] = 28,
		["40"] = 29,
		["41"] = 28,
		["42"] = 34,
		["43"] = 35,
		["46"] = 36,
		["47"] = 37,
		["48"] = 38,
		["51"] = 40,
		["52"] = 41,
		["53"] = 42,
		["54"] = 42,
		["55"] = 43,
		["56"] = 43,
		["58"] = 46,
		["59"] = 46,
		["60"] = 46,
		["61"] = 46,
		["62"] = 47,
		["63"] = 47,
		["64"] = 47,
		["65"] = 47,
		["66"] = 49,
		["67"] = 50,
		["68"] = 51,
		["69"] = 52,
		["73"] = 56,
		["76"] = 58,
		["77"] = 59,
		["78"] = 59,
		["79"] = 59,
		["80"] = 59,
		["81"] = 59,
		["82"] = 59,
		["83"] = 59,
		["84"] = 59,
		["85"] = 59,
		["86"] = 34,
		["87"] = 19,
		["88"] = 12,
		["89"] = 12,
		["90"] = 12,
		["91"] = 12,
		["92"] = 12,
		["93"] = 12,
		["94"] = 12,
		["95"] = 19,
		["97"] = 19,
	}
)
local l = {}
local m = require("lib.dota_ts_adapter")
local n = m.BaseAbility
local o = m.registerAbility
local p = require("modifiers.eom_modifier")
local q = p.EOMModifier
local r = p.registerEOMModifier
l.trait_171 = c()
local s = l.trait_171
s.name = "trait_171"
d(s, n)
function s.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_171"
end
s = e({ o(nil) }, s)
l.trait_171 = s
l.modifier_trait_171 = c()
local t = l.modifier_trait_171
t.name = "modifier_trait_171"
d(t, q)
function t.prototype.GetAbilitySpecialValue(self)
	self.exp_bonus = self:GetAbilitySpecialValueFor("exp_bonus")
	self.max_level = self:GetAbilitySpecialValueFor("max_level")
end
function t.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 } }
end
function t.prototype.OnRoundChange(self, u)
	if not IsServer() then
		return
	end
	local v = self:GetParent():GetPlayerOwnerID()
	local w = PlayerData:getHero(v)
	if not w then
		return
	end
	local x = w:getAbilityData()
	local y = f(AbilityShop.banList)
	local z = PlayerData:getplayerData(v)
	local A = z and z.bannedSect
	if A then
		y[#y + 1] = A
	end
	local B = i(h(x), function(C, D)
		return not g(y, D)
	end)
	j(B, function(C, E, F)
		return x[F].exp - x[E].exp
	end)
	local G = ""
	for C, D in ipairs(B) do
		if x[D].level < self.max_level then
			G = D
			break
		end
	end
	if G == "" then
		return
	end
	w:addSectExp(G, self.exp_bonus)
	Notification:combatToPlayer(
		v,
		{
			message = "notify_artifact_48",
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
			string_sect = "DOTA_Tooltip_ability_" .. G,
			int_exp = self.exp_bonus,
		}
	)
end
t = e(
	{ r(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	t
)
l.modifier_trait_171 = t
return l