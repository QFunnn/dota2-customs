--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_32"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 2,
		["9"] = 2,
		["10"] = 2,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["14"] = 6,
		["15"] = 7,
		["16"] = 6,
		["17"] = 7,
		["18"] = 8,
		["19"] = 9,
		["20"] = 8,
		["21"] = 7,
		["22"] = 6,
		["23"] = 7,
		["25"] = 7,
		["26"] = 13,
		["27"] = 20,
		["28"] = 13,
		["29"] = 20,
		["30"] = 25,
		["31"] = 26,
		["32"] = 27,
		["33"] = 28,
		["34"] = 25,
		["35"] = 30,
		["36"] = 31,
		["37"] = 32,
		["38"] = 33,
		["40"] = 30,
		["41"] = 37,
		["42"] = 38,
		["43"] = 39,
		["44"] = 40,
		["45"] = 41,
		["48"] = 37,
		["49"] = 46,
		["50"] = 47,
		["51"] = 48,
		["52"] = 49,
		["53"] = 50,
		["54"] = 51,
		["55"] = 52,
		["56"] = 53,
		["57"] = 54,
		["59"] = 52,
		["60"] = 64,
		["61"] = 65,
		["62"] = 67,
		["63"] = 68,
		["64"] = 69,
		["65"] = 70,
		["66"] = 70,
		["67"] = 71,
		["68"] = 72,
		["70"] = 73,
		["71"] = 73,
		["72"] = 74,
		["73"] = 75,
		["74"] = 75,
		["75"] = 75,
		["76"] = 75,
		["77"] = 75,
		["78"] = 75,
		["79"] = 75,
		["80"] = 75,
		["81"] = 73,
		["84"] = 81,
		["85"] = 81,
		["86"] = 81,
		["87"] = 81,
		["88"] = 81,
		["92"] = 46,
		["93"] = 86,
		["94"] = 87,
		["95"] = 87,
		["96"] = 89,
		["97"] = 89,
		["98"] = 89,
		["99"] = 87,
		["100"] = 87,
		["101"] = 86,
		["102"] = 92,
		["103"] = 93,
		["104"] = 94,
		["106"] = 92,
		["107"] = 97,
		["108"] = 98,
		["109"] = 97,
		["110"] = 20,
		["111"] = 13,
		["112"] = 13,
		["113"] = 13,
		["114"] = 13,
		["115"] = 13,
		["116"] = 13,
		["117"] = 13,
		["118"] = 20,
		["120"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_32 = c()
local n = g.trait_32
n.name = "trait_32"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_32"
end
n = e({ j(nil) }, n)
g.trait_32 = n
g.modifier_trait_32 = c()
local o = g.modifier_trait_32
o.name = "modifier_trait_32"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.rarity = self:GetAbilitySpecialValueFor("rarity")
	self.count = self:GetAbilitySpecialValueFor("count")
	self.round = self:GetAbilitySpecialValueFor("round")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self.enable = true
		self:Effect()
	end
end
function o.prototype.OnStackCountChanged(self, q)
	if IsServer() then
		if self:GetStackCount() == self.round then
			self.enable = true
			self:Effect()
		end
	end
end
function o.prototype.Effect(self)
	if self.enable then
		local r = self:GetParent():GetPlayerOwnerID()
		local s = PlayerData:getHero(r)
		local t = AbilityShop:getAbilityPoolNew("n", nil, nil, false)
		local u = s:getAbilityUpgradeData()
		t:each(function(v, w)
			if u[w] and u[w].level >= KeyValues.AbilityUpgradesKvs[w].MaxLevel then
				t:set(w, 0)
			end
		end)
		if #t.tName > 0 then
			self.enable = false
			local x = t:random()
			if x then
				local y = KeyValues.AbilityUpgradesKvs[x]
				local z = u[x]
				local A = z and z.level or 0
				local B = SECT_ABILITY_LEVEL[y.rarity]
				local C = B - A
				do
					local D = 0
					while D < C do
						s:learnAbility(x, true)
						Notification:combatToPlayer(
							r,
							{
								message = "notify_artifact_ability_" .. tostring(y.rarity),
								string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility()
									:GetAbilityName(),
								string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. x,
							}
						)
						D = D + 1
					end
				end
				PlayerData:getplayerData(r):addArtifactAbilities(self:GetAbility():entindex(), x, true)
			end
		end
	end
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { self:GetParent(), -1 },
	}
end
function o.prototype.OnRoundChange(self, p)
	if not self.enable then
		self:IncrementStackCount()
	end
end
function o.prototype.OnAbilityLearn(self, p)
	self:Effect()
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_32 = o
return g