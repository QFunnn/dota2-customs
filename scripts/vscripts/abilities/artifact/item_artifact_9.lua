--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_9"
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
		["34"] = 10,
		["35"] = 6,
		["36"] = 5,
		["37"] = 6,
		["39"] = 6,
		["40"] = 24,
		["41"] = 33,
		["42"] = 24,
		["43"] = 33,
		["44"] = 36,
		["45"] = 37,
		["46"] = 36,
		["47"] = 39,
		["48"] = 40,
		["49"] = 41,
		["50"] = 41,
		["51"] = 40,
		["52"] = 39,
		["53"] = 44,
		["54"] = 45,
		["55"] = 46,
		["56"] = 47,
		["57"] = 48,
		["58"] = 49,
		["59"] = 50,
		["60"] = 51,
		["62"] = 51,
		["63"] = 51,
		["64"] = 51,
		["65"] = 52,
		["66"] = 53,
		["67"] = 53,
		["69"] = 51,
		["70"] = 51,
		["72"] = 55,
		["73"] = 57,
		["74"] = 58,
		["75"] = 59,
		["78"] = 62,
		["79"] = 63,
		["82"] = 66,
		["83"] = 67,
		["86"] = 57,
		["87"] = 71,
		["88"] = 73,
		["89"] = 74,
		["90"] = 75,
		["91"] = 77,
		["92"] = 78,
		["93"] = 78,
		["94"] = 78,
		["95"] = 78,
		["96"] = 79,
		["97"] = 80,
		["98"] = 80,
		["99"] = 80,
		["100"] = 80,
		["103"] = 44,
		["104"] = 87,
		["105"] = 89,
		["106"] = 90,
		["107"] = 91,
		["108"] = 92,
		["109"] = 93,
		["110"] = 96,
		["111"] = 96,
		["112"] = 96,
		["113"] = 97,
		["114"] = 98,
		["115"] = 99,
		["116"] = 104,
		["117"] = 104,
		["118"] = 104,
		["119"] = 104,
		["120"] = 104,
		["121"] = 96,
		["122"] = 96,
		["124"] = 87,
		["125"] = 108,
		["126"] = 109,
		["127"] = 108,
		["128"] = 33,
		["129"] = 24,
		["130"] = 24,
		["131"] = 24,
		["132"] = 24,
		["133"] = 24,
		["134"] = 24,
		["135"] = 24,
		["136"] = 24,
		["137"] = 24,
		["138"] = 33,
		["140"] = 33,
	}
)
local l = {}
local m = require("lib.dota_ts_adapter")
local n = m.BaseItem
local o = m.registerAbility
local p = require("modifiers.eom_modifier")
local q = p.EOMModifier
local r = p.registerEOMModifier
l.item_artifact_9 = c()
local s = l.item_artifact_9
s.name = "item_artifact_9"
d(s, n)
function s.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_9"
end
function s.prototype.OnSpellStart(self)
	local t = self:GetCaster()
	local u = t:FindModifierByName(self:GetIntrinsicModifierName())
	if u then
		local v = t:GetPlayerOwnerID()
		local w = u:GetSecretKey()
		Notification:combatToPlayer(
			v,
			{ message = "notify_artifact_9_ability", string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. w }
		)
	end
end
s = e({ o(nil) }, s)
l.item_artifact_9 = s
l.modifier_item_artifact_9 = c()
local x = l.modifier_item_artifact_9
x.name = "modifier_item_artifact_9"
d(x, q)
function x.prototype.GetAbilitySpecialValue(self)
	self.ability_count = self:GetAbilitySpecialValueFor("ability_count")
end
function x.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { self:GetParent(), -1 } }
end
function x.prototype.OnCreated(self, y)
	if IsServer() then
		local v = self:GetParent():GetPlayerOwnerID()
		local z = PlayerData:getplayerData(v)
		local A = z.hero
		local B = self:GetParent():FindAllModifiersByName("modifier_item_artifact_146")
		local C = g(f)
		local D = B
		if D ~= nil then
			h(B, function(E, F)
				local G = F:GetSecretKey()
				if G then
					C:add(G)
				end
			end)
		end
		local H = AbilityShop:getAbilityPoolNew("n")
		H:each(function(E, I)
			if C:has(I) then
				i(H.tList, I)
				return
			end
			if
				z.bannedSect
				and KeyValues.AbilityUpgradesKvs[I]
				and (string.find(KeyValues.AbilityUpgradesKvs[I].sect, z.bannedSect, nil, true) or 0) - 1 ~= -1
			then
				i(H.tList, I)
				return
			end
			if A:getAbilityUpgradeLevel(I) >= SECT_ABILITY_LEVEL.n then
				i(H.tList, I)
				return
			end
		end)
		H:update()
		self.secret_key = H:random()
		if self.secret_key then
			local J = j(KeyValues.AbilityUpgradesKvs[self.secret_key].sect, "|")
			local K = J[RandomInt(0, #J - 1) + 1]
			PlayerData:getHero(self:GetParent():GetPlayerOwnerID()):addSectModifier(K, self:GetAbility():GetName())
			self:SetStackCount(1)
			Notification:combatToPlayer(
				self:GetParent():GetPlayerOwnerID(),
				{
					message = "notify_artifact_9_ability",
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. self.secret_key,
				}
			)
		end
	end
end
function x.prototype.OnAbilityLearn(self, y)
	local v = self:GetParent():GetPlayerOwnerID()
	if self:GetStackCount() > 0 and y.abilityname == self.secret_key then
		self:SetStackCount(0)
		PlayerData:getHero(v):removeSectModifiers(self:GetAbility():GetName())
		local L = AbilityShop:getRandomAbility(v, self.ability_count, { isAbilityShop = false })
		h(L, function(E, M, N)
			local w = M.aid
			y.heroclass:learnAbility(w, true)
			Notification:combatToPlayer(
				v,
				{
					message = "notify_artifact_ability_" .. M.rarity,
					string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_9",
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. w,
				}
			)
			PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
				:addArtifactAbilities(self:GetAbility():entindex(), w, N == #L - 1)
		end)
	end
end
function x.prototype.GetSecretKey(self)
	return self.secret_key
end
x = e(
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
	x
)
l.modifier_item_artifact_9 = x
return l