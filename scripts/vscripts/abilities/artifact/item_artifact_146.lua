--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_146"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.Set
local g = b.__TS__New
local h = b.__TS__ArrayForEach
local i = b.__TS__Delete
local j = b.__TS__StringSplit
local k = b.__TS__SourceMapTraceBack
k(
	debug.getinfo(1).short_src,
	{
		["13"] = 2,
		["14"] = 2,
		["15"] = 2,
		["16"] = 3,
		["17"] = 3,
		["18"] = 3,
		["19"] = 5,
		["20"] = 6,
		["21"] = 5,
		["22"] = 6,
		["23"] = 7,
		["24"] = 8,
		["25"] = 7,
		["26"] = 10,
		["27"] = 11,
		["28"] = 12,
		["29"] = 13,
		["30"] = 14,
		["31"] = 15,
		["32"] = 16,
		["33"] = 17,
		["34"] = 18,
		["35"] = 19,
		["37"] = 21,
		["40"] = 22,
		["42"] = 10,
		["43"] = 6,
		["44"] = 5,
		["45"] = 6,
		["47"] = 6,
		["48"] = 30,
		["49"] = 39,
		["50"] = 30,
		["51"] = 39,
		["52"] = 42,
		["53"] = 43,
		["54"] = 42,
		["55"] = 45,
		["56"] = 46,
		["57"] = 47,
		["58"] = 47,
		["59"] = 47,
		["60"] = 46,
		["61"] = 46,
		["62"] = 46,
		["63"] = 45,
		["64"] = 51,
		["65"] = 52,
		["66"] = 53,
		["67"] = 55,
		["68"] = 56,
		["71"] = 51,
		["72"] = 60,
		["73"] = 61,
		["74"] = 62,
		["75"] = 63,
		["76"] = 64,
		["77"] = 65,
		["78"] = 66,
		["80"] = 66,
		["81"] = 66,
		["82"] = 66,
		["83"] = 67,
		["84"] = 68,
		["85"] = 68,
		["87"] = 66,
		["88"] = 66,
		["90"] = 70,
		["91"] = 72,
		["92"] = 73,
		["93"] = 74,
		["96"] = 77,
		["97"] = 78,
		["100"] = 81,
		["101"] = 82,
		["104"] = 72,
		["105"] = 86,
		["106"] = 88,
		["107"] = 89,
		["109"] = 91,
		["110"] = 92,
		["111"] = 93,
		["112"] = 95,
		["113"] = 96,
		["114"] = 96,
		["115"] = 96,
		["116"] = 96,
		["118"] = 60,
		["119"] = 99,
		["120"] = 101,
		["123"] = 102,
		["124"] = 105,
		["127"] = 107,
		["128"] = 108,
		["129"] = 110,
		["130"] = 111,
		["132"] = 99,
		["133"] = 114,
		["134"] = 115,
		["135"] = 116,
		["136"] = 118,
		["137"] = 119,
		["138"] = 120,
		["139"] = 122,
		["141"] = 123,
		["142"] = 123,
		["143"] = 124,
		["144"] = 127,
		["145"] = 127,
		["146"] = 127,
		["147"] = 128,
		["148"] = 129,
		["149"] = 130,
		["150"] = 135,
		["151"] = 135,
		["152"] = 135,
		["153"] = 135,
		["154"] = 135,
		["155"] = 127,
		["156"] = 127,
		["157"] = 123,
		["160"] = 139,
		["161"] = 140,
		["162"] = 142,
		["165"] = 114,
		["166"] = 146,
		["167"] = 147,
		["168"] = 146,
		["169"] = 39,
		["170"] = 30,
		["171"] = 30,
		["172"] = 30,
		["173"] = 30,
		["174"] = 30,
		["175"] = 30,
		["176"] = 30,
		["177"] = 30,
		["178"] = 30,
		["179"] = 39,
		["181"] = 39,
	}
)
local l = {}
local m = require("lib.dota_ts_adapter")
local n = m.BaseItem
local o = m.registerAbility
local p = require("modifiers.eom_modifier")
local q = p.EOMModifier
local r = p.registerEOMModifier
l.item_artifact_146 = c()
local s = l.item_artifact_146
s.name = "item_artifact_146"
d(s, n)
function s.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_146"
end
function s.prototype.OnSpellStart(self)
	local t = self:GetCaster()
	local u = t:FindModifierByName(self:GetIntrinsicModifierName())
	if u and u:GetStackCount() > 0 then
		local v = t:GetPlayerOwnerID()
		local w = u
		local x = w:GetSecretKey()
		if not x then
			w:RandomizeSecretKey()
			x = w:GetSecretKey()
		end
		if not x then
			return
		end
		Notification:combatToPlayer(
			v,
			{ message = "notify_artifact_9_ability", string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. x }
		)
	end
