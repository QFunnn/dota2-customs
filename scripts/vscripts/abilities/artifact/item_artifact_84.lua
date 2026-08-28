--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_84"
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
		["23"] = 6,
		["24"] = 7,
		["25"] = 6,
		["26"] = 7,
		["27"] = 8,
		["28"] = 9,
		["29"] = 10,
		["31"] = 8,
		["32"] = 13,
		["33"] = 14,
		["34"] = 13,
		["35"] = 16,
		["36"] = 17,
		["37"] = 17,
		["38"] = 17,
		["39"] = 17,
		["40"] = 18,
		["42"] = 20,
		["43"] = 16,
		["44"] = 22,
		["45"] = 23,
		["46"] = 24,
		["47"] = 25,
		["48"] = 25,
		["49"] = 25,
		["50"] = 25,
		["51"] = 26,
		["52"] = 27,
		["54"] = 22,
		["55"] = 7,
		["56"] = 6,
		["57"] = 7,
		["59"] = 7,
		["60"] = 32,
		["61"] = 41,
		["62"] = 32,
		["63"] = 41,
		["65"] = 41,
		["66"] = 46,
		["67"] = 47,
		["68"] = 32,
		["69"] = 49,
		["70"] = 50,
		["71"] = 51,
		["72"] = 52,
		["73"] = 53,
		["74"] = 49,
		["75"] = 55,
		["76"] = 56,
		["77"] = 57,
		["79"] = 55,
		["80"] = 60,
		["81"] = 61,
		["82"] = 62,
		["83"] = 63,
		["84"] = 64,
		["85"] = 65,
		["86"] = 66,
		["88"] = 60,
		["89"] = 69,
		["90"] = 70,
		["91"] = 71,
		["92"] = 72,
		["93"] = 73,
		["96"] = 69,
		["97"] = 77,
		["98"] = 78,
		["99"] = 77,
		["100"] = 82,
		["101"] = 83,
		["104"] = 84,
		["107"] = 87,
		["108"] = 88,
		["111"] = 90,
		["112"] = 91,
		["115"] = 92,
		["116"] = 93,
		["119"] = 95,
		["120"] = 96,
		["121"] = 97,
		["123"] = 99,
		["124"] = 100,
		["125"] = 101,
		["126"] = 102,
		["127"] = 103,
		["129"] = 105,
		["131"] = 82,
		["132"] = 108,
		["133"] = 109,
		["134"] = 110,
		["135"] = 111,
		["136"] = 112,
		["137"] = 113,
		["138"] = 114,
		["139"] = 115,
		["140"] = 116,
		["142"] = 117,
		["143"] = 117,
		["144"] = 118,
		["145"] = 119,
		["146"] = 120,
		["147"] = 121,
		["149"] = 117,
		["152"] = 124,
		["153"] = 124,
		["154"] = 124,
		["155"] = 124,
		["156"] = 124,
		["157"] = 125,
		["158"] = 125,
		["159"] = 125,
		["160"] = 125,
		["161"] = 126,
		["162"] = 126,
		["163"] = 126,
		["164"] = 126,
		["165"] = 131,
		["166"] = 132,
		["167"] = 133,
		["169"] = 135,
		["170"] = 124,
		["171"] = 124,
		["172"] = 137,
		["175"] = 140,
		["176"] = 108,
		["177"] = 142,
		["178"] = 143,
		["179"] = 144,
		["180"] = 145,
		["181"] = 146,
		["182"] = 147,
		["183"] = 147,
		["184"] = 147,
		["185"] = 148,
		["186"] = 147,
		["187"] = 147,
		["188"] = 150,
		["189"] = 151,
		["191"] = 153,
		["192"] = 154,
		["193"] = 155,
		["194"] = 156,
		["195"] = 157,
		["196"] = 157,
		["197"] = 157,
		["198"] = 157,
		["199"] = 158,
		["204"] = 163,
		["205"] = 142,
		["206"] = 41,
		["207"] = 32,
		["208"] = 32,
		["209"] = 32,
		["210"] = 32,
		["211"] = 32,
		["212"] = 32,
		["213"] = 32,
		["214"] = 32,
		["215"] = 32,
		["216"] = 41,
		["218"] = 41,
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
m.item_artifact_84 = c()
local v = m.item_artifact_84
v.name = "item_artifact_84"
d(v, q)
function v.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(self:GetSpecialValueFor("init_count"))
	end
