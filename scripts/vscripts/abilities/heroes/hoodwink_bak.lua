--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/hoodwink_bak"
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
		["18"] = 6,
		["19"] = 7,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 9,
		["24"] = 8,
		["25"] = 7,
		["26"] = 6,
		["27"] = 7,
		["29"] = 7,
		["30"] = 12,
		["31"] = 20,
		["32"] = 12,
		["33"] = 20,
		["34"] = 22,
		["35"] = 23,
		["36"] = 22,
		["37"] = 25,
		["38"] = 26,
		["39"] = 26,
		["40"] = 28,
		["41"] = 28,
		["42"] = 28,
		["43"] = 26,
		["44"] = 26,
		["45"] = 25,
		["46"] = 31,
		["47"] = 32,
		["48"] = 33,
		["49"] = 34,
		["50"] = 35,
		["51"] = 36,
		["52"] = 36,
		["53"] = 36,
		["54"] = 36,
		["55"] = 36,
		["56"] = 36,
		["57"] = 37,
		["58"] = 37,
		["59"] = 37,
		["60"] = 37,
		["61"] = 37,
		["62"] = 37,
		["65"] = 31,
		["66"] = 41,
		["67"] = 42,
		["68"] = 43,
		["69"] = 44,
		["70"] = 45,
		["73"] = 41,
		["74"] = 20,
		["75"] = 12,
		["76"] = 12,
		["77"] = 12,
		["78"] = 12,
		["79"] = 12,
		["80"] = 12,
		["81"] = 12,
		["82"] = 12,
		["83"] = 20,
		["85"] = 20,
		["86"] = 50,
		["87"] = 59,
		["88"] = 50,
		["89"] = 59,
		["90"] = 62,
		["91"] = 63,
		["92"] = 64,
		["93"] = 62,
		["94"] = 66,
		["95"] = 67,
		["96"] = 68,
		["98"] = 66,
		["99"] = 71,
		["100"] = 72,
		["101"] = 71,
		["102"] = 76,
		["103"] = 77,
		["106"] = 78,
		["107"] = 79,
		["109"] = 81,
		["111"] = 76,
		["112"] = 59,
		["113"] = 50,
		["114"] = 50,
		["115"] = 50,
		["116"] = 50,
		["117"] = 50,
		["118"] = 50,
		["119"] = 50,
		["120"] = 50,
		["121"] = 50,
		["122"] = 59,
		["124"] = 59,
		["126"] = 118,
		["127"] = 119,
		["128"] = 118,
		["129"] = 119,
		["130"] = 120,
		["131"] = 121,
		["132"] = 122,
		["133"] = 123,
		["134"] = 120,
		["135"] = 125,
		["136"] = 126,
		["139"] = 127,
		["140"] = 128,
		["141"] = 129,
		["142"] = 130,
		["143"] = 131,
		["144"] = 132,
		["145"] = 133,
		["146"] = 134,
		["147"] = 135,
		["148"] = 136,
		["149"] = 140,
		["150"] = 141,
		["151"] = 141,
		["152"] = 141,
		["153"] = 141,
		["154"] = 141,
		["155"] = 147,
		["156"] = 148,
		["157"] = 149,
		["158"] = 150,
		["159"] = 150,
		["160"] = 150,
		["161"] = 150,
		["162"] = 150,
		["163"] = 150,
		["164"] = 150,
		["165"] = 151,
		["166"] = 152,
		["167"] = 155,
		["168"] = 156,
		["169"] = 157,
		["171"] = 159,
		["175"] = 141,
		["176"] = 141,
		["177"] = 175,
		["178"] = 178,
		["179"] = 179,
		["181"] = 184,
		["182"] = 185,
		["184"] = 125,
		["185"] = 190,
		["186"] = 191,
		["187"] = 190,
		["188"] = 119,
		["189"] = 118,
		["190"] = 119,
		["192"] = 119,
		["194"] = 200,
		["195"] = 209,
		["196"] = 200,
		["197"] = 209,
		["198"] = 211,
		["199"] = 212,
		["200"] = 211,
		["201"] = 214,
		["202"] = 215,
		["203"] = 214,
		["204"] = 219,
		["205"] = 220,
		["206"] = 219,
		["207"] = 209,
		["208"] = 200,
		["209"] = 200,
		["210"] = 200,
		["211"] = 200,
		["212"] = 200,
		["213"] = 200,
		["214"] = 200,
		["215"] = 200,
		["216"] = 209,
		["218"] = 209,
		["220"] = 227,
		["221"] = 228,
		["222"] = 227,
		["223"] = 228,
		["224"] = 229,
		["225"] = 230,
		["226"] = 229,
		["227"] = 228,
		["228"] = 227,
		["229"] = 228,
		["231"] = 228,
		["232"] = 233,
		["233"] = 240,
		["234"] = 233,
		["235"] = 240,
		["236"] = 243,
		["237"] = 244,
		["238"] = 245,
		["239"] = 243,
		["240"] = 247,
		["241"] = 248,
		["242"] = 249,
		["243"] = 249,
		["244"] = 248,
		["245"] = 247,
		["246"] = 252,
		["247"] = 253,
		["248"] = 254,
		["249"] = 255,
		["250"] = 256,
		["251"] = 257,
		["252"] = 258,
		["253"] = 258,
		["254"] = 258,
		["255"] = 258,
		["256"] = 258,
		["257"] = 258,
		["258"] = 258,
		["259"] = 258,
		["260"] = 258,
		["263"] = 252,
		["264"] = 240,
		["265"] = 233,
		["266"] = 233,
		["267"] = 233,
		["268"] = 233,
		["269"] = 233,
		["270"] = 233,
		["271"] = 233,
		["272"] = 240,
		["274"] = 240,
		["276"] = 265,
		["277"] = 266,
		["278"] = 265,
		["279"] = 266,
		["280"] = 267,
		["281"] = 268,
		["282"] = 267,
		["283"] = 266,
		["284"] = 265,
		["285"] = 266,
		["287"] = 266,
		["288"] = 271,
		["289"] = 279,
		["290"] = 271,
		["291"] = 279,
		["292"] = 281,
		["293"] = 282,
		["294"] = 281,
		["295"] = 284,
		["296"] = 285,
		["297"] = 286,
		["299"] = 284,
		["300"] = 289,
		["301"] = 290,
		["302"] = 289,
		["303"] = 294,
		["304"] = 295,
		["305"] = 294,
		["306"] = 279,
		["307"] = 271,
		["308"] = 271,
		["309"] = 271,
		["310"] = 271,
		["311"] = 271,
		["312"] = 271,
		["313"] = 271,
		["314"] = 271,
		["315"] = 279,
		["317"] = 279,
		["319"] = 301,
		["320"] = 309,
		["321"] = 301,
		["322"] = 309,
		["323"] = 311,
		["324"] = 312,
		["325"] = 311,
		["326"] = 314,
		["327"] = 315,
		["328"] = 316,
		["330"] = 314,
		["331"] = 319,
		["332"] = 320,
		["333"] = 319,
		["334"] = 324,
		["335"] = 325,
		["336"] = 324,
		["337"] = 309,
		["338"] = 301,
		["339"] = 301,
		["340"] = 301,
		["341"] = 301,
		["342"] = 301,
		["343"] = 301,
		["344"] = 301,
		["345"] = 301,
		["346"] = 309,
		["348"] = 309,
		["350"] = 330,
		["351"] = 331,
		["352"] = 330,
		["353"] = 331,
		["354"] = 332,
		["355"] = 333,
		["356"] = 332,
		["357"] = 331,
		["358"] = 330,
		["359"] = 331,
		["361"] = 331,
		["362"] = 336,
		["363"] = 343,
		["364"] = 336,
		["365"] = 343,
		["366"] = 347,
		["367"] = 348,
		["368"] = 349,
		["369"] = 350,
		["370"] = 347,
		["371"] = 352,
		["372"] = 353,
		["373"] = 354,
		["374"] = 354,
		["375"] = 353,
		["376"] = 352,
		["377"] = 357,
		["378"] = 360,
		["379"] = 361,
		["380"] = 361,
		["381"] = 361,
		["382"] = 361,
		["383"] = 357,
		["384"] = 363,
		["385"] = 364,
		["386"] = 363,
		["387"] = 366,
		["388"] = 367,
		["389"] = 366,
		["390"] = 371,
		["391"] = 372,
		["392"] = 372,
		["393"] = 372,
		["394"] = 372,
		["395"] = 371,
		["396"] = 343,
		["397"] = 336,
		["398"] = 336,
		["399"] = 336,
		["400"] = 336,
		["401"] = 336,
		["402"] = 336,
		["403"] = 336,
		["404"] = 343,
		["406"] = 343,
		["408"] = 377,
		["409"] = 378,
		["410"] = 377,
		["411"] = 378,
		["412"] = 379,
		["413"] = 380,
		["414"] = 379,
		["415"] = 378,
		["416"] = 377,
		["417"] = 378,
		["419"] = 378,
		["420"] = 383,
		["421"] = 391,
		["422"] = 383,
		["423"] = 391,
		["424"] = 392,
		["425"] = 393,
		["426"] = 394,
		["427"] = 394,
		["428"] = 393,
		["429"] = 392,
		["430"] = 397,
		["431"] = 398,
		["432"] = 399,
		["433"] = 400,
		["434"] = 401,
		["435"] = 402,
		["436"] = 403,
		["437"] = 404,
		["440"] = 397,
		["441"] = 391,
		["442"] = 383,
		["443"] = 383,
		["444"] = 383,
		["445"] = 383,
		["446"] = 383,
		["447"] = 383,
		["448"] = 383,
		["449"] = 383,
		["450"] = 391,
		["452"] = 391,
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
g.hoodwink_talent = c()
local q = g.hoodwink_talent
q.name = "hoodwink_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_hoodwink_talent"
end
q = e({ j(nil) }, q)
g.hoodwink_talent = q
g.modifier_hoodwink_talent = c()
local r = g.modifier_hoodwink_talent
r.name = "modifier_hoodwink_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.tl12_chance = self:GetAbilityTalentValue("hoodwink_talent_12", "chance")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self:GetParent(), -1 },
	}
