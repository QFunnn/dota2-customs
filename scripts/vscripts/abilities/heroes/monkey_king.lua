--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/monkey_king"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
local g = b.__TS__ArrayFilter
local h = b.__TS__ArrayForEach
local i = b.__TS__ObjectKeys
local j = b.__TS__ArrayMap
local k = b.__TS__SourceMapTraceBack
k(
	debug.getinfo(1).short_src,
	{
		["13"] = 1,
		["14"] = 1,
		["15"] = 1,
		["16"] = 2,
		["17"] = 2,
		["18"] = 2,
		["19"] = 3,
		["20"] = 3,
		["21"] = 3,
		["22"] = 5,
		["23"] = 6,
		["24"] = 7,
		["25"] = 8,
		["26"] = 9,
		["31"] = 16,
		["32"] = 17,
		["33"] = 16,
		["34"] = 17,
		["35"] = 18,
		["36"] = 19,
		["37"] = 18,
		["38"] = 17,
		["39"] = 16,
		["40"] = 17,
		["42"] = 17,
		["43"] = 23,
		["44"] = 31,
		["45"] = 23,
		["46"] = 31,
		["47"] = 44,
		["48"] = 45,
		["49"] = 47,
		["50"] = 48,
		["51"] = 49,
		["52"] = 50,
		["53"] = 51,
		["54"] = 52,
		["55"] = 53,
		["57"] = 44,
		["58"] = 57,
		["59"] = 58,
		["60"] = 59,
		["62"] = 57,
		["63"] = 62,
		["64"] = 63,
		["65"] = 64,
		["67"] = 62,
		["68"] = 67,
		["69"] = 68,
		["70"] = 69,
		["72"] = 67,
		["73"] = 72,
		["74"] = 73,
		["75"] = 74,
		["76"] = 75,
		["77"] = 76,
		["78"] = 77,
		["79"] = 78,
		["80"] = 79,
		["81"] = 80,
		["82"] = 80,
		["83"] = 80,
		["84"] = 80,
		["85"] = 81,
		["86"] = 82,
		["87"] = 82,
		["88"] = 82,
		["89"] = 83,
		["90"] = 82,
		["91"] = 82,
		["96"] = 72,
		["97"] = 90,
		["98"] = 91,
		["99"] = 91,
		["100"] = 94,
		["101"] = 94,
		["102"] = 94,
		["103"] = 91,
		["104"] = 97,
		["105"] = 97,
		["106"] = 97,
		["107"] = 91,
		["108"] = 98,
		["109"] = 98,
		["110"] = 98,
		["111"] = 91,
		["112"] = 99,
		["113"] = 99,
		["114"] = 99,
		["115"] = 91,
		["116"] = 91,
		["117"] = 90,
		["118"] = 102,
		["119"] = 104,
		["120"] = 105,
		["121"] = 106,
		["122"] = 106,
		["123"] = 106,
		["124"] = 106,
		["125"] = 106,
		["126"] = 106,
		["128"] = 102,
		["129"] = 116,
		["130"] = 117,
		["131"] = 118,
		["132"] = 119,
		["133"] = 120,
		["134"] = 121,
		["135"] = 121,
		["136"] = 121,
		["137"] = 121,
		["138"] = 121,
		["139"] = 122,
		["140"] = 122,
		["141"] = 122,
		["142"] = 122,
		["143"] = 122,
		["144"] = 123,
		["145"] = 123,
		["146"] = 123,
		["147"] = 123,
		["148"] = 123,
		["149"] = 123,
		["150"] = 123,
		["151"] = 123,
		["153"] = 116,
		["154"] = 126,
		["155"] = 127,
		["156"] = 128,
		["157"] = 129,
		["159"] = 126,
		["160"] = 132,
		["161"] = 133,
		["162"] = 134,
		["163"] = 135,
		["164"] = 136,
		["165"] = 137,
		["166"] = 138,
		["167"] = 138,
		["168"] = 138,
		["169"] = 138,
		["170"] = 138,
		["171"] = 138,
		["172"] = 138,
		["173"] = 139,
		["174"] = 140,
		["175"] = 141,
		["176"] = 142,
		["177"] = 143,
		["178"] = 144,
		["179"] = 144,
		["180"] = 144,
		["181"] = 144,
		["182"] = 144,
		["183"] = 144,
		["184"] = 145,
		["185"] = 145,
		["186"] = 145,
		["187"] = 145,
		["188"] = 145,
		["189"] = 145,
		["190"] = 145,
		["191"] = 145,
		["192"] = 145,
		["193"] = 146,
		["196"] = 149,
		["197"] = 132,
		["198"] = 152,
		["199"] = 153,
		["200"] = 152,
		["201"] = 157,
		["202"] = 158,
		["203"] = 159,
		["205"] = 157,
		["206"] = 31,
		["207"] = 23,
		["208"] = 23,
		["209"] = 23,
		["210"] = 23,
		["211"] = 23,
		["212"] = 23,
		["213"] = 23,
		["214"] = 23,
		["215"] = 31,
		["217"] = 31,
		["218"] = 166,
		["219"] = 175,
		["220"] = 166,
		["221"] = 175,
		["222"] = 179,
		["223"] = 180,
		["224"] = 181,
		["225"] = 179,
		["226"] = 183,
		["227"] = 184,
		["228"] = 185,
		["229"] = 185,
		["230"] = 185,
		["231"] = 185,
		["232"] = 185,
		["233"] = 186,
		["234"] = 186,
		["235"] = 186,
		["236"] = 186,
		["237"] = 186,
		["238"] = 187,
		["239"] = 187,
		["240"] = 187,
		["241"] = 187,
		["242"] = 187,
		["243"] = 187,
		["244"] = 187,
		["245"] = 187,
		["246"] = 188,
		["248"] = 183,
		["249"] = 191,
		["250"] = 192,
		["251"] = 193,
		["253"] = 191,
		["254"] = 196,
		["255"] = 197,
		["257"] = 196,
		["258"] = 201,
		["259"] = 202,
		["260"] = 203,
		["261"] = 204,
		["262"] = 204,
		["263"] = 204,
		["264"] = 204,
		["265"] = 204,
		["266"] = 205,
		["267"] = 206,
		["268"] = 206,
		["269"] = 206,
		["270"] = 206,
		["271"] = 206,
		["272"] = 206,
		["273"] = 209,
		["274"] = 209,
		["275"] = 209,
		["276"] = 209,
		["277"] = 209,
		["278"] = 209,
		["279"] = 210,
		["282"] = 201,
		["283"] = 175,
		["284"] = 166,
		["285"] = 166,
		["286"] = 166,
		["287"] = 166,
		["288"] = 166,
		["289"] = 166,
		["290"] = 166,
		["291"] = 166,
		["292"] = 166,
		["293"] = 175,
		["295"] = 175,
		["296"] = 215,
		["297"] = 223,
		["298"] = 215,
		["299"] = 223,
		["300"] = 224,
		["301"] = 225,
		["302"] = 226,
		["303"] = 227,
		["305"] = 229,
		["306"] = 230,
		["307"] = 231,
		["308"] = 231,
		["309"] = 231,
		["310"] = 231,
		["311"] = 231,
		["312"] = 232,
		["313"] = 232,
		["314"] = 232,
		["315"] = 232,
		["316"] = 232,
		["317"] = 232,
		["318"] = 232,
		["319"] = 232,
		["320"] = 232,
		["321"] = 233,
		["322"] = 233,
		["323"] = 233,
		["324"] = 233,
		["325"] = 233,
		["326"] = 233,
		["327"] = 233,
		["328"] = 233,
		["329"] = 233,
		["330"] = 234,
		["331"] = 234,
		["332"] = 234,
		["333"] = 234,
		["334"] = 234,
		["335"] = 234,
		["336"] = 234,
		["337"] = 234,
		["339"] = 224,
		["340"] = 237,
		["341"] = 238,
		["343"] = 237,
		["344"] = 223,
		["345"] = 215,
		["346"] = 215,
		["347"] = 215,
		["348"] = 215,
		["349"] = 215,
		["350"] = 215,
		["351"] = 215,
		["352"] = 215,
		["353"] = 223,
		["355"] = 223,
		["356"] = 244,
		["357"] = 252,
		["358"] = 244,
		["359"] = 252,
		["361"] = 252,
		["362"] = 261,
		["363"] = 244,
		["364"] = 262,
		["365"] = 263,
		["366"] = 262,
		["367"] = 267,
		["368"] = 268,
		["369"] = 267,
		["370"] = 270,
		["371"] = 271,
		["372"] = 272,
		["373"] = 273,
		["374"] = 274,
		["375"] = 275,
		["376"] = 276,
		["377"] = 278,
		["378"] = 270,
		["379"] = 280,
		["380"] = 281,
		["381"] = 282,
		["382"] = 283,
		["383"] = 284,
		["384"] = 285,
		["385"] = 286,
		["386"] = 286,
		["387"] = 286,
		["388"] = 286,
		["389"] = 286,
		["390"] = 286,
		["392"] = 290,
		["393"] = 291,
		["394"] = 291,
		["395"] = 291,
		["396"] = 292,
		["399"] = 294,
		["400"] = 295,
		["401"] = 296,
		["403"] = 291,
		["404"] = 291,
		["406"] = 300,
		["409"] = 280,
		["410"] = 304,
		["411"] = 305,
		["412"] = 306,
		["413"] = 307,
		["414"] = 308,
		["415"] = 309,
		["416"] = 309,
		["417"] = 309,
		["418"] = 309,
		["419"] = 309,
		["420"] = 309,
		["422"] = 313,
		["423"] = 314,
		["424"] = 314,
		["425"] = 314,
		["426"] = 315,
		["429"] = 317,
		["430"] = 318,
		["431"] = 319,
		["433"] = 314,
		["434"] = 314,
		["436"] = 323,
		["439"] = 304,
		["440"] = 327,
		["441"] = 328,
		["442"] = 329,
		["443"] = 331,
		["444"] = 332,
		["445"] = 333,
		["446"] = 334,
		["447"] = 335,
		["448"] = 335,
		["449"] = 335,
		["450"] = 336,
		["451"] = 337,
		["452"] = 338,
		["454"] = 335,
		["455"] = 335,
		["456"] = 341,
		["457"] = 342,
		["460"] = 327,
		["461"] = 346,
		["462"] = 347,
		["463"] = 346,
		["464"] = 352,
		["465"] = 353,
		["466"] = 354,
		["468"] = 352,
		["469"] = 357,
		["470"] = 358,
		["471"] = 359,
		["473"] = 357,
		["474"] = 252,
		["475"] = 244,
		["476"] = 244,
		["477"] = 244,
		["478"] = 244,
		["479"] = 244,
		["480"] = 244,
		["481"] = 244,
		["482"] = 244,
		["483"] = 252,
		["485"] = 252,
		["487"] = 364,
		["488"] = 377,
		["489"] = 364,
		["490"] = 377,
		["491"] = 378,
		["492"] = 379,
		["493"] = 378,
		["494"] = 383,
		["495"] = 384,
		["496"] = 383,
		["497"] = 377,
		["498"] = 364,
		["499"] = 364,
		["500"] = 364,
		["501"] = 364,
		["502"] = 364,
		["503"] = 364,
		["504"] = 364,
		["505"] = 364,
		["506"] = 364,
		["507"] = 364,
		["508"] = 364,
		["509"] = 364,
		["510"] = 364,
		["511"] = 377,
		["513"] = 377,
		["515"] = 392,
		["516"] = 393,
		["517"] = 392,
		["518"] = 393,
		["519"] = 394,
		["520"] = 395,
		["521"] = 396,
		["522"] = 397,
		["525"] = 400,
		["526"] = 401,
		["527"] = 402,
		["528"] = 403,
		["529"] = 404,
		["530"] = 405,
		["531"] = 405,
		["532"] = 405,
		["533"] = 405,
		["534"] = 405,
		["535"] = 405,
		["536"] = 406,
		["537"] = 406,
		["538"] = 406,
		["539"] = 406,
		["540"] = 406,
		["541"] = 406,
		["542"] = 406,
		["543"] = 406,
		["544"] = 406,
		["545"] = 407,
		["546"] = 407,
		["547"] = 407,
		["548"] = 407,
		["549"] = 407,
		["550"] = 407,
		["551"] = 407,
		["552"] = 407,
		["553"] = 407,
		["554"] = 408,
		["555"] = 409,
		["556"] = 410,
		["557"] = 411,
		["558"] = 411,
		["559"] = 411,
		["560"] = 412,
		["561"] = 411,
		["562"] = 411,
		["563"] = 394,
		["564"] = 416,
		["565"] = 417,
		["566"] = 418,
		["567"] = 419,
		["570"] = 422,
		["571"] = 423,
		["572"] = 424,
		["573"] = 425,
		["574"] = 426,
		["575"] = 427,
		["576"] = 429,
		["577"] = 430,
		["578"] = 431,
		["579"] = 432,
		["581"] = 437,
		["582"] = 438,
		["583"] = 439,
		["584"] = 440,
		["585"] = 441,
		["586"] = 442,
		["587"] = 442,
		["588"] = 442,
		["589"] = 442,
		["590"] = 442,
		["591"] = 442,
		["592"] = 443,
		["593"] = 444,
		["594"] = 445,
		["595"] = 446,
		["596"] = 447,
		["597"] = 448,
		["599"] = 454,
		["601"] = 457,
		["602"] = 458,
		["603"] = 459,
		["604"] = 416,
		["605"] = 393,
		["606"] = 392,
		["607"] = 393,
		["609"] = 393,
		["610"] = 474,
		["611"] = 487,
		["612"] = 474,
		["613"] = 487,
		["614"] = 488,
		["615"] = 489,
		["616"] = 490,
		["617"] = 490,
		["618"] = 490,
		["619"] = 490,
		["620"] = 490,
		["621"] = 491,
		["622"] = 491,
		["623"] = 491,
		["624"] = 491,
		["625"] = 491,
		["626"] = 491,
		["627"] = 491,
		["628"] = 491,
		["629"] = 491,
		["630"] = 492,
		["631"] = 492,
		["632"] = 492,
		["633"] = 492,
		["634"] = 492,
		["635"] = 492,
		["636"] = 492,
		["637"] = 492,
		["639"] = 488,
		["640"] = 495,
		["641"] = 496,
		["642"] = 495,
		["643"] = 487,
		["644"] = 474,
		["645"] = 474,
		["646"] = 474,
		["647"] = 474,
		["648"] = 474,
		["649"] = 474,
		["650"] = 474,
		["651"] = 474,
		["652"] = 474,
		["653"] = 474,
		["654"] = 474,
		["655"] = 474,
		["656"] = 487,
		["658"] = 487,
	}
)
local l = {}
local m = require("lib.dota_ts_adapter")
local n = m.BaseAbility
local o = m.registerAbility
local p = require("modifiers.eom_modifier")
local q = p.EOMModifier
local r = p.registerEOMModifier
local s = require("abilities.ability_ai")
local t = s.BaseAbilityAI
local u = s.registerAbilityAI
local v = {}
for w, x in pairs(KeyValues.HeroTalentKv) do
	if x and x.Hero == "monkey_king" then
		if x.RequiredLevel == 5 or x.RequiredLevel == 10 then
			v[#v + 1] = w
		end
	end
end
l.monkey_king_talent = c()
local y = l.monkey_king_talent
y.name = "monkey_king_talent"
d(y, n)
function y.prototype.GetIntrinsicModifierName(self)
	return "modifier_monkey_king_talent"
end
y = e({ o(nil) }, y)
l.monkey_king_talent = y
l.modifier_monkey_king_talent = c()
local z = l.modifier_monkey_king_talent
z.name = "modifier_monkey_king_talent"
d(z, q)
function z.prototype.GetAbilitySpecialValue(self)
	self.hair_count = self:GetAbilitySpecialValueFor("hair_count")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.level_damage = self:GetAbilitySpecialValueFor("level_damage")
	self.physical_damage_bonus = self:GetAbilitySpecialValueFor("physical_damage_bonus")
	self.tl5_hair_count = self:GetAbilityTalentValue("monkey_king_talent_5", "hair_count")
	if IsServer() then
		self:GetParent():AddActivityModifier("walk")
		self:GetParent():AddActivityModifier("attack_normal_range")
	end
end
function z.prototype.OnCreated(self, A)
	if IsServer() then
		self:StartIntervalThink(0.1)
	end
end
function z.prototype.OnIntervalThink(self)
	if IsServer() then
		self:CheckedEffect()
	end
end
function z.prototype.OnTalentLearn(self, A)
	if A.talentName == "monkey_king_talent_7" then
		self:CheckedEffect()
	end
end
function z.prototype.CheckedEffect(self)
	local B = self:GetParent():GetPlayerOwnerID()
	local C = PlayerData:getHero(B)
	if C then
		self:StartIntervalThink(-1)
		if self:HasTalent("monkey_king_talent_7") then
			local D = C.heroTalentBranch
			if D then
				local E = g(v, function(F, G)
					return not f(D, G)
				end)
				if #E > 0 then
					h(E, function(F, H)
						C:learnTalent(H)
					end)
				end
			end
		end
	end
end
function z.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TALENT_LEARN] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
	}
