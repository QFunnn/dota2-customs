--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_9"
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
		["42"] = 36,
		["43"] = 37,
		["44"] = 36,
		["45"] = 39,
		["46"] = 40,
		["47"] = 41,
		["48"] = 41,
		["49"] = 40,
		["50"] = 39,
		["51"] = 44,
		["52"] = 45,
		["53"] = 46,
		["54"] = 47,
		["55"] = 48,
		["56"] = 49,
		["57"] = 51,
		["58"] = 52,
		["59"] = 53,
		["62"] = 56,
		["63"] = 57,
		["66"] = 51,
		["67"] = 61,
		["68"] = 63,
		["69"] = 64,
		["70"] = 65,
		["71"] = 67,
		["72"] = 68,
		["73"] = 68,
		["74"] = 68,
		["75"] = 68,
		["76"] = 69,
		["77"] = 70,
		["78"] = 70,
		["79"] = 70,
		["80"] = 70,
		["83"] = 44,
		["84"] = 77,
		["85"] = 79,
		["86"] = 80,
		["87"] = 81,
		["88"] = 82,
		["89"] = 83,
		["90"] = 86,
		["91"] = 86,
		["92"] = 86,
		["93"] = 87,
		["94"] = 88,
		["95"] = 89,
		["96"] = 94,
		["97"] = 94,
		["98"] = 94,
		["99"] = 94,
		["100"] = 94,
		["101"] = 86,
		["102"] = 86,
		["104"] = 77,
		["105"] = 98,
		["106"] = 99,
		["107"] = 98,
		["108"] = 33,
		["109"] = 24,
		["110"] = 24,
		["111"] = 24,
		["112"] = 24,
		["113"] = 24,
		["114"] = 24,
		["115"] = 24,
		["116"] = 24,
		["117"] = 24,
		["118"] = 33,
		["120"] = 33,
	}
)
local j = {}
local k = require("lib.dota_ts_adapter")
local l = k.BaseItem
local m = k.registerAbility
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
j.item_artifact_9 = c()
local q = j.item_artifact_9
q.name = "item_artifact_9"
d(q, l)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_9"
end
function q.prototype.OnSpellStart(self)
	local r = self:GetCaster()
	local s = r:FindModifierByName(self:GetIntrinsicModifierName())
	if s then
		local t = r:GetPlayerOwnerID()
		local u = s:GetSecretKey()
		Notification:combatToPlayer(
			t,
			{ message = "notify_artifact_9_ability", string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. u }
		)
	end
end
q = e({ m(nil) }, q)
j.item_artifact_9 = q
j.modifier_item_artifact_9 = c()
local v = j.modifier_item_artifact_9
v.name = "modifier_item_artifact_9"
d(v, o)
function v.prototype.GetAbilitySpecialValue(self)
	self.ability_count = self:GetAbilitySpecialValueFor("ability_count")
end
function v.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { self:GetParent(), -1 } }
end
function v.prototype.OnCreated(self, w)
	if IsServer() then
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
		self.secret_key = z:random()
		if self.secret_key then
			local C = g(KeyValues.AbilityUpgradesKvs[self.secret_key].sect, "|")
			local D = C[RandomInt(0, #C - 1) + 1]
			PlayerData:getHero(self:GetParent():GetPlayerOwnerID()):addSectModifier(D, self:GetAbility():GetName())
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
function v.prototype.OnAbilityLearn(self, w)
	local t = self:GetParent():GetPlayerOwnerID()
	if self:GetStackCount() > 0 and w.abilityname == self.secret_key then
		self:SetStackCount(0)
		PlayerData:getHero(t):removeSectModifiers(self:GetAbility():GetName())
		local E = AbilityShop:getRandomAbility(t, self.ability_count, { isAbilityShop = false })
		h(E, function(A, F, G)
			local u = F.aid
			w.heroclass:learnAbility(u, true)
			Notification:combatToPlayer(
				t,
				{
					message = "notify_artifact_ability_" .. F.rarity,
					string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_9",
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. u,
				}
			)
			PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
				:addArtifactAbilities(self:GetAbility():entindex(), u, G == #E - 1)
		end)
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
j.modifier_item_artifact_9 = v
return j