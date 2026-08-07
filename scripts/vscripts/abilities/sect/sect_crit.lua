--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/sect/sect_crit"
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
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["18"] = 37,
		["19"] = 38,
		["20"] = 39,
		["21"] = 40,
		["22"] = 41,
		["23"] = 42,
		["24"] = 43,
		["25"] = 44,
		["26"] = 45,
		["27"] = 46,
		["28"] = 47,
		["29"] = 48,
		["30"] = 49,
		["31"] = 50,
		["32"] = 51,
		["33"] = 52,
		["34"] = 54,
		["35"] = 55,
		["36"] = 56,
		["37"] = 57,
		["38"] = 58,
		["39"] = 59,
		["40"] = 61,
		["41"] = 62,
		["42"] = 63,
		["43"] = 64,
		["44"] = 65,
		["45"] = 66,
		["46"] = 67,
		["47"] = 37,
		["48"] = 69,
		["49"] = 70,
		["50"] = 69,
		["51"] = 72,
		["52"] = 72,
		["53"] = 72,
		["55"] = 73,
		["56"] = 74,
		["60"] = 75,
		["61"] = 76,
		["63"] = 77,
		["66"] = 79,
		["68"] = 80,
		["69"] = 80,
		["70"] = 80,
		["71"] = 80,
		["72"] = 80,
		["73"] = 80,
		["74"] = 80,
		["77"] = 82,
		["79"] = 83,
		["80"] = 83,
		["81"] = 83,
		["82"] = 83,
		["83"] = 83,
		["84"] = 83,
		["85"] = 83,
		["88"] = 85,
		["90"] = 86,
		["93"] = 88,
		["95"] = 89,
		["98"] = 91,
		["100"] = 92,
		["101"] = 92,
		["102"] = 92,
		["103"] = 92,
		["104"] = 92,
		["105"] = 92,
		["106"] = 92,
		["109"] = 94,
		["111"] = 95,
		["114"] = 97,
		["117"] = 98,
		["118"] = 99,
		["119"] = 99,
		["120"] = 99,
		["121"] = 99,
		["122"] = 99,
		["123"] = 99,
		["124"] = 99,
		["125"] = 99,
		["126"] = 99,
		["127"] = 100,
		["128"] = 100,
		["129"] = 100,
		["130"] = 100,
		["131"] = 100,
		["132"] = 100,
		["133"] = 101,
		["134"] = 102,
		["135"] = 102,
		["136"] = 102,
		["137"] = 102,
		["138"] = 102,
		["139"] = 102,
		["140"] = 102,
		["141"] = 102,
		["145"] = 105,
		["148"] = 106,
		["149"] = 107,
		["150"] = 107,
		["151"] = 107,
		["152"] = 107,
		["153"] = 107,
		["154"] = 108,
		["155"] = 109,
		["156"] = 110,
		["157"] = 111,
		["158"] = 111,
		["159"] = 111,
		["160"] = 111,
		["161"] = 111,
		["162"] = 111,
		["163"] = 111,
		["164"] = 111,
		["165"] = 112,
		["166"] = 113,
		["167"] = 114,
		["173"] = 72,
		["174"] = 5,
		["175"] = 4,
		["176"] = 5,
		["178"] = 5,
		["179"] = 122,
		["180"] = 130,
		["181"] = 122,
		["182"] = 130,
		["183"] = 165,
		["184"] = 166,
		["185"] = 167,
		["186"] = 168,
		["187"] = 169,
		["188"] = 170,
		["189"] = 171,
		["190"] = 172,
		["191"] = 173,
		["192"] = 174,
		["193"] = 175,
		["194"] = 176,
		["195"] = 177,
		["196"] = 178,
		["197"] = 179,
		["198"] = 180,
		["199"] = 182,
		["200"] = 183,
		["201"] = 184,
		["202"] = 185,
		["203"] = 186,
		["204"] = 187,
		["205"] = 189,
		["206"] = 190,
		["207"] = 191,
		["208"] = 192,
		["209"] = 194,
		["210"] = 195,
		["211"] = 196,
		["212"] = 198,
		["213"] = 199,
		["214"] = 200,
		["215"] = 165,
		["216"] = 202,
		["217"] = 203,
		["218"] = 204,
		["219"] = 205,
		["220"] = 206,
		["223"] = 202,
		["224"] = 210,
		["225"] = 211,
		["226"] = 211,
		["227"] = 211,
		["228"] = 211,
		["229"] = 211,
		["230"] = 210,
		["231"] = 217,
		["232"] = 218,
		["233"] = 217,
		["234"] = 224,
		["235"] = 226,
		["236"] = 224,
		["237"] = 228,
		["238"] = 229,
		["239"] = 228,
		["240"] = 231,
		["241"] = 233,
		["242"] = 233,
		["243"] = 233,
		["244"] = 233,
		["245"] = 231,
		["246"] = 235,
		["247"] = 236,
		["248"] = 237,
		["249"] = 238,
		["252"] = 240,
		["253"] = 241,
		["255"] = 244,
		["256"] = 245,
		["258"] = 248,
		["259"] = 249,
		["261"] = 252,
		["262"] = 253,
		["264"] = 256,
		["265"] = 258,
		["267"] = 261,
		["268"] = 263,
		["270"] = 266,
		["271"] = 268,
		["273"] = 271,
		["274"] = 272,
		["275"] = 272,
		["276"] = 272,
		["277"] = 272,
		["278"] = 272,
		["279"] = 272,
		["281"] = 275,
		["282"] = 276,
		["283"] = 277,
		["284"] = 278,
		["285"] = 278,
		["286"] = 278,
		["287"] = 279,
		["288"] = 280,
		["289"] = 280,
		["290"] = 280,
		["291"] = 280,
		["292"] = 280,
		["293"] = 280,
		["294"] = 280,
		["295"] = 280,
		["296"] = 280,
		["297"] = 281,
		["298"] = 281,
		["299"] = 281,
		["300"] = 281,
		["301"] = 281,
		["302"] = 281,
		["303"] = 281,
		["304"] = 281,
		["305"] = 278,
		["306"] = 278,
		["309"] = 286,
		["310"] = 287,
		["311"] = 288,
		["314"] = 292,
		["315"] = 293,
		["316"] = 294,
		["317"] = 295,
		["318"] = 296,
		["321"] = 300,
		["322"] = 235,
		["323"] = 302,
		["324"] = 303,
		["325"] = 304,
		["326"] = 306,
		["327"] = 307,
		["328"] = 307,
		["329"] = 307,
		["330"] = 307,
		["331"] = 307,
		["332"] = 307,
		["334"] = 310,
		["335"] = 311,
		["336"] = 311,
		["337"] = 311,
		["338"] = 311,
		["339"] = 311,
		["340"] = 311,
		["342"] = 314,
		["343"] = 315,
		["344"] = 315,
		["345"] = 315,
		["346"] = 315,
		["347"] = 315,
		["348"] = 315,
		["349"] = 318,
		["350"] = 320,
		["351"] = 320,
		["352"] = 320,
		["353"] = 320,
		["354"] = 320,
		["355"] = 320,
		["358"] = 302,
		["359"] = 325,
		["360"] = 325,
		["361"] = 342,
		["362"] = 343,
		["365"] = 346,
		["368"] = 349,
		["369"] = 350,
		["370"] = 351,
		["372"] = 351,
		["376"] = 342,
		["377"] = 355,
		["378"] = 356,
		["379"] = 357,
		["380"] = 357,
		["381"] = 357,
		["382"] = 357,
		["383"] = 357,
		["384"] = 357,
		["385"] = 355,
		["386"] = 130,
		["387"] = 122,
		["388"] = 122,
		["389"] = 122,
		["390"] = 122,
		["391"] = 122,
		["392"] = 122,
		["393"] = 122,
		["394"] = 122,
		["395"] = 130,
		["397"] = 130,
		["399"] = 362,
		["400"] = 370,
		["401"] = 362,
		["402"] = 370,
		["403"] = 373,
		["404"] = 374,
		["405"] = 375,
		["406"] = 373,
		["407"] = 377,
		["408"] = 378,
		["409"] = 379,
		["411"] = 377,
		["412"] = 382,
		["413"] = 383,
		["414"] = 384,
		["416"] = 382,
		["417"] = 387,
		["418"] = 388,
		["419"] = 387,
		["420"] = 392,
		["421"] = 393,
		["422"] = 393,
		["423"] = 393,
		["424"] = 393,
		["425"] = 392,
		["426"] = 370,
		["427"] = 362,
		["428"] = 362,
		["429"] = 362,
		["430"] = 362,
		["431"] = 362,
		["432"] = 362,
		["433"] = 362,
		["434"] = 362,
		["435"] = 370,
		["437"] = 370,
		["439"] = 399,
		["440"] = 407,
		["441"] = 399,
		["442"] = 407,
		["443"] = 411,
		["444"] = 412,
		["445"] = 413,
		["446"] = 414,
		["447"] = 411,
		["448"] = 416,
		["449"] = 417,
		["450"] = 418,
		["451"] = 418,
		["452"] = 417,
		["453"] = 416,
		["454"] = 421,
		["455"] = 422,
		["456"] = 423,
		["457"] = 424,
		["458"] = 424,
		["459"] = 424,
		["460"] = 424,
		["461"] = 424,
		["462"] = 424,
		["463"] = 424,
		["464"] = 424,
		["465"] = 424,
		["466"] = 421,
		["467"] = 426,
		["468"] = 427,
		["469"] = 426,
		["470"] = 431,
		["471"] = 432,
		["472"] = 431,
		["473"] = 436,
		["474"] = 437,
		["475"] = 438,
		["477"] = 436,
		["478"] = 407,
		["479"] = 399,
		["480"] = 399,
		["481"] = 399,
		["482"] = 399,
		["483"] = 399,
		["484"] = 399,
		["485"] = 399,
		["486"] = 407,
		["488"] = 407,
		["490"] = 444,
		["491"] = 452,
		["492"] = 444,
		["493"] = 452,
		["494"] = 456,
		["495"] = 457,
		["496"] = 458,
		["497"] = 456,
		["498"] = 460,
		["499"] = 461,
		["500"] = 462,
		["501"] = 463,
		["502"] = 464,
		["503"] = 465,
		["504"] = 465,
		["506"] = 460,
		["507"] = 468,
		["508"] = 469,
		["509"] = 470,
		["510"] = 471,
		["511"] = 471,
		["513"] = 468,
		["514"] = 474,
		["515"] = 475,
		["516"] = 476,
		["517"] = 477,
		["518"] = 478,
		["519"] = 479,
		["522"] = 474,
		["523"] = 483,
		["524"] = 484,
		["525"] = 483,
		["526"] = 488,
		["527"] = 489,
		["528"] = 489,
		["529"] = 489,
		["530"] = 489,
		["531"] = 488,
		["532"] = 452,
		["533"] = 444,
		["534"] = 444,
		["535"] = 444,
		["536"] = 444,
		["537"] = 444,
		["538"] = 444,
		["539"] = 444,
		["540"] = 452,
		["542"] = 452,
		["544"] = 495,
		["545"] = 503,
		["546"] = 495,
		["547"] = 503,
		["548"] = 505,
		["549"] = 506,
		["550"] = 505,
		["551"] = 508,
		["552"] = 509,
		["553"] = 508,
		["554"] = 517,
		["555"] = 518,
		["556"] = 517,
		["557"] = 503,
		["558"] = 495,
		["559"] = 495,
		["560"] = 495,
		["561"] = 495,
		["562"] = 495,
		["563"] = 495,
		["564"] = 495,
		["565"] = 503,
		["567"] = 503,
		["569"] = 523,
		["570"] = 531,
		["571"] = 523,
		["572"] = 531,
		["573"] = 533,
		["574"] = 534,
		["575"] = 533,
		["576"] = 536,
		["577"] = 537,
		["578"] = 536,
		["579"] = 531,
		["580"] = 523,
		["581"] = 523,
		["582"] = 523,
		["583"] = 523,
		["584"] = 523,
		["585"] = 523,
		["586"] = 523,
		["587"] = 531,
		["589"] = 531,
		["591"] = 544,
		["592"] = 551,
		["593"] = 544,
		["594"] = 551,
		["595"] = 553,
		["596"] = 554,
		["597"] = 553,
		["598"] = 556,
		["599"] = 557,
		["600"] = 556,
		["601"] = 551,
		["602"] = 544,
		["603"] = 544,
		["604"] = 544,
		["605"] = 544,
		["606"] = 544,
		["607"] = 544,
		["608"] = 544,
		["609"] = 551,
		["611"] = 551,
		["613"] = 564,
		["614"] = 572,
		["615"] = 564,
		["616"] = 572,
		["617"] = 575,
		["618"] = 577,
		["619"] = 578,
		["620"] = 575,
		["621"] = 580,
		["622"] = 581,
		["623"] = 582,
		["624"] = 582,
		["625"] = 581,
		["626"] = 580,
		["627"] = 585,
		["628"] = 586,
		["629"] = 587,
		["630"] = 588,
		["632"] = 585,
		["633"] = 591,
		["634"] = 592,
		["635"] = 591,
		["636"] = 596,
		["637"] = 597,
		["638"] = 596,
		["639"] = 572,
		["640"] = 564,
		["641"] = 564,
		["642"] = 564,
		["643"] = 564,
		["644"] = 564,
		["645"] = 564,
		["646"] = 564,
		["647"] = 572,
		["649"] = 572,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.sect_crit = c()
