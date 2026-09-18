--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/yang_jian"
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
		["17"] = 4,
		["18"] = 4,
		["19"] = 4,
		["20"] = 7,
		["21"] = 8,
		["22"] = 9,
		["23"] = 10,
		["25"] = 13,
		["26"] = 14,
		["27"] = 13,
		["28"] = 14,
		["29"] = 15,
		["30"] = 15,
		["31"] = 15,
		["32"] = 18,
		["33"] = 18,
		["34"] = 18,
		["36"] = 18,
		["37"] = 18,
		["39"] = 19,
		["40"] = 20,
		["41"] = 21,
		["44"] = 22,
		["45"] = 23,
		["46"] = 24,
		["47"] = 25,
		["48"] = 26,
		["49"] = 26,
		["52"] = 28,
		["53"] = 29,
		["54"] = 29,
		["55"] = 29,
		["56"] = 29,
		["57"] = 29,
		["58"] = 29,
		["59"] = 29,
		["60"] = 29,
		["61"] = 29,
		["62"] = 30,
		["63"] = 30,
		["64"] = 30,
		["65"] = 30,
		["66"] = 30,
		["67"] = 30,
		["68"] = 30,
		["69"] = 30,
		["70"] = 30,
		["71"] = 31,
		["72"] = 32,
		["73"] = 33,
		["74"] = 34,
		["75"] = 36,
		["76"] = 18,
		["77"] = 14,
		["78"] = 13,
		["79"] = 14,
		["81"] = 14,
		["82"] = 40,
		["83"] = 41,
		["84"] = 40,
		["85"] = 41,
		["87"] = 41,
		["88"] = 42,
		["89"] = 43,
		["90"] = 44,
		["91"] = 46,
		["92"] = 40,
		["93"] = 47,
		["94"] = 48,
		["95"] = 48,
		["96"] = 48,
		["97"] = 51,
		["98"] = 51,
		["99"] = 51,
		["100"] = 48,
		["101"] = 48,
		["102"] = 47,
		["103"] = 54,
		["104"] = 55,
		["105"] = 56,
		["106"] = 57,
		["107"] = 58,
		["108"] = 59,
		["109"] = 60,
		["110"] = 61,
		["111"] = 62,
		["112"] = 63,
		["113"] = 64,
		["114"] = 65,
		["115"] = 66,
		["117"] = 54,
		["118"] = 69,
		["119"] = 70,
		["120"] = 71,
		["121"] = 72,
		["122"] = 74,
		["123"] = 74,
		["124"] = 74,
		["125"] = 75,
		["126"] = 75,
		["128"] = 76,
		["129"] = 77,
		["130"] = 78,
		["131"] = 79,
		["132"] = 79,
		["133"] = 79,
		["134"] = 79,
		["135"] = 79,
		["136"] = 79,
		["139"] = 74,
		["140"] = 74,
		["141"] = 69,
		["142"] = 84,
		["143"] = 85,
		["144"] = 86,
		["145"] = 87,
		["147"] = 84,
		["148"] = 90,
		["149"] = 90,
		["150"] = 90,
		["152"] = 90,
		["153"] = 91,
		["154"] = 92,
		["155"] = 93,
		["156"] = 94,
		["157"] = 95,
		["158"] = 96,
		["159"] = 97,
		["160"] = 98,
		["161"] = 98,
		["163"] = 91,
		["164"] = 100,
		["165"] = 101,
		["166"] = 102,
		["169"] = 103,
		["170"] = 104,
		["171"] = 105,
		["172"] = 106,
		["173"] = 107,
		["174"] = 107,
		["175"] = 107,
		["176"] = 107,
		["177"] = 107,
		["178"] = 107,
		["179"] = 107,
		["182"] = 110,
		["185"] = 111,
		["186"] = 100,
		["187"] = 113,
		["188"] = 114,
		["189"] = 115,
		["192"] = 116,
		["193"] = 116,
		["194"] = 116,
		["195"] = 116,
		["196"] = 116,
		["197"] = 116,
		["198"] = 116,
		["199"] = 117,
		["200"] = 118,
		["201"] = 119,
		["202"] = 120,
		["203"] = 121,
		["204"] = 121,
		["205"] = 121,
		["206"] = 121,
		["208"] = 123,
		["209"] = 113,
		["210"] = 125,
		["211"] = 125,
		["212"] = 125,
		["213"] = 126,
		["214"] = 127,
		["215"] = 128,
		["216"] = 128,
		["218"] = 130,
		["219"] = 131,
		["220"] = 131,
		["222"] = 133,
		["223"] = 133,
		["225"] = 134,
		["226"] = 126,
		["227"] = 136,
		["228"] = 137,
		["229"] = 138,
		["230"] = 139,
		["231"] = 139,
		["232"] = 139,
		["233"] = 139,
		["236"] = 140,
		["239"] = 141,
		["240"] = 142,
		["241"] = 136,
		["242"] = 41,
		["243"] = 40,
		["244"] = 41,
		["246"] = 41,
		["248"] = 147,
		["249"] = 148,
		["250"] = 147,
		["251"] = 148,
		["253"] = 148,
		["254"] = 149,
		["255"] = 147,
		["256"] = 150,
		["257"] = 150,
		["258"] = 150,
		["259"] = 151,
		["260"] = 152,
		["261"] = 153,
		["264"] = 154,
		["265"] = 155,
		["266"] = 156,
		["267"] = 157,
		["268"] = 158,
		["269"] = 159,
		["270"] = 161,
		["271"] = 162,
		["272"] = 163,
		["273"] = 164,
		["274"] = 165,
		["275"] = 166,
		["277"] = 168,
		["278"] = 169,
		["279"] = 170,
		["280"] = 170,
		["282"] = 171,
		["283"] = 172,
		["284"] = 173,
		["285"] = 174,
		["286"] = 175,
		["289"] = 176,
		["290"] = 177,
		["291"] = 151,
		["292"] = 148,
		["293"] = 147,
		["294"] = 148,
		["296"] = 148,
		["297"] = 181,
		["298"] = 182,
		["299"] = 181,
		["300"] = 182,
		["301"] = 183,
		["302"] = 184,
		["303"] = 184,
		["304"] = 184,
		["305"] = 184,
		["306"] = 185,
		["307"] = 186,
		["308"] = 186,
		["309"] = 186,
		["310"] = 186,
		["311"] = 187,
		["312"] = 188,
		["313"] = 188,
		["314"] = 188,
		["315"] = 188,
		["316"] = 189,
		["317"] = 189,
		["318"] = 189,
		["319"] = 189,
		["320"] = 189,
		["321"] = 189,
		["323"] = 191,
		["324"] = 192,
		["325"] = 194,
		["326"] = 194,
		["329"] = 196,
		["330"] = 183,
		["331"] = 198,
		["332"] = 199,
		["333"] = 200,
		["334"] = 201,
		["337"] = 202,
		["338"] = 203,
		["339"] = 203,
		["340"] = 203,
		["341"] = 203,
		["342"] = 203,
		["343"] = 203,
		["345"] = 198,
		["346"] = 206,
		["347"] = 207,
		["348"] = 206,
		["349"] = 209,
		["350"] = 209,
		["351"] = 209,
		["352"] = 210,
		["353"] = 210,
		["354"] = 210,
		["355"] = 182,
		["356"] = 181,
		["357"] = 182,
		["359"] = 182,
		["361"] = 214,
		["362"] = 215,
		["363"] = 214,
		["364"] = 215,
		["365"] = 216,
		["366"] = 217,
		["367"] = 219,
		["368"] = 219,
		["369"] = 220,
		["370"] = 220,
		["372"] = 221,
		["373"] = 221,
		["374"] = 221,
		["375"] = 221,
		["376"] = 221,
		["378"] = 219,
		["379"] = 222,
		["380"] = 222,
		["381"] = 222,
		["383"] = 222,
		["385"] = 222,
		["386"] = 223,
		["387"] = 216,
		["388"] = 225,
		["389"] = 225,
		["390"] = 225,
		["391"] = 226,
		["392"] = 226,
		["393"] = 226,
		["394"] = 227,
		["395"] = 215,
		["396"] = 227,
		["397"] = 228,
		["398"] = 228,
		["399"] = 228,
		["400"] = 229,
		["401"] = 230,
		["404"] = 233,
		["405"] = 234,
		["406"] = 234,
		["408"] = 229,
		["409"] = 215,
		["410"] = 214,
		["411"] = 215,
		["413"] = 215,
		["414"] = 238,
		["415"] = 239,
		["416"] = 238,
		["417"] = 239,
		["418"] = 240,
		["419"] = 241,
		["422"] = 242,
		["423"] = 243,
		["424"] = 240,
		["425"] = 245,
		["426"] = 246,
		["427"] = 247,
		["430"] = 248,
		["431"] = 249,
		["432"] = 249,
		["434"] = 251,
		["435"] = 245,
		["436"] = 239,
		["437"] = 238,
		["438"] = 239,
		["440"] = 239,
		["441"] = 255,
		["442"] = 256,
		["443"] = 255,
		["444"] = 256,
		["445"] = 258,
		["446"] = 259,
		["449"] = 260,
		["450"] = 261,
		["451"] = 262,
		["452"] = 263,
		["453"] = 263,
		["454"] = 263,
		["455"] = 263,
		["456"] = 263,
		["457"] = 263,
		["459"] = 258,
		["460"] = 266,
		["461"] = 267,
		["462"] = 268,
		["463"] = 266,
		["464"] = 270,
		["465"] = 271,
		["468"] = 272,
		["469"] = 273,
		["470"] = 276,
		["471"] = 276,
		["472"] = 276,
		["473"] = 276,
		["474"] = 276,
		["475"] = 276,
		["476"] = 276,
		["477"] = 276,
		["478"] = 276,
		["479"] = 276,
		["480"] = 276,
		["481"] = 276,
		["482"] = 276,
		["483"] = 276,
		["484"] = 276,
		["485"] = 288,
		["488"] = 289,
		["489"] = 289,
		["491"] = 290,
		["492"] = 270,
		["493"] = 292,
		["494"] = 293,
		["495"] = 292,
		["496"] = 295,
		["497"] = 296,
		["500"] = 297,
		["501"] = 298,
		["502"] = 295,
		["503"] = 300,
		["504"] = 301,
		["505"] = 302,
		["508"] = 305,
		["509"] = 300,
		["510"] = 307,
		["511"] = 308,
		["512"] = 308,
		["513"] = 308,
		["514"] = 308,
		["515"] = 307,
		["516"] = 313,
		["517"] = 313,
		["518"] = 313,
		["519"] = 314,
		["520"] = 314,
		["521"] = 314,
		["522"] = 315,
		["523"] = 315,
		["524"] = 315,
		["525"] = 316,
		["526"] = 317,
		["527"] = 317,
		["529"] = 318,
		["530"] = 318,
		["531"] = 318,
		["532"] = 318,
		["533"] = 318,
		["534"] = 318,
		["535"] = 318,
		["536"] = 318,
		["537"] = 318,
		["538"] = 318,
		["539"] = 318,
		["540"] = 316,
		["541"] = 330,
		["542"] = 331,
		["543"] = 331,
		["544"] = 331,
		["545"] = 331,
		["546"] = 330,
		["547"] = 333,
		["548"] = 334,
		["549"] = 335,
		["550"] = 335,
		["552"] = 333,
		["553"] = 337,
		["554"] = 338,
		["557"] = 339,
		["558"] = 340,
		["559"] = 340,
		["561"] = 341,
		["562"] = 342,
		["565"] = 343,
		["566"] = 344,
		["567"] = 344,
		["569"] = 337,
		["570"] = 256,
		["571"] = 255,
		["572"] = 255,
		["573"] = 255,
		["574"] = 255,
		["575"] = 255,
		["576"] = 255,
		["577"] = 255,
		["578"] = 256,
		["580"] = 256,
		["582"] = 349,
		["583"] = 350,
		["584"] = 349,
		["585"] = 350,
		["586"] = 351,
		["587"] = 351,
		["588"] = 351,
		["589"] = 350,
		["590"] = 349,
		["591"] = 350,
		["593"] = 350,
		["595"] = 355,
		["596"] = 356,
		["597"] = 355,
		["598"] = 356,
		["599"] = 357,
		["600"] = 357,
		["601"] = 357,
		["602"] = 356,
		["603"] = 355,
		["604"] = 356,
		["606"] = 356,
		["607"] = 360,
		["608"] = 361,
		["609"] = 360,
		["610"] = 361,
		["611"] = 362,
		["612"] = 363,
		["613"] = 363,
		["614"] = 363,
		["615"] = 363,
		["616"] = 362,
		["617"] = 365,
		["618"] = 366,
		["621"] = 367,
		["622"] = 368,
		["625"] = 369,
		["626"] = 370,
		["627"] = 370,
		["628"] = 370,
		["629"] = 370,
		["632"] = 371,
		["633"] = 372,
		["634"] = 365,
		["635"] = 361,
		["636"] = 360,
		["637"] = 361,
		["639"] = 361,
		["641"] = 377,
		["642"] = 378,
		["643"] = 377,
		["644"] = 378,
		["645"] = 379,
		["646"] = 379,
		["647"] = 379,
		["648"] = 378,
		["649"] = 377,
		["650"] = 378,
		["652"] = 378,
		["653"] = 382,
		["654"] = 383,
		["655"] = 382,
		["656"] = 383,
		["658"] = 383,
		["659"] = 384,
		["660"] = 385,
		["661"] = 386,
		["662"] = 382,
		["663"] = 387,
		["664"] = 388,
		["665"] = 388,
		["666"] = 390,
		["667"] = 390,
		["668"] = 390,
		["669"] = 388,
		["670"] = 388,
		["671"] = 387,
		["672"] = 393,
		["673"] = 393,
		["674"] = 393,
		["675"] = 393,
		["676"] = 393,
		["677"] = 394,
		["678"] = 394,
		["679"] = 394,
		["680"] = 394,
		["681"] = 395,
		["682"] = 395,
		["683"] = 395,
		["684"] = 396,
		["685"] = 398,
		["686"] = 398,
		["687"] = 398,
		["688"] = 398,
		["689"] = 396,
		["690"] = 400,
		["691"] = 401,
		["692"] = 402,
		["693"] = 402,
		["695"] = 403,
		["696"] = 403,
		["698"] = 404,
		["699"] = 406,
		["700"] = 406,
		["702"] = 407,
		["703"] = 408,
		["704"] = 408,
		["705"] = 408,
		["706"] = 408,
		["707"] = 408,
		["708"] = 408,
		["709"] = 409,
		["710"] = 410,
		["711"] = 412,
		["713"] = 414,
		["714"] = 415,
		["715"] = 415,
		["717"] = 416,
		["718"] = 417,
		["719"] = 418,
		["720"] = 419,
		["721"] = 420,
		["722"] = 421,
		["723"] = 422,
		["724"] = 422,
		["725"] = 422,
		["726"] = 423,
		["727"] = 423,
		["728"] = 423,
		["729"] = 423,
		["732"] = 424,
		["733"] = 425,
		["734"] = 426,
		["735"] = 426,
		["737"] = 422,
		["738"] = 422,
		["740"] = 429,
		["741"] = 400,
		["742"] = 383,
		["743"] = 382,
		["744"] = 383,
		["746"] = 383,
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
local q = require("abilities.interact_ability")
local r = q.InteractAbility
local s = q.registerInteractAbility
local t = "models/eom/hero/marina_1/marina_1_morph.vmdl"
local u = 1
local v = 60
local w = 80
g.yang_jian_talent = c()
local x = g.yang_jian_talent
x.name = "yang_jian_talent"
d(x, i)
function x.prototype.GetIntrinsicModifierName(self)
	return "modifier_yang_jian_talent"
