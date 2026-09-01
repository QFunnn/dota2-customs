--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		["43"] = 38,
		["44"] = 39,
		["45"] = 40,
		["46"] = 40,
		["48"] = 41,
		["49"] = 42,
		["50"] = 43,
		["51"] = 44,
		["54"] = 47,
		["55"] = 38,
		["56"] = 6,
		["57"] = 5,
		["58"] = 6,
		["60"] = 6,
		["61"] = 51,
		["62"] = 58,
		["63"] = 51,
		["64"] = 58,
		["65"] = 58,
		["66"] = 51,
		["67"] = 51,
		["68"] = 51,
		["69"] = 51,
		["70"] = 51,
		["71"] = 51,
		["72"] = 51,
		["73"] = 58,
		["75"] = 58,
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
		local t = self:GetPreviousNeutralWinCount(p)
		if t > 0 then
			local u = o:FindModifierByName("modifier_item_artifact_146")
			if u then
				u:SetStackCount(u:GetStackCount() + t)
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
function n.prototype.GetPreviousNeutralWinCount(self, p)
	local v = CombatLog.roundMatchInfo[p]
	if not v then
		return 0
	end
	local w = 0
	for x, y in pairs(v) do
		if (string.find(y.enemy, "N_", nil, true) or 0) - 1 == 0 and y.isWinner == true then
			w = w + 1
		end
	end
	return w
end
n = e({ j(nil) }, n)
g.trait_188 = n
g.modifier_trait_188 = c()
local z = g.modifier_trait_188
z.name = "modifier_trait_188"
d(z, l)
z = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	z
)
g.modifier_trait_188 = z
return g