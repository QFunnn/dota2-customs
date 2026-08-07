--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/bristleback"
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
		["15"] = 3,
		["16"] = 3,
		["17"] = 3,
		["18"] = 3,
		["19"] = 3,
		["21"] = 6,
		["22"] = 7,
		["23"] = 6,
		["24"] = 7,
		["25"] = 8,
		["26"] = 9,
		["27"] = 8,
		["28"] = 7,
		["29"] = 6,
		["30"] = 7,
		["32"] = 7,
		["33"] = 12,
		["34"] = 20,
		["35"] = 12,
		["36"] = 20,
		["38"] = 20,
		["39"] = 25,
		["40"] = 12,
		["41"] = 26,
		["42"] = 27,
		["43"] = 26,
		["44"] = 29,
		["45"] = 30,
		["46"] = 35,
		["47"] = 29,
		["48"] = 37,
		["49"] = 38,
		["50"] = 39,
		["51"] = 40,
		["52"] = 40,
		["53"] = 40,
		["54"] = 40,
		["55"] = 40,
		["56"] = 40,
		["58"] = 37,
		["59"] = 43,
		["60"] = 44,
		["61"] = 45,
		["62"] = 46,
		["63"] = 47,
		["64"] = 48,
		["65"] = 48,
		["66"] = 48,
		["67"] = 48,
		["68"] = 48,
		["69"] = 48,
		["70"] = 48,
		["71"] = 48,
		["72"] = 48,
		["73"] = 49,
		["74"] = 49,
		["75"] = 49,
		["76"] = 49,
		["77"] = 49,
		["78"] = 49,
		["79"] = 49,
		["80"] = 49,
		["81"] = 49,
		["82"] = 50,
		["83"] = 50,
		["84"] = 51,
		["85"] = 51,
		["86"] = 52,
		["87"] = 52,
		["90"] = 43,
		["91"] = 56,
		["92"] = 57,
		["93"] = 58,
		["94"] = 59,
		["95"] = 59,
		["96"] = 59,
		["97"] = 59,
		["100"] = 56,
		["101"] = 63,
		["102"] = 64,
		["103"] = 63,
		["104"] = 68,
		["105"] = 69,
		["106"] = 70,
		["107"] = 70,
		["108"] = 70,
		["109"] = 70,
		["111"] = 72,
		["112"] = 73,
		["113"] = 74,
		["114"] = 75,
		["115"] = 76,
		["116"] = 77,
		["118"] = 79,
		["119"] = 80,
		["120"] = 82,
		["123"] = 85,
		["124"] = 68,
		["125"] = 88,
		["126"] = 89,
		["127"] = 88,
		["128"] = 96,
		["129"] = 97,
		["130"] = 96,
		["131"] = 100,
		["132"] = 101,
		["133"] = 102,
		["134"] = 103,
		["135"] = 103,
		["136"] = 103,
		["137"] = 103,
		["138"] = 103,
		["139"] = 103,
		["141"] = 100,
		["142"] = 115,
		["143"] = 116,
		["144"] = 115,
		["145"] = 20,
		["146"] = 12,
		["147"] = 12,
		["148"] = 12,
		["149"] = 12,
		["150"] = 12,
		["151"] = 12,
		["152"] = 12,
		["153"] = 12,
		["154"] = 20,
		["156"] = 20,
		["157"] = 120,
		["158"] = 129,
		["159"] = 120,
		["160"] = 129,
		["161"] = 133,
		["162"] = 134,
		["163"] = 133,
		["164"] = 136,
		["165"] = 137,
		["166"] = 138,
		["167"] = 140,
		["168"] = 136,
		["169"] = 142,
		["170"] = 143,
		["171"] = 144,
		["173"] = 142,
		["174"] = 147,
		["175"] = 148,
		["176"] = 149,
		["178"] = 147,
		["179"] = 152,
		["180"] = 153,
		["181"] = 152,
		["182"] = 159,
		["183"] = 160,
		["186"] = 161,
		["187"] = 159,
		["188"] = 163,
		["189"] = 164,
		["192"] = 165,
		["193"] = 163,
		["194"] = 129,
		["195"] = 120,
		["196"] = 120,
		["197"] = 120,
		["198"] = 120,
		["199"] = 120,
		["200"] = 120,
		["201"] = 120,
		["202"] = 120,
		["203"] = 120,
		["204"] = 129,
		["206"] = 129,
		["207"] = 171,
		["208"] = 172,
		["209"] = 171,
		["210"] = 172,
		["211"] = 173,
		["212"] = 174,
		["213"] = 175,
		["214"] = 176,
		["215"] = 177,
		["216"] = 177,
		["217"] = 177,
		["218"] = 178,
		["219"] = 179,
		["220"] = 181,
		["221"] = 182,
		["222"] = 183,
		["223"] = 184,
		["226"] = 187,
		["227"] = 188,
		["228"] = 189,
		["230"] = 191,
		["231"] = 191,
		["232"] = 191,
		["233"] = 191,
		["234"] = 191,
		["235"] = 191,
		["236"] = 197,
		["237"] = 198,
		["238"] = 199,
		["239"] = 200,
		["240"] = 200,
		["241"] = 200,
		["242"] = 200,
		["243"] = 200,
		["244"] = 200,
		["246"] = 191,
		["247"] = 191,
		["249"] = 177,
		["250"] = 177,
		["251"] = 173,
		["252"] = 172,
		["253"] = 171,
		["254"] = 172,
		["256"] = 172,
		["257"] = 210,
		["258"] = 221,
		["259"] = 210,
		["260"] = 221,
		["261"] = 224,
		["262"] = 225,
		["263"] = 224,
		["264"] = 227,
		["265"] = 228,
		["266"] = 229,
		["267"] = 231,
		["268"] = 232,
		["269"] = 233,
		["270"] = 234,
		["271"] = 235,
		["273"] = 237,
		["274"] = 227,
		["275"] = 239,
		["276"] = 240,
		["277"] = 241,
		["279"] = 239,
		["280"] = 244,
		["281"] = 245,
		["282"] = 246,
		["284"] = 244,
		["285"] = 249,
		["286"] = 250,
		["287"] = 249,
		["288"] = 255,
		["289"] = 256,
		["290"] = 255,
		["291"] = 258,
		["292"] = 259,
		["293"] = 258,
		["294"] = 221,
		["295"] = 210,
		["296"] = 210,
		["297"] = 210,
		["298"] = 210,
		["299"] = 210,
		["300"] = 210,
		["301"] = 210,
		["302"] = 210,
		["303"] = 210,
		["304"] = 210,
		["305"] = 210,
		["306"] = 221,
		["308"] = 221,
		["310"] = 265,
		["311"] = 266,
		["312"] = 265,
		["313"] = 266,
		["314"] = 267,
		["315"] = 268,
		["316"] = 267,
		["317"] = 266,
		["318"] = 265,
		["319"] = 266,
		["321"] = 266,
		["322"] = 271,
		["323"] = 279,
		["324"] = 271,
		["325"] = 279,
		["326"] = 280,
		["327"] = 281,
		["328"] = 280,
		["329"] = 285,
		["330"] = 286,
		["331"] = 287,
		["332"] = 287,
		["333"] = 287,
		["334"] = 287,
		["335"] = 287,
		["336"] = 287,
		["338"] = 285,
		["339"] = 290,
		["340"] = 291,
		["341"] = 290,
		["342"] = 279,
		["343"] = 271,
		["344"] = 271,
		["345"] = 271,
		["346"] = 271,
		["347"] = 271,
		["348"] = 271,
		["349"] = 271,
		["350"] = 271,
		["351"] = 279,
		["353"] = 279,
		["354"] = 295,
		["355"] = 303,
		["356"] = 295,
		["357"] = 303,
		["359"] = 303,
		["360"] = 306,
		["361"] = 307,
		["362"] = 308,
		["363"] = 295,
		["364"] = 309,
		["365"] = 310,
		["366"] = 312,
		["367"] = 309,
		["368"] = 314,
		["369"] = 315,
		["370"] = 316,
		["371"] = 317,
		["372"] = 318,
		["374"] = 314,
		["375"] = 321,
		["376"] = 322,
		["377"] = 323,
		["379"] = 321,
		["380"] = 326,
		["381"] = 327,
		["382"] = 328,
		["383"] = 328,
		["384"] = 328,
		["385"] = 327,
		["386"] = 329,
		["387"] = 329,
		["388"] = 329,
		["389"] = 327,
		["390"] = 327,
		["391"] = 326,
		["392"] = 332,
		["393"] = 334,
		["394"] = 335,
		["395"] = 336,
		["396"] = 336,
		["397"] = 336,
		["398"] = 336,
		["399"] = 336,
		["400"] = 337,
		["401"] = 337,
		["402"] = 337,
		["403"] = 337,
		["404"] = 337,
		["405"] = 337,
		["406"] = 338,
		["407"] = 338,
		["408"] = 338,
		["409"] = 338,
		["410"] = 338,
		["411"] = 338,
		["412"] = 338,
		["413"] = 338,
		["414"] = 338,
		["415"] = 339,
		["417"] = 341,
		["418"] = 342,
		["419"] = 343,
		["420"] = 344,
		["423"] = 345,
		["424"] = 346,
		["425"] = 347,
		["428"] = 332,
		["429"] = 351,
		["430"] = 352,
		["431"] = 351,
		["432"] = 354,
		["433"] = 355,
		["434"] = 354,
		["435"] = 303,
		["436"] = 295,
		["437"] = 295,
		["438"] = 295,
		["439"] = 295,
		["440"] = 295,
		["441"] = 295,
		["442"] = 295,
		["443"] = 295,
		["444"] = 303,
		["446"] = 303,
		["447"] = 362,
		["448"] = 363,
		["449"] = 362,
		["450"] = 363,
		["451"] = 364,
		["452"] = 365,
		["453"] = 366,
		["454"] = 367,
		["457"] = 370,
		["458"] = 372,
		["459"] = 373,
		["460"] = 374,
		["461"] = 375,
		["462"] = 376,
		["463"] = 377,
		["464"] = 377,
		["465"] = 377,
		["466"] = 377,
		["467"] = 378,
		["468"] = 379,
		["469"] = 380,
		["470"] = 381,
		["471"] = 382,
		["472"] = 383,
		["473"] = 384,
		["475"] = 377,
		["476"] = 377,
		["477"] = 364,
		["478"] = 389,
		["479"] = 390,
		["480"] = 391,
		["481"] = 392,
		["482"] = 393,
		["483"] = 394,
		["484"] = 395,
		["485"] = 396,
		["486"] = 397,
		["487"] = 397,
		["488"] = 397,
		["489"] = 398,
		["490"] = 399,
		["492"] = 397,
		["493"] = 397,
		["494"] = 402,
		["495"] = 403,
		["496"] = 403,
		["497"] = 403,
		["498"] = 404,
		["499"] = 405,
		["501"] = 403,
		["502"] = 403,
		["506"] = 389,
		["507"] = 363,
		["508"] = 362,
		["509"] = 363,
		["511"] = 363,
		["512"] = 413,
		["513"] = 423,
		["514"] = 413,
		["515"] = 423,
		["516"] = 424,
		["517"] = 425,
		["518"] = 424,
		["519"] = 427,
		["520"] = 428,
		["521"] = 429,
		["523"] = 427,
		["524"] = 432,
		["525"] = 433,
		["526"] = 434,
		["528"] = 432,
		["529"] = 423,
		["530"] = 413,
		["531"] = 413,
		["532"] = 413,
		["533"] = 413,
		["534"] = 413,
		["535"] = 413,
		["536"] = 413,
		["537"] = 413,
		["538"] = 413,
		["539"] = 413,
		["540"] = 423,
		["542"] = 423,
		["543"] = 441,
		["544"] = 450,
		["545"] = 441,
		["546"] = 450,
		["547"] = 451,
		["548"] = 452,
		["549"] = 453,
		["550"] = 454,
		["551"] = 455,
		["552"] = 456,
		["553"] = 457,
		["554"] = 458,
		["556"] = 460,
		["559"] = 451,
		["560"] = 450,
		["561"] = 441,
		["562"] = 441,
		["563"] = 441,
		["564"] = 441,
		["565"] = 441,
		["566"] = 441,
		["567"] = 441,
		["568"] = 441,
		["569"] = 450,
		["571"] = 450,
		["572"] = 465,
		["573"] = 473,
		["574"] = 465,
		["575"] = 473,
		["577"] = 473,
		["578"] = 474,
		["579"] = 465,
		["580"] = 476,
		["581"] = 477,
		["582"] = 478,
		["583"] = 479,
		["585"] = 476,
		["586"] = 482,
		["587"] = 483,
		["588"] = 482,
		["589"] = 488,
		["590"] = 489,
		["591"] = 490,
		["592"] = 491,
		["593"] = 492,
		["594"] = 493,
		["596"] = 495,
		["598"] = 488,
		["599"] = 498,
		["600"] = 499,
		["601"] = 500,
		["602"] = 502,
		["604"] = 498,
		["605"] = 505,
		["606"] = 506,
		["609"] = 507,
		["610"] = 508,
		["611"] = 509,
		["614"] = 510,
		["615"] = 511,
		["616"] = 512,
		["617"] = 513,
		["618"] = 514,
		["619"] = 515,
		["620"] = 516,
		["621"] = 505,
		["622"] = 518,
		["623"] = 519,
		["624"] = 518,
		["625"] = 526,
		["626"] = 527,
		["627"] = 526,
		["628"] = 529,
		["629"] = 530,
		["630"] = 529,
		["631"] = 532,
		["632"] = 533,
		["633"] = 534,
		["635"] = 532,
		["636"] = 537,
		["637"] = 538,
		["638"] = 539,
		["640"] = 537,
		["641"] = 542,
		["642"] = 543,
		["643"] = 542,
		["644"] = 473,
		["645"] = 465,
		["646"] = 465,
		["647"] = 465,
		["648"] = 465,
		["649"] = 465,
		["650"] = 465,
		["651"] = 465,
		["652"] = 465,
		["653"] = 473,
		["655"] = 473,
		["656"] = 548,
		["657"] = 556,
		["658"] = 548,
		["659"] = 556,
		["660"] = 559,
		["661"] = 560,
		["662"] = 560,
		["663"] = 560,
		["664"] = 560,
		["665"] = 561,
		["666"] = 562,
		["667"] = 559,
		["668"] = 564,
		["669"] = 565,
		["670"] = 564,
		["671"] = 569,
		["672"] = 570,
		["673"] = 569,
		["674"] = 573,
		["675"] = 574,
		["676"] = 573,
		["677"] = 578,
		["678"] = 579,
		["679"] = 578,
		["680"] = 556,
		["681"] = 548,
		["682"] = 548,
		["683"] = 548,
		["684"] = 548,
		["685"] = 548,
		["686"] = 548,
		["687"] = 548,
		["688"] = 548,
		["689"] = 556,
		["691"] = 556,
		["693"] = 585,
		["694"] = 586,
		["695"] = 585,
		["696"] = 586,
		["697"] = 587,
		["698"] = 588,
		["699"] = 587,
		["700"] = 586,
		["701"] = 585,
		["702"] = 586,
		["704"] = 586,
		["705"] = 600,
		["706"] = 608,
		["707"] = 600,
		["708"] = 608,
		["709"] = 611,
		["710"] = 612,
		["711"] = 611,
		["712"] = 615,
		["713"] = 616,
		["714"] = 615,
		["715"] = 621,
		["716"] = 622,
		["717"] = 621,
		["718"] = 608,
		["719"] = 600,
		["720"] = 600,
		["721"] = 600,
		["722"] = 600,
		["723"] = 600,
		["724"] = 600,
		["725"] = 600,
		["726"] = 600,
		["727"] = 608,
		["729"] = 608,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
