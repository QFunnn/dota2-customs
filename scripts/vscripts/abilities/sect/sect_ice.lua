--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/sect/sect_ice"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
local g = b.__TS__SparseArrayNew
local h = b.__TS__SparseArrayPush
local i = b.__TS__SparseArraySpread
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
		["18"] = 4,
		["19"] = 5,
		["20"] = 4,
		["21"] = 5,
		["23"] = 5,
		["24"] = 10,
		["25"] = 12,
		["26"] = 14,
		["27"] = 16,
		["28"] = 40,
		["29"] = 4,
		["30"] = 43,
		["31"] = 44,
		["32"] = 45,
		["33"] = 46,
		["34"] = 47,
		["35"] = 48,
		["36"] = 49,
		["37"] = 50,
		["38"] = 51,
		["39"] = 52,
		["40"] = 54,
		["41"] = 55,
		["42"] = 56,
		["43"] = 57,
		["44"] = 58,
		["45"] = 59,
		["46"] = 60,
		["47"] = 61,
		["48"] = 62,
		["49"] = 63,
		["50"] = 64,
		["51"] = 65,
		["52"] = 66,
		["53"] = 67,
		["54"] = 68,
		["55"] = 43,
		["56"] = 70,
		["57"] = 70,
		["58"] = 70,
		["60"] = 71,
		["61"] = 72,
		["65"] = 73,
		["66"] = 74,
		["69"] = 75,
		["70"] = 75,
		["71"] = 75,
		["72"] = 75,
		["73"] = 75,
		["74"] = 75,
		["75"] = 75,
		["79"] = 78,
		["82"] = 79,
		["83"] = 80,
		["84"] = 81,
		["85"] = 81,
		["86"] = 81,
		["87"] = 81,
		["88"] = 81,
		["89"] = 81,
		["90"] = 81,
		["91"] = 81,
		["92"] = 82,
		["93"] = 83,
		["94"] = 83,
		["95"] = 83,
		["96"] = 83,
		["97"] = 83,
		["98"] = 84,
		["99"] = 84,
		["100"] = 84,
		["101"] = 84,
		["102"] = 84,
		["103"] = 85,
		["104"] = 85,
		["105"] = 85,
		["106"] = 85,
		["107"] = 85,
		["108"] = 86,
		["109"] = 86,
		["110"] = 86,
		["111"] = 86,
		["112"] = 86,
		["113"] = 87,
		["114"] = 87,
		["115"] = 87,
		["116"] = 87,
		["117"] = 87,
		["121"] = 90,
		["124"] = 91,
		["125"] = 92,
		["126"] = 92,
		["127"] = 92,
		["128"] = 92,
		["129"] = 92,
		["130"] = 92,
		["131"] = 92,
		["132"] = 92,
		["133"] = 92,
		["134"] = 93,
		["135"] = 93,
		["136"] = 93,
		["137"] = 93,
		["138"] = 93,
		["139"] = 94,
		["140"] = 95,
		["141"] = 95,
		["142"] = 95,
		["143"] = 96,
		["144"] = 97,
		["145"] = 98,
		["146"] = 99,
		["148"] = 101,
		["149"] = 101,
		["150"] = 101,
		["151"] = 101,
		["152"] = 101,
		["153"] = 101,
		["154"] = 101,
		["155"] = 101,
		["157"] = 95,
		["158"] = 95,
		["162"] = 106,
		["165"] = 107,
		["169"] = 110,
		["172"] = 111,
		["173"] = 111,
		["174"] = 111,
		["175"] = 111,
		["176"] = 111,
		["177"] = 111,
		["178"] = 111,
		["182"] = 114,
		["185"] = 115,
		["186"] = 115,
		["187"] = 115,
		["188"] = 115,
		["189"] = 115,
		["190"] = 115,
		["194"] = 118,
		["197"] = 119,
		["198"] = 119,
		["199"] = 119,
		["200"] = 119,
		["201"] = 119,
		["202"] = 119,
		["203"] = 119,
		["208"] = 70,
		["209"] = 124,
		["210"] = 125,
		["211"] = 124,
		["212"] = 5,
		["213"] = 4,
		["214"] = 5,
		["216"] = 5,
		["217"] = 129,
		["218"] = 137,
		["219"] = 129,
		["220"] = 137,
		["222"] = 137,
		["223"] = 144,
		["224"] = 147,
		["225"] = 149,
		["226"] = 151,
		["227"] = 182,
		["228"] = 129,
		["229"] = 188,
		["230"] = 189,
		["231"] = 190,
		["232"] = 192,
		["233"] = 193,
		["234"] = 194,
		["235"] = 195,
		["236"] = 196,
		["237"] = 197,
		["238"] = 198,
		["239"] = 200,
		["240"] = 201,
		["241"] = 202,
		["242"] = 203,
		["243"] = 204,
		["244"] = 205,
		["245"] = 206,
		["246"] = 207,
		["247"] = 208,
		["248"] = 209,
		["249"] = 210,
		["250"] = 211,
		["251"] = 212,
		["252"] = 213,
		["253"] = 214,
		["254"] = 215,
		["255"] = 216,
		["256"] = 217,
		["257"] = 219,
		["258"] = 220,
		["259"] = 221,
		["260"] = 188,
		["261"] = 224,
		["262"] = 225,
		["263"] = 226,
		["264"] = 227,
		["266"] = 229,
		["267"] = 224,
		["268"] = 232,
		["269"] = 233,
		["270"] = 234,
		["271"] = 237,
		["272"] = 238,
		["273"] = 239,
		["274"] = 240,
		["275"] = 241,
		["278"] = 246,
		["279"] = 247,
		["280"] = 248,
		["281"] = 249,
		["282"] = 250,
		["283"] = 251,
		["287"] = 232,
		["288"] = 256,
		["289"] = 257,
		["290"] = 257,
		["291"] = 257,
		["292"] = 260,
		["293"] = 260,
		["294"] = 260,
		["295"] = 257,
		["296"] = 257,
		["297"] = 262,
		["298"] = 262,
		["299"] = 262,
		["300"] = 257,
		["301"] = 257,
		["302"] = 256,
		["303"] = 265,
		["304"] = 266,
		["305"] = 266,
		["306"] = 266,
		["307"] = 266,
		["308"] = 265,
		["309"] = 273,
		["310"] = 274,
		["311"] = 273,
		["312"] = 276,
		["313"] = 277,
		["314"] = 277,
		["316"] = 278,
		["317"] = 279,
		["318"] = 280,
		["319"] = 281,
		["320"] = 282,
		["321"] = 282,
		["322"] = 282,
		["323"] = 282,
		["324"] = 282,
		["325"] = 282,
		["327"] = 286,
		["328"] = 276,
		["329"] = 288,
		["330"] = 289,
		["331"] = 290,
		["332"] = 291,
		["333"] = 292,
		["334"] = 293,
		["335"] = 294,
		["336"] = 296,
		["337"] = 298,
		["338"] = 299,
		["340"] = 303,
		["341"] = 304,
		["342"] = 306,
		["343"] = 307,
		["344"] = 308,
		["345"] = 309,
		["346"] = 310,
		["347"] = 311,
		["349"] = 313,
		["350"] = 314,
		["353"] = 317,
		["354"] = 318,
		["355"] = 319,
		["356"] = 320,
		["357"] = 320,
		["358"] = 320,
		["359"] = 320,
		["360"] = 320,
		["361"] = 320,
		["362"] = 320,
		["364"] = 322,
		["365"] = 323,
		["366"] = 323,
		["367"] = 323,
		["368"] = 323,
		["369"] = 323,
		["370"] = 323,
		["371"] = 323,
		["375"] = 336,
		["376"] = 337,
		["377"] = 338,
		["378"] = 338,
		["379"] = 338,
		["380"] = 338,
		["381"] = 338,
		["382"] = 338,
		["385"] = 288,
		["386"] = 342,
		["387"] = 343,
		["388"] = 344,
		["389"] = 345,
		["390"] = 346,
		["391"] = 347,
		["392"] = 349,
		["393"] = 350,
		["394"] = 352,
		["397"] = 342,
		["398"] = 363,
		["399"] = 364,
		["400"] = 365,
		["401"] = 366,
		["403"] = 363,
		["404"] = 369,
		["405"] = 370,
		["406"] = 371,
		["407"] = 372,
		["408"] = 373,
		["411"] = 369,
		["412"] = 399,
		["413"] = 400,
		["414"] = 401,
		["415"] = 402,
		["416"] = 404,
		["417"] = 407,
		["419"] = 410,
		["420"] = 411,
		["422"] = 415,
		["423"] = 416,
		["425"] = 419,
		["426"] = 420,
		["428"] = 446,
		["430"] = 399,
		["431"] = 452,
		["432"] = 453,
		["433"] = 454,
		["434"] = 455,
		["435"] = 456,
		["439"] = 452,
		["440"] = 462,
		["441"] = 463,
		["444"] = 466,
		["447"] = 469,
		["448"] = 470,
		["450"] = 470,
		["453"] = 462,
		["454"] = 474,
		["455"] = 475,
		["456"] = 476,
		["458"] = 476,
		["459"] = 476,
		["460"] = 476,
		["462"] = 476,
		["465"] = 476,
		["466"] = 476,
		["468"] = 476,
		["469"] = 474,
		["470"] = 137,
		["471"] = 129,
		["472"] = 129,
		["473"] = 129,
		["474"] = 129,
		["475"] = 129,
		["476"] = 129,
		["477"] = 129,
		["478"] = 137,
		["480"] = 137,
		["481"] = 480,
		["482"] = 489,
		["483"] = 480,
		["484"] = 489,
		["485"] = 495,
		["486"] = 496,
		["487"] = 497,
		["488"] = 498,
		["489"] = 499,
		["490"] = 495,
		["491"] = 501,
		["492"] = 502,
		["493"] = 503,
		["494"] = 504,
		["495"] = 505,
		["496"] = 506,
		["497"] = 507,
		["498"] = 507,
		["499"] = 507,
		["500"] = 507,
		["501"] = 507,
		["502"] = 507,
		["503"] = 508,
		["504"] = 508,
		["505"] = 508,
		["506"] = 508,
		["507"] = 508,
		["508"] = 508,
		["511"] = 511,
		["512"] = 512,
		["513"] = 512,
		["514"] = 512,
		["515"] = 512,
		["516"] = 512,
		["517"] = 512,
		["518"] = 512,
		["519"] = 512,
		["520"] = 513,
		["521"] = 514,
		["522"] = 514,
		["523"] = 514,
		["524"] = 514,
		["525"] = 514,
		["526"] = 514,
		["527"] = 514,
		["528"] = 514,
		["530"] = 501,
		["531"] = 517,
		["532"] = 518,
		["533"] = 519,
		["535"] = 517,
		["536"] = 522,
		["537"] = 523,
		["538"] = 524,
		["539"] = 525,
		["540"] = 526,
		["541"] = 526,
		["542"] = 526,
		["543"] = 526,
		["544"] = 526,
		["545"] = 526,
		["546"] = 526,
		["547"] = 527,
		["548"] = 527,
		["549"] = 527,
		["550"] = 527,
		["551"] = 527,
		["552"] = 527,
		["553"] = 527,
		["554"] = 527,
		["556"] = 522,
		["557"] = 530,
		["558"] = 531,
		["559"] = 530,
		["560"] = 489,
		["561"] = 480,
		["562"] = 480,
		["563"] = 480,
		["564"] = 480,
		["565"] = 480,
		["566"] = 480,
		["567"] = 480,
		["568"] = 480,
		["569"] = 489,
		["571"] = 489,
		["572"] = 538,
		["573"] = 545,
		["574"] = 538,
		["575"] = 545,
		["576"] = 549,
		["577"] = 552,
		["578"] = 549,
		["579"] = 564,
		["580"] = 565,
		["581"] = 564,
		["582"] = 569,
		["583"] = 570,
		["584"] = 569,
		["585"] = 545,
		["586"] = 538,
		["587"] = 545,
		["589"] = 545,
		["591"] = 575,
		["592"] = 587,
		["593"] = 575,
		["594"] = 587,
		["595"] = 589,
		["596"] = 590,
		["597"] = 591,
		["598"] = 592,
		["599"] = 593,
		["600"] = 596,
		["601"] = 597,
		["603"] = 589,
		["604"] = 600,
		["605"] = 601,
		["606"] = 602,
		["609"] = 605,
		["610"] = 606,
		["611"] = 607,
		["614"] = 610,
		["615"] = 611,
		["616"] = 611,
		["617"] = 611,
		["618"] = 611,
		["619"] = 611,
		["620"] = 611,
		["621"] = 611,
		["622"] = 612,
		["623"] = 613,
		["625"] = 600,
		["626"] = 630,
		["627"] = 631,
		["628"] = 632,
		["629"] = 633,
		["631"] = 630,
		["632"] = 636,
		["633"] = 637,
		["634"] = 636,
		["635"] = 641,
		["636"] = 642,
		["637"] = 641,
		["638"] = 587,
		["639"] = 575,
		["640"] = 575,
		["641"] = 575,
		["642"] = 575,
		["643"] = 575,
		["644"] = 575,
		["645"] = 575,
		["646"] = 575,
		["647"] = 575,
		["648"] = 575,
		["649"] = 575,
		["650"] = 587,
		["652"] = 587,
	}
)
local k = {}
local l = require("lib.dota_ts_adapter")
local m = l.BaseAbility
local n = l.registerAbility
local o = require("modifiers.eom_modifier")
local p = o.EOMModifier
local q = o.registerEOMModifier
k.sect_ice = c()
local r = k.sect_ice
r.name = "sect_ice"
d(r, m)
function r.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.timerInterval = 0.1
	self.n_92_timer = 0
	self.n_95_timer = 0
	self.sr_100_timer = 0
	self.sr_161_enable = false
