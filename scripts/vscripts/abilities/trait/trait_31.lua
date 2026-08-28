--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_31"
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
		["34"] = 29,
		["35"] = 30,
		["36"] = 31,
		["37"] = 26,
		["38"] = 33,
		["39"] = 34,
		["40"] = 35,
		["41"] = 36,
		["42"] = 37,
		["43"] = 38,
		["44"] = 42,
		["45"] = 43,
		["46"] = 44,
		["48"] = 48,
		["50"] = 52,
		["51"] = 53,
		["52"] = 53,
		["53"] = 53,
		["54"] = 53,
		["55"] = 53,
		["56"] = 53,
		["57"] = 53,
		["58"] = 54,
		["59"] = 55,
		["60"] = 55,
		["61"] = 55,
		["62"] = 55,
		["63"] = 55,
		["64"] = 55,
		["65"] = 55,
		["66"] = 55,
		["67"] = 60,
		["68"] = 60,
		["69"] = 60,
		["70"] = 60,
		["71"] = 60,
		["72"] = 53,
		["73"] = 53,
		["75"] = 33,
		["76"] = 64,
		["77"] = 65,
		["78"] = 66,
		["79"] = 67,
		["80"] = 68,
		["83"] = 64,
		["84"] = 72,
		["85"] = 73,
		["86"] = 74,
		["87"] = 75,
		["88"] = 79,
		["89"] = 80,
		["90"] = 81,
		["91"] = 82,
		["93"] = 86,
		["95"] = 90,
		["96"] = 91,
		["97"] = 91,
		["98"] = 91,
		["99"] = 91,
		["100"] = 91,
		["101"] = 91,
		["102"] = 91,
		["103"] = 92,
		["104"] = 93,
		["105"] = 93,
		["106"] = 93,
		["107"] = 93,
		["108"] = 93,
		["109"] = 93,
		["110"] = 93,
		["111"] = 93,
		["112"] = 98,
		["113"] = 98,
		["114"] = 98,
		["115"] = 98,
		["116"] = 98,
		["117"] = 91,
		["118"] = 91,
		["119"] = 72,
		["120"] = 101,
		["121"] = 102,
		["122"] = 101,
		["123"] = 106,
		["124"] = 107,
		["125"] = 106,
		["126"] = 19,
		["127"] = 12,
		["128"] = 12,
		["129"] = 12,
		["130"] = 12,
		["131"] = 12,
		["132"] = 12,
		["133"] = 12,
		["134"] = 19,
		["136"] = 19,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.trait_31 = c()
local o = h.trait_31
o.name = "trait_31"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_31"
end
o = e({ k(nil) }, o)
h.trait_31 = o
h.modifier_trait_31 = c()
local p = h.modifier_trait_31
p.name = "modifier_trait_31"
d(p, m)
function p.prototype.GetAbilitySpecialValue(self)
	self.rarity = self:GetAbilitySpecialValueFor("rarity")
	self.min_count = self:GetAbilitySpecialValueFor("min_count")
	self.max_count = self:GetAbilitySpecialValueFor("max_count")
	self.round = self:GetAbilitySpecialValueFor("round")
	self.base_count = self:GetAbilitySpecialValueFor("base_count")
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		self:SetStackCount(0)
		local r = self:GetParent():GetPlayerOwnerID()
		local s = { "n", "r", "sr" }
		local t = {}
		if self.rarity > 0 then
			local u = s
			t = AbilityShop:getRandomAbility(r, self.base_count, { specifyRarity = s[self.rarity] })
		else
			t = AbilityShop:getRandomAbility(r, self.base_count, { specifyRarity = "n" })
		end
		local v = PlayerData:getHero(r)
		f(t, function(u, w, x)
			local y
			local z
			z = w.aid
			y = w.rarity
			v:learnAbility(z, true)
			Notification:combatToPlayer(
				r,
				{
					message = "notify_artifact_ability_" .. y,
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. z,
				}
			)
			PlayerData:getplayerData(r):addArtifactAbilities(self:GetAbility():entindex(), z, x == #t - 1)
		end)
	end
end
function p.prototype.OnStackCountChanged(self, A)
	if IsServer() then
		if self:GetStackCount() == self.round then
			self:Effect()
			self:SetStackCount(0)
		end
	end
end
function p.prototype.Effect(self)
	local r = self:GetParent():GetPlayerOwnerID()
	local s = { "n", "r", "sr" }
	local t = {}
	local B = RandomInt(self.min_count, self.max_count)
	if self.rarity > 0 then
		local u = s
		t = AbilityShop:getRandomAbility(r, B, { specifyRarity = s[self.rarity] })
	else
		t = AbilityShop:getRandomAbility(r, B, { specifyRarity = "n" })
	end
	local v = PlayerData:getHero(r)
	f(t, function(u, w, x)
		local y
		local z
		z = w.aid
		y = w.rarity
		v:learnAbility(z, true)
		Notification:combatToPlayer(
			r,
			{
				message = "notify_artifact_ability_" .. y,
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. z,
			}
		)
		PlayerData:getplayerData(r):addArtifactAbilities(self:GetAbility():entindex(), z, x == #t - 1)
	end)
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 } }
end
function p.prototype.OnRoundChange(self, q)
	self:IncrementStackCount()
end
p = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
h.modifier_trait_31 = p
return h