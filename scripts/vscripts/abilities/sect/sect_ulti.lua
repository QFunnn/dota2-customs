--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/sect/sect_ulti"
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
		["18"] = 31,
		["19"] = 32,
		["20"] = 33,
		["21"] = 34,
		["22"] = 35,
		["23"] = 38,
		["24"] = 39,
		["25"] = 40,
		["26"] = 41,
		["27"] = 42,
		["28"] = 43,
		["29"] = 44,
		["30"] = 45,
		["31"] = 46,
		["32"] = 48,
		["33"] = 50,
		["34"] = 51,
		["35"] = 52,
		["36"] = 53,
		["37"] = 54,
		["38"] = 55,
		["39"] = 56,
		["40"] = 57,
		["41"] = 31,
		["42"] = 59,
		["43"] = 59,
		["44"] = 59,
		["46"] = 60,
		["47"] = 61,
		["51"] = 62,
		["52"] = 63,
		["55"] = 64,
		["59"] = 67,
		["62"] = 68,
		["66"] = 71,
		["69"] = 72,
		["70"] = 72,
		["71"] = 72,
		["72"] = 72,
		["73"] = 72,
		["74"] = 72,
		["78"] = 75,
		["81"] = 76,
		["82"] = 77,
		["83"] = 78,
		["87"] = 81,
		["90"] = 82,
		["94"] = 85,
		["97"] = 86,
		["98"] = 86,
		["99"] = 86,
		["100"] = 86,
		["101"] = 86,
		["102"] = 86,
		["103"] = 86,
		["107"] = 89,
		["110"] = 90,
		["111"] = 90,
		["112"] = 90,
		["113"] = 90,
		["114"] = 90,
		["115"] = 90,
		["116"] = 90,
		["120"] = 93,
		["123"] = 94,
		["124"] = 94,
		["125"] = 94,
		["126"] = 94,
		["127"] = 94,
		["128"] = 94,
		["129"] = 94,
		["133"] = 97,
		["136"] = 98,
		["140"] = 101,
		["144"] = 103,
		["145"] = 104,
		["146"] = 104,
		["147"] = 104,
		["148"] = 104,
		["149"] = 104,
		["150"] = 104,
		["151"] = 104,
		["152"] = 104,
		["153"] = 104,
		["154"] = 105,
		["155"] = 105,
		["156"] = 105,
		["157"] = 105,
		["158"] = 105,
		["159"] = 105,
		["160"] = 105,
		["161"] = 105,
		["162"] = 105,
		["163"] = 106,
		["164"] = 106,
		["165"] = 106,
		["166"] = 106,
		["167"] = 106,
		["168"] = 106,
		["169"] = 106,
		["170"] = 106,
		["171"] = 106,
		["172"] = 106,
		["173"] = 106,
		["174"] = 106,
		["175"] = 106,
		["176"] = 106,
		["177"] = 106,
		["178"] = 107,
		["179"] = 108,
		["180"] = 108,
		["181"] = 108,
		["182"] = 109,
		["183"] = 110,
		["184"] = 111,
		["186"] = 113,
		["187"] = 113,
		["188"] = 113,
		["189"] = 113,
		["190"] = 113,
		["191"] = 113,
		["192"] = 113,
		["193"] = 113,
		["195"] = 108,
		["196"] = 108,
		["201"] = 119,
		["204"] = 120,
		["205"] = 121,
		["206"] = 122,
		["207"] = 123,
		["213"] = 59,
		["214"] = 129,
		["215"] = 130,
		["216"] = 129,
		["217"] = 5,
		["218"] = 4,
		["219"] = 5,
		["221"] = 5,
		["222"] = 134,
		["223"] = 142,
		["224"] = 134,
		["225"] = 142,
		["226"] = 177,
		["227"] = 178,
		["228"] = 179,
		["229"] = 180,
		["230"] = 181,
		["231"] = 184,
		["232"] = 185,
		["233"] = 186,
		["234"] = 187,
		["235"] = 188,
		["236"] = 189,
		["237"] = 190,
		["238"] = 191,
		["239"] = 192,
		["240"] = 194,
		["241"] = 196,
		["242"] = 197,
		["243"] = 198,
		["244"] = 199,
		["245"] = 200,
		["246"] = 201,
		["247"] = 202,
		["248"] = 203,
		["249"] = 204,
		["250"] = 205,
		["251"] = 206,
		["252"] = 207,
		["253"] = 177,
		["254"] = 215,
		["255"] = 216,
		["256"] = 217,
		["257"] = 217,
		["258"] = 217,
		["259"] = 216,
		["260"] = 218,
		["261"] = 218,
		["262"] = 218,
		["263"] = 216,
		["264"] = 216,
		["265"] = 216,
		["266"] = 221,
		["267"] = 221,
		["268"] = 221,
		["269"] = 216,
		["270"] = 222,
		["271"] = 222,
		["272"] = 222,
		["273"] = 216,
		["274"] = 216,
		["275"] = 215,
		["276"] = 225,
		["277"] = 226,
		["278"] = 225,
		["279"] = 231,
		["280"] = 232,
		["281"] = 231,
		["282"] = 234,
		["283"] = 235,
		["284"] = 236,
		["285"] = 237,
		["286"] = 238,
		["287"] = 239,
		["290"] = 242,
		["291"] = 234,
		["292"] = 244,
		["293"] = 245,
		["296"] = 246,
		["297"] = 247,
		["298"] = 248,
		["299"] = 249,
		["300"] = 250,
		["301"] = 251,
		["302"] = 252,
		["303"] = 253,
		["304"] = 254,
		["306"] = 257,
		["309"] = 244,
		["310"] = 263,
		["311"] = 264,
		["312"] = 265,
		["313"] = 266,
		["314"] = 268,
		["315"] = 269,
		["316"] = 269,
		["317"] = 269,
		["318"] = 269,
		["319"] = 269,
		["320"] = 269,
		["322"] = 272,
		["323"] = 273,
		["325"] = 276,
		["326"] = 277,
		["328"] = 280,
		["329"] = 281,
		["331"] = 284,
		["332"] = 285,
		["334"] = 288,
		["335"] = 289,
		["337"] = 291,
		["338"] = 293,
		["339"] = 294,
		["341"] = 297,
		["342"] = 298,
		["344"] = 301,
		["345"] = 302,
		["347"] = 305,
		["348"] = 306,
		["350"] = 309,
		["351"] = 310,
		["355"] = 263,
		["356"] = 315,
		["357"] = 316,
		["358"] = 317,
		["359"] = 318,
		["360"] = 320,
		["362"] = 315,
		["363"] = 323,
		["364"] = 324,
		["365"] = 325,
		["366"] = 327,
		["367"] = 328,
		["368"] = 328,
		["369"] = 328,
		["370"] = 328,
		["371"] = 328,
		["372"] = 328,
		["374"] = 330,
		["375"] = 323,
		["376"] = 332,
		["377"] = 333,
		["378"] = 334,
		["379"] = 341,
		["380"] = 342,
		["381"] = 342,
		["382"] = 342,
		["383"] = 342,
		["384"] = 342,
		["385"] = 342,
		["387"] = 346,
		["388"] = 347,
		["389"] = 347,
		["390"] = 347,
		["391"] = 347,
		["392"] = 347,
		["393"] = 347,
		["396"] = 332,
		["397"] = 351,
		["398"] = 352,
		["399"] = 353,
		["401"] = 351,
		["402"] = 357,
		["403"] = 358,
		["406"] = 361,
		["409"] = 365,
		["410"] = 366,
		["412"] = 366,
		["415"] = 357,
		["416"] = 370,
		["417"] = 371,
		["418"] = 372,
		["419"] = 372,
		["420"] = 372,
		["421"] = 372,
		["422"] = 370,
		["423"] = 142,
		["424"] = 134,
		["425"] = 134,
		["426"] = 134,
		["427"] = 134,
		["428"] = 134,
		["429"] = 134,
		["430"] = 134,
		["431"] = 134,
		["432"] = 142,
		["434"] = 142,
		["436"] = 377,
		["437"] = 385,
		["438"] = 377,
		["439"] = 385,
		["440"] = 389,
		["441"] = 390,
		["442"] = 391,
		["443"] = 389,
		["444"] = 393,
		["445"] = 394,
		["446"] = 393,
		["447"] = 385,
		["448"] = 377,
		["449"] = 377,
		["450"] = 377,
		["451"] = 377,
		["452"] = 377,
		["453"] = 377,
		["454"] = 377,
		["455"] = 385,
		["457"] = 385,
		["459"] = 402,
		["460"] = 410,
		["461"] = 402,
		["462"] = 410,
		["463"] = 411,
		["464"] = 412,
		["465"] = 413,
		["467"] = 411,
		["468"] = 416,
		["469"] = 418,
		["470"] = 419,
		["471"] = 420,
		["472"] = 421,
		["473"] = 422,
		["474"] = 423,
		["475"] = 425,
		["477"] = 416,
		["478"] = 410,
		["479"] = 402,
		["480"] = 402,
		["481"] = 402,
		["482"] = 402,
		["483"] = 402,
		["484"] = 402,
		["485"] = 402,
		["486"] = 410,
		["488"] = 410,
		["490"] = 431,
		["491"] = 439,
		["492"] = 431,
		["493"] = 439,
		["494"] = 442,
		["495"] = 443,
		["496"] = 444,
		["497"] = 442,
		["498"] = 446,
		["499"] = 447,
		["500"] = 448,
		["501"] = 449,
		["502"] = 450,
		["503"] = 451,
		["505"] = 453,
		["506"] = 454,
		["507"] = 454,
		["508"] = 454,
		["509"] = 454,
		["510"] = 454,
		["511"] = 455,
		["512"] = 455,
		["513"] = 455,
		["514"] = 455,
		["515"] = 455,
		["516"] = 456,
		["517"] = 456,
		["518"] = 456,
		["519"] = 456,
		["520"] = 456,
		["521"] = 457,
		["522"] = 457,
		["523"] = 457,
		["524"] = 457,
		["525"] = 457,
		["526"] = 457,
		["527"] = 457,
		["528"] = 457,
		["530"] = 446,
		["531"] = 460,
		["532"] = 461,
		["533"] = 462,
		["534"] = 462,
		["535"] = 461,
		["536"] = 460,
		["537"] = 465,
		["538"] = 466,
		["539"] = 465,
		["540"] = 468,
		["541"] = 469,
		["542"] = 470,
		["543"] = 471,
		["544"] = 472,
		["545"] = 473,
		["546"] = 473,
		["547"] = 473,
		["548"] = 473,
		["549"] = 473,
		["550"] = 473,
		["551"] = 473,
		["552"] = 473,
		["554"] = 468,
		["555"] = 476,
		["556"] = 477,
		["557"] = 476,
		["558"] = 481,
		["559"] = 482,
		["560"] = 481,
		["561"] = 439,
		["562"] = 431,
		["563"] = 431,
		["564"] = 431,
		["565"] = 431,
		["566"] = 431,
		["567"] = 431,
		["568"] = 431,
		["569"] = 439,
		["571"] = 439,
		["572"] = 485,
		["573"] = 492,
		["574"] = 485,
		["575"] = 492,
		["576"] = 494,
		["577"] = 495,
		["578"] = 494,
		["579"] = 497,
		["580"] = 498,
		["581"] = 499,
		["583"] = 497,
		["584"] = 502,
		["585"] = 503,
		["586"] = 504,
		["588"] = 502,
		["589"] = 507,
		["590"] = 508,
		["591"] = 507,
		["592"] = 512,
		["593"] = 513,
		["594"] = 512,
		["595"] = 492,
		["596"] = 485,
		["597"] = 485,
		["598"] = 485,
		["599"] = 485,
		["600"] = 485,
		["601"] = 485,
		["602"] = 485,
		["603"] = 492,
		["605"] = 492,
		["606"] = 517,
		["607"] = 528,
		["608"] = 517,
		["609"] = 528,
		["610"] = 529,
		["611"] = 530,
		["612"] = 531,
		["613"] = 532,
		["615"] = 534,
		["617"] = 529,
		["618"] = 537,
		["619"] = 538,
		["620"] = 537,
		["621"] = 528,
		["622"] = 517,
		["623"] = 517,
		["624"] = 517,
		["625"] = 517,
		["626"] = 517,
		["627"] = 517,
		["628"] = 517,
		["629"] = 517,
		["630"] = 517,
		["631"] = 517,
		["632"] = 517,
		["633"] = 528,
		["635"] = 528,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.sect_ulti = c()
