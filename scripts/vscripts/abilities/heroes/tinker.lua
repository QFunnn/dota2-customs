--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/tinker"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
local g = b.__TS__ObjectKeys
local h = b.__TS__ArrayMap
local i = b.__TS__ArrayFilter
local j = b.__TS__SourceMapTraceBack
j(
	debug.getinfo(1).short_src,
	{
		["12"] = 1,
		["13"] = 1,
		["14"] = 1,
		["15"] = 2,
		["16"] = 2,
		["17"] = 2,
		["18"] = 3,
		["19"] = 3,
		["20"] = 3,
		["21"] = 5,
		["22"] = 6,
		["23"] = 5,
		["24"] = 6,
		["25"] = 7,
		["26"] = 8,
		["27"] = 7,
		["28"] = 6,
		["29"] = 5,
		["30"] = 6,
		["32"] = 6,
		["33"] = 12,
		["34"] = 20,
		["35"] = 12,
		["36"] = 20,
		["37"] = 25,
		["38"] = 26,
		["39"] = 29,
		["40"] = 25,
		["41"] = 31,
		["42"] = 32,
		["43"] = 31,
		["44"] = 36,
		["45"] = 37,
		["46"] = 37,
		["47"] = 37,
		["48"] = 40,
		["49"] = 40,
		["50"] = 40,
		["51"] = 37,
		["52"] = 37,
		["53"] = 36,
		["54"] = 44,
		["55"] = 45,
		["56"] = 46,
		["57"] = 47,
		["58"] = 48,
		["59"] = 50,
		["60"] = 51,
		["61"] = 53,
		["62"] = 54,
		["63"] = 54,
		["64"] = 54,
		["65"] = 55,
		["66"] = 56,
		["67"] = 57,
		["69"] = 54,
		["70"] = 54,
		["71"] = 60,
		["72"] = 60,
		["73"] = 60,
		["74"] = 61,
		["75"] = 62,
		["76"] = 63,
		["78"] = 60,
		["79"] = 60,
		["80"] = 66,
		["82"] = 68,
		["83"] = 69,
		["84"] = 44,
		["85"] = 82,
		["86"] = 83,
		["87"] = 84,
		["88"] = 85,
		["89"] = 85,
		["90"] = 85,
		["91"] = 86,
		["92"] = 85,
		["93"] = 85,
		["95"] = 82,
		["96"] = 90,
		["97"] = 91,
		["98"] = 92,
		["99"] = 93,
		["101"] = 95,
		["102"] = 90,
		["103"] = 20,
		["104"] = 12,
		["105"] = 12,
		["106"] = 12,
		["107"] = 12,
		["108"] = 12,
		["109"] = 12,
		["110"] = 12,
		["111"] = 12,
		["112"] = 20,
		["114"] = 20,
		["116"] = 100,
		["117"] = 101,
		["118"] = 100,
		["119"] = 101,
		["120"] = 103,
		["121"] = 104,
		["122"] = 105,
		["123"] = 106,
		["124"] = 107,
		["125"] = 108,
		["126"] = 109,
		["127"] = 110,
		["128"] = 111,
		["129"] = 112,
		["130"] = 113,
		["131"] = 113,
		["132"] = 113,
		["133"] = 114,
		["134"] = 115,
		["135"] = 116,
		["136"] = 117,
		["138"] = 113,
		["139"] = 113,
		["140"] = 103,
		["141"] = 121,
		["142"] = 122,
		["143"] = 123,
		["144"] = 124,
		["145"] = 125,
		["146"] = 126,
		["147"] = 127,
		["148"] = 128,
		["149"] = 130,
		["150"] = 131,
		["151"] = 132,
		["152"] = 134,
		["153"] = 135,
		["154"] = 136,
		["155"] = 137,
		["156"] = 139,
		["157"] = 140,
		["158"] = 141,
		["159"] = 141,
		["160"] = 141,
		["161"] = 141,
		["162"] = 141,
		["163"] = 146,
		["164"] = 146,
		["165"] = 146,
		["166"] = 146,
		["167"] = 141,
		["168"] = 147,
		["169"] = 148,
		["170"] = 149,
		["171"] = 150,
		["172"] = 150,
		["173"] = 150,
		["174"] = 150,
		["175"] = 150,
		["176"] = 150,
		["177"] = 150,
		["178"] = 151,
		["179"] = 153,
		["180"] = 154,
		["182"] = 157,
		["183"] = 158,
		["184"] = 158,
		["185"] = 158,
		["186"] = 158,
		["187"] = 158,
		["188"] = 158,
		["189"] = 158,
		["191"] = 161,
		["192"] = 162,
		["193"] = 162,
		["194"] = 162,
		["195"] = 162,
		["196"] = 162,
		["197"] = 162,
		["198"] = 162,
		["200"] = 164,
		["201"] = 141,
		["202"] = 141,
		["203"] = 167,
		["204"] = 121,
		["205"] = 101,
		["206"] = 100,
		["207"] = 101,
		["209"] = 101,
		["211"] = 176,
		["212"] = 177,
		["213"] = 176,
		["214"] = 177,
		["215"] = 178,
		["216"] = 179,
		["217"] = 178,
		["218"] = 177,
		["219"] = 176,
		["220"] = 177,
		["222"] = 177,
		["223"] = 182,
		["224"] = 190,
		["225"] = 182,
		["226"] = 190,
		["227"] = 194,
		["228"] = 195,
		["229"] = 196,
		["230"] = 197,
		["231"] = 194,
		["232"] = 199,
		["233"] = 200,
		["234"] = 201,
		["235"] = 201,
		["236"] = 200,
		["237"] = 199,
		["238"] = 204,
		["239"] = 205,
		["240"] = 206,
		["241"] = 207,
		["242"] = 208,
		["243"] = 209,
		["244"] = 209,
		["246"] = 210,
		["247"] = 211,
		["248"] = 212,
		["249"] = 213,
		["250"] = 214,
		["251"] = 214,
		["252"] = 214,
		["253"] = 214,
		["254"] = 214,
		["255"] = 214,
		["256"] = 214,
		["257"] = 214,
		["258"] = 214,
		["259"] = 215,
		["260"] = 215,
		["261"] = 215,
		["262"] = 215,
		["263"] = 215,
		["264"] = 215,
		["265"] = 215,
		["266"] = 215,
		["267"] = 215,
		["268"] = 216,
		["269"] = 217,
		["270"] = 218,
		["271"] = 219,
		["272"] = 220,
		["273"] = 220,
		["274"] = 220,
		["275"] = 220,
		["276"] = 221,
		["277"] = 221,
		["280"] = 204,
		["281"] = 229,
		["282"] = 230,
		["283"] = 231,
		["284"] = 232,
		["285"] = 233,
		["286"] = 234,
		["287"] = 235,
		["288"] = 235,
		["289"] = 235,
		["290"] = 235,
		["291"] = 235,
		["292"] = 235,
		["293"] = 236,
		["296"] = 239,
		["297"] = 240,
		["299"] = 229,
		["300"] = 190,
		["301"] = 182,
		["302"] = 182,
		["303"] = 182,
		["304"] = 182,
		["305"] = 182,
		["306"] = 182,
		["307"] = 182,
		["308"] = 182,
		["309"] = 190,
		["311"] = 190,
		["313"] = 246,
		["314"] = 247,
		["315"] = 246,
		["316"] = 247,
		["317"] = 248,
		["318"] = 249,
		["319"] = 248,
		["320"] = 247,
		["321"] = 246,
		["322"] = 247,
		["324"] = 247,
		["325"] = 252,
		["326"] = 260,
		["327"] = 252,
		["328"] = 260,
		["329"] = 262,
		["330"] = 263,
		["331"] = 262,
		["332"] = 265,
		["333"] = 266,
		["334"] = 265,
		["335"] = 270,
		["336"] = 271,
		["337"] = 270,
		["338"] = 275,
		["339"] = 277,
		["340"] = 278,
		["341"] = 279,
		["342"] = 280,
		["343"] = 282,
		["344"] = 283,
		["345"] = 283,
		["346"] = 283,
		["347"] = 284,
		["348"] = 285,
		["349"] = 286,
		["351"] = 283,
		["352"] = 283,
		["353"] = 289,
		["354"] = 289,
		["355"] = 289,
		["356"] = 290,
		["357"] = 291,
		["358"] = 292,
		["360"] = 289,
		["361"] = 289,
		["362"] = 296,
		["363"] = 275,
		["364"] = 298,
		["365"] = 299,
		["366"] = 298,
		["367"] = 260,
		["368"] = 252,
		["369"] = 252,
		["370"] = 252,
		["371"] = 252,
		["372"] = 252,
		["373"] = 252,
		["374"] = 252,
		["375"] = 252,
		["376"] = 260,
		["378"] = 260,
		["380"] = 305,
		["381"] = 306,
		["382"] = 305,
		["383"] = 306,
		["384"] = 307,
		["385"] = 308,
		["386"] = 307,
		["387"] = 306,
		["388"] = 305,
		["389"] = 306,
		["391"] = 306,
		["392"] = 311,
		["393"] = 319,
		["394"] = 311,
		["395"] = 319,
		["396"] = 321,
		["397"] = 322,
		["398"] = 321,
		["399"] = 324,
		["400"] = 325,
		["401"] = 326,
		["402"] = 326,
		["403"] = 325,
		["404"] = 324,
		["405"] = 329,
		["406"] = 330,
		["407"] = 331,
		["409"] = 331,
		["412"] = 329,
		["413"] = 319,
		["414"] = 311,
		["415"] = 311,
		["416"] = 311,
		["417"] = 311,
		["418"] = 311,
		["419"] = 311,
		["420"] = 311,
		["421"] = 311,
		["422"] = 319,
		["424"] = 319,
		["426"] = 337,
		["427"] = 338,
		["428"] = 337,
		["429"] = 338,
		["430"] = 339,
		["431"] = 340,
		["432"] = 339,
		["433"] = 338,
		["434"] = 337,
		["435"] = 338,
		["437"] = 338,
		["438"] = 343,
		["439"] = 351,
		["440"] = 343,
		["441"] = 351,
		["442"] = 355,
		["443"] = 356,
		["444"] = 357,
		["445"] = 355,
		["446"] = 359,
		["447"] = 360,
		["448"] = 359,
		["449"] = 364,
		["450"] = 365,
		["451"] = 364,
		["452"] = 368,
		["453"] = 369,
		["454"] = 370,
		["455"] = 371,
		["456"] = 372,
		["457"] = 373,
		["458"] = 374,
		["459"] = 376,
		["460"] = 376,
		["461"] = 376,
		["462"] = 376,
		["463"] = 377,
		["464"] = 378,
		["465"] = 379,
		["466"] = 380,
		["469"] = 383,
		["471"] = 384,
		["472"] = 384,
		["473"] = 385,
		["474"] = 384,
		["477"] = 387,
		["480"] = 390,
		["481"] = 368,
		["482"] = 392,
		["483"] = 393,
		["484"] = 394,
		["485"] = 395,
		["487"] = 392,
		["488"] = 398,
		["489"] = 399,
		["490"] = 398,
		["491"] = 403,
		["492"] = 404,
		["493"] = 405,
		["495"] = 403,
		["496"] = 351,
		["497"] = 343,
		["498"] = 343,
		["499"] = 343,
		["500"] = 343,
		["501"] = 343,
		["502"] = 343,
		["503"] = 343,
		["504"] = 343,
		["505"] = 351,
		["507"] = 351,
	}
)
local k = {}
local l = require("lib.dota_ts_adapter")
local m = l.BaseAbility
local n = l.registerAbility
local o = require("modifiers.eom_modifier")
local p = o.EOMModifier
local q = o.registerEOMModifier
local r = require("abilities.ability_ai")
local s = r.BaseAbilityAI
local t = r.registerAbilityAI
k.tinker_talent = c()
local u = k.tinker_talent
u.name = "tinker_talent"
d(u, m)
function u.prototype.GetIntrinsicModifierName(self)
	return "modifier_tinker_talent"
