--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
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
		["17"] = 5,
		["18"] = 6,
		["19"] = 9,
		["20"] = 10,
		["21"] = 9,
		["22"] = 10,
		["23"] = 17,
		["24"] = 18,
		["27"] = 19,
		["28"] = 20,
		["29"] = 21,
		["30"] = 17,
		["31"] = 24,
		["32"] = 25,
		["35"] = 26,
		["36"] = 27,
		["37"] = 28,
		["38"] = 28,
		["39"] = 28,
		["41"] = 28,
		["42"] = 29,
		["43"] = 30,
		["44"] = 30,
		["45"] = 30,
		["46"] = 30,
		["47"] = 30,
		["48"] = 30,
		["49"] = 30,
		["50"] = 31,
		["51"] = 24,
		["52"] = 34,
		["53"] = 35,
		["56"] = 36,
		["57"] = 37,
		["58"] = 38,
		["61"] = 42,
		["62"] = 43,
		["63"] = 44,
		["64"] = 45,
		["65"] = 46,
		["66"] = 47,
		["67"] = 47,
		["68"] = 47,
		["69"] = 47,
		["70"] = 47,
		["73"] = 51,
		["74"] = 52,
		["75"] = 53,
		["76"] = 34,
		["77"] = 56,
		["78"] = 57,
		["79"] = 58,
		["80"] = 59,
		["82"] = 61,
		["83"] = 62,
		["85"] = 64,
		["86"] = 56,
		["87"] = 67,
		["88"] = 68,
		["89"] = 68,
		["90"] = 68,
		["91"] = 68,
		["92"] = 68,
		["93"] = 67,
		["94"] = 71,
		["95"] = 72,
		["98"] = 73,
		["99"] = 74,
		["100"] = 74,
		["101"] = 74,
		["102"] = 74,
		["103"] = 74,
		["104"] = 74,
		["105"] = 74,
		["106"] = 75,
		["109"] = 77,
		["110"] = 78,
		["111"] = 79,
		["112"] = 79,
		["113"] = 79,
		["114"] = 79,
		["115"] = 79,
		["116"] = 81,
		["117"] = 82,
		["118"] = 83,
		["119"] = 84,
		["120"] = 85,
		["121"] = 85,
		["122"] = 85,
		["123"] = 85,
		["124"] = 85,
		["126"] = 87,
		["127"] = 87,
		["128"] = 87,
		["129"] = 87,
		["130"] = 87,
		["131"] = 87,
		["132"] = 88,
		["133"] = 89,
		["136"] = 71,
		["137"] = 94,
		["138"] = 95,
		["141"] = 96,
		["142"] = 96,
		["143"] = 96,
		["144"] = 96,
		["145"] = 96,
		["146"] = 96,
		["147"] = 97,
		["148"] = 98,
		["150"] = 94,
		["151"] = 102,
		["152"] = 103,
		["153"] = 102,
		["154"] = 10,
		["155"] = 9,
		["156"] = 10,
		["158"] = 10,
		["159"] = 107,
		["160"] = 114,
		["161"] = 107,
		["162"] = 114,
		["163"] = 115,
		["164"] = 116,
		["165"] = 115,
		["166"] = 119,
		["167"] = 120,
		["168"] = 121,
		["169"] = 121,
		["170"] = 120,
		["171"] = 119,
		["172"] = 125,
		["173"] = 126,
		["176"] = 127,
		["177"] = 128,
		["178"] = 128,
		["179"] = 128,
		["180"] = 128,
		["181"] = 128,
		["182"] = 128,
		["183"] = 125,
		["184"] = 114,
		["185"] = 107,
		["186"] = 107,
		["187"] = 107,
		["188"] = 107,
		["189"] = 107,
		["190"] = 107,
		["191"] = 107,
		["192"] = 114,
		["194"] = 114,
		["195"] = 132,
		["196"] = 140,
		["197"] = 132,
		["198"] = 140,
		["199"] = 141,
		["200"] = 142,
		["201"] = 143,
		["202"] = 143,
		["203"] = 142,
		["204"] = 141,
		["205"] = 147,
		["206"] = 148,
		["209"] = 149,
		["210"] = 150,
		["213"] = 152,
		["214"] = 153,
		["215"] = 154,
		["216"] = 154,
		["217"] = 154,
		["218"] = 154,
		["219"] = 154,
		["220"] = 154,
		["221"] = 154,
		["222"] = 154,
		["224"] = 157,
		["225"] = 158,
		["226"] = 159,
		["227"] = 160,
		["228"] = 161,
		["229"] = 161,
		["230"] = 161,
		["231"] = 161,
		["232"] = 161,
		["233"] = 161,
		["234"] = 162,
		["235"] = 162,
		["236"] = 162,
		["237"] = 162,
		["238"] = 162,
		["239"] = 162,
		["240"] = 163,
		["241"] = 163,
		["243"] = 164,
		["244"] = 164,
		["248"] = 168,
		["249"] = 168,
		["250"] = 168,
		["251"] = 168,
		["252"] = 169,
		["254"] = 172,
		["255"] = 172,
		["256"] = 172,
		["257"] = 172,
		["258"] = 147,
		["259"] = 175,
		["260"] = 176,
		["261"] = 177,
		["262"] = 178,
		["265"] = 179,
		["266"] = 180,
		["267"] = 181,
		["270"] = 183,
		["271"] = 184,
		["272"] = 184,
		["273"] = 184,
		["274"] = 185,
		["275"] = 186,
		["276"] = 186,
		["278"] = 187,
		["279"] = 187,
		["280"] = 184,
		["281"] = 184,
		["282"] = 189,
		["285"] = 190,
		["286"] = 191,
		["287"] = 192,
		["288"] = 197,
		["289"] = 197,
		["290"] = 197,
		["291"] = 197,
		["292"] = 197,
		["293"] = 175,
		["294"] = 140,
		["295"] = 132,
		["296"] = 132,
		["297"] = 132,
		["298"] = 132,
		["299"] = 132,
		["300"] = 132,
		["301"] = 132,
		["302"] = 132,
		["303"] = 140,
		["305"] = 140,
		["306"] = 201,
		["307"] = 209,
		["308"] = 201,
		["309"] = 209,
		["310"] = 210,
		["311"] = 211,
		["312"] = 210,
		["313"] = 214,
		["314"] = 215,
		["315"] = 214,
		["316"] = 209,
		["317"] = 201,
		["318"] = 201,
		["319"] = 201,
		["320"] = 201,
		["321"] = 201,
		["322"] = 201,
		["323"] = 201,
		["324"] = 201,
		["325"] = 209,
		["327"] = 209,
		["328"] = 219,
		["329"] = 227,
		["330"] = 219,
		["331"] = 227,
		["332"] = 228,
		["333"] = 229,
		["334"] = 228,
		["335"] = 232,
		["336"] = 233,
		["337"] = 232,
		["338"] = 227,
		["339"] = 219,
		["340"] = 219,
		["341"] = 219,
		["342"] = 219,
		["343"] = 219,
		["344"] = 219,
		["345"] = 219,
		["346"] = 219,
		["347"] = 227,
		["349"] = 227,
		["350"] = 237,
		["351"] = 246,
		["352"] = 237,
		["353"] = 246,
		["354"] = 247,
		["355"] = 248,
		["356"] = 247,
		["357"] = 251,
		["358"] = 252,
		["359"] = 251,
		["360"] = 246,
		["361"] = 237,
		["362"] = 237,
		["363"] = 237,
		["364"] = 237,
		["365"] = 237,
		["366"] = 237,
		["367"] = 237,
		["368"] = 237,
		["369"] = 237,
		["370"] = 246,
		["372"] = 246,
		["373"] = 256,
		["374"] = 265,
		["375"] = 256,
		["376"] = 265,
		["377"] = 266,
		["378"] = 267,
		["379"] = 266,
		["380"] = 270,
		["381"] = 271,
		["382"] = 270,
		["383"] = 265,
		["384"] = 256,
		["385"] = 256,
		["386"] = 256,
		["387"] = 256,
		["388"] = 256,
		["389"] = 256,
		["390"] = 256,
		["391"] = 256,
		["392"] = 256,
		["393"] = 265,
		["395"] = 265,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseAbility
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
local p = 5
local q = "modifier_trait_182_stolen_chaos_bonus"
local r = "modifier_trait_182_stolen_chaos_loss"
i.trait_182 = c()
local s = i.trait_182
s.name = "trait_182"
d(s, k)
function s.prototype.Spawn(self)
	if not IsServer() then
		return
	end
	self.record = 0
	self.unlockedStage = 0
	self.completed = false
