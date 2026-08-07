--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/phantom_lancer"
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
		["17"] = 7,
		["18"] = 17,
		["19"] = 7,
		["20"] = 17,
		["21"] = 18,
		["22"] = 19,
		["23"] = 20,
		["24"] = 21,
		["25"] = 22,
		["26"] = 23,
		["27"] = 23,
		["28"] = 23,
		["29"] = 23,
		["30"] = 23,
		["31"] = 23,
		["32"] = 23,
		["33"] = 23,
		["34"] = 23,
		["35"] = 24,
		["36"] = 24,
		["37"] = 24,
		["38"] = 24,
		["39"] = 24,
		["40"] = 24,
		["41"] = 24,
		["42"] = 24,
		["43"] = 24,
		["44"] = 25,
		["46"] = 18,
		["47"] = 28,
		["48"] = 29,
		["49"] = 30,
		["50"] = 31,
		["51"] = 32,
		["52"] = 33,
		["54"] = 35,
		["55"] = 36,
		["56"] = 37,
		["57"] = 38,
		["58"] = 38,
		["59"] = 38,
		["60"] = 38,
		["61"] = 38,
		["62"] = 38,
		["63"] = 38,
		["64"] = 38,
		["65"] = 38,
		["66"] = 39,
		["67"] = 40,
		["68"] = 40,
		["69"] = 40,
		["70"] = 40,
		["71"] = 40,
		["72"] = 40,
		["73"] = 40,
		["74"] = 40,
		["75"] = 40,
		["77"] = 28,
		["78"] = 43,
		["79"] = 44,
		["80"] = 43,
		["81"] = 48,
		["82"] = 49,
		["83"] = 50,
		["84"] = 50,
		["85"] = 50,
		["86"] = 50,
		["87"] = 51,
		["88"] = 52,
		["90"] = 54,
		["92"] = 48,
		["93"] = 17,
		["94"] = 7,
		["95"] = 7,
		["96"] = 7,
		["97"] = 7,
		["98"] = 7,
		["99"] = 7,
		["100"] = 7,
		["101"] = 7,
		["102"] = 7,
		["103"] = 7,
		["104"] = 17,
		["106"] = 17,
		["107"] = 60,
		["108"] = 68,
		["109"] = 60,
		["110"] = 68,
		["111"] = 69,
		["112"] = 70,
		["113"] = 69,
		["114"] = 68,
		["115"] = 60,
		["116"] = 60,
		["117"] = 60,
		["118"] = 60,
		["119"] = 60,
		["120"] = 60,
		["121"] = 60,
		["122"] = 60,
		["123"] = 68,
		["125"] = 68,
		["126"] = 78,
		["127"] = 79,
		["128"] = 78,
		["129"] = 79,
		["131"] = 79,
		["132"] = 80,
		["133"] = 81,
		["134"] = 88,
		["135"] = 78,
		["136"] = 90,
		["137"] = 91,
		["140"] = 94,
		["141"] = 95,
		["142"] = 96,
		["145"] = 98,
		["146"] = 99,
		["147"] = 100,
		["148"] = 101,
		["149"] = 102,
		["150"] = 103,
		["151"] = 104,
		["153"] = 105,
		["154"] = 105,
		["155"] = 106,
		["156"] = 106,
		["157"] = 106,
		["158"] = 106,
		["159"] = 106,
		["160"] = 107,
		["161"] = 108,
		["162"] = 108,
		["163"] = 105,
		["167"] = 111,
		["168"] = 112,
		["169"] = 113,
		["171"] = 114,
		["172"] = 114,
		["173"] = 115,
		["174"] = 116,
		["175"] = 117,
		["177"] = 114,
		["180"] = 120,
		["181"] = 121,
		["182"] = 122,
		["183"] = 123,
		["184"] = 124,
		["185"] = 124,
		["186"] = 124,
		["187"] = 124,
		["188"] = 124,
		["189"] = 124,
		["190"] = 124,
		["191"] = 124,
		["192"] = 124,
		["193"] = 125,
		["194"] = 125,
		["195"] = 125,
		["196"] = 125,
		["197"] = 125,
		["198"] = 125,
		["199"] = 125,
		["200"] = 125,
		["201"] = 125,
		["202"] = 126,
		["203"] = 127,
		["204"] = 128,
		["207"] = 133,
		["209"] = 134,
		["210"] = 134,
		["211"] = 135,
		["212"] = 134,
		["216"] = 137,
		["217"] = 137,
		["218"] = 138,
		["219"] = 137,
		["222"] = 141,
		["223"] = 142,
		["225"] = 144,
		["226"] = 145,
		["227"] = 145,
		["229"] = 151,
		["230"] = 90,
		["231"] = 154,
		["232"] = 155,
		["233"] = 156,
		["234"] = 157,
		["235"] = 158,
		["236"] = 159,
		["237"] = 160,
		["238"] = 161,
		["239"] = 162,
		["240"] = 154,
		["241"] = 165,
		["242"] = 166,
		["243"] = 167,
		["245"] = 165,
		["246"] = 171,
		["247"] = 172,
		["248"] = 173,
		["249"] = 174,
		["251"] = 175,
		["252"] = 175,
		["253"] = 176,
		["254"] = 175,
		["258"] = 171,
		["259"] = 180,
		["260"] = 181,
		["261"] = 181,
		["262"] = 181,
		["263"] = 182,
		["265"] = 183,
		["266"] = 183,
		["267"] = 184,
		["268"] = 185,
		["269"] = 186,
		["270"] = 187,
		["271"] = 188,
		["272"] = 188,
		["273"] = 189,
		["274"] = 190,
		["275"] = 191,
		["279"] = 195,
		["281"] = 183,
		["284"] = 199,
		["285"] = 181,
		["286"] = 181,
		["287"] = 180,
		["288"] = 202,
		["289"] = 203,
		["290"] = 204,
		["291"] = 205,
		["294"] = 207,
		["295"] = 207,
		["296"] = 208,
		["297"] = 207,
		["300"] = 210,
		["301"] = 211,
		["302"] = 202,
		["303"] = 213,
		["304"] = 214,
		["305"] = 215,
		["307"] = 213,
		["308"] = 218,
		["309"] = 219,
		["310"] = 218,
		["311"] = 79,
		["312"] = 78,
		["313"] = 79,
		["315"] = 79,
		["316"] = 223,
		["317"] = 231,
		["318"] = 223,
		["319"] = 231,
		["321"] = 231,
		["322"] = 240,
		["323"] = 223,
		["324"] = 242,
		["325"] = 243,
		["326"] = 244,
		["327"] = 246,
		["328"] = 248,
		["329"] = 249,
		["330"] = 251,
		["331"] = 253,
		["332"] = 255,
		["333"] = 242,
		["334"] = 257,
		["335"] = 258,
		["336"] = 259,
		["338"] = 257,
		["339"] = 262,
		["340"] = 263,
		["341"] = 264,
		["343"] = 262,
		["344"] = 267,
		["345"] = 268,
		["346"] = 268,
		["347"] = 270,
		["348"] = 270,
		["349"] = 270,
		["350"] = 268,
		["351"] = 268,
		["352"] = 268,
		["353"] = 268,
		["354"] = 268,
		["355"] = 267,
		["356"] = 276,
		["357"] = 277,
		["358"] = 278,
		["359"] = 276,
		["360"] = 280,
		["361"] = 281,
		["362"] = 282,
		["363"] = 283,
		["364"] = 284,
		["365"] = 285,
		["369"] = 280,
		["370"] = 290,
		["371"] = 291,
		["372"] = 292,
		["373"] = 290,
		["374"] = 294,
		["375"] = 295,
		["376"] = 296,
		["379"] = 299,
		["380"] = 300,
		["381"] = 301,
		["384"] = 304,
		["385"] = 305,
		["386"] = 306,
		["387"] = 308,
		["388"] = 309,
		["389"] = 309,
		["390"] = 310,
		["392"] = 312,
		["393"] = 312,
		["394"] = 312,
		["395"] = 312,
		["396"] = 312,
		["397"] = 312,
		["398"] = 313,
		["399"] = 314,
		["401"] = 316,
		["402"] = 317,
		["403"] = 318,
		["404"] = 319,
		["406"] = 321,
		["407"] = 322,
		["408"] = 322,
		["409"] = 322,
		["410"] = 322,
		["411"] = 322,
		["412"] = 322,
		["413"] = 325,
		["414"] = 325,
		["415"] = 325,
		["416"] = 325,
		["417"] = 325,
		["418"] = 325,
		["420"] = 330,
		["421"] = 331,
		["422"] = 332,
		["423"] = 333,
		["424"] = 334,
		["425"] = 334,
		["427"] = 335,
		["428"] = 335,
		["430"] = 336,
		["431"] = 336,
		["434"] = 294,
		["435"] = 339,
		["436"] = 340,
		["439"] = 344,
		["440"] = 345,
		["442"] = 347,
		["443"] = 348,
		["444"] = 349,
		["445"] = 350,
		["446"] = 350,
		["447"] = 350,
		["448"] = 350,
		["449"] = 350,
		["450"] = 350,
		["451"] = 353,
		["452"] = 353,
		["453"] = 353,
		["454"] = 353,
		["455"] = 353,
		["456"] = 353,
		["459"] = 339,
		["460"] = 360,
		["461"] = 361,
		["462"] = 362,
		["463"] = 363,
		["464"] = 364,
		["465"] = 365,
		["466"] = 366,
		["467"] = 367,
		["468"] = 368,
		["469"] = 369,
		["470"] = 370,
		["471"] = 371,
		["472"] = 372,
		["474"] = 360,
		["475"] = 376,
		["476"] = 377,
		["477"] = 376,
		["478"] = 381,
		["479"] = 382,
		["480"] = 381,
		["481"] = 231,
		["482"] = 223,
		["483"] = 223,
		["484"] = 223,
		["485"] = 223,
		["486"] = 223,
		["487"] = 223,
		["488"] = 223,
		["489"] = 223,
		["490"] = 231,
		["492"] = 231,
		["493"] = 386,
		["494"] = 396,
		["495"] = 386,
		["496"] = 396,
		["497"] = 396,
		["498"] = 386,
		["499"] = 386,
		["500"] = 386,
		["501"] = 386,
		["502"] = 386,
		["503"] = 386,
		["504"] = 386,
		["505"] = 386,
		["506"] = 386,
		["507"] = 386,
		["508"] = 396,
		["510"] = 396,
		["511"] = 397,
		["512"] = 405,
		["513"] = 397,
		["514"] = 405,
		["515"] = 406,
		["516"] = 407,
		["517"] = 408,
		["519"] = 406,
		["520"] = 411,
		["521"] = 412,
		["522"] = 413,
		["523"] = 414,
		["524"] = 415,
		["527"] = 411,
		["528"] = 419,
		["529"] = 420,
		["530"] = 419,
		["531"] = 405,
		["532"] = 397,
		["533"] = 397,
		["534"] = 397,
		["535"] = 397,
		["536"] = 397,
		["537"] = 397,
		["538"] = 397,
		["539"] = 397,
		["540"] = 405,
		["542"] = 405,
		["543"] = 425,
		["544"] = 435,
		["545"] = 425,
		["546"] = 435,
		["547"] = 436,
		["548"] = 437,
		["549"] = 438,
		["551"] = 436,
		["552"] = 441,
		["553"] = 442,
		["554"] = 441,
		["555"] = 447,
		["556"] = 448,
		["559"] = 451,
		["560"] = 447,
		["561"] = 453,
		["562"] = 454,
		["565"] = 457,
		["566"] = 453,
		["567"] = 435,
		["568"] = 425,
		["569"] = 425,
		["570"] = 425,
		["571"] = 425,
		["572"] = 425,
		["573"] = 425,
		["574"] = 425,
		["575"] = 425,
		["576"] = 425,
		["577"] = 425,
		["578"] = 435,
		["580"] = 435,
		["581"] = 460,
		["582"] = 468,
		["583"] = 460,
		["584"] = 468,
		["585"] = 468,
		["586"] = 460,
		["587"] = 460,
		["588"] = 460,
		["589"] = 460,
		["590"] = 460,
		["591"] = 460,
		["592"] = 460,
		["593"] = 460,
		["594"] = 468,
		["596"] = 468,
		["597"] = 472,
		["598"] = 473,
		["599"] = 472,
		["600"] = 473,
		["601"] = 475,
		["602"] = 476,
		["603"] = 477,
		["604"] = 478,
		["607"] = 481,
		["608"] = 482,
		["609"] = 483,
		["610"] = 484,
		["611"] = 485,
		["613"] = 486,
		["614"] = 486,
		["615"] = 487,
		["616"] = 488,
		["617"] = 489,
		["618"] = 490,
		["620"] = 486,
		["623"] = 493,
		["624"] = 494,
		["625"] = 495,
		["628"] = 498,
		["629"] = 498,
		["630"] = 498,
		["631"] = 499,
		["633"] = 500,
		["634"] = 500,
		["635"] = 501,
		["636"] = 502,
		["637"] = 503,
		["639"] = 505,
		["641"] = 500,
		["644"] = 498,
		["645"] = 498,
		["646"] = 475,
		["647"] = 510,
		["648"] = 510,
		["649"] = 510,
		["651"] = 511,
		["652"] = 512,
		["653"] = 513,
		["656"] = 516,
		["657"] = 518,
		["658"] = 519,
		["659"] = 520,
		["660"] = 521,
		["661"] = 522,
		["662"] = 523,
		["663"] = 524,
		["664"] = 525,
		["665"] = 526,
		["666"] = 527,
		["667"] = 528,
		["668"] = 528,
		["669"] = 528,
		["670"] = 528,
		["671"] = 528,
		["672"] = 528,
		["673"] = 534,
		["674"] = 535,
		["675"] = 537,
		["676"] = 539,
		["677"] = 541,
		["678"] = 542,
		["679"] = 542,
		["680"] = 542,
		["681"] = 542,
		["682"] = 542,
		["683"] = 544,
		["684"] = 528,
		["685"] = 546,
		["686"] = 547,
		["687"] = 548,
		["688"] = 549,
		["689"] = 550,
		["690"] = 551,
		["691"] = 552,
		["693"] = 554,
		["695"] = 558,
		["696"] = 558,
		["697"] = 558,
		["698"] = 558,
		["699"] = 558,
		["700"] = 558,
		["701"] = 558,
		["702"] = 558,
		["703"] = 558,
		["705"] = 528,
		["706"] = 528,
		["707"] = 510,
		["708"] = 473,
		["709"] = 472,
		["710"] = 473,
		["712"] = 473,
		["713"] = 574,
		["714"] = 586,
		["715"] = 574,
		["716"] = 586,
		["717"] = 588,
		["718"] = 589,
		["719"] = 588,
		["720"] = 591,
		["721"] = 592,
		["722"] = 591,
		["723"] = 586,
		["724"] = 574,
		["725"] = 574,
		["726"] = 574,
		["727"] = 574,
		["728"] = 574,
		["729"] = 574,
		["730"] = 574,
		["731"] = 574,
		["732"] = 574,
		["733"] = 574,
		["734"] = 574,
		["735"] = 574,
		["736"] = 586,
		["738"] = 586,
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
g.modifier_phantom_lancer_illu = c()
local q = g.modifier_phantom_lancer_illu
q.name = "modifier_phantom_lancer_illu"
d(q, l)
function q.prototype.OnCreated(self, r)
	if IsClient() then
		local s = self:GetParent()
		ParticleManager:CreateParticle("particles/generic_gameplay/illusion_created.vpcf", PATTACH_CUSTOMORIGIN, s)
		local t = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_phantom_lancer/phantom_lancer_spawn_illusion.vpcf",
			PATTACH_CUSTOMORIGIN,
			s
		)
		ParticleManager:SetParticleControlEnt(t, 0, s, PATTACH_POINT_FOLLOW, "attach_hitloc", s:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(t, 1, s, PATTACH_ABSORIGIN_FOLLOW, nil, s:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(t)
	end
end
function q.prototype.OnRemoved(self, u)
	if IsServer() then
		local v = self:GetCaster()
		local s = self:GetParent()
		s:EmitSound("General.Illusion.Destroy")
		s:AddNoDraw()
	else
		local v = self:GetCaster()
		local s = self:GetParent()
		local t = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_phantom_lancer/phantomlancer_illusion_destroy.vpcf",
			PATTACH_CUSTOMORIGIN,
			v
		)
		ParticleManager:SetParticleControlEnt(t, 0, s, PATTACH_ABSORIGIN_FOLLOW, nil, s:GetAbsOrigin(), true)
		local w = ParticleManager:CreateParticle(
			"particles/generic_gameplay/illusion_killed.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil,
			v
		)
		ParticleManager:SetParticleControlEnt(w, 0, s, PATTACH_ABSORIGIN_FOLLOW, nil, s:GetAbsOrigin(), true)
	end
end
function q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_OVERRIDE }
end
function q.prototype.EOM_GetModifierAttackSpeedBonusOverride(self, r)
	if IsServer() and IsValid(self:GetCaster()) then
		local x = GetAttackspeed(self:GetCaster(), { phantom_lancer = 1 })
		if self:GetParent():HasModifier("modifier_phantom_lancer_talent_6") then
			x = x + BUFF_VALUE.PhantomEdgeAttackSpeed
		end
		return x
	end
