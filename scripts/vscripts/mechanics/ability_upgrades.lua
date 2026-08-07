--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/ability_upgrades"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringReplaceAll
local f = b.__TS__StringSplit
local g = b.__TS__ArrayForEach
local h = b.__TS__Delete
local i = b.__TS__Number
local j = b.__TS__NumberIsFinite
local k = b.__TS__ArraySplice
local l = b.__TS__DecorateLegacy
local m = b.__TS__New
local n = b.__TS__SourceMapTraceBack
n(
	debug.getinfo(1).short_src,
	{
		["16"] = 1,
		["17"] = 1,
		["18"] = 31,
		["19"] = 31,
		["20"] = 32,
		["22"] = 32,
		["23"] = 33,
		["24"] = 36,
		["25"] = 38,
		["26"] = 38,
		["27"] = 38,
		["28"] = 38,
		["29"] = 38,
		["30"] = 38,
		["31"] = 38,
		["32"] = 38,
		["33"] = 38,
		["34"] = 38,
		["35"] = 38,
		["36"] = 38,
		["37"] = 38,
		["38"] = 38,
		["39"] = 38,
		["40"] = 38,
		["41"] = 38,
		["42"] = 38,
		["43"] = 38,
		["44"] = 38,
		["45"] = 38,
		["46"] = 38,
		["47"] = 67,
		["48"] = 73,
		["49"] = 73,
		["50"] = 73,
		["51"] = 73,
		["52"] = 73,
		["53"] = 73,
		["54"] = 73,
		["55"] = 73,
		["56"] = 73,
		["57"] = 73,
		["58"] = 73,
		["59"] = 73,
		["60"] = 73,
		["61"] = 73,
		["62"] = 73,
		["63"] = 73,
		["64"] = 73,
		["65"] = 73,
		["66"] = 73,
		["67"] = 73,
		["68"] = 73,
		["69"] = 94,
		["70"] = 94,
		["71"] = 94,
		["72"] = 94,
		["73"] = 94,
		["74"] = 94,
		["75"] = 94,
		["76"] = 94,
		["77"] = 94,
		["78"] = 94,
		["79"] = 94,
		["80"] = 94,
		["81"] = 31,
		["82"] = 111,
		["83"] = 112,
		["84"] = 113,
		["85"] = 114,
		["86"] = 115,
		["89"] = 118,
		["90"] = 119,
		["92"] = 121,
		["93"] = 121,
		["94"] = 121,
		["95"] = 121,
		["96"] = 121,
		["97"] = 121,
		["98"] = 121,
		["100"] = 111,
		["101"] = 125,
		["102"] = 126,
		["103"] = 129,
		["104"] = 130,
		["105"] = 131,
		["106"] = 132,
		["108"] = 135,
		["109"] = 136,
		["111"] = 138,
		["112"] = 125,
		["113"] = 142,
		["114"] = 143,
		["115"] = 144,
		["116"] = 145,
		["117"] = 146,
		["118"] = 146,
		["119"] = 146,
		["120"] = 146,
		["121"] = 146,
		["122"] = 147,
		["123"] = 147,
		["124"] = 147,
		["125"] = 147,
		["126"] = 147,
		["128"] = 149,
		["129"] = 150,
		["130"] = 151,
		["131"] = 152,
		["132"] = 152,
		["133"] = 152,
		["134"] = 152,
		["135"] = 152,
		["136"] = 153,
		["137"] = 154,
		["138"] = 154,
		["139"] = 154,
		["140"] = 154,
		["141"] = 154,
		["143"] = 156,
		["145"] = 142,
		["146"] = 161,
		["147"] = 162,
		["148"] = 164,
		["149"] = 165,
		["150"] = 165,
		["151"] = 165,
		["152"] = 165,
		["153"] = 165,
		["154"] = 165,
		["155"] = 165,
		["157"] = 167,
		["158"] = 161,
		["159"] = 171,
		["160"] = 172,
		["161"] = 174,
		["162"] = 175,
		["163"] = 175,
		["164"] = 175,
		["165"] = 175,
		["166"] = 175,
		["167"] = 175,
		["168"] = 175,
		["170"] = 177,
		["171"] = 171,
		["172"] = 180,
		["173"] = 184,
		["174"] = 185,
		["175"] = 186,
		["177"] = 188,
		["178"] = 189,
		["180"] = 191,
		["181"] = 192,
		["182"] = 193,
		["183"] = 193,
		["184"] = 193,
		["185"] = 193,
		["186"] = 194,
		["189"] = 197,
		["190"] = 198,
		["192"] = 200,
		["195"] = 203,
		["196"] = 180,
		["197"] = 219,
		["198"] = 220,
		["199"] = 222,
		["200"] = 222,
		["202"] = 223,
		["203"] = 223,
		["205"] = 224,
		["206"] = 224,
		["208"] = 225,
		["209"] = 225,
		["211"] = 227,
		["212"] = 229,
		["213"] = 230,
		["214"] = 232,
		["215"] = 232,
		["216"] = 233,
		["217"] = 233,
		["218"] = 235,
		["219"] = 235,
		["220"] = 235,
		["221"] = 235,
		["222"] = 235,
		["223"] = 235,
		["224"] = 235,
		["225"] = 237,
		["226"] = 239,
		["227"] = 219,
		["228"] = 242,
		["229"] = 243,
		["230"] = 245,
		["231"] = 245,
		["233"] = 246,
		["234"] = 246,
		["236"] = 247,
		["237"] = 247,
		["239"] = 248,
		["240"] = 248,
		["242"] = 250,
		["243"] = 252,
		["244"] = 253,
		["245"] = 254,
		["246"] = 255,
		["247"] = 255,
		["248"] = 255,
		["249"] = 255,
		["250"] = 255,
		["251"] = 255,
		["252"] = 255,
		["253"] = 257,
		["254"] = 259,
		["255"] = 242,
		["256"] = 262,
		["257"] = 263,
		["258"] = 265,
		["259"] = 266,
		["260"] = 267,
		["261"] = 267,
		["263"] = 268,
		["264"] = 268,
		["266"] = 269,
		["267"] = 269,
		["269"] = 270,
		["270"] = 270,
		["272"] = 271,
		["273"] = 271,
		["275"] = 273,
		["276"] = 274,
		["277"] = 276,
		["278"] = 276,
		["279"] = 276,
		["280"] = 276,
		["281"] = 276,
		["282"] = 276,
		["283"] = 276,
		["284"] = 278,
		["285"] = 280,
		["286"] = 262,
		["287"] = 282,
		["288"] = 283,
		["289"] = 285,
		["290"] = 285,
		["292"] = 286,
		["293"] = 286,
		["295"] = 288,
		["296"] = 290,
		["297"] = 292,
		["298"] = 293,
		["299"] = 294,
		["300"] = 295,
		["301"] = 296,
		["302"] = 297,
		["303"] = 298,
		["304"] = 299,
		["308"] = 303,
		["309"] = 282,
		["310"] = 305,
		["311"] = 307,
		["312"] = 307,
		["313"] = 307,
		["314"] = 307,
		["315"] = 308,
		["316"] = 309,
		["317"] = 305,
		["318"] = 311,
		["319"] = 312,
		["320"] = 311,
		["321"] = 317,
		["322"] = 318,
		["323"] = 319,
		["324"] = 320,
		["326"] = 322,
		["327"] = 327,
		["328"] = 328,
		["330"] = 330,
		["332"] = 332,
		["333"] = 333,
		["335"] = 335,
		["336"] = 317,
		["337"] = 338,
		["338"] = 339,
		["339"] = 340,
		["340"] = 341,
		["342"] = 343,
		["343"] = 344,
		["345"] = 346,
		["346"] = 338,
		["347"] = 349,
		["348"] = 350,
		["349"] = 351,
		["350"] = 352,
		["352"] = 354,
		["353"] = 359,
		["354"] = 360,
		["356"] = 362,
		["358"] = 364,
		["359"] = 349,
		["360"] = 385,
		["361"] = 385,
		["362"] = 385,
		["364"] = 386,
		["365"] = 388,
		["366"] = 388,
		["368"] = 389,
		["369"] = 389,
		["371"] = 390,
		["372"] = 390,
		["374"] = 391,
		["375"] = 391,
		["377"] = 393,
		["378"] = 394,
		["379"] = 395,
		["380"] = 395,
		["381"] = 396,
		["382"] = 396,
		["383"] = 397,
		["384"] = 398,
		["385"] = 399,
		["387"] = 401,
		["388"] = 401,
		["390"] = 403,
		["391"] = 405,
		["392"] = 406,
		["393"] = 407,
		["394"] = 408,
		["396"] = 410,
		["397"] = 412,
		["398"] = 413,
		["399"] = 414,
		["400"] = 415,
		["401"] = 416,
		["402"] = 419,
		["403"] = 420,
		["404"] = 420,
		["405"] = 421,
		["406"] = 422,
		["407"] = 423,
		["408"] = 424,
		["409"] = 424,
		["410"] = 424,
		["411"] = 424,
		["413"] = 424,
		["414"] = 424,
		["415"] = 424,
		["416"] = 424,
		["418"] = 426,
		["419"] = 427,
		["420"] = 428,
		["421"] = 429,
		["422"] = 430,
		["423"] = 431,
		["424"] = 431,
		["425"] = 432,
		["426"] = 433,
		["427"] = 434,
		["428"] = 435,
		["429"] = 435,
		["430"] = 435,
		["431"] = 435,
		["433"] = 435,
		["434"] = 435,
		["435"] = 435,
		["436"] = 435,
		["440"] = 440,
		["444"] = 444,
		["447"] = 448,
		["448"] = 450,
		["449"] = 452,
		["450"] = 385,
		["451"] = 454,
		["452"] = 454,
		["453"] = 454,
		["455"] = 455,
		["456"] = 457,
		["457"] = 457,
		["459"] = 458,
		["460"] = 458,
		["462"] = 459,
		["463"] = 459,
		["465"] = 461,
		["466"] = 461,
		["468"] = 463,
		["469"] = 464,
		["470"] = 465,
		["471"] = 466,
		["473"] = 468,
		["474"] = 469,
		["475"] = 469,
		["476"] = 471,
		["478"] = 471,
		["480"] = 471,
		["482"] = 474,
		["483"] = 476,
		["484"] = 454,
		["485"] = 479,
		["486"] = 480,
		["487"] = 479,
		["488"] = 483,
		["489"] = 484,
		["490"] = 486,
		["491"] = 487,
		["492"] = 488,
		["493"] = 488,
		["495"] = 489,
		["496"] = 489,
		["498"] = 490,
		["499"] = 490,
		["501"] = 491,
		["502"] = 491,
		["504"] = 492,
		["505"] = 492,
		["507"] = 494,
		["508"] = 495,
		["509"] = 496,
		["510"] = 496,
		["511"] = 497,
		["513"] = 497,
		["515"] = 497,
		["517"] = 500,
		["518"] = 502,
		["519"] = 483,
		["520"] = 504,
		["521"] = 505,
		["522"] = 505,
		["523"] = 505,
		["524"] = 505,
		["525"] = 504,
		["526"] = 507,
		["527"] = 509,
		["528"] = 509,
		["529"] = 509,
		["530"] = 510,
		["531"] = 511,
		["532"] = 512,
		["533"] = 513,
		["534"] = 514,
		["535"] = 515,
		["540"] = 507,
		["541"] = 522,
		["542"] = 525,
		["543"] = 525,
		["544"] = 525,
		["545"] = 526,
		["546"] = 527,
		["547"] = 528,
		["548"] = 529,
		["549"] = 530,
		["550"] = 531,
		["551"] = 532,
		["552"] = 533,
		["553"] = 534,
		["554"] = 535,
		["555"] = 536,
		["556"] = 537,
		["557"] = 538,
		["558"] = 539,
		["560"] = 541,
		["567"] = 522,
		["568"] = 551,
		["569"] = 552,
		["570"] = 553,
		["571"] = 554,
		["572"] = 555,
		["573"] = 556,
		["574"] = 557,
		["575"] = 558,
		["576"] = 559,
		["577"] = 560,
		["579"] = 561,
		["580"] = 561,
		["581"] = 562,
		["582"] = 562,
		["583"] = 561,
		["589"] = 551,
		["590"] = 568,
		["591"] = 569,
		["592"] = 570,
		["593"] = 571,
		["594"] = 572,
		["596"] = 573,
		["597"] = 573,
		["598"] = 574,
		["599"] = 574,
		["600"] = 573,
		["603"] = 568,
		["604"] = 578,
		["605"] = 579,
		["606"] = 580,
		["607"] = 581,
		["608"] = 582,
		["610"] = 583,
		["611"] = 583,
		["612"] = 584,
		["613"] = 583,
		["617"] = 587,
		["618"] = 578,
		["619"] = 590,
		["620"] = 591,
		["621"] = 590,
		["622"] = 593,
		["623"] = 594,
		["624"] = 595,
		["625"] = 596,
		["626"] = 597,
		["627"] = 598,
		["628"] = 593,
		["629"] = 31,
		["630"] = 607,
		["631"] = 608,
	}
)
local o = {}
local p = require("lib.tstl-utils")
local q = p.reloadable
local r = c()
r.name = "CAbilityUpgrades"
d(r, CModule)
function r.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.removeRetention = {}
	self.tClientAbilityUpgrades = {}
	self.ABILITY_UPGRADES_STATS_LIST = {
		"bonus_attack_damage",
		"base_attack_damage_pct",
		"bonus_attack_speed",
		"bonus_attack_range",
		"bonus_armor",
		"bonus_move_speed",
		"move_speed_pct",
		"bonus_mana",
		"bonus_mana_regen",
		"bonus_health",
		"bonus_health_regen",
		"max_health_regen_pct",
		"bonus_str",
		"bonus_agi",
		"bonus_int",
		"bonus_stats",
		"bonus_evasion",
		"bonus_cooldown_reduction",
		"bonus_status_resistance",
		"bonus_debuff_amplify",
	}
	self.ABILITY_UPGRADES_STATS_SETTLE = {
		bonus_evasion = SubtractionMultiplicationPercentage,
		bonus_cooldown_reduction = SubtractionMultiplicationPercentage,
		bonus_status_resistance = SubtractionMultiplicationPercentage,
		bonus_debuff_amplify = AdditionMultiplicationPercentage,
	}
	self.aPropertyNames = {
		"LinkedSpecialBonus",
		"LinkedSpecialBonusField",
		"LinkedSpecialBonusOperation",
		"CalculateSpellDamageTooltip",
		"RequiresScepter",
		"levelkey",
		"_str",
		"_int",
		"_agi",
		"_all",
		"_attack_damage",
		"_attack_speed",
		"_health",
		"_armor",
		"_magical_armor",
		"_mana",
		"_max",
		"_min",
		"_move_speed",
	}
	self.zip_list = {
		"type",
		"id",
		"ability_name",
		"value",
		"special_value_name",
		"special_value_property",
		"operator",
		"values",
		"description",
		"level",
	}