end
function s.prototype.InitializeTask(self)
	if not IsServer() then
		return
	end
	self.record = self.record or 0
	self.unlockedStage = self.unlockedStage or 0
	local t = self.completed
	if t == nil then
		t = false
	end
	self.completed = t
	self.playerID = self:GetCaster():GetPlayerOwnerID()
	self.targetCount = self:GetLevelSpecialValueFor("count", math.max(0, self:GetLevel() - 1))
	self:UpdateProgressDisplay()
end
function s.prototype.UpdateProgress(self, u, v)
	if not IsServer() or self.completed then
		return
	end
	self.record = math.min(self.targetCount, self.record + 1)
	if self.record < self.targetCount then
		self:UpdateProgressDisplay()
		return
	end
	local w = self:GetLevel()
	self.unlockedStage = math.max(self.unlockedStage, w)
	self:GrantStageReward(w, u, v)
	if w >= p then
		self.completed = true
		PlayerData:getplayerData(self.playerID)
			:modifyArtifactExtraStringData(self:entindex(), "trait_task_progress", "#activity_completed")
		return
	end
	self:SetLevel(w + 1)
	self.targetCount = self:GetLevelSpecialValueFor("count", w)
	self:UpdateProgressDisplay()
end
function s.prototype.GetChaosLifesteal(self)
	local x = 0
	if self.unlockedStage >= 2 then
		x = x + self:GetSpecialValueFor("skill_steal_health")
	end
	if self.unlockedStage >= 5 then
		x = x + self:GetSpecialValueFor("final_skill_steal_health")
	end
	return x
