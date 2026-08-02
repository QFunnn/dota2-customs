--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/sect/sect_poison"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SparseArrayNew
local g = b.__TS__SparseArrayPush
local h = b.__TS__SparseArraySpread
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 1,
		["12"] = 1,
		["13"] = 1,
		["14"] = 2,
		["15"] = 2,
		["16"] = 2,
		["17"] = 4,
		["18"] = 5,
		["19"] = 4,
		["20"] = 5,
		["22"] = 5,
		["23"] = 7,
		["24"] = 9,
		["25"] = 11,
		["26"] = 4,
		["27"] = 37,
		["28"] = 38,
		["29"] = 39,
		["30"] = 40,
		["31"] = 41,
		["32"] = 42,
		["33"] = 43,
		["34"] = 44,
		["35"] = 45,
		["36"] = 46,
		["37"] = 47,
		["38"] = 49,
		["39"] = 50,
		["40"] = 51,
		["41"] = 52,
		["42"] = 53,
		["43"] = 54,
		["44"] = 55,
		["45"] = 56,
		["46"] = 57,
		["47"] = 58,
		["48"] = 59,
		["49"] = 60,
		["50"] = 61,
		["51"] = 37,
		["52"] = 64,
		["53"] = 64,
		["54"] = 64,
		["56"] = 65,
		["58"] = 66,
		["59"] = 67,
		["62"] = 68,
		["63"] = 68,
		["64"] = 68,
		["65"] = 68,
		["66"] = 68,
		["67"] = 68,
		["68"] = 68,
		["72"] = 71,
		["75"] = 72,
		["76"] = 72,
		["77"] = 72,
		["78"] = 72,
		["79"] = 72,
		["80"] = 72,
		["81"] = 72,
		["85"] = 75,
		["88"] = 76,
		["89"] = 76,
		["90"] = 76,
		["91"] = 76,
		["92"] = 76,
		["93"] = 76,
		["94"] = 76,
		["98"] = 79,
		["101"] = 80,
		["102"] = 80,
		["103"] = 80,
		["104"] = 80,
		["105"] = 80,
		["106"] = 80,
		["110"] = 83,
		["113"] = 84,
		["114"] = 85,
		["115"] = 86,
		["116"] = 87,
		["117"] = 88,
		["118"] = 89,
		["119"] = 89,
		["120"] = 89,
		["121"] = 89,
		["122"] = 89,
		["123"] = 89,
		["124"] = 95,
		["125"] = 96,
		["126"] = 97,
		["127"] = 98,
		["128"] = 98,
		["129"] = 98,
		["130"] = 98,
		["131"] = 98,
		["132"] = 98,
		["133"] = 98,
		["134"] = 98,
		["136"] = 89,
		["137"] = 89,
		["138"] = 102,
		["145"] = 64,
		["146"] = 109,
		["147"] = 110,
		["148"] = 109,
		["149"] = 5,
		["150"] = 4,
		["151"] = 5,
		["153"] = 5,
		["154"] = 114,
		["155"] = 122,
		["156"] = 114,
		["157"] = 122,
		["159"] = 122,
		["160"] = 126,
		["161"] = 128,
		["162"] = 131,
		["163"] = 133,
		["164"] = 114,
		["165"] = 160,
		["166"] = 161,
		["167"] = 162,
		["168"] = 163,
		["169"] = 164,
		["170"] = 165,
		["171"] = 168,
		["172"] = 169,
		["173"] = 170,
		["174"] = 171,
		["175"] = 172,
		["176"] = 174,
		["177"] = 175,
		["178"] = 176,
		["179"] = 177,
		["180"] = 178,
		["181"] = 179,
		["182"] = 180,
		["183"] = 181,
		["184"] = 182,
		["185"] = 183,
		["186"] = 184,
		["187"] = 185,
		["188"] = 186,
		["189"] = 187,
		["190"] = 160,
		["191"] = 190,
		["192"] = 191,
		["193"] = 191,
		["194"] = 191,
		["195"] = 194,
		["196"] = 194,
		["197"] = 194,
		["198"] = 191,
		["199"] = 195,
		["200"] = 195,
		["201"] = 195,
		["202"] = 191,
		["203"] = 196,
		["204"] = 196,
		["205"] = 196,
		["206"] = 191,
		["207"] = 191,
		["208"] = 190,
		["209"] = 199,
		["210"] = 200,
		["211"] = 199,
		["212"] = 206,
		["213"] = 208,
		["214"] = 209,
		["216"] = 206,
		["217"] = 212,
		["218"] = 213,
		["219"] = 212,
		["220"] = 221,
		["221"] = 222,
		["222"] = 221,
		["223"] = 225,
		["224"] = 226,
		["225"] = 227,
		["227"] = 225,
		["228"] = 237,
		["229"] = 238,
		["230"] = 239,
		["231"] = 240,
		["232"] = 241,
		["233"] = 242,
		["234"] = 244,
		["235"] = 246,
		["236"] = 246,
		["237"] = 246,
		["238"] = 246,
		["239"] = 246,
		["240"] = 246,
		["241"] = 254,
		["242"] = 255,
		["243"] = 256,
		["244"] = 256,
		["245"] = 256,
		["246"] = 256,
		["247"] = 256,
		["248"] = 256,
		["250"] = 260,
		["251"] = 262,
		["252"] = 263,
		["253"] = 264,
		["255"] = 267,
		["256"] = 267,
		["257"] = 267,
		["258"] = 267,
		["259"] = 267,
		["260"] = 267,
		["261"] = 267,
		["262"] = 267,
		["263"] = 268,
		["264"] = 271,
		["265"] = 271,
		["266"] = 271,
		["267"] = 271,
		["268"] = 271,
		["269"] = 271,
		["270"] = 271,
		["271"] = 271,
		["273"] = 275,
		["274"] = 276,
		["275"] = 277,
		["276"] = 277,
		["277"] = 277,
		["278"] = 277,
		["279"] = 277,
		["280"] = 277,
		["281"] = 277,
		["282"] = 277,
		["283"] = 278,
		["284"] = 279,
		["285"] = 279,
		["286"] = 279,
		["287"] = 279,
		["288"] = 279,
		["289"] = 279,
		["291"] = 281,
		["292"] = 282,
		["293"] = 282,
		["294"] = 282,
		["295"] = 282,
		["296"] = 282,
		["297"] = 282,
		["300"] = 237,
		["301"] = 287,
		["302"] = 288,
		["303"] = 289,
		["305"] = 287,
		["306"] = 293,
		["307"] = 294,
		["308"] = 295,
		["310"] = 293,
		["311"] = 299,
		["312"] = 300,
		["313"] = 302,
		["314"] = 303,
		["315"] = 304,
		["316"] = 305,
		["317"] = 308,
		["318"] = 308,
		["319"] = 308,
		["320"] = 308,
		["323"] = 299,
		["324"] = 312,
		["325"] = 313,
		["326"] = 314,
		["327"] = 315,
		["328"] = 316,
		["329"] = 317,
		["330"] = 319,
		["331"] = 320,
		["335"] = 325,
		["336"] = 326,
		["338"] = 329,
		["339"] = 330,
		["340"] = 331,
		["341"] = 332,
		["342"] = 332,
		["343"] = 332,
		["344"] = 332,
		["345"] = 332,
		["346"] = 332,
		["347"] = 332,
		["348"] = 332,
		["349"] = 332,
		["350"] = 333,
		["351"] = 333,
		["352"] = 333,
		["353"] = 333,
		["354"] = 333,
		["355"] = 334,
		["356"] = 335,
		["357"] = 335,
		["358"] = 335,
		["359"] = 335,
		["360"] = 335,
		["361"] = 336,
		["362"] = 337,
		["363"] = 337,
		["364"] = 337,
		["365"] = 337,
		["366"] = 337,
		["367"] = 337,
		["368"] = 337,
		["369"] = 338,
		["372"] = 312,
		["373"] = 342,
		["374"] = 343,
		["375"] = 344,
		["376"] = 345,
		["377"] = 346,
		["378"] = 348,
		["379"] = 350,
		["382"] = 355,
		["384"] = 342,
		["385"] = 359,
		["386"] = 360,
		["389"] = 363,
		["392"] = 366,
		["393"] = 367,
		["394"] = 368,
		["396"] = 368,
		["400"] = 359,
		["401"] = 372,
		["402"] = 373,
		["403"] = 374,
		["405"] = 374,
		["406"] = 374,
		["407"] = 374,
		["409"] = 374,
		["412"] = 374,
		["413"] = 374,
		["415"] = 374,
		["416"] = 372,
		["417"] = 122,
		["418"] = 114,
		["419"] = 114,
		["420"] = 114,
		["421"] = 114,
		["422"] = 114,
		["423"] = 114,
		["424"] = 114,
		["425"] = 114,
		["426"] = 122,
		["428"] = 122,
		["430"] = 379,
		["431"] = 387,
		["432"] = 379,
		["433"] = 387,
		["434"] = 388,
		["435"] = 389,
		["436"] = 390,
		["437"] = 391,
		["438"] = 392,
		["439"] = 393,
		["440"] = 393,
		["441"] = 393,
		["442"] = 393,
		["443"] = 393,
		["444"] = 394,
		["445"] = 394,
		["446"] = 394,
		["447"] = 394,
		["448"] = 394,
		["449"] = 394,
		["450"] = 394,
		["451"] = 394,
		["453"] = 388,
		["454"] = 397,
		["455"] = 398,
		["456"] = 397,
		["457"] = 387,
		["458"] = 379,
		["459"] = 379,
		["460"] = 379,
		["461"] = 379,
		["462"] = 379,
		["463"] = 379,
		["464"] = 379,
		["465"] = 387,
		["467"] = 387,
		["469"] = 405,
		["470"] = 413,
		["471"] = 405,
		["472"] = 413,
		["473"] = 416,
		["474"] = 417,
		["475"] = 418,
		["476"] = 416,
		["477"] = 420,
		["478"] = 421,
		["479"] = 420,
		["480"] = 425,
		["481"] = 426,
		["482"] = 427,
		["484"] = 425,
		["485"] = 413,
		["486"] = 405,
		["487"] = 405,
		["488"] = 405,
		["489"] = 405,
		["490"] = 405,
		["491"] = 405,
		["492"] = 405,
		["493"] = 413,
		["495"] = 413,
		["497"] = 433,
		["498"] = 441,
		["499"] = 433,
		["500"] = 441,
		["501"] = 444,
		["502"] = 445,
		["503"] = 446,
		["504"] = 444,
		["505"] = 448,
		["506"] = 449,
		["507"] = 448,
		["508"] = 454,
		["509"] = 455,
		["510"] = 456,
		["512"] = 454,
		["513"] = 441,
		["514"] = 433,
		["515"] = 433,
		["516"] = 433,
		["517"] = 433,
		["518"] = 433,
		["519"] = 433,
		["520"] = 433,
		["521"] = 441,
		["523"] = 441,
		["525"] = 462,
		["526"] = 469,
		["527"] = 462,
		["528"] = 469,
		["529"] = 474,
		["530"] = 475,
		["531"] = 476,
		["532"] = 477,
		["533"] = 474,
		["534"] = 479,
		["535"] = 480,
		["536"] = 481,
		["537"] = 482,
		["539"] = 479,
		["540"] = 485,
		["541"] = 486,
		["542"] = 487,
		["543"] = 488,
		["545"] = 485,
		["546"] = 491,
		["547"] = 492,
		["548"] = 491,
		["549"] = 496,
		["550"] = 497,
		["551"] = 496,
		["552"] = 499,
		["553"] = 500,
		["554"] = 501,
		["555"] = 501,
		["556"] = 500,
		["557"] = 499,
		["558"] = 504,
		["559"] = 505,
		["562"] = 508,
		["563"] = 504,
		["564"] = 469,
		["565"] = 462,
		["566"] = 462,
		["567"] = 462,
		["568"] = 462,
		["569"] = 462,
		["570"] = 462,
		["571"] = 462,
		["572"] = 469,
		["574"] = 469,
	}
)
local j = {}
local k = require("lib.dota_ts_adapter")
local l = k.BaseAbility
local m = k.registerAbility
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
j.sect_poison = c()
local q = j.sect_poison
q.name = "sect_poison"
d(q, l)
function q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.timerInterval = 0.1
	self.n_82_timer = 0
	self.n_85_timer = 0
