--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/tiny"
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
		["15"] = 4,
		["16"] = 4,
		["17"] = 4,
		["18"] = 8,
		["19"] = 9,
		["20"] = 8,
		["21"] = 9,
		["22"] = 10,
		["23"] = 11,
		["24"] = 10,
		["25"] = 9,
		["26"] = 8,
		["27"] = 9,
		["29"] = 9,
		["30"] = 15,
		["31"] = 23,
		["32"] = 15,
		["33"] = 23,
		["34"] = 41,
		["35"] = 42,
		["36"] = 41,
		["37"] = 44,
		["38"] = 45,
		["39"] = 46,
		["40"] = 47,
		["41"] = 48,
		["42"] = 49,
		["43"] = 50,
		["44"] = 52,
		["45"] = 53,
		["46"] = 54,
		["47"] = 55,
		["48"] = 56,
		["49"] = 57,
		["51"] = 60,
		["52"] = 62,
		["53"] = 64,
		["54"] = 44,
		["55"] = 66,
		["56"] = 67,
		["57"] = 68,
		["58"] = 69,
		["59"] = 70,
		["60"] = 71,
		["61"] = 71,
		["62"] = 71,
		["63"] = 71,
		["64"] = 71,
		["65"] = 72,
		["66"] = 72,
		["67"] = 72,
		["68"] = 72,
		["69"] = 72,
		["70"] = 72,
		["71"] = 72,
		["72"] = 72,
		["73"] = 73,
		["74"] = 74,
		["75"] = 74,
		["76"] = 74,
		["77"] = 75,
		["78"] = 76,
		["80"] = 74,
		["81"] = 74,
		["83"] = 66,
		["84"] = 81,
		["85"] = 82,
		["86"] = 83,
		["87"] = 84,
		["88"] = 85,
		["89"] = 86,
		["90"] = 87,
		["91"] = 88,
		["92"] = 89,
		["93"] = 90,
		["94"] = 91,
		["95"] = 92,
		["96"] = 93,
		["97"] = 94,
		["104"] = 101,
		["107"] = 81,
		["108"] = 105,
		["109"] = 106,
		["110"] = 107,
		["111"] = 108,
		["112"] = 109,
		["113"] = 110,
		["116"] = 105,
		["117"] = 114,
		["118"] = 115,
		["119"] = 116,
		["120"] = 117,
		["121"] = 118,
		["122"] = 119,
		["124"] = 121,
		["125"] = 121,
		["126"] = 121,
		["127"] = 121,
		["128"] = 122,
		["129"] = 123,
		["130"] = 124,
		["131"] = 125,
		["133"] = 126,
		["134"] = 126,
		["135"] = 127,
		["136"] = 126,
		["139"] = 129,
		["140"] = 129,
		["141"] = 129,
		["142"] = 129,
		["143"] = 129,
		["144"] = 129,
		["147"] = 114,
		["148"] = 133,
		["149"] = 134,
		["150"] = 134,
		["151"] = 134,
		["152"] = 134,
		["153"] = 134,
		["154"] = 133,
		["155"] = 140,
		["156"] = 141,
		["157"] = 142,
		["158"] = 143,
		["159"] = 144,
		["161"] = 140,
		["162"] = 147,
		["163"] = 148,
		["164"] = 147,
		["165"] = 150,
		["166"] = 151,
		["167"] = 150,
		["168"] = 153,
		["169"] = 154,
		["170"] = 155,
		["171"] = 156,
		["173"] = 158,
		["174"] = 159,
		["177"] = 162,
		["180"] = 165,
		["181"] = 166,
		["182"] = 167,
		["183"] = 168,
		["184"] = 169,
		["185"] = 170,
		["186"] = 171,
		["187"] = 172,
		["188"] = 173,
		["190"] = 175,
		["191"] = 176,
		["192"] = 177,
		["193"] = 178,
		["194"] = 178,
		["195"] = 178,
		["196"] = 178,
		["199"] = 181,
		["200"] = 182,
		["201"] = 183,
		["205"] = 153,
		["206"] = 188,
		["207"] = 189,
		["208"] = 189,
		["209"] = 189,
		["210"] = 189,
		["211"] = 189,
		["212"] = 189,
		["213"] = 189,
		["214"] = 189,
		["215"] = 188,
		["216"] = 199,
		["217"] = 200,
		["220"] = 203,
		["221"] = 204,
		["223"] = 199,
		["224"] = 207,
		["225"] = 208,
		["228"] = 211,
		["229"] = 212,
		["231"] = 207,
		["232"] = 215,
		["233"] = 216,
		["236"] = 219,
		["237"] = 215,
		["238"] = 221,
		["239"] = 222,
		["240"] = 221,
		["241"] = 224,
		["242"] = 225,
		["243"] = 224,
		["244"] = 227,
		["245"] = 228,
		["248"] = 231,
		["249"] = 227,
		["250"] = 23,
		["251"] = 15,
		["252"] = 15,
		["253"] = 15,
		["254"] = 15,
		["255"] = 15,
		["256"] = 15,
		["257"] = 15,
		["258"] = 15,
		["259"] = 23,
		["261"] = 23,
		["262"] = 235,
		["263"] = 244,
		["264"] = 235,
		["265"] = 244,
		["266"] = 245,
		["267"] = 246,
		["268"] = 247,
		["269"] = 248,
		["270"] = 249,
		["271"] = 250,
		["272"] = 250,
		["273"] = 250,
		["274"] = 250,
		["275"] = 250,
		["276"] = 250,
		["277"] = 250,
		["278"] = 250,
		["280"] = 245,
		["281"] = 244,
		["282"] = 235,
		["283"] = 235,
		["284"] = 235,
		["285"] = 235,
		["286"] = 235,
		["287"] = 235,
		["288"] = 235,
		["289"] = 235,
		["290"] = 235,
		["291"] = 244,
		["293"] = 244,
		["294"] = 255,
		["295"] = 264,
		["296"] = 255,
		["297"] = 264,
		["298"] = 265,
		["299"] = 266,
		["300"] = 267,
		["301"] = 268,
		["302"] = 269,
		["303"] = 270,
		["304"] = 271,
		["305"] = 271,
		["306"] = 271,
		["307"] = 271,
		["308"] = 271,
		["309"] = 271,
		["310"] = 271,
		["311"] = 271,
		["312"] = 272,
		["313"] = 273,
		["314"] = 273,
		["315"] = 273,
		["316"] = 273,
		["317"] = 273,
		["318"] = 273,
		["319"] = 273,
		["320"] = 273,
		["321"] = 274,
		["322"] = 275,
		["324"] = 265,
		["325"] = 278,
		["326"] = 279,
		["327"] = 278,
		["328"] = 283,
		["329"] = 284,
		["330"] = 284,
		["331"] = 284,
		["332"] = 284,
		["333"] = 283,
		["334"] = 264,
		["335"] = 255,
		["336"] = 255,
		["337"] = 255,
		["338"] = 255,
		["339"] = 255,
		["340"] = 255,
		["341"] = 255,
		["342"] = 255,
		["343"] = 255,
		["344"] = 264,
		["346"] = 264,
		["347"] = 288,
		["348"] = 297,
		["349"] = 288,
		["350"] = 297,
		["351"] = 298,
		["352"] = 299,
		["353"] = 300,
		["354"] = 301,
		["355"] = 302,
		["356"] = 303,
		["357"] = 304,
		["358"] = 304,
		["359"] = 304,
		["360"] = 304,
		["361"] = 304,
		["362"] = 304,
		["363"] = 304,
		["364"] = 304,
		["365"] = 305,
		["366"] = 306,
		["367"] = 306,
		["368"] = 306,
		["369"] = 306,
		["370"] = 306,
		["371"] = 306,
		["372"] = 306,
		["373"] = 306,
		["374"] = 307,
		["375"] = 308,
		["377"] = 298,
		["378"] = 311,
		["379"] = 312,
		["380"] = 311,
		["381"] = 316,
		["382"] = 317,
		["383"] = 317,
		["384"] = 317,
		["385"] = 317,
		["386"] = 316,
		["387"] = 297,
		["388"] = 288,
		["389"] = 288,
		["390"] = 288,
		["391"] = 288,
		["392"] = 288,
		["393"] = 288,
		["394"] = 288,
		["395"] = 288,
		["396"] = 288,
		["397"] = 297,
		["399"] = 297,
		["400"] = 321,
		["401"] = 330,
		["402"] = 321,
		["403"] = 330,
		["404"] = 331,
		["405"] = 332,
		["406"] = 333,
		["407"] = 334,
		["408"] = 335,
		["409"] = 336,
		["410"] = 337,
		["411"] = 337,
		["412"] = 337,
		["413"] = 337,
		["414"] = 337,
		["415"] = 337,
		["416"] = 337,
		["417"] = 337,
		["418"] = 338,
		["419"] = 339,
		["420"] = 339,
		["421"] = 339,
		["422"] = 339,
		["423"] = 339,
		["424"] = 339,
		["425"] = 339,
		["426"] = 339,
		["427"] = 340,
		["428"] = 341,
		["430"] = 331,
		["431"] = 344,
		["432"] = 345,
		["433"] = 344,
		["434"] = 349,
		["435"] = 350,
		["436"] = 350,
		["437"] = 350,
		["438"] = 350,
		["439"] = 349,
		["440"] = 330,
		["441"] = 321,
		["442"] = 321,
		["443"] = 321,
		["444"] = 321,
		["445"] = 321,
		["446"] = 321,
		["447"] = 321,
		["448"] = 321,
		["449"] = 321,
		["450"] = 330,
		["452"] = 330,
		["453"] = 356,
		["454"] = 357,
		["455"] = 356,
		["456"] = 357,
		["457"] = 358,
		["458"] = 359,
		["459"] = 360,
		["460"] = 361,
		["463"] = 364,
		["464"] = 365,
		["465"] = 366,
		["467"] = 368,
		["468"] = 369,
		["469"] = 369,
		["470"] = 369,
		["471"] = 370,
		["472"] = 371,
		["474"] = 373,
		["475"] = 374,
		["477"] = 369,
		["478"] = 369,
		["479"] = 358,
		["480"] = 378,
		["481"] = 378,
		["482"] = 378,
		["484"] = 379,
		["485"] = 380,
		["488"] = 383,
		["489"] = 384,
		["490"] = 385,
		["491"] = 386,
		["492"] = 387,
		["493"] = 387,
		["494"] = 387,
		["495"] = 387,
		["496"] = 387,
		["497"] = 387,
		["498"] = 387,
		["499"] = 387,
		["500"] = 395,
		["501"] = 396,
		["504"] = 397,
		["505"] = 387,
		["506"] = 387,
		["507"] = 412,
		["508"] = 413,
		["509"] = 414,
		["510"] = 414,
		["511"] = 414,
		["512"] = 415,
		["513"] = 416,
		["515"] = 414,
		["516"] = 414,
		["518"] = 378,
		["519"] = 421,
		["520"] = 421,
		["521"] = 421,
		["523"] = 421,
		["524"] = 421,
		["526"] = 422,
		["527"] = 423,
		["530"] = 427,
		["531"] = 428,
		["532"] = 429,
		["533"] = 430,
		["534"] = 431,
		["535"] = 432,
		["536"] = 421,
		["537"] = 434,
		["538"] = 435,
		["539"] = 434,
		["540"] = 357,
		["541"] = 356,
		["542"] = 357,
		["544"] = 357,
		["545"] = 441,
		["546"] = 449,
		["547"] = 441,
		["548"] = 449,
		["549"] = 454,
		["550"] = 456,
		["551"] = 457,
		["552"] = 454,
		["553"] = 459,
		["554"] = 460,
		["555"] = 461,
		["556"] = 462,
		["558"] = 459,
		["559"] = 465,
		["560"] = 466,
		["561"] = 466,
		["562"] = 468,
		["563"] = 468,
		["564"] = 468,
		["565"] = 466,
		["566"] = 469,
		["567"] = 469,
		["568"] = 469,
		["569"] = 466,
		["570"] = 466,
		["571"] = 465,
		["572"] = 472,
		["573"] = 473,
		["574"] = 472,
		["575"] = 475,
		["576"] = 476,
		["577"] = 475,
		["578"] = 478,
		["579"] = 479,
		["580"] = 480,
		["581"] = 480,
		["582"] = 480,
		["583"] = 480,
		["584"] = 481,
		["585"] = 482,
		["586"] = 483,
		["587"] = 484,
		["588"] = 485,
		["589"] = 485,
		["590"] = 485,
		["591"] = 485,
		["594"] = 478,
		["595"] = 449,
		["596"] = 441,
		["597"] = 441,
		["598"] = 441,
		["599"] = 441,
		["600"] = 441,
		["601"] = 441,
		["602"] = 441,
		["603"] = 441,
		["604"] = 449,
		["606"] = 449,
		["607"] = 493,
		["608"] = 494,
		["609"] = 493,
		["610"] = 494,
		["611"] = 495,
		["612"] = 496,
		["613"] = 495,
		["614"] = 494,
		["615"] = 493,
		["616"] = 494,
		["618"] = 494,
		["619"] = 500,
		["620"] = 508,
		["621"] = 500,
		["622"] = 508,
		["623"] = 510,
		["624"] = 511,
		["625"] = 510,
		["626"] = 513,
		["627"] = 514,
		["628"] = 513,
		["629"] = 518,
		["630"] = 519,
		["631"] = 520,
		["632"] = 521,
		["633"] = 522,
		["634"] = 524,
		["635"] = 525,
		["636"] = 526,
		["637"] = 527,
		["638"] = 527,
		["639"] = 527,
		["640"] = 527,
		["641"] = 527,
		["642"] = 527,
		["643"] = 527,
		["644"] = 527,
		["645"] = 527,
		["646"] = 528,
		["647"] = 529,
		["648"] = 530,
		["649"] = 531,
		["650"] = 531,
		["651"] = 531,
		["652"] = 531,
		["653"] = 531,
		["654"] = 531,
		["655"] = 532,
		["657"] = 534,
		["658"] = 534,
		["659"] = 534,
		["660"] = 534,
		["661"] = 534,
		["663"] = 518,
		["664"] = 508,
		["665"] = 500,
		["666"] = 500,
		["667"] = 500,
		["668"] = 500,
		["669"] = 500,
		["670"] = 500,
		["671"] = 500,
		["672"] = 500,
		["673"] = 508,
		["675"] = 508,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
