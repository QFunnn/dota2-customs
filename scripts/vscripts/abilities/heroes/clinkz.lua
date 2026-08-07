--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/clinkz"
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
		["30"] = 13,
		["31"] = 21,
		["32"] = 13,
		["33"] = 21,
		["34"] = 30,
		["35"] = 31,
		["36"] = 32,
		["37"] = 33,
		["38"] = 34,
		["39"] = 36,
		["40"] = 39,
		["41"] = 41,
		["42"] = 42,
		["43"] = 43,
		["44"] = 44,
		["46"] = 30,
		["47"] = 47,
		["48"] = 48,
		["49"] = 47,
		["50"] = 53,
		["51"] = 55,
		["52"] = 55,
		["53"] = 55,
		["54"] = 55,
		["55"] = 53,
		["56"] = 58,
		["57"] = 60,
		["58"] = 58,
		["59"] = 68,
		["60"] = 69,
		["61"] = 69,
		["62"] = 71,
		["63"] = 71,
		["64"] = 71,
		["65"] = 69,
		["66"] = 72,
		["67"] = 72,
		["68"] = 72,
		["69"] = 69,
		["70"] = 73,
		["71"] = 73,
		["72"] = 73,
		["73"] = 69,
		["74"] = 69,
		["75"] = 68,
		["76"] = 76,
		["77"] = 77,
		["78"] = 78,
		["79"] = 78,
		["80"] = 78,
		["81"] = 78,
		["83"] = 76,
		["84"] = 81,
		["85"] = 85,
		["86"] = 85,
		["87"] = 85,
		["88"] = 85,
		["89"] = 85,
		["90"] = 85,
		["91"] = 81,
		["92"] = 87,
		["93"] = 88,
		["94"] = 89,
		["95"] = 89,
		["96"] = 89,
		["97"] = 89,
		["98"] = 89,
		["99"] = 89,
		["101"] = 87,
		["102"] = 92,
		["103"] = 93,
		["104"] = 94,
		["105"] = 95,
		["106"] = 96,
		["107"] = 96,
		["108"] = 96,
		["109"] = 96,
		["110"] = 96,
		["111"] = 96,
		["114"] = 92,
		["115"] = 100,
		["116"] = 101,
		["117"] = 100,
		["118"] = 107,
		["119"] = 109,
		["120"] = 107,
		["121"] = 112,
		["122"] = 113,
		["123"] = 113,
		["124"] = 113,
		["125"] = 113,
		["126"] = 112,
		["127"] = 115,
		["128"] = 117,
		["129"] = 115,
		["130"] = 120,
		["131"] = 122,
		["132"] = 120,
		["133"] = 21,
		["134"] = 13,
		["135"] = 13,
		["136"] = 13,
		["137"] = 13,
		["138"] = 13,
		["139"] = 13,
		["140"] = 13,
		["141"] = 13,
		["142"] = 21,
		["144"] = 21,
		["146"] = 128,
		["147"] = 129,
		["148"] = 128,
		["149"] = 129,
		["150"] = 130,
		["151"] = 131,
		["152"] = 132,
		["153"] = 133,
		["156"] = 136,
		["157"] = 137,
		["158"] = 130,
		["159"] = 141,
		["160"] = 141,
		["161"] = 141,
		["163"] = 142,
		["164"] = 143,
		["165"] = 144,
		["168"] = 147,
		["169"] = 148,
		["170"] = 149,
		["171"] = 151,
		["172"] = 152,
		["173"] = 153,
		["174"] = 154,
		["176"] = 156,
		["177"] = 157,
		["178"] = 158,
		["179"] = 159,
		["180"] = 161,
		["181"] = 163,
		["182"] = 164,
		["183"] = 165,
		["184"] = 166,
		["185"] = 167,
		["186"] = 168,
		["187"] = 168,
		["188"] = 168,
		["189"] = 168,
		["190"] = 168,
		["191"] = 168,
		["192"] = 168,
		["193"] = 168,
		["194"] = 176,
		["195"] = 177,
		["196"] = 178,
		["197"] = 179,
		["199"] = 168,
		["200"] = 168,
		["201"] = 141,
		["202"] = 129,
		["203"] = 128,
		["204"] = 129,
		["206"] = 129,
		["207"] = 186,
		["208"] = 195,
		["209"] = 186,
		["210"] = 195,
		["211"] = 199,
		["212"] = 200,
		["213"] = 201,
		["214"] = 202,
		["215"] = 203,
		["216"] = 203,
		["218"] = 199,
		["219"] = 206,
		["220"] = 207,
		["221"] = 208,
		["222"] = 209,
		["224"] = 206,
		["225"] = 212,
		["226"] = 213,
		["227"] = 214,
		["229"] = 212,
		["230"] = 217,
		["231"] = 218,
		["233"] = 217,
		["234"] = 221,
		["235"] = 222,
		["236"] = 223,
		["237"] = 224,
		["238"] = 225,
		["239"] = 226,
		["240"] = 227,
		["241"] = 228,
		["242"] = 229,
		["243"] = 229,
		["244"] = 229,
		["245"] = 230,
		["246"] = 229,
		["247"] = 229,
		["250"] = 234,
		["254"] = 221,
		["255"] = 274,
		["256"] = 275,
		["257"] = 274,
		["258"] = 280,
		["259"] = 281,
		["260"] = 280,
		["261"] = 283,
		["262"] = 284,
		["263"] = 283,
		["264"] = 195,
		["265"] = 186,
		["266"] = 186,
		["267"] = 186,
		["268"] = 186,
		["269"] = 186,
		["270"] = 186,
		["271"] = 186,
		["272"] = 186,
		["273"] = 186,
		["274"] = 195,
		["276"] = 195,
		["278"] = 289,
		["279"] = 290,
		["280"] = 289,
		["281"] = 290,
		["282"] = 291,
		["283"] = 292,
		["284"] = 291,
		["285"] = 290,
		["286"] = 289,
		["287"] = 290,
		["289"] = 290,
		["290"] = 296,
		["291"] = 304,
		["292"] = 296,
		["293"] = 304,
		["294"] = 307,
		["295"] = 308,
		["296"] = 309,
		["297"] = 307,
		["298"] = 311,
		["299"] = 312,
		["300"] = 312,
		["301"] = 314,
		["302"] = 314,
		["303"] = 314,
		["304"] = 312,
		["305"] = 312,
		["306"] = 311,
		["307"] = 318,
		["308"] = 319,
		["309"] = 318,
		["310"] = 321,
		["311"] = 322,
		["312"] = 321,
		["313"] = 324,
		["314"] = 325,
		["315"] = 326,
		["317"] = 324,
		["318"] = 329,
		["319"] = 330,
		["320"] = 329,
		["321"] = 335,
		["322"] = 336,
		["323"] = 335,
		["324"] = 338,
		["325"] = 340,
		["326"] = 338,
		["327"] = 304,
		["328"] = 296,
		["329"] = 296,
		["330"] = 296,
		["331"] = 296,
		["332"] = 296,
		["333"] = 296,
		["334"] = 296,
		["335"] = 296,
		["336"] = 304,
		["338"] = 304,
		["340"] = 345,
		["341"] = 346,
		["342"] = 345,
		["343"] = 346,
		["344"] = 347,
		["345"] = 348,
		["346"] = 347,
		["347"] = 346,
		["348"] = 345,
		["349"] = 346,
		["351"] = 346,
		["352"] = 352,
		["353"] = 360,
		["354"] = 352,
		["355"] = 360,
		["356"] = 362,
		["357"] = 363,
		["358"] = 362,
		["359"] = 365,
		["360"] = 366,
		["361"] = 365,
		["362"] = 370,
		["363"] = 371,
		["364"] = 372,
		["365"] = 372,
		["366"] = 372,
		["367"] = 372,
		["368"] = 372,
		["369"] = 372,
		["370"] = 375,
		["371"] = 375,
		["372"] = 375,
		["373"] = 375,
		["374"] = 375,
		["375"] = 375,
		["376"] = 375,
		["377"] = 375,
		["378"] = 375,
		["379"] = 375,
		["380"] = 375,
		["381"] = 375,
		["383"] = 383,
		["384"] = 370,
		["385"] = 360,
		["386"] = 352,
		["387"] = 352,
		["388"] = 352,
		["389"] = 352,
		["390"] = 352,
		["391"] = 352,
		["392"] = 352,
		["393"] = 352,
		["394"] = 360,
		["396"] = 360,
		["397"] = 386,
		["398"] = 394,
		["399"] = 386,
		["400"] = 394,
		["401"] = 395,
		["402"] = 396,
		["403"] = 397,
		["404"] = 398,
		["405"] = 399,
		["406"] = 399,
		["407"] = 399,
		["408"] = 399,
		["409"] = 399,
		["410"] = 399,
		["411"] = 399,
		["412"] = 399,
		["413"] = 400,
		["414"] = 401,
		["415"] = 401,
		["416"] = 401,
		["417"] = 401,
		["418"] = 401,
		["419"] = 401,
		["420"] = 401,
		["421"] = 401,
		["423"] = 403,
		["425"] = 395,
		["426"] = 406,
		["427"] = 407,
		["428"] = 408,
		["429"] = 408,
		["430"] = 408,
		["431"] = 408,
		["432"] = 408,
		["433"] = 408,
		["435"] = 406,
		["436"] = 411,
		["437"] = 412,
		["438"] = 411,
		["439"] = 416,
		["440"] = 417,
		["441"] = 416,
		["442"] = 394,
		["443"] = 386,
		["444"] = 386,
		["445"] = 386,
		["446"] = 386,
		["447"] = 386,
		["448"] = 386,
		["449"] = 386,
		["450"] = 386,
		["451"] = 394,
		["453"] = 394,
		["455"] = 425,
		["456"] = 426,
		["457"] = 425,
		["458"] = 426,
		["459"] = 427,
		["460"] = 428,
		["461"] = 427,
		["462"] = 426,
		["463"] = 425,
		["464"] = 426,
		["466"] = 426,
		["467"] = 432,
		["468"] = 440,
		["469"] = 432,
		["470"] = 440,
		["471"] = 446,
		["472"] = 447,
		["473"] = 448,
		["474"] = 449,
		["475"] = 450,
		["476"] = 451,
		["477"] = 452,
		["478"] = 452,
		["480"] = 446,
		["481"] = 455,
		["482"] = 456,
		["483"] = 456,
		["484"] = 456,
		["485"] = 456,
		["486"] = 455,
		["487"] = 461,
		["488"] = 462,
		["489"] = 462,
		["490"] = 461,
		["491"] = 464,
		["492"] = 465,
		["493"] = 466,
		["494"] = 467,
		["495"] = 468,
		["496"] = 469,
		["497"] = 470,
		["498"] = 471,
		["499"] = 472,
		["500"] = 472,
		["501"] = 472,
		["502"] = 473,
		["503"] = 472,
		["504"] = 472,
		["507"] = 478,
		["508"] = 479,
		["509"] = 480,
		["512"] = 464,
		["513"] = 484,
		["514"] = 485,
		["515"] = 486,
		["516"] = 487,
		["517"] = 488,
		["518"] = 489,
		["519"] = 490,
		["520"] = 491,
		["521"] = 492,
		["524"] = 484,
		["525"] = 440,
		["526"] = 432,
		["527"] = 432,
		["528"] = 432,
		["529"] = 432,
		["530"] = 432,
		["531"] = 432,
		["532"] = 432,
		["533"] = 432,
		["534"] = 440,
		["536"] = 440,
		["538"] = 498,
		["539"] = 499,
		["540"] = 498,
		["541"] = 499,
		["542"] = 500,
		["543"] = 501,
		["544"] = 500,
		["545"] = 499,
		["546"] = 498,
		["547"] = 499,
		["549"] = 499,
		["550"] = 504,
		["551"] = 512,
		["552"] = 504,
		["553"] = 512,
		["554"] = 514,
		["555"] = 515,
		["556"] = 514,
		["557"] = 517,
		["558"] = 518,
		["559"] = 517,
		["560"] = 522,
		["561"] = 523,
		["562"] = 524,
		["563"] = 526,
		["564"] = 526,
		["565"] = 526,
		["566"] = 526,
		["567"] = 526,
		["568"] = 526,
		["569"] = 526,
		["570"] = 526,
		["571"] = 528,
		["572"] = 528,
		["573"] = 528,
		["574"] = 528,
		["575"] = 528,
		["576"] = 528,
		["577"] = 528,
		["578"] = 528,
		["580"] = 530,
		["581"] = 522,
		["582"] = 512,
		["583"] = 504,
		["584"] = 504,
		["585"] = 504,
		["586"] = 504,
		["587"] = 504,
		["588"] = 504,
		["589"] = 504,
		["590"] = 504,
		["591"] = 512,
		["593"] = 512,
		["595"] = 535,
		["596"] = 536,
		["597"] = 535,
		["598"] = 536,
		["599"] = 537,
		["600"] = 538,
		["601"] = 537,
		["602"] = 536,
		["603"] = 535,
		["604"] = 536,
		["606"] = 536,
		["607"] = 541,
		["608"] = 549,
		["609"] = 541,
		["610"] = 549,
		["611"] = 551,
		["612"] = 552,
		["613"] = 551,
		["614"] = 554,
		["615"] = 555,
		["616"] = 554,
		["617"] = 559,
		["618"] = 560,
		["619"] = 559,
		["620"] = 564,
		["621"] = 565,
		["622"] = 566,
		["623"] = 566,
		["624"] = 566,
		["625"] = 566,
		["626"] = 564,
		["627"] = 549,
		["628"] = 541,
		["629"] = 541,
		["630"] = 541,
		["631"] = 541,
		["632"] = 541,
		["633"] = 541,
		["634"] = 541,
		["635"] = 541,
		["636"] = 549,
		["638"] = 549,
		["639"] = 572,
		["640"] = 573,
		["641"] = 572,
		["642"] = 573,
		["643"] = 574,
		["644"] = 575,
		["645"] = 574,
		["646"] = 573,
		["647"] = 572,
		["648"] = 573,
		["650"] = 573,
		["651"] = 578,
		["652"] = 586,
		["653"] = 578,
		["654"] = 586,
		["655"] = 589,
		["656"] = 590,
		["657"] = 589,
		["658"] = 592,
		["659"] = 593,
		["660"] = 592,
		["661"] = 598,
		["662"] = 599,
		["663"] = 598,
		["664"] = 601,
		["665"] = 602,
		["668"] = 603,
		["669"] = 604,
		["670"] = 605,
		["671"] = 606,
		["672"] = 607,
		["673"] = 608,
		["674"] = 609,
		["675"] = 610,
		["676"] = 611,
		["677"] = 611,
		["678"] = 611,
		["679"] = 611,
		["680"] = 611,
		["681"] = 611,
		["682"] = 611,
		["683"] = 611,
		["684"] = 611,
		["685"] = 612,
		["686"] = 612,
		["687"] = 612,
		["688"] = 612,
		["689"] = 612,
		["690"] = 612,
		["691"] = 612,
		["692"] = 612,
		["693"] = 612,
		["694"] = 613,
		["695"] = 614,
		["696"] = 615,
		["697"] = 615,
		["698"] = 615,
		["699"] = 615,
		["700"] = 615,
		["703"] = 601,
		["704"] = 586,
		["705"] = 578,
		["706"] = 578,
		["707"] = 578,
		["708"] = 578,
		["709"] = 578,
		["710"] = 578,
		["711"] = 578,
		["712"] = 578,
		["713"] = 586,
		["715"] = 586,
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
g.clinkz_talent = c()
local q = g.clinkz_talent
q.name = "clinkz_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_clinkz_talent"
end
q = e({ j(nil) }, q)
g.clinkz_talent = q
g.modifier_clinkz_talent = c()
local r = g.modifier_clinkz_talent
r.name = "modifier_clinkz_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.fury_count = self:GetAbilitySpecialValueFor("fury_count")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
	self.passive_pct = self:GetAbilitySpecialValueFor("passive_pct")
	self.tl2_health = self:GetAbilityTalentValue("clinkz_talent_2", "health")
	self.tl3_regen_pct = self:GetAbilityTalentValue("clinkz_talent_3", "regen_pct")
	local s = self:GetAbilityTalentValue("clinkz_talent_5", "bonus_pct")
	if s > 0 then
		self.fury_count = self.fury_count * (100 + s) * 0.01
		self.damage_pct = self.damage_pct * (100 + s) * 0.01
	end