end
function x.prototype.HeavenlyEye(self, y, z)
	if y == nil then
		y = 1
	end
	if z == nil then
		z = false
	end
	local A = self:GetCaster()
	local B = A:GetEnemy()
	if not IsInjurable(A, B) then
		return
	end
	local C = A:FindAbilityByName("yang_jian_interact")
	local D = IsValid(C) and C:IsUnlocked() and C:GetToggleState()
	if z and D then
		local E = A:FindModifierByName("modifier_yang_jian_insight")
		if IsValid(E) then
			E:SetStackCount(0)
		end
	end
	local F = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_lina/lina_spell_laguna_blade.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		A
	)
	ParticleManager:SetParticleControlEnt(F, 0, A, PATTACH_POINT_FOLLOW, "attach_hitloc", A:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(F, 1, B, PATTACH_POINT_FOLLOW, "attach_hitloc", B:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(F)
	A:EmitSound("Hero_Lina.LagunaBladeImpact")
	local G = D and C:GetSpecialValueFor("talent_damge_bonus") or 0
	local H = (A:GetMaxHealth() * self:GetSpecialValueFor("damage_health_pct") * 0.01 + G) * y
	A:DealDamage(B, self, H, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
end
x = e({ j(nil) }, x)
g.yang_jian_talent = x
g.modifier_yang_jian_talent = c()
local I = g.modifier_yang_jian_talent
I.name = "modifier_yang_jian_talent"
d(I, l)
function I.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.lostHealth = 0
	self.eyeUsed = false
	self.battling = false
	self.manaTick = 0
end
function I.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function I.prototype.OnBattleStartBefore(self)
	self:StopDamageHook()
	self.battling = false
	self.lostHealth = 0
	self.eyeUsed = false
	self.manaTick = 0
	local J = self:GetParent()
	J:RemoveModifierByName("modifier_yang_jian_transformation")
	J:RemoveModifierByName("modifier_yang_jian_invulnerable")
	local K = J:FindAbilityByName("yang_jian_ult")
	if IsValid(K) then
		K.combo = 0
		J:AddNewModifier(J, K, "modifier_yang_jian_insight", {}):SetStackCount(0)
	end
end
function I.prototype.OnBattleStart(self)
	self.battling = true
	self:StartIntervalThink(0.1)
	self:StopDamageHook()
	self.hookID = self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE, function(L, M, N, B)
		if B == self:GetParent() then
			self:OnCustomTakeDamage(M)
		end
		if N == self:GetParent() and M.ability == self:GetAbility() then
			local C = N:FindAbilityByName("yang_jian_interact")
			if IsInjurable(N) and IsValid(C) and C:IsUnlocked() and C:GetToggleState() then
				Heal(
					N,
					M.damage * C:GetSpecialValueFor("tian_reply_health_pct") * 0.01,
					self:GetAbility():GetAbilityName(),
					"Ability"
				)
			end
		end
	end)
end
function I.prototype.StopDamageHook(self)
	if self.hookID ~= nil then
		self:unhook(self.hookID)
		self.hookID = nil
	end
end
function I.prototype.OnDestroy(self)
	if IsServer() then
		self:StopDamageHook()
	end
end
function I.prototype.OnBattleEnd(self)
	self.battling = false
	self:StopDamageHook()
	self:StartIntervalThink(-1)
	self:GetParent():RemoveModifierByName("modifier_yang_jian_transformation")
	self:GetParent():RemoveModifierByName("modifier_yang_jian_invulnerable")
	local E = self:GetParent():FindModifierByName("modifier_yang_jian_insight")
	if IsValid(E) then
		E:SetStackCount(0)
	end
end
function I.prototype.OnIntervalThink(self)
	local J = self:GetParent()
	if not self.battling or not IsInjurable(J) then
		return
	end
	self.manaTick = self.manaTick + 1
	if self.manaTick >= 10 then
		self.manaTick = 0
		if not J:PassivesDisabled() then
			RestoreCustomMana(
				J,
				self:GetAbilitySpecialValueFor("base_mana")
					+ math.floor(J:GetMaxHealth() / math.max(1, self:GetAbilitySpecialValueFor("health_base")))
						* self:GetAbilitySpecialValueFor("base_mana_add")
			)
		end
	end
	if J:PassivesDisabled() then
		return
	end
	self:TryHeavenlyEye(J:GetHealth())
end
function I.prototype.OnCustomTakeDamage(self, M)
	local J = self:GetParent()
	if not self.battling or not IsInjurable(J) or J:PassivesDisabled() then
		return
	end
	self.lostHealth = self.lostHealth + math.max(0, math.min(M.damage, M.original_health - J:GetHealth()))
	local O = self:GetAbilitySpecialValueFor("health_loss")
	if O > 0 and self.lostHealth >= O then
		local P = math.floor(self.lostHealth / O)
		self.lostHealth = self.lostHealth - P * O
		RestoreCustomMana(J, P * self:GetAbilitySpecialValueFor("mana_add_once"))
	end
	self:TryHeavenlyEye(J:GetHealth())
end
function I.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_AVOID_DAMAGE }
end
function I.prototype.EOM_GetModifierAvoidDamage(self, Q)
	local J = self:GetParent()
	if not self.battling or J:PassivesDisabled() then
		return 0
	end
	local R = J:FindModifierByName("modifier_yang_jian_talent_5")
	if IsValid(R) and R:TryProtect(Q) then
		return 1
	end
	if Q.damage >= J:GetHealth() then
		self:TryHeavenlyEye(J:GetHealth() - Q.damage)
	end
	return 0
end
function I.prototype.TryHeavenlyEye(self, S)
	local J = self:GetParent()
	local T = J:FindModifierByName("modifier_sect_health")
	if
		not self.battling
		or self.eyeUsed
		or J:PassivesDisabled()
		or not IsInjurable(J, J:GetEnemy())
		or IsValid(T) and T.sr_respawn_enable
	then
		return
	end
	if S >= J:GetMaxHealth() * self:GetAbilitySpecialValueFor("health_pct") * 0.01 then
		return
	end
	self.eyeUsed = true
	self:GetAbility():HeavenlyEye(1, true)
end
I = e({ m(a, { IsHidden = true, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }) }, I)
g.modifier_yang_jian_talent = I
g.yang_jian_ult = c()
local U = g.yang_jian_ult
U.name = "yang_jian_ult"
d(U, o)
function U.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.combo = 0
end
function U.prototype.OnSpellStart(self)
	self:Strike(self:GetCaster():GetEnemy())
end
function U.prototype.Strike(self, B)
	local A = self:GetCaster()
	if not IsInjurable(A, B) then
		return
	end
	local V = self.combo
	self.combo = (V + 1) % 3
	local H = self:GetSpecialValueFor("pi_damage")
	local W = self:GetSpecialValueFor("pi_point")
	local X = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
	if V == 1 then
		H = self:GetSpecialValueFor("ci_damge_base") + B:GetHealth() * self:GetSpecialValueFor("ci_damage_pct") * 0.01
		W = self:GetSpecialValueFor("ci_point")
	elseif V == 2 then
		H = self:GetSpecialValueFor("sao_damage_base")
			+ A:GetMaxHealth() * self:GetSpecialValueFor("sao_damage_pct") * 0.01
		W = self:GetSpecialValueFor("sao_point")
		X = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE
	end
	A:ForcePlayActivityOnce(ACT_DOTA_ATTACK)
	local Y = A:FindModifierByName("modifier_yang_jian_transformation")
	if IsValid(Y) then
		Y:PlayAvatarAttack()
	end
	local F = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_monkey_king/monkey_king_strike_hit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		B
	)
	ParticleManager:ReleaseParticleIndex(F)
	A:EmitSound("Hero_MonkeyKing.Strike.Impact")
	A:DealDamage(B, self, H, X)
	if not IsInjurable(A) then
		return
	end
	local E = A:AddNewModifier(A, self, "modifier_yang_jian_insight", {})
	E:AddInsight(W)