end
function r.prototype.init(self, s)
	if IsServer() then
		if not s then
			self.tAbilityUpgrades = {}
			self.tAbilityUpgradesIndexs = {}
		end
	else
		if not s then
			self.tClientAbilityUpgrades = {}
		end
		GameEvent("clear_client_ability_upgrade_cache", function(self, ...)
			return self:OnClearClientAbilityUpgradeCache(...)
		end, self)
	end
end
function r.prototype.zip(self, t)
	local u = { self.zip_list }
	for v, w in ipairs(t) do
		local x = {}
		for y = 0, #self.zip_list - 1, 1 do
			x[y + 1] = w[self.zip_list[y + 1]]
		end
		x.n = #self.zip_list
		u[#u + 1] = x
	end
	return u
end
function r.prototype.UpdateAbilityUpgradesNetTables(self, z, t)
	assert(IsServer())
	if z ~= nil then
		if t == nil then
			CustomNetTables:SetTableValue("ability_upgrades_list", tostring(z), nil)
			CustomNetTables:SetTableValue("ability_upgrades_result", tostring(z), nil)
		else
			local A = t[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1]
			local B = json.encode(self:zip(A))
			B = e(B, "null", "*")
			CustomNetTables:SetTableValue("ability_upgrades_list", tostring(z), { json = B })
			local C = t[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1]
			CustomNetTables:SetTableValue("ability_upgrades_result", tostring(z), { json = json.encode(C) })
		end
		PlayerData:RefreshHeroAbility()
	end
end
function r.prototype.GetAbilityUpgradeTable(self, z)
	assert(IsServer())
	if self.tAbilityUpgrades[z] == nil then
		self.tAbilityUpgrades[z] = { {}, { {}, {}, {}, {}, {} } }
	end
	return self.tAbilityUpgrades[z]
end
function r.prototype.GetAbilityUpgradeIndexs(self, z)
	assert(IsServer())
	if self.tAbilityUpgradesIndexs[z] == nil then
		self.tAbilityUpgradesIndexs[z] = { {}, {}, {}, {}, {} }
	end
	return self.tAbilityUpgradesIndexs[z]
end
function r.prototype.GetCachedResult(self, z)
	local C
	if IsServer() then
		C = self:GetAbilityUpgradeTable(z)[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1]
	else
		if self.tClientAbilityUpgrades[z] == nil then
			self.tClientAbilityUpgrades[z] = {}
		end
		if self.tClientAbilityUpgrades[z][GetFrameCount()] == nil then
			self.tClientAbilityUpgrades[z] = {}
			local x = CustomNetTables:GetTableValue("ability_upgrades_result", tostring(z))
			if (x and x.json) == nil then
				return
			end
			C = json.decode(x.json)
			self.tClientAbilityUpgrades[z][GetFrameCount()] = C
		else
			C = self.tClientAbilityUpgrades[z][GetFrameCount()]
		end
	end
	return C
end
function r.prototype.AddSpecialValueUpgrade(self, z, t)
	assert(IsServer())
	if t.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE then
		return false
	end
	if t.ability_name == nil then
		return false
	end
	if t.special_value_name == nil then
		return false
	end
	if t.value == nil or t.value == 0 then
		return false
	end
	t.operator = t.operator or ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD
	local A = self:GetAbilityUpgradeTable(z)
	local D = self:GetAbilityUpgradeIndexs(z)
	local E = A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1]
	E[#E + 1] = t
	local F = D[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE + 1]
	F[#F + 1] = #A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1] - 1
	self:_UpdateSpecialValueUpgrades(A, D, t.ability_name, t.special_value_name, t.operator)
	self:UpdateAbilityUpgradesNetTables(z, A)
	return true
end
function r.prototype.RemoveSpecialValueUpgrade(self, z, t)
	assert(IsServer())
	if t.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE then
		return false
	end
	if t.ability_name == nil then
		return false
	end
	if t.special_value_name == nil then
		return false
	end
	if t.value == nil or t.value == 0 then
		return false
	end
	t.operator = t.operator or ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD
	local A = self:GetAbilityUpgradeTable(z)
	local D = self:GetAbilityUpgradeIndexs(z)
	self:RemoveAbilityUpgradeDataByID(z, ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE, t.id)
	self:_UpdateSpecialValueUpgrades(A, D, t.ability_name, t.special_value_name, t.operator)
	self:UpdateAbilityUpgradesNetTables(z, A)
	return true
end
function r.prototype.RemoveSpecialValueUpgradeByIndex(self, z, G)
	assert(IsServer())
	local A = self:GetAbilityUpgradeTable(z)
	local t = A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1][G + 1]
	if t == nil then
		return false
	end
	if t.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE then
		return false
	end
	if t.ability_name == nil then
		return false
	end
	if t.special_value_name == nil then
		return false
	end
	if t.value == nil or t.value == 0 then
		return false
	end
	local D = self:GetAbilityUpgradeIndexs(z)
	self:RemoveAbilityUpgradeDataByIndex(z, ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE, G)
	self:_UpdateSpecialValueUpgrades(A, D, t.ability_name, t.special_value_name, t.operator)
	self:UpdateAbilityUpgradesNetTables(z, A)
	return true
end
function r.prototype._UpdateSpecialValueUpgrades(self, A, D, H, I, J)
	local K =
		A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1][ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE + 1]
	if K[H] == nil then
		K[H] = {}
	end
	if K[H][I] == nil then
		K[H][I] = {}
	end
	local L = K[H][I]
	local M = 0
	for N = 0, #D[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE + 1] - 1, 1 do
		local O = D[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE + 1][N + 1]
		local P = A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1][O + 1]
		if P ~= nil and P.ability_name == H and P.special_value_name == I and P.operator == J then
			if J == ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD then
				M = M + P.value
			elseif J == ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_MUL then
				M = AdditionMultiplicationPercentage(M, P.value)
			end
		end
	end
	L[J] = M