end
function r.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PROJECTILE_NAME, MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND }
end
function r.prototype.GetModifierProjectileName(self)
	return Wearable:getReplaceParticle(self:GetCaster(), "particles/units/heroes/hero_clinkz/clinkz_searing_arrow.vpcf")
end
function r.prototype.GetAttackSound(self)
	return "Hero_Clinkz.SearingArrows"
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
	}
end
function r.prototype.OnBattleStart(self, t)
	if self.tl2_health > 0 then
		SummonWisp(self:GetParent(), self.tl2_health)
	end
end
function r.prototype.OnCustomAttackLanded(self, u)
	AddFury(self:GetParent(), self.fury_count, "clinkz_talent", "Ability")
end
function r.prototype.OnCustomTakeDamage(self, u)
	if u.ability and u.ability_upgrade == nil and IsValid(u.ability) and u.ability:GetAbilityName() == "sect_wisp" then
		AddFury(self:GetParent(), self.fury_count * self.passive_pct * 0.01, "clinkz_talent", "Ability")
	end
end
function r.prototype.OnWispDie(self, t)
	if self.tl3_regen_pct > 0 then
		if IsValid(t.wisp) then
			local v = t.wisp:GetMaxHealth() * self.tl3_regen_pct * 0.01
			Heal(self:GetParent(), v, "clinkz_talent_3", "Ability")
		end
	end
