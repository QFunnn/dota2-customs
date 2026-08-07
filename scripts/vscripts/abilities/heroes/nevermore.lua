--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/nevermore"
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
		["14"] = 3,
		["15"] = 3,
		["16"] = 3,
		["17"] = 5,
		["18"] = 6,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 7,
		["24"] = 6,
		["25"] = 5,
		["26"] = 6,
		["28"] = 6,
		["29"] = 12,
		["30"] = 20,
		["31"] = 12,
		["32"] = 20,
		["33"] = 36,
		["34"] = 37,
		["35"] = 38,
		["36"] = 39,
		["37"] = 40,
		["38"] = 41,
		["39"] = 42,
		["40"] = 43,
		["41"] = 44,
		["42"] = 45,
		["43"] = 46,
		["44"] = 47,
		["45"] = 48,
		["46"] = 50,
		["47"] = 51,
		["48"] = 36,
		["49"] = 53,
		["50"] = 54,
		["51"] = 54,
		["52"] = 54,
		["53"] = 57,
		["54"] = 57,
		["55"] = 57,
		["56"] = 54,
		["57"] = 58,
		["58"] = 58,
		["59"] = 58,
		["60"] = 54,
		["61"] = 54,
		["62"] = 53,
		["63"] = 61,
		["64"] = 62,
		["65"] = 61,
		["66"] = 69,
		["67"] = 70,
		["68"] = 69,
		["69"] = 72,
		["70"] = 73,
		["71"] = 72,
		["72"] = 75,
		["73"] = 76,
		["74"] = 75,
		["75"] = 78,
		["76"] = 79,
		["77"] = 78,
		["78"] = 81,
		["79"] = 82,
		["80"] = 82,
		["81"] = 82,
		["82"] = 82,
		["83"] = 82,
		["84"] = 82,
		["86"] = 82,
		["87"] = 83,
		["88"] = 83,
		["89"] = 83,
		["90"] = 83,
		["91"] = 83,
		["92"] = 81,
		["93"] = 85,
		["94"] = 86,
		["95"] = 86,
		["96"] = 86,
		["97"] = 86,
		["98"] = 86,
		["99"] = 86,
		["101"] = 86,
		["102"] = 87,
		["103"] = 88,
		["104"] = 89,
		["105"] = 90,
		["108"] = 93,
		["109"] = 85,
		["110"] = 96,
		["111"] = 97,
		["112"] = 98,
		["113"] = 98,
		["114"] = 98,
		["115"] = 98,
		["116"] = 99,
		["117"] = 99,
		["118"] = 99,
		["119"] = 99,
		["120"] = 99,
		["122"] = 96,
		["123"] = 102,
		["124"] = 103,
		["125"] = 104,
		["126"] = 105,
		["127"] = 102,
		["128"] = 107,
		["129"] = 108,
		["130"] = 109,
		["131"] = 110,
		["132"] = 107,
		["133"] = 112,
		["134"] = 113,
		["137"] = 116,
		["138"] = 117,
		["139"] = 118,
		["140"] = 119,
		["141"] = 120,
		["142"] = 121,
		["144"] = 112,
		["145"] = 124,
		["146"] = 126,
		["147"] = 127,
		["148"] = 128,
		["150"] = 124,
		["151"] = 132,
		["152"] = 133,
		["153"] = 134,
		["156"] = 137,
		["157"] = 138,
		["158"] = 139,
		["159"] = 140,
		["160"] = 141,
		["161"] = 142,
		["162"] = 143,
		["163"] = 144,
		["164"] = 145,
		["165"] = 146,
		["166"] = 146,
		["167"] = 146,
		["168"] = 146,
		["169"] = 146,
		["170"] = 147,
		["171"] = 148,
		["173"] = 149,
		["174"] = 149,
		["175"] = 150,
		["176"] = 150,
		["177"] = 150,
		["178"] = 150,
		["179"] = 150,
		["180"] = 151,
		["181"] = 152,
		["182"] = 153,
		["183"] = 154,
		["184"] = 154,
		["185"] = 154,
		["186"] = 154,
		["187"] = 154,
		["188"] = 149,
		["191"] = 157,
		["192"] = 157,
		["193"] = 157,
		["194"] = 157,
		["195"] = 157,
		["196"] = 157,
		["197"] = 158,
		["198"] = 159,
		["199"] = 160,
		["200"] = 160,
		["201"] = 160,
		["202"] = 160,
		["203"] = 161,
		["204"] = 162,
		["206"] = 160,
		["207"] = 160,
		["210"] = 132,
		["211"] = 20,
		["212"] = 12,
		["213"] = 12,
		["214"] = 12,
		["215"] = 12,
		["216"] = 12,
		["217"] = 12,
		["218"] = 12,
		["219"] = 12,
		["220"] = 20,
		["222"] = 20,
		["223"] = 171,
		["224"] = 172,
		["225"] = 171,
		["226"] = 172,
		["228"] = 172,
		["229"] = 173,
		["230"] = 171,
		["231"] = 175,
		["232"] = 176,
		["233"] = 175,
		["234"] = 179,
		["235"] = 180,
		["236"] = 181,
		["237"] = 183,
		["238"] = 184,
		["239"] = 185,
		["240"] = 186,
		["241"] = 187,
		["242"] = 188,
		["244"] = 190,
		["245"] = 190,
		["246"] = 190,
		["247"] = 191,
		["248"] = 192,
		["249"] = 193,
		["250"] = 193,
		["251"] = 193,
		["252"] = 193,
		["253"] = 193,
		["254"] = 194,
		["255"] = 195,
		["256"] = 195,
		["257"] = 195,
		["258"] = 195,
		["259"] = 195,
		["260"] = 195,
		["261"] = 197,
		["262"] = 199,
		["263"] = 200,
		["264"] = 201,
		["267"] = 190,
		["268"] = 190,
		["269"] = 179,
		["270"] = 206,
		["271"] = 207,
		["272"] = 208,
		["273"] = 209,
		["274"] = 210,
		["275"] = 211,
		["276"] = 212,
		["278"] = 214,
		["279"] = 206,
		["280"] = 172,
		["281"] = 171,
		["282"] = 172,
		["284"] = 172,
		["285"] = 218,
		["286"] = 226,
		["287"] = 218,
		["288"] = 226,
		["289"] = 228,
		["290"] = 229,
		["291"] = 230,
		["292"] = 230,
		["293"] = 229,
		["294"] = 228,
		["295"] = 234,
		["296"] = 235,
		["297"] = 236,
		["298"] = 237,
		["299"] = 239,
		["300"] = 241,
		["301"] = 244,
		["302"] = 245,
		["303"] = 245,
		["304"] = 245,
		["305"] = 245,
		["306"] = 245,
		["307"] = 245,
		["308"] = 245,
		["309"] = 245,
		["312"] = 234,
		["313"] = 226,
		["314"] = 218,
		["315"] = 218,
		["316"] = 218,
		["317"] = 218,
		["318"] = 218,
		["319"] = 218,
		["320"] = 218,
		["321"] = 218,
		["322"] = 226,
		["324"] = 226,
		["325"] = 254,
		["326"] = 262,
		["327"] = 254,
		["328"] = 262,
		["329"] = 263,
		["330"] = 264,
		["331"] = 265,
		["333"] = 263,
		["334"] = 268,
		["335"] = 269,
		["336"] = 270,
		["338"] = 268,
		["339"] = 273,
		["340"] = 274,
		["341"] = 273,
		["342"] = 276,
		["343"] = 277,
		["344"] = 276,
		["345"] = 262,
		["346"] = 254,
		["347"] = 254,
		["348"] = 254,
		["349"] = 254,
		["350"] = 254,
		["351"] = 254,
		["352"] = 254,
		["353"] = 254,
		["354"] = 262,
		["356"] = 262,
		["358"] = 286,
		["359"] = 287,
		["360"] = 286,
		["361"] = 287,
		["362"] = 288,
		["363"] = 289,
		["364"] = 288,
		["365"] = 287,
		["366"] = 286,
		["367"] = 287,
		["369"] = 287,
		["370"] = 292,
		["371"] = 300,
		["372"] = 292,
		["373"] = 300,
		["375"] = 300,
		["376"] = 302,
		["377"] = 292,
		["378"] = 303,
		["379"] = 304,
		["380"] = 303,
		["381"] = 306,
		["382"] = 307,
		["383"] = 308,
		["384"] = 308,
		["385"] = 307,
		["386"] = 306,
		["387"] = 311,
		["388"] = 312,
		["389"] = 313,
		["390"] = 315,
		["391"] = 316,
		["393"] = 311,
		["394"] = 300,
		["395"] = 292,
		["396"] = 292,
		["397"] = 292,
		["398"] = 292,
		["399"] = 292,
		["400"] = 292,
		["401"] = 292,
		["402"] = 292,
		["403"] = 300,
		["405"] = 300,
		["406"] = 333,
		["407"] = 334,
		["408"] = 333,
		["409"] = 334,
		["410"] = 335,
		["411"] = 336,
		["412"] = 335,
		["413"] = 334,
		["414"] = 333,
		["415"] = 334,
		["417"] = 334,
		["418"] = 339,
		["419"] = 347,
		["420"] = 339,
		["421"] = 347,
		["422"] = 349,
		["423"] = 350,
		["424"] = 349,
		["425"] = 352,
		["426"] = 353,
		["427"] = 354,
		["428"] = 354,
		["429"] = 353,
		["430"] = 352,
		["431"] = 357,
		["432"] = 358,
		["433"] = 359,
		["435"] = 357,
		["436"] = 347,
		["437"] = 339,
		["438"] = 339,
		["439"] = 339,
		["440"] = 339,
		["441"] = 339,
		["442"] = 339,
		["443"] = 339,
		["444"] = 339,
		["445"] = 347,
		["447"] = 347,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = require("abilities.ability_ai")