local n = g.sect_crit
n.name = "sect_crit"
d(n, i)
function n.prototype.GetAbilitySpecialValue(self)
	self.crit_chance = self:GetSpecialValueFor("crit_chance")
	self.crit_damage = self:GetSpecialValueFor("crit_damage")
	self.n_32_regen = self:GetSectSpecialValueFor("32", "n_32_regen")
	self.n_33_crit = self:GetSectSpecialValueFor("33", "n_33_crit")
	self.n_34_poison = self:GetSectSpecialValueFor("34", "n_34_poison")
	self.n_35_ice = self:GetSectSpecialValueFor("35", "n_35_ice")
	self.n_36_mana = self:GetSectSpecialValueFor("36", "n_36_mana")
	self.n_37_shield = self:GetSectSpecialValueFor("37", "n_37_shield")
	self.n_38_injury = self:GetSectSpecialValueFor("38", "n_38_injury")
	self.n_39_health = self:GetSectSpecialValueFor("39", "n_39_health")
	self.n_40_duration = self:GetSectSpecialValueFor("40", "n_40_duration")
	self.n_41_crit = self:GetSectSpecialValueFor("41", "n_41_crit")
	self.r_42_crit = self:GetSectSpecialValueFor("42", "r_42_crit")
	self.sr_43_damage = self:GetSectSpecialValueFor("43", "sr_43_damage")
	self.sr_43_chance = self:GetSectSpecialValueFor("43", "sr_43_chance")
	self.r_44_duration = self:GetSectSpecialValueFor("44", "r_44_duration")
	self.sr_45_chance = self:GetSectSpecialValueFor("45", "sr_45_chance")
	self.sr_45_damage = self:GetSectSpecialValueFor("45", "sr_45_damage")
	self.sr_45_count = self:GetSectSpecialValueFor("45", "sr_45_count")
	self.n_124_fury = self:GetSectSpecialValueFor("124", "n_124_fury")
	self.sr_141_damage = self:GetSectSpecialValueFor("141", "sr_141_damage")
	self.sr_141_chance = self:GetSectSpecialValueFor("141", "sr_141_chance")
	self.sr_183_duration = self:GetSectSpecialValueFor("183", "sr_183_duration")
	self.sr_183_base = self:GetSectSpecialValueFor("183", "sr_183_base")
	self.sr_183_effect_1 = self:GetSectSpecialValueFor("183", "crit_bonus")
	self.sr_188_stun = self:GetSectSpecialValueFor("188", "sr_188_stun")
	self.sr_188_damage = self:GetSectSpecialValueFor("188", "sr_188_damage")
	self.sr_188_cd = self:GetSectSpecialValueFor("188", "sr_188_cd")
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_sect_crit"
end
function n.prototype.TriggerByName(self, o, p)
	if p == nil then
		p = self:GetCaster():GetEnemy()
	end
	local q = self:GetCaster()
	if not IsInjurable(p, q) then
		return
	end
	repeat
		local r = o
		local s = r == "32"
		if s then
			Heal(q, self.n_32_regen, "32", "AbilityUpgrade")
			break
		end
		s = s or r == "34"
		if s then
			AddPoison(q, p, self.n_34_poison, "34", "AbilityUpgrade")
			break
		end
		s = s or r == "35"
		if s then
			AddIce(q, p, self.n_35_ice, "35", "AbilityUpgrade")
			break
		end
		s = s or r == "36"
		if s then
			Restore(q, self.n_36_mana)
			break
		end
		s = s or r == "37"
		if s then
			AddShield(q, self.n_37_shield, "37", "AbilityUpgrade")
			break
		end
		s = s or r == "38"
		if s then
			AddInjury(q, p, self.n_38_injury, "38", "AbilityUpgrade")
			break
		end
		s = s or r == "124"
		if s then
			AddFury(q, self.n_124_fury, "124", "AbilityUpgrade")
			break
		end
		s = s or r == "141"
		if s then
			do
				local t = ParticleManager:CreateParticle(
					"particles/econ/items/spirit_breaker/spirit_breaker_weapon_ti8/spirit_breaker_bash_ti8.vpcf",
					PATTACH_CUSTOMORIGIN,
					p
				)
				ParticleManager:SetParticleControlEnt(t, 0, p, PATTACH_POINT, "attach_hitloc", p:GetAbsOrigin(), false)
				ParticleManager:SetParticleControlTransformForward(t, 1, p:GetAbsOrigin(), -p:GetForwardVector())
				q:EmitSound("Hero_Spirit_Breaker.GreaterBash")
				q:DealDamage(
					p,
					self,
					self.sr_141_damage,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
					DamageFlags.DAMAGE_FLAG_REFLECTION
						+ DamageFlags.DAMAGE_FLAG_HPLOSS
						+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING,
					"141"
				)
				break
			end
		end
		s = s or r == "188"
		if s then
			do
				local u = ParticleManager:CreateParticle(
					"particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_crit_tgt.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					q
				)
				ParticleManager:SetParticleControl(u, 1, q:GetAbsOrigin())
				ParticleManager:ReleaseParticleIndex(u)
				q:EmitSound("Hero_Juggernaut.BladeDance")
				local v = p:GetHealth() * self.sr_188_damage * 0.01
				q:DealDamage(
					p,
					self,
					v,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
					DamageFlags.DAMAGE_FLAG_REFLECTION
						+ DamageFlags.DAMAGE_FLAG_HPLOSS
						+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING,
					"188"
				)
				if self.sr_188_stun > 0 then
					AddStun(q, p, self, self.sr_188_stun)
					p:AddNewModifier(q, self, "modifier_sect_crit_188_debuff", { duration = self.sr_188_stun })
				end
				break
			end
		end
	until true
