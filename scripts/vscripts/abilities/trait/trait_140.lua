--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_140"
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
		["30"] = 21,
		["31"] = 22,
		["32"] = 23,
		["33"] = 24,
		["34"] = 25,
		["35"] = 26,
		["36"] = 27,
		["37"] = 27,
		["38"] = 27,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 27,
		["43"] = 27,
		["44"] = 32,
		["45"] = 33,
		["46"] = 33,
		["47"] = 33,
		["48"] = 33,
		["51"] = 21,
		["52"] = 37,
		["53"] = 38,
		["54"] = 39,
		["55"] = 39,
		["56"] = 38,
		["57"] = 37,
		["58"] = 42,
		["59"] = 43,
		["60"] = 44,
		["61"] = 44,
		["62"] = 44,
		["63"] = 44,
		["64"] = 44,
		["65"] = 44,
		["66"] = 42,
		["67"] = 20,
		["68"] = 13,
		["69"] = 13,
		["70"] = 13,
		["71"] = 13,
		["72"] = 13,
		["73"] = 13,
		["74"] = 13,
		["75"] = 20,
		["77"] = 20,
		["78"] = 48,
		["79"] = 56,
		["80"] = 48,
		["81"] = 56,
		["82"] = 58,
		["83"] = 59,
		["84"] = 60,
		["86"] = 58,
		["87"] = 63,
		["88"] = 64,
		["89"] = 64,
		["90"] = 66,
		["91"] = 66,
		["92"] = 66,
		["93"] = 64,
		["94"] = 64,
		["95"] = 63,
		["96"] = 69,
		["97"] = 70,
		["98"] = 69,
		["99"] = 72,
		["100"] = 73,
		["101"] = 72,
		["102"] = 75,
		["103"] = 76,
		["104"] = 77,
		["105"] = 78,
		["106"] = 79,
		["107"] = 80,
		["108"] = 81,
		["111"] = 84,
		["112"] = 85,
		["113"] = 86,
		["115"] = 88,
		["118"] = 75,
		["119"] = 92,
		["120"] = 93,
		["121"] = 92,
		["122"] = 97,
		["123"] = 98,
		["124"] = 97,
		["125"] = 103,
		["126"] = 104,
		["127"] = 103,
		["128"] = 56,
		["129"] = 48,
		["130"] = 48,
		["131"] = 48,
		["132"] = 48,
		["133"] = 48,
		["134"] = 48,
		["135"] = 48,
		["136"] = 48,
		["137"] = 56,
		["139"] = 56,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_140 = c()
local n = g.trait_140
n.name = "trait_140"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_140"
end
n = e({ j(nil) }, n)
g.trait_140 = n
g.modifier_trait_140 = c()
local o = g.modifier_trait_140
o.name = "modifier_trait_140"
d(o, l)
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = "156"
		local s = PlayerData:getHero(q)
		if s then
			Notification:combatToPlayer(
				q,
				{
					message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[r].rarity),
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. r,
				}
			)
			s:learnAbility(r, true)
			PlayerData:getplayerData(q):addArtifactAbilities(self:GetAbility():entindex(), r)
		end
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_140_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_140_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_140 = o
g.modifier_trait_140_buff = c()
local t = g.modifier_trait_140_buff
t.name = "modifier_trait_140_buff"
d(t, l)
function t.prototype.OnCreated(self, p)
	if IsServer() then
		self.mana_regen = self:GetAbilitySpecialValueFor("mana_regen_pct")
	end
end
function t.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function t.prototype.OnBattleStartBefore(self, p)
	self:StartIntervalThink(0.1)
end
function t.prototype.OnBattleEnd(self, p)
	self:StartIntervalThink(-1)
end
function t.prototype.OnIntervalThink(self)
	if IsServer() then
		local u = self:GetParent()
		local v = u:GetEnemy()
		if not IsInjurable(v, u) then
			self:StartIntervalThink(-1)
			self:SetStackCount(0)
			return
		end
		local w = v:FindModifierByName("modifier_ice_permanent")
		if IsValid(w) then
			self:SetStackCount(w:GetManaRegen() * self.mana_regen * 0.01)
		else
			self:SetStackCount(0)
		end
	end
end
function t.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BONUS }
end
function t.prototype.ECheckState(self)
	return {
		[EOMModifierStates.MODIFIER_STATE_IGNORE_ICE_MANA_REGEN_EFFECT] = true,
		[EOMModifierStates.MODIFIER_STATE_IGNORE_ICE_EFFECT] = true,
	}
end
function t.prototype.EOM_GetModifierManaRegenBonus(self)
	return self:GetStackCount()
end
t = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	t
)
g.modifier_trait_140_buff = t
return g