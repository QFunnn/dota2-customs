--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_40"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ObjectKeys
local g = b.__TS__ArrayFilter
local h = b.__TS__ArrayForEach
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 1,
		["12"] = 1,
		["13"] = 1,
		["14"] = 2,
		["15"] = 2,
		["16"] = 2,
		["17"] = 5,
		["18"] = 6,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 7,
		["24"] = 6,
		["25"] = 5,
		["26"] = 6,
		["28"] = 6,
		["29"] = 12,
		["30"] = 19,
		["31"] = 12,
		["32"] = 19,
		["33"] = 23,
		["34"] = 24,
		["35"] = 25,
		["36"] = 23,
		["37"] = 27,
		["38"] = 28,
		["39"] = 29,
		["40"] = 30,
		["42"] = 27,
		["43"] = 33,
		["44"] = 34,
		["45"] = 33,
		["46"] = 39,
		["47"] = 40,
		["48"] = 41,
		["49"] = 42,
		["50"] = 43,
		["52"] = 39,
		["53"] = 47,
		["54"] = 48,
		["57"] = 51,
		["60"] = 54,
		["61"] = 55,
		["62"] = 56,
		["63"] = 57,
		["64"] = 58,
		["66"] = 60,
		["67"] = 61,
		["68"] = 62,
		["70"] = 63,
		["71"] = 63,
		["72"] = 64,
		["73"] = 65,
		["74"] = 65,
		["75"] = 65,
		["76"] = 66,
		["77"] = 67,
		["78"] = 68,
		["79"] = 69,
		["80"] = 70,
		["81"] = 71,
		["83"] = 73,
		["84"] = 74,
		["86"] = 76,
		["87"] = 65,
		["88"] = 65,
		["89"] = 80,
		["92"] = 81,
		["93"] = 82,
		["94"] = 83,
		["95"] = 84,
		["97"] = 86,
		["98"] = 63,
		["101"] = 88,
		["102"] = 89,
		["103"] = 90,
		["104"] = 90,
		["105"] = 90,
		["106"] = 91,
		["107"] = 92,
		["108"] = 92,
		["109"] = 92,
		["110"] = 92,
		["111"] = 92,
		["112"] = 92,
		["113"] = 92,
		["114"] = 92,
		["115"] = 97,
		["116"] = 97,
		["117"] = 97,
		["118"] = 97,
		["119"] = 97,
		["120"] = 90,
		["121"] = 90,
		["122"] = 99,
		["123"] = 100,
		["125"] = 102,
		["128"] = 47,
		["129"] = 19,
		["130"] = 12,
		["131"] = 12,
		["132"] = 12,
		["133"] = 12,
		["134"] = 12,
		["135"] = 12,
		["136"] = 12,
		["137"] = 19,
		["139"] = 19,
	}
)
local j = {}
local k = require("lib.dota_ts_adapter")
local l = k.BaseAbility
local m = k.registerAbility
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
j.trait_40 = c()
local q = j.trait_40
q.name = "trait_40"
d(q, l)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_40"
end
q = e({ m(nil) }, q)
j.trait_40 = q
j.modifier_trait_40 = c()
local r = j.modifier_trait_40
r.name = "modifier_trait_40"
d(r, o)
function r.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function r.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(self.round)
		self.enable = true
	end
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 },
	}
end
function r.prototype.OnRoundChange(self, s)
	self:IncrementStackCount()
	if self:GetStackCount() >= self.round then
		self.enable = true
		self:SetStackCount(0)
	end
end
function r.prototype.OnBattleEnd(self, t)
	if t.isNeutral ~= nil then
		return
	end
	if not self.enable then
		return
	end
	local u = self:GetParent():GetPlayerOwnerID()
	if t.illusionPlayerID ~= u and (t.losePlayerID == u or t.winPlayerID == u) then
		local v = t.losePlayerID
		if t.losePlayerID == u then
			v = t.winPlayerID
		end
		local w = PlayerData:getHero(u)
		local x = {}
		local y = {}
		do
			local z = 0
			while z < self.count do
				local A = PlayerData:getHero(u):getAbilityUpgradeData()
				local B = PlayerData:getHero(v)
				local C = g(f(B and B:getAbilityUpgradeData() or {}), function(D, E)
					local F = KeyValues.AbilityUpgradesKvs[E]
					local G = SECT_ABILITY_LEVEL[F.rarity]
					local H = 0
					if A[E] and A[E].level then
						H = A[E].level
					end
					if y[E] then
						H = H + y[E]
					end
					return H < G
				end)
				if #C <= 0 then
					break
				end
				local I = GetRandomElement(C)
				x[#x + 1] = I
				if y[I] == nil then
					y[I] = 0
				end
				y[I] = y[I] + 1
				z = z + 1
			end
		end
		local J = self:GetAbility():GetAbilityName()
		if #x > 0 then
			h(x, function(D, K, L)
				w:learnAbility(K, true)
				Notification:combatToPlayer(
					u,
					{
						message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[K].rarity),
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. J,
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. K,
					}
				)
				PlayerData:getplayerData(u):addArtifactAbilities(self:GetAbility():entindex(), K, L == #x - 1)
			end)
			self.enable = false
			self:SetStackCount(0)
		else
			Notification:combatToPlayer(
				u,
				{ message = "notify_enemy_ability_none", string_itemname_artifact = "DOTA_Tooltip_ability_" .. J }
			)
		end
	end
end
r = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	r
)
j.modifier_trait_40 = r
return j