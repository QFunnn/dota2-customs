--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		["35"] = 21,
		["36"] = 22,
		["37"] = 21,
		["38"] = 24,
		["39"] = 25,
		["40"] = 26,
		["41"] = 27,
		["42"] = 27,
		["43"] = 27,
		["44"] = 30,
		["45"] = 31,
		["46"] = 32,
		["47"] = 33,
		["48"] = 34,
		["49"] = 35,
		["50"] = 36,
		["51"] = 37,
		["52"] = 38,
		["53"] = 39,
		["54"] = 39,
		["55"] = 39,
		["56"] = 39,
		["57"] = 40,
		["61"] = 44,
		["62"] = 44,
		["63"] = 44,
		["64"] = 45,
		["65"] = 45,
		["66"] = 45,
		["67"] = 45,
		["68"] = 45,
		["69"] = 45,
		["70"] = 45,
		["71"] = 45,
		["72"] = 50,
		["73"] = 51,
		["74"] = 51,
		["75"] = 51,
		["76"] = 51,
		["77"] = 51,
		["78"] = 44,
		["79"] = 44,
		["81"] = 27,
		["82"] = 27,
		["83"] = 27,
		["84"] = 27,
		["86"] = 24,
		["87"] = 19,
		["88"] = 12,
		["89"] = 12,
		["90"] = 12,
		["91"] = 12,
		["92"] = 12,
		["93"] = 12,
		["94"] = 12,
		["95"] = 19,
		["97"] = 19,
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
					local z = PlayerData:getplayerData(x)
					local A = z.hero
					local B = {}
					local C = AbilityShop.banList
					for D, E in pairs(KeyValues.AbilityUpgradesKvs) do
						if E.rarity == "n" and f(E.sect, y) then
							local F = g(E.sect, "|")
							if not i(F, function(w, E)
								return h(C, E)
							end) then
								B[#B + 1] = D
							end
						end
					end
					j(B, function(w, G, H)
						Notification:combatToPlayer(
							x,
							{
								message = "notify_artifact_ability_"
									.. tostring(KeyValues.AbilityUpgradesKvs[G].rarity),
								string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility()
									:GetAbilityName(),
								string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. G,
							}
						)
						A:learnAbility(G, true)
						PlayerData:getplayerData(x):addArtifactAbilities(self:GetAbility():entindex(), G, H == #B - 1)
					end)
				end
			end,
			"trait_105",
			true
		)
	end
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