local o = require("abilities.ability_ai")
local p = o.BaseAbilityAI
local q = o.registerAbilityAI
h.tiny_talent = c()
local r = h.tiny_talent
r.name = "tiny_talent"
d(r, j)
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_tiny_talent"
end
r = e({ k(nil) }, r)
h.tiny_talent = r
h.modifier_tiny_talent = c()
local s = h.modifier_tiny_talent
s.name = "modifier_tiny_talent"
d(s, m)
function s.prototype.GetTexture(self)
	return "modifier_tiny_talent"
end
function s.prototype.GetAbilitySpecialValue(self)
	self.level = self:GetAbilitySpecialValueFor("level")
	self.physical_reduce = self:GetAbilitySpecialValueFor("physical_reduce")
	self.attack_damage = self:GetAbilitySpecialValueFor("attack_damage")
	self.attackspeed_reduce = self:GetAbilitySpecialValueFor("attackspeed_reduce")
	self.state_resistance = self:GetAbilitySpecialValueFor("state_resistance")
	self.max_stack = self:GetAbilitySpecialValueFor("max_stack")
	local t = self:GetAbilityTalentValue("tiny_talent_3", "bonus_pct")
	if t > 0 then
		self.attackspeed_reduce = 0
		self.physical_reduce = self.physical_reduce * (1 + t * 0.01)
		self.attack_damage = self.attack_damage * (1 + t * 0.01)
		self.state_resistance = self.state_resistance * (1 + t * 0.01)
	end
	self.tl2_health = self:GetAbilityTalentValue("tiny_talent_2", "health")
	self.tl5_enable = self:HasTalent("tiny_talent_5")
	self.tl6_enable = self:HasTalent("tiny_talent_6")