end
function r.prototype.OnBattleStart(self, s)
	if IsServer() then
		local t = self:GetParent()
		local u = t:GetEnemy()
		if IsInjurable(u, t) then
			t:AddNewModifier(t, self:GetAbility(), "modifier_hoodwink_talent_buff", nil)
			u:AddNewModifier(t, self:GetAbility(), "modifier_hoodwink_talent_buff", nil)
		end
	end
end
function r.prototype.OnEvasion(self, s)
	if self.tl12_chance > 0 and self:PRD(self.tl12_chance, "hoodwink_talent_12") then
		local v = self:GetParent():FindAbilityByName("hoodwink_ult")
		if IsValid(v) then
			v:OnSpellStart()
		end
	end
end
r = e(
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
	r
)
g.modifier_hoodwink_talent = r
g.modifier_hoodwink_talent_buff = c()
local w = g.modifier_hoodwink_talent_buff
w.name = "modifier_hoodwink_talent_buff"
d(w, l)
function w.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.passive_bonus = self:GetAbilityTalentValue("hoodwink_talent_3", "passive_bonus")
end
function w.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(self.count + self.passive_bonus)
	end
end
function w.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS }
end
function w.prototype.EOM_GetModifierEvasion_Bonus(self)
	if self:GetCaster():PassivesDisabled() then
		return
	end
	if self:GetParent() == self:GetCaster() then
		return self:GetStackCount()
	else
		return -self:GetStackCount()
	end