end
function q.prototype.GetAbilitySpecialValue(self)
	self.poison_count_extra = self:GetSpecialValueFor("poison_count_extra")
	self.poison_interval_reduce = self:GetSpecialValueFor("poison_interval_reduce")
	self.n_82_interval = self:GetSectSpecialValueFor("82", "n_82_interval")
	self.n_82_poison = self:GetSectSpecialValueFor("82", "n_82_poison")
	self.n_85_chance = self:GetSectSpecialValueFor("85", "n_85_chance")
	self.n_87_interval = self:GetSectSpecialValueFor("87", "n_87_interval")
	self.n_87_poison = self:GetSectSpecialValueFor("87", "n_87_poison")
	self.r_88_chance = self:GetSectSpecialValueFor("88", "r_88_chance")
	self.r_88_poison = self:GetSectSpecialValueFor("88", "r_88_poison")
	self.r_89_poison = self:GetSectSpecialValueFor("89", "r_89_poison")
	self.r_89_effect_1 = self:GetSectSpecialValueFor("89", "effect_1")
	self.r_90_chance = self:GetSectSpecialValueFor("90", "r_90_chance")
	self.r_90_poison = self:GetSectSpecialValueFor("90", "r_90_poison")
	self.sr_91_threshold = self:GetSectSpecialValueFor("91", "sr_91_threshold")
	self.sr_91_poison = self:GetSectSpecialValueFor("91", "sr_91_poison")
	self.sr_145_interval_reduce = self:GetSectSpecialValueFor("145", "sr_145_interval_reduce")
	self.sr_145_reduce = self:GetSectSpecialValueFor("145", "sr_145_reduce")
	self.sr_145_chance = self:GetSectSpecialValueFor("145", "sr_145_chance")
	self.n_177_chance = self:GetSectSpecialValueFor("177", "n_177_chance")
	self.n_177_chaos_count = self:GetSectSpecialValueFor("177", "n_177_chaos_count")
	self.sr_195_poison_deep = self:GetSectSpecialValueFor("195", "sr_195_poison_deep")
	self.sr_195_back = self:GetSectSpecialValueFor("195", "sr_195_back")
	self.sr_195_tick = self:GetSectSpecialValueFor("195", "sr_195_tick")