local o = require("abilities.interact_ability")
local p = o.InteractAbility
local q = o.InteractBaseAbility
local r = o.registerInteractAbility
local s = o.registerInteractBaseAbility
h.bristleback_talent = c()
local t = h.bristleback_talent
t.name = "bristleback_talent"
d(t, q)
function t.prototype.GetIntrinsicModifierName(self)
	return "modifier_bristleback_talent"
end
t = e({ s(nil) }, t)
h.bristleback_talent = t
h.modifier_bristleback_talent = c()
local u = h.modifier_bristleback_talent
u.name = "modifier_bristleback_talent"
d(u, m)
function u.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.warpath_ptcl = {}
end
function u.prototype.GetTexture(self)
	return "bristleback_warpath"
end
function u.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.s_enable = self:HasTalent("bristleback_shard")
end
function u.prototype.OnCreated(self, v)
	if IsServer() then
		local w = self:GetParent()
		w:AddNewModifier(w, self:GetAbility(), "modifier_bristleback_talent_buff", { duration = self.duration })
	end
end
function u.prototype.OnStackCountChanged(self, x)
	if IsServer() then
		if #self.warpath_ptcl == 0 and self:GetStackCount() > 0 then
			local y = self:GetParent()
			local z = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_bristleback/bristleback_warpath.vpcf",
				PATTACH_CUSTOMORIGIN,
				y
			)
			ParticleManager:SetParticleControlEnt(z, 3, y, PATTACH_POINT_FOLLOW, "attach_attack2", vec3_zero, true)
			ParticleManager:SetParticleControlEnt(z, 4, y, PATTACH_POINT_FOLLOW, "attach_attack1", vec3_zero, true)
			local A = self.warpath_ptcl
			A[#A + 1] = z
			local B = self.warpath_ptcl
			B[#B + 1] = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_bristleback/bristleback_warpath_active.vpcf",
				PATTACH_CUSTOMORIGIN,
				y
			)
			local C = self.warpath_ptcl
			C[#C + 1] = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_bristleback/bristleback_warpath_dust.vpcf",
				PATTACH_CUSTOMORIGIN,
				y
			)
		end
	end
end
function u.prototype.OnDestroy(self)
	if IsServer() then
		if #self.warpath_ptcl > 0 then
			f(self.warpath_ptcl, function(D, E)
				return ParticleManager:DestroyParticle(E, false)
			end)
		end
	end
end
function u.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function u.prototype.OnBattleStartBefore(self, v)
	if #self.warpath_ptcl > 0 then
		f(self.warpath_ptcl, function(D, E)
			return ParticleManager:DestroyParticle(E, false)
		end)
	end
	self.warpath_ptcl = {}
	if self.s_enable then
		local y = self:GetParent()
		local F = y:FindAbilityByName("bristleback_ult")
		if IsValid(F) then
			F:OnSpellStart()
		end
		local G = y:FindAbilityByName("bristleback_ult_s")
		if IsValid(G) then
			G:OnSpellStart(true)
		end
	end
	self:SetStackCount(0)
end
function u.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_LOSS_PERCENTAGE }
end
function u.prototype.EOM_GetModifierManaLossPercentage(self, v)
	return 0