end
s = e({ o(nil) }, s)
l.item_artifact_146 = s
l.modifier_item_artifact_146 = c()
local y = l.modifier_item_artifact_146
y.name = "modifier_item_artifact_146"
d(y, q)
function y.prototype.GetAbilitySpecialValue(self)
	self.ability_count = self:GetAbilitySpecialValueFor("ability_count")
end
function y.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 },
	}
end
function y.prototype.OnCreated(self, z)
	if IsServer() then
		self:RandomizeSecretKey()
		if self.secret_key then
			self:SetStackCount(1)
		end
	end
end
function y.prototype.RandomizeSecretKey(self)
	local v = self:GetParent():GetPlayerOwnerID()
	local A = PlayerData:getplayerData(v)
	local B = A.hero
	local C = self:GetParent():FindAllModifiersByName("modifier_item_artifact_9")
	local D = g(f)
	local E = C
	if E ~= nil then
		h(C, function(F, w)
			local G = w:GetSecretKey()
			if G then
				D:add(G)
			end
		end)
	end
	local H = AbilityShop:getAbilityPoolNew("n")
	H:each(function(F, I)
		if D:has(I) then
			i(H.tList, I)
			return
		end
		if
			A.bannedSect
			and KeyValues.AbilityUpgradesKvs[I]
			and (string.find(KeyValues.AbilityUpgradesKvs[I].sect, A.bannedSect, nil, true) or 0) - 1 ~= -1
		then
			i(H.tList, I)
			return
		end
		if B:getAbilityUpgradeLevel(I) >= SECT_ABILITY_LEVEL.n then
			i(H.tList, I)
			return
		end
	end)
	H:update()
	if self.secret_key then
		PlayerData:getHero(v):removeSectModifiers(self:GetAbility():GetName())
	end
	self.secret_key = H:random()
	if self.secret_key then
		local J = j(KeyValues.AbilityUpgradesKvs[self.secret_key].sect, "|")
		local K = J[RandomInt(0, #J - 1) + 1]
		PlayerData:getHero(self:GetParent():GetPlayerOwnerID()):addSectModifier(K, self:GetAbility():GetName())
	end
end
function y.prototype.OnBattleEnd(self, z)
	if not z.isNeutral then
		return
	end
	local v = self:GetParent():GetPlayerOwnerID()
	if z.neutralWin ~= true or z.winPlayerID ~= v then
		return
	end
	local L = self:GetStackCount() > 0
	self:SetStackCount(self:GetStackCount() + 1)
	if not L then
		self:RandomizeSecretKey()
	end
end
function y.prototype.OnAbilityLearn(self, z)
	local v = self:GetParent():GetPlayerOwnerID()
	if self:GetStackCount() > 0 and z.abilityname == self.secret_key then
		self:SetStackCount(self:GetStackCount() - 1)
		PlayerData:getHero(v):removeSectModifiers(self:GetAbility():GetName())
		self.secret_key = nil
		local A = PlayerData:getplayerData(v)
		do
			local M = 0
			while M < self.ability_count do
				local N = AbilityShop:getRandomAbility(v, 1, { isAbilityShop = false })
				h(N, function(F, O)
					local x = O.aid
					z.heroclass:learnAbility(x, true)
					Notification:combatToPlayer(
						v,
						{
							message = "notify_artifact_ability_" .. O.rarity,
							string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_146",
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. x,
						}
					)
					A:addArtifactAbilities(self:GetAbility():entindex(), x, false)
				end)
				M = M + 1
			end
		end
		A:upDateArtifactAbilities()
		if self:GetStackCount() > 0 then
			self:RandomizeSecretKey()
		end
	end
end
function y.prototype.GetSecretKey(self)
	return self.secret_key
end
y = e(
	{
		r(
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
	y
)
l.modifier_item_artifact_146 = y
return l