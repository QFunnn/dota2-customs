--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_182"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ObjectKeys
local g = b.__TS__ArrayFilter
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 1,
		["13"] = 2,
		["14"] = 2,
		["15"] = 2,
		["16"] = 4,
		["17"] = 7,
		["18"] = 8,
		["19"] = 7,
		["20"] = 8,
		["21"] = 15,
		["22"] = 16,
		["25"] = 17,
		["26"] = 18,
		["27"] = 19,
		["28"] = 15,
		["29"] = 22,
		["30"] = 23,
		["33"] = 24,
		["34"] = 25,
		["35"] = 26,
		["36"] = 26,
		["37"] = 26,
		["39"] = 26,
		["40"] = 27,
		["41"] = 28,
		["42"] = 28,
		["43"] = 28,
		["44"] = 28,
		["45"] = 29,
		["46"] = 22,
		["47"] = 32,
		["48"] = 33,
		["51"] = 34,
		["52"] = 35,
		["53"] = 36,
		["56"] = 40,
		["57"] = 41,
		["58"] = 42,
		["59"] = 43,
		["60"] = 44,
		["61"] = 45,
		["62"] = 45,
		["63"] = 45,
		["64"] = 45,
		["65"] = 45,
		["68"] = 49,
		["69"] = 50,
		["70"] = 32,
		["71"] = 53,
		["72"] = 54,
		["73"] = 55,
		["74"] = 56,
		["76"] = 58,
		["77"] = 53,
		["78"] = 61,
		["79"] = 62,
		["80"] = 62,
		["81"] = 62,
		["82"] = 62,
		["83"] = 62,
		["84"] = 61,
		["85"] = 65,
		["86"] = 66,
		["87"] = 65,
		["88"] = 8,
		["89"] = 7,
		["90"] = 8,
		["92"] = 8,
		["93"] = 70,
		["94"] = 77,
		["95"] = 70,
		["96"] = 77,
		["97"] = 78,
		["98"] = 79,
		["99"] = 78,
		["100"] = 82,
		["101"] = 83,
		["102"] = 84,
		["103"] = 84,
		["104"] = 83,
		["105"] = 82,
		["106"] = 88,
		["107"] = 89,
		["110"] = 90,
		["111"] = 91,
		["112"] = 91,
		["113"] = 91,
		["114"] = 91,
		["115"] = 91,
		["116"] = 91,
		["117"] = 88,
		["118"] = 77,
		["119"] = 70,
		["120"] = 70,
		["121"] = 70,
		["122"] = 70,
		["123"] = 70,
		["124"] = 70,
		["125"] = 70,
		["126"] = 77,
		["128"] = 77,
		["129"] = 95,
		["130"] = 103,
		["131"] = 95,
		["132"] = 103,
		["133"] = 104,
		["134"] = 105,
		["135"] = 106,
		["136"] = 106,
		["137"] = 106,
		["138"] = 105,
		["139"] = 105,
		["140"] = 105,
		["141"] = 104,
		["142"] = 111,
		["143"] = 112,
		["144"] = 113,
		["147"] = 115,
		["148"] = 116,
		["149"] = 117,
		["152"] = 119,
		["153"] = 119,
		["154"] = 121,
		["155"] = 121,
		["156"] = 121,
		["157"] = 119,
		["158"] = 119,
		["159"] = 123,
		["160"] = 124,
		["161"] = 125,
		["162"] = 126,
		["164"] = 128,
		["165"] = 129,
		["167"] = 111,
		["168"] = 133,
		["169"] = 134,
		["172"] = 135,
		["173"] = 136,
		["176"] = 138,
		["177"] = 139,
		["178"] = 140,
		["179"] = 140,
		["180"] = 140,
		["181"] = 140,
		["182"] = 140,
		["183"] = 140,
		["184"] = 140,
		["185"] = 140,
		["187"] = 143,
		["188"] = 144,
		["189"] = 145,
		["190"] = 146,
		["191"] = 147,
		["192"] = 148,
		["193"] = 148,
		["194"] = 148,
		["195"] = 148,
		["196"] = 148,
		["197"] = 148,
		["198"] = 149,
		["199"] = 149,
		["200"] = 149,
		["201"] = 149,
		["202"] = 149,
		["203"] = 149,
		["204"] = 150,
		["205"] = 150,
		["207"] = 151,
		["208"] = 151,
		["213"] = 156,
		["214"] = 156,
		["215"] = 156,
		["216"] = 156,
		["217"] = 157,
		["219"] = 160,
		["220"] = 160,
		["221"] = 160,
		["222"] = 160,
		["223"] = 133,
		["224"] = 163,
		["225"] = 164,
		["226"] = 165,
		["227"] = 166,
		["230"] = 167,
		["231"] = 168,
		["232"] = 169,
		["235"] = 171,
		["236"] = 172,
		["237"] = 172,
		["238"] = 172,
		["239"] = 173,
		["240"] = 174,
		["241"] = 174,
		["243"] = 175,
		["244"] = 175,
		["245"] = 172,
		["246"] = 172,
		["247"] = 177,
		["250"] = 178,
		["251"] = 179,
		["252"] = 180,
		["253"] = 185,
		["254"] = 185,
		["255"] = 185,
		["256"] = 185,
		["257"] = 185,
		["258"] = 163,
		["259"] = 103,
		["260"] = 95,
		["261"] = 95,
		["262"] = 95,
		["263"] = 95,
		["264"] = 95,
		["265"] = 95,
		["266"] = 95,
		["267"] = 95,
		["268"] = 103,
		["270"] = 103,
		["271"] = 189,
		["272"] = 197,
		["273"] = 189,
		["274"] = 197,
		["275"] = 198,
		["276"] = 199,
		["277"] = 198,
		["278"] = 202,
		["279"] = 203,
		["280"] = 202,
		["281"] = 197,
		["282"] = 189,
		["283"] = 189,
		["284"] = 189,
		["285"] = 189,
		["286"] = 189,
		["287"] = 189,
		["288"] = 189,
		["289"] = 189,
		["290"] = 197,
		["292"] = 197,
		["293"] = 207,
		["294"] = 215,
		["295"] = 207,
		["296"] = 215,
		["297"] = 216,
		["298"] = 217,
		["299"] = 216,
		["300"] = 220,
		["301"] = 221,
		["302"] = 220,
		["303"] = 215,
		["304"] = 207,
		["305"] = 207,
		["306"] = 207,
		["307"] = 207,
		["308"] = 207,
		["309"] = 207,
		["310"] = 207,
		["311"] = 207,
		["312"] = 215,
		["314"] = 215,
		["315"] = 225,
		["316"] = 234,
		["317"] = 225,
		["318"] = 234,
		["319"] = 235,
		["320"] = 236,
		["321"] = 235,
		["322"] = 238,
		["323"] = 239,
		["324"] = 238,
		["325"] = 234,
		["326"] = 225,
		["327"] = 225,
		["328"] = 225,
		["329"] = 225,
		["330"] = 225,
		["331"] = 225,
		["332"] = 225,
		["333"] = 225,
		["334"] = 225,
		["335"] = 234,
		["337"] = 234,
		["338"] = 243,
		["339"] = 252,
		["340"] = 243,
		["341"] = 252,
		["342"] = 253,
		["343"] = 254,
		["344"] = 253,
		["345"] = 256,
		["346"] = 257,
		["347"] = 256,
		["348"] = 252,
		["349"] = 243,
		["350"] = 243,
		["351"] = 243,
		["352"] = 243,
		["353"] = 243,
		["354"] = 243,
		["355"] = 243,
		["356"] = 243,
		["357"] = 243,
		["358"] = 252,
		["360"] = 252,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseAbility
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
local p = 4
i.trait_182 = c()
local q = i.trait_182
q.name = "trait_182"
d(q, k)
function q.prototype.Spawn(self)
	if not IsServer() then
		return
	end
	self.record = 0
	self.unlockedStage = 0
	self.completed = false