end
function u.prototype.AddPassiveStack(self)
	if self:IsActivated() then
		local w = self:GetParent()
		w:AddNewModifier(w, self:GetAbility(), "modifier_bristleback_talent_buff", { duration = self.duration })
	end
end
function u.prototype.IsActivated(self)
	return self:GetAbility():GetToggleState()
end
u = e(
	{
		n(
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
	u
)
h.modifier_bristleback_talent = u
h.modifier_bristleback_talent_buff = c()
local H = h.modifier_bristleback_talent_buff
H.name = "modifier_bristleback_talent_buff"
d(H, m)
function H.prototype.GetTexture(self)
	return "bristleback_warpath"
end
function H.prototype.GetAbilitySpecialValue(self)
	self.max_stack = self:GetAbilitySpecialValueFor("max_stack")
	self.attack_bonus = self:GetAbilitySpecialValueFor("attack_bonus")
		+ self:GetAbilityTalentValue("bristleback_talent_3", "bonus_attack")
	self.tl3_bonus_as = self:GetAbilityTalentValue("bristleback_talent_3", "bonus_as")
end
function H.prototype.OnCreated(self, v)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function H.prototype.OnRefresh(self, v)
	if IsServer() and self:GetStackCount() < self.max_stack then
		self:IncrementStackCount()
	end
end
function H.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
	}
end
function H.prototype.EOM_GetModifierAttackDamageBonus(self)
	if self:GetParent():PassivesDisabled() then
		return
	end
	return self:GetStackCount() * self.attack_bonus
end
function H.prototype.EOM_GetModifierAttackSpeedBonus(self, v)
	if self:GetParent():PassivesDisabled() then
		return
	end
	return self:GetStackCount() * self.tl3_bonus_as
end
H = e(
	{
		n(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				IsIndependent = true,
			}
		),
	},
	H
)
h.modifier_bristleback_talent_buff = H
h.bristleback_ult = c()
local I = h.bristleback_ult
I.name = "bristleback_ult"
d(I, q)
function I.prototype.OnSpellStart(self)
	local w = self:GetCaster()
	local J = w:GetEnemy()
	w:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	self:GameTimer(0.3, function()
		if IsInjurable(w, J) then
			w:EmitSound("Hero_Bristleback.ViscousGoo.Cast")
			if self:HasTalent("bristleback_talent_5") then
				local K = w:FindAbilityByName("bristleback_ult_s")
				if IsValid(K) then
					K:OnSpellStart()
				end
			end
			local L = w:FindModifierByName("modifier_bristleback_talent")
			if IsValid(L) then
				L:AddPassiveStack()
			end
			Projectile:CreateTrackingProjectile({
				EffectName = "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_goo.vpcf",
				hCaster = w,
				vSpawnOrigin = w:GetAttachmentPosition("attach_attack3"),
				hTarget = J,
				iMoveSpeed = PROJECTILE_SPEED_NORMAL,
				OnProjectileHit = function(M, N, O)
					if IsInjurable(w, J) and IsValid(self) then
						J:EmitSound("Hero_Bristleback.ViscousGoo.Target")
						J:AddNewModifier(
							w,
							self,
							"modifier_bristleback_ult",
							{ duration = self:GetSpecialValueFor("duration") }
						)
					end
				end,
			})
		end
	end)
