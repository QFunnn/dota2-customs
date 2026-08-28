--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_43"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 12,
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["30"] = 24,
		["31"] = 25,
		["32"] = 26,
		["33"] = 24,
		["34"] = 28,
		["35"] = 29,
		["36"] = 31,
		["38"] = 28,
		["39"] = 38,
		["40"] = 39,
		["41"] = 38,
		["42"] = 43,
		["43"] = 44,
		["44"] = 45,
		["46"] = 43,
		["47"] = 48,
		["48"] = 49,
		["49"] = 50,
		["50"] = 51,
		["51"] = 52,
		["52"] = 53,
		["55"] = 48,
		["56"] = 57,
		["57"] = 58,
		["58"] = 59,
		["59"] = 60,
		["60"] = 61,
		["61"] = 62,
		["63"] = 66,
		["64"] = 66,
		["65"] = 67,
		["66"] = 66,
		["69"] = 69,
		["70"] = 69,
		["71"] = 69,
		["72"] = 69,
		["73"] = 69,
		["74"] = 70,
		["75"] = 71,
		["76"] = 71,
		["77"] = 71,
		["78"] = 71,
		["79"] = 72,
		["80"] = 72,
		["81"] = 72,
		["82"] = 72,
		["83"] = 72,
		["84"] = 72,
		["85"] = 72,
		["86"] = 72,
		["87"] = 77,
		["88"] = 78,
		["89"] = 79,
		["91"] = 81,
		["92"] = 69,
		["93"] = 69,
		["94"] = 57,
		["95"] = 19,
		["96"] = 12,
		["97"] = 12,
		["98"] = 12,
		["99"] = 12,
		["100"] = 12,
		["101"] = 12,
		["102"] = 12,
		["103"] = 19,
		["105"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_43 = c()
local n = g.trait_43
n.name = "trait_43"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_43"
end
n = e({ j(nil) }, n)
g.trait_43 = n
g.modifier_trait_43 = c()
local o = g.modifier_trait_43
o.name = "modifier_trait_43"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self:Effect()
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 } }
end
function o.prototype.OnRoundChange(self, p)
	if not self.enable then
		self:StartIntervalThink(0.1)
	end
end
function o.prototype.OnIntervalThink(self)
	if IsServer() then
		self:StartIntervalThink(-1)
		self:IncrementStackCount()
		if self:GetStackCount() >= self.round then
			self:Effect()
		end
	end
end
function o.prototype.Effect(self)
	self.enable = true
	self:SetStackCount(0)
	local q = self:GetParent():GetPlayerOwnerID()
	local r = {}
	local s = AbilityShop:getRandomAbility(q, self.count, { specifyRarity = "r", specifyRarityIgnoreRule = true })
	do
		local t = 0
		while t < #s do
			r[#r + 1] = s[t + 1].aid
			t = t + 1
		end
	end
	Selection:AddSpecialSelection(q, "ability_card", r, function(u, v)
		self.enable = false
		PlayerData:getplayerData(q):addArtifactAbilities(self.ability:entindex(), v)
		Notification:combatToPlayer(
			q,
			{
				message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[v].rarity),
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.ability:GetAbilityName(),
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. v,
			}
		)
		local w = PlayerData:getHero(q)
		if w then
			w:learnAbility(v, true)
		end
		return true
	end)
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_43 = o
return g