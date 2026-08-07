--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/troll_warlord"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 2,
		["16"] = 2,
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
		["34"] = 26,
		["35"] = 27,
		["36"] = 26,
		["37"] = 29,
		["38"] = 31,
		["39"] = 32,
		["40"] = 33,
		["41"] = 34,
		["42"] = 36,
		["43"] = 37,
		["44"] = 38,
		["46"] = 29,
		["47"] = 41,
		["48"] = 42,
		["49"] = 43,
		["50"] = 43,
		["51"] = 43,
		["52"] = 42,
		["53"] = 44,
		["54"] = 44,
		["55"] = 44,
		["56"] = 42,
		["57"] = 42,
		["58"] = 41,
		["59"] = 47,
		["60"] = 48,
		["63"] = 49,
		["66"] = 50,
		["67"] = 51,
		["69"] = 47,
		["70"] = 54,
		["71"] = 55,
		["72"] = 56,
		["75"] = 57,
		["76"] = 58,
		["79"] = 54,
		["80"] = 62,
		["81"] = 63,
		["82"] = 64,
		["83"] = 65,
		["86"] = 66,
		["87"] = 66,
		["88"] = 66,
		["89"] = 66,
		["90"] = 66,
		["91"] = 66,
		["92"] = 66,
		["93"] = 67,
		["94"] = 68,
		["95"] = 68,
		["96"] = 68,
		["97"] = 68,
		["98"] = 68,
		["99"] = 68,
		["100"] = 69,
		["101"] = 70,
		["102"] = 70,
		["103"] = 70,
		["104"] = 70,
		["105"] = 70,
		["106"] = 70,
		["107"] = 70,
		["108"] = 70,
		["109"] = 70,
		["110"] = 71,
		["111"] = 72,
		["112"] = 62,
		["113"] = 20,
		["114"] = 12,
		["115"] = 12,
		["116"] = 12,
		["117"] = 12,
		["118"] = 12,
		["119"] = 12,
		["120"] = 12,
		["121"] = 12,
		["122"] = 20,
		["124"] = 20,
		["126"] = 78,
		["127"] = 79,
		["128"] = 78,
		["129"] = 79,
		["130"] = 80,
		["131"] = 81,
		["132"] = 82,
		["133"] = 83,
		["136"] = 86,
		["137"] = 87,
		["138"] = 88,
		["139"] = 89,
		["140"] = 90,
		["141"] = 90,
		["142"] = 90,
		["143"] = 90,
		["144"] = 90,
		["145"] = 90,
		["146"] = 90,
		["147"] = 91,
		["148"] = 92,
		["149"] = 92,
		["150"] = 92,
		["151"] = 92,
		["152"] = 92,
		["153"] = 97,
		["154"] = 98,
		["155"] = 99,
		["156"] = 100,
		["157"] = 100,
		["158"] = 100,
		["159"] = 100,
		["160"] = 100,
		["161"] = 100,
		["162"] = 100,
		["163"] = 100,
		["164"] = 100,
		["166"] = 92,
		["167"] = 92,
		["168"] = 120,
		["169"] = 121,
		["170"] = 122,
		["171"] = 123,
		["172"] = 124,
		["173"] = 125,
		["174"] = 126,
		["175"] = 127,
		["177"] = 128,
		["178"] = 128,
		["179"] = 129,
		["180"] = 130,
		["181"] = 131,
		["183"] = 133,
		["184"] = 134,
		["185"] = 135,
		["186"] = 135,
		["187"] = 135,
		["188"] = 135,
		["189"] = 135,
		["190"] = 135,
		["191"] = 135,
		["192"] = 135,
		["193"] = 135,
		["194"] = 136,
		["195"] = 128,
		["198"] = 138,
		["199"] = 138,
		["200"] = 138,
		["201"] = 139,
		["202"] = 139,
		["203"] = 139,
		["204"] = 140,
		["205"] = 139,
		["206"] = 139,
		["207"] = 138,
		["208"] = 138,
		["209"] = 80,
		["210"] = 79,
		["211"] = 78,
		["212"] = 79,
		["214"] = 79,
		["216"] = 148,
		["217"] = 149,
		["218"] = 148,
		["219"] = 149,
		["220"] = 150,
		["221"] = 151,
		["222"] = 150,
		["223"] = 149,
		["224"] = 148,
		["225"] = 149,
		["227"] = 149,
		["228"] = 154,
		["229"] = 162,
		["230"] = 154,
		["231"] = 162,
		["232"] = 167,
		["233"] = 169,
		["234"] = 170,
		["235"] = 171,
		["236"] = 172,
		["237"] = 167,
		["238"] = 174,
		["239"] = 175,
		["240"] = 176,
		["241"] = 176,
		["242"] = 175,
		["243"] = 174,
		["244"] = 179,
		["245"] = 180,
		["248"] = 181,
		["251"] = 182,
		["254"] = 183,
		["255"] = 184,
		["256"] = 185,
		["257"] = 186,
		["260"] = 187,
		["261"] = 188,
		["262"] = 189,
		["263"] = 190,
		["264"] = 190,
		["265"] = 190,
		["266"] = 190,
		["267"] = 190,
		["268"] = 190,
		["269"] = 191,
		["270"] = 192,
		["271"] = 192,
		["272"] = 192,
		["273"] = 192,
		["274"] = 192,
		["275"] = 192,
		["276"] = 193,
		["277"] = 193,
		["278"] = 193,
		["279"] = 193,
		["280"] = 193,
		["281"] = 193,
		["282"] = 193,
		["283"] = 193,
		["284"] = 193,
		["285"] = 194,
		["286"] = 196,
		["287"] = 197,
		["288"] = 197,
		["289"] = 197,
		["290"] = 197,
		["291"] = 197,
		["294"] = 179,
		["295"] = 203,
		["296"] = 204,
		["297"] = 203,
		["298"] = 162,
		["299"] = 154,
		["300"] = 154,
		["301"] = 154,
		["302"] = 154,
		["303"] = 154,
		["304"] = 154,
		["305"] = 154,
		["306"] = 154,
		["307"] = 162,
		["309"] = 162,
		["311"] = 210,
		["312"] = 211,
		["313"] = 210,
		["314"] = 211,
		["315"] = 212,
		["316"] = 213,
		["317"] = 214,
		["318"] = 215,
		["321"] = 216,
		["322"] = 217,
		["323"] = 218,
		["324"] = 219,
		["325"] = 220,
		["326"] = 220,
		["327"] = 220,
		["328"] = 220,
		["329"] = 220,
		["330"] = 220,
		["331"] = 221,
		["332"] = 221,
		["333"] = 221,
		["334"] = 221,
		["335"] = 221,
		["336"] = 221,
		["337"] = 221,
		["338"] = 221,
		["339"] = 221,
		["340"] = 230,
		["341"] = 212,
		["342"] = 211,
		["343"] = 210,
		["344"] = 211,
		["346"] = 211,
		["347"] = 242,
		["348"] = 251,
		["349"] = 242,
		["350"] = 251,
		["352"] = 251,
		["353"] = 252,
		["354"] = 242,
		["355"] = 255,
		["356"] = 256,
		["357"] = 257,
		["358"] = 258,
		["360"] = 261,
		["361"] = 262,
		["362"] = 263,
		["363"] = 264,
		["364"] = 265,
		["365"] = 266,
		["366"] = 266,
		["367"] = 266,
		["368"] = 266,
		["369"] = 266,
		["370"] = 266,
		["371"] = 266,
		["372"] = 266,
		["373"] = 266,
		["374"] = 267,
		["375"] = 267,
		["376"] = 267,
		["377"] = 267,
		["378"] = 267,
		["379"] = 267,
		["380"] = 267,
		["381"] = 267,
		["382"] = 267,
		["383"] = 268,
		["384"] = 268,
		["385"] = 268,
		["386"] = 268,
		["387"] = 268,
		["388"] = 269,
		["389"] = 270,
		["390"] = 270,
		["391"] = 270,
		["392"] = 270,
		["393"] = 270,
		["394"] = 270,
		["395"] = 270,
		["396"] = 270,
		["397"] = 270,
		["398"] = 271,
		["399"] = 271,
		["400"] = 271,
		["401"] = 271,
		["402"] = 271,
		["403"] = 271,
		["404"] = 271,
		["405"] = 271,
		["406"] = 271,
		["407"] = 272,
		["408"] = 272,
		["409"] = 272,
		["410"] = 272,
		["411"] = 272,
		["412"] = 273,
		["413"] = 273,
		["414"] = 274,
		["415"] = 274,
		["416"] = 275,
		["417"] = 275,
		["418"] = 275,
		["419"] = 275,
		["420"] = 275,
		["421"] = 275,
		["422"] = 275,
		["423"] = 275,
		["424"] = 276,
		["425"] = 276,
		["426"] = 276,
		["427"] = 276,
		["428"] = 276,
		["429"] = 276,
		["430"] = 276,
		["431"] = 276,
		["432"] = 277,
		["434"] = 255,
		["435"] = 280,
		["436"] = 281,
		["437"] = 282,
		["438"] = 283,
		["439"] = 283,
		["440"] = 283,
		["441"] = 284,
		["442"] = 285,
		["443"] = 285,
		["444"] = 285,
		["445"] = 285,
		["446"] = 285,
		["447"] = 285,
		["448"] = 285,
		["449"] = 285,
		["450"] = 285,
		["452"] = 287,
		["453"] = 287,
		["454"] = 287,
		["455"] = 287,
		["456"] = 287,
		["457"] = 287,
		["458"] = 287,
		["459"] = 287,
		["460"] = 287,
		["462"] = 283,
		["463"] = 283,
		["464"] = 280,
		["465"] = 251,
		["466"] = 242,
		["467"] = 242,
		["468"] = 242,
		["469"] = 242,
		["470"] = 242,
		["471"] = 242,
		["472"] = 242,
		["473"] = 242,
		["474"] = 242,
		["475"] = 251,
		["477"] = 251,
		["479"] = 297,
		["480"] = 306,
		["481"] = 297,
		["482"] = 306,
		["483"] = 307,
		["484"] = 308,
		["485"] = 309,
		["487"] = 307,
		["488"] = 312,
		["489"] = 313,
		["490"] = 314,
		["491"] = 315,
		["492"] = 316,
		["493"] = 317,
		["494"] = 318,
		["495"] = 319,
		["497"] = 321,
		["498"] = 322,
		["499"] = 323,
		["501"] = 325,
		["503"] = 312,
		["504"] = 328,
		["505"] = 329,
		["506"] = 328,
		["507"] = 306,
		["508"] = 297,
		["509"] = 297,
		["510"] = 297,
		["511"] = 297,
		["512"] = 297,
		["513"] = 297,
		["514"] = 297,
		["515"] = 297,
		["516"] = 306,
		["518"] = 306,
		["519"] = 332,
		["520"] = 340,
		["521"] = 332,
		["522"] = 340,
		["523"] = 353,
		["524"] = 354,
		["525"] = 353,
		["526"] = 356,
		["527"] = 357,
		["528"] = 358,
		["529"] = 359,
		["530"] = 361,
		["531"] = 362,
		["532"] = 364,
		["533"] = 365,
		["534"] = 367,
		["535"] = 368,
		["536"] = 369,
		["537"] = 370,
		["539"] = 356,
		["540"] = 373,
		["541"] = 374,
		["542"] = 374,
		["543"] = 374,
		["544"] = 374,
		["545"] = 373,
		["546"] = 379,
		["547"] = 380,
		["550"] = 381,
		["553"] = 382,
		["554"] = 383,
		["555"] = 383,
		["556"] = 383,
		["557"] = 383,
		["559"] = 379,
		["560"] = 386,
		["561"] = 387,
		["562"] = 388,
		["563"] = 389,
		["564"] = 390,
		["567"] = 391,
		["568"] = 392,
		["569"] = 392,
		["570"] = 392,
		["571"] = 392,
		["572"] = 392,
		["573"] = 392,
		["574"] = 392,
		["576"] = 394,
		["577"] = 395,
		["578"] = 396,
		["579"] = 397,
		["582"] = 398,
		["583"] = 399,
		["584"] = 399,
		["585"] = 399,
		["586"] = 399,
		["587"] = 399,
		["588"] = 399,
		["589"] = 399,
		["591"] = 386,
		["592"] = 402,
		["593"] = 403,
		["594"] = 404,
		["597"] = 405,
		["598"] = 406,
		["599"] = 407,
		["600"] = 408,
		["601"] = 409,
		["602"] = 410,
		["603"] = 410,
		["604"] = 410,
		["605"] = 410,
		["606"] = 410,
		["607"] = 410,
		["611"] = 402,
		["612"] = 417,
		["613"] = 418,
		["614"] = 419,
		["615"] = 420,
		["616"] = 421,
		["618"] = 417,
		["619"] = 424,
		["620"] = 425,
		["621"] = 424,
		["622"] = 429,
		["623"] = 430,
		["624"] = 429,
		["625"] = 340,
		["626"] = 332,
		["627"] = 332,
		["628"] = 332,
		["629"] = 332,
		["630"] = 332,
		["631"] = 332,
		["632"] = 332,
		["633"] = 332,
		["634"] = 340,
		["636"] = 340,
		["637"] = 434,
		["638"] = 442,
		["639"] = 434,
		["640"] = 442,
		["641"] = 443,
		["642"] = 444,
		["643"] = 445,
		["645"] = 443,
		["646"] = 448,
		["647"] = 449,
		["648"] = 448,
		["649"] = 453,
		["650"] = 454,
		["651"] = 453,
		["652"] = 442,
		["653"] = 434,
		["654"] = 434,
		["655"] = 434,
		["656"] = 434,
		["657"] = 434,
		["658"] = 434,
		["659"] = 434,
		["660"] = 434,
		["661"] = 442,
		["663"] = 442,
		["664"] = 457,
		["665"] = 465,
		["666"] = 457,
		["667"] = 465,
		["668"] = 466,
		["669"] = 467,
		["670"] = 468,
		["672"] = 466,
		["673"] = 471,
		["674"] = 472,
		["675"] = 471,
		["676"] = 476,
		["677"] = 477,
		["678"] = 476,
		["679"] = 465,
		["680"] = 457,
		["681"] = 457,
		["682"] = 457,
		["683"] = 457,
		["684"] = 457,
		["685"] = 457,
		["686"] = 457,
		["687"] = 457,
		["688"] = 465,
		["690"] = 465,
		["691"] = 481,
		["692"] = 489,
		["693"] = 481,
		["694"] = 489,
		["695"] = 492,
		["696"] = 493,
		["697"] = 494,
		["698"] = 492,
		["699"] = 496,
		["700"] = 497,
		["701"] = 496,
		["702"] = 489,
		["703"] = 481,
		["704"] = 481,
		["705"] = 481,
		["706"] = 481,
		["707"] = 481,
		["708"] = 481,
		["709"] = 481,
		["710"] = 481,
		["711"] = 489,
		["713"] = 489,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("abilities.interact_ability")
