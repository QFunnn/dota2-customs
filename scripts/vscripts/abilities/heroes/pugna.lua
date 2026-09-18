--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/pugna"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIndexOf
local g = b.__TS__ArraySplice
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 1,
		["13"] = 2,
		["14"] = 2,
		["15"] = 2,
		["16"] = 3,
		["17"] = 3,
		["18"] = 3,
		["19"] = 5,
		["20"] = 6,
		["21"] = 8,
		["22"] = 15,
		["23"] = 16,
		["24"] = 15,
		["25"] = 16,
		["26"] = 17,
		["27"] = 17,
		["28"] = 17,
		["29"] = 16,
		["30"] = 15,
		["31"] = 16,
		["33"] = 16,
		["34"] = 20,
		["35"] = 21,
		["36"] = 20,
		["37"] = 21,
		["39"] = 21,
		["40"] = 22,
		["41"] = 23,
		["42"] = 20,
		["43"] = 24,
		["44"] = 25,
		["45"] = 25,
		["46"] = 25,
		["47"] = 25,
		["48"] = 24,
		["49"] = 27,
		["50"] = 28,
		["51"] = 28,
		["52"] = 28,
		["53"] = 28,
		["54"] = 28,
		["55"] = 28,
		["56"] = 28,
		["57"] = 28,
		["59"] = 28,
		["61"] = 27,
		["62"] = 30,
		["63"] = 31,
		["64"] = 31,
		["65"] = 31,
		["66"] = 31,
		["67"] = 31,
		["68"] = 31,
		["69"] = 31,
		["70"] = 30,
		["71"] = 39,
		["72"] = 40,
		["73"] = 41,
		["74"] = 42,
		["75"] = 39,
		["76"] = 44,
		["77"] = 45,
		["78"] = 46,
		["79"] = 47,
		["80"] = 48,
		["81"] = 44,
		["82"] = 50,
		["83"] = 51,
		["84"] = 51,
		["86"] = 50,
		["87"] = 53,
		["88"] = 54,
		["89"] = 55,
		["90"] = 55,
		["92"] = 53,
		["93"] = 57,
		["94"] = 58,
		["95"] = 59,
		["98"] = 60,
		["99"] = 61,
		["100"] = 62,
		["101"] = 64,
		["102"] = 57,
		["103"] = 66,
		["104"] = 67,
		["107"] = 68,
		["108"] = 69,
		["109"] = 70,
		["110"] = 70,
		["112"] = 71,
		["113"] = 71,
		["115"] = 72,
		["116"] = 74,
		["117"] = 66,
		["118"] = 76,
		["119"] = 78,
		["120"] = 79,
		["121"] = 79,
		["122"] = 80,
		["123"] = 81,
		["124"] = 82,
		["125"] = 84,
		["126"] = 84,
		["127"] = 84,
		["128"] = 84,
		["130"] = 85,
		["131"] = 85,
		["132"] = 86,
		["133"] = 88,
		["134"] = 88,
		["135"] = 88,
		["136"] = 88,
		["137"] = 88,
		["138"] = 93,
		["139"] = 85,
		["142"] = 95,
		["143"] = 96,
		["144"] = 96,
		["145"] = 96,
		["146"] = 97,
		["149"] = 98,
		["150"] = 99,
		["153"] = 102,
		["154"] = 104,
		["155"] = 105,
		["156"] = 105,
		["157"] = 105,
		["158"] = 106,
		["159"] = 106,
		["161"] = 105,
		["162"] = 105,
		["163"] = 108,
		["165"] = 109,
		["166"] = 109,
		["167"] = 109,
		["168"] = 109,
		["171"] = 96,
		["172"] = 96,
		["173"] = 76,
		["174"] = 112,
		["175"] = 113,
		["176"] = 116,
		["178"] = 117,
		["179"] = 118,
		["180"] = 118,
		["182"] = 119,
		["183"] = 119,
		["184"] = 120,
		["185"] = 122,
		["186"] = 122,
		["187"] = 122,
		["188"] = 122,
		["189"] = 122,
		["193"] = 112,
		["194"] = 125,
		["195"] = 126,
		["196"] = 127,
		["197"] = 128,
		["199"] = 130,
		["200"] = 125,
		["201"] = 132,
		["202"] = 133,
		["203"] = 134,
		["204"] = 135,
		["205"] = 136,
		["206"] = 136,
		["208"] = 132,
		["209"] = 138,
		["210"] = 139,
		["211"] = 140,
		["212"] = 141,
		["214"] = 143,
		["215"] = 138,
		["216"] = 145,
		["217"] = 146,
		["220"] = 147,
		["221"] = 148,
		["222"] = 148,
		["223"] = 148,
		["224"] = 148,
		["225"] = 148,
		["226"] = 145,
		["227"] = 150,
		["228"] = 151,
		["229"] = 150,
		["230"] = 153,
		["231"] = 155,
		["232"] = 153,
		["233"] = 157,
		["234"] = 158,
		["235"] = 157,
		["236"] = 160,
		["237"] = 161,
		["240"] = 162,
		["241"] = 163,
		["242"] = 164,
		["243"] = 164,
		["244"] = 164,
		["245"] = 164,
		["246"] = 164,
		["247"] = 164,
		["248"] = 164,
		["250"] = 165,
		["251"] = 166,
		["252"] = 167,
		["253"] = 168,
		["254"] = 169,
		["255"] = 169,
		["256"] = 169,
		["257"] = 169,
		["258"] = 169,
		["259"] = 169,
		["260"] = 169,
		["261"] = 170,
		["262"] = 171,
		["263"] = 173,
		["264"] = 174,
		["265"] = 174,
		["266"] = 174,
		["267"] = 174,
		["268"] = 174,
		["269"] = 174,
		["270"] = 174,
		["271"] = 175,
		["272"] = 176,
		["273"] = 177,
		["277"] = 181,
		["278"] = 181,
		["279"] = 181,
		["280"] = 181,
		["281"] = 181,
		["284"] = 160,
		["285"] = 184,
		["286"] = 185,
		["289"] = 186,
		["290"] = 187,
		["291"] = 187,
		["292"] = 187,
		["293"] = 187,
		["294"] = 187,
		["295"] = 187,
		["297"] = 184,
		["298"] = 21,
		["299"] = 20,
		["300"] = 21,
		["302"] = 21,
		["303"] = 192,
		["304"] = 200,
		["305"] = 192,
		["306"] = 200,
		["307"] = 201,
		["308"] = 202,
		["309"] = 202,
		["310"] = 202,
		["311"] = 202,
		["312"] = 202,
		["313"] = 201,
		["314"] = 200,
		["315"] = 192,
		["316"] = 192,
		["317"] = 192,
		["318"] = 192,
		["319"] = 192,
		["320"] = 192,
		["321"] = 192,
		["322"] = 192,
		["323"] = 200,
		["325"] = 200,
		["326"] = 210,
		["327"] = 211,
		["328"] = 210,
		["329"] = 211,
		["330"] = 212,
		["331"] = 213,
		["332"] = 214,
		["333"] = 214,
		["334"] = 214,
		["335"] = 214,
		["338"] = 215,
		["339"] = 216,
		["340"] = 217,
		["342"] = 220,
		["343"] = 220,
		["345"] = 221,
		["346"] = 222,
		["347"] = 224,
		["348"] = 225,
		["349"] = 212,
		["350"] = 211,
		["351"] = 210,
		["352"] = 211,
		["354"] = 211,
		["355"] = 229,
		["356"] = 230,
		["357"] = 229,
		["358"] = 230,
		["359"] = 234,
		["360"] = 234,
		["361"] = 234,
		["362"] = 235,
		["363"] = 236,
		["366"] = 237,
		["367"] = 238,
		["368"] = 238,
		["369"] = 238,
		["370"] = 238,
		["371"] = 239,
		["372"] = 239,
		["373"] = 239,
		["374"] = 239,
		["375"] = 241,
		["376"] = 242,
		["377"] = 242,
		["378"] = 242,
		["379"] = 242,
		["380"] = 242,
		["381"] = 242,
		["382"] = 242,
		["383"] = 242,
		["384"] = 242,
		["385"] = 243,
		["386"] = 243,
		["387"] = 243,
		["388"] = 243,
		["389"] = 243,
		["390"] = 243,
		["391"] = 243,
		["392"] = 243,
		["393"] = 243,
		["394"] = 244,
		["395"] = 244,
		["396"] = 244,
		["397"] = 244,
		["398"] = 244,
		["399"] = 245,
		["400"] = 245,
		["401"] = 245,
		["402"] = 245,
		["403"] = 245,
		["404"] = 245,
		["405"] = 245,
		["406"] = 245,
		["407"] = 246,
		["408"] = 247,
		["409"] = 249,
		["410"] = 235,
		["411"] = 251,
		["412"] = 252,
		["413"] = 252,
		["416"] = 253,
		["417"] = 253,
		["418"] = 253,
		["419"] = 253,
		["420"] = 254,
		["421"] = 254,
		["422"] = 254,
		["423"] = 254,
		["424"] = 254,
		["425"] = 254,
		["426"] = 255,
		["427"] = 255,
		["428"] = 255,
		["429"] = 255,
		["430"] = 255,
		["431"] = 255,
		["432"] = 256,
		["433"] = 257,
		["434"] = 257,
		["436"] = 251,
		["437"] = 259,
		["438"] = 260,
		["439"] = 261,
		["441"] = 259,
		["442"] = 230,
		["443"] = 229,
		["444"] = 230,
		["446"] = 230,
		["447"] = 266,
		["448"] = 267,
		["449"] = 266,
		["450"] = 267,
		["451"] = 268,
		["452"] = 268,
		["453"] = 268,
		["454"] = 269,
		["455"] = 269,
		["456"] = 269,
		["457"] = 270,
		["458"] = 271,
		["459"] = 270,
		["460"] = 273,
		["461"] = 273,
		["462"] = 273,
		["463"] = 274,
		["464"] = 274,
		["465"] = 274,
		["466"] = 275,
		["467"] = 275,
		["468"] = 275,
		["469"] = 267,
		["470"] = 266,
		["471"] = 267,
		["473"] = 267,
		["474"] = 278,
		["475"] = 280,
		["476"] = 281,
		["477"] = 280,
		["478"] = 281,
		["480"] = 281,
		["481"] = 283,
		["482"] = 280,
		["483"] = 284,
		["484"] = 285,
		["485"] = 286,
		["486"] = 286,
		["487"] = 286,
		["488"] = 286,
		["491"] = 287,
		["492"] = 287,
		["494"] = 288,
		["495"] = 289,
		["496"] = 291,
		["497"] = 292,
		["498"] = 293,
		["499"] = 294,
		["500"] = 295,
		["501"] = 295,
		["502"] = 295,
		["503"] = 295,
		["504"] = 295,
		["505"] = 295,
		["506"] = 295,
		["507"] = 295,
		["508"] = 295,
		["509"] = 289,
		["510"] = 297,
		["511"] = 298,
		["512"] = 298,
		["513"] = 298,
		["514"] = 298,
		["515"] = 298,
		["516"] = 298,
		["517"] = 298,
		["518"] = 298,
		["519"] = 298,
		["521"] = 301,
		["522"] = 301,
		["523"] = 301,
		["524"] = 301,
		["525"] = 302,
		["526"] = 302,
		["527"] = 302,
		["528"] = 302,
		["529"] = 302,
		["530"] = 302,
		["531"] = 302,
		["532"] = 302,
		["533"] = 303,
		["536"] = 304,
		["537"] = 305,
		["538"] = 306,
		["540"] = 284,
		["541"] = 281,
		["542"] = 280,
		["543"] = 281,
		["545"] = 281,
		["546"] = 311,
		["547"] = 313,
		["548"] = 311,
		["549"] = 313,
		["551"] = 313,
		["552"] = 314,
		["553"] = 311,
		["554"] = 315,
		["555"] = 316,
		["558"] = 318,
		["559"] = 319,
		["560"] = 321,
		["561"] = 321,
		["562"] = 321,
		["563"] = 321,
		["564"] = 321,
		["565"] = 321,
		["566"] = 321,
		["567"] = 321,
		["568"] = 321,
		["569"] = 322,
		["570"] = 322,
		["571"] = 322,
		["572"] = 322,
		["573"] = 322,
		["574"] = 322,
		["575"] = 322,
		["576"] = 322,
		["577"] = 322,
		["578"] = 323,
		["579"] = 323,
		["580"] = 323,
		["581"] = 323,
		["582"] = 323,
		["583"] = 323,
		["584"] = 323,
		["585"] = 323,
		["586"] = 324,
		["587"] = 315,
		["588"] = 326,
		["589"] = 327,
		["590"] = 326,
		["591"] = 333,
		["592"] = 334,
		["593"] = 335,
		["594"] = 335,
		["595"] = 335,
		["596"] = 334,
		["597"] = 334,
		["598"] = 334,
		["599"] = 333,
		["600"] = 339,
		["601"] = 339,
		["602"] = 339,
		["603"] = 340,
		["604"] = 341,
		["607"] = 343,
		["610"] = 344,
		["611"] = 345,
		["612"] = 346,
		["615"] = 347,
		["616"] = 348,
		["617"] = 348,
		["618"] = 349,
		["619"] = 350,
		["620"] = 351,
		["621"] = 351,
		["622"] = 351,
		["623"] = 351,
		["624"] = 351,
		["625"] = 351,
		["626"] = 351,
		["627"] = 351,
		["628"] = 351,
		["629"] = 352,
		["630"] = 352,
		["631"] = 352,
		["632"] = 352,
		["633"] = 352,
		["634"] = 352,
		["635"] = 352,
		["636"] = 352,
		["637"] = 352,
		["638"] = 353,
		["639"] = 354,
		["640"] = 355,
		["641"] = 340,
		["642"] = 357,
		["643"] = 358,
		["644"] = 359,
		["645"] = 361,
		["647"] = 363,
		["650"] = 357,
		["651"] = 313,
		["652"] = 311,
		["653"] = 313,
		["655"] = 313,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseAbility
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
local p = require("abilities.ability_ai")
local q = p.BaseAbilityAI
local r = p.registerAbilityAI
local s = 220
local t = 0.8
local u = 3.5
i.pugna_talent = c()
local v = i.pugna_talent
v.name = "pugna_talent"
d(v, k)
function v.prototype.GetIntrinsicModifierName(self)
	return "modifier_pugna_talent"