end
q = e(
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
				GetStatusEffectName = "particles/status_fx/status_effect_phantom_lancer_illusion.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_HIGH,
			}
		),
	},
	q
)
g.modifier_phantom_lancer_illu = q
g.modifier_phantom_lancer_talent_interrupt = c()
local y = g.modifier_phantom_lancer_talent_interrupt
y.name = "modifier_phantom_lancer_talent_interrupt"
d(y, l)
function y.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true }
end
y = e(
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
	y
)
g.modifier_phantom_lancer_talent_interrupt = y
g.phantom_lancer_talent = c()
local z = g.phantom_lancer_talent
z.name = "phantom_lancer_talent"
d(z, i)
function z.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.position_ist = {}
	self.illusion_list = {}
	self.tick = 0.1
end
function z.prototype.CreateIllusion(self)
	if self.timer == nil then
		return
	end
	local v = self:GetCaster()
	local A = v:GetEnemy()
	if not IsInjurable(v, A) then
		return
	end
	local B = self:GetSpecialValueFor("max_count") + self:GetTalentValue("phantom_lancer_shard", "bonus_count")
	local C = self:GetSpecialValueFor("duration")
	local D = v:GetAbsOrigin()
	local E = A:GetAbsOrigin() - D
	if #self.position_ist == 0 then
		E.z = 0
		E = E:Normalized()
		do
			local F = 0
			while F < B do
				local G = RotatePosition(vec3_zero, QAngle(0, F * 360 / B, 0), E)
				local H = D + G * 200
				local I = self.position_ist
				I[#I + 1] = H
				F = F + 1
			end
		end
	end
	local J = 0
	if #self.illusion_list == B then
		local K = 100
		do
			local F = #self.illusion_list - 1
			while F >= 0 do
				if self.illusion_list[F + 1].time < K then
					J = F
					K = self.illusion_list[F + 1].time
				end
				F = F - 1
			end
		end
		self.illusion_list[J + 1].time = C
		if IsValid(self.illusion_list[J + 1].unit) then
			ParticleManager:CreateParticle(
				"particles/generic_gameplay/illusion_created.vpcf",
				PATTACH_CUSTOMORIGIN,
				self.illusion_list[J + 1].unit
			)
			local t = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_phantom_lancer/phantom_lancer_spawn_illusion.vpcf",
				PATTACH_CUSTOMORIGIN,
				self.illusion_list[J + 1].unit
			)
			ParticleManager:SetParticleControlEnt(
				t,
				0,
				self.illusion_list[J + 1].unit,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				self.illusion_list[J + 1].unit:GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControlEnt(
				t,
				1,
				self.illusion_list[J + 1].unit,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				self.illusion_list[J + 1].unit:GetAbsOrigin(),
				true
			)
			ParticleManager:ReleaseParticleIndex(t)
			self.illusion_list[J + 1].unit:EmitSound("General.Illusion.Create")
			self.illusion_list[J + 1].unit:AddNewModifier(
				v,
				self,
				"modifier_phantom_lancer_talent_interrupt",
				{ duration = 0.01 }
			)
		end
	else
		local L = {}
		do
			local F = 0
			while F < #self.position_ist do
				L[#L + 1] = F
				F = F + 1
			end
		end
		do
			local F = 0
			while F < #self.illusion_list do
				ArrayRemove(L, self.illusion_list[F + 1].pos)
				F = F + 1
			end
		end
		if #L > 0 then
			J = L[1]
		end
		local M = self:_CreateIllusion(self.position_ist[J + 1], E)
		local N = self.illusion_list
		N[#N + 1] = { unit = M, pos = J, time = C }
	end
	self:TiggerTl5()
end
function z.prototype._CreateIllusion(self, O, E)
	local v = self:GetCaster()
	local M = v:CreatePhantom(O, v)
	M:SetForwardVector(E)
	M:RemoveGesture(ACT_DOTA_SPAWN)
	M:SetMoveCapability(DOTA_UNIT_CAP_MOVE_NONE)
	M:AddNewModifier(v, self, "modifier_phantom_lancer_illu", nil)
	M:EmitSound("General.Illusion.Create")
	return M
end
function z.prototype.KillIllusion(self, P)
	if IsValid(P) then
		P:SafeRemoveUnit()
	end
end
function z.prototype.TiggerTl5(self)
	local Q = self:GetTalentValue("phantom_lancer_talent_5", "count")
	if Q > 0 then
		local R = self:GetCaster()
		do
			local F = 0
			while F < Q do
				TriggerAllWisp(R)
				F = F + 1
			end
		end
	end
end
function z.prototype.StartIlluTimer(self)
	self.timer = self:GameTimer(self.tick, function()
		local S = {}
		do
			local J = #self.illusion_list - 1
			while J >= 0 do
				if IsValid(self.illusion_list[J + 1].unit) then
					local T = self.illusion_list[J + 1].unit:entindex()
					if not S[T] then
						S[T] = true
						local U, V = self.illusion_list[J + 1], "time"
						U[V] = U[V] - self.tick
						if self.illusion_list[J + 1].time <= 0 then
							local W = table.remove(self.illusion_list, J + 1)
							self:KillIllusion(W.unit)
						end
					end
				else
					table.remove(self.illusion_list, J + 1)
				end
				J = J - 1
			end
		end
		return self.tick
	end)
end
function z.prototype.CloseIlluTimer(self)
	if self.timer ~= nil then
		self:StopTimer(self.timer)
		self.timer = nil
	end
	do
		local J = #self.illusion_list - 1
		while J >= 0 do
			self:KillIllusion(self.illusion_list[J + 1].unit)
			J = J - 1
		end
	end
	self.illusion_list = {}
	self:KillTl3Illu()
end
function z.prototype.KillTl3Illu(self)
	if IsValid(self.tl3_illusion) then
		self:KillIllusion(self.tl3_illusion)
	end
end
function z.prototype.GetIntrinsicModifierName(self)
	return "modifier_phantom_lancer_talent"
end
z = e({ j(nil) }, z)
g.phantom_lancer_talent = z
g.modifier_phantom_lancer_talent = c()
local X = g.modifier_phantom_lancer_talent
X.name = "modifier_phantom_lancer_talent"
d(X, l)
function X.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.illusion_cd = 0.1
end
function X.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
		+ self:GetAbilityTalentValue("phantom_lancer_talent_1", "bonus_chance")
	self.equip_chance = self:GetAbilitySpecialValueFor("equip_chance")
	self.pt_chance = self:GetAbilitySpecialValueFor("pt_chance")
		+ self:GetAbilityTalentValue("phantom_lancer_talent_4", "bonus_chance")
	self.pt_attack_pct = self:GetAbilitySpecialValueFor("pt_attack_pct")
		+ self:GetAbilityTalentValue("phantom_lancer_talent_2", "bonus_attack_pct")
	self.illu_chance = self:GetAbilitySpecialValueFor("illu_chance")
	self.tl3_chance = self:GetAbilityTalentValue("phantom_lancer_talent_3", "chance")
	self.tl5_add_hp = self:GetAbilityTalentValue("phantom_lancer_talent_5", "add_hp")
	self.tl6_cd = self:GetAbilityTalentValue("phantom_lancer_talent_6", "cd")
end
function X.prototype.OnCreated(self, r)
	if IsServer() then
		self.illusion_cd_list = {}
	end
end
function X.prototype.OnDestroy(self)
	if IsServer() then
		self:GetAbility():CloseIlluTimer()
	end
end
function X.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ILLUSION_ATTACK] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_SPAWN] = { self:GetParent() },
	}