end
U = e({ p(nil) }, U)
g.yang_jian_ult = U
g.modifier_yang_jian_insight = c()
local Z = g.modifier_yang_jian_insight
Z.name = "modifier_yang_jian_insight"
d(Z, l)
function Z.prototype.AddInsight(self, P)
	self:SetStackCount(math.min(self:GetAbilitySpecialValueFor("point_limit"), self:GetStackCount() + P))
	local J = self:GetParent()
	if
		self:HasTalent("yang_jian_talent_4")
		and self:PRD(self:GetAbilityTalentValue("yang_jian_talent_4", "chance"), "yang_jian_talent_4")
	then
		local _ = J:FindModifierByName("modifier_yang_jian_invulnerable")
		local a0 = math.max(
			self:GetAbilityTalentValue("yang_jian_talent_4", "invincible_duration"),
			IsValid(_) and _:GetRemainingTime() or 0
		)
		J:AddNewModifier(J, self:GetAbility(), "modifier_yang_jian_invulnerable", { duration = a0 })
	end
	if self:HasTalent("yang_jian_talent_6") then
		local z = J:FindAbilityByName("yang_jian_talent")
		if IsValid(z) then
			z:HeavenlyEye(self:GetAbilityTalentValue("yang_jian_talent_6", "chance") * 0.01)
		end
	end
	self:TryTransform()