end
function z.prototype.OnCustomTakeDamage(self, I)
	local J = self:GetParent()
	if not J:PassivesDisabled() then
		J:AddNewModifier(J, self:GetAbility(), "modifier_monkey_king_talent_counter", {})
	end
end
function z.prototype.OnBattleStartBefore(self, A)
	self.record = 0
	local K = self:GetParent():GetHeroBase()
	self:SetStackCount(K:getLevel())
	if self:HasTalent("monkey_king_talent_5") then
		self.ringOfFireID = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_monkey_king/ring_of_fire.vpcf",
			PATTACH_CUSTOMORIGIN,
			self:GetParent()
		)
		ParticleManager:SetParticleControl(self.ringOfFireID, 7, self:GetParent():GetAbsOrigin())
		self:AddParticle(self.ringOfFireID, false, false, -1, false, false)
	end
end
function z.prototype.OnBattleEnd(self, A)
	if self.ringOfFireID ~= nil then
		ParticleManager:DestroyParticle(self.ringOfFireID, false)
		self.ringOfFireID = nil
	end
end
function z.prototype.OnCustomAttackLanded(self, I)
	local J = self:GetParent()
	J:RemoveModifierByName("modifier_monkey_king_talent_buff")
	local L = I.target
	if IsInjurable(J, L) then
		if self.enable then
			J:DealDamage(
				L,
				self:GetAbility(),
				self.damage + self:GetStackCount() * self.level_damage,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
				DamageFlags.DAMAGE_FLAG_REFLECTION
					+ DamageFlags.DAMAGE_FLAG_HPLOSS
					+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING
			)
			local M = L:GetAbsOrigin()
			local N = J:GetAbsOrigin() - M
			N.z = 0
			N = N:Normalized()
			local O = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf",
				PATTACH_CUSTOMORIGIN,
				J
			)
			ParticleManager:SetParticleControlTransform(O, 0, M, VectorAngles(N))
			ParticleManager:SetParticleControlEnt(O, 1, L, PATTACH_POINT, "attach_hitloc", M, true)
			ParticleManager:ReleaseParticleIndex(O)
		end
	end
	self.enable = false
