--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
		["315"] = 307,
		["316"] = 305,
		["317"] = 309,
		["318"] = 310,
		["319"] = 309,
		["320"] = 315,
		["321"] = 316,
		["322"] = 317,
		["323"] = 318,
		["325"] = 320,
		["326"] = 325,
		["327"] = 326,
		["329"] = 328,
		["331"] = 330,
		["332"] = 331,
		["334"] = 333,
		["335"] = 315,
		["336"] = 336,
		["337"] = 337,
		["338"] = 338,
		["339"] = 339,
		["341"] = 341,
		["342"] = 342,
		["344"] = 344,
		["345"] = 336,
		["346"] = 347,
		["347"] = 348,
		["348"] = 349,
		["349"] = 350,
		["351"] = 352,
		["352"] = 357,
		["353"] = 358,
		["355"] = 360,
		["357"] = 362,
		["358"] = 347,
		["359"] = 383,
		["360"] = 383,
		["361"] = 383,
		["363"] = 384,
		["364"] = 386,
		["365"] = 386,
		["367"] = 387,
		["368"] = 387,
		["370"] = 388,
		["371"] = 388,
		["373"] = 389,
		["374"] = 389,
		["376"] = 391,
		["377"] = 392,
		["378"] = 393,
		["379"] = 393,
		["380"] = 394,
		["381"] = 394,
		["382"] = 395,
		["383"] = 396,
		["384"] = 397,
		["386"] = 399,
		["387"] = 399,
		["389"] = 401,
		["390"] = 403,
		["391"] = 404,
		["392"] = 405,
		["393"] = 406,
		["395"] = 408,
		["396"] = 410,
		["397"] = 411,
		["398"] = 412,
		["399"] = 413,
		["400"] = 414,
		["401"] = 417,
		["402"] = 418,
		["403"] = 418,
		["404"] = 419,
		["405"] = 420,
		["406"] = 421,
		["407"] = 422,
		["408"] = 422,
		["409"] = 422,
		["410"] = 422,
		["412"] = 422,
		["413"] = 422,
		["414"] = 422,
		["415"] = 422,
		["417"] = 424,
		["418"] = 425,
		["419"] = 426,
		["420"] = 427,
		["421"] = 428,
		["422"] = 429,
		["423"] = 429,
		["424"] = 430,
		["425"] = 431,
		["426"] = 432,
		["427"] = 433,
		["428"] = 433,
		["429"] = 433,
		["430"] = 433,
		["432"] = 433,
		["433"] = 433,
		["434"] = 433,
		["435"] = 433,
		["439"] = 438,
		["443"] = 442,
		["446"] = 446,
		["447"] = 448,
		["448"] = 450,
		["449"] = 383,
		["450"] = 452,
		["451"] = 452,
		["452"] = 452,
		["454"] = 453,
		["455"] = 455,
		["456"] = 455,
		["458"] = 456,
		["459"] = 456,
		["461"] = 457,
		["462"] = 457,
		["464"] = 459,
		["465"] = 459,
		["467"] = 461,
		["468"] = 462,
		["469"] = 463,
		["470"] = 464,
		["472"] = 466,
		["473"] = 467,
		["474"] = 467,
		["475"] = 469,
		["477"] = 469,
		["479"] = 469,
		["481"] = 472,
		["482"] = 474,
		["483"] = 452,
		["484"] = 477,
		["485"] = 478,
		["486"] = 477,
		["487"] = 481,
		["488"] = 482,
		["489"] = 484,
		["490"] = 485,
		["491"] = 486,
		["492"] = 486,
		["494"] = 487,
		["495"] = 487,
		["497"] = 488,
		["498"] = 488,
		["500"] = 489,
		["501"] = 489,
		["503"] = 490,
		["504"] = 490,
		["506"] = 492,
		["507"] = 493,
		["508"] = 494,
		["509"] = 494,
		["510"] = 495,
		["512"] = 495,
		["514"] = 495,
		["516"] = 498,
		["517"] = 500,
		["518"] = 481,
		["519"] = 502,
		["520"] = 503,
		["521"] = 503,
		["522"] = 503,
		["523"] = 503,
		["524"] = 502,
		["525"] = 505,
		["526"] = 507,
		["527"] = 507,
		["528"] = 507,
		["529"] = 508,
		["530"] = 509,
		["531"] = 510,
		["532"] = 511,
		["533"] = 512,
		["534"] = 513,
		["539"] = 505,
		["540"] = 520,
		["541"] = 523,
		["542"] = 523,
		["543"] = 523,
		["544"] = 524,
		["545"] = 525,
		["546"] = 526,
		["547"] = 527,
		["548"] = 528,
		["549"] = 529,
		["550"] = 530,
		["551"] = 531,
		["552"] = 532,
		["553"] = 533,
		["554"] = 534,
		["555"] = 535,
		["556"] = 536,
		["557"] = 537,
		["559"] = 539,
		["566"] = 520,
		["567"] = 549,
		["568"] = 550,
		["569"] = 551,
		["570"] = 552,
		["571"] = 553,
		["572"] = 554,
		["573"] = 555,
		["574"] = 556,
		["575"] = 557,
		["576"] = 558,
		["578"] = 559,
		["579"] = 559,
		["580"] = 560,
		["581"] = 560,
		["582"] = 559,
		["588"] = 549,
		["589"] = 566,
		["590"] = 567,
		["591"] = 568,
		["592"] = 569,
		["593"] = 570,
		["595"] = 571,
		["596"] = 571,
		["597"] = 572,
		["598"] = 572,
		["599"] = 571,
		["602"] = 566,
		["603"] = 576,
		["604"] = 577,
		["605"] = 578,
		["606"] = 579,
		["607"] = 580,
		["609"] = 581,
		["610"] = 581,
		["611"] = 582,
		["612"] = 581,
		["616"] = 585,
		["617"] = 576,
		["618"] = 588,
		["619"] = 589,
		["620"] = 588,
		["621"] = 591,
		["622"] = 592,
		["623"] = 593,
		["624"] = 594,
		["625"] = 595,
		["626"] = 596,
		["627"] = 591,
		["628"] = 31,
		["629"] = 605,
		["630"] = 606,
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
	return T and T[J] or 0