end
function r.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROCATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_PROJECTILE_NAME,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_ATTACK,
	}
end
function r.prototype.EOM_GetModifierProcAttackDamageBonus(self, t)
	return self:GetPassiveDamage()
end
function r.prototype.EOM_GetModifierWispProjectileName(self, t)
	return Wearable:getReplaceParticle(self:GetCaster(), "particles/units/heroes/hero_clinkz/clinkz_searing_arrow.vpcf")
end
function r.prototype.EOM_GetModifierWispAttack(self, t)
	return self:GetPassiveDamage() * self.passive_pct * 0.01
end
function r.prototype.GetPassiveDamage(self)
	return self.damage + GetFury(self:GetParent()) * self.damage_pct * 0.01
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
				GetPriority = MODIFIER_PRIORITY_NORMAL,
			}
		),
	},
	r
)
g.modifier_clinkz_talent = r
g.clinkz_ult = c()
local w = g.clinkz_ult
w.name = "clinkz_ult"
d(w, o)
function w.prototype.OnSpellStart(self)
	local x = self:GetCaster()
	local y = x:GetEnemy()
	if not IsInjurable(x, y) then
		return
	end
	local z = self:GetSpecialValueFor("duration")
	x:AddNewModifier(x, self, "modifier_clinkz_ult_buff", { duration = z })
