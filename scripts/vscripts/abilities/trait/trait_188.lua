--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_188"
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
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 10,
		["22"] = 11,
		["23"] = 12,
		["24"] = 13,
		["25"] = 14,
		["26"] = 16,
		["27"] = 17,
		["28"] = 18,
		["29"] = 19,
		["31"] = 21,
		["32"] = 23,
		["33"] = 24,
		["34"] = 25,
		["35"] = 26,
		["36"] = 27,
		["39"] = 30,
		["40"] = 31,
		["42"] = 10,
		["43"] = 6,
		["44"] = 5,
		["45"] = 6,
		["47"] = 6,
		["48"] = 40,
		["49"] = 47,
		["50"] = 40,
		["51"] = 47,
		["52"] = 47,
		["53"] = 40,
		["54"] = 40,
		["55"] = 40,
		["56"] = 40,
		["57"] = 40,
		["58"] = 40,
		["59"] = 40,
		["60"] = 47,
		["62"] = 47,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_188 = c()
local n = g.trait_188
n.name = "trait_188"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_188"
end
function n.prototype.Spawn(self)
	if IsServer() then
		local o = self:GetCaster()
		local p = o:GetPlayerOwnerID()
		local q = "item_artifact_146"
		local r = PlayerData:getplayerData(p)
		if r and #r.artifacts > 0 then
			local s = r.artifacts[1]
			PlayerData:removeArtifact(p, s, false)
		end
		o:AddItemByName(q)
		if PlayerData:getNeutralArtifactChargePending(p) then
			local t = o:FindModifierByName("modifier_item_artifact_146")
			if t then
				t:IncrementStackCount()
				PlayerData:consumeNeutralArtifactCharge(p)
			end
		end
		PlayerData:addArtifact(p, q, false)
		FireModifierEvent(
			EOMModifierEvents.MODIFIER_EVENT_ON_SELECT_ARTIFACT,
			{ playerID = p, artifact = q, gift = true },
			o
		)
	end
end
n = e({ j(nil) }, n)
g.trait_188 = n
g.modifier_trait_188 = c()
local u = g.modifier_trait_188
u.name = "modifier_trait_188"
d(u, l)
u = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	u
)
g.modifier_trait_188 = u
return g