end
v = e({ l(nil) }, v)
i.pugna_talent = v
i.modifier_pugna_talent = c()
local w = i.modifier_pugna_talent
w.name = "modifier_pugna_talent"
d(w, n)
function w.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.battleActive = false
	self.blastWaves = {}
end
function w.prototype.GetBlastInterval(self)
	return math.max(
		FRAME_TIME,
		self:GetAbilitySpecialValueFor("interval") - self:GetAbilityTalentValue("pugna_talent_7", "interval_reduce")
	)
end
function w.prototype.OnCreated(self)
	if IsServer() then
		local x = self.SetStackCount
		local y = PlayerData:loadData(self.parent:GetPlayerOwnerID(), "pugna_wisp_kills")
		if y == nil then
			y = 0
		end
		x(self, y)
	end
end
function w.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE] = { self.parent, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self.parent, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_HEAL] = { self.parent, -1 },
	}
end
function w.prototype.OnBattleStartBefore(self)
	self:ClearBlastEffect()
	self.battleActive = true
	self:StartIntervalThink(self:GetBlastInterval())
end
function w.prototype.OnBattleEnd(self)
	self.battleActive = false
	self:StartIntervalThink(-1)
	self:ClearBlastEffect()
	self.parent:RemoveModifierByName("modifier_pugna_ult")
