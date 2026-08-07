--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_74"
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
		["28"] = 7,
		["29"] = 10,
		["30"] = 11,
		["31"] = 11,
		["32"] = 11,
		["33"] = 11,
		["34"] = 12,
		["36"] = 14,
		["37"] = 10,
		["38"] = 16,
		["39"] = 17,
		["40"] = 18,
		["41"] = 19,
		["42"] = 19,
		["43"] = 19,
		["44"] = 19,
		["45"] = 20,
		["46"] = 21,
		["48"] = 16,
		["49"] = 6,
		["50"] = 5,
		["51"] = 6,
		["53"] = 6,
		["54"] = 26,
		["55"] = 35,
		["56"] = 26,
		["57"] = 35,
		["59"] = 35,
		["60"] = 38,
		["61"] = 40,
		["62"] = 26,
		["63"] = 42,
		["64"] = 43,
		["65"] = 44,
		["66"] = 42,
		["67"] = 46,
		["68"] = 47,
		["69"] = 48,
		["70"] = 49,
		["71"] = 50,
		["74"] = 46,
		["75"] = 54,
		["76"] = 55,
		["77"] = 56,
		["78"] = 56,
		["79"] = 55,
		["80"] = 54,
		["81"] = 59,
		["82"] = 60,
		["85"] = 62,
		["86"] = 63,
		["87"] = 64,
		["88"] = 65,
		["89"] = 66,
		["90"] = 67,
		["91"] = 68,
		["92"] = 69,
		["95"] = 59,
		["96"] = 74,
		["97"] = 75,
		["98"] = 75,
		["100"] = 76,
		["101"] = 77,
		["102"] = 78,
		["103"] = 79,
		["104"] = 80,
		["105"] = 81,
		["106"] = 82,
		["108"] = 83,
		["109"] = 83,
		["110"] = 84,
		["111"] = 85,
		["112"] = 86,
		["113"] = 87,
		["115"] = 83,
		["118"] = 90,
		["119"] = 90,
		["120"] = 90,
		["121"] = 90,
		["122"] = 90,
		["123"] = 91,
		["124"] = 91,
		["125"] = 91,
		["126"] = 91,
		["127"] = 92,
		["128"] = 92,
		["129"] = 92,
		["130"] = 92,
		["131"] = 97,
		["132"] = 98,
		["133"] = 99,
		["135"] = 101,
		["136"] = 90,
		["137"] = 90,
		["138"] = 103,
		["140"] = 105,
		["141"] = 74,
		["142"] = 108,
		["143"] = 109,
		["144"] = 110,
		["145"] = 111,
		["146"] = 112,
		["147"] = 113,
		["148"] = 113,
		["149"] = 113,
		["150"] = 114,
		["151"] = 113,
		["152"] = 113,
		["153"] = 116,
		["154"] = 117,
		["156"] = 119,
		["157"] = 120,
		["158"] = 121,
		["159"] = 122,
		["160"] = 123,
		["161"] = 123,
		["162"] = 123,
		["163"] = 123,
		["164"] = 124,
		["169"] = 129,
		["170"] = 108,
		["171"] = 35,
		["172"] = 26,
		["173"] = 26,
		["174"] = 26,
		["175"] = 26,
		["176"] = 26,
		["177"] = 26,
		["178"] = 26,
		["179"] = 26,
		["180"] = 26,
		["181"] = 35,
		["183"] = 35,
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
m.item_artifact_74 = c()
local v = m.item_artifact_74
v.name = "item_artifact_74"
d(v, q)
function v.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_74"
end
function v.prototype.GetBehavior(self)
	if self:GetCaster():GetModifierStackCount("modifier_item_artifact_74", self:GetCaster()) == -1 then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET
	end
	return DOTA_ABILITY_BEHAVIOR_PASSIVE
end
function v.prototype.OnSpellStart(self)
	local w = self:GetCaster()
	local x = w:FindAllModifiersByName("modifier_item_artifact_74")
	local y = e(x, function(z, A)
		return IsValid(A) and A:GetAbility() == self
	end)
	if IsValid(y) then
		y:Activate()
	end
end
v = f({ r(nil) }, v)
m.item_artifact_74 = v
m.modifier_item_artifact_74 = c()
local B = m.modifier_item_artifact_74
B.name = "modifier_item_artifact_74"
d(B, t)
function B.prototype.____constructor(self, ...)
	t.prototype.____constructor(self, ...)
	self.broken = false
	self.activated = false
end
function B.prototype.GetAbilitySpecialValue(self)
	self.refresh = self:GetAbilitySpecialValueFor("refresh")
	self.sr_count = self:GetAbilitySpecialValueFor("sr_count")
end
function B.prototype.OnDestroy(self)
	if IsServer() then
		local C = self:GetParent():GetPlayerOwnerID()
		if self.key then
			Selection:RemoveSpecialSelection(C, self.key)
		end
	end
end
function B.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SHOP_REFRESH] = { self:GetParent(), -1 } }
end
function B.prototype.OnShopRefresh(self, D)
	if self.broken then
		return
	end
	if self:GetStackCount() < self.refresh then
		self:IncrementStackCount()
		local E = self:GetAbility()
		E:SetCurrentCharges(self:GetStackCount())
		if self:GetStackCount() >= self.refresh then
			self.broken = true
			self:SetStackCount(-1)
			E:SetCurrentCharges(1)
		end
	end
end
function B.prototype.Activate(self)
	if self.activated then
		return false
	end
	local w = self:GetCaster()
	local C = w:GetPlayerOwnerID()
	if IsValid(w) then
		self.activated = true
		self:GetAbility():SetCurrentCharges(0)
		local F = {}
		local G = self:getLegendPool(w:GetPlayerOwnerID())
		do
			local H = 0
			while H < self.sr_count do
				local I = G:random()
				if I ~= nil then
					G:remove(I)
					F[#F + 1] = I
				end
				H = H + 1
			end
		end
		self.key = Selection:AddSpecialSelection(C, "ability_card", F, function(z, I)
			PlayerData:getplayerData(w:GetPlayerOwnerID()):addArtifactAbilities(self.ability:entindex(), I)
			Notification:combatToPlayer(
				w:GetPlayerOwnerID(),
				{
					message = "notify_artifact_ability_sr",
					string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_74",
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. I,
				}
			)
			local J = PlayerData:getHero(C)
			if J then
				J:learnAbility(I, true)
			end
			return true
		end)
		return true
	end
	return false
end
function B.prototype.getLegendPool(self, C)
	local J = PlayerData:getHero(C)
	local K = PlayerData:getplayerData(C)
	local L = {}
	local M = {}
	g(AbilityShop.banList, function(z, N)
		M[#M + 1] = N
	end)
	if K.bannedSect then
		M[#M + 1] = K.bannedSect
	end
	for O, P in pairs(KeyValues.AbilityUpgradesKvs) do
		if P.rarity ~= nil and P.rarity == "sr" then
			if J:getAbilityUpgradeLevel(O) < SECT_ABILITY_LEVEL.sr then
				local Q = h(P.sect, "|")
				if not j(Q, function(z, A)
					return i(M, A)
				end) then
					L[O] = 1
				end
			end
		end
	end
	return k(o, L)
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
m.modifier_item_artifact_74 = B
return m