end
function X.prototype.OnBattleStartBefore(self, r)
	self:GetAbility():StartIlluTimer()
	self:StartThink(0.1, "illusion_cd_timer")
end
function X.prototype.OnThink(self, Y)
	if Y == "illusion_cd_timer" then
		local Z = GameRules:GetGameTime()
		for J, _ in pairs(self.illusion_cd_list) do
			if Z >= _ then
				self.illusion_cd_list[J] = nil
			end
		end
	end
end
function X.prototype.OnBattleEnd(self, r)
	self:GetAbility():CloseIlluTimer()
	self:StartThink(-1, "illusion_cd_timer")
end
function X.prototype.OnIllusionAttack(self, a0)
	local a1 = a0.target
	if not IsInjurable(a0.attacker, a1) then
		return
	end
	if a0.attacker:HasModifier("modifier_phantom_lancer_talent_3_ptcl") then
		if self:PRD(self.tl3_chance + self.illu_chance, "tl3_chance") then
			self:GetAbility():CreateIllusion()
		end
	end
	local T = a0.attacker:entindex()
	local s = self:GetParent()
	local a2 = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
	local a3 = GetAttackDamage(s, { phantom_lancer = 1 }) * self.pt_attack_pct * 0.01
	local a4 = a0.attacker
	if a4 and a4:HasModifier("modifier_phantom_lancer_talent_6") then
		a3 = a3 + BUFF_VALUE.PhantomEdgeAttackDamage
	end
	s:DealDamage(a1, self:GetAbility(), a3, a2)
	if not self.parent:PassivesDisabled() and self:PRD(self.illu_chance) then
		self:GetAbility():CreateIllusion()
	end
	s:TriggerSectAttackNormal(a1, self.pt_chance)
	if self.pt_chance > 0 and self:PRD(self.pt_chance, "pt_chance") and not (self.illusion_cd_list[T] ~= nil) then
		self.illusion_cd_list[T] = GameRules:GetGameTime() + self.illusion_cd
		s:TriggerSectAttackRAndSR(a1)
	end
	if
		self.tl6_cd > 0
		and IsValid(a0.attacker)
		and not a0.attacker:HasModifier("modifier_phantom_lancer_talent_6_cooldown")
	then
		a0.attacker:AddNewModifier(
			s,
			self:GetAbility(),
			"modifier_phantom_lancer_talent_6",
			{ duration = BUFF_VALUE.PhantomEdgeDuration }
		)
		a0.attacker:AddNewModifier(
			s,
			self:GetAbility(),
			"modifier_phantom_lancer_talent_6_cooldown",
			{ duration = self.tl6_cd }
		)
	end
	if not self.parent:PassivesDisabled() and self:PRD(self.equip_chance, "equip_chance") then
		local a5 = self.parent:FindModifierByName("modifier_item_equipment_135")
		local a6 = self.parent:FindModifierByName("modifier_item_equipment_137")
		local a7 = self.parent:FindModifierByName("modifier_item_equipment_142")
		if a5 ~= nil then
			a5:EquipmentEffect(a1)
		end
		if a6 ~= nil then
			a6:EquipmentEffect(a1)
		end
		if a7 ~= nil then
			a7:EquipmentEffect(a1)
		end
	end