local n = g.sect_ulti
n.name = "sect_ulti"
d(n, i)
function n.prototype.GetAbilitySpecialValue(self)
	self.mana_regen = self:GetSpecialValueFor("mana_regen")
	self.damage_pct = self:GetSpecialValueFor("damage_pct")
	self.n_3_attackdamage = self:GetSectSpecialValueFor("3", "n_3_attackdamage")
	self.n_65_regen = self:GetSectSpecialValueFor("65", "n_65_regen")
	self.n_71_ulti_power = self:GetSectSpecialValueFor("71", "n_71_ulti_power")
	self.n_72_shield = self:GetSectSpecialValueFor("72", "n_72_shield")
	self.n_73_poison = self:GetSectSpecialValueFor("73", "n_73_poison")
	self.n_74_ice = self:GetSectSpecialValueFor("74", "n_74_ice")
	self.n_75_injury = self:GetSectSpecialValueFor("75", "n_75_injury")
	self.n_76_mana_reduce_pct = self:GetSectSpecialValueFor("76", "n_76_mana_reduce_pct")
	self.r_78_mana_pct = self:GetSectSpecialValueFor("78", "r_78_mana_pct")
	self.r_79_chance = self:GetSectSpecialValueFor("79", "r_79_chance")
	self.r_79_duration = self:GetSectSpecialValueFor("79", "r_79_duration")
	self.r_80_damage = self:GetSectSpecialValueFor("80", "r_80_damage")
	self.r_80_effect_1 = self:GetSectSpecialValueFor("80", "effect_1")
	self.r_154_mana = self:GetSectSpecialValueFor("154", "r_154_mana")
	self.r_154_power = self:GetSectSpecialValueFor("154", "r_154_power")
	self.n_127_fury = self:GetSectSpecialValueFor("127", "n_127_fury")
	self.n_170_chaos_count = self:GetSectSpecialValueFor("170", "n_170_chaos_count")
	self.sr_144_damage = self:GetSectSpecialValueFor("144", "sr_144_damage")
	self.sr_190_duration = self:GetSectSpecialValueFor("190", "sr_190_duration")
	self.sr_190_threshold = self:GetSectSpecialValueFor("190", "sr_190_threshold")
