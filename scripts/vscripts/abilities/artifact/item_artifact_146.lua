--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_146"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__Delete
local g = b.__TS__StringSplit
local h = b.__TS__ArrayForEach
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 3,
		["15"] = 3,
		["16"] = 3,
		["17"] = 5,
		["18"] = 6,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 7,
		["24"] = 10,
		["25"] = 11,
		["26"] = 12,
		["27"] = 13,
		["28"] = 14,
		["29"] = 15,
		["30"] = 16,
		["31"] = 17,
		["32"] = 18,
		["33"] = 19,
		["35"] = 21,
		["38"] = 22,
		["40"] = 10,
		["41"] = 6,
		["42"] = 5,
		["43"] = 6,
		["45"] = 6,
		["46"] = 30,
		["47"] = 39,
		["48"] = 30,
		["49"] = 39,
		["51"] = 39,
		["52"] = 43,
		["53"] = 30,
		["54"] = 44,
		["55"] = 45,
		["56"] = 46,
		["57"] = 44,
		["58"] = 48,
		["59"] = 49,
		["60"] = 50,
		["61"] = 50,
		["62"] = 50,
		["63"] = 49,
		["64"] = 49,
		["65"] = 49,
		["66"] = 48,
		["67"] = 54,
		["68"] = 55,
		["69"] = 56,
		["70"] = 58,
		["71"] = 59,
		["74"] = 54,
		["75"] = 63,
		["76"] = 64,
		["77"] = 65,
		["78"] = 66,
		["79"] = 67,
		["80"] = 69,
		["81"] = 70,
		["82"] = 71,
		["85"] = 74,
		["86"] = 75,
		["89"] = 69,
		["90"] = 79,
		["91"] = 81,
		["92"] = 82,
		["94"] = 84,
		["95"] = 85,
		["96"] = 86,
		["97"] = 88,
		["98"] = 89,
		["99"] = 89,
		["100"] = 89,
		["101"] = 89,
		["103"] = 63,
		["104"] = 92,
		["105"] = 94,
		["108"] = 95,
		["109"] = 97,
		["112"] = 99,
		["113"] = 100,
		["114"] = 102,
		["115"] = 103,
		["117"] = 92,
		["118"] = 106,
		["119"] = 107,
		["120"] = 108,
		["121"] = 110,
		["123"] = 112,
		["124"] = 112,
		["125"] = 113,
		["126"] = 116,
		["127"] = 116,
		["128"] = 116,
		["129"] = 117,
		["130"] = 118,
		["131"] = 119,
		["132"] = 124,
		["133"] = 124,
		["134"] = 124,
		["135"] = 124,
		["136"] = 124,
		["137"] = 116,
		["138"] = 116,
		["139"] = 112,
		["142"] = 127,
		["143"] = 129,
		["144"] = 130,
		["145"] = 131,
		["146"] = 133,
		["149"] = 106,
		["150"] = 137,
		["151"] = 138,
		["152"] = 137,
		["153"] = 39,
		["154"] = 30,
		["155"] = 30,
		["156"] = 30,
		["157"] = 30,
		["158"] = 30,
		["159"] = 30,
		["160"] = 30,
		["161"] = 30,
		["162"] = 30,
		["163"] = 39,
		["165"] = 39,
	}
)
local j = {}
local k = require("lib.dota_ts_adapter")
local l = k.BaseItem
local m = k.registerAbility
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
j.item_artifact_146 = c()
local q = j.item_artifact_146
q.name = "item_artifact_146"
d(q, l)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_146"
end
function q.prototype.OnSpellStart(self)
	local r = self:GetCaster()
	local s = r:FindModifierByName(self:GetIntrinsicModifierName())
	if s and s:GetStackCount() > 0 then
		local t = r:GetPlayerOwnerID()
		local u = s
		local v = u:GetSecretKey()
		if not v then
			u:RandomizeSecretKey()
			v = u:GetSecretKey()
		end
		if not v then
			return
		end
		Notification:combatToPlayer(
			t,
			{ message = "notify_artifact_9_ability", string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. v }
		)
	end
end
q = e({ m(nil) }, q)
j.item_artifact_146 = q
j.modifier_item_artifact_146 = c()
local w = j.modifier_item_artifact_146
w.name = "modifier_item_artifact_146"
d(w, o)
function w.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.completion_count = 0
end
function w.prototype.GetAbilitySpecialValue(self)
	self.ability_count = self:GetAbilitySpecialValueFor("ability_count")
	self.limit = self:GetAbilitySpecialValueFor("limit")
end
function w.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 },
	}
end
function w.prototype.OnCreated(self, x)
	if IsServer() then
		self:RandomizeSecretKey()
		if self.secret_key then
			self:SetStackCount(1)
		end
	end
end
function w.prototype.RandomizeSecretKey(self)
	local t = self:GetParent():GetPlayerOwnerID()
	local y = PlayerData:getplayerData(t)
	local z = y.hero
	local A = AbilityShop:getAbilityPoolNew("n")
	A:each(function(B, C)
		if
			y.bannedSect
			and KeyValues.AbilityUpgradesKvs[C]
			and (string.find(KeyValues.AbilityUpgradesKvs[C].sect, y.bannedSect, nil, true) or 0) - 1 ~= -1
		then
			f(A.tList, C)
			return
		end
		if z:getAbilityUpgradeLevel(C) >= SECT_ABILITY_LEVEL.n then
			f(A.tList, C)
			return
		end
	end)
	A:update()
	if self.secret_key then
		PlayerData:getHero(t):removeSectModifiers(self:GetAbility():GetName())
	end
	self.secret_key = A:random()
	if self.secret_key then
		local D = g(KeyValues.AbilityUpgradesKvs[self.secret_key].sect, "|")
		local E = D[RandomInt(0, #D - 1) + 1]
		PlayerData:getHero(self:GetParent():GetPlayerOwnerID()):addSectModifier(E, self:GetAbility():GetName())
	end
end
function w.prototype.OnBattleEnd(self, x)
	if not x.isNeutral then
		return
	end
	local t = self:GetParent():GetPlayerOwnerID()
	if x.winPlayerID ~= t then
		return
	end
	local F = self:GetStackCount() > 0
	self:SetStackCount(self:GetStackCount() + 1)
	if not F then
		self:RandomizeSecretKey()
	end
end
function w.prototype.OnAbilityLearn(self, x)
	local t = self:GetParent():GetPlayerOwnerID()
	if self:GetStackCount() > 0 and self.completion_count < self.limit and x.abilityname == self.secret_key then
		self:SetStackCount(self:GetStackCount() - 1)
		do
			local G = 0
			while G < self.ability_count do
				local H = AbilityShop:getRandomAbility(t, 1, { isAbilityShop = false })
				h(H, function(B, I, G)
					local v = I.aid
					x.heroclass:learnAbility(v, true)
					Notification:combatToPlayer(
						t,
						{
							message = "notify_artifact_ability_" .. I.rarity,
							string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_146",
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. v,
						}
					)
					PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
						:addArtifactAbilities(self:GetAbility():entindex(), v, G == self.ability_count - 1)
				end)
				G = G + 1
			end
		end
		self.completion_count = self.completion_count + 1
		if self.completion_count >= self.limit then
			PlayerData:getHero(t):removeSectModifiers(self:GetAbility():GetName())
		elseif self:GetStackCount() > 0 then
			self:RandomizeSecretKey()
		end
	end
end
function w.prototype.GetSecretKey(self)
	return self.secret_key
end
w = e(
	{
		p(
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
	w
)
j.modifier_item_artifact_146 = w
return j