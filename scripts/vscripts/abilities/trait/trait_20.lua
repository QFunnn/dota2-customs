--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_20"
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
		["30"] = 20,
		["31"] = 21,
		["32"] = 22,
		["33"] = 23,
		["34"] = 25,
		["36"] = 26,
		["37"] = 26,
		["38"] = 27,
		["39"] = 28,
		["40"] = 29,
		["41"] = 30,
		["42"] = 30,
		["43"] = 30,
		["44"] = 30,
		["45"] = 30,
		["46"] = 30,
		["47"] = 30,
		["48"] = 30,
		["49"] = 35,
		["50"] = 35,
		["51"] = 35,
		["52"] = 35,
		["53"] = 35,
		["54"] = 26,
		["58"] = 20,
		["59"] = 39,
		["60"] = 40,
		["61"] = 42,
		["62"] = 42,
		["63"] = 40,
		["64"] = 39,
		["65"] = 45,
		["66"] = 46,
		["67"] = 47,
		["68"] = 47,
		["69"] = 47,
		["70"] = 47,
		["71"] = 47,
		["72"] = 47,
		["73"] = 45,
		["74"] = 19,
		["75"] = 12,
		["76"] = 12,
		["77"] = 12,
		["78"] = 12,
		["79"] = 12,
		["80"] = 12,
		["81"] = 12,
		["82"] = 19,
		["84"] = 19,
		["85"] = 58,
		["86"] = 65,
		["87"] = 58,
		["88"] = 65,
		["89"] = 69,
		["90"] = 70,
		["91"] = 71,
		["92"] = 72,
		["93"] = 69,
		["94"] = 74,
		["95"] = 75,
		["96"] = 74,
		["97"] = 81,
		["98"] = 82,
		["99"] = 81,
		["100"] = 86,
		["101"] = 87,
		["102"] = 88,
		["104"] = 86,
		["105"] = 65,
		["106"] = 58,
		["107"] = 58,
		["108"] = 58,
		["109"] = 58,
		["110"] = 58,
		["111"] = 58,
		["112"] = 58,
		["113"] = 65,
		["115"] = 65,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_20 = c()
local n = g.trait_20
n.name = "trait_20"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_20"
end
n = e({ j(nil) }, n)
g.trait_20 = n
g.modifier_trait_20 = c()
local o = g.modifier_trait_20
o.name = "modifier_trait_20"
d(o, l)
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = { "82" }
		local s = PlayerData:getHero(q)
		do
			local t = 0
			while t < #r do
				local u = r[t + 1]
				s:learnAbility(u, true)
				local v = KeyValues.AbilityUpgradesKvs[u]
				Notification:combatToPlayer(
					q,
					{
						message = "notify_artifact_ability_" .. tostring(v.rarity),
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. u,
					}
				)
				PlayerData:getplayerData(q):addArtifactAbilities(self:GetAbility():entindex(), u, t == #r - 1)
				t = t + 1
			end
		end
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_20_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_20_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_20 = o
g.modifier_trait_20_buff = c()
local w = g.modifier_trait_20_buff
w.name = "modifier_trait_20_buff"
d(w, l)
function w.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.reduce = self:GetAbilitySpecialValueFor("reduce")
end
function w.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_PHYSICAL_DAMAGE_PERCENTAGE] = -self.reduce,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_MAGICAL_DAMAGE_PERCENTAGE] = -self.reduce,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_INTERVAL] = -self.interval,
	}
end
function w.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function w.prototype.EOM_GetModifierOutgoingDamagePercentage(self, p)
	if p and p.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_POISON then
		return self.damage
	end
end
w = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	w
)
g.modifier_trait_20_buff = w
return g