end
function n.prototype.TriggerByName(self, o, p)
	if p == nil then
		p = self:GetCaster():GetEnemy()
	end
	local q = self:GetCaster()
	if not IsInjurable(q, p) then
		return
	end
	repeat
		local r = o
		local s = r == "72"
		if s then
			do
				AddShield(q, self.n_72_shield, "72", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "127"
		if s then
			do
				AddFury(q, self.n_127_fury, "127", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "170"
		if s then
			do
				AddChaos(q, GetSectChaosModifiedValue(q, self.n_170_chaos_count), "170", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "78"
		if s then
			do
				local t = q:GetMaxMana() * self.r_78_mana_pct * 0.01
				Restore(q, t)
				ParticleManager:CreateParticle(
					"particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_essence_effect.vpcf",
					PATTACH_ABSORIGIN,
					q
				)
				break
			end
		end
		s = s or r == "65"
		if s then
			do
				Heal(q, self.n_65_regen, "65", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "73"
		if s then
			do
				AddPoison(q, p, self.n_73_poison, "73", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "74"
		if s then
			do
				AddIce(q, p, self.n_74_ice, "74", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "75"
		if s then
			do
				AddInjury(q, p, self.n_75_injury, "75", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "79"
		if s then
			do
				AddStun(q, p, self, self.r_79_duration)
				break
			end
		end
		s = s or r == "80"
		if s then
			do
				do
					local u =
						ParticleManager:CreateParticle("particles/items_fx/dagon.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, q)
					ParticleManager:SetParticleControlEnt(
						u,
						0,
						q,
						PATTACH_POINT_FOLLOW,
						"attach_attack1",
						vec3_zero,
						true
					)
					ParticleManager:SetParticleControlEnt(
						u,
						1,
						p,
						PATTACH_POINT_FOLLOW,
						"attach_hitloc",
						vec3_zero,
						true
					)
					ParticleManager:SetParticleControl(
						u,
						2,
						Vector(Script_RemapValClamped(self.r_80_damage, 400, 1600, 400, 800), 0, 0)
					)
					EmitSoundOn("DOTA_Item.Dagon.Activate", p)
					GameTimer(0.25, function()
						if IsValid(self) and IsValid(p) then
							if self.r_80_effect_1 > 0 then
								AddStun(q, p, self, self.r_80_effect_1)
							end
							q:DealDamage(p, self, self.r_80_damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, nil, "80")
						end
					end)
				end
				break
			end
		end
		s = s or r == "144"
		if s then
			do
				local v = q:FindModifierByName("modifier_sect_ulti_144_buff")
				if IsValid(v) then
					v:IncrementStackCount()
					v:OnIntervalThink()
				end
				break
			end
		end
	until true
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_sect_ulti"
end
n = e({ j(nil) }, n)
g.sect_ulti = n
g.modifier_sect_ulti = c()
local w = g.modifier_sect_ulti
w.name = "modifier_sect_ulti"
d(w, l)
function w.prototype.GetAbilitySpecialValue(self)
	self.mana_regen = self:GetAbilitySpecialValueFor("mana_regen")
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
	self.n_3_attackdamage = self:GetSectSpecialValueFor("3", "n_3_attackdamage")
	self.n_65_regen = self:GetSectSpecialValueFor("65", "n_65_regen")
	self.n_71_ulti_power = self:GetSectSpecialValueFor("71", "n_71_ulti_power")
	self.n_72_shield = self:GetSectSpecialValueFor("72", "n_72_shield")
	self.n_73_poison = self:GetSectSpecialValueFor("73", "n_73_poison")
	self.n_74_ice = self:GetSectSpecialValueFor("74", "n_74_ice")
	self.n_75_injury = self:GetSectSpecialValueFor("75", "n_75_injury")
	self.n_76_mana_reduce_pct = self:GetSectSpecialValueFor("76", "n_76_mana_reduce_pct")
	self.r_78_mana_pct = self:GetSectSpecialValueFor("78", "r_78_mana_pct")
	self.r_79_chance = self:GetSectSpecialValueFor("79", "r_79_chance")
	self.r_79_duration = self:GetSectSpecialValueFor("79", "r_79_duration")
	self.r_80_damage = self:GetSectSpecialValueFor("80", "r_80_damage")
	self.r_80_effect_1 = self:GetSectSpecialValueFor("80", "effect_1")
	self.r_154_mana = self:GetSectSpecialValueFor("154", "r_154_mana")
	self.r_154_power = self:GetSectSpecialValueFor("154", "r_154_power")
	self.sr_81_duration = self:GetSectSpecialValueFor("81", "sr_81_duration")
	self.n_127_fury = self:GetSectSpecialValueFor("127", "n_127_fury")
	self.n_170_chaos_count = self:GetSectSpecialValueFor("170", "n_170_chaos_count")
	self.sr_144_damage = self:GetSectSpecialValueFor("144", "sr_144_damage")
	self.sr_190_duration = self:GetSectSpecialValueFor("190", "sr_190_duration")
	self.sr_190_threshold = self:GetSectSpecialValueFor("190", "sr_190_threshold")
	self.trigger_chance = self:GetCustomAbilityValueFor("sect_ulti_trigger", "chance")
	self.effect_value = self:GetCustomAbilityValueFor("sect_ulti_effect", "value")
	self.ability:GetAbilitySpecialValue()
end
function w.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_RESTORE] = { self:GetParent(), -1 },
	}
end
function w.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BASE,
	}
end
function w.prototype.EOM_GetModifierUltiPower(self)
	return self.damage_pct + self.n_71_ulti_power
end
function w.prototype.EOM_GetModifierManaRegenBase(self)
	local x = self.mana_regen
	if self.r_154_power > 0 then
		local y = GetUltiPower(self:GetParent())
		if y > 0 then
			x = x + y / self.r_154_power * self.r_154_mana
		end
	end
	return x
end
function w.prototype.OnCustomTakeDamage(self, z)
	if not self.sr_190_enable then
		return
	end
	local q = self:GetParent()
	if q:GetHealthPercent() <= self.sr_190_threshold then
		local p = q:GetEnemy()
		self.sr_190_enable = false
		if IsInjurable(q, p) then
			local A = q:GetAbilityByIndex(1)
			if IsValid(A) then
				A:OnSpellStart()
				FireModifierEvent(
					EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
					{ ability = A, unit = q, target = p },
					q,
					p
				)
			end
			self.parent:AddNewModifier(
				self.parent,
				self.ability,
				"modifier_sect_ulti_190",
				{ duration = self.sr_190_duration }
			)
		end
	end
end
function w.prototype.OnCustomAbilityFullyCast(self, z)
	if z then
		local q = self:GetParent()
		local p = q:GetEnemy()
		if self.n_3_attackdamage > 0 then
			q:AddNewModifier(q, self:GetAbility(), "modifier_sect_ulti_3_buff", {})
		end
		if self.n_72_shield > 0 then
			self.ability:TriggerByName("72")
		end
		if self.n_127_fury > 0 then
			self.ability:TriggerByName("127")
		end
		if self.n_170_chaos_count > 0 then
			self.ability:TriggerByName("170")
		end
		if self.r_78_mana_pct > 0 then
			self.ability:TriggerByName("78")
		end
		if self.n_65_regen > 0 then
			self.ability:TriggerByName("65")
		end
		if IsValid(p) then
			if self.n_73_poison > 0 then
				self.ability:TriggerByName("73")
			end
			if self.n_74_ice > 0 then
				self.ability:TriggerByName("74")
			end
			if self.n_75_injury > 0 then
				self.ability:TriggerByName("75")
			end
			if self.r_79_chance > 0 and self:PRD(self.r_79_chance, "r_79_chance") then
				self.ability:TriggerByName("79")
			end
			if self.r_80_damage > 0 then
				self.ability:TriggerByName("80", p)
			end
		end
	end
end
function w.prototype.OnRestore(self, z)
	self.mana_record = (self.mana_record or 0) + z.count
	if self.mana_record >= self.trigger_chance then
		self.mana_record = self.mana_record - self.trigger_chance
		self:customAbilityTrigger()
	end
end
function w.prototype.OnBattleStartBefore(self, z)
	local q = self:GetParent()
	local p = q:GetEnemy()
	if self.n_76_mana_reduce_pct and IsValid(p) then
		p:AddNewModifier(q, self:GetAbility(), "modifier_sect_ulti_76_debuff", {})
	end
	self.sr_190_enable = self.sr_190_threshold > 0
end
function w.prototype.OnBattleStart(self, z)
	if IsServer() then
		local q = self:GetParent()
		if self.sr_81_duration > 0 then
			q:AddNewModifier(q, self:GetAbility(), "modifier_sect_ulti_81_buff", { duration = self.sr_81_duration })
		end
		if self.sr_144_damage > 0 then
			q:AddNewModifier(q, self:GetAbility(), "modifier_sect_ulti_144_buff", nil)
		end
	end
end
function w.prototype.OnBattleEnd(self, z)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
function w.prototype.customAbilityTrigger(self)
	if self:GetParent():IsNeutral() then
		return
	end
	if self:GetParent():GetHeroBase():getCustomAbilityTrigger() ~= "sect_ulti" then
		return
	end
	if self.trigger_chance > 0 then
		local B = self:GetParent():GetHeroBase():getCustomAbilityEffectModifier()
		if B ~= nil then
			B:customAbilityEffect()
		end
	end
end
function w.prototype.customAbilityEffect(self)
	self:GetParent():GetHeroBase():addCustomAbilityTriggerCount()
	Restore(self:GetParent(), self.effect_value)
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
g.modifier_sect_ulti = w
g.modifier_sect_ulti_76_debuff = c()
local C = g.modifier_sect_ulti_76_debuff
C.name = "modifier_sect_ulti_76_debuff"
d(C, l)
function C.prototype.GetAbilitySpecialValue(self)
	self.n_76_mana_reduce_pct = self:GetSectSpecialValueFor("76", "n_76_mana_reduce_pct")
	self.n_76_ulti_reduce_pct = self:GetSectSpecialValueFor("76", "n_76_ulti_reduce_pct")
end
function C.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BASE_PERCENTAGE] = -self.n_76_mana_reduce_pct,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER] = -self.n_76_ulti_reduce_pct,
	}
end
C = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	C
)
g.modifier_sect_ulti_76_debuff = C
g.modifier_sect_ulti_81_buff = c()
local D = g.modifier_sect_ulti_81_buff
D.name = "modifier_sect_ulti_81_buff"
d(D, l)
function D.prototype.OnCreated(self, z)
	if IsServer() then
		self:StartIntervalThink(0)
	end
end
function D.prototype.OnIntervalThink(self)
	local q = self:GetParent()
	local A = q:GetAbilityByIndex(1)
	if IsValid(A) then
		local p = q:GetEnemy()
		A:OnSpellStart()
		FireModifierEvent(
			EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
			{ ability = A, unit = q, target = p },
			q,
			p
		)
		self:StartIntervalThink(-1)
	end
end
D = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	D
)
g.modifier_sect_ulti_81_buff = D
g.modifier_sect_ulti_144_buff = c()
local E = g.modifier_sect_ulti_144_buff
E.name = "modifier_sect_ulti_144_buff"
d(E, l)
function E.prototype.GetAbilitySpecialValue(self)
	self.sr_144_power = self:GetSectSpecialValueFor("144", "sr_144_power")
	self.sr_144_damage = self:GetSectSpecialValueFor("144", "sr_144_damage")