end
function s.prototype.OnCreated(self, u)
	if IsServer() then
		self:StartThink(0.1, "tree")
		self.buff_record = 0
		self.tree_state = self.tl5_enable
		local v = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_tiny/tiny_scepter_empty.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		self:AddParticle(v, false, false, -1, false, false)
		self:StartIntervalThink(0)
		GameTimer(1, function()
			if IsValid(self) then
				self:CheckLevelModelBuff(nil, true)
			end
		end)
	end
end
function s.prototype.OnThink(self, w)
	if w == "tree" then
		if self.tree_ent == nil then
			local x = self:GetParent()
			if x:HasModifier("modifier_skin") then
				local y = x:FindModifierByName("modifier_skin")
				if IsValid(y) and y.tWearables then
					for z = 1, #y.tWearables, 1 do
						local A = y.tWearables[z]
						local B = A:GetModelName()
						if
							(string.find(B, "tree", nil, true) or 0) - 1 ~= -1
							or (string.find(B, "weapon", nil, true) or 0) - 1 ~= -1
						then
							self.tree_ent = A
							self.tree_model = B
							self:SetTreeState(nil, true)
							break
						end
					end
				end
			end
		else
			self:StartThink(-1, "tree")
		end
	end
end
function s.prototype.OnIntervalThink(self)
	if IsServer() then
		local C = self:GetParent():GetPlayerOwnerID()
		if C ~= -1 then
			self:StartIntervalThink(-1)
			self:CheckLevelModelBuff()
		end
	end