end
function s.prototype.UpdateProgressDisplay(self)
	PlayerData:getplayerData(self.playerID)
		:modifyArtifactExtraStringData(self:entindex(), "trait_task_progress", tostring(self.record))
end
function s.prototype.GrantStageReward(self, w, u, v)
	if w ~= 1 or not IsValid(v) then
		return
	end
	local y = self:GetSpecialValueFor("extra_chaos_damage")
	local z = math.min(y, math.max(0, math.floor(GetChaosDamageBonus(v))))
	if z <= 0 then
		return
	end
	local A = PlayerData:getplayerData(self.playerID)
	A:modifyPermanentBuffStackCount(q, z)
	self:SetPermanentModifierStack(u, q, A:GetPermanentBuffStackCount(q))
	local B = v:GetPlayerOwnerID()
	local C = B >= 0 and PlayerData:getplayerData(B) or nil
	if C then
		C:modifyPermanentBuffStackCount(r, z)
		self:SetPermanentModifierStack(v, r, C:GetPermanentBuffStackCount(r))
	else
		local D = v:AddNewModifier(self:GetCaster(), self, r, {})
		if IsValid(D) then
			D:SetStackCount(D:GetStackCount() + z)
		end
	end
end
function s.prototype.SetPermanentModifierStack(self, E, F, G)
	if not IsValid(E) then
		return
	end
	local D = E:FindModifierByName(F) or E:AddNewModifier(E, E:GetDummyAbility(), F, {})
	if IsValid(D) then
		D:SetStackCount(G)
	end
end
function s.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_182"
end
s = e({ l(nil) }, s)
i.trait_182 = s
i.modifier_trait_182 = c()
local H = i.modifier_trait_182
H.name = "modifier_trait_182"
d(H, n)
function H.prototype.OnCreated(self)
	self:GetAbility():InitializeTask()
end
function H.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function H.prototype.OnTraitInit(self, I)
	if I.hero:IsCustomIllusion() then
		return
	end
	I.hero:RemoveModifierByName("modifier_trait_182_buff")
	I.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_182_buff", {})