end
u = e({ n(nil) }, u)
k.tinker_talent = u
k.modifier_tinker_talent = c()
local v = k.modifier_tinker_talent
v.name = "modifier_tinker_talent"
d(v, p)
function v.prototype.GetAbilitySpecialValue(self)
	self.factor = self:GetAbilitySpecialValueFor("factor") + self:GetAbilityTalentValue("tinker_talent_1", "factor")
	self.s_bonus = self:GetAbilityTalentValue("tinker_shard", "bonus")
end
function v.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_CONSTANT }
end
function v.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TALENT_LEARN] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
	}
end
function v.prototype.OnBattleStartBefore(self, w)
	local x = 0
	local y = self:GetParent():GetHeroBase()
	local z = y:getAbilityUpgradeData(true)
	if self.s_bonus > 0 then
		local A = y:getTempAbilityUpgrade()
		local B = KeyValues.AbilityUpgradesKvs
		local C = {}
		h(g(z), function(D, E)
			local F = B[E] or {}
			if F.rarity == "sr" and not f(C, E) then
				C[#C + 1] = E
			end
		end)
		h(g(A), function(D, E)
			local F = B[E] or {}
			if F.rarity == "sr" and not f(C, E) then
				C[#C + 1] = E
			end
		end)
		x = #C * self.s_bonus
	end
	x = x + #g(y:getAbilityUpgradeData(true, true)) * self.factor
	self:SetStackCount(x)
end
function v.prototype.OnTalentLearn(self, w)
	if w.talentName == "tinker_talent_8" then
		local G = self:GetParent():GetHeroBase()
		h(AbilityShop.pickList, function(D, H)
			G:addSectExp(H, 0)
		end)
	end
end
function v.prototype.EOM_GetModifierOutgoingDamageConstant(self, w)
	local I = 0
	if w.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL then
		I = I + self:GetStackCount()
	end
	return I
end
v = e(
	{
		q(
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
	v
)
k.modifier_tinker_talent = v
k.tinker_ult = c()
local J = k.tinker_ult
J.name = "tinker_ult"
d(J, s)
function J.prototype.OnSpellStart(self)
	local K = self:GetCaster()
	local L = K:GetEnemy()
	local M = self:GetSpecialValueFor("damage")
	local N = self:GetSpecialValueFor("count") + self:GetTalentValue("tinker_talent_3", "missile_count")
	local O = self:GetSpecialValueFor("interval")
	K:AddActivityModifier("activity_ult")
	K:StartGestureWithPlaybackRate(ACT_DOTA_TELEPORT_END, 0.4)
	K:RemoveActivityModifier("activity_ult")
	local P = 0
	self:GameTimer(0, function()
		if P < N then
			P = P + 1
			self:Launch(L)
			return O
		end
	end)
end
function J.prototype.Launch(self, L)
	local K = self:GetCaster()
	local Q = K:GetAttachmentPosition("attach_ambient")
	local M = self:GetSpecialValueFor("damage")
	local R = self:GetSpecialValueFor("level_factor")
	local S = self:GetTalentValue("tinker_talent_2", "chance")
	local T = self:GetTalentValue("tinker_talent_2", "mana_regen")
	local U = self:GetTalentValue("tinker_talent_7", "missile_damage")
	local V = self:GetTalentValue("tinker_talent_9", "damage_per_stack")
	local W = self:GetTalentValue("tinker_talent_9", "max_stack")
	self.tinker_talent_9_record = self.tinker_talent_9_record or 0
	local X = self:GetTalentValue("tinker_talent_11", "chance")
	local Y = self:GetTalentValue("tinker_talent_11", "injury")
	local Z = self:GetTalentValue("tinker_talent_12", "chance")
	local _ = self:GetTalentValue("tinker_talent_12", "damage_pct")
	local a0 = PlayerData:getHero(K:GetPlayerOwnerID())
	local a1 = a0 ~= nil and a0:getLevel() or 1
	Projectile:CreateTrackingProjectile({
		EffectName = "particles/units/heroes/hero_tinker/tinker_missile.vpcf",
		hCaster = K,
		hTarget = L,
		iMoveSpeed = 600,
		vSpawnOrigin = Q + Vector(RandomInt(-150, 150), RandomInt(-150, 150), 0),
		OnProjectileHit = function(L, a2, a3)
			local a4 = M + a1 * R + U + math.min(W, self.tinker_talent_9_record) * V
			local a5 = self:HasTalent("tinker_talent_10") and DamageFlags.DAMAGE_FLAG_NO_EVASION
				or DamageFlags.DAMAGE_FLAG_NONE
			K:DealDamage(L, self, a4, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL, a5)
			EmitSoundOnLocationWithCaster(a2, "Hero_Tinker.Heat-Seeking_Missile.Impact", K)
			if S > 0 and self:PRD(S, "talent_2_chance") then
				Restore(K, T, true)
			end
			if X > 0 and self:PRD(X, "talent_11_chance") then
				AddInjury(K, L, Y, "tinker_talent_11", "Ability")
			end
			if Z > 0 and self:PRD(Z, "talent_12_chance") then
				K:DealDamage(L, self, a4 * _ * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, a5)
			end
			self.tinker_talent_9_record = self.tinker_talent_9_record + 1
		end,
	})
	K:EmitSound("Hero_Tinker.Heat-Seeking_Missile")
end
J = e({ t(nil) }, J)
k.tinker_ult = J
k.tinker_talent_4 = c()
local a6 = k.tinker_talent_4
a6.name = "tinker_talent_4"
d(a6, m)
function a6.prototype.GetIntrinsicModifierName(self)
	return "modifier_tinker_talent_4"
end
a6 = e({ n(nil) }, a6)
k.tinker_talent_4 = a6
k.modifier_tinker_talent_4 = c()
local a7 = k.modifier_tinker_talent_4
a7.name = "modifier_tinker_talent_4"
d(a7, p)
function a7.prototype.GetAbilitySpecialValue(self)
	self.stack = self:GetAbilitySpecialValueFor("stack")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.timer = {}
end
function a7.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function a7.prototype.OnCustomTakeDamage(self, a8)
	if self.stack > 0 and a8.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL then
		self:IncrementStackCount()
		if self:GetStackCount() >= self.stack then
			self:SetStackCount(0)
			if #self.timer == 0 then
				self:StartIntervalThink(0)
			end
			local a9 = self:GetParent()
			local aa = GameRules:GetGameTime()
			local ab = 0.15
			local ac = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_tinker/tinker_laser.vpcf",
				PATTACH_CUSTOMORIGIN,
				a9
			)
			ParticleManager:SetParticleControlEnt(
				ac,
				9,
				a9,
				PATTACH_POINT_FOLLOW,
				"attach_attack2",
				vec3_invalid,
				false
			)
			ParticleManager:SetParticleControlEnt(
				ac,
				1,
				a8.target,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				vec3_invalid,
				false
			)
			ParticleManager:ReleaseParticleIndex(ac)
			EmitSoundOn("Hero_Tinker.Laser", a9)
			EmitSoundOn("Hero_Tinker.LaserImpact", a8.target)
			a9:ForcePlayActivityOnce(ACT_DOTA_CAST_ABILITY_1)
			a9:StartGestureWithPlaybackRate(
				ACT_DOTA_CAST_ABILITY_1,
				a9:GetAttackSpeed(false) * a9:GetBaseAttackTime(false) * 1.25
			)
			local ad = self.timer
			ad[#ad + 1] = { flExpireTime = aa + ab, hTarget = a8.target, flDamage = self.damage }
		end
	end
end
function a7.prototype.OnIntervalThink(self)
	local a9 = self:GetParent()
	local aa = GameRules:GetGameTime()
	for ae = #self.timer, 1, -1 do
		local af = self.timer[ae]
		if aa >= af.flExpireTime then
			a9:DealDamage(af.hTarget, self:GetAbility(), af.flDamage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			table.remove(self.timer, ae)
		end
	end
	if #self.timer == 0 then
		self:StartIntervalThink(-1)
	end
end
a7 = e(
	{
		q(
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
	a7
)
k.modifier_tinker_talent_4 = a7
k.tinker_talent_5 = c()
local ag = k.tinker_talent_5
ag.name = "tinker_talent_5"
d(ag, m)
function ag.prototype.GetIntrinsicModifierName(self)
	return "modifier_tinker_talent_5"
end
ag = e({ n(nil) }, ag)
k.tinker_talent_5 = ag
k.modifier_tinker_talent_5 = c()
local ah = k.modifier_tinker_talent_5
ah.name = "modifier_tinker_talent_5"
d(ah, p)
function ah.prototype.GetAbilitySpecialValue(self)
	self.damage_bonus = self:GetAbilitySpecialValueFor("damage_bonus")
end
function ah.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function ah.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function ah.prototype.OnBattleStartBefore(self, w)
	local y = self:GetParent():GetHeroBase()
	local z = y:getAbilityUpgradeData(true)
	local A = y:getTempAbilityUpgrade()
	local B = KeyValues.AbilityUpgradesKvs
	local C = {}
	h(g(z), function(D, E)
		local F = B[E] or {}
		if F.rarity == "sr" and not f(C, E) then
			C[#C + 1] = E
		end
	end)
	h(g(A), function(D, E)
		local F = B[E] or {}
		if F.rarity == "sr" and not f(C, E) then
			C[#C + 1] = E
		end
	end)
	self:SetStackCount(#C)
end
function ah.prototype.EOM_GetModifierOutgoingDamagePercentage(self)
	return self.damage_bonus * self:GetStackCount()
end
ah = e(
	{
		q(
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
	ah
)
k.modifier_tinker_talent_5 = ah
k.tinker_talent_6 = c()
local ai = k.tinker_talent_6
ai.name = "tinker_talent_6"
d(ai, m)
function ai.prototype.GetIntrinsicModifierName(self)
	return "modifier_tinker_talent_6"
end
ai = e({ n(nil) }, ai)
k.tinker_talent_6 = ai
k.modifier_tinker_talent_6 = c()
local aj = k.modifier_tinker_talent_6
aj.name = "modifier_tinker_talent_6"
d(aj, p)
function aj.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function aj.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function aj.prototype.OnCustomTakeDamage(self, a8)
	if self.chance > 0 and a8.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL and self:PRD(self.chance) then
		local ak = self:GetParent():FindAbilityByName("tinker_ult")
		if ak ~= nil then
			ak:Launch(a8.target)
		end
	end
end
aj = e(
	{
		q(
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
	aj
)
k.modifier_tinker_talent_6 = aj
k.tinker_talent_8 = c()
local al = k.tinker_talent_8
al.name = "tinker_talent_8"
d(al, m)
function al.prototype.GetIntrinsicModifierName(self)
	return "modifier_tinker_talent_8"
end
al = e({ n(nil) }, al)
k.tinker_talent_8 = al
k.modifier_tinker_talent_8 = c()
local am = k.modifier_tinker_talent_8
am.name = "modifier_tinker_talent_8"
d(am, p)
function am.prototype.GetAbilitySpecialValue(self)
	self.exp_reduce = self:GetAbilitySpecialValueFor("exp_reduce")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function am.prototype.AddCustomTransmitterData(self)
	return { tl8_list = self.tl8_list }
end
function am.prototype.HandleCustomTransmitterData(self, an)
	self.tl8_list = an.tl8_list
end
function am.prototype.loadDataTl8(self)
	local ao = self:GetParent():GetPlayerOwnerID()
	local ap = PlayerData:loadData(ao, "tinker_talent_8")
	local aq = PlayerData:getplayerData(ao)
	if aq then
		if ap == nil then
			local ar = {}
			local as = aq.bannedSect and i(AbilityShop.pickList, function(D, at)
				return at ~= aq.bannedSect
			end) or AbilityShop.pickList
			while #ar < self.count do
				local au = as[RandomInt(0, #as - 1) + 1]
				if not f(ar, au) then
					ar[#ar + 1] = au
				end
			end
			ap = {}
			do
				local ae = 0
				while ae < #ar do
					ap[ar[ae + 1]] = true
					ae = ae + 1
				end
			end
			PlayerData:saveData(ao, "tinker_talent_8", ap)
		end
	end
	self.tl8_list = ap
end
function am.prototype.OnCreated(self, w)
	if IsServer() then
		self:loadDataTl8()
		self:SetHasCustomTransmitterData(true)
	end
end
function am.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SECT_EXP_REDUCE }
end
function am.prototype.EOM_GetModifierSectExpReduce(self, w)
	if w and w.sect and self.tl8_list ~= nil and self.tl8_list[w.sect] then
		return self.exp_reduce
	end
end
am = e(
	{
		q(
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
	am
)
k.modifier_tinker_talent_8 = am
return k