end
function q.prototype.InitializeTask(self)
	if not IsServer() then
		return
	end
	self.record = self.record or 0
	self.unlockedStage = self.unlockedStage or 0
	local r = self.completed
	if r == nil then
		r = false
	end
	self.completed = r
	self.playerID = self:GetCaster():GetPlayerOwnerID()
	self.targetCount = self:GetLevelSpecialValueFor("count", self:GetLevel() + 1)
	self:UpdateProgressDisplay()
end
function q.prototype.UpdateProgress(self, s, t)
	if not IsServer() or self.completed then
		return
	end
	self.record = math.min(self.targetCount, self.record + 1)
	if self.record < self.targetCount then
		self:UpdateProgressDisplay()
		return
	end
	local u = self:GetLevel()
	self.unlockedStage = math.max(self.unlockedStage, u)
	self:SetLevel(u + 1)
	if u >= p then
		self.completed = true
		PlayerData:getplayerData(self.playerID)
			:modifyArtifactExtraStringData(self:entindex(), "trait_task_progress", "#activity_completed")
		return
	end
	self.targetCount = self:GetLevelSpecialValueFor("count", u + 2)
	self:UpdateProgressDisplay()
end
function q.prototype.GetChaosLifesteal(self)
	local v = 0
	if self.unlockedStage >= 2 then
		v = v + self:GetSpecialValueFor("skill_steal_health")
	end
	return v
