--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
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
		["32"] = 10,
		["33"] = 6,
		["34"] = 5,
		["35"] = 6,
		["37"] = 6,
		["38"] = 24,
		["39"] = 33,
		["40"] = 24,
		["41"] = 33,
		["43"] = 33,
		["44"] = 37,
		["45"] = 24,
		["46"] = 38,
		["47"] = 39,
		["48"] = 40,
		["49"] = 38,
		["50"] = 42,
		["51"] = 43,
		["52"] = 44,
		["53"] = 44,
		["54"] = 44,
		["55"] = 43,
		["56"] = 43,
		["57"] = 43,
		["58"] = 42,
		["59"] = 48,
		["60"] = 49,
		["61"] = 50,
		["62"] = 52,
		["63"] = 53,
		["66"] = 48,
		["67"] = 57,
		["68"] = 58,
		["69"] = 59,
		["70"] = 60,
		["71"] = 61,
		["72"] = 63,
		["73"] = 64,
		["74"] = 65,
		["77"] = 68,
		["78"] = 69,
		["81"] = 63,
		["82"] = 73,
		["83"] = 75,
		["84"] = 76,
		["86"] = 78,
		["87"] = 79,
		["88"] = 80,
		["89"] = 82,
		["90"] = 83,
		["91"] = 83,
		["92"] = 83,
		["93"] = 83,
		["95"] = 57,
		["96"] = 86,
		["97"] = 88,
		["100"] = 89,
		["101"] = 91,
		["104"] = 93,
		["105"] = 86,
		["106"] = 95,
		["107"] = 96,
		["108"] = 97,
		["109"] = 99,
		["110"] = 101,
		["111"] = 104,
		["112"] = 104,
		["113"] = 104,
		["114"] = 105,
		["115"] = 106,
		["116"] = 107,
		["117"] = 112,
		["118"] = 112,
		["119"] = 112,
		["120"] = 112,
		["121"] = 112,
		["122"] = 104,
		["123"] = 104,
		["124"] = 114,
		["125"] = 116,
		["126"] = 117,
		["128"] = 119,
		["131"] = 95,
		["132"] = 123,
		["133"] = 124,
		["134"] = 123,
		["135"] = 33,
		["136"] = 24,
		["137"] = 24,
		["138"] = 24,
		["139"] = 24,
		["140"] = 24,
		["141"] = 24,
		["142"] = 24,
		["143"] = 24,
		["144"] = 24,
		["145"] = 33,
		["147"] = 33,
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
		local u = s:GetSecretKey()
		Notification:combatToPlayer(
			t,
			{ message = "notify_artifact_9_ability", string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. u }
		)
	end
end
q = e({ m(nil) }, q)
j.item_artifact_146 = q
j.modifier_item_artifact_146 = c()
local v = j.modifier_item_artifact_146
v.name = "modifier_item_artifact_146"
d(v, o)
function v.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.completion_count = 0
end
function v.prototype.GetAbilitySpecialValue(self)
	self.ability_count = self:GetAbilitySpecialValueFor("ability_count")
	self.limit = self:GetAbilitySpecialValueFor("limit")
end
function v.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 },
	}
end
function v.prototype.OnCreated(self, w)
	if IsServer() then
		self:RandomizeSecretKey()
		if self.secret_key then
			self:SetStackCount(1)
		end
	end
end
function v.prototype.RandomizeSecretKey(self)
	local t = self:GetParent():GetPlayerOwnerID()
	local x = PlayerData:getplayerData(t)
	local y = x.hero
	local z = AbilityShop:getAbilityPoolNew("n")
	z:each(function(A, B)
		if
			x.bannedSect
			and KeyValues.AbilityUpgradesKvs[B]
			and (string.find(KeyValues.AbilityUpgradesKvs[B].sect, x.bannedSect, nil, true) or 0) - 1 ~= -1
		then
			f(z.tList, B)
			return
		end
		if y:getAbilityUpgradeLevel(B) >= SECT_ABILITY_LEVEL.n then
			f(z.tList, B)
			return
		end
	end)
	z:update()
	if self.secret_key then
		PlayerData:getHero(t):removeSectModifiers(self:GetAbility():GetName())
	end
	self.secret_key = z:random()
	if self.secret_key then
		local C = g(KeyValues.AbilityUpgradesKvs[self.secret_key].sect, "|")
		local D = C[RandomInt(0, #C - 1) + 1]
		PlayerData:getHero(self:GetParent():GetPlayerOwnerID()):addSectModifier(D, self:GetAbility():GetName())
	end
end
function v.prototype.OnBattleEnd(self, w)
	if not w.isNeutral then
		return
	end
	local t = self:GetParent():GetPlayerOwnerID()
	if w.winPlayerID ~= t then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end
function v.prototype.OnAbilityLearn(self, w)
	local t = self:GetParent():GetPlayerOwnerID()
	if self:GetStackCount() > 0 and self.completion_count < self.limit and w.abilityname == self.secret_key then
		self:SetStackCount(self:GetStackCount() - 1)
		local E = AbilityShop:getRandomAbility(t, self.ability_count, { isAbilityShop = false })
		h(E, function(A, F, G)
			local u = F.aid
			w.heroclass:learnAbility(u, true)
			Notification:combatToPlayer(
				t,
				{
					message = "notify_artifact_ability_" .. F.rarity,
					string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_146",
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. u,
				}
			)
			PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
				:addArtifactAbilities(self:GetAbility():entindex(), u, G == #E - 1)
		end)
		self.completion_count = self.completion_count + 1
		if self.completion_count >= self.limit then
			PlayerData:getHero(t):removeSectModifiers(self:GetAbility():GetName())
		else
			self:RandomizeSecretKey()
		end
	end
end
function v.prototype.GetSecretKey(self)
	return self.secret_key
end
v = e(
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
	v
)
j.modifier_item_artifact_146 = v
return j