end
function w.prototype.OnDestroy(self)
	if IsServer() then
		self:ClearBlastEffect()
	end
end
function w.prototype.OnIntervalThink(self)
	self:NetherBlast()
	if self.battleActive then
		self:StartIntervalThink(self:GetBlastInterval())
	end
end
function w.prototype.NetherBlast(self)
	local z = self.parent:GetEnemy()
	if not self.battleActive or self.parent:PassivesDisabled() or not IsInjurable(self.parent, z) then
		return
	end
	local A = self:GetAbilityTalentValue("pugna_talent_11", "level")
	local B = A > 0
			and math.floor(self.parent:GetHeroBase():getLevel() / A) * self:GetAbilityTalentValue(
				"pugna_talent_11",
				"count"
			)
		or 0
	local C = 1 + B
	self:PlayBlastEffect(C, z)
end
function w.prototype.BlastOnce(self, z)
	if
		not self.battleActive
		or self.parent:GetEnemy() ~= z
		or self.parent:PassivesDisabled()
		or not IsInjurable(self.parent, z)
	then
		return
	end
	local D = self:GetAbilityTalentValue("pugna_talent_9", "duration")
	local E = self:GetAbilityTalentValue("pugna_talent_10", "duration")
	if D > 0 then
		z:AddNewModifier(self.parent, self.ability, "modifier_pugna_talent1", { duration = D })
	end
	if E > 0 then
		self.parent:AddNewModifier(self.parent, self.ability, "modifier_pugna_talent1", { duration = E })
	end
	local F = self:GetAbilitySpecialValueFor("damage_base")
		+ self:GetAbilityTalentValue("pugna_talent_7", "damage_bonus")
		+ GetWispHealth(self.parent, { first = true }) * self:GetAbilitySpecialValueFor("damage_health_bonus") * 0.01
	self.parent:DealDamage(z, self.ability, F, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
end
function w.prototype.PlayBlastEffect(self, C, z)
	local G = { particles = {}, cancelled = false }
	local H = self.blastWaves
	H[#H + 1] = G
	local I = {}
	local J = z:GetAbsOrigin()
	local K = z:GetForwardVector()
	local L = C == 1 and 400 or math.min(180, s * math.sin(math.pi / C) * 0.85)
	do
		local M = 0
		while M < C do
			local N = 2 * math.pi * M / C
			local O = C == 1 and J
				or Vector(
					J.x + s * (-K.y * math.cos(N) + K.x * math.sin(N)),
					J.y + s * (K.x * math.cos(N) + K.y * math.sin(N)),
					J.z
				)
			I[#I + 1] = GetGroundPosition(O, z)
			M = M + 1
		end
	end
	self:PlayBlastStage(G, I, L, true)
	GameTimer(t, function()
		if not IsValid(self) or G.cancelled then
			return
		end
		if
			not self.battleActive
			or not IsInjurable(self.parent, z)
			or self.parent:GetEnemy() ~= z
			or self.parent:PassivesDisabled()
		then
			self:RemoveBlastWave(G)
			return
		end
		self:ClearBlastParticles(G)
		self:PlayBlastStage(G, I, L, false)
		GameTimer(u, function()
			if IsValid(self) and not G.cancelled then
				self:RemoveBlastWave(G)
			end
		end)
		EmitSoundOn("Hero_Pugna.NetherBlast", z)
		do
			local M = 0
			while M < C do
				self:BlastOnce(z)
				M = M + 1
			end
		end
	end)
end
function w.prototype.PlayBlastStage(self, G, I, P, Q)
	local R = Q and "particles/econ/items/pugna/pugna_ti9_immortal/pugna_ti9_immortal_netherblast_pre.vpcf"
		or "particles/econ/items/pugna/pugna_ti9_immortal/pugna_ti9_immortal_netherblast.vpcf"
	for S, O in ipairs(I) do
		do
			local T = ParticleManager:CreateParticle(R, PATTACH_WORLDORIGIN, self.parent)
			if T == -1 then
				goto U
			end
			local V = G.particles
			V[#V + 1] = T
			ParticleManager:SetParticleControl(T, 0, O)
			ParticleManager:SetParticleControl(T, 1, Q and Vector(300, 300, 300) or Vector(P, 0, 0))
		end
		::U::
	end
end
function w.prototype.ClearBlastParticles(self, G)
	for S, T in ipairs(G.particles) do
		ParticleManager:DestroyParticle(T, true)
		ParticleManager:ReleaseParticleIndex(T)
	end
	G.particles = {}
end
function w.prototype.RemoveBlastWave(self, G)
	G.cancelled = true
	self:ClearBlastParticles(G)
	local W = f(self.blastWaves, G)
	if W >= 0 then
		g(self.blastWaves, W, 1)
	end
end
function w.prototype.ClearBlastEffect(self)
	for S, G in ipairs(self.blastWaves) do
		G.cancelled = true
		self:ClearBlastParticles(G)
	end
	self.blastWaves = {}
end
function w.prototype.OnWispDie(self, X)
	if
		X.remove
		or X.attacker ~= self.parent
		or X.target ~= self.parent:GetEnemy()
		or self.parent:IsCustomIllusion()
	then
		return
	end
	self:IncrementStackCount()
	PlayerData:saveData(self.parent:GetPlayerOwnerID(), "pugna_wisp_kills", self:GetStackCount())
end
function w.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_HEALTH_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_DAMAGE_OUTGOING_TO_WISP,
	}
end
function w.prototype.EOM_GetModifierDamageOutgoingToWisp(self, X)
	return (X and X.ability) == self.ability and self:GetAbilitySpecialValueFor("damage_wisp_bonus") or 0
end
function w.prototype.EOM_GetModifierWispHealthPercentage(self, X)
	return X and X.first and self:GetStackCount() * self:GetAbilitySpecialValueFor("wsip_health_bonus") or 0
end
function w.prototype.OnCustomTakeDamage(self, Y)
	if Y.attacker ~= self.parent or Y.damage <= 0 or not IsValid(Y.ability) then
		return
	end
	if Y.ability == self.ability then
		local Z = Y.damage * self:GetAbilityTalentValue("pugna_talent_11", "reply_damage") * 0.01
		if Z > 0 and IsInjurable(self.parent) then
			Heal(self.parent, Z, self.ability:GetAbilityName(), "Ability")
		end
	elseif Y.ability:GetAbilityName() == "pugna_ult" then
		local _ = self:GetAbilityTalentValue("pugna_talent_8", "ult_bonus_steal")
		if _ > 0 then
			local a0 = self.parent:AddNewModifier(self.parent, Y.ability, "modifier_pugna_ult_power", {})
			local a1 =
				math.min(_, math.max(0, self:GetAbilityTalentValue("pugna_talent_8", "limit") - a0:GetStackCount()))
			a0:SetStackCount(a0:GetStackCount() + a1)
			if a1 > 0 and IsValid(Y.target) then
				local a2 = GetModifierProperty(Y.target, EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER)
				local a3 = math.min(a1, math.max(0, math.floor(a2)))
				if a3 > 0 then
					local a4 = Y.target:AddNewModifier(self.parent, Y.ability, "modifier_pugna_ult_power", {})
					a4:SetStackCount(a4:GetStackCount() + a3)
				end
			end
		end
		if self:PRD(self:GetAbilityTalentValue("pugna_talent_12", "chance"), "pugna_drain_blast") then
			self:NetherBlast()
		end
	end
end
function w.prototype.OnHeal(self, X)
	if X.origin ~= "pugna_ult" then
		return
	end
	local Z = X.flHealAmount * self:GetAbilityTalentValue("pugna_talent_12", "wisp_reply") * 0.01
	if Z > 0 then
		HealWisp(self.parent, self.parent:FindAbilityByName("pugna_ult"), Z)
	end
end
w = e({ o(a, { IsHidden = true, IsPurgable = false, AllowIllusionDuplicate = false }) }, w)
i.modifier_pugna_talent = w
i.modifier_pugna_talent1 = c()
local a5 = i.modifier_pugna_talent1
a5.name = "modifier_pugna_talent1"
d(a5, n)
function a5.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE] = -BUFF_VALUE.AnilePhysicalDmgReducePct,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE] = BUFF_VALUE.AnileMagicalDmgAddPct,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_AMPLIFY] = self.caster == self:GetParent()
				and BUFF_VALUE.AnileSelfAddHealPct
			or 0,
	}
