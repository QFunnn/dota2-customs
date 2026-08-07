--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_124"
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
		["31"] = 27,
		["32"] = 28,
		["33"] = 29,
		["34"] = 30,
		["35"] = 31,
		["36"] = 32,
		["37"] = 33,
		["39"] = 27,
		["40"] = 36,
		["41"] = 37,
		["42"] = 38,
		["43"] = 39,
		["44"] = 40,
		["45"] = 41,
		["46"] = 42,
		["47"] = 43,
		["48"] = 44,
		["49"] = 45,
		["50"] = 46,
		["52"] = 47,
		["53"] = 47,
		["55"] = 48,
		["56"] = 49,
		["58"] = 51,
		["61"] = 47,
		["64"] = 53,
		["66"] = 54,
		["67"] = 55,
		["68"] = 56,
		["70"] = 58,
		["75"] = 61,
		["76"] = 62,
		["77"] = 63,
		["78"] = 64,
		["79"] = 64,
		["80"] = 64,
		["81"] = 65,
		["82"] = 65,
		["83"] = 65,
		["84"] = 65,
		["85"] = 65,
		["86"] = 65,
		["87"] = 65,
		["88"] = 65,
		["89"] = 70,
		["90"] = 71,
		["91"] = 71,
		["92"] = 71,
		["93"] = 71,
		["94"] = 71,
		["95"] = 64,
		["96"] = 64,
		["101"] = 36,
		["102"] = 78,
		["103"] = 79,
		["104"] = 78,
		["105"] = 83,
		["106"] = 84,
		["109"] = 85,
		["110"] = 86,
		["111"] = 87,
		["112"] = 88,
		["113"] = 89,
		["114"] = 90,
		["115"] = 91,
		["116"] = 92,
		["118"] = 93,
		["119"] = 93,
		["120"] = 94,
		["121"] = 94,
		["122"] = 94,
		["123"] = 95,
		["124"] = 95,
		["125"] = 95,
		["126"] = 95,
		["127"] = 95,
		["128"] = 95,
		["129"] = 95,
		["130"] = 95,
		["131"] = 100,
		["132"] = 101,
		["133"] = 101,
		["134"] = 101,
		["135"] = 101,
		["136"] = 101,
		["137"] = 94,
		["138"] = 94,
		["139"] = 93,
		["145"] = 83,
		["146"] = 19,
		["147"] = 12,
		["148"] = 12,
		["149"] = 12,
		["150"] = 12,
		["151"] = 12,
		["152"] = 12,
		["153"] = 12,
		["154"] = 19,
		["156"] = 19,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.trait_124 = c()
local o = h.trait_124
o.name = "trait_124"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_124"
end
o = e({ k(nil) }, o)
h.trait_124 = o
h.modifier_trait_124 = c()
local p = h.modifier_trait_124
p.name = "modifier_trait_124"
d(p, m)
function p.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.round = self:GetAbilitySpecialValueFor("round")
	self["repeat"] = self:GetAbilitySpecialValueFor("repeat")
	self.repeat_count = self:GetAbilitySpecialValueFor("repeat_count")
	if IsServer() then
		self.round_record = self.round
	end
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		local r = self:GetParent():GetPlayerOwnerID()
		local s = PlayerData:getplayerData(r)
		if s then
			local t = s.hero
			if t then
				local u = t:getAbilityUpgradeData()
				local v = {}
				local w = {}
				local x = s.bannedSect
				do
					local y = 0
					while y < #AbilityShop.pickList do
						do
							if x and AbilityShop.pickList[y + 1] == x then
								goto z
							end
							w[AbilityShop.pickList[y + 1]] = true
						end
						::z::
						y = y + 1
					end
				end
				for A, B in pairs(KeyValues.AbilityUpgradesKvs) do
					do
						if w[B.sect] and B.rarity == "r" then
							if u[A] and u[A].level > 0 then
								goto C
							end
							v[#v + 1] = A
						end
					end
					::C::
				end
				self.abilityList = {}
				if #v > 0 then
					self.abilityList = PickList(v, self.count)
					f(self.abilityList, function(D, A, E)
						Notification:combatToPlayer(
							r,
							{
								message = "notify_artifact_ability_"
									.. tostring(KeyValues.AbilityUpgradesKvs[A].rarity),
								string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility()
									:GetAbilityName(),
								string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. A,
							}
						)
						t:learnAbility(A, true)
						PlayerData:getplayerData(r)
							:addArtifactAbilities(self:GetAbility():entindex(), A, E == #self.abilityList - 1)
					end)
				end
			end
		end
	end
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END] = { -1, -1 } }
end
function p.prototype.OnBattleEndStateEnd(self, q)
	if self["repeat"] == 0 then
		return
	end
	self.round_record = self.round_record - 1
	if self.round_record == 0 then
		self.round_record = self.round
		self["repeat"] = self["repeat"] - 1
		if #self.abilityList > 0 then
			local r = self:GetParent():GetPlayerOwnerID()
			local t = PlayerData:getHero(r)
			if t then
				do
					local y = 0
					while y < self.repeat_count do
						f(self.abilityList, function(D, A, E)
							Notification:combatToPlayer(
								r,
								{
									message = "notify_artifact_ability_"
										.. tostring(KeyValues.AbilityUpgradesKvs[A].rarity),
									string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility()
										:GetAbilityName(),
									string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. A,
								}
							)
							t:learnAbility(A, true)
							PlayerData:getplayerData(r):addArtifactAbilities(
								self:GetAbility():entindex(),
								A,
								y == self.repeat_count - 1 and E == #self.abilityList - 1
							)
						end)
						y = y + 1
					end
				end
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
h.modifier_trait_124 = p
return h