--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_44"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__Delete
local g = b.__TS__StringSplit
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 2,
		["11"] = 2,
		["12"] = 2,
		["13"] = 3,
		["14"] = 3,
		["15"] = 3,
		["16"] = 5,
		["17"] = 6,
		["18"] = 5,
		["19"] = 6,
		["20"] = 7,
		["21"] = 8,
		["22"] = 7,
		["23"] = 11,
		["24"] = 12,
		["25"] = 13,
		["28"] = 17,
		["29"] = 18,
		["32"] = 22,
		["33"] = 22,
		["34"] = 22,
		["35"] = 22,
		["36"] = 11,
		["37"] = 6,
		["38"] = 5,
		["39"] = 6,
		["41"] = 6,
		["42"] = 29,
		["43"] = 36,
		["44"] = 29,
		["45"] = 36,
		["46"] = 40,
		["47"] = 41,
		["48"] = 40,
		["49"] = 44,
		["50"] = 45,
		["51"] = 46,
		["52"] = 46,
		["53"] = 45,
		["54"] = 44,
		["55"] = 50,
		["56"] = 51,
		["59"] = 55,
		["60"] = 56,
		["61"] = 57,
		["62"] = 58,
		["63"] = 59,
		["64"] = 60,
		["65"] = 61,
		["68"] = 64,
		["69"] = 65,
		["71"] = 58,
		["72"] = 68,
		["73"] = 69,
		["74"] = 70,
		["77"] = 73,
		["78"] = 73,
		["79"] = 73,
		["80"] = 73,
		["81"] = 77,
		["82"] = 78,
		["83"] = 79,
		["84"] = 79,
		["85"] = 79,
		["86"] = 79,
		["87"] = 80,
		["88"] = 80,
		["89"] = 80,
		["90"] = 80,
		["91"] = 80,
		["92"] = 81,
		["93"] = 50,
		["94"] = 84,
		["95"] = 85,
		["98"] = 89,
		["99"] = 90,
		["100"] = 91,
		["102"] = 92,
		["103"] = 92,
		["104"] = 93,
		["106"] = 94,
		["107"] = 94,
		["108"] = 95,
		["109"] = 96,
		["110"] = 97,
		["111"] = 97,
		["112"] = 97,
		["113"] = 97,
		["114"] = 97,
		["115"] = 97,
		["116"] = 97,
		["117"] = 97,
		["118"] = 102,
		["119"] = 102,
		["120"] = 102,
		["121"] = 102,
		["122"] = 102,
		["123"] = 94,
		["126"] = 92,
		["129"] = 84,
		["130"] = 107,
		["131"] = 108,
		["132"] = 107,
		["133"] = 36,
		["134"] = 29,
		["135"] = 29,
		["136"] = 29,
		["137"] = 29,
		["138"] = 29,
		["139"] = 29,
		["140"] = 29,
		["141"] = 36,
		["143"] = 36,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseAbility
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
i.treasure_44 = c()
local p = i.treasure_44
p.name = "treasure_44"
d(p, k)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_44"
end
function p.prototype.OnSpellStart(self)
	local q = self:GetCaster():FindModifierByName(self:GetIntrinsicModifierName())
	if q == nil then
		return
	end
	local r = q:GetSecretAbilityID()
	if r == nil then
		return
	end
	Notification:combatToPlayer(
		self:GetCaster():GetPlayerOwnerID(),
		{ message = "notify_artifact_9_ability", string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. r }
	)
end
p = e({ l(nil) }, p)
i.treasure_44 = p
i.modifier_treasure_44 = c()
local s = i.modifier_treasure_44
s.name = "modifier_treasure_44"
d(s, n)
function s.prototype.GetAbilitySpecialValue(self)
	self.abilityCount = self:GetAbilitySpecialValueFor("ability_count")
end
function s.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { self:GetParent(), -1 } }
end
function s.prototype.OnCreated(self, t)
	if not IsServer() then
		return
	end
	local u = self:GetParent():GetPlayerOwnerID()
	local v = PlayerData:getplayerData(u)
	local w = AbilityShop:getAbilityPoolNew("n")
	w:each(function(x, r)
		local y = KeyValues.AbilityUpgradesKvs[r]
		if v.bannedSect and y and (string.find(y.sect, v.bannedSect, nil, true) or 0) - 1 ~= -1 then
			f(w.tList, r)
			return
		end
		if v.hero:getAbilityUpgradeLevel(r) >= SECT_ABILITY_LEVEL.n then
			f(w.tList, r)
		end
	end)
	w:update()
	self.secretAbilityID = w:random()
	if self.secretAbilityID == nil then
		return
	end
	Notification:combatToPlayer(
		self:GetParent():GetPlayerOwnerID(),
		{
			message = "notify_artifact_9_ability",
			string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. self.secretAbilityID,
		}
	)
	local z = g(KeyValues.AbilityUpgradesKvs[self.secretAbilityID].sect, "|")
	local A = z[RandomInt(0, #z - 1) + 1]
	v.hero:addSectModifier(A, self:GetAbility():GetAbilityName())
	v:modifyArtifactExtraStringData(
		self:GetAbility():entindex(),
		"DOTA_Tooltip_ability_treasure_44_order",
		"DOTA_Tooltip_ability_mechanics_" .. self.secretAbilityID
	)
	self:SetStackCount(1)
end
function s.prototype.OnAbilityLearn(self, t)
	if not IsServer() or self:GetStackCount() == 0 or t.abilityname ~= self.secretAbilityID then
		return
	end
	local u = self:GetParent():GetPlayerOwnerID()
	self:SetStackCount(0)
	PlayerData:getHero(u):removeSectModifiers(self:GetAbility():GetAbilityName())
	do
		local B = 0
		while B < self.abilityCount do
			local C = AbilityShop:getRandomAbility(u, 1, { isAbilityShop = false })
			do
				local B = 0
				while B < #C do
					local D = C[B + 1]
					t.heroclass:learnAbility(D.aid, true)
					Notification:combatToPlayer(
						u,
						{
							message = "notify_artifact_ability_" .. D.rarity,
							string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. D.aid,
						}
					)
					PlayerData:getplayerData(u)
						:addArtifactAbilities(self:GetAbility():entindex(), D.aid, B == self.abilityCount - 1)
					B = B + 1
				end
			end
			B = B + 1
		end
	end
end
function s.prototype.GetSecretAbilityID(self)
	return self.secretAbilityID
end
s = e(
	{ o(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	s
)
i.modifier_treasure_44 = s
return i