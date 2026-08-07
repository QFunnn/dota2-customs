--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/abilities/trait/trait_39 copy.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__ClassExtends
local f = c.__TS__Decorate
local g = c.__TS__ObjectKeys
local h = c.__TS__ArrayFilter
local i = c.__TS__ArrayForEach
local j = c.__TS__SourceMapTraceBack
j(
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
		["77"] = 65,
		["78"] = 65,
		["79"] = 66,
		["80"] = 67,
		["81"] = 68,
		["82"] = 69,
		["83"] = 70,
		["84"] = 71,
		["86"] = 73,
		["87"] = 74,
		["89"] = 76,
		["90"] = 65,
		["91"] = 65,
		["92"] = 80,
		["95"] = 81,
		["96"] = 82,
		["97"] = 83,
		["98"] = 84,
		["100"] = 86,
		["101"] = 63,
		["104"] = 88,
		["105"] = 89,
		["106"] = 90,
		["107"] = 90,
		["108"] = 90,
		["109"] = 91,
		["110"] = 92,
		["111"] = 92,
		["112"] = 92,
		["113"] = 92,
		["114"] = 92,
		["115"] = 92,
		["116"] = 92,
		["117"] = 92,
		["118"] = 97,
		["119"] = 97,
		["120"] = 97,
		["121"] = 97,
		["122"] = 97,
		["123"] = 90,
		["124"] = 90,
		["125"] = 99,
		["126"] = 100,
		["128"] = 102,
		["131"] = 47,
		["132"] = 19,
		["133"] = 12,
		["134"] = 12,
		["135"] = 12,
		["136"] = 12,
		["137"] = 12,
		["138"] = 12,
		["139"] = 12,
		["140"] = 19,
		["142"] = 19,
	}
)
local k = {}
local l = require("lib.dota_ts_adapter")
local m = l.BaseAbility
local n = l.registerAbility
local o = require("modifiers.eom_modifier")
local p = o.EOMModifier
local q = o.registerEOMModifier
k.trait_39 = d()
local r = k.trait_39
r.name = "trait_39"
e(r, m)
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_39"
end
r = f({ n(nil) }, r)
k.trait_39 = r
k.modifier_trait_39 = d()
local s = k.modifier_trait_39
s.name = "modifier_trait_39"
e(s, p)
function s.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function s.prototype.OnCreated(self, t)
	if IsServer() then
		self:SetStackCount(self.round)
		self.enable = true
	end
end
function s.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 },
	}
end
function s.prototype.OnRoundChange(self, t)
	self:IncrementStackCount()
	if self:GetStackCount() >= self.round then
		self.enable = true
		self:SetStackCount(0)
	end
end
function s.prototype.OnBattleEnd(self, u)
	if u.isNeutral ~= nil then
		return
	end
	if not self.enable then
		return
	end
	local v = self:GetParent():GetPlayerOwnerID()
	if u.illusionPlayerID ~= v and (u.losePlayerID == v or u.winPlayerID == v) then
		local w = u.losePlayerID
		if u.losePlayerID == v then
			w = u.winPlayerID
		end
		local x = PlayerData:getHero(v)
		local y = {}
		local z = {}
		do
			local A = 0
			while A < self.count do
				local B = PlayerData:getHero(v):getAbilityUpgradeData()
				local C = PlayerData:getHero(w)
				if C ~= nil then
					C = C:getAbilityUpgradeData()
				end
				local D = h(g(C or {}), function(E, F)
					local G = KeyValues.AbilityUpgradesKvs[F]
					local H = SECT_ABILITY_LEVEL[G.rarity]
					local I = 0
					if B[F] and B[F].level then
						I = B[F].level
					end
					if z[F] then
						I = I + z[F]
					end
					return I < H
				end)
				if #D <= 0 then
					break
				end
				local J = GetRandomElement(D)
				y[#y + 1] = J
				if z[J] == nil then
					z[J] = 0
				end
				z[J] = z[J] + 1
				A = A + 1
			end
		end
		local K = self:GetAbility():GetAbilityName()
		if #y > 0 then
			i(y, function(E, L, M)
				x:learnAbility(L, true)
				Notification:combatToPlayer(
					v,
					{
						message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[L].rarity),
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. K,
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. L,
					}
				)
				PlayerData:getplayerData(v):addArtifactAbilities(self:GetAbility():entindex(), L, M == #y - 1)
			end)
			self.enable = false
			self:SetStackCount(0)
		else
			Notification:combatToPlayer(
				v,
				{ message = "notify_enemy_ability_none", string_itemname_artifact = "DOTA_Tooltip_ability_" .. K }
			)
		end
	end
end
s = f(
	{ q(
		nil,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	s
)
k.modifier_trait_39 = s
return k