end
function w.prototype.BurningBarrage(self, A, B)
	if B == nil then
		B = 100
	end
	local x = self:GetCaster()
	local y = x:GetEnemy()
	if not IsInjurable(A, x, y) then
		return
	end
	local C = self:GetSpecialValueFor("fury_count")
	local D = self:GetSpecialValueFor("damage")
	local E = self:GetSpecialValueFor("damage_pct")
	local s = self:GetTalentValue("clinkz_talent_5", "bonus_pct")
	if s > 0 then
		C = C * (100 + s) * 0.01
		E = E * (100 + s) * 0.01
	end
	local F = A:GetAbsOrigin()
	local G = y:GetAbsOrigin() - F
	G.z = 0
	G = G:Normalized()
	AddFury(x, C * B * 0.01, "clinkz_ult", "Ability")
	D = D + E * GetFury(x) * 0.01
	D = B * 0.01 * D
	local H = self
	A:EmitSound("Hero_Clinkz.SearingArrows")
	A:EmitSound("Hero_Clinkz.SearingArrows.Layer")
	Projectile:CreateLinearProjectile({
		EffectName = "particles/units/heroes/hero_clinkz/clinkz_searing_arrow_linear_proj.vpcf",
		hCaster = A,
		vSpawnOrigin = F,
		vDirection = G,
		flDistance = 800,
		flRadius = 250,
		iMoveSpeed = PROJECTILE_SPEED_FAST,
		OnProjectileHit = function(I, J, K)
			if IsInjurable(x, y) then
				y:EmitSound("Hero_Clinkz.SearingArrows.Impact")
				x:DealDamage(y, H, D, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
			end
		end,
	})
end
w = e({ p(nil) }, w)
g.clinkz_ult = w
g.modifier_clinkz_ult_buff = c()
local L = g.modifier_clinkz_ult_buff
L.name = "modifier_clinkz_ult_buff"
d(L, l)
function L.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	if IsServer() then
		local M = self:GetParent():FindAbilityByName("clinkz_talent")
		self.ult_pct = M and M:GetSpecialValueFor("ult_pct") or 0
	end
end
function L.prototype.OnCreated(self, t)
	if IsServer() then
		self:StartIntervalThink(self.duration / self.count)
		self:IncrementStackCount()
	end
end
function L.prototype.OnRefresh(self, t)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function L.prototype.OnDestroy(self)
	if IsServer() then
	end
end
function L.prototype.OnIntervalThink(self)
	if IsServer() then
		if self.count > 0 then
			local N = self:GetParent()
			self.count = self.count - 1
			local H = self:GetAbility()
			H:BurningBarrage(N)
			if self.ult_pct > 0 then
				EachWisp(N, function(O)
					H:BurningBarrage(O, self.ult_pct)
				end)
			end
		else
			self:Destroy()
			return
		end
	end
end
function L.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE }
end
function L.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CHANNEL_ABILITY_1
end
function L.prototype.GetOverrideAnimationRate(self)
	return 2