end
function q.prototype.TriggerByName(self, r, s)
	if s == nil then
		s = self:GetCaster():GetEnemy()
	end
	local t = self:GetCaster()
	repeat
		local u = r
		local v = u == "82"
		if v then
			do
				AddPoison(t, s, self.n_82_poison, "82", "AbilityUpgrade")
				break
			end
		end
		v = v or u == "90"
		if v then
			do
				AddPoison(t, s, self.r_90_poison, "90", "AbilityUpgrade")
				break
			end
		end
		v = v or u == "88"
		if v then
			do
				AddPoison(t, t:GetEnemy(), self.r_88_poison, "88", "AbilityUpgrade")
				break
			end
		end
		v = v or u == "177"
		if v then
			do
				AddChaos(t, GetSectChaosModifiedValue(t, self.n_177_chaos_count), "177", "AbilityUpgrade")
				break
			end
		end
		v = v or u == "195"
		if v then
			do
				local w = s:FindModifierByName("modifier_sect_poison_195_debuff")
				if IsValid(w) then
					local x = w.sr_195_record
					local y = Round(x * self.sr_195_back * 0.01)
					if y > 0 then
						Projectile:CreateTrackingProjectile({
							EffectName = "particles/units/heroes/hero_venomancer/venomancer_noxious_plague_projectile.vpcf",
							hCaster = t,
							vSpawnOrigin = t:GetAttachmentPosition("attach_hitloc"),
							hTarget = s,
							iMoveSpeed = PROJECTILE_SPEED_FAST,
							OnProjectileHit = function(z, A, B)
								if IsInjurable(t, s) then
									s:EmitSound("Hero_Venomancer.NoxiousPlague.Damage2nd")
									AddPoison(t, s, y, "195", "AbilityUpgrade", PoisonFlags.POISON_FLAG_NO_EXTRA)
								end
							end,
						})
						t:EmitSound("Hero_Venomancer.NoxiousPlague.Damage")
					end
				end
				break
			end
		end
	until true