end
w = e(
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	w
)
g.modifier_hoodwink_talent_buff = w
g.hoodwink_ult = c()
local x = g.hoodwink_ult
x.name = "hoodwink_ult"
d(x, o)
function x.prototype.OnSpellStart(self)
	local y = self:GetCaster()
	local u = y:GetEnemy()
	self:PoisonDart(u)
end
function x.prototype.PoisonDart(self, u)
	if not IsValid(u) then
		return
	end
	local y = self:GetCaster()
	local z = self:GetSpecialValueFor("poison_count") + self:GetTalentValue("hoodwink_talent_1", "poison_bonus")
	local A = self:GetTalentValue("hoodwink_talent_2", "duration")
	local B = self:GetTalentValue("hoodwink_talent_4", "damage_bonus")
	local C = self:GetTalentValue("hoodwink_talent_6", "stun_duration")
	local D = self:GetTalentValue("hoodwink_talent_6", "threshold")
	local E = self:GetTalentValue("hoodwink_talent_6", "extra_stun")
	local F = self:GetTalentValue("hoodwink_talent_7", "damage_bonus")
	local G = self:GetTalentValue("hoodwink_talent_9", "duration")
	local H = self:GetSpecialValueFor("damage") + GetEvasion(y) * B * 0.01 + F
	y:EmitSound("Hero_Hoodwink.AcornShot.Cast")
	Projectile:CreateTrackingProjectile({
		EffectName = "particles/units/heroes/hero_hoodwink/hoodwink_acorn_shot_tracking.vpcf",
		hCaster = y,
		hTarget = u,
		iMoveSpeed = 600,
		OnProjectileHit = function(u, I, J)
			if IsInjurable(u) then
				local K = Round(GetEvasion(y) * z)
				AddPoison(y, u, K, self:GetAbilityName(), "Ability")
				y:DealDamage(u, self, H, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
				EmitSoundOnLocationWithCaster(I, "Hero_Hoodwink.AcornShot.Target", y)
				if C > 0 then
					if math.abs(GetEvasion(y) - GetEvasion(u)) > D then
						AddStun(y, u, self, C + E)
					else
						AddStun(y, u, self, C)
					end
				end
			end
		end,
	})
	y:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	if A > 0 then
		y:AddNewModifier(y, self, "modifier_hoodwink_talent_2", { duration = A })
	end
	if G > 0 then
		y:AddNewModifier(y, self, "modifier_hoodwink_talent_9", { duration = G })
	end
end
function x.prototype.GetIntrinsicModifierName(self)
	return "modifier_hoodwink_ult"
end
x = e({ p(nil) }, x)
g.hoodwink_ult = x
g.modifier_hoodwink_talent_2 = c()
local L = g.modifier_hoodwink_talent_2
L.name = "modifier_hoodwink_talent_2"
d(L, l)
function L.prototype.GetAbilitySpecialValue(self)
	self.attackspeed_bonus = self:GetAbilityTalentValue("hoodwink_talent_2", "attackspeed_bonus")
end
function L.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function L.prototype.EOM_GetModifierAttackSpeedBonus(self)
	return self.attackspeed_bonus
end
L = e(
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
	L
)
g.modifier_hoodwink_talent_2 = L
g.hoodwink_talent_5 = c()
local M = g.hoodwink_talent_5
M.name = "hoodwink_talent_5"
d(M, i)
function M.prototype.GetIntrinsicModifierName(self)
	return "modifier_hoodwink_talent_5"
end
M = e({ j(nil) }, M)
g.hoodwink_talent_5 = M
g.modifier_hoodwink_talent_5 = c()
local N = g.modifier_hoodwink_talent_5
N.name = "modifier_hoodwink_talent_5"
d(N, l)
function N.prototype.GetAbilitySpecialValue(self)
	self.heal_pct = self:GetAbilitySpecialValueFor("heal_pct")
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function N.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_POISON_TAKEDAMAGE] = { -1, self:GetParent() } }
end
function N.prototype.OnPoisonTakeDamage(self, s)
	if self.chance > 0 and self:PRD(self.chance) then
		local t = self:GetParent()
		local O = t:GetEnemy()
		local P = (GetEvasion(t) + (IsValid(O) and GetEvasion(O) or 0)) * self.heal_pct * 0.01
		if P > 0 then
			local Q = Heal
			local R = P
			local S = self:GetAbility()
			Q(t, R, S and S:GetAbilityName(), "Ability")
		end
	end