end
n = e({ j(nil) }, n)
g.sect_crit = n
g.modifier_sect_crit = c()
local w = g.modifier_sect_crit
w.name = "modifier_sect_crit"
d(w, l)
function w.prototype.GetAbilitySpecialValue(self)
	self.crit_chance = self:GetAbilitySpecialValueFor("crit_chance")
	self.crit_damage = self:GetAbilitySpecialValueFor("crit_damage")
	self.n_32_regen = self:GetSectSpecialValueFor("32", "n_32_regen")
	self.n_33_crit = self:GetSectSpecialValueFor("33", "n_33_crit")
	self.n_34_poison = self:GetSectSpecialValueFor("34", "n_34_poison")
	self.n_35_ice = self:GetSectSpecialValueFor("35", "n_35_ice")
	self.n_36_mana = self:GetSectSpecialValueFor("36", "n_36_mana")
	self.n_37_shield = self:GetSectSpecialValueFor("37", "n_37_shield")
	self.n_38_injury = self:GetSectSpecialValueFor("38", "n_38_injury")
	self.n_39_health = self:GetSectSpecialValueFor("39", "n_39_health")
	self.n_40_duration = self:GetSectSpecialValueFor("40", "n_40_duration")
	self.n_41_crit = self:GetSectSpecialValueFor("41", "n_41_crit")
	self.r_42_crit = self:GetSectSpecialValueFor("42", "r_42_crit")
	self.sr_43_damage = self:GetSectSpecialValueFor("43", "sr_43_damage")
	self.sr_43_chance = self:GetSectSpecialValueFor("43", "sr_43_chance")
	self.r_44_duration = self:GetSectSpecialValueFor("44", "r_44_duration")
	self.sr_45_chance = self:GetSectSpecialValueFor("45", "sr_45_chance")
	self.sr_45_damage = self:GetSectSpecialValueFor("45", "sr_45_damage")
	self.sr_45_count = self:GetSectSpecialValueFor("45", "sr_45_count")
	self.n_124_fury = self:GetSectSpecialValueFor("124", "n_124_fury")
	self.sr_141_damage = self:GetSectSpecialValueFor("141", "sr_141_damage")
	self.sr_141_chance = self:GetSectSpecialValueFor("141", "sr_141_chance")
	self.sr_183_duration = self:GetSectSpecialValueFor("183", "sr_183_duration")
	self.sr_183_base = self:GetSectSpecialValueFor("183", "sr_183_base")
	self.sr_183_effect_1 = self:GetSectSpecialValueFor("183", "crit_bonus")
	self.sr_188_stun = self:GetSectSpecialValueFor("188", "sr_188_stun")
	self.sr_188_damage = self:GetSectSpecialValueFor("188", "sr_188_damage")
	self.sr_188_cd = self:GetSectSpecialValueFor("188", "sr_188_cd")
	self.trigger_chance = self:GetCustomAbilityValueFor("sect_crit_trigger", "chance")
	self.effect_duration = self:GetCustomAbilityValueFor("sect_crit_effect", "duration")
	self.ability:GetAbilitySpecialValue()