local o = n.BaseAbilityAI
local p = n.registerAbilityAI
g.nevermore_talent = c()
local q = g.nevermore_talent
q.name = "nevermore_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_nevermore_talent"
end
q = e({ j(nil) }, q)
g.nevermore_talent = q
g.modifier_nevermore_talent = c()
local r = g.modifier_nevermore_talent
r.name = "modifier_nevermore_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.win_stack = self:GetAbilitySpecialValueFor("win_stack")
	self.lose_stack = self:GetAbilitySpecialValueFor("lose_stack")
	self.attack = self:GetAbilitySpecialValueFor("attack")
	local s = self:GetAbilityTalentValue("nevermore_talent_9", "health_pct")
	self.tl9_count = self:GetAbilityTalentValue("nevermore_talent_9", "count")
	self.threshold = s > 0 and s or self:GetAbilitySpecialValueFor("threshold")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.amp_per_stack = self:GetAbilitySpecialValueFor("amp_per_stack")
	self.ulti_power = self:GetAbilityTalentValue("nevermore_talent_4", "ulti_power")
	self.mana_regen = self:GetAbilityTalentValue("nevermore_talent_5", "mana_regen")
	self.attack_stack = self:GetAbilityTalentValue("nevermore_talent_6", "attack_stack")
	self.attack_speed_stack = self:GetAbilityTalentValue("nevermore_talent_6", "attack_speed_stack")
	self.s_round = self:GetAbilityTalentValue("nevermore_shard", "round")
	self.s_count = self:GetAbilityTalentValue("nevermore_shard", "count")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function r.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
	}