end
function r.prototype.GetSpecialValueUpgrade(self, z, H, I, J)
	local Q = self:GetCachedResult(z)
	local R = Q and Q[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE + 1]
	local S = R and R[H]
	local T = S and S[I]
	local U = T
	return T and T[J] or U and U[tostring(J)] or 0
end
function r.prototype.CalcSpecialValueUpgrade(self, z, H, I, V)
	return (V + self:GetSpecialValueUpgrade(z, H, I, ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD))
		* (1 + self:GetSpecialValueUpgrade(z, H, I, ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_MUL) * 0.01)
end
function r.prototype.AddAbilityMechanicsUpgradeByID(self, z, W, X)
	local Y = KeyValues.AbilityUpgradesMechenicsKV[W]
	if not Y then
		return false
	end
	local t =
		{ id = W, type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS, description = Y.description }
	if X then
		t.ability_name = X
	else
		t.ability_name = Y.ability_name
	end
	if type(Y.AbilityValues) == "table" then
		t.values = Y.AbilityValues
	end
	return self:AddAbilityMechanicsUpgrade(z, t)
end
function r.prototype.HasAbilityMechanicsUpgradeByID(self, z, W, H)
	local Y = KeyValues.AbilityUpgradesMechenicsKV[W]
	if not (Y and Y.description) then
		return false
	end
	if H == nil then
		H = Y.ability_name
	end
	return self:HasAbilityMechanicsUpgrade(z, H, Y.description)