end
function w.prototype.OnThink(self, x)
	if IsServer() then
		if x == "sr_188_cd" then
			self.sr_188_flag = false
			self:StartThink(-1, x)
		end
	end
end
function w.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
	}
end
function w.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BASE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_MAGICAL_CRITICALSTRIKE_CHANCE,
	}
end
function w.prototype.EOM_GetModifierPhysicalCriticalStrikeChance(self)
	return (self.crit_chance or 0) + self.n_33_crit + self.sr_183_base
end
function w.prototype.EOM_GetModifierPhysicalCriticalStrikeDamage(self)
	return self.crit_damage
end
function w.prototype.EOM_GetModifierMagicalCriticalStrikeChance(self, y)
	return GetPhysicalCriticalChance(self:GetParent(), y) * self.r_42_crit * 0.01
end
function w.prototype.OnCritical(self, y)
	local z = self:GetParent()
	local A = y.target
	if not IsInjurable(z, A) then
		return
	end
	if self.n_32_regen > 0 then
		self.ability:TriggerByName("32")
	end
	if self.n_34_poison > 0 then
		self.ability:TriggerByName("34", A)
	end
	if self.n_35_ice > 0 then
		self.ability:TriggerByName("35", A)
	end
	if self.n_124_fury > 0 then
		self.ability:TriggerByName("124")
	end
	if self.n_36_mana > 0 then
		self.ability:TriggerByName("36")
	end
	if self.n_37_shield > 0 then
		self.ability:TriggerByName("37")
	end
	if self.n_38_injury > 0 then
		self.ability:TriggerByName("38", A)
	end
	if self.r_44_duration > 0 then
		z:AddNewModifier(z, self:GetAbility(), "modifier_sect_crit_44_buff", { duration = self.r_44_duration })
	end
	if self.sr_43_chance > 0 and self:PRD(self.sr_43_chance, "sr_43_chance") then
		if bit.band(y.damage_flags, DamageFlags.DAMAGE_FLAG_REFLECTION) ~= DamageFlags.DAMAGE_FLAG_REFLECTION then
			local B = y.damage * self.sr_43_damage * 0.01
			z:GameTimer(0.2, function()
				local C = ParticleManager:CreateParticle("particles/sect/sect_crit_43.vpcf", PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControlEnt(
					C,
					0,
					A,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					A:GetAbsOrigin(),
					false
				)
				z:DealDamage(
					A,
					self:GetAbility(),
					B,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
					DamageFlags.DAMAGE_FLAG_REFLECTION
						+ DamageFlags.DAMAGE_FLAG_HPLOSS
						+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING,
					"43"
				)
			end)
		end
	end
	if self.sr_141_damage > 0 then
		if bit.band(y.damage_flags, DamageFlags.DAMAGE_FLAG_REFLECTION) ~= DamageFlags.DAMAGE_FLAG_REFLECTION then
			self.ability:TriggerByName("141", A)
		end
	end
	if self.sr_188_damage > 0 and not self.sr_188_flag then
		if bit.band(y.damage_flags, DamageFlags.DAMAGE_FLAG_REFLECTION) ~= DamageFlags.DAMAGE_FLAG_REFLECTION then
			self.sr_188_flag = true
			self:StartThink(self.sr_188_cd, "sr_188_cd")
			self.ability:TriggerByName("188", A)
		end
	end
	self:customAbilityTrigger()
end
function w.prototype.OnBattleStartBefore(self, y)
	local D = self:GetParent()
	local E = D:GetEnemy()
	if self.sr_45_chance > 0 then
		D:AddNewModifier(D, self:GetAbility(), "modifier_sect_crit_45_buff", nil)
	end
	if IsInjurable(E) then
		E:AddNewModifier(D, self:GetAbility(), "modifier_sect_crit_40_debuff", nil)
	end
	if self.sr_183_duration > 0 then
		D:AddNewModifier(D, self:GetAbility(), "modifier_sect_crit_183_buff", { duration = self.sr_183_duration })
		if self.sr_183_effect_1 > 0 then
			D:AddNewModifier(D, self:GetAbility(), "modifier_sect_crit_183_trait", nil)
		end
	end
end
function w.prototype.OnBattleStart(self, y) end
function w.prototype.customAbilityTrigger(self)
	if self:GetParent():IsNeutral() then
		return
	end
	if self:GetParent():GetHeroBase():getCustomAbilityTrigger() ~= "sect_crit" then
		return
	end
	if self.trigger_chance > 0 then
		if self.trigger_chance > 0 and self:PRD(self.trigger_chance, "trigger_chance") then
			local F = self:GetParent():GetHeroBase():getCustomAbilityEffectModifier()
			if F ~= nil then
				F:customAbilityEffect()
			end
		end
	end
end
function w.prototype.customAbilityEffect(self)
	self:GetParent():GetHeroBase():addCustomAbilityTriggerCount()
	self:GetParent():AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_sect_crit_effect_buff",
		{ duration = self.effect_duration }
	)