end
function z.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_SOURCE_ABILITY }
end
function z.prototype.EOM_GetModifierAttackSourceAbility(self, A)
	if A and not self.enable and self:GetParent():HasModifier("modifier_monkey_king_talent_buff") then
		self.enable = true
	end
end
z = e(
	{
		r(
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
	z
)
l.modifier_monkey_king_talent = z
l.modifier_monkey_king_talent_counter = c()
local P = l.modifier_monkey_king_talent_counter
P.name = "modifier_monkey_king_talent_counter"
d(P, q)
function P.prototype.GetAbilitySpecialValue(self)
	self.hair_count = self:GetAbilitySpecialValueFor("hair_count")
	self.count = self:GetAbilitySpecialValueFor("count")
		- self:GetAbilityTalentValue("monkey_king_talent_8", "count_reduce")
end
function P.prototype.OnCreated(self, A)
	if IsServer() then
		self.stack_particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_stack.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControl(self.stack_particle, 1, Vector(0, 1, 0))
		self:AddParticle(self.stack_particle, false, false, -1, false, true)
		self:IncrementStackCount()
	end
end
function P.prototype.OnRefresh(self, A)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function P.prototype.OnDestroy(self)
	if IsServer() then
	end
end
function P.prototype.OnStackCountChanged(self, Q)
	if IsServer() then
		local R = self:GetStackCount()
		ParticleManager:SetParticleControl(self.stack_particle, 1, Vector(0, R, 0))
		if R >= self.count then
			self:GetParent():AddNewModifier(
				self:GetParent(),
				self:GetAbility(),
				"modifier_monkey_king_talent_hair",
				{ add_count = self.hair_count }
			)
			self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_monkey_king_talent_buff", {})
			self:Destroy()
		end
	end
end
P = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				ShouldUseOverheadOffset = true,
			}
		),
	},
	P
)
l.modifier_monkey_king_talent_counter = P
l.modifier_monkey_king_talent_buff = c()
local S = l.modifier_monkey_king_talent_buff
S.name = "modifier_monkey_king_talent_buff"
d(S, q)
function S.prototype.OnCreated(self, A)
	if IsServer() then
		local J = self:GetParent()
		J:EmitSound("Hero_MonkeyKing.IronCudgel")
	else
		local J = self:GetParent()
		local T = J:GetAbsOrigin()
		local O = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_monkey_king/monkey_king_tap_buff.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(O, 2, J, PATTACH_POINT_FOLLOW, "attach_weapon_top", T, true)
		ParticleManager:SetParticleControlEnt(O, 3, J, PATTACH_POINT_FOLLOW, "attach_weapon_bot", T, true)
		self:AddParticle(O, false, false, -1, false, false)
	end
