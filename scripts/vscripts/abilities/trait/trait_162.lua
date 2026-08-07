--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_162"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArraySlice
local g = b.__TS__ArrayIncludes
local h = b.__TS__ObjectKeys
local i = b.__TS__ArrayFilter
local j = b.__TS__ArraySome
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
		["19"] = 4,
		["20"] = 5,
		["21"] = 6,
		["22"] = 8,
		["23"] = 10,
		["24"] = 11,
		["25"] = 12,
		["26"] = 8,
		["27"] = 15,
		["28"] = 16,
		["29"] = 15,
		["30"] = 16,
		["31"] = 17,
		["32"] = 18,
		["33"] = 17,
		["34"] = 16,
		["35"] = 15,
		["36"] = 16,
		["38"] = 16,
		["39"] = 22,
		["40"] = 29,
		["41"] = 22,
		["42"] = 29,
		["43"] = 36,
		["44"] = 37,
		["45"] = 38,
		["46"] = 39,
		["47"] = 40,
		["48"] = 41,
		["49"] = 42,
		["50"] = 36,
		["51"] = 45,
		["52"] = 46,
		["53"] = 46,
		["54"] = 46,
		["55"] = 46,
		["56"] = 46,
		["58"] = 45,
		["59"] = 49,
		["60"] = 50,
		["61"] = 51,
		["62"] = 51,
		["63"] = 50,
		["64"] = 49,
		["65"] = 55,
		["66"] = 56,
		["67"] = 55,
		["68"] = 59,
		["69"] = 60,
		["72"] = 63,
		["73"] = 64,
		["74"] = 65,
		["77"] = 68,
		["78"] = 69,
		["79"] = 69,
		["80"] = 70,
		["81"] = 70,
		["83"] = 71,
		["84"] = 72,
		["85"] = 72,
		["86"] = 72,
		["88"] = 72,
		["89"] = 73,
		["90"] = 73,
		["91"] = 73,
		["93"] = 73,
		["94"] = 74,
		["95"] = 75,
		["96"] = 76,
		["97"] = 76,
		["98"] = 76,
		["99"] = 76,
		["100"] = 77,
		["103"] = 78,
		["104"] = 79,
		["105"] = 80,
		["107"] = 82,
		["108"] = 83,
		["109"] = 59,
		["110"] = 86,
		["111"] = 87,
		["112"] = 87,
		["113"] = 87,
		["115"] = 87,
		["116"] = 88,
		["117"] = 88,
		["118"] = 88,
		["119"] = 88,
		["122"] = 90,
		["123"] = 90,
		["124"] = 90,
		["125"] = 90,
		["126"] = 90,
		["127"] = 92,
		["128"] = 93,
		["129"] = 93,
		["131"] = 94,
		["132"] = 95,
		["133"] = 95,
		["134"] = 95,
		["136"] = 95,
		["137"] = 96,
		["138"] = 96,
		["139"] = 96,
		["140"] = 96,
		["141"] = 96,
		["142"] = 97,
		["143"] = 97,
		["144"] = 97,
		["145"] = 97,
		["146"] = 97,
		["147"] = 97,
		["148"] = 97,
		["149"] = 98,
		["150"] = 90,
		["151"] = 90,
		["152"] = 86,
		["153"] = 102,
		["154"] = 103,
		["155"] = 104,
		["158"] = 105,
		["159"] = 106,
		["160"] = 107,
		["161"] = 107,
		["162"] = 107,
		["163"] = 107,
		["164"] = 107,
		["165"] = 107,
		["166"] = 107,
		["167"] = 107,
		["170"] = 114,
		["171"] = 115,
		["172"] = 116,
		["175"] = 117,
		["176"] = 118,
		["177"] = 119,
		["178"] = 120,
		["179"] = 121,
		["180"] = 121,
		["181"] = 121,
		["182"] = 121,
		["183"] = 121,
		["184"] = 121,
		["185"] = 121,
		["187"] = 123,
		["188"] = 123,
		["189"] = 123,
		["190"] = 123,
		["191"] = 123,
		["192"] = 123,
		["193"] = 123,
		["194"] = 123,
		["197"] = 130,
		["198"] = 131,
		["199"] = 132,
		["202"] = 133,
		["204"] = 134,
		["205"] = 134,
		["206"] = 135,
		["207"] = 139,
		["208"] = 140,
		["211"] = 141,
		["212"] = 142,
		["213"] = 143,
		["214"] = 143,
		["215"] = 143,
		["216"] = 143,
		["217"] = 143,
		["218"] = 143,
		["219"] = 143,
		["220"] = 143,
		["221"] = 134,
		["225"] = 102,
		["226"] = 152,
		["227"] = 152,
		["228"] = 29,
		["229"] = 22,
		["230"] = 22,
		["231"] = 22,
		["232"] = 22,
		["233"] = 22,
		["234"] = 22,
		["235"] = 22,
		["236"] = 29,
		["238"] = 29,
	}
)
local l = {}
local m = require("lib.dota_ts_adapter")
local n = m.BaseAbility
local o = m.registerAbility
local p = require("modifiers.eom_modifier")
local q = p.EOMModifier
local r = p.registerEOMModifier
local s = { "trait_162_gold", "trait_162_health", "trait_162_abilities" }
local t = "trait_162_reward_level"
local u = "trait_162_pending_reward_count"
local function v(self, w)
	local x = PlayerResource:GetSelectedHeroEntity(w)
	local y = x and x:FindModifierByName("modifier_trait_162")
	return IsValid(y) and y or nil