end
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_sect_poison"
end
q = e({ m(nil) }, q)
j.sect_poison = q
j.modifier_sect_poison = c()
local C = j.modifier_sect_poison
C.name = "modifier_sect_poison"
d(C, o)
function C.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.timerInterval = 0.1
	self.sr_flag = false
	self.n_82_timer = 0
	self.n_85_timer = 0
end
function C.prototype.GetAbilitySpecialValue(self)
	self.poison_count_extra = self:GetAbilitySpecialValueFor("poison_count_extra")
	self.poison_interval_reduce = self:GetAbilitySpecialValueFor("poison_interval_reduce")
	self.n_82_interval = self:GetSectSpecialValueFor("82", "n_82_interval")
	self.n_82_poison = self:GetSectSpecialValueFor("82", "n_82_poison")
	self.n_85_chance = self:GetSectSpecialValueFor("85", "n_85_chance")
	self.n_87_interval = self:GetSectSpecialValueFor("87", "n_87_interval")
	self.n_87_poison = self:GetSectSpecialValueFor("87", "n_87_poison")
	self.r_88_chance = self:GetSectSpecialValueFor("88", "r_88_chance")
	self.r_88_poison = self:GetSectSpecialValueFor("88", "r_88_poison")
	self.r_89_poison = self:GetSectSpecialValueFor("89", "r_89_poison")
	self.r_89_effect_1 = self:GetSectSpecialValueFor("89", "effect_1")
	self.r_90_chance = self:GetSectSpecialValueFor("90", "r_90_chance")
	self.r_90_poison = self:GetSectSpecialValueFor("90", "r_90_poison")
	self.sr_91_threshold = self:GetSectSpecialValueFor("91", "sr_91_threshold")
	self.sr_91_poison = self:GetSectSpecialValueFor("91", "sr_91_poison")
	self.sr_145_interval_reduce = self:GetSectSpecialValueFor("145", "sr_145_interval_reduce")
	self.sr_145_reduce = self:GetSectSpecialValueFor("145", "sr_145_reduce")
	self.sr_145_chance = self:GetSectSpecialValueFor("145", "sr_145_chance")
	self.n_177_chance = self:GetSectSpecialValueFor("177", "n_177_chance")
	self.n_177_chaos_count = self:GetSectSpecialValueFor("177", "n_177_chaos_count")
	self.sr_195_poison_deep = self:GetSectSpecialValueFor("195", "sr_195_poison_deep")
	self.trigger_chance = self:GetCustomAbilityValueFor("sect_poison_trigger", "chance")
	self.effect_value = self:GetCustomAbilityValueFor("sect_poison_effect", "value")
	self.ability:GetAbilitySpecialValue()
