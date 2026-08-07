--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_120"
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
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 12,
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["30"] = 22,
		["31"] = 23,
		["32"] = 22,
		["33"] = 25,
		["34"] = 26,
		["35"] = 27,
		["36"] = 28,
		["37"] = 29,
		["38"] = 30,
		["39"] = 31,
		["40"] = 32,
		["42"] = 34,
		["43"] = 35,
		["44"] = 36,
		["45"] = 37,
		["46"] = 38,
		["47"] = 38,
		["48"] = 38,
		["49"] = 38,
		["50"] = 38,
		["51"] = 38,
		["52"] = 38,
		["53"] = 38,
		["54"] = 43,
		["55"] = 43,
		["56"] = 43,
		["57"] = 43,
		["58"] = 43,
		["62"] = 25,
		["63"] = 48,
		["64"] = 49,
		["65"] = 50,
		["66"] = 51,
		["67"] = 52,
		["68"] = 53,
		["69"] = 54,
		["70"] = 55,
		["71"] = 56,
		["72"] = 57,
		["73"] = 58,
		["78"] = 48,
		["79"] = 19,
		["80"] = 12,
		["81"] = 12,
		["82"] = 12,
		["83"] = 12,
		["84"] = 12,
		["85"] = 12,
		["86"] = 12,
		["87"] = 19,
		["89"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_120 = c()
local n = g.trait_120
n.name = "trait_120"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_120"
end
n = e({ j(nil) }, n)
g.trait_120 = n
g.modifier_trait_120 = c()
local o = g.modifier_trait_120
o.name = "modifier_trait_120"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:getplayerData(q)
		if r then
			if not PlayerData:isShardUnlock(q) then
				self.flag = true
				r:unlockShard()
			end
			local s = r.heroName .. "_shard"
			local t = KeyValues.HeroShardKV[s]
			if type(t.ShardLevel) == "number" and t.ShardLevel == 1 then
				PlayerData:modifyGold(q, self.gold)
				Notification:combatToPlayer(
					q,
					{
						message = "notify_bonus_gold",
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
						int_gold = self.gold,
					}
				)
				r:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.gold)
			end
		end
	end
end
function o.prototype.OnDestroy(self)
	if IsServer() then
		if self.flag then
			local q = self:GetParent():GetPlayerOwnerID()
			local r = PlayerData:getplayerData(q)
			if r then
				r.shardState = false
				r:updateNetTable()
				local u = r.hero
				if GameState:isCeaseFireState() and u then
					u:fixAbilityLevel(u.hero)
				end
			end
		end
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_120 = o
return g