end
w = e(
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
	w
)
g.modifier_sect_crit = w
g.modifier_sect_crit_44_buff = c()
local G = g.modifier_sect_crit_44_buff
G.name = "modifier_sect_crit_44_buff"
d(G, l)
function G.prototype.GetAbilitySpecialValue(self)
	self.r_44_crit = self:GetSectSpecialValueFor("44", "r_44_crit")
	self.r_44_max_crit = self:GetSectSpecialValueFor("44", "r_44_max_crit")
end
function G.prototype.OnCreated(self, y)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function G.prototype.OnRefresh(self, y)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function G.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS }
end
function G.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self)
	return math.min(self.r_44_max_crit, self:GetStackCount() * self.r_44_crit)
end
G = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				IsIndependent = true,
			}
		),
	},
	G
)
g.modifier_sect_crit_44_buff = G
g.modifier_sect_crit_45_buff = c()
local H = g.modifier_sect_crit_45_buff
H.name = "modifier_sect_crit_45_buff"
d(H, l)
function H.prototype.GetAbilitySpecialValue(self)
	self.sr_45_chance = self:GetSectSpecialValueFor("45", "sr_45_chance")
	self.sr_45_damage = self:GetSectSpecialValueFor("45", "sr_45_damage")
	self.sr_45_count = self:GetSectSpecialValueFor("45", "sr_45_count")