end
L = e(
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
				IsIndependent = true,
			}
		),
	},
	L
)
g.modifier_clinkz_ult_buff = L
g.clinkz_talent_1 = c()
local P = g.clinkz_talent_1
P.name = "clinkz_talent_1"
d(P, i)
function P.prototype.GetIntrinsicModifierName(self)
	return "modifier_clinkz_talent_1"
end
P = e({ j(nil) }, P)
g.clinkz_talent_1 = P
g.modifier_clinkz_talent_1 = c()
local Q = g.modifier_clinkz_talent_1
Q.name = "modifier_clinkz_talent_1"
d(Q, l)
function Q.prototype.GetAbilitySpecialValue(self)
	self.fury_bonus = self:GetAbilitySpecialValueFor("fury_bonus")
	self.fury_count = self:GetAbilitySpecialValueFor("fury_count")
end
function Q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function Q.prototype.OnBattleStartBefore(self, t)
	self:StartIntervalThink(0.1)
end
function Q.prototype.OnBattleEnd(self, t)
	self:StartIntervalThink(-1)
end
function Q.prototype.OnIntervalThink(self)
	if IsServer() then
		self:SetStackCount(GetWispCount(self:GetParent()))
	end
end
function Q.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_STACK_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_PERMANENT,
	}
end
function Q.prototype.EOM_GetModifierFuryStackBonus(self, t)
	return self:GetStackCount() * self.fury_bonus