end
function r.prototype.GetAbilitySpecialValue(self)
	self.ice_count_extra = self:GetSpecialValueFor("ice_count_extra")
	self.ice_fury_pct = self:GetSpecialValueFor("ice_fury_pct")
	self.n_86_chance = self:GetSectSpecialValueFor("86", "n_86_chance")
	self.n_86_poison = self:GetSectSpecialValueFor("86", "n_86_poison")
	self.n_92_ice_count = self:GetSectSpecialValueFor("92", "n_92_ice_count")
	self.n_92_interval = self:GetSectSpecialValueFor("92", "n_92_interval")
	self.n_94_chance = self:GetSectSpecialValueFor("94", "n_94_chance")
	self.n_94_ice_count = self:GetSectSpecialValueFor("94", "n_94_ice_count")
	self.n_95_chance = self:GetSectSpecialValueFor("95", "n_95_chance")
	self.r_98_chance = self:GetSectSpecialValueFor("98", "r_98_chance")
	self.r_98_damage = self:GetSectSpecialValueFor("98", "r_98_damage")
	self.r_98_effect_1 = self:GetSectSpecialValueFor("98", "effect_1")
	self.r_99_chance = self:GetSectSpecialValueFor("99", "r_99_chance")
	self.r_99_ice_count = self:GetSectSpecialValueFor("99", "r_99_ice_count")
	self.sr_100_interval = self:GetSectSpecialValueFor("100", "sr_100_interval")
	self.sr_100_base_damage = self:GetSectSpecialValueFor("100", "sr_100_base_damage")
	self.sr_100_damage_per_stack = self:GetSectSpecialValueFor("100", "sr_100_damage_per_stack")
	self.n_134_chance = self:GetSectSpecialValueFor("134", "n_134_chance")
	self.n_134_fury = self:GetSectSpecialValueFor("134", "n_134_fury")
	self.r_156_ice = self:GetSectSpecialValueFor("156", "r_156_ice")
	self.r_156_ice_permanent = self:GetSectSpecialValueFor("156", "r_156_ice_permanent")
	self.sr_161_threshold = self:GetSectSpecialValueFor("161", "sr_161_threshold")
	self.n_175_chance = self:GetSectSpecialValueFor("175", "n_175_chance")
	self.n_175_chaos_count = self:GetSectSpecialValueFor("175", "n_175_chaos_count")