end
a5 = e(
	{
		o(
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
	a5
)
i.modifier_pugna_talent1 = a5
i.pugna_ult = c()
local a6 = i.pugna_ult
a6.name = "pugna_ult"
d(a6, q)
function a6.prototype.OnSpellStart(self)
	local a7 = self:GetCaster()
	if not IsInjurable(a7, a7:GetEnemy()) then
		return
	end
	local a8 = a7:FindAbilityByName("pugna_nether_ward")
	if not IsValid(a8) then
		a8 = a7:AddAbility_Engine("pugna_nether_ward")
	end
	if a8:GetLevel() < 1 then
		a8:SetLevel(1)
	end
	a8:SetHidden(true)
	a8:OnSpellStart()
	a7:RemoveModifierByName("modifier_pugna_ult")
	a7:AddNewModifier(a7, self, "modifier_pugna_ult", {})
end
a6 = e({ r(nil) }, a6)
i.pugna_ult = a6
i.modifier_pugna_ult = c()
local a9 = i.modifier_pugna_ult
a9.name = "modifier_pugna_ult"
d(a9, n)
function a9.prototype.GetTexture(self)
	return "pugna_life_drain"
end
function a9.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.target = self.caster:GetEnemy()
	self.interval = math.max(
		FRAME_TIME,
		self:GetAbilitySpecialValueFor("interval") - self:GetAbilityTalentValue("pugna_talent_12", "interval_reduce")
	)
	self.ticks = math.max(1, math.floor(self:GetAbilitySpecialValueFor("duration") / self.interval))
	local T = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_pugna/pugna_life_drain.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.caster
	)
	ParticleManager:SetParticleControlEnt(T, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_head", vec3_zero, true)
	ParticleManager:SetParticleControlEnt(T, 1, self.target, PATTACH_POINT_FOLLOW, "attach_hitloc", vec3_zero, true)
	ParticleManager:SetParticleControl(T, 61, Vector(1, 0, 0))
	self:AddParticle(T, false, false, -1, false, false)
	EmitSoundOn("Hero_Pugna.LifeDrain.Cast", self.caster)
	EmitSoundOn("Hero_Pugna.LifeDrain.Loop", self.caster)
	self:StartIntervalThink(self.interval)
end
function a9.prototype.OnIntervalThink(self)
	if not IsInjurable(self.caster, self.target) then
		self:Destroy()
		return
	end
	local aa = math.max(0, 1 + GetUltiPower(self.caster) * 0.01)
	self.caster:DealDamage(
		self.target,
		self.ability,
		self:GetAbilitySpecialValueFor("magic_damage") * aa,
		EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
	)
	Heal(self.caster, self:GetAbilitySpecialValueFor("reply") * aa, self.ability:GetAbilityName(), "Ability")
	self.ticks = self.ticks - 1
	if self.ticks <= 0 then
		self:Destroy()
	end
end
function a9.prototype.OnDestroy(self)
	if IsServer() and IsValid(self.caster) then
		StopSoundOn("Hero_Pugna.LifeDrain.Loop", self.caster)
	end
end
a9 = e({ o(a, { IsHidden = false, IsPurgable = false, AllowIllusionDuplicate = false }) }, a9)
i.modifier_pugna_ult = a9
i.modifier_pugna_ult_power = c()
local ab = i.modifier_pugna_ult_power
ab.name = "modifier_pugna_ult_power"
d(ab, n)
function ab.prototype.GetTexture(self)
	return "pugna_life_drain"
end
function ab.prototype.IsDebuff(self)
	return self.parent ~= self.caster
end
function ab.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent } }
end
function ab.prototype.OnBattleEnd(self)
	self:Destroy()