end
function Q.prototype.EOM_GetModifierFuryPermanent(self)
	return self.fury_count * self:GetStackCount()
end
Q = e(
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
	Q
)
g.modifier_clinkz_talent_1 = Q
g.clinkz_talent_4 = c()
local R = g.clinkz_talent_4
R.name = "clinkz_talent_4"
d(R, i)
function R.prototype.GetIntrinsicModifierName(self)
	return "modifier_clinkz_talent_4"
end
R = e({ j(nil) }, R)
g.clinkz_talent_4 = R
g.modifier_clinkz_talent_4 = c()
local S = g.modifier_clinkz_talent_4
S.name = "modifier_clinkz_talent_4"
d(S, l)
function S.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function S.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_MIN_HEALTH }
end
function S.prototype.EOM_GetModifierWispMinHealth(self, t)
	if t.damage >= t.wisp:GetHealth() then
		t.wisp:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_clinkz_talent_4_wisp_undead",
			{ duration = self.duration }
		)
		FireModifierEvent(
			EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE,
			{ attacker = self:GetParent():GetEnemy(), target = self:GetParent(), wisp = t.wisp, remove = false, first = t.first },
			self:GetParent():GetEnemy(),
			self:GetParent()
		)
	end
	return 1
end
S = e(
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
	S
)
g.modifier_clinkz_talent_4 = S
g.modifier_clinkz_talent_4_wisp_undead = c()
local T = g.modifier_clinkz_talent_4_wisp_undead
T.name = "modifier_clinkz_talent_4_wisp_undead"
d(T, l)
function T.prototype.OnCreated(self, t)
	local N = self:GetParent()
	if IsClient() then
		local U = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_skeletonking/wraith_king_ghosts_ambient.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			N
		)
		self:AddParticle(U, false, false, -1, false, false)
		local V = ParticleManager:CreateParticle(
			"particles/status_fx/status_effect_wraithking_ghosts.vpcf",
			PATTACH_INVALID,
			N
		)
		self:AddParticle(V, false, true, 100, false, false)
	else
		N:EmitSound("Hero_SkeletonKing.Reincarnate.Ghost")
	end
