--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
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
		["31"] = 22,
		["32"] = 23,
		["33"] = 24,
		["34"] = 25,
		["35"] = 31,
		["36"] = 32,
		["39"] = 10,
		["40"] = 37,
		["41"] = 37,
		["42"] = 37,
		["44"] = 38,
		["45"] = 39,
		["46"] = 40,
		["49"] = 43,
		["50"] = 44,
		["53"] = 47,
		["54"] = 47,
		["55"] = 47,
		["56"] = 48,
		["57"] = 47,
		["58"] = 47,
		["59"] = 37,
		["60"] = 51,
		["61"] = 52,
		["62"] = 53,
		["63"] = 53,
		["65"] = 54,
		["66"] = 55,
		["67"] = 56,
		["68"] = 57,
		["71"] = 60,
		["72"] = 51,
		["73"] = 6,
		["74"] = 5,
		["75"] = 6,
		["77"] = 6,
		["78"] = 64,
		["79"] = 71,
		["80"] = 64,
		["81"] = 71,
		["82"] = 71,
		["83"] = 64,
		["84"] = 64,
		["85"] = 64,
		["86"] = 64,
		["87"] = 64,
		["88"] = 64,
		["89"] = 64,
		["90"] = 71,
		["92"] = 71,
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
		local t = self:GetPreviousNeutralWinCount(p)
		o:AddItemByName(q)
		PlayerData:addArtifact(p, q, false)
		FireModifierEvent(
			EOMModifierEvents.MODIFIER_EVENT_ON_SELECT_ARTIFACT,
			{ playerID = p, artifact = q, gift = true },
			o
		)
		if t > 0 then
			self:GrantPreviousNeutralWinCount(o, t)
		end
	end
end
function n.prototype.GrantPreviousNeutralWinCount(self, o, u, v)
	if v == nil then
		v = 10
	end
	local w = IsValid(o) and o:FindModifierByName("modifier_item_artifact_146") or nil
	if w then
		w:SetStackCount(w:GetStackCount() + u)
		return
	end
	if v <= 0 then
		print(("<!><E> trait_188: modifier_item_artifact_146 not found, lost " .. tostring(u)) .. " neutral win points")
		return
	end
	GameTimer(0, function()
		self:GrantPreviousNeutralWinCount(o, u, v - 1)
	end)
end
function n.prototype.GetPreviousNeutralWinCount(self, p)
	local x = CombatLog.roundMatchInfo[p]
	if not x then
		return 0
	end
	local u = 0
	for y, z in pairs(x) do
		if (string.find(z.enemy, "N_", nil, true) or 0) - 1 == 0 and z.isWinner == true then
			u = u + 1
		end
	end
	return u
end
n = e({ j(nil) }, n)
g.trait_188 = n
g.modifier_trait_188 = c()
local A = g.modifier_trait_188
A.name = "modifier_trait_188"
d(A, l)
A = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	A
)
g.modifier_trait_188 = A
return g