end
function s.prototype.CheckLevelModelBuff(self, D, E)
	if IsServer() then
		local x = self:GetParent()
		if D == nil then
			local C = x:GetPlayerOwnerID()
			D = PlayerData:getHeroLevel(C)
		end
		local F = math.min(math.floor(D / self.level), self.max_stack)
		self:SetStackCount(F)
		local G = Clamp(F + 1, 1, 4)
		if E or G ~= self.buff_record then
			self.buff_record = G
			do
				local z = 0
				while z < 4 do
					x:RemoveModifierByName("modifier_tiny_talent_model_" .. tostring(z + 1))
					z = z + 1
				end
			end
			x:AddNewModifier(x, self:GetAbility(), "modifier_tiny_talent_model_" .. tostring(G), nil)
		end
	end
end
function s.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TALENT_LEARN] = { self:GetParent() },
	}
end
function s.prototype.OnTalentLearn(self, u)
	if u.talentName == "tiny_talent_5" then
		self.tl5_enable = self:HasTalent("tiny_talent_5")
		self:GetParent():RemoveGesture(ACT_DOTA_SPAWN)
		self:SetTreeState()
	end
end
function s.prototype.OnHeroLevelUp(self, u)
	self:CheckLevelModelBuff(u.lvl)
end
function s.prototype.OnBattleStartBefore(self, u)
	self:CheckLevelModelBuff()
