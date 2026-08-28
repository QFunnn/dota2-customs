--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		["63"] = 51,
		["64"] = 50,
		["65"] = 53,
		["66"] = 53,
		["67"] = 53,
		["68"] = 50,
		["69"] = 50,
		["70"] = 49,
		["71"] = 57,
		["72"] = 58,
		["73"] = 57,
		["74"] = 61,
		["75"] = 62,
		["76"] = 61,
		["77"] = 65,
		["78"] = 66,
		["81"] = 69,
		["82"] = 70,
		["83"] = 71,
		["86"] = 74,
		["87"] = 75,
		["88"] = 75,
		["89"] = 76,
		["90"] = 76,
		["92"] = 77,
		["93"] = 78,
		["94"] = 78,
		["95"] = 78,
		["97"] = 78,
		["98"] = 79,
		["99"] = 79,
		["100"] = 79,
		["102"] = 79,
		["103"] = 80,
		["104"] = 81,
		["105"] = 82,
		["106"] = 82,
		["107"] = 82,
		["108"] = 82,
		["109"] = 83,
		["112"] = 84,
		["113"] = 85,
		["114"] = 86,
		["116"] = 88,
		["117"] = 89,
		["118"] = 65,
		["119"] = 92,
		["120"] = 93,
		["121"] = 93,
		["122"] = 93,
		["124"] = 93,
		["125"] = 94,
		["126"] = 94,
		["127"] = 94,
		["128"] = 94,
		["131"] = 96,
		["132"] = 96,
		["133"] = 96,
		["134"] = 96,
		["135"] = 96,
		["136"] = 98,
		["137"] = 99,
		["138"] = 99,
		["140"] = 100,
		["141"] = 101,
		["142"] = 101,
		["143"] = 101,
		["145"] = 101,
		["146"] = 102,
		["147"] = 102,
		["148"] = 102,
		["149"] = 102,
		["150"] = 102,
		["151"] = 103,
		["152"] = 103,
		["153"] = 103,
		["154"] = 103,
		["155"] = 103,
		["156"] = 103,
		["157"] = 103,
		["158"] = 104,
		["159"] = 96,
		["160"] = 96,
		["161"] = 92,
		["162"] = 108,
		["163"] = 109,
		["164"] = 110,
		["167"] = 111,
		["168"] = 112,
		["169"] = 113,
		["170"] = 113,
		["171"] = 113,
		["172"] = 113,
		["173"] = 113,
		["174"] = 113,
		["175"] = 113,
		["176"] = 113,
		["179"] = 120,
		["180"] = 121,
		["181"] = 122,
		["184"] = 123,
		["185"] = 124,
		["186"] = 125,
		["187"] = 126,
		["188"] = 127,
		["189"] = 127,
		["190"] = 127,
		["191"] = 127,
		["192"] = 127,
		["193"] = 127,
		["194"] = 127,
		["196"] = 129,
		["197"] = 129,
		["198"] = 129,
		["199"] = 129,
		["200"] = 129,
		["201"] = 129,
		["202"] = 129,
		["203"] = 129,
		["206"] = 136,
		["207"] = 137,
		["208"] = 138,
		["211"] = 139,
		["213"] = 140,
		["214"] = 140,
		["215"] = 141,
		["216"] = 145,
		["217"] = 146,
		["220"] = 147,
		["221"] = 148,
		["222"] = 149,
		["223"] = 149,
		["224"] = 149,
		["225"] = 149,
		["226"] = 149,
		["227"] = 149,
		["228"] = 149,
		["229"] = 149,
		["230"] = 140,
		["234"] = 108,
		["235"] = 158,
		["236"] = 158,
		["237"] = 29,
		["238"] = 22,
		["239"] = 22,
		["240"] = 22,
		["241"] = 22,
		["242"] = 22,
		["243"] = 22,
		["244"] = 22,
		["245"] = 29,
		["247"] = 29,
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
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_SECT_LEVEL_UP] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { self:GetParent(), -1 },
	}
end
function A.prototype.OnSectLevelUp(self)
	self:CheckProgress()
end
function A.prototype.OnAbilityLearn(self)
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