end
function r.prototype.EOM_GetModifierAttackDamageBonus(self)
	return self:GetStackCount() * (self.attack + self.attack_stack)
end
function r.prototype.EOM_GetModifierAttackSpeedBonus(self)
	return self:GetStackCount() * self.attack_speed_stack
end
function r.prototype.EOM_GetModifierUltiPower(self)
	return self.ulti_power
end
function r.prototype.EOM_GetModifierManaRegenBonus(self, t)
	return self.mana_regen
end
function r.prototype.SaveStack(self, u)
	local v = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "nevermore_talent")
	if v == nil then
		v = 0
	end
	local w = v
	PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), "nevermore_talent", w + u)
end
function r.prototype.LoadStack(self)
	local x = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "nevermore_talent")
	if x == nil then
		x = 0
	end
	local w = x
	if self.s_round > 0 then
		local y = PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
		if y then
			w = w + math.floor(y.totalLose / self.s_round) * self.s_count
		end
	end
	return w
end
function r.prototype.Init(self)
	local z = self:GetParent()
	if PlayerData:loadData(z:GetPlayerOwnerID(), "nevermore_talent") == nil then
		PlayerData:saveData(z:GetPlayerOwnerID(), "nevermore_talent", 0)
	end
end
function r.prototype.OnPrepare(self)
	self:Init()
	self:SetStackCount(self:LoadStack())
	self.trigger = false