end
function s.prototype.SetTreeState(self, H, E)
	local I = self.tree_state
	if self.tl5_enable then
		self.tree_state = true
	else
		if H ~= nil then
			self.tree_state = H
		end
	end
	if not E and I == self.tree_state then
		return
	end
	if IsValid(self.tree_ent) then
		local x = self:GetParent()
		local y = x:FindModifierByName("modifier_skin")
		if IsValid(y) then
			if self.tree_state then
				y:Wearable()
				self:GetParent():AddActivityModifier("tree")
				self.tree_ent:SetModel(self.tree_model)
				self.tree_ent:RemoveEffects(EF_NODRAW)
			else
				if y.tAmbientParticleList then
					local J = y.tAmbientParticleList[self.tree_ent:entindex()]
					if J then
						f(J, function(K, v)
							return ParticleManager:DestroyParticle(v, true)
						end)
					end
				end
				self:GetParent():RemoveActivityModifier("tree")
				self.tree_ent:SetModel("models/development/invisiblebox.vmdl")
				self.tree_ent:AddEffects(EF_NODRAW)
			end
		end
	end
end
function s.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_STATE_RESISTANCE,
	}
end
function s.prototype.EOM_GetModifierIncomingDamagePercentage(self, u)
	if self:GetParent():PassivesDisabled() then
		return
	end
	if self.tl6_enable then
		return -self:GetStackCount() * self.physical_reduce
	end