local m = l.InteractAbility
local n = l.InteractBaseAbility
local o = l.registerInteractAbility
local p = l.registerInteractBaseAbility
h.troll_warlord_talent = c()
local q = h.troll_warlord_talent
q.name = "troll_warlord_talent"
d(q, n)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_troll_warlord_talent"
end
q = e({ p(nil) }, q)
h.troll_warlord_talent = q
h.modifier_troll_warlord_talent = c()
local r = h.modifier_troll_warlord_talent
r.name = "modifier_troll_warlord_talent"
d(r, j)
function r.prototype.IsActivated(self)
	return self:GetAbility():GetToggleState()
end
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
		+ self:GetAbilityTalentValue("troll_warlord_talent_1", "bonus_chance")
	self.ice = self:GetAbilitySpecialValueFor("ice")
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.buff_damage = self:GetAbilitySpecialValueFor("buff_damage")
	self.tl6_chance = self:GetAbilityTalentValue("troll_warlord_talent_6", "chance")
	if IsServer() then
		self:GetParent():AddActivityModifier("walk")
	end
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
	}
end
function r.prototype.OnCustomAttackLanded(self, s)
	if not self:IsActivated() then
		return
	end
	if self:GetParent():PassivesDisabled() then
		return
	end
	if self:PRD(self.chance) then
		self:Effect()
	end