end
function C.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_POISON_GAINED] = { self:GetParent(), -1 },
	}
end
function C.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_STACK_BONUS] = self.poison_count_extra,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_INTERVAL] = -self.poison_interval_reduce,
	}
end
function C.prototype.EOM_GetModifierIncomingDamagePercentage(self, D)
	if D and D.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_POISON and self.n_85_chance > 0 then
		return -self.n_85_chance
	end
end
function C.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_INTERVAL,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_ATTENUATION_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end
function C.prototype.EOM_GetModifierPoisonInterval(self)
	return -self.sr_145_interval_reduce
end
function C.prototype.EOM_GetModifierPoisonAttenuationPercent(self, D)
	if
		(D and D.attacker) == self:GetParent()
		and self.sr_145_chance > 0
		and self:PRD(self.sr_145_chance, "sr_145_chance")
	then
		return -self.sr_145_reduce
	end
end
function C.prototype.OnBattleStartBefore(self, D)
	local E = self:GetParent()
	local F = E:GetEnemy()
	self.n_82_timer = 0
	self.n_85_timer = 0
	self.sr_flag = false
	if IsInjurable(F) then
		F:AddNewModifier(E, self:GetAbility(), "modifier_poison_deepen", {})
		local G = self.r_89_poison + GetPoisonPreBattle(E)
		if self.r_89_effect_1 > 0 then
			F:AddNewModifier(E, self:GetAbility(), "modifier_poison_89_effect_1", { duration = self.r_89_effect_1 })
		end
		if G > 0 then
			local H = E:FindAbilityByName("sect_poison")
			if not IsValid(H) then
				H = E:AddAbility_Engine("sect_poison")
			end
			CombatLog:recordBuff(E, F, "poison", G, "89", "AbilityUpgrade")
			F:AddNewModifier(E, H, "modifier_poison_custom", { iStackCount = G })
			PlayerData:addDetailData(self:GetParent(), "AbilityUpgrade", "poison", G, false, "89")
		end
		if self.sr_145_chance > 0 then
			local I = ParticleManager:CreateParticle("particles/sect/sect_poison_145.vpcf", PATTACH_ABSORIGIN, E)
			self:AddParticle(I, false, false, -1, false, false)
			E:EmitSound("Hero_Viper.Nethertoxin.Cast")
			F:AddNewModifier(E, self:GetAbility(), "modifier_sect_poison_145_debuff", {})
		end
		if self.sr_195_poison_deep > 0 then
			F:AddNewModifier(E, self:GetAbility(), "modifier_sect_poison_195_debuff", {})
		end
	end
