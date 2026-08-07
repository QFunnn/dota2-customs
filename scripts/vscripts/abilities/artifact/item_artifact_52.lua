--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_52"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFind
local f = b.__TS__DecorateLegacy
local g = b.__TS__ArrayForEach
local h = b.__TS__StringSplit
local i = b.__TS__ArrayIncludes
local j = b.__TS__ArraySome
local k = b.__TS__New
local l = b.__TS__SourceMapTraceBack
l(
	debug.getinfo(1).short_src,
	{
		["14"] = 1,
		["15"] = 1,
		["16"] = 2,
		["17"] = 2,
		["18"] = 2,
		["19"] = 3,
		["20"] = 3,
		["21"] = 3,
		["22"] = 5,
		["23"] = 6,
		["24"] = 5,
		["25"] = 6,
		["26"] = 7,
		["27"] = 8,
		["28"] = 9,
		["30"] = 7,
		["31"] = 13,
		["32"] = 14,
		["33"] = 15,
		["34"] = 16,
		["35"] = 16,
		["36"] = 16,
		["37"] = 16,
		["38"] = 17,
		["39"] = 18,
		["41"] = 13,
		["42"] = 22,
		["43"] = 23,
		["44"] = 24,
		["45"] = 25,
		["47"] = 27,
		["48"] = 22,
		["49"] = 29,
		["50"] = 30,
		["51"] = 29,
		["52"] = 32,
		["53"] = 33,
		["54"] = 32,
		["55"] = 6,
		["56"] = 5,
		["57"] = 6,
		["59"] = 6,
		["60"] = 38,
		["61"] = 47,
		["62"] = 38,
		["63"] = 47,
		["65"] = 47,
		["66"] = 52,
		["67"] = 38,
		["68"] = 54,
		["69"] = 55,
		["70"] = 56,
		["71"] = 57,
		["72"] = 54,
		["73"] = 59,
		["74"] = 60,
		["75"] = 61,
		["76"] = 62,
		["77"] = 63,
		["80"] = 59,
		["81"] = 67,
		["82"] = 68,
		["83"] = 68,
		["85"] = 69,
		["86"] = 70,
		["87"] = 71,
		["88"] = 72,
		["89"] = 73,
		["90"] = 74,
		["91"] = 75,
		["92"] = 75,
		["93"] = 75,
		["94"] = 75,
		["95"] = 76,
		["96"] = 77,
		["97"] = 78,
		["98"] = 78,
		["99"] = 78,
		["100"] = 78,
		["101"] = 79,
		["102"] = 79,
		["103"] = 79,
		["104"] = 79,
		["105"] = 80,
		["106"] = 80,
		["107"] = 80,
		["108"] = 80,
		["109"] = 80,
		["110"] = 80,
		["111"] = 80,
		["112"] = 81,
		["113"] = 81,
		["114"] = 81,
		["115"] = 81,
		["116"] = 82,
		["117"] = 82,
		["118"] = 82,
		["119"] = 82,
		["120"] = 82,
		["121"] = 82,
		["122"] = 82,
		["123"] = 82,
		["124"] = 82,
		["126"] = 93,
		["127"] = 94,
		["129"] = 95,
		["130"] = 95,
		["131"] = 96,
		["132"] = 97,
		["133"] = 98,
		["134"] = 99,
		["136"] = 95,
		["139"] = 102,
		["140"] = 102,
		["141"] = 102,
		["142"] = 102,
		["143"] = 102,
		["144"] = 103,
		["145"] = 104,
		["146"] = 104,
		["147"] = 104,
		["148"] = 104,
		["149"] = 105,
		["150"] = 105,
		["151"] = 105,
		["152"] = 105,
		["153"] = 110,
		["154"] = 111,
		["155"] = 112,
		["157"] = 114,
		["158"] = 102,
		["159"] = 102,
		["160"] = 116,
		["162"] = 118,
		["163"] = 67,
		["164"] = 121,
		["165"] = 122,
		["166"] = 123,
		["167"] = 124,
		["168"] = 125,
		["169"] = 126,
		["170"] = 126,
		["171"] = 126,
		["172"] = 127,
		["173"] = 126,
		["174"] = 126,
		["175"] = 129,
		["176"] = 130,
		["178"] = 132,
		["179"] = 133,
		["180"] = 134,
		["181"] = 135,
		["182"] = 136,
		["183"] = 136,
		["184"] = 136,
		["185"] = 136,
		["186"] = 137,
		["191"] = 142,
		["192"] = 121,
		["193"] = 47,
		["194"] = 38,
		["195"] = 38,
		["196"] = 38,
		["197"] = 38,
		["198"] = 38,
		["199"] = 38,
		["200"] = 38,
		["201"] = 38,
		["202"] = 38,
		["203"] = 47,
		["205"] = 47,
	}
)
local m = {}
local n = require("class.weight_pool")
local o = n.CWeightPool
local p = require("lib.dota_ts_adapter")
local q = p.BaseItem
local r = p.registerAbility
local s = require("modifiers.eom_modifier")
local t = s.EOMModifier
local u = s.registerEOMModifier
m.item_artifact_52 = c()
local v = m.item_artifact_52
v.name = "item_artifact_52"
d(v, q)
function v.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(self:GetSpecialValueFor("initial_charge"))
	end
