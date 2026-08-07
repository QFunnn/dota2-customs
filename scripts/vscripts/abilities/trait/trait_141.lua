--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_141"
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
		["31"] = 23,
		["32"] = 24,
		["33"] = 25,
		["34"] = 26,
		["35"] = 27,
		["36"] = 28,
		["37"] = 28,
		["38"] = 28,
		["39"] = 28,
		["40"] = 28,
		["42"] = 23,
		["43"] = 31,
		["44"] = 32,
		["45"] = 31,
		["46"] = 36,
		["47"] = 37,
		["48"] = 38,
		["49"] = 39,
		["50"] = 40,
		["51"] = 41,
		["52"] = 42,
		["53"] = 43,
		["54"] = 44,
		["55"] = 47,
		["56"] = 47,
		["57"] = 47,
		["58"] = 47,
		["59"] = 47,
		["60"] = 47,
		["61"] = 47,
		["62"] = 48,
		["63"] = 48,
		["64"] = 48,
		["65"] = 48,
		["66"] = 48,
		["67"] = 48,
		["68"] = 48,
		["69"] = 48,
		["70"] = 53,
		["71"] = 54,
		["72"] = 54,
		["73"] = 54,
		["74"] = 54,
		["75"] = 54,
		["76"] = 47,
		["77"] = 47,
		["79"] = 57,
		["80"] = 57,
		["81"] = 57,
		["82"] = 57,
		["83"] = 57,
		["85"] = 36,
		["86"] = 19,
		["87"] = 12,
		["88"] = 12,
		["89"] = 12,
		["90"] = 12,
		["91"] = 12,
		["92"] = 12,
		["93"] = 12,
		["94"] = 19,
		["96"] = 19,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.trait_141 = c()
local o = h.trait_141
o.name = "trait_141"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_141"
end
o = e({ k(nil) }, o)
h.trait_141 = o
h.modifier_trait_141 = c()
local p = h.modifier_trait_141
p.name = "modifier_trait_141"
d(p, m)
function p.prototype.GetAbilitySpecialValue(self)
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
	self.count = self:GetAbilitySpecialValueFor("count")
	if IsServer() then
		self.record = 0
		PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			:modifyArtifactExtraStringData(self:GetAbility():entindex(), "trait_cost", tostring(self.record))
	end
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SHOP_REFRESH] = { self:GetParent() } }
end
function p.prototype.OnShopRefresh(self, q)
	if q.cost > 0 then
		self.record = self.record + q.cost
		local r = self:GetParent()
		local s = r:GetPlayerOwnerID()
		if self.record >= self.threshold then
			self.record = self.record - self.threshold
			local t = PlayerData:getHero(s)
			local u = AbilityShop:getRandomAbility(s, self.count, { isAbilityShop = false })
			f(u, function(v, w, x)
				local y
				local z
				z = w.aid
				y = w.rarity
				Notification:combatToPlayer(
					s,
					{
						message = "notify_artifact_ability_" .. y,
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. z,
					}
				)
				t:learnAbility(z, true)
				PlayerData:getplayerData(s):addArtifactAbilities(self:GetAbility():entindex(), z, x == #u - 1)
			end)
		end
		PlayerData:getplayerData(s)
			:modifyArtifactExtraStringData(self:GetAbility():entindex(), "trait_cost", tostring(self.record))
	end
end
p = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
h.modifier_trait_141 = p
return h