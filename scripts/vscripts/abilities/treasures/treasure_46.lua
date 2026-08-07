--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_46"
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
		["14"] = 4,
		["15"] = 5,
		["16"] = 7,
		["17"] = 8,
		["18"] = 7,
		["19"] = 8,
		["20"] = 9,
		["21"] = 10,
		["24"] = 14,
		["25"] = 15,
		["26"] = 16,
		["27"] = 17,
		["28"] = 17,
		["29"] = 17,
		["30"] = 17,
		["33"] = 21,
		["34"] = 9,
		["35"] = 24,
		["36"] = 25,
		["37"] = 24,
		["38"] = 8,
		["39"] = 7,
		["40"] = 8,
		["42"] = 8,
		["43"] = 29,
		["44"] = 36,
		["45"] = 29,
		["46"] = 36,
		["47"] = 41,
		["48"] = 42,
		["49"] = 43,
		["50"] = 41,
		["51"] = 46,
		["52"] = 47,
		["55"] = 51,
		["56"] = 52,
		["57"] = 53,
		["58"] = 53,
		["59"] = 53,
		["60"] = 53,
		["61"] = 53,
		["62"] = 53,
		["63"] = 53,
		["64"] = 53,
		["65"] = 53,
		["66"] = 62,
		["67"] = 62,
		["68"] = 62,
		["69"] = 62,
		["70"] = 62,
		["71"] = 62,
		["72"] = 62,
		["73"] = 62,
		["74"] = 62,
		["75"] = 46,
		["76"] = 73,
		["77"] = 74,
		["80"] = 78,
		["81"] = 79,
		["82"] = 79,
		["83"] = 79,
		["84"] = 79,
		["85"] = 79,
		["86"] = 79,
		["87"] = 79,
		["88"] = 79,
		["89"] = 79,
		["90"] = 88,
		["91"] = 88,
		["92"] = 88,
		["93"] = 88,
		["94"] = 88,
		["95"] = 88,
		["96"] = 88,
		["97"] = 88,
		["98"] = 88,
		["99"] = 73,
		["100"] = 99,
		["101"] = 100,
		["102"] = 101,
		["103"] = 101,
		["104"] = 100,
		["105"] = 99,
		["106"] = 105,
		["107"] = 106,
		["108"] = 107,
		["109"] = 107,
		["110"] = 107,
		["111"] = 107,
		["112"] = 107,
		["113"] = 107,
		["114"] = 105,
		["115"] = 36,
		["116"] = 29,
		["117"] = 29,
		["118"] = 29,
		["119"] = 29,
		["120"] = 29,
		["121"] = 29,
		["122"] = 29,
		["123"] = 36,
		["125"] = 36,
		["126"] = 111,
		["127"] = 118,
		["128"] = 111,
		["129"] = 118,
		["130"] = 121,
		["131"] = 122,
		["132"] = 121,
		["133"] = 125,
		["134"] = 126,
		["135"] = 125,
		["136"] = 131,
		["137"] = 132,
		["140"] = 136,
		["141"] = 137,
		["142"] = 138,
		["144"] = 131,
		["145"] = 118,
		["146"] = 111,
		["147"] = 111,
		["148"] = 111,
		["149"] = 111,
		["150"] = 111,
		["151"] = 111,
		["152"] = 111,
		["153"] = 118,
		["155"] = 118,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = "13"
local o = "r_13_max_stack"
g.treasure_46 = c()
local p = g.treasure_46
p.name = "treasure_46"
d(p, i)
function p.prototype.Spawn(self)
	if not IsServer() then
		return
	end
	local q = self:GetCaster():GetPlayerOwnerID()
	local r = PlayerData:getHero(q)
	if r:getAbilityUpgradeLevel(n) >= SECT_ABILITY_LEVEL.r then
		PlayerData:modifyGold(q, self:GetSpecialValueFor("gold"))
		return
	end
	r:learnAbility(n, true)
end
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_46"
end
p = e({ j(nil) }, p)
g.treasure_46 = p
g.modifier_treasure_46 = c()
local s = g.modifier_treasure_46
s.name = "modifier_treasure_46"
d(s, l)
function s.prototype.GetAbilitySpecialValue(self)
	self.maxBonus = self:GetAbilitySpecialValueFor("max_bonus")
	self.preBattleStack = self:GetAbilitySpecialValueFor("pre_battle_stack")
end
function s.prototype.OnCreated(self, t)
	if not IsServer() then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	self.upgradeID = tostring(self:GetAbility():entindex())
	AbilityUpgrades:AddSpecialValueUpgrade(
		q,
		{
			id = self.upgradeID,
			type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE,
			description = self.upgradeID,
			ability_name = n,
			special_value_name = o,
			operator = ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD,
			value = self.maxBonus,
		}
	)
	AbilityUpgrades:AddSpecialValueUpgrade(
		q,
		{
			id = self.upgradeID,
			type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE,
			description = self.upgradeID,
			ability_name = n,
			special_value_name = "r_13_pre_stack_count",
			operator = ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD,
			value = self.preBattleStack,
		}
	)
end
function s.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	AbilityUpgrades:RemoveSpecialValueUpgrade(
		q,
		{
			id = self.upgradeID,
			type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE,
			description = self.upgradeID,
			ability_name = n,
			special_value_name = o,
			operator = ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD,
			value = self.maxBonus,
		}
	)
	AbilityUpgrades:RemoveSpecialValueUpgrade(
		q,
		{
			id = self.upgradeID,
			type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE,
			description = self.upgradeID,
			ability_name = n,
			special_value_name = "r_13_pre_stack_count",
			operator = ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD,
			value = self.preBattleStack,
		}
	)
end
function s.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function s.prototype.OnTraitInit(self, t)
	t.hero:RemoveModifierByName("modifier_treasure_46_buff")
	t.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_treasure_46_buff", {})
end
s = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	s
)
g.modifier_treasure_46 = s
g.modifier_treasure_46_buff = c()
local u = g.modifier_treasure_46_buff
u.name = "modifier_treasure_46_buff"
d(u, l)
function u.prototype.GetAbilitySpecialValue(self)
	self.preBattleStack = self:GetAbilitySpecialValueFor("pre_battle_stack")
end
function u.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function u.prototype.OnBattleStartBefore(self)
	if not IsServer() then
		return
	end
	local v = self:GetParent():FindModifierByName("modifier_sect_attack_13_buff")
	if v ~= nil then
		v:SetStackCount(v:GetStackCount() + self.preBattleStack)
	end
end
u = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	u
)
g.modifier_treasure_46_buff = u
return g