end
N = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	N
)
g.modifier_hoodwink_talent_5 = N
g.hoodwink_talent_8 = c()
local T = g.hoodwink_talent_8
T.name = "hoodwink_talent_8"
d(T, i)
function T.prototype.GetIntrinsicModifierName(self)
	return "modifier_hoodwink_talent_8"
end
T = e({ j(nil) }, T)
g.hoodwink_talent_8 = T
g.modifier_hoodwink_talent_8 = c()
local U = g.modifier_hoodwink_talent_8
U.name = "modifier_hoodwink_talent_8"
d(U, l)
function U.prototype.GetAbilitySpecialValue(self)
	self.physical_damage_per_victory = self:GetAbilitySpecialValueFor("physical_damage_per_victory")
end
function U.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(
			PlayerData:getTotalWin(self:GetParent():GetPlayerOwnerID()) * self.physical_damage_per_victory
		)
	end
end
function U.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_PHYSICAL_DAMAGE_PERCENTAGE }
end
function U.prototype.EOM_GetModifierOutgoingPhysicalDamagePercentage(self)
	return self:GetStackCount()
end
U = e(
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
	U
)
g.modifier_hoodwink_talent_8 = U
g.modifier_hoodwink_talent_9 = c()
local V = g.modifier_hoodwink_talent_9
V.name = "modifier_hoodwink_talent_9"
d(V, l)
function V.prototype.GetAbilitySpecialValue(self)
	self.extra_crit = self:GetAbilitySpecialValueFor("extra_crit")