end
function C.prototype.OnBattleStart(self, D)
	if IsServer() then
		self:StartIntervalThink(self.timerInterval)
	end
end
function C.prototype.OnBattleEnd(self, D)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
function C.prototype.OnIntervalThink(self)
	local E = self:GetParent()
	if self.n_82_interval > 0 then
		self.n_82_timer = self.n_82_timer + self.timerInterval
		if self.n_82_timer >= self.n_82_interval then
			self.n_82_timer = self.n_82_timer - self.n_82_interval
			self.ability:TriggerByName("82", E:GetEnemy())
		end
	end
end
function C.prototype.OnCustomTakeDamage(self, D)
	local J = D.attacker
	local K = D.target
	local t = self:GetParent()
	if J == t then
		if K ~= t then
			if self.r_90_chance > 0 and self:PRD(self.r_90_chance, "r_90_chance") then
				self.ability:TriggerByName("90", K)
			end
		end
	else
		if self.r_88_chance > 0 and self:PRD(self.r_88_chance, "r_88_chance") then
			self.ability:TriggerByName("88")
		end
		if t:GetHealth() / t:GetMaxHealth() < self.sr_91_threshold / 100 and self.sr_flag == false then
			self.sr_flag = true
			local L = ParticleManager:CreateParticle("particles/sect/poison_legend.vpcf", PATTACH_CUSTOMORIGIN, t)
			ParticleManager:SetParticleControlEnt(L, 0, J, PATTACH_ABSORIGIN_FOLLOW, "", J:GetAbsOrigin(), false)
			ParticleManager:SetParticleControl(L, 1, Vector(250, 1, 300))
			ParticleManager:ReleaseParticleIndex(L)
			EmitSoundOnLocationWithCaster(J:GetAbsOrigin(), "Hero_Venomancer.PoisonNova", t)
			CombatLog:recordSectAbilityCast(t, "91")
			AddPoison(t, J, self.sr_91_poison, "91", "AbilityUpgrade")
			TriggerPoison(J)
		end
	end
end
function C.prototype.OnPoisonGained(self, M)
	if M then
		local t = self:GetParent()
		local K = t:GetEnemy()
		if IsInjurable(K) then
			if self.n_177_chance > 0 and self:PRD(self.n_177_chance, "n_177_chance") then
				self.ability:TriggerByName("177")
			end
		end
		self:customAbilityTrigger()
	end
end
function C.prototype.customAbilityTrigger(self)
	if self:GetParent():IsNeutral() then
		return
	end
	if self:GetParent():GetHeroBase():getCustomAbilityTrigger() ~= "sect_poison" then
		return
	end
	if self.trigger_chance > 0 then
		if self.trigger_chance > 0 and self:PRD(self.trigger_chance, "trigger_chance") then
			local N = self:GetParent():GetHeroBase():getCustomAbilityEffectModifier()
			if N ~= nil then
				N:customAbilityEffect()
			end
		end
	end
end
function C.prototype.customAbilityEffect(self)
	self:GetParent():GetHeroBase():addCustomAbilityTriggerCount()
	local O = AddPoison
	local P = f(self:GetParent(), self:GetParent():GetEnemy(), self.effect_value)
	local Q = self:GetAbility()
	g(P, Q and Q:GetAbilityName() or "", "Sect")
	O(h(P))