end
function X.prototype.OnCustomAttackLanded(self, a0)
	if a0.ability and IsValid(a0.ability) and a0.ability == self:GetAbility() then
		return
	end
	if not self.parent:PassivesDisabled() and self:PRD(self.chance) then
		self:GetAbility():CreateIllusion()
	end
	if self.tl6_cd > 0 then
		local s = self:GetParent()
		if IsValid(s) and not s:HasModifier("modifier_phantom_lancer_talent_6_cooldown") then
			s:AddNewModifier(
				s,
				self:GetAbility(),
				"modifier_phantom_lancer_talent_6",
				{ duration = BUFF_VALUE.PhantomEdgeDuration }
			)
			s:AddNewModifier(
				s,
				self:GetAbility(),
				"modifier_phantom_lancer_talent_6_cooldown",
				{ duration = self.tl6_cd }
			)
		end
	end
end
function X.prototype.OnWispSpawn(self, r)
	if self.tl3_chance > 0 and r.first and IsValid(r.wisp) then
		local s = self:GetParent()
		local A = s:GetEnemy()
		local O = r.wisp:GetAbsOrigin()
		local E = A:GetAbsOrigin() - O
		E.z = 0
		E = E:Normalized()
		local a8 = self:GetAbility()
		local M = a8:_CreateIllusion(O, E)
		a8.tl3_illusion = M
		M:AddNewModifier(s, a8, "modifier_phantom_lancer_talent_3_ptcl", nil)
		r.wisp:AddNewModifier(s, a8, "modifier_phantom_lancer_talent_3_wisp", nil)
	end