end
function r.prototype.CalcSpecialValueUpgrade(self, z, H, I, U)
	return (U + self:GetSpecialValueUpgrade(z, H, I, ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD))
		* (1 + self:GetSpecialValueUpgrade(z, H, I, ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_MUL) * 0.01)
end
function r.prototype.AddAbilityMechanicsUpgradeByID(self, z, V, W)
	local X = KeyValues.AbilityUpgradesMechenicsKV[V]
	if not X then
		return false
	end
	local t =
		{ id = V, type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS, description = X.description }
	if W then
		t.ability_name = W
	else
		t.ability_name = X.ability_name
	end
	if type(X.AbilityValues) == "table" then
		t.values = X.AbilityValues
	end
	return self:AddAbilityMechanicsUpgrade(z, t)
end
function r.prototype.HasAbilityMechanicsUpgradeByID(self, z, V, H)
	local X = KeyValues.AbilityUpgradesMechenicsKV[V]
	if not (X and X.description) then
		return false
	end
	if H == nil then
		H = X.ability_name
	end
	return self:HasAbilityMechanicsUpgrade(z, H, X.description)
end
function r.prototype.RemoveAbilityMechanicsUpgradeByID(self, z, V, W)
	local X = KeyValues.AbilityUpgradesMechenicsKV[V]
	if not X then
		return false
	end
	local t =
		{ id = V, type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS, description = X.description }
	if W then
		t.ability_name = W
	else
		t.ability_name = X.ability_name
	end
	return self:RemoveAbilityMechanicsUpgrade(z, t)