end
function r.prototype.TriggerByName(self, s, t)
	if t == nil then
		t = self:GetCaster():GetEnemy()
	end
	local u = self:GetCaster()
	if not IsInjurable(u, t) then
		return
	end
	repeat
		local v = s
		local w = v == "92"
		if w then
			do
				AddIce(u, t, self.n_92_ice_count, "92", "AbilityUpgrade")
				break
			end
		end
		w = w or v == "100"
		if w then
			do
				local x = GetIce(t)
				local y = self.sr_100_base_damage + x * self.sr_100_damage_per_stack
				u:DealDamage(t, self, y, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, nil, "100")
				local z = ParticleManager:CreateParticle("particles/sect/sect_ice_100.vpcf", PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControl(z, 0, t:GetAbsOrigin())
				ParticleManager:SetParticleControl(z, 1, Vector(425, 2, 1000))
				ParticleManager:SetParticleControl(z, 2, t:GetAbsOrigin())
				ParticleManager:SetParticleControl(z, 3, Vector(1, 0, 0))
				EmitSoundOnLocationWithCaster(t:GetAbsOrigin(), "Hero_Crystal.CrystalNova", u)
				break
			end
		end
		w = w or v == "98"
		if w then
			do
				local z = ParticleManager:CreateParticle(
					"particles/sect/sect_ice_freezing_attack.vpcf",
					PATTACH_CUSTOMORIGIN,
					t
				)
				ParticleManager:SetParticleControlEnt(z, 0, t, PATTACH_ABSORIGIN_FOLLOW, nil, t:GetAbsOrigin(), false)
				ParticleManager:SetParticleControl(
					z,
					1,
					t:GetAbsOrigin() + RandomVector(RandomInt(0, 150)) + Vector(0, 0, 800)
				)
				ParticleManager:ReleaseParticleIndex(z)
				u:GameTimer(0.2, function()
					if IsValid(t) and IsValid(u) and IsValid(self) then
						local A = self.r_98_damage
						if self.r_98_effect_1 > 0 then
							A = A + GetIce(t) * self.r_98_effect_1 * 0.01
						end
						u:DealDamage(t, self, A, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, nil, "98")
					end
				end)
				break
			end
		end
		w = w or v == "134"
		if w then
			do
				AddFury(u, self.n_134_fury, "134", "AbilityUpgrade")
				break
			end
		end
		w = w or v == "86"
		if w then
			do
				AddPoison(u, t, self.n_86_poison, "86", "AbilityUpgrade")
				break
			end
		end
		w = w or v == "175"
		if w then
			do
				AddChaos(u, GetSectChaosModifiedValue(u, self.n_175_chaos_count), "175", "AbilityUpgrade")
				break
			end
		end
		w = w or v == "99"
		if w then
			do
				AddIce(u, t, self.r_99_ice_count, "99", "AbilityUpgrade")
				break
			end
		end
	until true
end
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_sect_ice"
end
r = e({ n(nil) }, r)
k.sect_ice = r
k.modifier_sect_ice = c()
local B = k.modifier_sect_ice
B.name = "modifier_sect_ice"
d(B, p)
function B.prototype.____constructor(self, ...)
	p.prototype.____constructor(self, ...)
	self.timerInterval = 0.1
	self.n_92_timer = 0
	self.n_95_timer = 0
	self.sr_100_timer = 0
	self.sr_161_enable = false
end
function B.prototype.GetAbilitySpecialValue(self)
	self.ice_count_extra = self:GetAbilitySpecialValueFor("ice_count_extra")
	self.ice_fury_pct = self:GetAbilitySpecialValueFor("ice_fury_pct")
	self.n_86_chance = self:GetSectSpecialValueFor("86", "n_86_chance")
	self.n_86_poison = self:GetSectSpecialValueFor("86", "n_86_poison")
	self.n_92_ice_count = self:GetSectSpecialValueFor("92", "n_92_ice_count")
	self.n_92_interval = self:GetSectSpecialValueFor("92", "n_92_interval")
	self.n_94_chance = self:GetSectSpecialValueFor("94", "n_94_chance")
	self.n_94_ice_count = self:GetSectSpecialValueFor("94", "n_94_ice_count")
	self.n_95_chance = self:GetSectSpecialValueFor("95", "n_95_chance")
	self.r_98_chance = self:GetSectSpecialValueFor("98", "r_98_chance")
	self.r_98_effect_1 = self:GetSectSpecialValueFor("98", "effect_1")
	self.r_99_chance = self:GetSectSpecialValueFor("99", "r_99_chance")
	self.r_99_ice_count = self:GetSectSpecialValueFor("99", "r_99_ice_count")
	self.sr_100_interval = self:GetSectSpecialValueFor("100", "sr_100_interval")
	self.sr_100_base_damage = self:GetSectSpecialValueFor("100", "sr_100_base_damage")
	self.sr_100_damage_per_stack = self:GetSectSpecialValueFor("100", "sr_100_damage_per_stack")
	self.n_134_chance = self:GetSectSpecialValueFor("134", "n_134_chance")
	self.n_134_fury = self:GetSectSpecialValueFor("134", "n_134_fury")
	self.sr_146_duration = self:GetSectSpecialValueFor("146", "sr_146_duration")
	self.sr_146_interval = self:GetSectSpecialValueFor("146", "sr_146_interval")
	self.sr_146_damage = self:GetSectSpecialValueFor("146", "sr_146_damage")
	self.sr_146_count = self:GetSectSpecialValueFor("146", "sr_146_count")
	self.r_156_ice = self:GetSectSpecialValueFor("156", "r_156_ice")
	self.r_156_ice_permanent = self:GetSectSpecialValueFor("156", "r_156_ice_permanent")
	self.sr_161_threshold = self:GetSectSpecialValueFor("161", "sr_161_threshold")
	self.n_175_chance = self:GetSectSpecialValueFor("175", "n_175_chance")
	self.n_175_chaos_count = self:GetSectSpecialValueFor("175", "n_175_chaos_count")
	self.trigger_chance = self:GetCustomAbilityValueFor("sect_ice_trigger", "chance")
	self.effect_value = self:GetCustomAbilityValueFor("sect_ice_effect", "value")
	self.ability:GetAbilitySpecialValue()
end
function B.prototype.GetIceFuryPct(self)
	if IsServer() then
		local C = f(AbilityShop.pickList, "sect_fury") and 100 + self.ice_fury_pct or 100
		self:SetStackCount(C)
	end
	return self:GetStackCount() * 0.01
end
function B.prototype.OnIntervalThink(self)
	local D = self:GetParent()
	local E = D:GetEnemy()
	if self.n_92_interval > 0 then
		self.n_92_timer = self.n_92_timer + self.timerInterval
		if self.n_92_timer >= self.n_92_interval then
			self.n_92_timer = self.n_92_timer - self.n_92_interval
			self.ability:TriggerByName("92")
		end
	end
	if self.sr_100_interval > 0 then
		self.sr_100_timer = self.sr_100_timer + self.timerInterval
		if self.sr_100_timer >= self.sr_100_interval then
			self.sr_100_timer = self.sr_100_timer - self.sr_100_interval
			if IsValid(E) then
				self.ability:TriggerByName("100", E)
			end
		end
	end
end
function B.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function B.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_STACK_BONUS_PERCENTAGE] = self.ice_count_extra
			* self:GetIceFuryPct(),
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_ICE_PERCENTAGE] = self.n_95_chance,
	}
