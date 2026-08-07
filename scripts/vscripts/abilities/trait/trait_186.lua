--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_186"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ObjectKeys
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
		["15"] = 4,
		["16"] = 5,
		["17"] = 4,
		["18"] = 5,
		["19"] = 6,
		["20"] = 6,
		["21"] = 6,
		["22"] = 5,
		["23"] = 4,
		["24"] = 5,
		["26"] = 5,
		["27"] = 9,
		["28"] = 16,
		["29"] = 9,
		["30"] = 16,
		["32"] = 16,
		["33"] = 20,
		["34"] = 21,
		["35"] = 9,
		["36"] = 22,
		["37"] = 23,
		["38"] = 24,
		["39"] = 25,
		["40"] = 22,
		["41"] = 27,
		["42"] = 27,
		["43"] = 27,
		["44"] = 27,
		["45"] = 27,
		["46"] = 27,
		["48"] = 27,
		["49"] = 28,
		["50"] = 29,
		["51"] = 29,
		["52"] = 29,
		["53"] = 29,
		["54"] = 28,
		["55"] = 31,
		["56"] = 31,
		["57"] = 31,
		["59"] = 31,
		["60"] = 32,
		["61"] = 33,
		["64"] = 34,
		["65"] = 35,
		["68"] = 36,
		["69"] = 37,
		["70"] = 38,
		["71"] = 38,
		["73"] = 39,
		["77"] = 32,
		["78"] = 42,
		["79"] = 43,
		["82"] = 44,
		["83"] = 45,
		["84"] = 46,
		["87"] = 47,
		["88"] = 48,
		["89"] = 49,
		["92"] = 50,
		["93"] = 51,
		["94"] = 52,
		["95"] = 52,
		["96"] = 52,
		["97"] = 52,
		["98"] = 52,
		["99"] = 52,
		["100"] = 52,
		["101"] = 52,
		["102"] = 55,
		["103"] = 55,
		["104"] = 55,
		["105"] = 55,
		["106"] = 55,
		["108"] = 57,
		["109"] = 42,
		["110"] = 16,
		["111"] = 9,
		["112"] = 9,
		["113"] = 9,
		["114"] = 9,
		["115"] = 9,
		["116"] = 9,
		["117"] = 9,
		["118"] = 16,
		["120"] = 16,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.trait_186 = c()
local o = h.trait_186
o.name = "trait_186"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_186"
end
o = e({ k(nil) }, o)
h.trait_186 = o
h.modifier_trait_186 = c()
local p = h.modifier_trait_186
p.name = "modifier_trait_186"
d(p, m)
function p.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.rewardedSects = {}
	self.rewardCount = 0
end
function p.prototype.GetAbilitySpecialValue(self)
	self.triggerLevel = self:GetAbilitySpecialValueFor("trigger_level")
	self.cardCount = self:GetAbilitySpecialValueFor("card_count")
	self.maxCount = self:GetAbilitySpecialValueFor("count")
end
function p.prototype.OnCreated(self)
	if IsServer() then
		GameTimer(0, function()
			return self:CheckExistingSects()
		end)
	end
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SECT_LEVEL_UP] = { self:GetParent(), -1 } }
end
function p.prototype.OnSectLevelUp(self, q)
	if q.newLevel >= self.triggerLevel then
		self:RewardSect(q.sect)
	end
end
function p.prototype.CheckExistingSects(self)
	if not IsValid(self) or self.rewardCount >= self.maxCount then
		return
	end
	local r = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
	if not r then
		return
	end
	local s = r:getAbilityData()
	for t, u in ipairs(f(s)) do
		if s[u].level >= self.triggerLevel then
			self:RewardSect(u)
		end
		if self.rewardCount >= self.maxCount then
			break
		end
	end
end
function p.prototype.RewardSect(self, u)
	if not IsServer() or self.rewardCount >= self.maxCount or self.rewardedSects[u] then
		return
	end
	local v = self:GetParent():GetPlayerOwnerID()
	local r = PlayerData:getHero(v)
	if not r then
		return
	end
	self.rewardedSects[u] = true
	local w = AbilityShop:getRandomAbility(
		v,
		self.cardCount,
		{ specifyRarity = "sr", specifySect = { u }, isAbilityShop = false }
	)
	if #w <= 0 then
		return
	end
	for t, x in ipairs(w) do
		r:learnAbility(x.aid, true)
		Notification:combatToPlayer(
			v,
			{
				message = "notify_artifact_ability_" .. x.rarity,
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. x.aid,
			}
		)
		PlayerData:getplayerData(v):addArtifactAbilities(self:GetAbility():entindex(), x.aid, true)
	end
	self.rewardCount = self.rewardCount + 1
end
p = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
h.modifier_trait_186 = p
return h