end
function X.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_HEALTH_BONUS }
end
function X.prototype.EOM_GetModifierWispHealthBonus(self)
	return self.tl5_add_hp
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
g.modifier_phantom_lancer_talent = X
g.modifier_phantom_lancer_talent_3_ptcl = c()
local a9 = g.modifier_phantom_lancer_talent_3_ptcl
a9.name = "modifier_phantom_lancer_talent_3_ptcl"
d(a9, l)
a9 = e(
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
				StatusEffectPriority = MODIFIER_PRIORITY_SUPER_ULTRA,
				GetStatusEffectName = "particles/units/heroes/hero_phantom_lancer/status_effect_phantom_illstrong.vpcf",
			}
		),
	},
	a9
)
g.modifier_phantom_lancer_talent_3_ptcl = a9
g.modifier_phantom_lancer_talent_3_wisp = c()
local aa = g.modifier_phantom_lancer_talent_3_wisp
aa.name = "modifier_phantom_lancer_talent_3_wisp"
d(aa, l)
function aa.prototype.OnCreated(self, r)
	if IsServer() then
		self:GetParent():AddNoDraw()
	end
end
function aa.prototype.OnRemoved(self)
	if IsServer() then
		local a8 = self:GetAbility()
		if IsValid(a8) then
			a8:KillTl3Illu()
		end
	end