end
function B.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MIN_HEALTH }
end
function B.prototype.EOM_GetModifierMinHealth(self, F)
	if not self.sr_161_enable then
		return 0
	end
	local u = self:GetParent()
	local G = u:GetMaxHealth() * self.sr_161_threshold * 0.01
	if u:GetHealth() - F.damage <= G then
		self.sr_161_enable = false
		u:AddNewModifier(u, self:GetAbility(), "modifier_sect_ice_161", { duration = BUFF_VALUE.ColdEmbraceDuration })
	end
	return G
end
function B.prototype.OnBattleStartBefore(self, F)
	local D = self:GetParent()
	local H = self:GetAbility()
	local E = D:GetEnemy()
	self.n_92_timer = 0
	self.n_95_timer = 0
	self.sr_100_timer = 0
	self.sr_161_enable = self.sr_161_threshold > 0
	if IsInjurable(E) then
		E:AddNewModifier(D, H, "modifier_ice_permanent", {})
	end
	local I = self.r_156_ice + GetIcePreBattle(D)
	if I > 0 and IsInjurable(E) then
		local J = E:FindModifierByName("modifier_fury_custom")
		if IsValid(J) then
			local K = J:GetStackCount()
			if K <= I then
				I = I - K
				J:Destroy()
			else
				J:DecrementStackCount(I)
				I = 0
			end
		end
		if I > 0 then
			if I >= self.r_156_ice and self.r_156_ice > 0 then
				I = I - self.r_156_ice
				AddIce(D, E, self.r_156_ice, "156", "AbilityUpgrade")
			end
			if I > 0 then
				AddIce(D, E, I, "sect_ice", "Ability")
			end
		end
	end
	if self.r_156_ice_permanent > 0 then
		if IsInjurable(E) then
			E:AddNewModifier(D, self:GetAbility(), "modifier_sect_ice_156_debuff", {})
		end
	end
