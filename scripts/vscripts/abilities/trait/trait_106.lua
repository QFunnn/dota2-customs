--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_106"
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
		["35"] = 26,
		["36"] = 32,
		["37"] = 33,
		["38"] = 34,
		["39"] = 35,
		["40"] = 36,
		["41"] = 41,
		["42"] = 42,
		["43"] = 43,
		["44"] = 43,
		["45"] = 43,
		["46"] = 43,
		["47"] = 43,
		["48"] = 44,
		["49"] = 44,
		["50"] = 44,
		["51"] = 44,
		["52"] = 44,
		["53"] = 44,
		["54"] = 44,
		["55"] = 44,
		["56"] = 49,
		["57"] = 50,
		["58"] = 50,
		["59"] = 50,
		["60"] = 50,
		["61"] = 50,
		["62"] = 43,
		["63"] = 43,
		["66"] = 32,
		["67"] = 55,
		["68"] = 56,
		["69"] = 57,
		["70"] = 57,
		["71"] = 56,
		["72"] = 55,
		["73"] = 60,
		["74"] = 61,
		["77"] = 62,
		["78"] = 63,
		["79"] = 64,
		["80"] = 65,
		["81"] = 66,
		["82"] = 67,
		["83"] = 72,
		["84"] = 73,
		["85"] = 74,
		["86"] = 74,
		["87"] = 74,
		["88"] = 74,
		["89"] = 74,
		["90"] = 75,
		["91"] = 75,
		["92"] = 75,
		["93"] = 75,
		["94"] = 75,
		["95"] = 75,
		["96"] = 75,
		["97"] = 75,
		["98"] = 80,
		["99"] = 81,
		["100"] = 74,
		["101"] = 74,
		["103"] = 91,
		["104"] = 91,
		["105"] = 91,
		["106"] = 91,
		["107"] = 91,
		["109"] = 93,
		["110"] = 93,
		["111"] = 93,
		["112"] = 93,
		["113"] = 93,
		["115"] = 60,
		["116"] = 19,
		["117"] = 12,
		["118"] = 12,
		["119"] = 12,
		["120"] = 12,
		["121"] = 12,
		["122"] = 12,
		["123"] = 12,
		["124"] = 19,
		["126"] = 19,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.trait_106 = c()
local o = h.trait_106
o.name = "trait_106"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_106"
end
o = e({ k(nil) }, o)
h.trait_106 = o
h.modifier_trait_106 = c()
local p = h.modifier_trait_106
p.name = "modifier_trait_106"
d(p, m)
function p.prototype.GetAbilitySpecialValue(self)
	self.r_count = self:GetAbilitySpecialValueFor("r_count")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.sr_count = self:GetAbilitySpecialValueFor("sr_count")
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		self.record = 0
		local r = self:GetCaster():GetPlayerOwnerID()
		local s = AbilityShop:getRandomAbility(
			r,
			self.r_count,
			{ specifyRarity = "r", specifyRarityIgnoreRule = true, isAbilityShop = false }
		)
		local t = PlayerData:getHero(r)
		if t then
			f(s, function(u, v, w)
				local x
				x = v.aid
				Notification:combatToPlayer(
					r,
					{
						message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[x].rarity),
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. x,
					}
				)
				t:learnAbility(x, true)
				PlayerData:getplayerData(r):addArtifactAbilities(self:GetAbility():entindex(), x, w == #s - 1)
			end)
		end
	end
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function p.prototype.OnPlayerTakeDamage(self, y)
	if self.flag then
		return
	end
	self.record = self.record + y.damage
	local r = self:GetCaster():GetPlayerOwnerID()
	if self.record >= self.damage then
		local z = self:GetAbility():entindex()
		self.flag = true
		local s = AbilityShop:getRandomAbility(
			r,
			self.sr_count,
			{ specifyRarity = "sr", specifyRarityIgnoreRule = true, isAbilityShop = false }
		)
		local t = PlayerData:getHero(r)
		if t then
			f(s, function(u, v, w)
				local x
				x = v.aid
				Notification:combatToPlayer(
					r,
					{
						message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[x].rarity),
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. x,
					}
				)
				t:learnAbility(x, true)
				PlayerData:getplayerData(r):addArtifactAbilities(z, x, w == #s - 1)
			end)
		end
		PlayerData:getplayerData(r):modifyArtifactExtraStringData(z, "trait_task_progress", tostring(self.damage))
	else
		PlayerData:getplayerData(r)
			:modifyArtifactExtraStringData(self:GetAbility():entindex(), "trait_task_progress", tostring(self.record))
	end
end
p = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
h.modifier_trait_106 = p
return h