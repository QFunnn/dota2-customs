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
		["50"] = 42,
		["51"] = 43,
		["52"] = 42,
		["53"] = 45,
		["54"] = 46,
		["55"] = 47,
		["56"] = 47,
		["57"] = 47,
		["58"] = 46,
		["59"] = 46,
		["60"] = 46,
		["61"] = 45,
		["62"] = 51,
		["63"] = 52,
		["64"] = 53,
		["65"] = 55,
		["66"] = 56,
		["69"] = 51,
		["70"] = 60,
		["71"] = 61,
		["72"] = 62,
		["73"] = 63,
		["74"] = 64,
		["75"] = 66,
		["76"] = 67,
		["77"] = 68,
		["80"] = 71,
		["81"] = 72,
		["84"] = 66,
		["85"] = 76,
		["86"] = 78,
		["87"] = 79,
		["89"] = 81,
		["90"] = 82,
		["91"] = 83,
		["92"] = 85,
		["93"] = 86,
		["94"] = 86,
		["95"] = 86,
		["96"] = 86,
		["98"] = 60,
		["99"] = 89,
		["100"] = 91,
		["103"] = 92,
		["104"] = 94,
		["105"] = 95,
		["108"] = 97,
		["109"] = 98,
		["110"] = 100,
		["111"] = 101,
		["113"] = 89,
		["114"] = 104,
		["115"] = 105,
		["116"] = 106,
		["117"] = 108,
		["119"] = 110,
		["120"] = 110,
		["121"] = 111,
		["122"] = 114,
		["123"] = 114,
		["124"] = 114,
		["125"] = 115,
		["126"] = 116,
		["127"] = 117,
		["128"] = 122,
		["129"] = 122,
		["130"] = 122,
		["131"] = 122,
		["132"] = 122,
		["133"] = 114,
		["134"] = 114,
		["135"] = 110,
		["138"] = 125,
		["139"] = 127,
		["141"] = 130,
		["142"] = 131,
		["145"] = 104,
		["146"] = 135,
		["147"] = 136,
		["148"] = 135,
		["149"] = 39,
		["150"] = 30,
		["151"] = 30,
		["152"] = 30,
		["153"] = 30,
		["154"] = 30,
		["155"] = 30,
		["156"] = 30,
		["157"] = 30,
		["158"] = 30,
		["159"] = 39,
		["161"] = 39,
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
function w.prototype.GetAbilitySpecialValue(self)
	self.ability_count = self:GetAbilitySpecialValueFor("ability_count")
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
	local z = PlayerData:getHero(t).hero
	if x.winPlayerID ~= t or not IsValid(z) or not z:IsAlive() then
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
	if self:GetStackCount() > 0 and x.abilityname == self.secret_key then
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
		if self:GetStackCount() > 0 then
			self:RandomizeSecretKey()
		else
			PlayerData:getHero(t):removeSectModifiers(self:GetAbility():GetName())
			self.secret_key = nil
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