end
function T.prototype.OnDestroy(self)
	if IsServer() then
		KillWisp(self:GetCaster(), self:GetParent(), true, false)
	end
end
function T.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
function T.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_WISP_UNDEAD] = true }
end
T = e(
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
	T
)
g.modifier_clinkz_talent_4_wisp_undead = T
g.clinkz_talent_6 = c()
local W = g.clinkz_talent_6
W.name = "clinkz_talent_6"
d(W, i)
function W.prototype.GetIntrinsicModifierName(self)
	return "modifier_clinkz_talent_6"
end
W = e({ j(nil) }, W)
g.clinkz_talent_6 = W
g.modifier_clinkz_talent_6 = c()
local X = g.modifier_clinkz_talent_6
X.name = "modifier_clinkz_talent_6"
d(X, l)
function X.prototype.GetAbilitySpecialValue(self)
	self.fury = self:GetAbilitySpecialValueFor("fury")
	if IsServer() then
		self.timer = false
		self.record = 0
		self.count = 0
		local Y = self:GetParent():FindAbilityByName("clinkz_talent")
		self.ult_pct = Y and Y:GetSpecialValueFor("ult_pct") or 0
	end
end
function X.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED] = { self:GetParent() },
	}
end
function X.prototype.OnBattleStartBefore(self, t)
	local Z = self:GetParent():FindAbilityByName("clinkz_talent")
	self.ult_pct = Z and Z:GetSpecialValueFor("ult_pct") or 0
end
function X.prototype.OnIntervalThink(self)
	if IsServer() then
		if self.count > 0 then
			self.count = self.count - 1
			local N = self:GetParent()
			local _ = N:FindAbilityByName("clinkz_ult")
			_:BurningBarrage(N)
			if self.ult_pct > 0 then
				EachWisp(N, function(O)
					_:BurningBarrage(O, self.ult_pct)
				end)
			end
		end
		if self.count <= 0 then
			self.timer = false
			self:StartIntervalThink(-1)
		end
	end
end
function X.prototype.OnFuryGained(self, t)
	self.record = self.record + t.iStackCount
	if self.record >= self.fury then
		self.count = self.count + math.floor(self.record / self.fury)
		self.record = self.record % self.fury
		if not self.timer then
			self.timer = true
			self:StartIntervalThink(0.1)
			self:OnIntervalThink()
		end
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
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	X
)
g.modifier_clinkz_talent_6 = X
g.clinkz_talent_7 = c()
local a0 = g.clinkz_talent_7
a0.name = "clinkz_talent_7"
d(a0, i)
function a0.prototype.GetIntrinsicModifierName(self)
	return "modifier_clinkz_talent_7"
