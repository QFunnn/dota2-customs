--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		["33"] = 38,
		["34"] = 39,
		["35"] = 40,
		["36"] = 41,
		["37"] = 42,
		["38"] = 43,
		["39"] = 44,
		["40"] = 45,
		["41"] = 46,
		["42"] = 47,
		["43"] = 48,
		["44"] = 49,
		["45"] = 50,
		["46"] = 52,
		["47"] = 53,
		["48"] = 38,
		["49"] = 55,
		["50"] = 56,
		["51"] = 56,
		["52"] = 56,
		["53"] = 59,
		["54"] = 59,
		["55"] = 59,
		["56"] = 56,
		["57"] = 60,
		["58"] = 60,
		["59"] = 60,
		["60"] = 56,
		["61"] = 56,
		["62"] = 55,
		["63"] = 63,
		["64"] = 64,
		["65"] = 63,
		["66"] = 71,
		["67"] = 72,
		["68"] = 71,
		["69"] = 74,
		["70"] = 75,
		["71"] = 74,
		["72"] = 77,
		["73"] = 78,
		["74"] = 77,
		["75"] = 80,
		["76"] = 81,
		["77"] = 80,
		["78"] = 83,
		["79"] = 84,
		["80"] = 84,
		["81"] = 84,
		["82"] = 84,
		["83"] = 84,
		["84"] = 84,
		["86"] = 84,
		["87"] = 85,
		["88"] = 85,
		["89"] = 85,
		["90"] = 85,
		["91"] = 85,
		["92"] = 83,
		["93"] = 87,
		["94"] = 88,
		["95"] = 88,
		["96"] = 88,
		["97"] = 88,
		["98"] = 88,
		["99"] = 88,
		["101"] = 88,
		["102"] = 89,
		["103"] = 90,
		["104"] = 91,
		["105"] = 92,
		["108"] = 95,
		["109"] = 87,
		["110"] = 98,
		["111"] = 99,
		["112"] = 100,
		["113"] = 100,
		["114"] = 100,
		["115"] = 100,
		["116"] = 101,
		["117"] = 101,
		["118"] = 101,
		["119"] = 101,
		["120"] = 101,
		["122"] = 98,
		["123"] = 104,
		["124"] = 105,
		["127"] = 108,
		["128"] = 109,
		["129"] = 110,
		["130"] = 111,
		["131"] = 104,
		["132"] = 113,
		["133"] = 114,
		["134"] = 115,
		["135"] = 116,
		["136"] = 113,
		["137"] = 118,
		["138"] = 119,
		["141"] = 122,
		["142"] = 123,
		["143"] = 124,
		["144"] = 125,
		["145"] = 126,
		["146"] = 127,
		["148"] = 118,
		["149"] = 130,
		["150"] = 132,
		["151"] = 133,
		["152"] = 134,
		["154"] = 130,
		["155"] = 138,
		["156"] = 139,
		["157"] = 140,
		["160"] = 143,
		["161"] = 144,
		["162"] = 145,
		["163"] = 146,
		["164"] = 147,
		["165"] = 148,
		["166"] = 149,
		["167"] = 150,
		["168"] = 151,
		["169"] = 152,
		["170"] = 152,
		["171"] = 152,
		["172"] = 152,
		["173"] = 152,
		["174"] = 153,
		["175"] = 154,
		["177"] = 155,
		["178"] = 155,
		["179"] = 156,
		["180"] = 156,
		["181"] = 156,
		["182"] = 156,
		["183"] = 156,
		["184"] = 157,
		["185"] = 158,
		["186"] = 159,
		["187"] = 160,
		["188"] = 160,
		["189"] = 160,
		["190"] = 160,
		["191"] = 160,
		["192"] = 155,
		["195"] = 163,
		["196"] = 163,
		["197"] = 163,
		["198"] = 163,
		["199"] = 163,
		["200"] = 163,
		["201"] = 164,
		["202"] = 165,
		["203"] = 166,
		["204"] = 166,
		["205"] = 166,
		["206"] = 166,
		["207"] = 167,
		["208"] = 168,
		["210"] = 166,
		["211"] = 166,
		["214"] = 138,
		["215"] = 20,
		["216"] = 12,
		["217"] = 12,
		["218"] = 12,
		["219"] = 12,
		["220"] = 12,
		["221"] = 12,
		["222"] = 12,
		["223"] = 12,
		["224"] = 20,
		["226"] = 20,
		["227"] = 177,
		["228"] = 178,
		["229"] = 177,
		["230"] = 178,
		["232"] = 178,
		["233"] = 179,
		["234"] = 177,
		["235"] = 181,
		["236"] = 182,
		["237"] = 181,
		["238"] = 185,
		["239"] = 186,
		["240"] = 187,
		["241"] = 189,
		["242"] = 190,
		["243"] = 191,
		["244"] = 192,
		["245"] = 193,
		["246"] = 194,
		["248"] = 196,
		["249"] = 196,
		["250"] = 196,
		["251"] = 197,
		["252"] = 198,
		["253"] = 199,
		["254"] = 199,
		["255"] = 199,
		["256"] = 199,
		["257"] = 199,
		["258"] = 200,
		["259"] = 201,
		["260"] = 201,
		["261"] = 201,
		["262"] = 201,
		["263"] = 201,
		["264"] = 201,
		["265"] = 203,
		["266"] = 205,
		["267"] = 206,
		["268"] = 207,
		["271"] = 196,
		["272"] = 196,
		["273"] = 185,
		["274"] = 212,
		["275"] = 213,
		["276"] = 214,
		["277"] = 215,
		["278"] = 216,
		["279"] = 217,
		["280"] = 218,
		["282"] = 220,
		["283"] = 212,
		["284"] = 178,
		["285"] = 177,
		["286"] = 178,
		["288"] = 178,
		["289"] = 224,
		["290"] = 232,
		["291"] = 224,
		["292"] = 232,
		["293"] = 234,
		["294"] = 235,
		["295"] = 236,
		["296"] = 236,
		["297"] = 235,
		["298"] = 234,
		["299"] = 240,
		["300"] = 241,
		["301"] = 242,
		["302"] = 243,
		["303"] = 245,
		["304"] = 247,
		["305"] = 250,
		["306"] = 251,
		["307"] = 251,
		["308"] = 251,
		["309"] = 251,
		["310"] = 251,
		["311"] = 251,
		["312"] = 251,
		["313"] = 251,
		["316"] = 240,
		["317"] = 232,
		["318"] = 224,
		["319"] = 224,
		["320"] = 224,
		["321"] = 224,
		["322"] = 224,
		["323"] = 224,
		["324"] = 224,
		["325"] = 224,
		["326"] = 232,
		["328"] = 232,
		["329"] = 260,
		["330"] = 268,
		["331"] = 260,
		["332"] = 268,
		["333"] = 269,
		["334"] = 270,
		["335"] = 271,
		["337"] = 269,
		["338"] = 274,
		["339"] = 275,
		["340"] = 276,
		["342"] = 274,
		["343"] = 279,
		["344"] = 280,
		["345"] = 279,
		["346"] = 282,
		["347"] = 283,
		["348"] = 282,
		["349"] = 268,
		["350"] = 260,
		["351"] = 260,
		["352"] = 260,
		["353"] = 260,
		["354"] = 260,
		["355"] = 260,
		["356"] = 260,
		["357"] = 260,
		["358"] = 268,
		["360"] = 268,
		["362"] = 292,
		["363"] = 293,
		["364"] = 292,
		["365"] = 293,
		["366"] = 294,
		["367"] = 295,
		["368"] = 294,
		["369"] = 293,
		["370"] = 292,
		["371"] = 293,
		["373"] = 293,
		["374"] = 298,
		["375"] = 306,
		["376"] = 298,
		["377"] = 306,
		["379"] = 306,
		["380"] = 308,
		["381"] = 298,
		["382"] = 309,
		["383"] = 310,
		["384"] = 309,
		["385"] = 312,
		["386"] = 313,
		["387"] = 314,
		["388"] = 314,
		["389"] = 313,
		["390"] = 312,
		["391"] = 317,
		["392"] = 318,
		["393"] = 319,
		["394"] = 321,
		["395"] = 322,
		["397"] = 317,
		["398"] = 306,
		["399"] = 298,
		["400"] = 298,
		["401"] = 298,
		["402"] = 298,
		["403"] = 298,
		["404"] = 298,
		["405"] = 298,
		["406"] = 298,
		["407"] = 306,
		["409"] = 306,
		["410"] = 339,
		["411"] = 340,
		["412"] = 339,
		["413"] = 340,
		["414"] = 341,
		["415"] = 342,
		["416"] = 341,
		["417"] = 340,
		["418"] = 339,
		["419"] = 340,
		["421"] = 340,
		["422"] = 345,
		["423"] = 353,
		["424"] = 345,
		["425"] = 353,
		["426"] = 355,
		["427"] = 356,
		["428"] = 355,
		["429"] = 358,
		["430"] = 359,
		["431"] = 360,
		["432"] = 360,
		["433"] = 359,
		["434"] = 358,
		["435"] = 363,
		["436"] = 364,
		["437"] = 365,
		["439"] = 363,
		["440"] = 353,
		["441"] = 345,
		["442"] = 345,
		["443"] = 345,
		["444"] = 345,
		["445"] = 345,
		["446"] = 345,
		["447"] = 345,
		["448"] = 345,
		["449"] = 353,
		["451"] = 353,
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
	if self.disable then
		return
	end
	self.disable = true
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