end
function q.prototype.UpdateProgressDisplay(self)
	PlayerData:getplayerData(self.playerID)
		:modifyArtifactExtraStringData(self:entindex(), "trait_task_progress", tostring(self.record))
end
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_182"
end
q = e({ l(nil) }, q)
i.trait_182 = q
i.modifier_trait_182 = c()
local w = i.modifier_trait_182
w.name = "modifier_trait_182"
d(w, n)
function w.prototype.OnCreated(self)
	self:GetAbility():InitializeTask()
end
function w.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function w.prototype.OnTraitInit(self, x)
	if x.hero:IsCustomIllusion() then
		return
	end
	x.hero:RemoveModifierByName("modifier_trait_182_buff")
	x.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_182_buff", {})
end
w = e(
	{ o(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	w
)
i.modifier_trait_182 = w
i.modifier_trait_182_buff = c()
local y = i.modifier_trait_182_buff
y.name = "modifier_trait_182_buff"
d(y, n)
function y.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
	}
end
function y.prototype.OnBattleStartBefore(self)
	local z = self:GetAbility()
	if not IsValid(z) or z.unlockedStage < 1 then
		return
	end
	local A = self:GetParent()
	local t = A:GetEnemy()
	if not IsValid(t) then
		return
	end
	local B = math.min(z:GetSpecialValueFor("extra_chaos_damage"), math.max(0, math.floor(GetChaosDamageBonus(t))))
	local C = A:AddNewModifier(A, z, "modifier_trait_182_stolen_chaos_bonus", {})
	local D = t:AddNewModifier(A, z, "modifier_trait_182_stolen_chaos_loss", {})
	if IsValid(C) then
		C:SetStackCount(B)
	end
	if IsValid(D) then
		D:SetStackCount(B)
	end
end
function y.prototype.OnCustomTakeDamage(self, E)
	if
		E.damage_type ~= EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS
		or E.damage <= 0
		or not IsValid(E.target)
		or E.target == self:GetParent()
	then
		return
	end
	local z = self:GetAbility()
	if not IsValid(z) then
		return
	end
	local F = z:GetChaosLifesteal()
	if F > 0 then
		Heal(
			self:GetParent(),
			E.damage * F * 0.01,
			z:GetAbilityName(),
			"Ability",
			false,
			HealFlags.HEAL_FLAG_ABILITY_LIFESETEAL
		)
	end
	if z.unlockedStage >= 3 then
		if not self.parent:HasModifier("modifier_trait_182_health_bonus") then
			local G = math.floor(E.target:GetMaxHealth() * z:GetSpecialValueFor("steal_max_health") * 0.01)
			if G > 0 then
				local H = z:GetSpecialValueFor("duration")
				local C = self:GetParent()
					:AddNewModifier(self:GetParent(), z, "modifier_trait_182_health_bonus", { duration = H })
				local D =
					E.target:AddNewModifier(self:GetParent(), z, "modifier_trait_182_health_loss", { duration = H })
				if IsValid(C) then
					C:SetStackCount(G)
				end
				if IsValid(D) then
					D:SetStackCount(G)
				end
			end
		end
	end
	if z.unlockedStage >= 4 and self:PRD(z:GetSpecialValueFor("chance"), "trait_182_copy") then
		self:CopyEnemyLegendaryAbility(E.target)
	end
	z:UpdateProgress(self:GetParent(), E.target)
end
function y.prototype.CopyEnemyLegendaryAbility(self, t)
	local I = self:GetParent():GetPlayerOwnerID()
	local J = t:GetPlayerOwnerID()
	if J < 0 or J == I then
		return
	end
	local K = PlayerData:getHero(I)
	local L = PlayerData:getHero(J)
	if not K or not L then
		return
	end
	local M = K:getAbilityUpgradeData()
	local N = g(f(L:getAbilityUpgradeData()), function(O, P)
		local Q = KeyValues.AbilityUpgradesKvs[P]
		if not Q or Q.rarity ~= "sr" then
			return false
		end
		local R = M[P]
		return (R and R.level or 0) < SECT_ABILITY_LEVEL.sr
	end)
	if #N <= 0 then
		return
	end
	local P = GetRandomElement(N)
	K:learnAbility(P, true)
	Notification:combatToPlayer(
		I,
		{
			message = "notify_artifact_ability_sr",
			string_itemname_artifact = "DOTA_Tooltip_ability_trait_182",
			string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. P,
		}
	)
	PlayerData:getplayerData(I):addArtifactAbilities(self:GetAbility():entindex(), P, true)
end
y = e(
	{
		o(
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
	y
)
i.modifier_trait_182_buff = y
i.modifier_trait_182_stolen_chaos_bonus = c()
local S = i.modifier_trait_182_stolen_chaos_bonus
S.name = "modifier_trait_182_stolen_chaos_bonus"
d(S, n)
function S.prototype.EOM_GetModifierChaosDamageBonus(self)
	return self:GetStackCount()
end
function S.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_DAMAGE_BONUS }
end
S = e(
	{
		o(
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
	S
)
i.modifier_trait_182_stolen_chaos_bonus = S
i.modifier_trait_182_stolen_chaos_loss = c()
local T = i.modifier_trait_182_stolen_chaos_loss
T.name = "modifier_trait_182_stolen_chaos_loss"
d(T, n)
function T.prototype.EOM_GetModifierChaosDamageBonus(self)
	return -self:GetStackCount()
end
function T.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_DAMAGE_BONUS }
end
T = e(
	{
		o(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	T
)
i.modifier_trait_182_stolen_chaos_loss = T
i.modifier_trait_182_health_bonus = c()
local U = i.modifier_trait_182_health_bonus
U.name = "modifier_trait_182_health_bonus"
d(U, n)
function U.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function U.prototype.EOM_GetModifierHealthBonus(self)
	return self:GetStackCount()
end
U = e(
	{
		o(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	U
)
i.modifier_trait_182_health_bonus = U
i.modifier_trait_182_health_loss = c()
local V = i.modifier_trait_182_health_loss
V.name = "modifier_trait_182_health_loss"
d(V, n)
function V.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function V.prototype.EOM_GetModifierHealthBonus(self)
	return -self:GetStackCount()
end
V = e(
	{
		o(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	V
)
i.modifier_trait_182_health_loss = V
return i