end
a0 = e({ j(nil) }, a0)
g.clinkz_talent_7 = a0
g.modifier_clinkz_talent_7 = c()
local a1 = g.modifier_clinkz_talent_7
a1.name = "modifier_clinkz_talent_7"
d(a1, l)
function a1.prototype.GetAbilitySpecialValue(self)
	self.fury = self:GetAbilitySpecialValueFor("fury")
end
function a1.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_PRE_BATTLE }
end
function a1.prototype.EOM_GetModifierFuryPreBattle(self)
	if IsServer() then
		local a2 = self:GetParent()
		CombatLog:recordBuff(a2, a2, "fury", self.fury, "clinkz_talent_7", "Ability")
		PlayerData:addDetailData(a2, "Ability", "fury", self.fury, false, "clinkz_talent_7")
	end
	return self.fury
end
a1 = e(
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
	a1
)
g.modifier_clinkz_talent_7 = a1
g.clinkz_talent_8 = c()
local a3 = g.clinkz_talent_8
a3.name = "clinkz_talent_8"
d(a3, i)
function a3.prototype.GetIntrinsicModifierName(self)
	return "modifier_clinkz_talent_8"
end
a3 = e({ j(nil) }, a3)
g.clinkz_talent_8 = a3
g.modifier_clinkz_talent_8 = c()
local a4 = g.modifier_clinkz_talent_8
a4.name = "modifier_clinkz_talent_8"
d(a4, l)
function a4.prototype.GetAbilitySpecialValue(self)
	self.reduce_interval = self:GetAbilitySpecialValueFor("reduce_interval")
end
function a4.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_ATTACK_INTERVAL_BONUS] = -self.reduce_interval }
end
function a4.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_ATTACK_INTERVAL_CONSTANT }
end
function a4.prototype.EOM_GetModifierWispAttackIntervalConstant(self)
	local a5 = GetFury(self:GetParent())
	return GetWispAttackInterval(self:GetParent(), true) / (100 + ICE_FURY_ATTACKSPEED(nil, a5)) * 100
end
a4 = e(
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
	a4
)
g.modifier_clinkz_talent_8 = a4
g.clinkz_shard = c()
local a6 = g.clinkz_shard
a6.name = "clinkz_shard"
d(a6, i)
function a6.prototype.GetIntrinsicModifierName(self)
	return "modifier_clinkz_shard"
end
a6 = e({ j(nil) }, a6)
g.clinkz_shard = a6
g.modifier_clinkz_shard = c()
local a7 = g.modifier_clinkz_shard
a7.name = "modifier_clinkz_shard"
d(a7, l)
function a7.prototype.GetAbilitySpecialValue(self)
	self.regen_per = self:GetAbilitySpecialValueFor("regen_per")
end
function a7.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE] = { -1, -1 },
	}
end
function a7.prototype.OnBattleStartBefore(self, t)
	self.flag = nil
end
function a7.prototype.OnWispDie(self, t)
	if self.flag then
		return
	end
	if t.first and IsValid(t.wisp) then
		if t.target == self:GetParent() or t.target == self:GetParent():GetEnemy() then
			self.flag = true
			local N = self:GetParent()
			local v = t.wisp:GetMaxHealth() * self.regen_per * 0.01
			N:EmitSound("Hero_Clinkz.DeathPact.Cast")
			N:EmitSound("Hero_Clinkz.DeathPact")
			local a8 = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_clinkz/clinkz_death_pact.vpcf",
				PATTACH_CUSTOMORIGIN,
				N
			)
			ParticleManager:SetParticleControlEnt(
				a8,
				0,
				t.wisp,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				t.wisp:GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControlEnt(a8, 1, N, PATTACH_ABSORIGIN_FOLLOW, nil, N:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(a8)
			Heal(N, v, "clinkz_shard", "Ability")
			HealWisp(N, self:GetAbility(), v)
		end
	end
end
a7 = e(
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
	a7
)
g.modifier_clinkz_shard = a7
return g