end
function r.prototype.OnCustomTakeDamage(self, s)
	if self.tl6_chance > 0 then
		if s.ability and s.ability == self:GetAbility() then
			return
		end
		if s.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL and self:PRD(self.tl6_chance, "tl6_chance") then
			self:Effect()
		end
	end
end
function r.prototype.Effect(self)
	local t = self:GetParent()
	local u = t:GetEnemy()
	if not IsInjurable(t, u) then
		return
	end
	AddIce(t, u, self.ice, "troll_warlord_talent", "Ability")
	local v = self.base_damage + self.buff_damage * GetIce(u) * 0.01
	t:DealDamage(u, self:GetAbility(), v, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	local w = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_troll_warlord/troll_warlord_net_cast_sparks.vpcf",
		PATTACH_ABSORIGIN,
		u,
		t
	)
	ParticleManager:SetParticleControlEnt(w, 1, u, PATTACH_POINT_FOLLOW, "attach_hitloc", u:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(w)
	u:EmitSound("Hero_TrollWarlord.BerserkersRage.Stun")
end
r = e(
	{
		k(
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
h.modifier_troll_warlord_talent = r
h.troll_warlord_ult = c()
local x = h.troll_warlord_ult
x.name = "troll_warlord_ult"
d(x, n)
function x.prototype.OnSpellStart(self, y)
	local z = self:GetCaster()
	local u = z:GetEnemy()
	if not IsInjurable(z, u) then
		return
	end
	z:StartGesture(ACT_DOTA_CAST_ABILITY_3)
	local v = self:GetSpecialValueFor("damage")
	local A = self:GetSpecialValueFor("buff_pct")
	local B = self:GetSpecialValueFor("base_buff")
	AddIce(z, u, B + GetFury(z) * A * 0.01, "troll_warlord_ult", "Ability")
	z:EmitSound("Hero_TrollWarlord.WhirlingAxes.Ranged")
	Projectile:CreateTrackingProjectile({
		hCaster = z,
		vSpawnOrigin = z:GetAttachmentPosition("attach_hitloc"),
		hTarget = u,
		iMoveSpeed = 1500,
		OnProjectileHit = function(C, D, E)
			if IsValid(self) and IsInjurable(z, u) then
				u:EmitSound("Hero_TrollWarlord.WhirlingAxes.Target")
				DamageSystem:dealDamage({
					attacker = z,
					target = u,
					ability = self,
					damage = v,
					damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
					damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
					damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
				})
			end
		end,
	})
	local F = 5
	local G = 5
	local H = 1500
	local I = z:GetAbsOrigin()
	local J = u:GetAbsOrigin() - I
	J.z = 0
	J = J:Normalized()
	local K = {}
	do
		local L = 0
		while L < F do
			local M = G * math.ceil(L / 2)
			if L % 2 == 0 then
				M = M * -1
			end
			local w = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_troll_warlord/troll_warlord_whirling_axe_ranged.vpcf",
				PATTACH_CUSTOMORIGIN,
				z
			)
			ParticleManager:SetParticleControl(w, 0, I)
			ParticleManager:SetParticleControl(w, 1, Rotation2D(nil, J, math.rad(M)) * H)
			K[#K + 1] = w
			L = L + 1
		end
	end
	GameTimer(0.63, function()
		f(K, function(N, w)
			ParticleManager:DestroyParticle(w, false)
		end)
	end)
end
x = e({ p(nil) }, x)
h.troll_warlord_ult = x
h.troll_warlord_talent_s = c()
local O = h.troll_warlord_talent_s
O.name = "troll_warlord_talent_s"
d(O, n)
function O.prototype.GetIntrinsicModifierName(self)
	return "modifier_troll_warlord_talent_s"
end
O = e({ p(nil) }, O)
h.troll_warlord_talent_s = O
h.modifier_troll_warlord_talent_s = c()
local P = h.modifier_troll_warlord_talent_s
P.name = "modifier_troll_warlord_talent_s"
d(P, j)
function P.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
		+ self:GetAbilityTalentValue("troll_warlord_talent_1", "bonus_chance")
	self.fury = self:GetAbilitySpecialValueFor("fury")
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.buff_damage = self:GetAbilitySpecialValueFor("buff_damage")
end
function P.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function P.prototype.OnCustomAttackLanded(self, s)
	if not self:IsActivated() then
		return
	end
	if self:GetParent():PassivesDisabled() then
		return
	end
	if s.ability and s.ability == self:GetAbility() then
		return
	end
	if self:PRD(self.chance) then
		local t = self:GetParent()
		local u = t:GetEnemy()
		if not IsInjurable(t, u) then
			return
		end
		AddFury(t, self.fury, "troll_warlord_talent_s", "Ability")
		u:EmitSound("Hero_TrollWarlord.BerserkersRage.Stun")
		local v = self.base_damage + self.buff_damage * GetFury(t) * 0.01
		t:DealDamage(u, self:GetAbility(), v, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
		local w = ParticleManager:CreateParticle(
			"particles/econ/items/troll_warlord/troll_warlord_ti7_axe/troll_ti7_axe_bash_impact_burst.vpcf",
			PATTACH_ABSORIGIN,
			u,
			t
		)
		ParticleManager:SetParticleControlTransform(w, 1, u:GetAbsOrigin(), VectorAngles(t:GetForwardVector()))
		ParticleManager:SetParticleControlEnt(w, 3, u, PATTACH_POINT_FOLLOW, "attach_hitloc", u:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(w)
		if self:HasTalent("troll_warlord_talent_5") then
			DamageSystem:performAttack(t, u, { ability = self:GetAbility() })
		end
	end
end
function P.prototype.IsActivated(self)
	return self:GetAbility():GetToggleState()
end
P = e(
	{
		k(
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
	P
)
h.modifier_troll_warlord_talent_s = P
h.troll_warlord_ult_s = c()
local Q = h.troll_warlord_ult_s
Q.name = "troll_warlord_ult_s"
d(Q, n)
function Q.prototype.OnSpellStart(self, y)
	local z = self:GetCaster()
	local u = z:GetEnemy()
	if not IsInjurable(z, u) then
		return
	end
	local v = self:GetSpecialValueFor("damage")
	local A = self:GetSpecialValueFor("buff_pct")
	local B = self:GetSpecialValueFor("base_buff")
	z:StartGesture(ACT_DOTA_CAST_ABILITY_3)
	AddFury(z, B + GetIce(u) * A * 0.01, "troll_warlord_ult_s", "Ability")
	DamageSystem:dealDamage({
		attacker = z,
		target = u,
		ability = self,
		damage = v,
		damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
		damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
		damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
	})
	z:AddNewModifier(z, self, "modifier_troll_warlord_ult_s_cast", { duration = 1 })
end
Q = e({ p(nil) }, Q)
h.troll_warlord_ult_s = Q
h.modifier_troll_warlord_ult_s_cast = c()
local R = h.modifier_troll_warlord_ult_s_cast
R.name = "modifier_troll_warlord_ult_s_cast"
d(R, j)
function R.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.angleSpeed = 360
end
function R.prototype.OnCreated(self, S)
	if IsServer() then
		local t = self:GetParent()
		t:EmitSound("Hero_TrollWarlord.WhirlingAxes.Melee")
	else
		local t = self:GetParent()
		local T = self:GetDuration()
		self.ticks = 0
		self.ParticleList = {}
		local w = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_troll_warlord/troll_warlord_whirling_axe_melee.vpcf",
			PATTACH_CUSTOMORIGIN,
			t
		)
		ParticleManager:SetParticleControlEnt(w, 0, t, PATTACH_POINT_FOLLOW, "attach_hitloc", t:GetAbsOrigin(), true)
		ParticleManager:SetParticleControl(
			w,
			1,
			t:GetAbsOrigin()
				+ Rotation2D(nil, vec3_top, math.rad(self.angleSpeed * FRAME_TIME * self.ticks)) * 150
				+ Vector(0, 0, 96)
		)
		ParticleManager:SetParticleControl(w, 4, Vector(T, T, T))
		local U = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_troll_warlord/troll_warlord_whirling_axe_melee.vpcf",
			PATTACH_CUSTOMORIGIN,
			t
		)
		ParticleManager:SetParticleControlEnt(U, 0, t, PATTACH_POINT_FOLLOW, "attach_hitloc", t:GetAbsOrigin(), true)
		ParticleManager:SetParticleControl(
			U,
			1,
			t:GetAbsOrigin()
				+ Rotation2D(nil, vec3_bottom, math.rad(self.angleSpeed * FRAME_TIME * self.ticks)) * 150
				+ Vector(0, 0, 96)
		)
		ParticleManager:SetParticleControl(U, 4, Vector(T, T, T))
		local V = self.ParticleList
		V[#V + 1] = w
		local W = self.ParticleList
		W[#W + 1] = U
		self:AddParticle(w, false, false, -1, false, false)
		self:AddParticle(U, false, false, -1, false, false)
		self:StartIntervalThink(0)
	end
end
function R.prototype.OnIntervalThink(self)
	local t = self:GetParent()
	self.ticks = self.ticks + 1
	f(self.ParticleList, function(N, w, X)
		if X == 0 then
			ParticleManager:SetParticleControl(
				w,
				1,
				t:GetAbsOrigin()
					+ Rotation2D(nil, vec3_top, math.rad(self.angleSpeed * FRAME_TIME * self.ticks)) * 150
					+ Vector(0, 0, 96)
			)
		else
			ParticleManager:SetParticleControl(
				w,
				1,
				t:GetAbsOrigin()
					+ Rotation2D(nil, vec3_bottom, math.rad(self.angleSpeed * FRAME_TIME * self.ticks)) * 150
					+ Vector(0, 0, 96)
			)
		end
	end)
end
R = e(
	{
		k(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	R
)
h.modifier_troll_warlord_ult_s_cast = R
h.troll_warlord_interact = c()
local Y = h.troll_warlord_interact
Y.name = "troll_warlord_interact"
d(Y, m)
function Y.prototype.Spawn(self)
	if IsServer() then
		self:GetCaster():RemoveActivityModifier("melee")
	end
end
function Y.prototype.OnToggle(self)
	if IsServer() then
		local z = self:GetCaster()
		local Z = self:GetToggleState()
		if Z then
			z:AddActivityModifier("melee")
			z:RemoveModifierByName("modifier_troll_warlord_range")
			z:AddNewModifier(z, self, "modifier_troll_warlord_melee", nil)
		else
			z:RemoveActivityModifier("melee")
			z:RemoveModifierByName("modifier_troll_warlord_melee")
			z:AddNewModifier(z, self, "modifier_troll_warlord_range", nil)
		end
		z:RemoveGesture(ACT_DOTA_SPAWN)
	end
end
function Y.prototype.GetIntrinsicModifierName(self)
	return "modifier_troll_warlord_interact"
end
Y = e(
	{
		o(
			nil,
			{
				ActiveTextureName = "troll_warlord_fervor",
				InactiveTextureName = "troll_warlord_fervor_active",
				talent_ability1 = "troll_warlord_talent",
				talent_ability2 = "troll_warlord_talent_s",
				ult_ability1 = "troll_warlord_ult",
				ult_ability2 = "troll_warlord_ult_s",
			}
		),
	},
	Y
)
h.troll_warlord_interact = Y
h.modifier_troll_warlord_interact = c()
local _ = h.modifier_troll_warlord_interact
_.name = "modifier_troll_warlord_interact"
d(_, j)
function _.prototype.GetTexture(self)
	return "modifier_troll_warlord_interact"
end
function _.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.max = self:GetAbilitySpecialValueFor("max")
	self.duration = self:GetAbilitySpecialValueFor("duration")
		+ self:GetAbilityTalentValue("troll_warlord_talent_7", "duration")
	self.tl3_buff_pct = self:GetAbilityTalentValue("troll_warlord_talent_3", "buff_pct")
	self.tl3_base = self:GetAbilityTalentValue("troll_warlord_talent_3", "base")
	self.tl4_buff_pct = self:GetAbilityTalentValue("troll_warlord_talent_4", "buff_pct")
	self.tl4_base = self:GetAbilityTalentValue("troll_warlord_talent_4", "base")
	self.s_ice = self:GetAbilityTalentValue("troll_warlord_shard", "ice")
	self.s_fury = self:GetAbilityTalentValue("troll_warlord_shard", "fury")
	if IsServer() then
		self.maxed = false
	end
end
function _.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent() },
	}
end
function _.prototype.OnDamageStart(self, s)
	if self.maxed then
		return
	end
	if self:GetParent():PassivesDisabled() then
		return
	end
	if s.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		self:SetStackCount(math.min(self.max, self:GetStackCount() + 1))
	end
end
function _.prototype.OnCustomTakeDamage(self, s)
	if self.tl3_buff_pct > 0 and s.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL then
		local t = self:GetParent()
		local u = t:GetEnemy()
		if not IsInjurable(t, u) then
			return
		end
		local v = self.tl3_base + GetFury(t) * self.tl3_buff_pct * 0.01
		t:DealDamage(u, self:GetAbility(), v, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, DamageFlags.DAMAGE_FLAG_HPLOSS)
	end
	if self.tl4_buff_pct > 0 and s.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL then
		local t = self:GetParent()
		local u = t:GetEnemy()
		if not IsInjurable(t, u) then
			return
		end
		local v = self.tl4_base + GetIce(u) * self.tl4_buff_pct * 0.01
		t:DealDamage(u, self:GetAbility(), v, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, DamageFlags.DAMAGE_FLAG_HPLOSS)
	end
end
function _.prototype.OnStackCountChanged(self, a0)
	if IsServer() then
		if self.maxed then
			return
		end
		if self:GetStackCount() == self.max then
			self.maxed = true
			self:StartIntervalThink(self.duration)
			if self.s_fury > 0 or self.s_ice > 0 then
				local t = self:GetParent()
				t:AddNewModifier(t, self:GetAbility(), "modifier_troll_warlord_shard", { duration = self.duration })
			end
		end
	end
end
function _.prototype.OnIntervalThink(self)
	if IsServer() then
		self.maxed = false
		self:SetStackCount(0)
		self:StartIntervalThink(-1)
	end
end
function _.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function _.prototype.EOM_GetModifierAttackSpeedBonus(self, S)
	return self:GetStackCount()
		* (self.attackspeed + self:GetAbilityTalentValue("troll_warlord_talent_7", "attackspeed"))
end
_ = e(
	{
		k(
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
	_
)
h.modifier_troll_warlord_interact = _
h.modifier_troll_warlord_melee = c()
local a1 = h.modifier_troll_warlord_melee
a1.name = "modifier_troll_warlord_melee"
d(a1, j)
function a1.prototype.OnCreated(self, S)
	if IsServer() then
		self:GetParent():SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
	end
end
function a1.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function a1.prototype.GetActivityTranslationModifiers(self)
	return "melee"
end
a1 = e(
	{
		k(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_ULTRA,
			}
		),
	},
	a1
)
h.modifier_troll_warlord_melee = a1
h.modifier_troll_warlord_range = c()
local a2 = h.modifier_troll_warlord_range
a2.name = "modifier_troll_warlord_range"
d(a2, j)
function a2.prototype.OnCreated(self, S)
	if IsServer() then
		self:GetParent():SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)
	end
end
function a2.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function a2.prototype.GetActivityTranslationModifiers(self)
	return ""
end
a2 = e(
	{
		k(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_ULTRA,
			}
		),
	},
	a2
)
h.modifier_troll_warlord_range = a2
h.modifier_troll_warlord_shard = c()
local a3 = h.modifier_troll_warlord_shard
a3.name = "modifier_troll_warlord_shard"
d(a3, j)
function a3.prototype.GetAbilitySpecialValue(self)
	self.s_ice = self:GetAbilityTalentValue("troll_warlord_shard", "ice")
	self.s_fury = self:GetAbilityTalentValue("troll_warlord_shard", "fury")
end
function a3.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_PERMANENT] = self.s_fury,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_PERMANENT_SOURCE] = self.s_ice,
	}
end
a3 = e(
	{
		k(
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
	a3
)
h.modifier_troll_warlord_shard = a3
return h