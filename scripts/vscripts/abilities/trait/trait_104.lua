--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_104"
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
		["31"] = 26,
		["32"] = 27,
		["33"] = 28,
		["34"] = 26,
		["35"] = 30,
		["36"] = 31,
		["37"] = 32,
		["38"] = 33,
		["39"] = 34,
		["41"] = 38,
		["42"] = 38,
		["43"] = 39,
		["44"] = 39,
		["45"] = 38,
		["48"] = 41,
		["49"] = 41,
		["50"] = 41,
		["51"] = 41,
		["52"] = 41,
		["53"] = 42,
		["54"] = 43,
		["55"] = 44,
		["56"] = 45,
		["58"] = 46,
		["59"] = 46,
		["60"] = 47,
		["61"] = 47,
		["62"] = 47,
		["63"] = 47,
		["64"] = 47,
		["65"] = 47,
		["66"] = 47,
		["67"] = 47,
		["68"] = 52,
		["69"] = 53,
		["70"] = 53,
		["71"] = 53,
		["72"] = 53,
		["73"] = 53,
		["74"] = 46,
		["78"] = 56,
		["79"] = 56,
		["80"] = 56,
		["81"] = 56,
		["82"] = 56,
		["83"] = 57,
		["84"] = 41,
		["85"] = 41,
		["87"] = 30,
		["88"] = 61,
		["89"] = 62,
		["90"] = 63,
		["91"] = 64,
		["92"] = 64,
		["93"] = 64,
		["94"] = 64,
		["97"] = 61,
		["98"] = 68,
		["99"] = 69,
		["100"] = 68,
		["101"] = 73,
		["102"] = 74,
		["103"] = 75,
		["104"] = 76,
		["105"] = 77,
		["106"] = 77,
		["107"] = 77,
		["108"] = 77,
		["109"] = 77,
		["110"] = 78,
		["111"] = 79,
		["112"] = 80,
		["113"] = 81,
		["114"] = 81,
		["115"] = 81,
		["116"] = 82,
		["117"] = 82,
		["118"] = 82,
		["119"] = 82,
		["120"] = 82,
		["121"] = 82,
		["122"] = 82,
		["123"] = 82,
		["124"] = 87,
		["125"] = 88,
		["126"] = 88,
		["127"] = 88,
		["128"] = 88,
		["129"] = 88,
		["130"] = 81,
		["131"] = 81,
		["135"] = 73,
		["136"] = 19,
		["137"] = 12,
		["138"] = 12,
		["139"] = 12,
		["140"] = 12,
		["141"] = 12,
		["142"] = 12,
		["143"] = 12,
		["144"] = 19,
		["146"] = 19,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.trait_104 = c()
local o = h.trait_104
o.name = "trait_104"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_104"
end
o = e({ k(nil) }, o)
h.trait_104 = o
h.modifier_trait_104 = c()
local p = h.modifier_trait_104
p.name = "modifier_trait_104"
d(p, m)
function p.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.first_add = self:GetAbilitySpecialValueFor("first_add")
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		local r = self:GetParent():GetPlayerOwnerID()
		self.selections = {}
		local s = AbilityShop:getRandomAbility(r, self.count, { specifyRarity = "r", specifyRarityIgnoreRule = true })
		do
			local t = 0
			while t < #s do
				local u = self.selections
				u[#u + 1] = s[t + 1].aid
				t = t + 1
			end
		end
		self.key = Selection:AddSpecialSelection(r, "ability_card", self.selections, function(v, w)
			ArrayRemove(self.selections, w)
			self.round = self:GetAbilitySpecialValueFor("round")
			local x = PlayerData:getHero(r)
			if x then
				do
					local t = 0
					while t < self.first_add do
						Notification:combatToPlayer(
							r,
							{
								message = "notify_artifact_ability_"
									.. tostring(KeyValues.AbilityUpgradesKvs[w].rarity),
								string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.ability:GetAbilityName(),
								string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. w,
							}
						)
						x:learnAbility(w, true)
						PlayerData:getplayerData(r):addArtifactAbilities(self:GetAbility():entindex(), w, true)
						t = t + 1
					end
				end
			end
			PlayerData:getplayerData(r):modifyArtifactExtraStringData(
				self:GetAbility():entindex(),
				"DOTA_Tooltip_ability_trait_102_effect",
				tostring(self.round)
			)
			return true
		end)
	end
end
function p.prototype.OnDestroy(self)
	if IsServer() then
		if self.key then
			Selection:RemoveSpecialSelection(self.parent:GetPlayerOwnerID(), self.key)
		end
	end
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 } }
end
function p.prototype.OnRoundChange(self, q)
	if self.round ~= nil and self.round ~= 0 then
		self.round = self.round - 1
		local r = self:GetCaster():GetPlayerOwnerID()
		PlayerData:getplayerData(r):modifyArtifactExtraStringData(
			self:GetAbility():entindex(),
			"DOTA_Tooltip_ability_trait_102_effect",
			tostring(self.round)
		)
		if self.round == 0 then
			local x = PlayerData:getHero(r)
			if x then
				f(self.selections, function(v, y)
					Notification:combatToPlayer(
						r,
						{
							message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[y].rarity),
							string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. y,
						}
					)
					x:learnAbility(y, true)
					PlayerData:getplayerData(r):addArtifactAbilities(self:GetAbility():entindex(), y, true)
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
h.modifier_trait_104 = p
return h