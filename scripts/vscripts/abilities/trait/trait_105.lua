--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_105"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__StringIncludes
local g = b.__TS__StringSplit
local h = b.__TS__ArrayIncludes
local i = b.__TS__ArraySome
local j = b.__TS__ArrayForEach
local k = b.__TS__SourceMapTraceBack
k(
	debug.getinfo(1).short_src,
	{
		["13"] = 1,
		["14"] = 1,
		["15"] = 1,
		["16"] = 2,
		["17"] = 2,
		["18"] = 2,
		["19"] = 5,
		["20"] = 6,
		["21"] = 5,
		["22"] = 6,
		["23"] = 7,
		["24"] = 8,
		["25"] = 7,
		["26"] = 6,
		["27"] = 5,
		["28"] = 6,
		["30"] = 6,
		["31"] = 12,
		["32"] = 19,
		["33"] = 12,
		["34"] = 19,
		["35"] = 23,
		["36"] = 24,
		["37"] = 23,
		["38"] = 26,
		["39"] = 27,
		["40"] = 28,
		["41"] = 29,
		["42"] = 29,
		["43"] = 29,
		["44"] = 32,
		["45"] = 33,
		["46"] = 34,
		["47"] = 35,
		["48"] = 36,
		["49"] = 36,
		["50"] = 36,
		["51"] = 36,
		["52"] = 36,
		["54"] = 29,
		["55"] = 29,
		["56"] = 29,
		["57"] = 29,
		["59"] = 26,
		["60"] = 41,
		["61"] = 42,
		["62"] = 41,
		["63"] = 46,
		["64"] = 47,
		["67"] = 48,
		["68"] = 49,
		["69"] = 50,
		["70"] = 51,
		["71"] = 51,
		["72"] = 51,
		["73"] = 51,
		["74"] = 51,
		["75"] = 52,
		["78"] = 54,
		["79"] = 55,
		["80"] = 56,
		["81"] = 57,
		["82"] = 58,
		["83"] = 59,
		["84"] = 60,
		["85"] = 60,
		["86"] = 60,
		["87"] = 60,
		["88"] = 61,
		["92"] = 65,
		["93"] = 65,
		["94"] = 65,
		["96"] = 66,
		["97"] = 66,
		["98"] = 67,
		["99"] = 67,
		["100"] = 67,
		["101"] = 67,
		["102"] = 67,
		["103"] = 67,
		["104"] = 67,
		["105"] = 67,
		["106"] = 72,
		["107"] = 73,
		["108"] = 73,
		["109"] = 73,
		["110"] = 73,
		["111"] = 73,
		["112"] = 66,
		["115"] = 65,
		["116"] = 65,
		["117"] = 46,
		["118"] = 19,
		["119"] = 12,
		["120"] = 12,
		["121"] = 12,
		["122"] = 12,
		["123"] = 12,
		["124"] = 12,
		["125"] = 12,
		["126"] = 19,
		["128"] = 19,
	}
)
local l = {}
local m = require("lib.dota_ts_adapter")
local n = m.BaseAbility
local o = m.registerAbility
local p = require("modifiers.eom_modifier")
local q = p.EOMModifier
local r = p.registerEOMModifier
l.trait_105 = c()
local s = l.trait_105
s.name = "trait_105"
d(s, n)
function s.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_105"
end
s = e({ o(nil) }, s)
l.trait_105 = s
l.modifier_trait_105 = c()
local t = l.modifier_trait_105
t.name = "modifier_trait_105"
d(t, q)
function t.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
end
function t.prototype.OnCreated(self, u)
	if IsServer() then
		local v = self:GetCaster()
		PlayerData:requestSectSelection(
			v:GetPlayerOwnerID(),
			{ sects = AbilityShop.pickList, ability_name = "trait_105" },
			function(w, x, y)
				if IsValid(self) and IsValid(self:GetCaster()) then
					self.selectedSect = y
					self.round = self:GetAbilitySpecialValueFor("round")
					PlayerData:getplayerData(x):modifyArtifactExtraStringData(
						self:GetAbility():entindex(),
						"DOTA_Tooltip_ability_trait_102_effect",
						tostring(self.round)
					)
				end
			end,
			"trait_105",
			true
		)
	end
end
function t.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 } }
end
function t.prototype.OnRoundChange(self, u)
	if self.round == nil or self.round <= 0 then
		return
	end
	self.round = self.round - 1
	local x = self:GetCaster():GetPlayerOwnerID()
	local z = PlayerData:getplayerData(x)
	z:modifyArtifactExtraStringData(
		self:GetAbility():entindex(),
		"DOTA_Tooltip_ability_trait_102_effect",
		tostring(self.round)
	)
	if self.round ~= 0 or not z.hero then
		return
	end
	local A = z.hero
	local B = {}
	local C = AbilityShop.banList
	for D, E in pairs(KeyValues.AbilityUpgradesKvs) do
		if E.rarity == "n" and f(E.sect, self.selectedSect) then
			local F = g(E.sect, "|")
			if not i(F, function(w, E)
				return h(C, E)
			end) then
				B[#B + 1] = D
			end
		end
	end
	j(B, function(w, G, H)
		do
			local I = 0
			while I < self.count do
				Notification:combatToPlayer(
					x,
					{
						message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[G].rarity),
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. G,
					}
				)
				A:learnAbility(G, true)
				z:addArtifactAbilities(self:GetAbility():entindex(), G, H == #B - 1 and I == self.count - 1)
				I = I + 1
			end
		end
	end)
end
t = e(
	{ r(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	t
)
l.modifier_trait_105 = t
return l