end
C = e(
	{
		p(
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
	C
)
j.modifier_sect_poison = C
j.modifier_poison_89_effect_1 = c()
local R = j.modifier_poison_89_effect_1
R.name = "modifier_poison_89_effect_1"
d(R, o)
function R.prototype.OnCreated(self, D)
	if IsServer() then
		local t = self:GetParent()
		t:EmitSound("Hero_Alchemist.AcidSpray")
		local S = ParticleManager:CreateParticle("", PATTACH_ABSORIGIN, t)
		ParticleManager:SetParticleControl(S, 1, Vector(200, 200, 200))
		self:AddParticle(S, false, false, -1, false, false)
	end
end
function R.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_ATTENUATION_PERCENTAGE] = -100 }
end
R = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	R
)
j.modifier_poison_89_effect_1 = R
j.modifier_sect_poison_86_debuff = c()
local T = j.modifier_sect_poison_86_debuff
T.name = "modifier_sect_poison_86_debuff"
d(T, o)
function T.prototype.GetAbilitySpecialValue(self)
	self.n_86_poison_per_ice = self:GetSectSpecialValueFor("86", "n_86_poison_per_ice")
	self.n_86_poison = self:GetSectSpecialValueFor("86", "n_86_poison")
end
function T.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_DAMAGE_BONUS_TARGET }
end
function T.prototype.EOM_GetModifierPoisonDamageBonusTarget(self, D)
	if self.n_86_poison_per_ice > 0 then
		return math.floor(GetIce(self:GetParent()) / self.n_86_poison_per_ice) * self.n_86_poison
	end
end
T = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	T
)
j.modifier_sect_poison_86_debuff = T
j.modifier_sect_poison_145_debuff = c()
local U = j.modifier_sect_poison_145_debuff
U.name = "modifier_sect_poison_145_debuff"
d(U, o)
function U.prototype.GetAbilitySpecialValue(self)
	self.sr_145_reduce = self:GetSectSpecialValueFor("145", "sr_145_reduce")
	self.sr_145_chance = self:GetSectSpecialValueFor("145", "sr_145_chance")
end
function U.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_ATTENUATION_PERCENTAGE }
end
function U.prototype.EOM_GetModifierPoisonAttenuationPercent(self, D)
	if
		(D and D.unit) == self:GetParent()
		and self.sr_145_chance > 0
		and self:PRD(self.sr_145_chance, "sr_145_chance")
	then
		return -self.sr_145_reduce
	end
end
U = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	U
)
j.modifier_sect_poison_145_debuff = U
j.modifier_sect_poison_195_debuff = c()
local V = j.modifier_sect_poison_195_debuff
V.name = "modifier_sect_poison_195_debuff"
d(V, o)
function V.prototype.GetAbilitySpecialValue(self)
	self.sr_195_poison_deep = self:GetSectSpecialValueFor("195", "sr_195_poison_deep")
	self.sr_195_back = self:GetSectSpecialValueFor("195", "sr_195_back")
	self.sr_195_tick = self:GetSectSpecialValueFor("195", "sr_195_tick")
end
function V.prototype.OnCreated(self, D)
	if IsServer() then
		self.sr_195_record = 0
		self:StartIntervalThink(self.sr_195_tick)
	end
end
function V.prototype.OnIntervalThink(self)
	if IsServer() then
		self:GetAbility():TriggerByName("195")
		self.sr_195_record = 0
	end
end
function V.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_DEEPEN }
end
function V.prototype.EOM_GetModifierPoisonDeepen(self, D)
	return self.sr_195_poison_deep
end
function V.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_POISON_GAINED] = { -1, self:GetCaster() } }
end
function V.prototype.OnPoisonGained(self, D)
	if D.flag and bit.band(D.flag, PoisonFlags.POISON_FLAG_NO_EXTRA) == PoisonFlags.POISON_FLAG_NO_EXTRA then
		return
	end
	self.sr_195_record = self.sr_195_record + D.iStackCount
end
V = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	V
)
j.modifier_sect_poison_195_debuff = V
return j