end
function r.prototype.OnBattleStart(self, t)
	self:Init()
	self:SetStackCount(self:LoadStack())
	self.trigger = false
end
function r.prototype.OnBattleEnd(self, t)
	if t.isNeutral ~= nil then
		return
	end
	if self:GetParent():GetPlayerOwnerID() == t.winPlayerID then
		self:IncrementStackCount(self.win_stack)
		self:SaveStack(self.win_stack)
	elseif self:GetParent():GetPlayerOwnerID() == t.losePlayerID then
		self:IncrementStackCount(self.lose_stack)
		self:SaveStack(self.lose_stack)
	end
end
function r.prototype.OnCustomTakeDamage(self, A)
	if A.target:GetHealthPercent() <= self.threshold and not self.trigger then
		self:RequiemOfSouls()
		self.trigger = true
	end
end
function r.prototype.RequiemOfSouls(self)
	local B = self:GetStackCount()
	if B <= 0 then
		return
	end
	local z = self:GetParent()
	local C = z:GetEnemy()
	if IsInjurable(C) then
		local D = C:GetAbsOrigin()
		local E = 700
		local F = 700
		local G = math.min(B, 25)
		local H = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_nevermore/nevermore_requiemofsouls.vpcf",
			PATTACH_CUSTOMORIGIN,
			z
		)
		ParticleManager:SetParticleControl(H, 0, D)
		ParticleManager:SetParticleControl(H, 1, Vector(G, 0, 0))
		z:EmitSound("Hero_Nevermore.RequiemOfSouls")
		local I = vec3_left
		do
			local J = 0
			while J < G do
				local K = RotatePosition(vec3_zero, QAngle(0, J * 360 / G, 0), I)
				local H = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_line.vpcf",
					PATTACH_CUSTOMORIGIN,
					z
				)
				ParticleManager:SetParticleControl(H, 0, D)
				ParticleManager:SetParticleControl(H, 1, K * E)
				ParticleManager:SetParticleControl(H, 2, Vector(0, F / E, 0))
				J = J + 1
			end
		end
		z:DealDamage(
			C,
			self:GetAbility(),
			self:GetAbilitySpecialValueFor("damage") * (1 + B * self.amp_per_stack / 100),
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
		)
		if self.tl9_count > 0 then
			local L = z:FindAbilityByName("nevermore_ult")
			ForWithInterval(0.6, self.tl9_count, function()
				if IsValid(L) then
					L:OnSpellStart()
				end
			end)
		end
	end