end
function B.prototype.OnBattleStart(self, F)
	if IsServer() then
		local D = self:GetParent()
		local H = self:GetAbility()
		local E = D:GetEnemy()
		self:StartIntervalThink(self.timerInterval)
		if self.sr_146_duration > 0 and IsInjurable(E) then
			CombatLog:recordSectAbilityCast(D, "146")
			E:AddNewModifier(D, H, "modifier_sect_ice_146_debuff", { duration = self.sr_146_duration })
		end
	end
end
function B.prototype.OnBattleEnd(self, F)
	if IsServer() then
		self:StartIntervalThink(-1)
		self:StartThink(-1, "sr_146_interval")
	end
end
function B.prototype.OnThink(self, L)
	local D = self:GetParent()
	local E = D:GetEnemy()
	if not IsInjurable(E) then
		self:StartThink(-1, L)
		return
	end
end
function B.prototype.OnIceGained(self, F)
	local u = self:GetParent()
	local M = u:GetEnemy()
	if IsInjurable(M) then
		if self.r_98_chance > 0 and self:PRD(self.r_98_chance, "r_98_chance") then
			self.ability:TriggerByName("98", M)
		end
		if self.n_134_chance > 0 and self:PRD(self.n_134_chance, "n_134_chance") then
			self.ability:TriggerByName("134")
		end
		if self.n_86_chance > 0 and self:PRD(self.n_86_chance, "n_86_chance") then
			self.ability:TriggerByName("86", M)
		end
		if self.n_175_chance > 0 and self:PRD(self.n_175_chance, "n_175_chance") then
			self.ability:TriggerByName("175")
		end
		self:customAbilityTrigger()
	end