end
function s.prototype.EOM_GetModifierIncomingPhysicalDamagePercentage(self, u)
	if self:GetParent():PassivesDisabled() then
		return
	end
	if not self.tl6_enable then
		return -self:GetStackCount() * self.physical_reduce
	end
end
function s.prototype.EOM_GetModifierAttackDamageBonus(self)
	if self:GetParent():PassivesDisabled() then
		return
	end
	return self:GetStackCount() * self.attack_damage
end
function s.prototype.EOM_GetModifierAttackSpeedBonus(self, u)
	return -self:GetStackCount() * self.attackspeed_reduce
end
function s.prototype.EOM_GetModifierHealthBonus(self, u)
	return self.tl2_health
end
function s.prototype.EOM_GetModifierStateResistance(self, u)
	if self:GetParent():PassivesDisabled() then
		return
	end
	return self:GetStackCount() * self.state_resistance
end
s = e(
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
	s
)
h.modifier_tiny_talent = s
h.modifier_tiny_talent_model_1 = c()
local L = h.modifier_tiny_talent_model_1
L.name = "modifier_tiny_talent_model_1"
d(L, m)
function L.prototype.OnCreated(self, u)
	if IsServer() then
		local x = self:GetParent()
		x:SetOriginalModel(Wearable:getReplaceUnitModel(x, "models/heroes/tiny/tiny_01/tiny_01.vmdl"))
		local M = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_tiny/tiny_ambient.vpcf",
			PATTACH_CUSTOMORIGIN,
			x
		)
		self:AddParticle(M, false, false, -1, false, false)
	end
end
L = e(
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
				RemoveOnDeath = false,
			}
		),
	},
	L
)
h.modifier_tiny_talent_model_1 = L
h.modifier_tiny_talent_model_2 = c()
local N = h.modifier_tiny_talent_model_2
N.name = "modifier_tiny_talent_model_2"
d(N, m)
function N.prototype.OnCreated(self, u)
	if IsServer() then
		local x = self:GetParent()
		x:SetOriginalModel(Wearable:getReplaceUnitModel(x, "models/heroes/tiny/tiny_02/tiny_02.vmdl"))
		x:EmitSound("Tiny.Grow")
		local M = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_tiny/tiny_ambient_lvl2.vpcf",
			PATTACH_CUSTOMORIGIN,
			x
		)
		self:AddParticle(M, false, false, -1, false, false)
		local O = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_tiny/tiny_grow_hero_effect.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			x
		)
		self:AddParticle(O, false, false, -1, false, false)
		local v = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_tiny/tiny_transform_lvl2.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			x
		)
		ParticleManager:ReleaseParticleIndex(v)
	end
end
function N.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE }
end
function N.prototype.GetModifierModelChange(self)
	return Wearable:getReplaceUnitModel(self:GetParent(), "models/heroes/tiny/tiny_02/tiny_02.vmdl")