end
r = e(
	{
		m(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	r
)
g.modifier_nevermore_talent = r
g.nevermore_ult = c()
local M = g.nevermore_ult
M.name = "nevermore_ult"
d(M, o)
function M.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.gestureRecord = 1
end
function M.prototype.GetIntrinsicModifierName(self)
	return "modifier_nevermore_ult"
end
function M.prototype.OnSpellStart(self)
	local N = self:GetCaster()
	local C = N:GetEnemy()
	if self.gestureRecord == 1 then
		N:StartGesture(ACT_DOTA_RAZE_1)
	elseif self.gestureRecord == 2 then
		N:StartGesture(ACT_DOTA_RAZE_2)
	elseif self.gestureRecord == 3 then
		N:StartGesture(ACT_DOTA_RAZE_3)
	end
	self:GameTimer(0.55, function()
		if IsInjurable(C) then
			local H = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf",
				PATTACH_CUSTOMORIGIN,
				N
			)
			ParticleManager:SetParticleControl(H, 0, C:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(H)
			N:DealDamage(C, self, self:GetDamage(C), EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			N:EmitSound("Hero_Nevermore.Shadowraze")
			self.gestureRecord = self.gestureRecord + 1
			if self.gestureRecord > 3 then
				self.gestureRecord = 1
			end
		end
	end)
end
function M.prototype.GetDamage(self, C)
	local N = self:GetCaster()
	local O = self:GetSpecialValueFor("base_damage")
		+ self:GetTalentValue("nevermore_talent_8", "base_damage")
			* N:GetModifierStackCount("modifier_nevermore_talent", N)
	local P = self:GetSpecialValueFor("damage_stack") + self:GetTalentValue("nevermore_talent_7", "stack_damage")
	local Q = O + P * C:GetModifierStackCount("modifier_nevermore_ult_debuff", N)
	if N:HasModifier("modifier_nevermore_talent_1") then
		Q = Q + N:GetModifierStackCount("modifier_nevermore_talent_1", N)
	end
	return Q
end
M = e({ p(nil) }, M)
g.nevermore_ult = M
g.modifier_nevermore_ult = c()
local R = g.modifier_nevermore_ult
R.name = "modifier_nevermore_ult"
d(R, l)
function R.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function R.prototype.OnCustomTakeDamage(self, A)
	local S = self:GetAbility()
	local N = self:GetCaster()
	local C = A.target
	if A.ability == S and A.damage_category == DOTA_DAMAGE_CATEGORY_SPELL then
		C:AddNewModifier(N, S, "modifier_nevermore_ult_debuff", {})
		if S:HasTalent("nevermore_talent_2") then
			DamageSystem:performAttack(N, C, { is_crit = true, ability = self:GetAbility() })
		end
	end
end
R = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	R
)
g.modifier_nevermore_ult = R
g.modifier_nevermore_ult_debuff = c()
local T = g.modifier_nevermore_ult_debuff
T.name = "modifier_nevermore_ult_debuff"
d(T, l)
function T.prototype.OnCreated(self, t)
	if IsServer() then
		self:SetStackCount(1)
	end
end
function T.prototype.OnRefresh(self, t)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function T.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_nevermore/nevermore_shadowraze_debuff.vpcf"
end
function T.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
T = e(
	{
		m(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	T
)
g.modifier_nevermore_ult_debuff = T
g.nevermore_talent_3 = c()
local U = g.nevermore_talent_3
U.name = "nevermore_talent_3"
d(U, i)
function U.prototype.GetIntrinsicModifierName(self)
	return "modifier_nevermore_talent_3"
end
U = e({ j(nil) }, U)
g.nevermore_talent_3 = U
g.modifier_nevermore_talent_3 = c()
local V = g.modifier_nevermore_talent_3
V.name = "modifier_nevermore_talent_3"
d(V, l)
function V.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.record = 0
end
function V.prototype.GetAbilitySpecialValue(self)
	self.attack_threshold = self:GetAbilityTalentValue("nevermore_talent_3", "attack_threshold")
end
function V.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function V.prototype.OnCustomAttackLanded(self, A)
	self.record = self.record + 1
	if self.attack_threshold > 0 and self.record >= self.attack_threshold then
		self:GetParent():FindAbilityByName("nevermore_ult"):OnSpellStart()
		self.record = 0
	end
end
V = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	V
)
g.modifier_nevermore_talent_3 = V
g.nevermore_talent_1 = c()
local W = g.nevermore_talent_1
W.name = "nevermore_talent_1"
d(W, i)
function W.prototype.GetIntrinsicModifierName(self)
	return "modifier_nevermore_talent_1"
end
W = e({ j(nil) }, W)
g.nevermore_talent_1 = W
g.modifier_nevermore_talent_1 = c()
local X = g.modifier_nevermore_talent_1
X.name = "modifier_nevermore_talent_1"
d(X, l)
function X.prototype.GetAbilitySpecialValue(self)
	self.damage_stack = self:GetAbilityTalentValue("nevermore_talent_1", "damage_stack")
end
function X.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function X.prototype.OnCustomAttackLanded(self, A)
	if self.damage_stack > 0 then
		self:IncrementStackCount(self.damage_stack)
	end
end
X = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	X
)
g.modifier_nevermore_talent_1 = X
return g