end
l.trait_162 = c()
local z = l.trait_162
z.name = "trait_162"
d(z, n)
function z.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_162"
end
z = e({ o(nil) }, z)
l.trait_162 = z
l.modifier_trait_162 = c()
local A = l.modifier_trait_162
A.name = "modifier_trait_162"
d(A, q)
function A.prototype.GetAbilitySpecialValue(self)
	self.sectCount = self:GetAbilitySpecialValueFor("sect_count")
	self.maxRewardLevel = self:GetAbilitySpecialValueFor("max_reward_level")
	self.gold = self:GetAbilitySpecialValueFor("gold")
	self.health = self:GetAbilitySpecialValueFor("health")
	local B = self:GetAbilitySpecialValueFor("ability_count")
	self.abilityCount = B > 0 and B or 7
end
function A.prototype.OnCreated(self)
	if IsServer() then
		GameTimer(0, function()
			return self:CheckProgress()
		end)
	end
end
function A.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SECT_LEVEL_UP] = { self:GetParent(), -1 } }
end
function A.prototype.OnSectLevelUp(self)
	self:CheckProgress()
end
function A.prototype.CheckProgress(self)
	if not IsServer() or not IsValid(self) then
		return
	end
	local w = self:GetParent():GetPlayerOwnerID()
	local C = PlayerData:getHero(w)
	if not C then
		return
	end
	local D = f(AbilityShop.banList)
	local E = PlayerData:getplayerData(w)
	local F = E and E.bannedSect
	if F then
		D[#D + 1] = F
	end
	local G = C:getAbilityData()
	local H = PlayerData:loadData(w, t)
	if H == nil then
		H = 0
	end
	local I = H
	local J = PlayerData:loadData(w, u)
	if J == nil then
		J = 0
	end
	local K = J
	while I < self.maxRewardLevel do
		local L = I + 1
		local M = #i(h(G), function(N, O)
			return not g(D, O) and G[O].level >= L
		end)
		if M < self.sectCount then
			break
		end
		I = L
		PlayerData:saveData(w, t, I)
		K = K + 1
	end
	PlayerData:saveData(w, u, K)
	self:TryShowRewardSelection(w)
end
function A.prototype.TryShowRewardSelection(self, w)
	local P = PlayerData:loadData(w, u)
	if P == nil then
		P = 0
	end
	local K = P
	if K <= 0 or j(Selection:GetSelectionData(w), function(N, G)
		return G.type == "trait_reward"
	end) then
		return
	end
	Selection:AddSpecialSelection(w, "trait_reward", s, function(N, Q)
		local y = v(nil, w)
		if not y then
			return false
		end
		y:GiveReward(w, Q)
		local R = PlayerData:loadData(w, u)
		if R == nil then
			R = 0
		end
		local S = R
		PlayerData:saveData(w, u, math.max(0, S - 1))
		GameTimer(0, function()
			local T = v(nil, w)
			return T and T:TryShowRewardSelection(w)
		end)
		return true
	end)
end
function A.prototype.GiveReward(self, w, Q)
	local U = self:GetAbility()
	if not U then
		return
	end
	if Q == "trait_162_gold" then
		PlayerData:modifyGold(w, self.gold)
		Notification:combatToPlayer(
			w,
			{
				message = "notify_bonus_gold",
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. U:GetAbilityName(),
				int_gold = self.gold,
			}
		)
		return
	end
	if Q == "trait_162_health" then
		local V = PlayerData:getplayerData(w)
		if not V then
			return
		end
		local W = V.health
		PlayerData:modifyHealth(w, self.health, true)
		local X = V.health - W
		if X > 0 then
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetParent(), X, self:GetParent():GetPlayerOwner())
		end
		Notification:combatToPlayer(
			w,
			{ message = "notify_bonus_hp", string_itemname_artifact = "DOTA_Tooltip_ability_" .. U:GetAbilityName(), int_hp = X }
		)
		return
	end
	if Q == "trait_162_abilities" then
		local C = PlayerData:getHero(w)
		if not C then
			return
		end
		local Y = {}
		do
			local Z = 0
			while Z < self.abilityCount do
				local _ = AbilityShop:getRandomAbility(w, 1, { isAbilityShop = false, excludedAbility = Y })
				local G = _[1]
				if not G then
					break
				end
				Y[#Y + 1] = G.aid
				C:learnAbility(G.aid, true)
				Notification:combatToPlayer(
					w,
					{
						message = "notify_artifact_ability_" .. G.rarity,
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. U:GetAbilityName(),
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. G.aid,
					}
				)
				Z = Z + 1
			end
		end
	end
end
function A.prototype.OnDestroy(self) end
A = e(
	{ r(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	A
)
l.modifier_trait_162 = A
return l