end
function ab.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER }
end
function ab.prototype.EOM_GetModifierUltiPower(self)
	return (self.parent == self.caster and 1 or -1) * self:GetStackCount()
end
ab = e({ o(a, { IsHidden = false, IsPurgable = false, AllowIllusionDuplicate = false }) }, ab)
i.modifier_pugna_ult_power = ab
local ac = "models/heroes/pugna/pugna_ward.vmdl"
i.pugna_nether_ward = c()
local ad = i.pugna_nether_ward
ad.name = "pugna_nether_ward"
d(ad, k)
function ad.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.nextCounterTime = 0
end
function ad.prototype.OnSpellStart(self)
	local a7 = self:GetCaster()
	if not IsInjurable(a7, a7:GetEnemy()) then
		return
	end
	if self:GetLevel() < 1 then
		self:SetLevel(1)
	end
	local ae = self:HasTalent("pugna_shard")
	local function af(S, a8)
		a8:RemoveModifierByName("modifier_sect_wisp_status")
		a8:SetOriginalModel(ac)
		a8:SetModel(ac)
		a8:SetModelScale(1)
		a8:AddNewModifier(
			a7,
			self,
			"modifier_pugna_nether_ward_custom",
			{ duration = self:GetSpecialValueFor("duration"), isWisp = ae and 1 or 0 }
		)
	end
	if ae then
		SummonWisp(a7, math.max(1, GetWispHealth(a7, { first = true })), ac, function(a8)
			return af(nil, a8)
		end)
	else
		local O = GetGroundPosition(a7:GetAbsOrigin() + a7:GetForwardVector() * -100, a7)
		local a8 = CreateUnitFromTable({ MapUnitName = "npc_wisp", StatusHealth = 1, teamnumber = a7:GetTeam() }, O)
		if not IsValid(a8) then
			return
		end
		a8:SetForwardVector(a7:GetForwardVector())
		af(nil, a8)
		EmitSoundOn("Portal.Hero_Appear", a8)
	end