end
I = e({ s(nil) }, I)
h.bristleback_ult = I
h.modifier_bristleback_ult = c()
local P = h.modifier_bristleback_ult
P.name = "modifier_bristleback_ult"
d(P, m)
function P.prototype.GetTexture(self)
	return "bristleback_viscous_nasal_goo"
end
function P.prototype.GetAbilitySpecialValue(self)
	self.injury_count = self:GetAbilitySpecialValueFor("injury_count")
	self.as_pct_reduce = self:GetAbilitySpecialValueFor("as_pct_reduce")
	local Q = self:GetAbilityTalentValue("bristleback_talent_1", "injury_count")
	local R = self:GetAbilityTalentValue("bristleback_talent_1", "bonus_pct")
	if R > 0 then
		self.injury_count = self.injury_count * (1 + R * 0.01)
		self.as_pct_reduce = self.as_pct_reduce * (1 + R * 0.01)
	end
	self.injury_count = self.injury_count + Q
end
function P.prototype.OnCreated(self, v)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function P.prototype.OnRefresh(self, v)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function P.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_PERMANENT,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_TOTAL_PERCENTAGE,
	}
end
function P.prototype.EOM_GetModifierInjuryPermanent(self, v)
	return self.injury_count * self:GetStackCount()
end
function P.prototype.EOM_GetModifierAttackSpeedTotalPercentage(self, v)
	return -self.as_pct_reduce * self:GetStackCount()