end
function r.prototype.RemoveAbilityMechanicsUpgradeByID(self, z, W, X)
	local Y = KeyValues.AbilityUpgradesMechenicsKV[W]
	if not Y then
		return false
	end
	local t =
		{ id = W, type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS, description = Y.description }
	if X then
		t.ability_name = X
	else
		t.ability_name = Y.ability_name
	end
	return self:RemoveAbilityMechanicsUpgrade(z, t)
end
function r.prototype.AddAbilityMechanicsUpgrade(self, z, t, Z)
	if Z == nil then
		Z = false
	end
	assert(IsServer())
	if t.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS then
		return false
	end
	if t.description == nil then
		return false
	end
	if t.ability_name == nil then
		return false
	end
	if self:HasAbilityMechanicsUpgrade(z, t.ability_name, t.description) then
		return false
	end
	local A = self:GetAbilityUpgradeTable(z)
	local D = self:GetAbilityUpgradeIndexs(z)
	local _ = A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1]
	_[#_ + 1] = t
	local a0 = D[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	a0[#a0 + 1] = #A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1] - 1
	if Z then
		if self.removeRetention[z] == nil then
			self.removeRetention[z] = {}
		end
		local a1 = self.removeRetention[z]
		a1[#a1 + 1] = t
	end
	local a2 =
		A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1][ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	local H = t.ability_name
	local a3 = t.description
	if a2[H] == nil then
		a2[H] = {}
	end
	local a4 = a2[H]
	local a5 = {}
	if type(t.values) == "table" then
		for a6 in pairs(t.values) do
			local w = t.values[a6]
			local x = { value = {} }
			if type(w) == "number" then
				local a7 = x.value
				a7[#a7 + 1] = w
			elseif type(w) == "string" then
				local a8 = f(w, " ")
				if #a8 > 0 then
					g(a8, function(v, a9)
						local aa = x.value
						local ab = #aa + 1
						aa[ab] = toFiniteNumber(a9)
						return ab
					end)
				end
			elseif type(w) == "table" then
				for ac in pairs(w) do
					local a9 = w[ac]
					if ac == "value" then
						if type(a9) == "number" then
							local ad = x.value
							ad[#ad + 1] = a9
						elseif type(a9) == "string" then
							local a8 = f(a9, " ")
							if #a8 > 0 then
								g(a8, function(v, ae)
									local af = x.value
									local ag = #af + 1
									af[ag] = toFiniteNumber(ae)
									return ag
								end)
							end
						end
					else
						x[ac] = a9
					end
				end
			end
			a5[a6] = x
		end
	end
	a4[a3] = a5
	self:UpdateAbilityUpgradesNetTables(z, A)
	return true
end
function r.prototype.RemoveAbilityMechanicsUpgrade(self, z, t, Z)
	if Z == nil then
		Z = false
	end
	assert(IsServer())
	if t.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS then
		return false
	end
	if t.description == nil then
		return false
	end
	if t.ability_name == nil then
		return false
	end
	if not self:HasAbilityMechanicsUpgrade(z, t.ability_name, t.description) then
		return false
	end
	local A = self:GetAbilityUpgradeTable(z)
	self:RemoveAbilityUpgradeDataByID(z, ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS, t.id)
	if Z then
		self:RemoveRemoveRetention(z, t)
	end
	local a2 =
		A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1][ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	local ah = a2[t.ability_name]
	if (ah and ah[t.description]) ~= nil then
		local ai = a2[t.ability_name]
		if ai ~= nil then
			h(ai, t.description)
		end
		local v = true
	end
	self:UpdateAbilityUpgradesNetTables(z, A)
	return true
end
function r.prototype.RemoveRemoveRetention(self, z, t)
	ArrayRemove(self.removeRetention[z], t)
end
function r.prototype.RemoveAbilityMechanicsUpgradeByIndex(self, z, G)
	assert(IsServer())
	local A = self:GetAbilityUpgradeTable(z)
	local t = A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1][G + 1]
	if t == nil then
		return false
	end
	if t.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS then
		return false
	end
	if t.description == nil then
		return false
	end
	if t.ability_name == nil then
		return false
	end
	if not self:HasAbilityMechanicsUpgrade(z, t.ability_name, t.description) then
		return false
	end
	self:RemoveAbilityUpgradeDataByIndex(z, ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS, G)
	local a2 =
		A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1][ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	local aj = a2[t.ability_name]
	if (aj and aj[t.description]) ~= nil then
		local ak = a2[t.ability_name]
		if ak ~= nil then
			h(ak, t.description)
		end
		local v = true
	end
	self:UpdateAbilityUpgradesNetTables(z, A)
	return true
end
function r.prototype.HasAbilityMechanicsUpgrade(self, z, H, a3)
	local al = self:GetCachedResult(z)
	local am = al and al[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	local an = am and am[H]
	return (an and an[a3]) ~= nil
end
function r.prototype.GetAbilityMechanicsUpgradeLevelSpecialValue(self, z, H, ao, ap)
	local aq = self:GetCachedResult(z)
	local ar = aq and aq[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	local a4 = ar and ar[H]
	if a4 ~= nil then
		for a3 in pairs(a4) do
			local a5 = a4[a3]
			local as = a5[ao]
			if (as and as.value) ~= nil then
				return as.value[Clamp(ap, 0, #as.value - 1) + 1]
			end
		end
	end
	return
end
function r.prototype.GetAbilityMechanicsUpgradeLevelSpecialAddedValue(self, z, H, ao, ap, at)
	local au = self:GetCachedResult(z)
	local av = au and au[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	local a4 = av and av[H]
	if a4 ~= nil then
		for a3 in pairs(a4) do
			local a5 = a4[a3]
			local as = a5[ao]
			local w = as and as[at]
			if type(w) == "number" then
				return w
			elseif type(w) == "string" then
				local a8 = f(w, " ")
				if #a8 > 0 then
					local a9 = a8[Clamp(ap, 0, #a8 - 1) + 1]
					local aw = i(a9)
					if j(i(aw)) then
						return aw
					else
						return a9
					end
				end
			end
		end
	end
	return
end
function r.prototype.RemoveAbilityUpgradeDataByID(self, z, ax, W)
	local A = self:GetAbilityUpgradeTable(z)
	local D = self:GetAbilityUpgradeIndexs(z)
	local ay = D[ax + 1]
	for N = 0, #ay - 1, 1 do
		local O = ay[N + 1]
		local P = A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1][O + 1]
		if P ~= nil and W == P.id then
			k(A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1], O, 1)
			ArrayRemove(ay, N)
			do
				local az = N
				while az < #ay do
					local aA, aB = ay, az + 1
					aA[aB] = aA[aB] - 1
					az = az + 1
				end
			end
			break
		end
	end
end
function r.prototype.RemoveAbilityUpgradeDataByIndex(self, z, ax, O)
	local A = self:GetAbilityUpgradeTable(z)
	local D = self:GetAbilityUpgradeIndexs(z)
	k(A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1], O, 1)
	ArrayRemove(D[ax + 1], O)
	do
		local N = O
		while N < #D[ax + 1] do
			local aC, aD = D[ax + 1], N + 1
			aC[aD] = aC[aD] - 1
			N = N + 1
		end
	end
end
function r.prototype.ResetAbilityUpgradesByPlayerID(self, z)
	h(self.tAbilityUpgrades, z)
	h(self.tAbilityUpgradesIndexs, z)
	local aE = self.removeRetention[z]
	if aE ~= nil then
		do
			local N = 0
			while N < #aE do
				AbilityUpgrades:AddAbilityMechanicsUpgrade(z, aE[N + 1])
				N = N + 1
			end
		end
	end
	self:UpdateAbilityUpgradesNetTables(z)
end
function r.prototype.OnClearClientAbilityUpgradeCache(self, aF)
	self.tClientAbilityUpgrades = {}
end
function r.prototype.reset(self)
	self.tAbilityUpgrades = {}
	self.tAbilityUpgradesIndexs = {}
	self.removeRetention = {}
	self:UpdateAbilityUpgradesNetTables()
	FireGameEvent("clear_client_ability_upgrade_cache", { clear = 1 })
end
r = l({ q }, r)
if _G.AbilityUpgrades == nil then
	_G.AbilityUpgrades = m(r)
end
return o