end
function Z.prototype.TryTransform(self)
	local J = self:GetParent()
	local C = J:FindAbilityByName("yang_jian_interact")
	if
		not IsValid(C)
		or not C:IsUnlocked()
		or C:GetToggleState()
		or J:HasModifier("modifier_yang_jian_transformation")
	then
		return
	end
	if self:GetStackCount() >= C:GetSpecialValueFor("fa_point_stack") then
		J:AddNewModifier(J, C, "modifier_yang_jian_transformation", { duration = C:GetSpecialValueFor("fa_duration") })
	end
end
function Z.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_SUREHIT_CHANCE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end
function Z.prototype.EOM_GetModifierSurehitChance(self)
	return self:GetStackCount() * self:GetAbilitySpecialValueFor("point_hit_rate")
end
function Z.prototype.EOM_GetModifierIncomingDamagePercentage(self)
	return -self:GetStackCount() * self:GetAbilitySpecialValueFor("point_damage_reduce_pct")
end
Z = e({ m(a, { IsHidden = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }) }, Z)
g.modifier_yang_jian_insight = Z
g.yang_jian_interact = c()
local a1 = g.yang_jian_interact
a1.name = "yang_jian_interact"
d(a1, r)
function a1.prototype.GetAbilityTextureName(self)
	local a2 = self:GetCaster():GetPlayerOwnerID()
	local a3
	if IsServer() then
		local a4 = PlayerData:getplayerData(a2)
		a3 = a4 and a4:GetInteractiveAbilityState()
	else
		local a5 = CustomNetTables:GetTableValue("player_data", tostring(a2))
		a3 = a5 and a5.interAbilityState
	end
	local a6 = a3
	local a7
	if a6 == nil then
		a7 = self:GetToggleState()
	else
		a7 = a6 == true or a6 == 1
	end
	local a8 = a7
	return a8 and "lina_laguna_blade" or "monkey_king_wukongs_command"