end
function S.prototype.OnDestroy(self)
	if IsServer() then
	end
end
S = e(
	{
		r(
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
	S
)
l.modifier_monkey_king_talent_buff = S
l.modifier_monkey_king_talent_hair = c()
local U = l.modifier_monkey_king_talent_hair
U.name = "modifier_monkey_king_talent_hair"
d(U, q)
function U.prototype.____constructor(self, ...)
	q.prototype.____constructor(self, ...)
	self.sr_ability_count = 0
end
function U.prototype.AddCustomTransmitterData(self)
	return { sr_ability_count = self.sr_ability_count }
end
function U.prototype.HandleCustomTransmitterData(self, V)
	self.sr_ability_count = Round(V.sr_ability_count)
end
function U.prototype.GetAbilitySpecialValue(self)
	self.hair_count = self:GetAbilitySpecialValueFor("hair_count")
	self.hair_max = self:GetAbilitySpecialValueFor("hair_max")
		+ self:GetAbilityTalentValue("monkey_king_talent_7", "hair_count")
		+ self:GetAbilityTalentValue("monkey_king_shard", "count")
	self.physical_damage_bonus = self:GetAbilitySpecialValueFor("physical_damage_bonus")
		+ self:GetAbilityTalentValue("monkey_king_talent_2", "bonus_damage")
	self.tl1_chance = self:GetAbilityTalentValue("monkey_king_talent_1", "chance")
	self.tl1_duration = self:GetAbilityTalentValue("monkey_king_talent_1", "duration")
	self.tl3_chance = self:GetAbilityTalentValue("monkey_king_talent_3", "chance")
	self.tl5_hair_damage_pct = self:GetAbilityTalentValue("monkey_king_talent_5", "hair_damage_pct")
end
function U.prototype.OnCreated(self, A)
	if IsServer() then
		self:updateLegendAbilityCount()
		if self:GetStackCount() < self.hair_max then
			local J = self:GetParent()
			if self.tl1_chance > 0 and self:PRD(self.tl1_chance, "tl1_chance") then
				J:AddNewModifier(
					J,
					self:GetAbility(),
					"modifier_monkey_king_talent_1",
					{ duration = self.tl1_duration }
				)
			end
			if self.tl3_chance > 0 and self:PRD(self.tl3_chance, "tl3_chance") then
				J:GameTimer(0.1, function()
					if not (IsValid(self) and IsValid(J)) then
						return
					end
					local W = J:FindAbilityByName("monkey_king_ult")
					if IsValid(W) then
						W:HeavyHit()
					end
				end)
			end
			self:IncrementStackCount(math.min(self.hair_max, A and A.add_count or self.hair_count))
		end
	end
end
function U.prototype.OnRefresh(self, A)
	if IsServer() then
		if self:GetStackCount() < self.hair_max then
			local J = self:GetParent()
			if self.tl1_chance > 0 and self:PRD(self.tl1_chance, "tl1_chance") then
				J:AddNewModifier(
					J,
					self:GetAbility(),
					"modifier_monkey_king_talent_1",
					{ duration = self.tl1_duration }
				)
			end
			if self.tl3_chance > 0 and self:PRD(self.tl3_chance, "tl3_chance") then
				J:GameTimer(0.1, function()
					if not (IsValid(self) and IsValid(J)) then
						return
					end
					local W = J:FindAbilityByName("monkey_king_ult")
					if IsValid(W) then
						W:HeavyHit()
					end
				end)
			end
			self:IncrementStackCount(math.min(self.hair_max, A and A.add_count or self.hair_count))
		end
	end
end
function U.prototype.updateLegendAbilityCount(self)
	if IsServer() then
		if self.tl5_hair_damage_pct > 0 then
			local K = self:GetParent():GetHeroBase()
			local X = K:getAbilityUpgradeData(true)
			local x = KeyValues.AbilityUpgradesKvs
			local Y = 0
			j(i(X), function(F, Z)
				local _ = x[Z] or {}
				if _.rarity == "sr" then
					Y = Y + 1
				end
			end)
			self.sr_ability_count = Y
			self:SetHasCustomTransmitterData(true)
		end
	end
end
function U.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_CONSTANT,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE,
	}
end
function U.prototype.EOM_GetModifierOutgoingDamageConstant(self, A)
	if A.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL then
		return self:GetStackCount() * self.physical_damage_bonus
	end
end
function U.prototype.EOM_GetModifierOutgoingDamagePercentage(self)
	if self.tl5_hair_damage_pct > 0 then
		return self.tl5_hair_damage_pct * self.sr_ability_count * self:GetStackCount()
	end
end
U = e(
	{
		r(
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
	U
)
l.modifier_monkey_king_talent_hair = U
l.modifier_monkey_king_talent_1 = c()
local a0 = l.modifier_monkey_king_talent_1
a0.name = "modifier_monkey_king_talent_1"
d(a0, q)
function a0.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ALL_BLOCK_CHANCE] = 100 }
end
function a0.prototype.CheckState(self)
	return { [MODIFIER_STATE_FROZEN] = true }
end
a0 = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				ShouldUseOverheadOffset = true,
				GetEffectName = "particles/units/heroes/hero_monkey_king/monkey_king_fur_army_positions.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
				StatusEffectPriority = MODIFIER_PRIORITY_SUPER_ULTRA,
				GetStatusEffectName = "particles/status_fx/status_effect_monkey_king_fur_army.vpcf",
			}
		),
	},
	a0
)
l.modifier_monkey_king_talent_1 = a0
l.monkey_king_ult = c()
local a1 = l.monkey_king_ult
a1.name = "monkey_king_ult"
d(a1, t)
function a1.prototype.OnSpellStart(self)
	local a2 = self:GetCaster()
	local a3 = a2:GetEnemy()
	if not IsInjurable(a2, a3) then
		return
	end
	local a4 = a2:GetAbsOrigin()
	local N = a3:GetAbsOrigin() - a2:GetAbsOrigin()
	N.z = 0
	N = N:Normalized()
	local a5 = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_monkey_king/monkey_king_strike_cast.vpcf",
		PATTACH_CUSTOMORIGIN,
		a2
	)
	ParticleManager:SetParticleControlTransform(a5, 0, a4, VectorAngles(N))
	ParticleManager:SetParticleControlEnt(a5, 1, a2, PATTACH_POINT_FOLLOW, "attach_weapon_bot", a4, true)
	ParticleManager:SetParticleControlEnt(a5, 2, a2, PATTACH_POINT_FOLLOW, "attach_weapon_top", a4, true)
	ParticleManager:ReleaseParticleIndex(a5)
	a2:StartGesture(ACT_DOTA_MK_STRIKE)
	a2:EmitSound("Hero_MonkeyKing.Strike.Cast")
	self:GameTimer(0.42, function()
		self:HeavyHit()
	end)