end
N = e(
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
				RemoveOnDeath = false,
			}
		),
	},
	N
)
h.modifier_tiny_talent_model_2 = N
h.modifier_tiny_talent_model_3 = c()
local P = h.modifier_tiny_talent_model_3
P.name = "modifier_tiny_talent_model_3"
d(P, m)
function P.prototype.OnCreated(self, u)
	if IsServer() then
		local x = self:GetParent()
		x:SetOriginalModel(Wearable:getReplaceUnitModel(x, "models/heroes/tiny/tiny_03/tiny_03.vmdl"))
		x:EmitSound("Tiny.Grow")
		local M = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_tiny/tiny_ambient_lvl3.vpcf",
			PATTACH_CUSTOMORIGIN,
			x
		)
		self:AddParticle(M, false, false, -1, false, false)
		local O = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_tiny/tiny_grow_hero_effect.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			x
		)
		self:AddParticle(O, false, false, -1, false, false)
		local v = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_tiny/tiny_transform_lvl3.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			x
		)
		ParticleManager:ReleaseParticleIndex(v)
	end
end
function P.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE }
end
function P.prototype.GetModifierModelChange(self)
	return Wearable:getReplaceUnitModel(self:GetParent(), "models/heroes/tiny/tiny_03/tiny_03.vmdl")
end
P = e(
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
				RemoveOnDeath = false,
			}
		),
	},
	P
)
h.modifier_tiny_talent_model_3 = P
h.modifier_tiny_talent_model_4 = c()
local Q = h.modifier_tiny_talent_model_4
Q.name = "modifier_tiny_talent_model_4"
d(Q, m)
function Q.prototype.OnCreated(self, u)
	if IsServer() then
		local x = self:GetParent()
		x:SetOriginalModel(Wearable:getReplaceUnitModel(x, "models/heroes/tiny/tiny_04/tiny_04.vmdl"))
		x:EmitSound("Tiny.Grow")
		local M = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_tiny/tiny_ambient_lvl4.vpcf",
			PATTACH_CUSTOMORIGIN,
			x
		)
		self:AddParticle(M, false, false, -1, false, false)
		local O = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_tiny/tiny_grow_hero_effect.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			x
		)
		self:AddParticle(O, false, false, -1, false, false)
		local v = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_tiny/tiny_transform_lvl4.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			x
		)
		ParticleManager:ReleaseParticleIndex(v)
	end
end
function Q.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE }
end
function Q.prototype.GetModifierModelChange(self)
	return Wearable:getReplaceUnitModel(self:GetParent(), "models/heroes/tiny/tiny_04/tiny_04.vmdl")
end
Q = e(
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
				RemoveOnDeath = false,
			}
		),
	},
	Q
)
h.modifier_tiny_talent_model_4 = Q
h.tiny_ult = c()
local R = h.tiny_ult
R.name = "tiny_ult"
d(R, p)
function R.prototype.OnSpellStart(self)
	local S = self:GetCaster()
	local T = S:GetEnemy()
	if not IsInjurable(S, T) then
		return
	end
	local G = S:FindModifierByName("modifier_tiny_talent")
	if IsValid(G) then
		G:SetTreeState(true)
	end
	S:StartGesture(ACT_DOTA_CAST_ABILITY_4_END)
	self:GameTimer(0.3, function()
		if IsValid(G) then
			G:SetTreeState(false)
		end
		if IsValid(self) then
			self:ThrowTree(T)
		end
	end)
end
function R.prototype.ThrowTree(self, T, U)
	if U == nil then
		U = 100
	end
	local S = self:GetCaster()
	if not IsInjurable(S, T) then
		return
	end
	S:EmitSound("Hero_Tiny.Tree.Throw")
	local V = T:GetAbsOrigin() - S:GetAbsOrigin()
	V.z = 0
	V = V:Normalized()
	Projectile:CreateLinearProjectile({
		EffectName = "particles/units/heroes/hero_tiny/tiny_tree_linear_proj.vpcf",
		hCaster = S,
		vSpawnOrigin = S:GetAbsOrigin(),
		vDirection = V,
		flDistance = 600,
		flRadius = 0,
		iMoveSpeed = PROJECTILE_SPEED_FAST,
		OnProjectileDestroy = function(W)
			if not (IsValid(self) and IsInjurable(S, T)) then
				return
			end
			self:TreeHit(T, self, U)
		end,
	})
	local X = self:GetTalentValue("tiny_shard", "chance")
	if X > 0 and self:PRD(X, "tiny_shard") then
		self:GameTimer(0.25, function()
			if IsValid(self) then
				self:ThrowTree(T)
			end
		end)
	end