end
function aa.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_SINGLE_WISP_DISARMED] = true }
end
aa = e(
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
	aa
)
g.modifier_phantom_lancer_talent_3_wisp = aa
g.modifier_phantom_lancer_talent_6 = c()
local ab = g.modifier_phantom_lancer_talent_6
ab.name = "modifier_phantom_lancer_talent_6"
d(ab, l)
function ab.prototype.OnCreated(self, r)
	if IsServer() then
		self:GetParent():EmitSound("Hero_PhantomLancer.PhantomEdge")
	end
end
function ab.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
	}
end
function ab.prototype.EOM_GetModifierAttackDamageBonus(self, r)
	if r and r.phantom_lancer then
		return
	end
	return BUFF_VALUE.PhantomEdgeAttackDamage
end
function ab.prototype.EOM_GetModifierAttackSpeedBonus(self, r)
	if r and r.phantom_lancer then
		return
	end
	return BUFF_VALUE.PhantomEdgeAttackSpeed
end
ab = e(
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
				GetEffectName = "particles/units/heroes/hero_phantom_lancer/phantomlancer_edge_boost.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
			}
		),
	},
	ab
)
g.modifier_phantom_lancer_talent_6 = ab
g.modifier_phantom_lancer_talent_6_cooldown = c()
local ac = g.modifier_phantom_lancer_talent_6_cooldown
ac.name = "modifier_phantom_lancer_talent_6_cooldown"
d(ac, l)
ac = e(
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
	ac
)
g.modifier_phantom_lancer_talent_6_cooldown = ac
g.phantom_lancer_ult = c()
local ad = g.phantom_lancer_ult
ad.name = "phantom_lancer_ult"
d(ad, o)
function ad.prototype.OnSpellStart(self)
	local v = self:GetCaster()
	local A = v:GetEnemy()
	if not IsInjurable(v, A) then
		return
	end
	v:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	local ae = { v }
	local af = self:GetSpecialValueFor("pt_ulti_damage")
	local ag = v:FindAbilityByName("phantom_lancer_talent")
	if IsValid(ag) then
		do
			local F = 0
			while F < #ag.illusion_list do
				local P = ag.illusion_list[F + 1].unit
				if IsValid(P) then
					P:StartGesture(ACT_DOTA_CAST_ABILITY_1)
					ae[#ae + 1] = P
				end
				F = F + 1
			end
		end
		if IsValid(ag.tl3_illusion) then
			ag.tl3_illusion:StartGesture(ACT_DOTA_CAST_ABILITY_1)
			ae[#ae + 1] = ag.tl3_illusion
		end
	end
	self:GameTimer(0.33, function()
		v:EmitSound("Hero_PhantomLancer.SpiritLance.Throw")
		do
			local F = 0
			while F < #ae do
				local P = ae[F + 1]
				if P == v then
					self:SpiritLance(P)
				else
					self:SpiritLance(P, af)
				end
				F = F + 1
			end
		end
	end)
end
function ad.prototype.SpiritLance(self, P, ah)
	if ah == nil then
		ah = 100
	end
	local v = self:GetCaster()
	local A = v:GetEnemy()
	if not IsInjurable(v, A, P) then
		return
	end
	local C = self:GetSpecialValueFor("duration")
	local a3 = self:GetSpecialValueFor("damage")
	a3 = a3 * ah * 0.01
	local D = P:GetAbsOrigin()
	local E = A:GetAbsOrigin() - D
	E.z = 0
	E = E:Normalized()
	local O = D + E * 90
	local t = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phantom_lancer/phantomlancer_spiritlance_caster.vpcf",
		PATTACH_CUSTOMORIGIN,
		P,
		v
	)
	ParticleManager:SetParticleControl(t, 1, O)
	ParticleManager:ReleaseParticleIndex(t)
	Projectile:CreateTrackingProjectile({
		hCaster = v,
		hTarget = A,
		Ability = self,
		vSpawnOrigin = O,
		iMoveSpeed = PROJECTILE_SPEED_NORMAL,
		OnProjectileCreated = function(ai)
			local aj = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_phantom_lancer/phantomlancer_spiritlance_projectile.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil,
				v
			)
			ParticleManager:SetParticleControl(aj, 0, ai._vPosition)
			ParticleManager:SetParticleControlForward(aj, 0, ai.vDirection)
			ParticleManager:SetParticleControl(aj, 1, ai.vTarget)
			ParticleManager:SetParticleControl(aj, 2, Vector(ai.iMoveSpeed, 0, 0))
			ai._iParticleID = aj
		end,
		OnProjectileHit = function(ak, al, am)
			if IsValid(self) and IsInjurable(A, v) then
				if P == v then
					A:EmitSound("Hero_PhantomLancer.SpiritLance.Impact")
					local ag = v:FindAbilityByName("phantom_lancer_talent")
					if IsValid(ag) then
						ag:CreateIllusion()
					end
					A:AddNewModifier(v, self, "modifier_phantom_lancer_ult_debuff", { duration = C })
				end
				DamageSystem:dealDamage({
					attacker = v,
					target = A,
					ability = self,
					damage = a3,
					damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
					damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
					damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
				})
			end
		end,
	})
end
ad = e({ p(nil) }, ad)
g.phantom_lancer_ult = ad
g.modifier_phantom_lancer_ult_debuff = c()
local an = g.modifier_phantom_lancer_ult_debuff
an.name = "modifier_phantom_lancer_ult_debuff"
d(an, l)
function an.prototype.GetAbilitySpecialValue(self)
	self.attackspeed_reduce = self:GetAbilitySpecialValueFor("attackspeed_reduce")
end
function an.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = -self.attackspeed_reduce }
end
an = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetEffectName = "particles/units/heroes/hero_phantom_lancer/phantomlancer_spiritlance_target.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
				GetStatusEffectName = "particles/status_fx/status_effect_phantoml_slowlance.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_NORMAL,
			}
		),
	},
	an
)
g.modifier_phantom_lancer_ult_debuff = an
return g