end
function a1.prototype.GetIntrinsicModifierName(self)
	return "modifier_yang_jian_interact"
end
function a1.prototype.IsUnlocked(self)
	return self:HasTalent("yang_jian_talent_1") or self:HasTalent("yang_jian_talent_2")
end
function a1.prototype.CustomToggleEnable(self)
	return self:IsUnlocked() and r.prototype.CustomToggleEnable(self)
end
function a1.prototype.OnSpellStart(self)
	self:RestoreToggleState()
end
function a1.prototype.RestoreToggleState(self)
	if not IsServer() or not self:IsUnlocked() then
		return
	end
	local a9 = PlayerData:getplayerData(self:GetCaster():GetPlayerOwnerID())
	if a9 and self:GetToggleState() ~= a9:GetInteractiveAbilityState() then
		self:ToggleAbility()
	end
end
a1 = e({ s(nil, { InactiveTextureName = "monkey_king_wukongs_command", ActiveTextureName = "lina_laguna_blade" }) }, a1)
g.yang_jian_interact = a1
g.modifier_yang_jian_interact = c()
local aa = g.modifier_yang_jian_interact
aa.name = "modifier_yang_jian_interact"
d(aa, l)
function aa.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:OnIntervalThink()
	self:StartIntervalThink(0.1)