end
function r.prototype.AddAbilityMechanicsUpgrade(self, z, t, Y)
	if Y == nil then
		Y = false
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
	local Z = A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1]
	Z[#Z + 1] = t
	local _ = D[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	_[#_ + 1] = #A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1] - 1
	if Y then
		if self.removeRetention[z] == nil then
			self.removeRetention[z] = {}
		end
		local a0 = self.removeRetention[z]
		a0[#a0 + 1] = t
	end
	local a1 =
		A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1][ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	local H = t.ability_name
	local a2 = t.description
	if a1[H] == nil then
		a1[H] = {}
	end
	local a3 = a1[H]
	local a4 = {}
	if type(t.values) == "table" then
		for a5 in pairs(t.values) do
			local w = t.values[a5]
			local x = { value = {} }
			if type(w) == "number" then
				local a6 = x.value
				a6[#a6 + 1] = w
			elseif type(w) == "string" then
				local a7 = f(w, " ")
				if #a7 > 0 then
					g(a7, function(v, a8)
						local a9 = x.value
						local aa = #a9 + 1
						a9[aa] = toFiniteNumber(a8)
						return aa
					end)
				end
			elseif type(w) == "table" then
				for ab in pairs(w) do
					local a8 = w[ab]
					if ab == "value" then
						if type(a8) == "number" then
							local ac = x.value
							ac[#ac + 1] = a8
						elseif type(a8) == "string" then
							local a7 = f(a8, " ")
							if #a7 > 0 then
								g(a7, function(v, ad)
									local ae = x.value
									local af = #ae + 1
									ae[af] = toFiniteNumber(ad)
									return af
								end)
							end
						end
					else
						x[ab] = a8
					end
				end
			end
			a4[a5] = x
		end
	end
	a3[a2] = a4
	self:UpdateAbilityUpgradesNetTables(z, A)
	return true
end
function r.prototype.RemoveAbilityMechanicsUpgrade(self, z, t, Y)
	if Y == nil then
		Y = false
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
	if Y then
		self:RemoveRemoveRetention(z, t)
	end
	local a1 =
		A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1][ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	local ag = a1[t.ability_name]
	if (ag and ag[t.description]) ~= nil then
		local ah = a1[t.ability_name]
		if ah ~= nil then
			h(ah, t.description)
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
	local a1 =
		A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1][ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	local ai = a1[t.ability_name]
	if (ai and ai[t.description]) ~= nil then
		local aj = a1[t.ability_name]
		if aj ~= nil then
			h(aj, t.description)
		end
		local v = true
	end
	self:UpdateAbilityUpgradesNetTables(z, A)
	return true
end
function r.prototype.HasAbilityMechanicsUpgrade(self, z, H, a2)
	local ak = self:GetCachedResult(z)
	local al = ak and ak[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	local am = al and al[H]
	return (am and am[a2]) ~= nil
end
function r.prototype.GetAbilityMechanicsUpgradeLevelSpecialValue(self, z, H, an, ao)
	local ap = self:GetCachedResult(z)
	local aq = ap and ap[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	local a3 = aq and aq[H]
	if a3 ~= nil then
		for a2 in pairs(a3) do
			local a4 = a3[a2]
			local ar = a4[an]
			if (ar and ar.value) ~= nil then
				return ar.value[Clamp(ao, 0, #ar.value - 1) + 1]
			end
		end
	end
	return
end
function r.prototype.GetAbilityMechanicsUpgradeLevelSpecialAddedValue(self, z, H, an, ao, as)
	local at = self:GetCachedResult(z)
	local au = at and at[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	local a3 = au and au[H]
	if a3 ~= nil then
		for a2 in pairs(a3) do
			local a4 = a3[a2]
			local ar = a4[an]
			local w = ar and ar[as]
			if type(w) == "number" then
				return w
			elseif type(w) == "string" then
				local a7 = f(w, " ")
				if #a7 > 0 then
					local a8 = a7[Clamp(ao, 0, #a7 - 1) + 1]
					local av = i(a8)
					if j(i(av)) then
						return av
					else
						return a8
					end
				end
			end
		end
	end
	return
end
function r.prototype.RemoveAbilityUpgradeDataByID(self, z, aw, V)
	local A = self:GetAbilityUpgradeTable(z)
	local D = self:GetAbilityUpgradeIndexs(z)
	local ax = D[aw + 1]
	for N = 0, #ax - 1, 1 do
		local O = ax[N + 1]
		local P = A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1][O + 1]
		if P ~= nil and V == P.id then
			k(A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1], O, 1)
			ArrayRemove(ax, N)
			do
				local ay = N
				while ay < #ax do
					local az, aA = ax, ay + 1
					az[aA] = az[aA] - 1
					ay = ay + 1
				end
			end
			break
		end
	end
end
function r.prototype.RemoveAbilityUpgradeDataByIndex(self, z, aw, O)
	local A = self:GetAbilityUpgradeTable(z)
	local D = self:GetAbilityUpgradeIndexs(z)
	k(A[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1], O, 1)
	ArrayRemove(D[aw + 1], O)
	do
		local N = O
		while N < #D[aw + 1] do
			local aB, aC = D[aw + 1], N + 1
			aB[aC] = aB[aC] - 1
			N = N + 1
		end
	end
end
function r.prototype.ResetAbilityUpgradesByPlayerID(self, z)
	h(self.tAbilityUpgrades, z)
	h(self.tAbilityUpgradesIndexs, z)
	local aD = self.removeRetention[z]
	if aD ~= nil then
		do
			local N = 0
			while N < #aD do
				AbilityUpgrades:AddAbilityMechanicsUpgrade(z, aD[N + 1])
				N = N + 1
			end
		end
	end
	self:UpdateAbilityUpgradesNetTables(z)
end
function r.prototype.OnClearClientAbilityUpgradeCache(self, aE)
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