end
function v.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_84"
end
function v.prototype.GetBehavior(self)
	if self:GetCaster():GetModifierStackCount("modifier_item_artifact_84", self:GetCaster()) == -1 then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET
	end
	return DOTA_ABILITY_BEHAVIOR_PASSIVE
end
function v.prototype.OnSpellStart(self)
	local w = self:GetCaster()
	local x = w:FindAllModifiersByName("modifier_item_artifact_84")
	local y = e(x, function(z, A)
		return IsValid(A) and A:GetAbility() == self
	end)
	if IsValid(y) then
		y:Activate()
	end
end
v = f({ r(nil) }, v)
m.item_artifact_84 = v
m.modifier_item_artifact_84 = c()
local B = m.modifier_item_artifact_84
B.name = "modifier_item_artifact_84"
d(B, t)
function B.prototype.____constructor(self, ...)
	t.prototype.____constructor(self, ...)
	self.activated = false
	self.broken = false
end
function B.prototype.GetAbilitySpecialValue(self)
	self.lose_count = self:GetAbilitySpecialValueFor("lose_count")
	self.win_count = self:GetAbilitySpecialValueFor("win_count")
	self.init_count = self:GetAbilitySpecialValueFor("init_count")
	self.sr_count = self:GetAbilitySpecialValueFor("sr_count")
end
function B.prototype.OnCreated(self, C)
	if IsServer() then
		self:SetStackCount(self.init_count)
	end
end
function B.prototype.OnIntervalThink(self)
	if IsServer() then
		self:StartIntervalThink(-1)
		self.broken = true
		local D = self:GetAbility()
		D:SetCurrentCharges(1)
		self:SetStackCount(-1)
	end
end
function B.prototype.OnDestroy(self)
	if IsServer() then
		local E = self:GetParent():GetPlayerOwnerID()
		if self.key then
			Selection:RemoveSpecialSelection(E, self.key)
		end
	end
end
function B.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 } }
end
function B.prototype.OnBattleEnd(self, C)
	if self.broken then
		return
	end
	if C.isNeutral ~= nil then
		return
	end
	local F = self:GetStackCount()
	if F == 0 then
		return
	end
	local E = self:GetParent():GetPlayerOwnerID()
	if not (E == C.losePlayerID or E == C.winPlayerID) then
		return
	end
	local G = C.illusionPlayerID ~= nil and C.illusionPlayerID == E
	if G then
		return
	end
	local H = self.lose_count
	if C.winPlayerID == E then
		H = self.win_count
	end
	local I = math.max(0, F - H)
	local D = self:GetAbility()
	D:SetCurrentCharges(I)
	if I <= 0 then
		self:StartIntervalThink(0.2)
	else
		self:SetStackCount(I)
	end
end
function B.prototype.Activate(self)
	if not self.activated then
		local w = self:GetCaster()
		local E = w:GetPlayerOwnerID()
		if IsValid(w) then
			self.activated = true
			self:GetAbility():SetCurrentCharges(0)
			local J = {}
			local K = self:getLegendPool(w:GetPlayerOwnerID())
			do
				local L = 0
				while L < self.sr_count do
					local M = K:random()
					if M ~= nil then
						K:remove(M)
						J[#J + 1] = M
					end
					L = L + 1
				end
			end
			self.key = Selection:AddSpecialSelection(E, "ability_card", J, function(z, M)
				PlayerData:getplayerData(w:GetPlayerOwnerID()):addArtifactAbilities(self.ability:entindex(), M)
				Notification:combatToPlayer(
					w:GetPlayerOwnerID(),
					{
						message = "notify_artifact_ability_sr",
						string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_84",
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. M,
					}
				)
				local N = PlayerData:getHero(E)
				if N then
					N:learnAbility(M, true)
				end
				return true
			end)
			return true
		end
	end
	return false
end
function B.prototype.getLegendPool(self, E)
	local N = PlayerData:getHero(E)
	local O = PlayerData:getplayerData(E)
	local P = {}
	local Q = {}
	g(AbilityShop.banList, function(z, R)
		Q[#Q + 1] = R
	end)
	if O.bannedSect then
		Q[#Q + 1] = O.bannedSect
	end
	for S, T in pairs(KeyValues.AbilityUpgradesKvs) do
		if T.rarity ~= nil and T.rarity == "sr" then
			if N:getAbilityUpgradeLevel(S) < SECT_ABILITY_LEVEL.sr then
				local U = h(T.sect, "|")
				if not j(U, function(z, A)
					return i(Q, A)
				end) then
					P[S] = 1
				end
			end
		end
	end
	return k(o, P)
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
m.modifier_item_artifact_84 = B
return m