end
function B.prototype.OnCustomTakeDamage(self, F)
	if IsServer() then
		if F and F.attacker ~= F.target and IsInjurable(F.attacker, F.target) then
			if self.r_99_chance > 0 and self:PRD(self.r_99_chance, "r_99_chance") then
				self.ability:TriggerByName("99", F.attacker)
			end
		end
	end
end
function B.prototype.customAbilityTrigger(self)
	if self:GetParent():IsNeutral() then
		return
	end
	if self:GetParent():GetHeroBase():getCustomAbilityTrigger() ~= "sect_ice" then
		return
	end
	if self.trigger_chance > 0 and self:PRD(self.trigger_chance, "trigger_chance") then
		local N = self:GetParent():GetHeroBase():getCustomAbilityEffectModifier()
		if N ~= nil then
			N:customAbilityEffect()
		end
	end
end
function B.prototype.customAbilityEffect(self)
	self:GetParent():GetHeroBase():addCustomAbilityTriggerCount()
	local O = AddIce
	local P = g(self:GetParent(), self:GetParent():GetEnemy(), self.effect_value)
	local Q = self:GetAbility()
	h(P, Q and Q:GetAbilityName() or "", "Sect")
	O(i(P))
end
B = e(
	{ q(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	B
)
k.modifier_sect_ice = B
k.modifier_sect_ice_146_debuff = c()
local R = k.modifier_sect_ice_146_debuff
R.name = "modifier_sect_ice_146_debuff"
d(R, p)
function R.prototype.GetAbilitySpecialValue(self)
	self.sr_146_duration = self:GetSectSpecialValueFor("146", "sr_146_duration")
	self.sr_146_interval = self:GetSectSpecialValueFor("146", "sr_146_interval")
	self.sr_146_damage = self:GetSectSpecialValueFor("146", "sr_146_damage")
	self.sr_146_count = self:GetSectSpecialValueFor("146", "sr_146_count")
end
function R.prototype.OnCreated(self, F)
	local D = self:GetParent()
	self:StartIntervalThink(self.sr_146_interval)
	if IsServer() then
		D:EmitSound("hero_Crystal.frostbite")
		if not D:HasModifier("modifier_state_immunity_custom") then
			AddStun(self:GetCaster(), D, self:GetAbility(), self.sr_146_duration)
			AddBroken(self:GetCaster(), D, self:GetAbility(), self.sr_146_duration)
		end
	else
		local S = ParticleManager:CreateParticle(
			"particles/econ/items/winter_wyvern/winter_wyvern_ti7/wyvern_cold_embrace_ti7buff.vpcf",
			PATTACH_ABSORIGIN,
			D
		)
		self:AddParticle(S, false, false, -1, false, false)
		local T = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_silencer/silencer_last_word_disarm.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			D
		)
		self:AddParticle(T, false, false, -1, false, true)
	end
end
function R.prototype.OnRemoved(self, U)
	if IsServer() then
		self:GetParent():StopSound("hero_Crystal.frostbite")
	end
end
function R.prototype.OnIntervalThink(self)
	local D = self:GetParent()
	local V = self:GetCaster()
	if IsServer() then
		AddIce(V, D, self.sr_146_count, "146", "AbilityUpgrade")
		V:DealDamage(D, self:GetAbility(), self.sr_146_damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, nil, "146")
	end
end
function R.prototype.CheckState(self)
	return {}
end
R = e(
	{
		q(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				ShouldUseOverheadOffset = true,
			}
		),
	},
	R
)
k.modifier_sect_ice_146_debuff = R
k.modifier_sect_ice_156_debuff = c()
local W = k.modifier_sect_ice_156_debuff
W.name = "modifier_sect_ice_156_debuff"
d(W, p)
function W.prototype.GetAbilitySpecialValue(self)
	self.r_156_ice_permanent = self:GetSectSpecialValueFor("156", "r_156_ice_permanent")