end
function v.prototype.OnSpellStart(self)
	local w = self:GetCaster()
	local x = w:FindAllModifiersByName("modifier_item_artifact_52")
	local y = e(x, function(z, A)
		return IsValid(A) and A:GetAbility() == self
	end)
	if IsValid(y) and y:Activate() then
		self:SpendCharge()
	end
end
function v.prototype.CastFilterResult(self)
	if self:GetCurrentCharges() == 0 then
		self.error = "没有使用次数"
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function v.prototype.GetCustomCastError(self)
	return self.error
end
function v.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_52"
end
v = f({ r(nil) }, v)
m.item_artifact_52 = v
m.modifier_item_artifact_52 = c()
local B = m.modifier_item_artifact_52
B.name = "modifier_item_artifact_52"
d(B, t)
function B.prototype.____constructor(self, ...)
	t.prototype.____constructor(self, ...)
	self.activated = false
end
function B.prototype.GetAbilitySpecialValue(self)
	self.cost_hp_pct = self:GetAbilitySpecialValueFor("cost_hp_pct")
	self.bonus_gold = self:GetAbilitySpecialValueFor("bonus_gold")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function B.prototype.OnDestroy(self)
	if IsServer() then
		local C = self:GetParent():GetPlayerOwnerID()
		if self.key then
			Selection:RemoveSpecialSelection(C, self.key)
		end
	end
end
function B.prototype.Activate(self)
	if self.activated then
		return false
	end
	local w = self:GetCaster()
	local D = getGoldBattleConfig(nil)
	if IsValid(w) then
		self.activated = true
		local C = w:GetPlayerOwnerID()
		local E = PlayerData:getplayerData(C).health
		local F = math.max(1, math.floor(E * (100 - self.cost_hp_pct) * 0.01))
		local G = E - F
		if G > 0 then
			local H = math.max(
				0,
				D.LosePerHP
						* (1 + GetModifierProperty(
							w,
							EOMModifierFunction.EOM_MODIFIER_PROPERTY_LOSE_PER_HP_GOLD_PERCENTAGE
						) * 0.01)
					+ GetModifierProperty(w, EOMModifierFunction.EOM_MODIFIER_PROPERTY_LOSE_PER_HP_GOLD_BONUS)
			)
			PlayerData:modifyHealth(w:GetPlayerOwnerID(), -G)
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_DAMAGE, w, G, w:GetPlayerOwner())
			PlayerData:modifyGold(w:GetPlayerOwnerID(), G * H)
			FireModifierEvent(
				EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_TAKEDAMAGE,
				{ attackerID = C, victimID = C, player = w, originDamage = G, damage = G, isOver = false, bImmunity = false },
				w,
				w
			)
		end
		local I = {}
		local J = self:getLegendPool(C)
		do
			local K = 0
			while K < self.count do
				local L = J:random()
				if L ~= nil then
					J:remove(L)
					I[#I + 1] = L
				end
				K = K + 1
			end
		end
		self.key = Selection:AddSpecialSelection(C, "ability_card", I, function(z, L)
			PlayerData:modifyGold(C, self.bonus_gold)
			PlayerData:getplayerData(w:GetPlayerOwnerID()):addArtifactAbilities(self.ability:entindex(), L)
			Notification:combatToPlayer(
				w:GetPlayerOwnerID(),
				{
					message = "notify_artifact_ability_sr",
					string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_52",
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. L,
				}
			)
			local M = PlayerData:getHero(C)
			if M then
				M:learnAbility(L, true)
			end
			return true
		end)
		return true
	end
	return false
end
function B.prototype.getLegendPool(self, C)
	local M = PlayerData:getHero(C)
	local N = PlayerData:getplayerData(C)
	local O = {}
	local P = {}
	g(AbilityShop.banList, function(z, Q)
		P[#P + 1] = Q
	end)
	if N.bannedSect then
		P[#P + 1] = N.bannedSect
	end
	for R, S in pairs(KeyValues.AbilityUpgradesKvs) do
		if S.rarity ~= nil and S.rarity == "sr" then
			if M:getAbilityUpgradeLevel(R) < SECT_ABILITY_LEVEL.sr then
				local T = h(S.sect, "|")
				if not j(T, function(z, A)
					return i(P, A)
				end) then
					O[R] = 1
				end
			end
		end
	end
	return k(o, O)
end
B = f(
	{
		u(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	B
)
m.modifier_item_artifact_52 = B
return m