end
function V.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(self.extra_crit)
	end
end
function V.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS }
end
function V.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self)
	return self:GetStackCount()
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
g.modifier_hoodwink_talent_9 = V
g.hoodwink_talent_10 = c()
local W = g.hoodwink_talent_10
W.name = "hoodwink_talent_10"
d(W, i)
function W.prototype.GetIntrinsicModifierName(self)
	return "modifier_hoodwink_talent_10"
end
W = e({ j(nil) }, W)
g.hoodwink_talent_10 = W
g.modifier_hoodwink_talent_10 = c()
local X = g.modifier_hoodwink_talent_10
X.name = "modifier_hoodwink_talent_10"
d(X, l)
function X.prototype.GetAbilitySpecialValue(self)
	self.poison_count = self:GetAbilitySpecialValueFor("poison_count")
	self.max_stack = self:GetAbilitySpecialValueFor("max_stack")
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function X.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self:GetParent(), -1 } }
end
function X.prototype.OnEvasion(self, s)
	self:IncrementStackCount()
	self:StartThink(self.duration, DoUniqueString("modifier_hoodwink_talent_10"))
end
function X.prototype.OnThink(self, Y)
	self:DecrementStackCount()
end
function X.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_DAMAGE_BONUS }
end
function X.prototype.EOM_GetModifierPoisonDamageBonus(self)
	return self.poison_count * math.min(self.max_stack, self:GetStackCount())
end
X = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	X
)
g.modifier_hoodwink_talent_10 = X
g.hoodwink_talent_11 = c()
local Z = g.hoodwink_talent_11
Z.name = "hoodwink_talent_11"
d(Z, i)
function Z.prototype.GetIntrinsicModifierName(self)
	return "modifier_hoodwink_talent_11"
end
Z = e({ j(nil) }, Z)
g.hoodwink_talent_11 = Z
g.modifier_hoodwink_talent_11 = c()
local _ = g.modifier_hoodwink_talent_11
_.name = "modifier_hoodwink_talent_11"
d(_, l)
function _.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_POISON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function _.prototype.OnPoisonTakeDamage(self, s)
	local a0 = self:GetAbilityTalentValue("hoodwink_talent_11", "chance")
	if a0 > 0 and self:PRD(a0) then
		local t = self:GetParent()
		local O = t:GetEnemy()
		local a1 = t:FindAbilityByName("hoodwink_ult")
		if IsValid(a1) and IsValid(O) then
			a1:PoisonDart(O)
		end
	end
end
_ = e(
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
	_
)
g.modifier_hoodwink_talent_11 = _
return g