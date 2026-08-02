--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
		["34"] = 40,
		["35"] = 41,
		["36"] = 40,
		["37"] = 43,
		["38"] = 44,
		["39"] = 45,
		["40"] = 46,
		["41"] = 47,
		["42"] = 48,
		["43"] = 50,
		["44"] = 51,
		["45"] = 52,
		["46"] = 53,
		["47"] = 54,
		["48"] = 55,
		["50"] = 58,
		["51"] = 60,
		["52"] = 62,
		["53"] = 43,
		["54"] = 64,
		["55"] = 65,
		["56"] = 66,
		["57"] = 67,
		["58"] = 68,
		["59"] = 69,
		["60"] = 69,
		["61"] = 69,
		["62"] = 69,
		["63"] = 69,
		["64"] = 70,
		["65"] = 70,
		["66"] = 70,
		["67"] = 70,
		["68"] = 70,
		["69"] = 70,
		["70"] = 70,
		["71"] = 70,
		["72"] = 71,
		["73"] = 72,
		["74"] = 72,
		["75"] = 72,
		["76"] = 73,
		["77"] = 74,
		["79"] = 72,
		["80"] = 72,
		["82"] = 64,
		["83"] = 79,
		["84"] = 80,
		["85"] = 81,
		["86"] = 82,
		["87"] = 83,
		["88"] = 84,
		["89"] = 85,
		["90"] = 86,
		["91"] = 87,
		["92"] = 88,
		["93"] = 89,
		["94"] = 90,
		["95"] = 91,
		["96"] = 92,
		["103"] = 99,
		["106"] = 79,
		["107"] = 103,
		["108"] = 104,
		["109"] = 105,
		["110"] = 106,
		["111"] = 107,
		["112"] = 108,
		["115"] = 103,
		["116"] = 112,
		["117"] = 113,
		["118"] = 114,
		["119"] = 115,
		["120"] = 116,
		["121"] = 117,
		["123"] = 119,
		["124"] = 120,
		["125"] = 121,
		["126"] = 122,
		["127"] = 123,
		["129"] = 124,
		["130"] = 124,
		["131"] = 125,
		["132"] = 124,
		["135"] = 127,
		["136"] = 127,
		["137"] = 127,
		["138"] = 127,
		["139"] = 127,
		["140"] = 127,
		["143"] = 112,
		["144"] = 131,
		["145"] = 132,
		["146"] = 132,
		["147"] = 132,
		["148"] = 132,
		["149"] = 132,
		["150"] = 131,
		["151"] = 138,
		["152"] = 139,
		["153"] = 140,
		["154"] = 141,
		["155"] = 142,
		["157"] = 138,
		["158"] = 145,
		["159"] = 146,
		["160"] = 145,
		["161"] = 148,
		["162"] = 149,
		["163"] = 148,
		["164"] = 151,
		["165"] = 152,
		["166"] = 153,
		["167"] = 154,
		["169"] = 156,
		["170"] = 157,
		["173"] = 160,
		["176"] = 163,
		["177"] = 164,
		["178"] = 165,
		["179"] = 166,
		["180"] = 167,
		["181"] = 168,
		["182"] = 169,
		["183"] = 170,
		["184"] = 171,
		["186"] = 173,
		["187"] = 174,
		["188"] = 175,
		["189"] = 176,
		["190"] = 176,
		["191"] = 176,
		["192"] = 176,
		["195"] = 179,
		["196"] = 180,
		["197"] = 181,
		["201"] = 151,
		["202"] = 186,
		["203"] = 187,
		["204"] = 187,
		["205"] = 187,
		["206"] = 187,
		["207"] = 187,
		["208"] = 187,
		["209"] = 187,
		["210"] = 187,
		["211"] = 186,
		["212"] = 197,
		["213"] = 198,
		["216"] = 201,
		["217"] = 202,
		["219"] = 197,
		["220"] = 205,
		["221"] = 206,
		["224"] = 209,
		["225"] = 210,
		["227"] = 205,
		["228"] = 213,
		["229"] = 214,
		["232"] = 217,
		["233"] = 213,
		["234"] = 219,
		["235"] = 220,
		["236"] = 219,
		["237"] = 222,
		["238"] = 223,
		["239"] = 222,
		["240"] = 225,
		["241"] = 226,
		["244"] = 229,
		["245"] = 225,
		["246"] = 23,
		["247"] = 15,
		["248"] = 15,
		["249"] = 15,
		["250"] = 15,
		["251"] = 15,
		["252"] = 15,
		["253"] = 15,
		["254"] = 15,
		["255"] = 23,
		["257"] = 23,
		["258"] = 233,
		["259"] = 242,
		["260"] = 233,
		["261"] = 242,
		["262"] = 243,
		["263"] = 244,
		["264"] = 245,
		["265"] = 246,
		["266"] = 247,
		["267"] = 248,
		["268"] = 248,
		["269"] = 248,
		["270"] = 248,
		["271"] = 248,
		["272"] = 248,
		["273"] = 248,
		["274"] = 248,
		["276"] = 243,
		["277"] = 242,
		["278"] = 233,
		["279"] = 233,
		["280"] = 233,
		["281"] = 233,
		["282"] = 233,
		["283"] = 233,
		["284"] = 233,
		["285"] = 233,
		["286"] = 233,
		["287"] = 242,
		["289"] = 242,
		["290"] = 253,
		["291"] = 262,
		["292"] = 253,
		["293"] = 262,
		["294"] = 263,
		["295"] = 264,
		["296"] = 265,
		["297"] = 266,
		["298"] = 267,
		["299"] = 268,
		["300"] = 269,
		["301"] = 269,
		["302"] = 269,
		["303"] = 269,
		["304"] = 269,
		["305"] = 269,
		["306"] = 269,
		["307"] = 269,
		["308"] = 270,
		["309"] = 271,
		["310"] = 271,
		["311"] = 271,
		["312"] = 271,
		["313"] = 271,
		["314"] = 271,
		["315"] = 271,
		["316"] = 271,
		["317"] = 272,
		["318"] = 273,
		["320"] = 263,
		["321"] = 276,
		["322"] = 277,
		["323"] = 276,
		["324"] = 281,
		["325"] = 282,
		["326"] = 282,
		["327"] = 282,
		["328"] = 282,
		["329"] = 281,
		["330"] = 262,
		["331"] = 253,
		["332"] = 253,
		["333"] = 253,
		["334"] = 253,
		["335"] = 253,
		["336"] = 253,
		["337"] = 253,
		["338"] = 253,
		["339"] = 253,
		["340"] = 262,
		["342"] = 262,
		["343"] = 286,
		["344"] = 295,
		["345"] = 286,
		["346"] = 295,
		["347"] = 296,
		["348"] = 297,
		["349"] = 298,
		["350"] = 299,
		["351"] = 300,
		["352"] = 301,
		["353"] = 302,
		["354"] = 302,
		["355"] = 302,
		["356"] = 302,
		["357"] = 302,
		["358"] = 302,
		["359"] = 302,
		["360"] = 302,
		["361"] = 303,
		["362"] = 304,
		["363"] = 304,
		["364"] = 304,
		["365"] = 304,
		["366"] = 304,
		["367"] = 304,
		["368"] = 304,
		["369"] = 304,
		["370"] = 305,
		["371"] = 306,
		["373"] = 296,
		["374"] = 309,
		["375"] = 310,
		["376"] = 309,
		["377"] = 314,
		["378"] = 315,
		["379"] = 315,
		["380"] = 315,
		["381"] = 315,
		["382"] = 314,
		["383"] = 295,
		["384"] = 286,
		["385"] = 286,
		["386"] = 286,
		["387"] = 286,
		["388"] = 286,
		["389"] = 286,
		["390"] = 286,
		["391"] = 286,
		["392"] = 286,
		["393"] = 295,
		["395"] = 295,
		["396"] = 319,
		["397"] = 328,
		["398"] = 319,
		["399"] = 328,
		["400"] = 329,
		["401"] = 330,
		["402"] = 331,
		["403"] = 332,
		["404"] = 333,
		["405"] = 334,
		["406"] = 335,
		["407"] = 335,
		["408"] = 335,
		["409"] = 335,
		["410"] = 335,
		["411"] = 335,
		["412"] = 335,
		["413"] = 335,
		["414"] = 336,
		["415"] = 337,
		["416"] = 337,
		["417"] = 337,
		["418"] = 337,
		["419"] = 337,
		["420"] = 337,
		["421"] = 337,
		["422"] = 337,
		["423"] = 338,
		["424"] = 339,
		["426"] = 329,
		["427"] = 342,
		["428"] = 343,
		["429"] = 342,
		["430"] = 347,
		["431"] = 348,
		["432"] = 348,
		["433"] = 348,
		["434"] = 348,
		["435"] = 347,
		["436"] = 328,
		["437"] = 319,
		["438"] = 319,
		["439"] = 319,
		["440"] = 319,
		["441"] = 319,
		["442"] = 319,
		["443"] = 319,
		["444"] = 319,
		["445"] = 319,
		["446"] = 328,
		["448"] = 328,
		["449"] = 354,
		["450"] = 355,
		["451"] = 354,
		["452"] = 355,
		["453"] = 356,
		["454"] = 357,
		["455"] = 358,
		["456"] = 359,
		["459"] = 362,
		["460"] = 363,
		["461"] = 364,
		["463"] = 366,
		["464"] = 367,
		["465"] = 367,
		["466"] = 367,
		["467"] = 368,
		["468"] = 369,
		["470"] = 371,
		["471"] = 372,
		["473"] = 367,
		["474"] = 367,
		["475"] = 356,
		["476"] = 376,
		["477"] = 376,
		["478"] = 376,
		["480"] = 377,
		["481"] = 378,
		["484"] = 381,
		["485"] = 382,
		["486"] = 383,
		["487"] = 384,
		["488"] = 385,
		["489"] = 385,
		["490"] = 385,
		["491"] = 385,
		["492"] = 385,
		["493"] = 385,
		["494"] = 385,
		["495"] = 385,
		["496"] = 393,
		["497"] = 394,
		["500"] = 395,
		["501"] = 385,
		["502"] = 385,
		["503"] = 410,
		["504"] = 411,
		["505"] = 412,
		["506"] = 412,
		["507"] = 412,
		["508"] = 413,
		["509"] = 414,
		["511"] = 412,
		["512"] = 412,
		["514"] = 376,
		["515"] = 419,
		["516"] = 419,
		["517"] = 419,
		["519"] = 419,
		["520"] = 419,
		["522"] = 420,
		["523"] = 421,
		["526"] = 425,
		["527"] = 426,
		["528"] = 427,
		["529"] = 428,
		["530"] = 429,
		["531"] = 430,
		["532"] = 419,
		["533"] = 432,
		["534"] = 433,
		["535"] = 432,
		["536"] = 355,
		["537"] = 354,
		["538"] = 355,
		["540"] = 355,
		["541"] = 439,
		["542"] = 447,
		["543"] = 439,
		["544"] = 447,
		["545"] = 452,
		["546"] = 454,
		["547"] = 455,
		["548"] = 452,
		["549"] = 457,
		["550"] = 458,
		["551"] = 459,
		["552"] = 460,
		["554"] = 457,
		["555"] = 463,
		["556"] = 464,
		["557"] = 464,
		["558"] = 466,
		["559"] = 466,
		["560"] = 466,
		["561"] = 464,
		["562"] = 467,
		["563"] = 467,
		["564"] = 467,
		["565"] = 464,
		["566"] = 464,
		["567"] = 463,
		["568"] = 470,
		["569"] = 471,
		["570"] = 470,
		["571"] = 473,
		["572"] = 474,
		["573"] = 473,
		["574"] = 476,
		["575"] = 477,
		["576"] = 478,
		["577"] = 478,
		["578"] = 478,
		["579"] = 478,
		["580"] = 479,
		["581"] = 480,
		["582"] = 481,
		["583"] = 482,
		["584"] = 483,
		["585"] = 483,
		["586"] = 483,
		["587"] = 483,
		["590"] = 476,
		["591"] = 447,
		["592"] = 439,
		["593"] = 439,
		["594"] = 439,
		["595"] = 439,
		["596"] = 439,
		["597"] = 439,
		["598"] = 439,
		["599"] = 439,
		["600"] = 447,
		["602"] = 447,
		["603"] = 491,
		["604"] = 492,
		["605"] = 491,
		["606"] = 492,
		["607"] = 493,
		["608"] = 494,
		["609"] = 493,
		["610"] = 492,
		["611"] = 491,
		["612"] = 492,
		["614"] = 492,
		["615"] = 498,
		["616"] = 506,
		["617"] = 498,
		["618"] = 506,
		["619"] = 508,
		["620"] = 509,
		["621"] = 508,
		["622"] = 511,
		["623"] = 512,
		["624"] = 511,
		["625"] = 516,
		["626"] = 517,
		["627"] = 518,
		["628"] = 519,
		["629"] = 520,
		["630"] = 522,
		["631"] = 523,
		["632"] = 524,
		["633"] = 525,
		["634"] = 525,
		["635"] = 525,
		["636"] = 525,
		["637"] = 525,
		["638"] = 525,
		["639"] = 525,
		["640"] = 525,
		["641"] = 525,
		["642"] = 526,
		["643"] = 527,
		["644"] = 528,
		["645"] = 529,
		["646"] = 529,
		["647"] = 529,
		["648"] = 529,
		["649"] = 529,
		["650"] = 529,
		["651"] = 530,
		["653"] = 532,
		["654"] = 532,
		["655"] = 532,
		["656"] = 532,
		["657"] = 532,
		["659"] = 516,
		["660"] = 506,
		["661"] = 498,
		["662"] = 498,
		["663"] = 498,
		["664"] = 498,
		["665"] = 498,
		["666"] = 498,
		["667"] = 498,
		["668"] = 498,
		["669"] = 506,
		["671"] = 506,
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
		local F = math.floor(D / self.level)
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