end
function H.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent(), -1 } }
end
function H.prototype.OnCritical(self, y)
	self:IncrementStackCount()
	local C = ParticleManager:CreateParticle("particles/sect/sect_crit_45.vpcf", PATTACH_ABSORIGIN, y.target)
	ParticleManager:SetParticleControlEnt(C, 1, y.target, PATTACH_ABSORIGIN, "", y.target:GetAbsOrigin(), false)
end
function H.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE] = self.sr_45_damage }
end
function H.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS }
end
function H.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self)
	if self:GetStackCount() < self.sr_45_count then
		return self.sr_45_chance
	end
end
H = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	H
)
g.modifier_sect_crit_45_buff = H
g.modifier_sect_crit_effect_buff = c()
local I = g.modifier_sect_crit_effect_buff
I.name = "modifier_sect_crit_effect_buff"
d(I, l)
function I.prototype.GetAbilitySpecialValue(self)
	self.effect_value = self:GetCustomAbilityValueFor("sect_crit_effect", "value")
	self.effect_max_value = self:GetCustomAbilityValueFor("sect_crit_effect", "max_value")
end
function I.prototype.OnCreated(self, y)
	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink(0)
		self.tData = {}
		local J = self.tData
		J[#J + 1] = self:GetDieTime()
	end
end
function I.prototype.OnRefresh(self, K)
	if IsServer() then
		self:IncrementStackCount()
		local L = self.tData
		L[#L + 1] = self:GetDieTime()
	end
end
function I.prototype.OnIntervalThink(self)
	local M = GameRules:GetGameTime()
	for N = #self.tData, 1, -1 do
		if self.tData[N] <= M then
			self:DecrementStackCount()
			table.remove(self.tData, N)
		end
	end
end
function I.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE }
end
function I.prototype.EOM_GetModifierPhysicalCriticalStrikeDamage(self)
	return math.min(self.effect_max_value, self.effect_value * self:GetStackCount())
end
I = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	I
)
g.modifier_sect_crit_effect_buff = I
g.modifier_sect_crit_40_debuff = c()
local O = g.modifier_sect_crit_40_debuff
O.name = "modifier_sect_crit_40_debuff"
d(O, l)
function O.prototype.GetAbilitySpecialValue(self)
	self.n_40_max_crit = self:GetSectSpecialValueFor("40", "n_40_max_crit")