end
function aa.prototype.OnIntervalThink(self)
	local ab = self:GetAbility()
	if not IsValid(ab) then
		return
	end
	local ac = ab:IsUnlocked()
	if ab:IsActivated() ~= ac then
		ab:SetActivated(ac)
	end
	ab:RestoreToggleState()
end
aa = e({ m(a, { IsHidden = true, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }) }, aa)
g.modifier_yang_jian_interact = aa
g.modifier_yang_jian_transformation = c()
local ad = g.modifier_yang_jian_transformation
ad.name = "modifier_yang_jian_transformation"
d(ad, l)
function ad.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:CreateAvatar("ACT_DOTA_IDLE_RARE")
	self:StartIntervalThink(FrameTime())
	if self:HasTalent("yang_jian_talent_3") then
		AddShield(
			self:GetParent(),
			self:GetAbilityTalentValue("yang_jian_talent_3", "shield_count"),
			"yang_jian_talent_3",
			"Ability"
		)
	end
end
function ad.prototype.GetAvatarPosition(self)
	local J = self:GetParent()
	return J:GetAbsOrigin() + J:GetForwardVector() * -v + Vector(0, 0, w)
end
function ad.prototype.CreateAvatar(self, ae)
	if not IsServer() then
		return
	end
	local J = self:GetParent()
	local y = J:GetModelScale() * u
	local af = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{
			model = t,
			origin = self:GetAvatarPosition(),
			angles = VectorToAngles(J:GetForwardVector()),
			scales = (((tostring(y) .. " ") .. tostring(y)) .. " ") .. tostring(y),
			StartingAnim = ae,
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
			DefaultAnim = "ACT_DOTA_IDLE_RARE",
			AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			use_animgraph = "1",
			solid = "0",
		}
	)
	if not IsValid(af) then
		return
	end
	if IsValid(self.avatar) then
		UTIL_Remove(self.avatar)
	end
	self.avatar = af