end
function E.prototype.OnCreated(self, z)
	local q = self:GetParent()
	if IsServer() then
		self:SetStackCount(1)
		self:StartIntervalThink(1)
		q:EmitSound("Hero_Disruptor.StaticStorm")
	else
		local F = ParticleManager:CreateParticle(
			"particles/econ/items/disruptor/disruptor_2022_immortal/disruptor_2022_immortal_static_storm.vpcf",
			PATTACH_ABSORIGIN,
			q
		)
		ParticleManager:SetParticleControl(F, 1, Vector(500, 1, 1))
		ParticleManager:SetParticleControl(F, 2, Vector(500, 0, 0))
		ParticleManager:SetParticleControl(F, 4, q:GetAbsOrigin())
		self:AddParticle(F, false, false, -1, false, false)
	end
end
function E.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 } }
end
function E.prototype.OnCustomAbilityFullyCast(self, G)
	self:IncrementStackCount()
end
function E.prototype.OnIntervalThink(self)
	local q = self:GetParent()
	local H = q:GetEnemy()
	local A = self:GetAbility()
	if IsInjurable(q, H) then
		q:DealDamage(H, A, self.sr_144_damage * self:GetStackCount(), EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, nil, "144")
	end
end
function E.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER }
end
function E.prototype.EOM_GetModifierUltiPower(self)
	return self:GetStackCount() * self.sr_144_power