end
function W.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_PERMANENT }
end
function W.prototype.EOM_GetModifierIcePermanent(self)
	return self.r_156_ice_permanent
end
W = e({ q(a, { IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true }) }, W)
k.modifier_sect_ice_156_debuff = W
k.modifier_sect_ice_161 = c()
local X = k.modifier_sect_ice_161
X.name = "modifier_sect_ice_161"
d(X, p)
function X.prototype.OnCreated(self, F)
	if IsServer() then
		local u = self:GetParent()
		u:EmitSound("Hero_Winter_Wyvern.ColdEmbrace")
		CombatLog:recordSectAbilityCast(u, "161")
		self.count = BUFF_VALUE.ColdEmbraceDuration / BUFF_VALUE.ColdEmbraceIceTick
		self:StartIntervalThink(BUFF_VALUE.ColdEmbraceIceTick)
	end
end
function X.prototype.OnIntervalThink(self)
	if IsServer() then
		if self.count <= 0 then
			return
		end
		local u = self:GetParent()
		local t = u:GetEnemy()
		if not IsInjurable(u, t) then
			return
		end
		self.count = self.count - 1
		AddIce(u, t, BUFF_VALUE.ColdEmbraceIceBonus, "161", "AbilityUpgrade")
		local Y = BUFF_VALUE.ColdEmbraceRegenBase + GetIce(t) * BUFF_VALUE.ColdEmbraceRegenPct * 0.01
		Heal(u, Y, "161", "AbilityUpgrade")
	end
end
function X.prototype.OnDestroy(self)
	if IsServer() then
		self:OnIntervalThink()
		self:GetParent():StopSound("Hero_Winter_Wyvern.ColdEmbrace")
	end
end
function X.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_PERMANENT }
end
function X.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_ATTENUATION_PERCENTAGE] = -BUFF_VALUE.ColdEmbraceIceReduce,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE] = -BUFF_VALUE.ColdEmbraceDamageReduce,
	}
end
X = e(
	{
		q(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetStatusEffectName = "particles/status_fx/status_effect_wyvern_cold_embrace.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_NORMAL,
				GetEffectName = "particles/units/heroes/hero_winter_wyvern/wyvern_cold_embrace_buff.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
			}
		),
	},
	X
)
k.modifier_sect_ice_161 = X
return k