end
ad = e({ l(nil) }, ad)
i.pugna_nether_ward = ad
i.modifier_pugna_nether_ward_custom = c()
local ag = i.modifier_pugna_nether_ward_custom
ag.name = "modifier_pugna_nether_ward_custom"
d(ag, n)
function ag.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.isWisp = false
end
function ag.prototype.OnCreated(self, X)
	if not IsServer() then
		return
	end
	self.isWisp = X.isWisp == 1
	local T = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_pugna/pugna_ward_ambient.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		T,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		self.parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		T,
		1,
		self.parent,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		self.parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(T, false, false, -1, false, false)
	EmitSoundOn("Hero_Pugna.NetherWard", self.parent)
end
function ag.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function ag.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self.caster:GetEnemy(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.caster, self.caster },
	}
end
function ag.prototype.OnBattleEnd(self)
	self:Destroy()
end
function ag.prototype.OnCustomAbilityFullyCast(self, Y)
	if not IsServer() or Y.unit ~= self.caster:GetEnemy() or not IsInjurable(self.parent, self.caster, Y.unit) then
		return
	end
	if not IsValid(Y.ability) or Y.ability ~= Y.unit:GetAbilityByIndex(1) then
		return
	end
	local ah = self.ability
	local ai = GameRules:GetGameTime()
	if ai < ah.nextCounterTime then
		return
	end
	ah.nextCounterTime = ai + 1
	local aj = Y.unit:GetHeroBase()
	local ak = aj and aj:getSectAbilityExp("sect_ulti") or 0
	local F = self:GetAbilitySpecialValueFor("nether_ward_damage_base")
		+ ak * self:GetAbilitySpecialValueFor("nether_ward_damage_bonus")
	local T = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_pugna/pugna_ward_attack.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		T,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		T,
		1,
		Y.unit,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Y.unit:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(T)
	EmitSoundOn("Hero_Pugna.NetherWard.Attack", self.parent)
	self.caster:DealDamage(Y.unit, ah, F, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
end
function ag.prototype.OnDestroy(self)
	if IsServer() and IsInjurable(self.parent) then
		if self.isWisp then
			KillWisp(self.caster, self.parent, true)
		else
			self.parent:ForceKill(false)
		end
	end
end
ag = e({ o(a, { IsHidden = true, IsPurgable = false, AllowIllusionDuplicate = false }) }, ag)
i.modifier_pugna_nether_ward_custom = ag
return i