end
H = e(
	{ o(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	H
)
i.modifier_trait_182 = H
i.modifier_trait_182_buff = c()
local J = i.modifier_trait_182_buff
J.name = "modifier_trait_182_buff"
d(J, n)
function J.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function J.prototype.OnCustomTakeDamage(self, K)
	if
		K.damage_type ~= EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS
		or K.damage <= 0
		or not IsValid(K.target)
		or K.target == self:GetParent()
	then
		return
	end
	local L = self:GetAbility()
	if not IsValid(L) then
		return
	end
	local M = L:GetChaosLifesteal()
	if M > 0 then
		Heal(
			self:GetParent(),
			K.damage * M * 0.01,
			L:GetAbilityName(),
			"Ability",
			false,
			HealFlags.HEAL_FLAG_ABILITY_LIFESETEAL
		)
	end
	if L.unlockedStage >= 3 then
		local N = math.floor(K.target:GetMaxHealth() * L:GetSpecialValueFor("steal_max_health") * 0.01)
		if N > 0 then
			local O = L:GetSpecialValueFor("duration")
			local P = self:GetParent()
				:AddNewModifier(self:GetParent(), L, "modifier_trait_182_health_bonus", { duration = O })
			local Q = K.target:AddNewModifier(self:GetParent(), L, "modifier_trait_182_health_loss", { duration = O })
			if IsValid(P) then
				P:SetStackCount(N)
			end
			if IsValid(Q) then
				Q:SetStackCount(N)
			end
		end
	end
	if L.unlockedStage >= 4 and self:PRD(L:GetSpecialValueFor("chance"), "trait_182_copy") then
		self:CopyEnemyLegendaryAbility(K.target)
	end
	L:UpdateProgress(self:GetParent(), K.target)
end
function J.prototype.CopyEnemyLegendaryAbility(self, v)
	local R = self:GetParent():GetPlayerOwnerID()
	local B = v:GetPlayerOwnerID()
	if B < 0 or B == R then
		return
	end
	local S = PlayerData:getHero(R)
	local T = PlayerData:getHero(B)
	if not S or not T then
		return
	end
	local U = S:getAbilityUpgradeData()
	local V = g(f(T:getAbilityUpgradeData()), function(W, X)
		local Y = KeyValues.AbilityUpgradesKvs[X]
		if not Y or Y.rarity ~= "sr" then
			return false
		end
		local Z = U[X]
		return (Z and Z.level or 0) < SECT_ABILITY_LEVEL.sr
	end)
	if #V <= 0 then
		return
	end
	local X = GetRandomElement(V)
	S:learnAbility(X, true)
	Notification:combatToPlayer(
		R,
		{
			message = "notify_artifact_ability_sr",
			string_itemname_artifact = "DOTA_Tooltip_ability_trait_182",
			string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. X,
		}
	)
	PlayerData:getplayerData(R):addArtifactAbilities(self:GetAbility():entindex(), X, true)
end
J = e(
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
	J
)
i.modifier_trait_182_buff = J
i.modifier_trait_182_stolen_chaos_bonus = c()
local _ = i.modifier_trait_182_stolen_chaos_bonus
_.name = "modifier_trait_182_stolen_chaos_bonus"
d(_, n)
function _.prototype.EOM_GetModifierChaosDamageBonus(self)
	return self:GetStackCount()
end
function _.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_DAMAGE_BONUS }
end
_ = e(
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
	_
)
i.modifier_trait_182_stolen_chaos_bonus = _
i.modifier_trait_182_stolen_chaos_loss = c()
local a0 = i.modifier_trait_182_stolen_chaos_loss
a0.name = "modifier_trait_182_stolen_chaos_loss"
d(a0, n)
function a0.prototype.EOM_GetModifierChaosDamageBonus(self)
	return -self:GetStackCount()
end
function a0.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_DAMAGE_BONUS }
end
a0 = e(
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
	a0
)
i.modifier_trait_182_stolen_chaos_loss = a0
i.modifier_trait_182_health_bonus = c()
local a1 = i.modifier_trait_182_health_bonus
a1.name = "modifier_trait_182_health_bonus"
d(a1, n)
function a1.prototype.EOM_GetModifierHealthBonus(self)
	return self:GetStackCount()
end
function a1.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
a1 = e(
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
	a1
)
i.modifier_trait_182_health_bonus = a1
i.modifier_trait_182_health_loss = c()
local a2 = i.modifier_trait_182_health_loss
a2.name = "modifier_trait_182_health_loss"
d(a2, n)
function a2.prototype.EOM_GetModifierHealthBonus(self)
	return -self:GetStackCount()
end
function a2.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
a2 = e(
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
	a2
)
i.modifier_trait_182_health_loss = a2
return i