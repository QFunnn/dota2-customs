--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_126"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 5,
		["16"] = 6,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 8,
		["21"] = 7,
		["22"] = 6,
		["23"] = 5,
		["24"] = 6,
		["26"] = 6,
		["27"] = 12,
		["28"] = 19,
		["29"] = 12,
		["30"] = 19,
		["31"] = 24,
		["32"] = 25,
		["33"] = 24,
		["34"] = 27,
		["35"] = 28,
		["36"] = 29,
		["37"] = 30,
		["38"] = 31,
		["39"] = 32,
		["41"] = 27,
		["42"] = 35,
		["43"] = 36,
		["44"] = 35,
		["45"] = 40,
		["46"] = 41,
		["47"] = 42,
		["49"] = 40,
		["50"] = 45,
		["51"] = 46,
		["52"] = 47,
		["53"] = 48,
		["54"] = 49,
		["55"] = 50,
		["56"] = 51,
		["57"] = 52,
		["58"] = 53,
		["59"] = 58,
		["60"] = 58,
		["61"] = 58,
		["62"] = 58,
		["63"] = 58,
		["64"] = 58,
		["65"] = 58,
		["66"] = 59,
		["67"] = 59,
		["68"] = 59,
		["69"] = 59,
		["70"] = 59,
		["71"] = 59,
		["72"] = 59,
		["73"] = 59,
		["74"] = 64,
		["75"] = 65,
		["76"] = 65,
		["77"] = 65,
		["78"] = 65,
		["79"] = 65,
		["80"] = 58,
		["81"] = 58,
		["83"] = 68,
		["84"] = 69,
		["85"] = 70,
		["86"] = 75,
		["87"] = 75,
		["88"] = 75,
		["89"] = 75,
		["90"] = 75,
		["91"] = 75,
		["92"] = 75,
		["93"] = 76,
		["94"] = 76,
		["95"] = 76,
		["96"] = 76,
		["97"] = 76,
		["98"] = 76,
		["99"] = 76,
		["100"] = 76,
		["101"] = 81,
		["102"] = 82,
		["103"] = 82,
		["104"] = 82,
		["105"] = 82,
		["106"] = 82,
		["107"] = 75,
		["108"] = 75,
		["110"] = 85,
		["111"] = 86,
		["112"] = 87,
		["113"] = 92,
		["114"] = 92,
		["115"] = 92,
		["116"] = 92,
		["117"] = 92,
		["118"] = 92,
		["119"] = 92,
		["120"] = 93,
		["121"] = 93,
		["122"] = 93,
		["123"] = 93,
		["124"] = 93,
		["125"] = 93,
		["126"] = 93,
		["127"] = 93,
		["128"] = 98,
		["129"] = 99,
		["130"] = 99,
		["131"] = 99,
		["132"] = 99,
		["133"] = 99,
		["134"] = 92,
		["135"] = 92,
		["139"] = 45,
		["140"] = 19,
		["141"] = 12,
		["142"] = 12,
		["143"] = 12,
		["144"] = 12,
		["145"] = 12,
		["146"] = 12,
		["147"] = 12,
		["148"] = 19,
		["150"] = 19,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.trait_126 = c()
local o = h.trait_126
o.name = "trait_126"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_126"
end
o = e({ k(nil) }, o)
h.trait_126 = o
h.modifier_trait_126 = c()
local p = h.modifier_trait_126
p.name = "modifier_trait_126"
d(p, m)
function p.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		self.lv1 = self:GetAbilitySpecialValueFor("lv1")
		self.lv2 = self:GetAbilitySpecialValueFor("lv2")
		self.lv3 = self:GetAbilitySpecialValueFor("lv3")
		self:CheckEffect()
	end
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = { -1, -1 } }
end
function p.prototype.OnHeroLevelUp(self, q)
	if q.player_id == self:GetParent():GetPlayerOwnerID() then
		self:CheckEffect()
	end
end
function p.prototype.CheckEffect(self)
	if IsServer() then
		local r = self:GetParent():GetPlayerOwnerID()
		local s = PlayerData:getHero(r)
		if s then
			local t = s:getLevel()
			if self.lv1 > 0 and t >= self.lv1 then
				self.lv1 = 0
				local u = AbilityShop:getRandomAbility(
					r,
					self.count,
					{ isAbilityShop = false, specifyRarity = "n", specifyRarityIgnoreRule = true }
				)
				f(u, function(v, w, x)
					local y
					local z
					z = w.aid
					y = w.rarity
					Notification:combatToPlayer(
						r,
						{
							message = "notify_artifact_ability_" .. y,
							string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. z,
						}
					)
					s:learnAbility(z, true)
					PlayerData:getplayerData(r):addArtifactAbilities(self:GetAbility():entindex(), z, x == #u - 1)
				end)
			end
			if self.lv2 > 0 and t >= self.lv2 then
				self.lv2 = 0
				local u = AbilityShop:getRandomAbility(
					r,
					self.count,
					{ isAbilityShop = false, specifyRarity = "r", specifyRarityIgnoreRule = true }
				)
				f(u, function(v, w, x)
					local y
					local z
					z = w.aid
					y = w.rarity
					Notification:combatToPlayer(
						r,
						{
							message = "notify_artifact_ability_" .. y,
							string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. z,
						}
					)
					s:learnAbility(z, true)
					PlayerData:getplayerData(r):addArtifactAbilities(self:GetAbility():entindex(), z, x == #u - 1)
				end)
			end
			if self.lv3 > 0 and t >= self.lv3 then
				self.lv3 = 0
				local u = AbilityShop:getRandomAbility(
					r,
					self.count,
					{ isAbilityShop = false, specifyRarity = "sr", specifyRarityIgnoreRule = true }
				)
				f(u, function(v, w, x)
					local y
					local z
					z = w.aid
					y = w.rarity
					Notification:combatToPlayer(
						r,
						{
							message = "notify_artifact_ability_" .. y,
							string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. z,
						}
					)
					s:learnAbility(z, true)
					PlayerData:getplayerData(r):addArtifactAbilities(self:GetAbility():entindex(), z, x == #u - 1)
				end)
			end
		end
	end
end
p = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
h.modifier_trait_126 = p
return h