end
function ad.prototype.PlayAvatarAttack(self)
	self:CreateAvatar("ACT_DOTA_ATTACK")
end
function ad.prototype.SyncAvatar(self)
	if not IsServer() or not IsValid(self.avatar) then
		return
	end
	self.avatar:SetAbsOrigin(self:GetAvatarPosition())
	self.avatar:SetForwardVector(self:GetParent():GetForwardVector())
end
function ad.prototype.OnIntervalThink(self)
	if not IsValid(self:GetParent()) or not self:GetParent():IsAlive() then
		self:Destroy()
		return
	end
	self:SyncAvatar()
end
function ad.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS_PERCENTAGE] = self:GetAbilitySpecialValueFor(
			"fa_max_health_pct"
		),
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self:GetAbilitySpecialValueFor(
			"fa_attack_speed"
		),
	}
end
function ad.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE }
end
function ad.prototype.GetModifierModelScale(self)
	return 30
end
function ad.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_FAKE_ATTACK] = true }
end
function ad.prototype.CheckState(self)
	if not self:HasTalent("yang_jian_talent_3") then
		return {}
	end
	return {
		[MODIFIER_STATE_STUNNED] = false,
		[MODIFIER_STATE_HEXED] = false,
		[MODIFIER_STATE_ROOTED] = false,
		[MODIFIER_STATE_SILENCED] = false,
		[MODIFIER_STATE_DISARMED] = false,
		[MODIFIER_STATE_FEARED] = false,
		[MODIFIER_STATE_TAUNTED] = false,
		[MODIFIER_STATE_PASSIVES_DISABLED] = false,
		[MODIFIER_STATE_MUTED] = false,
	}
end
function ad.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_FAKE_ATTACK] = { self:GetParent(), -1 } }
end
function ad.prototype.OnFakeAttack(self, M)
	local K = self:GetParent():FindAbilityByName("yang_jian_ult")
	if IsValid(K) then
		K:Strike(self:GetParent():GetEnemy())
	end
end
function ad.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	if IsValid(self.avatar) then
		UTIL_Remove(self.avatar)
	end
	self.avatar = nil
	if not IsValid(self:GetParent()) then
		return
	end
	local E = self:GetParent():FindModifierByName("modifier_yang_jian_insight")
	if IsValid(E) then
		E:SetStackCount(0)
	end