end
function O.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CRITICAL_MISS_CHANCE }
end
function O.prototype.EOM_GetModifierCriticalMissChance(self, y)
	return self.n_40_max_crit
end
O = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	O
)
g.modifier_sect_crit_40_debuff = O
g.modifier_sect_crit_183_buff = c()
local P = g.modifier_sect_crit_183_buff
P.name = "modifier_sect_crit_183_buff"
d(P, l)
function P.prototype.GetAbilitySpecialValue(self)
	self.sr_183_count = self:GetSectSpecialValueFor("183", "sr_183_count")
end
function P.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS] = self.sr_183_count }
end
P = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	P
)
g.modifier_sect_crit_183_buff = P
g.modifier_sect_crit_188_debuff = c()
local Q = g.modifier_sect_crit_188_debuff
Q.name = "modifier_sect_crit_188_debuff"
d(Q, l)
function Q.prototype.GetAbilitySpecialValue(self)
	self.sr_188_evade_reduce = self:GetSectSpecialValueFor("188", "sr_188_evade_reduce")
end
function Q.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVADE_DAMAGE_REDUCE_BONUS_PERCENT] = -self.sr_188_evade_reduce }
end
Q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	Q
)
g.modifier_sect_crit_188_debuff = Q
g.modifier_sect_crit_183_trait = c()
local R = g.modifier_sect_crit_183_trait
R.name = "modifier_sect_crit_183_trait"
d(R, l)
function R.prototype.GetAbilitySpecialValue(self)
	self.crit_bonus = self:GetSectSpecialValueFor("183", "crit_bonus")
	self.max_stack = self:GetSectSpecialValueFor("183", "max_stack")
end
function R.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent(), -1 } }
end
function R.prototype.OnCritical(self, y)
	local S = self:GetStackCount()
	if S < self.max_stack then
		self:SetStackCount(math.min(self.max_stack, S + 1))
	end
end
function R.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS }
end
function R.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, y)
	return self.crit_bonus * self:GetStackCount()
end
R = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	R
)
g.modifier_sect_crit_183_trait = R
return g