end
function R.prototype.TreeHit(self, T, Y, U)
	if Y == nil then
		Y = self
	end
	if U == nil then
		U = 100
	end
	local S = self:GetCaster()
	if not IsInjurable(T, S) then
		return
	end
	local Z = self:GetSpecialValueFor("health_damage") + self:GetTalentValue("tiny_talent_1", "damage_pct")
	local _ = self:GetSpecialValueFor("damage")
	local a0 = _ + Z * S:GetMaxHealth() * 0.01
	a0 = a0 * U * 0.01
	T:EmitSound("Hero_Tiny.Tree.Target")
	S:DealDamage(T, Y, a0, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
end
function R.prototype.GetIntrinsicModifierName(self)
	return "modifier_tiny_ult"
end
R = e({ q(nil) }, R)
h.tiny_ult = R
h.modifier_tiny_ult = c()
local a1 = h.modifier_tiny_ult
a1.name = "modifier_tiny_ult"
d(a1, m)
function a1.prototype.GetAbilitySpecialValue(self)
	self.tl4_threshold = self:GetAbilityTalentValue("tiny_talent_4", "threshold")
	self.tl4_damage_pct = self:GetAbilityTalentValue("tiny_talent_4", "damage_pct")
end
function a1.prototype.OnCreated(self, u)
	if IsServer() then
		self.battling = false
		self.tl4_record = 0
	end
end
function a1.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function a1.prototype.OnBattleStartBefore(self, u)
	self.battling = true
end
function a1.prototype.OnBattleEnd(self, u)
	self.battling = false
end
function a1.prototype.OnCustomTakeDamage(self, a2)
	local x = self:GetParent()
	local a0 = math.max(0, a2.original_health - x:GetHealth())
	if self.tl4_threshold > 0 then
		self.tl4_record = self.tl4_record + a0
		if self.tl4_record >= self.tl4_threshold then
			self.tl4_record = self.tl4_record - self.tl4_threshold
			self:GetAbility():ThrowTree(x:GetEnemy(), self.tl4_damage_pct)
		end
	end
end
a1 = e(
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
	a1
)
h.modifier_tiny_ult = a1
h.tiny_talent_5 = c()
local a3 = h.tiny_talent_5
a3.name = "tiny_talent_5"
d(a3, j)
function a3.prototype.GetIntrinsicModifierName(self)
	return "modifier_tiny_talent_5"
end
a3 = e({ k(nil) }, a3)
h.tiny_talent_5 = a3
h.modifier_tiny_talent_5 = c()
local a4 = h.modifier_tiny_talent_5
a4.name = "modifier_tiny_talent_5"
d(a4, m)
function a4.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function a4.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent() } }
end
function a4.prototype.OnCustomAttackLanded(self, a2)
	local x = self:GetParent()
	local a5 = x:FindAbilityByName("tiny_ult")
	if IsValid(a5) then
		local T = x:GetEnemy()
		if IsInjurable(x, T) then
			x:EmitSound("Hero_Tiny_Tree.Attack")
			local v = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_tiny/tiny_craggy_cleave.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				T,
				x
			)
			ParticleManager:SetParticleControlEnt(v, 1, T, PATTACH_ABSORIGIN_FOLLOW, nil, T:GetAbsOrigin(), false)
			local V = T:GetAbsOrigin() - x:GetAbsOrigin()
			V.z = 0
			V = V:Normalized()
			ParticleManager:SetParticleControlTransform(v, 2, x:GetAbsOrigin(), VectorAngles(V))
			ParticleManager:ReleaseParticleIndex(v)
		end
		a5:TreeHit(T, self:GetAbility(), self.damage)
	end
end
a4 = e(
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
	a4
)
h.modifier_tiny_talent_5 = a4
return h