end
ad = e(
	{
		m(
			a,
			{
				IsHidden = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_SUPER_ULTRA,
			}
		),
	},
	ad
)
g.modifier_yang_jian_transformation = ad
g.modifier_yang_jian_invulnerable = c()
local ag = g.modifier_yang_jian_invulnerable
ag.name = "modifier_yang_jian_invulnerable"
d(ag, l)
function ag.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
ag = e({ m(a, { IsHidden = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }) }, ag)
g.modifier_yang_jian_invulnerable = ag
g.yang_jian_shard = c()
local ah = g.yang_jian_shard
ah.name = "yang_jian_shard"
d(ah, i)
function ah.prototype.GetIntrinsicModifierName(self)
	return "modifier_yang_jian_shard"
end
ah = e({ j(nil) }, ah)
g.yang_jian_shard = ah
g.modifier_yang_jian_shard = c()
local ai = g.modifier_yang_jian_shard
ai.name = "modifier_yang_jian_shard"
d(ai, l)
function ai.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self:GetParent(), -1 } }
end
function ai.prototype.OnEvasion(self)
	if not IsServer() then
		return
	end
	local J = self:GetParent()
	if not IsInjurable(J) or J:PassivesDisabled() then
		return
	end
	local K = J:FindAbilityByName("yang_jian_ult")
	if not IsValid(K) or not self:PRD(self:GetAbilitySpecialValueFor("chance"), "yang_jian_shard") then
		return
	end
	local E = J:AddNewModifier(J, K, "modifier_yang_jian_insight", {})
	E:AddInsight(self:GetAbilitySpecialValueFor("count"))
end
ai = e({ m(a, { IsHidden = true, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }) }, ai)
g.modifier_yang_jian_shard = ai
g.yang_jian_talent_5 = c()
local aj = g.yang_jian_talent_5
aj.name = "yang_jian_talent_5"
d(aj, i)
function aj.prototype.GetIntrinsicModifierName(self)
	return "modifier_yang_jian_talent_5"
end
aj = e({ j(nil) }, aj)
g.yang_jian_talent_5 = aj
g.modifier_yang_jian_talent_5 = c()
local ak = g.modifier_yang_jian_talent_5
ak.name = "modifier_yang_jian_talent_5"
d(ak, l)
function ak.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.used = false
	self.battling = false
	self.battleId = 0
end
function ak.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function ak.prototype.OnBattleStartBefore(self)
	self.used = false
	self.battling = true
	self.battleId = self.battleId + 1
end
function ak.prototype.OnBattleEnd(self)
	self.battling = false
	self.battleId = self.battleId + 1
end
function ak.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_CONSTANT }
end
function ak.prototype.EOM_GetModifierOutgoingDamageConstant(self)
	return GetSectHealthModifiedValue(self:GetParent(), self:GetSectSpecialValueFor("197", "sr_197_health"))
end
function ak.prototype.TryProtect(self, Q)
	local J = self:GetParent()
	if not self.battling or self.used or J:PassivesDisabled() or Q.damage < J:GetHealth() then
		return false
	end
	if bit.band(Q.damage_flags, DamageFlags.DAMAGE_FLAG_NO_LETHAL) ~= 0 or J:HasModifier("modifier_sect_regen_143") then
		return false
	end
	local S = J:FindModifierByName("modifier_sect_health")
	if IsValid(S) and S.sr_respawn_enable then
		return false
	end
	self.used = true
	J:AddNewModifier(
		J,
		self:GetAbility(),
		"modifier_yang_jian_invulnerable",
		{ duration = self:GetAbilitySpecialValueFor("invincible_duration") }
	)
	J:SetHealth(1)
	if IsValid(S) and S.sr_58_health_pct > 0 then
		S.sr_respawn_enable = true
	end
	local z = J:FindModifierByName("modifier_yang_jian_talent")
	if IsValid(z) then
		z:TryHeavenlyEye(J:GetHealth())
	end
	local al = J:FindAbilityByName("sect_health")
	if IsValid(al) and self:GetSectSpecialValueFor("153", "sr_153_interval") > 0 then
		local P = self:GetAbilitySpecialValueFor("gu_damage_count")
		local am = self:GetAbilitySpecialValueFor("gu_duration") / math.max(1, P)
		local an = self.battleId
		local ao = P
		J:GameTimer(am, function()
			if
				not IsValid(self)
				or not self.battling
				or self.battleId ~= an
				or not IsValid(al)
				or not IsInjurable(J, J:GetEnemy())
			then
				return
			end
			al:TriggerByName("153")
			ao = ao - 1
			if ao > 0 then
				return am
			end
		end)
	end
	return true
end
ak = e({ m(a, { IsHidden = true, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }) }, ak)
g.modifier_yang_jian_talent_5 = ak
return g