end
function a1.prototype.HeavyHit(self)
	local a2 = self:GetCaster()
	local a3 = a2:GetEnemy()
	if not IsInjurable(a2, a3) then
		return
	end
	local a6 = self:GetSpecialValueFor("damage")
	local a7 = self:GetSpecialValueFor("hair_damage")
	local a8 = self:GetSpecialValueFor("stun_duration")
	local a9 = self:GetTalentValue("monkey_king_talent_4", "hair_count")
	local aa = self:GetTalentValue("monkey_king_talent_4", "bonus_damage_pct")
	local ab = self:GetTalentValue("monkey_king_talent_4", "max_pct")
	local ac = a2:GetModifierStackCount("modifier_monkey_king_talent_hair", a2)
	local ad = a6 + a7 * ac
	if a9 > 0 then
		ad = ad * (1 + math.min(ab, aa * ac) * 0.01)
	end
	local a4 = a2:GetAbsOrigin()
	local N = a3:GetAbsOrigin() - a2:GetAbsOrigin()
	N.z = 0
	N = N:Normalized()
	local ae = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_monkey_king/monkey_king_strike.vpcf",
		PATTACH_CUSTOMORIGIN,
		a2
	)
	ParticleManager:SetParticleControlTransform(ae, 0, a4, VectorAngles(N))
	ParticleManager:SetParticleControl(ae, 1, a4 + N * 1200)
	ParticleManager:ReleaseParticleIndex(ae)
	a2:EmitSound("Hero_MonkeyKing.Strike.Impact")
	a3:EmitSound("Hero_MonkeyKing.Strike.Impact.EndPos")
	if a2:HasItemInInventory("item_equipment_92") then
		DamageSystem:performAttack(
			a2,
			a3,
			{ damage = ad, ability = self, damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL }
		)
	else
		a2:DealDamage(a3, self, ad, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
	end
	a3:EmitSound("Hero_MonkeyKing.Attack.Ring")
	AddStun(a2, a3, self, a8)
	a3:AddNewModifier(a2, self, "monkey_king_ult_stun", { duration = a8 })
end
a1 = e({ u(nil) }, a1)
l.monkey_king_ult = a1
l.monkey_king_ult_stun = c()
local af = l.monkey_king_ult_stun
af.name = "monkey_king_ult_stun"
d(af, q)
function af.prototype.OnCreated(self, A)
	if IsClient() then
		local Z = ParticleManager:CreateParticle(
			"particles/econ/items/zeus/zeus_immortal_2021/zuus_shard_gold_impact.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(
			Z,
			1,
			self:GetParent(),
			PATTACH_ABSORIGIN_FOLLOW,
			nil,
			self:GetParent():GetAbsOrigin(),
			true
		)
		self:AddParticle(Z, false, false, -1, false, false)
	end
end
function af.prototype.CheckState(self)
	return { [MODIFIER_STATE_FROZEN] = true }
end
af = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetEffectName = "particles/units/heroes/hero_techies/techies_tazer.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
				GetStatusEffectName = "particles/status_fx/status_effect_windrunner_tgt_arcana.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_ULTRA,
			}
		),
	},
	af
)
l.monkey_king_ult_stun = af
return l