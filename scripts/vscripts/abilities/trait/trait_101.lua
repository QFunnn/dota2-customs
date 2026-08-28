--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_101"
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
		["30"] = 22,
		["31"] = 23,
		["32"] = 24,
		["33"] = 22,
		["34"] = 26,
		["35"] = 27,
		["36"] = 28,
		["37"] = 29,
		["38"] = 29,
		["39"] = 29,
		["40"] = 32,
		["41"] = 33,
		["42"] = 34,
		["43"] = 35,
		["44"] = 36,
		["45"] = 37,
		["46"] = 38,
		["47"] = 44,
		["48"] = 45,
		["49"] = 45,
		["50"] = 45,
		["51"] = 45,
		["52"] = 45,
		["53"] = 46,
		["54"] = 46,
		["55"] = 46,
		["56"] = 46,
		["57"] = 46,
		["58"] = 47,
		["59"] = 49,
		["60"] = 50,
		["61"] = 51,
		["64"] = 54,
		["66"] = 55,
		["67"] = 55,
		["68"] = 56,
		["69"] = 57,
		["70"] = 57,
		["71"] = 57,
		["72"] = 57,
		["73"] = 57,
		["74"] = 57,
		["75"] = 57,
		["76"] = 57,
		["77"] = 62,
		["78"] = 62,
		["79"] = 62,
		["80"] = 62,
		["81"] = 62,
		["82"] = 55,
		["87"] = 29,
		["88"] = 29,
		["89"] = 29,
		["90"] = 29,
		["92"] = 26,
		["93"] = 69,
		["94"] = 70,
		["95"] = 71,
		["96"] = 72,
		["97"] = 73,
		["98"] = 74,
		["101"] = 69,
		["102"] = 19,
		["103"] = 12,
		["104"] = 12,
		["105"] = 12,
		["106"] = 12,
		["107"] = 12,
		["108"] = 12,
		["109"] = 12,
		["110"] = 19,
		["112"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_101 = c()
local n = g.trait_101
n.name = "trait_101"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_101"
end
n = e({ j(nil) }, n)
g.trait_101 = n
g.modifier_trait_101 = c()
local o = g.modifier_trait_101
o.name = "modifier_trait_101"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.exp = self:GetAbilitySpecialValueFor("exp")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetCaster()
		PlayerData:requestSectSelection(
			q:GetPlayerOwnerID(),
			{ sects = AbilityShop.pickList, ability_name = "trait_101" },
			function(r, s, t)
				if IsValid(self) and IsValid(self:GetCaster()) then
					local u = PlayerData:getplayerData(s)
					local v = u.hero
					u.bannedSect = t
					u:updateNetTable()
					Notification:combatToPlayer(
						s,
						{
							message = "notify_artifact_48",
							string_itemname_artifact = "DOTA_Tooltip_ability_trait_101",
							string_sect = "DOTA_Tooltip_ability_" .. t,
							int_exp = self.exp,
						}
					)
					v:addSectExp(t, self.exp)
					u:modifyArtifactExtraData(self:GetAbility():entindex(), "exp_gain", self.exp)
					u:modifyArtifactExtraStringData(
						self:GetAbility():entindex(),
						"DOTA_Tooltip_ability_trait_101_effect",
						"#DOTA_Tooltip_ability_" .. t
					)
					local w
					for x, y in pairs(KeyValues.AbilityUpgradesKvs) do
						if y.type == "inhibit" and y.sect == t then
							w = x
						end
					end
					if w then
						do
							local z = 0
							while z < self.count do
								v:learnAbility(w, true)
								Notification:combatToPlayer(
									s,
									{
										message = "notify_artifact_ability_"
											.. tostring(KeyValues.AbilityUpgradesKvs[w].rarity),
										string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility()
											:GetAbilityName(),
										string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. w,
									}
								)
								u:addArtifactAbilities(self:GetAbility():entindex(), w, z == self.count - 1)
								z = z + 1
							end
						end
					end
				end
			end,
			"trait_101",
			true
		)
	end
end
function o.prototype.OnDestroy(self)
	if IsServer() then
		local u = PlayerData:getplayerData(self:GetCaster():GetPlayerOwnerID())
		if u then
			u.bannedSect = nil
			u:updateNetTable()
		end
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_101 = o
return g