end
P = e(
	{
		n(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetEffectName = "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_goo_debuff.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
				IsIndependent = true,
			}
		),
	},
	P
)
h.modifier_bristleback_ult = P
h.bristleback_talent_s = c()
local S = h.bristleback_talent_s
S.name = "bristleback_talent_s"
d(S, q)
function S.prototype.GetIntrinsicModifierName(self)
	return "modifier_bristleback_talent_s"
end
S = e({ s(nil) }, S)
h.bristleback_talent_s = S
h.modifier_bristleback_talent_s = c()
local T = h.modifier_bristleback_talent_s
T.name = "modifier_bristleback_talent_s"
d(T, m)
function T.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function T.prototype.OnBattleStartBefore(self, v)
	if self:IsActivated() then
		self:GetParent()
			:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_bristleback_talent_s_effect", nil)
	end
end
function T.prototype.IsActivated(self)
	return self:GetAbility():GetToggleState()
end
T = e(
	{
		n(
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
h.modifier_bristleback_talent_s = T
h.modifier_bristleback_talent_s_effect = c()
local U = h.modifier_bristleback_talent_s_effect
U.name = "modifier_bristleback_talent_s_effect"
d(U, m)
function U.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.record = 0
	self.cal_threshold = 0
	self.ptclTimer = 0
end
function U.prototype.GetAbilitySpecialValue(self)
	self.damage_reduce = self:GetAbilitySpecialValueFor("damage_reduce")
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
		- self:GetAbilityTalentValue("bristleback_talent_4", "threshold_reduce")
end
function U.prototype.OnCreated(self, v)
	if IsServer() then
		self.record = 0
		self:OnIntervalThink()
		self:StartIntervalThink(1)
	end
end
function U.prototype.OnIntervalThink(self)
	if IsServer() then
		self.cal_threshold = self:GetParent():GetMaxHealth() * self.threshold * 0.01
	end
end
function U.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function U.prototype.OnCustomTakeDamage(self, V)
	self.record = self.record + V.damage
	if GameRules:GetGameTime() - self.ptclTimer >= 0.2 then
		local W = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_bristleback/bristleback_back_dmg.vpcf",
			PATTACH_CUSTOMORIGIN,
			self:GetParent()
		)
		ParticleManager:SetParticleControlTransform(
			W,
			0,
			self:GetParent():GetAbsOrigin(),
			VectorAngles(self:GetParent():GetForwardVector() * -1)
		)
		ParticleManager:SetParticleControlEnt(
			W,
			1,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self:GetParent():GetAbsOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(W)
	end
	V.target:EmitSound("Hero_Bristleback.Bristleback")
	if self.record >= self.cal_threshold then
		self.record = self.record - self.cal_threshold
		if self:GetParent():PassivesDisabled() then
			return
		end
		local X = self:GetParent():FindAbilityByName("bristleback_ult_s")
		if IsValid(X) then
			X:OnSpellStart()
		end
	end
end
function U.prototype.OnBattleEnd(self, v)
	self:Destroy()
end
function U.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE] = self:GetParent():PassivesDisabled()
				and 0
			or -self.damage_reduce,
	}
end
U = e(
	{
		n(
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
h.modifier_bristleback_talent_s_effect = U
h.bristleback_ult_s = c()
local Y = h.bristleback_ult_s
Y.name = "bristleback_ult_s"
d(Y, q)
function Y.prototype.OnSpellStart(self, Z)
	local w = self:GetCaster()
	local J = w:GetEnemy()
	if not IsInjurable(w, J) then
		return
	end
	local _ = 1
	self:Talent6Effect(Z)
	w:StartGesture(ACT_DOTA_CAST_ABILITY_2)
	local a0 = self:GetSpecialValueFor("bonus_damage")
	local a1 = self:GetSpecialValueFor("damage")
	w:EmitSound("Hero_Bristleback.QuillSpray.Cast")
	ForWithInterval(0.1, _, function()
		if IsInjurable(w, J) then
			J:EmitSound("Hero_Bristleback.QuillSpray.Target")
			local W = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_bristleback/bristleback_quill_spray.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				w
			)
			ParticleManager:ReleaseParticleIndex(W)
			local a2 = a1 + J:GetModifierStackCount("modifier_bristleback_ult_s_debuff", w) * a0
			w:DealDamage(J, self, a2, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
			J:AddNewModifier(w, self, "modifier_bristleback_ult_s_debuff", nil)
		end
	end)
end
function Y.prototype.Talent6Effect(self, Z)
	if not Z then
		local a3 = self:GetTalentValue("bristleback_talent_6", "sect_level")
		local a4 = self:GetTalentValue("bristleback_talent_6", "extra_trigger_pct")
		if a3 > 0 then
			local a5 = AbilityShop.pickList
			local a6 = 0
			local a7 = PlayerData:getHero(self:GetCaster():GetPlayerOwnerID())
			f(a5, function(D, a8)
				if a7:GetSectLevel(a8) >= a3 then
					a6 = a6 + 1
				end
			end)
			if self:PRD(a4 * a6, "extra_trigger_pct") then
				GameTimer(0.5, function()
					if self then
						self:OnSpellStart(true)
					end
				end)
			end
		end
	end
end
Y = e({ s(nil) }, Y)
h.bristleback_ult_s = Y
h.modifier_bristleback_ult_s_debuff = c()
local a9 = h.modifier_bristleback_ult_s_debuff
a9.name = "modifier_bristleback_ult_s_debuff"
d(a9, m)
function a9.prototype.GetTexture(self)
	return "bristleback_quill_spray"
end
function a9.prototype.OnCreated(self, v)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function a9.prototype.OnRefresh(self, v)
	if IsServer() then
		self:IncrementStackCount()
	end
end
a9 = e(
	{
		n(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetEffectName = "particles/units/heroes/hero_bristleback/bristleback_quill_spray_hit_creep.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
			}
		),
	},
	a9
)
h.modifier_bristleback_ult_s_debuff = a9
h.bristleback_interact = c()
local aa = h.bristleback_interact
aa.name = "bristleback_interact"
d(aa, p)
function aa.prototype.OnToggle(self)
	if IsServer() then
		local w = self:GetCaster()
		local ab = self:GetToggleState()
		w:RemoveModifierByName("modifier_bristleback_interact_inactive")
		w:RemoveModifierByName("modifier_bristleback_interact_active")
		if ab then
			w:AddNewModifier(w, self, "modifier_bristleback_interact_active", nil)
		else
			w:AddNewModifier(w, self, "modifier_bristleback_interact_inactive", nil)
		end
	end
end
aa = e(
	{
		r(
			nil,
			{
				ActiveTextureName = "bristleback/bb_2022_immortal_ability_icon/bb_2022_immortal_warpath",
				InactiveTextureName = "bristleback/bb_2022_immortal_ability_icon/bb_2022_immortal_bristleback",
				talent_ability1 = "bristleback_talent",
				talent_ability2 = "bristleback_talent_s",
				ult_ability1 = "bristleback_ult",
				ult_ability2 = "bristleback_ult_s",
			}
		),
	},
	aa
)
h.bristleback_interact = aa
h.modifier_bristleback_interact_active = c()
local ac = h.modifier_bristleback_interact_active
ac.name = "modifier_bristleback_interact_active"
d(ac, m)
function ac.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.state = false
end
function ac.prototype.OnIntervalThink(self)
	if IsServer() then
		self:StartIntervalThink(-1)
		self:TurnBack()
	end
end
function ac.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_CONFIRM_BATTLE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
	}
end
function ac.prototype.OnConfirmBattle(self, v)
	local ad = GameState:getStateStartEndGameTime()[2]
	local ae = 0.5
	local af = ad - GameRules:GetGameTime()
	if af > ae then
		self:StartIntervalThink(af - ae)
	else
		self:TurnBack()
	end
end
function ac.prototype.OnBattleStartBefore(self, v)
	self:SetStackCount(1)
	if self.targetPos then
		self:GetParent():SetAbsOrigin(self.targetPos)
	end
end
function ac.prototype.TurnBack(self)
	if self.state then
		return
	end
	local y = self:GetParent()
	local J = y:GetEnemy()
	if not IsInjurable(y, J) then
		return
	end
	local ag = y:GetAbsOrigin() - J:GetAbsOrigin()
	ag.z = 0
	ag = ag:Normalized()
	y:EmitSound("Hero_Bristleback.Bristleback.Active")
	y:StartGesture(ACT_DOTA_CAST_ABILITY_3)
	self.targetPos = y:GetAbsOrigin()
	y:MoveToPosition(self.targetPos + ag)
end
function ac.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_DISABLE_TURNING,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
		MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE,
	}
end
function ac.prototype.GetModifierDisableTurning(self)
	return self:GetStackCount()
end
function ac.prototype.GetModifierIgnoreCastAngle(self)
	return self:GetStackCount()
end
function ac.prototype.GetActivityTranslationModifiers(self)
	if self:GetStackCount() > 0 then
		return "bristleback"
	end
end
function ac.prototype.GetModifierTurnRate_Percentage(self)
	if self:GetStackCount() > 0 then
		return -100
	end
end
function ac.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
ac = e(
	{
		n(
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
	ac
)
h.modifier_bristleback_interact_active = ac
h.modifier_bristleback_interact_inactive = c()
local ah = h.modifier_bristleback_interact_inactive
ah.name = "modifier_bristleback_interact_inactive"
d(ah, m)
function ah.prototype.GetAbilitySpecialValue(self)
	self.mana = math.max(10, self:GetAbilitySpecialValueFor("mana"))
	self.loss_mana_pct = self:GetAbilitySpecialValueFor("loss_mana_pct")
	self.mana = self.mana - 100
end
function ah.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MANA_BONUS }
end
function ah.prototype.GetModifierManaBonus(self)
	return self.mana
end
function ah.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_GAIN_BONUS_PERCENTAGE }
end
function ah.prototype.EOM_GetModifierManaGainBonusPercentage(self, v)
	return -self.loss_mana_pct
end
ah = e(
	{
		n(
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
h.modifier_bristleback_interact_inactive = ah
h.bristleback_talent_2 = c()
local ai = h.bristleback_talent_2
ai.name = "bristleback_talent_2"
d(ai, j)
function ai.prototype.GetIntrinsicModifierName(self)
	return "modifier_bristleback_talent_2"
end
ai = e({ k(nil) }, ai)
h.bristleback_talent_2 = ai
h.modifier_bristleback_talent_2 = c()
local aj = h.modifier_bristleback_talent_2
aj.name = "modifier_bristleback_talent_2"
d(aj, m)
function aj.prototype.GetAbilitySpecialValue(self)
	self.heal_pct = self:GetAbilitySpecialValueFor("heal_pct")
end
function aj.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ABILITY_LIFESTEAL }
end
function aj.prototype.EOM_GetModifierAbilityLifesteal(self, v)
	return self.heal_pct
end
aj = e(
	{
		n(
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
h.modifier_bristleback_talent_2 = aj
return h