end
E = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	E
)
g.modifier_sect_ulti_144_buff = E
g.modifier_sect_ulti_3_buff = c()
local I = g.modifier_sect_ulti_3_buff
I.name = "modifier_sect_ulti_3_buff"
d(I, l)
function I.prototype.GetAbilitySpecialValue(self)
	self.n_3_attackdamage = self:GetSectSpecialValueFor("3", "n_3_attackdamage")
end
function I.prototype.OnCreated(self, z)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function I.prototype.OnRefresh(self, z)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function I.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS }
end
function I.prototype.EOM_GetModifierAttackDamageBonus(self)
	return self.n_3_attackdamage * self:GetStackCount()
end
I = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	I
)
g.modifier_sect_ulti_3_buff = I
g.modifier_sect_ulti_190 = c()
local J = g.modifier_sect_ulti_190
J.name = "modifier_sect_ulti_190"
d(J, l)
function J.prototype.OnCreated(self, z)
	if IsClient() then
		local K = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_essence_effect.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		ParticleManager:ReleaseParticleIndex(K)
	else
		self.parent:EmitSound("Hero_ObsidianDestroyer.EssenceFlux.Cast")
	end
end
function J.prototype.CheckState(self)
	return { [MODIFIER_STATE_SILENCED] = false }
end
J = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_HIGH,
				GetEffectName = "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_matter_buff.vpcf",
				GetEffectAttachType = PATTACH_OVERHEAD_FOLLOW,
				ShouldUseOverheadOffset = true,
			}
		),
	},
	J
)
g.modifier_sect_ulti_190 = J
return g