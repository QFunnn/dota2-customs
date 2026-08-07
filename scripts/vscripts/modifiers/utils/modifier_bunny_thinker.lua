--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_bunny_thinker"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayIncludes
local f = b.__TS__ObjectKeys
local g = b.__TS__ArrayFilter
local h = b.__TS__ArraySort
local i = b.__TS__ArrayIndexOf
local j = b.__TS__ObjectEntries
local k = b.__TS__ArrayForEach
local l = b.__TS__ObjectValues
local m = b.__TS__DecorateLegacy
local n = b.__TS__SourceMapTraceBack
n(
	debug.getinfo(1).short_src,
	{
		["16"] = 1,
		["17"] = 1,
		["18"] = 1,
		["19"] = 3,
		["20"] = 4,
		["21"] = 12,
		["22"] = 4,
		["23"] = 12,
		["25"] = 12,
		["26"] = 17,
		["27"] = 21,
		["28"] = 22,
		["29"] = 23,
		["30"] = 28,
		["31"] = 29,
		["32"] = 30,
		["33"] = 31,
		["34"] = 32,
		["35"] = 4,
		["36"] = 34,
		["37"] = 35,
		["38"] = 36,
		["39"] = 38,
		["40"] = 39,
		["41"] = 42,
		["42"] = 43,
		["43"] = 44,
		["45"] = 46,
		["46"] = 47,
		["47"] = 48,
		["49"] = 50,
		["52"] = 56,
		["53"] = 34,
		["54"] = 58,
		["55"] = 59,
		["56"] = 58,
		["57"] = 68,
		["58"] = 70,
		["59"] = 71,
		["60"] = 72,
		["61"] = 73,
		["62"] = 74,
		["63"] = 75,
		["64"] = 76,
		["65"] = 77,
		["66"] = 78,
		["69"] = 81,
		["70"] = 82,
		["73"] = 83,
		["77"] = 86,
		["80"] = 87,
		["81"] = 88,
		["85"] = 91,
		["88"] = 92,
		["89"] = 93,
		["93"] = 96,
		["96"] = 97,
		["100"] = 100,
		["103"] = 101,
		["107"] = 104,
		["110"] = 105,
		["114"] = 108,
		["117"] = 109,
		["123"] = 113,
		["129"] = 119,
		["130"] = 120,
		["131"] = 120,
		["132"] = 120,
		["133"] = 120,
		["134"] = 121,
		["135"] = 121,
		["136"] = 121,
		["137"] = 121,
		["138"] = 123,
		["139"] = 124,
		["142"] = 68,
		["143"] = 164,
		["144"] = 166,
		["146"] = 166,
		["148"] = 166,
		["149"] = 166,
		["150"] = 166,
		["152"] = 166,
		["153"] = 164,
		["154"] = 169,
		["155"] = 170,
		["157"] = 170,
		["159"] = 170,
		["160"] = 170,
		["161"] = 170,
		["163"] = 170,
		["164"] = 169,
		["165"] = 173,
		["166"] = 174,
		["168"] = 190,
		["169"] = 191,
		["170"] = 192,
		["171"] = 193,
		["172"] = 194,
		["174"] = 196,
		["176"] = 200,
		["178"] = 173,
		["179"] = 204,
		["180"] = 205,
		["181"] = 207,
		["182"] = 208,
		["183"] = 209,
		["184"] = 210,
		["186"] = 212,
		["187"] = 213,
		["190"] = 204,
		["191"] = 217,
		["192"] = 218,
		["193"] = 219,
		["194"] = 220,
		["195"] = 220,
		["196"] = 220,
		["197"] = 220,
		["198"] = 220,
		["199"] = 220,
		["200"] = 220,
		["201"] = 223,
		["202"] = 224,
		["203"] = 224,
		["204"] = 224,
		["205"] = 224,
		["206"] = 224,
		["207"] = 224,
		["208"] = 224,
		["209"] = 225,
		["210"] = 226,
		["211"] = 226,
		["212"] = 226,
		["213"] = 226,
		["214"] = 226,
		["215"] = 227,
		["216"] = 227,
		["217"] = 227,
		["218"] = 227,
		["219"] = 227,
		["220"] = 228,
		["221"] = 228,
		["222"] = 228,
		["223"] = 228,
		["224"] = 228,
		["225"] = 229,
		["226"] = 229,
		["227"] = 229,
		["228"] = 229,
		["229"] = 230,
		["230"] = 237,
		["231"] = 237,
		["232"] = 237,
		["233"] = 237,
		["234"] = 237,
		["235"] = 238,
		["236"] = 239,
		["237"] = 240,
		["238"] = 240,
		["239"] = 241,
		["240"] = 241,
		["242"] = 224,
		["243"] = 224,
		["245"] = 247,
		["246"] = 248,
		["247"] = 252,
		["248"] = 253,
		["251"] = 217,
		["252"] = 257,
		["253"] = 258,
		["254"] = 259,
		["255"] = 260,
		["256"] = 261,
		["258"] = 257,
		["259"] = 264,
		["260"] = 264,
		["261"] = 264,
		["263"] = 264,
		["264"] = 264,
		["266"] = 265,
		["267"] = 266,
		["268"] = 266,
		["269"] = 268,
		["270"] = 268,
		["271"] = 268,
		["272"] = 266,
		["273"] = 269,
		["274"] = 269,
		["275"] = 269,
		["276"] = 269,
		["277"] = 266,
		["278"] = 270,
		["279"] = 270,
		["280"] = 270,
		["281"] = 270,
		["282"] = 270,
		["283"] = 266,
		["284"] = 271,
		["285"] = 271,
		["286"] = 271,
		["287"] = 271,
		["288"] = 271,
		["289"] = 271,
		["290"] = 266,
		["291"] = 266,
		["292"] = 278,
		["293"] = 280,
		["294"] = 281,
		["295"] = 282,
		["296"] = 284,
		["298"] = 287,
		["301"] = 290,
		["302"] = 292,
		["304"] = 295,
		["307"] = 298,
		["308"] = 264,
		["309"] = 300,
		["310"] = 301,
		["311"] = 302,
		["312"] = 303,
		["313"] = 304,
		["315"] = 306,
		["316"] = 300,
		["317"] = 308,
		["318"] = 309,
		["319"] = 310,
		["320"] = 310,
		["321"] = 310,
		["322"] = 310,
		["323"] = 310,
		["324"] = 310,
		["325"] = 310,
		["326"] = 313,
		["327"] = 314,
		["328"] = 314,
		["329"] = 314,
		["330"] = 314,
		["331"] = 314,
		["332"] = 314,
		["333"] = 314,
		["334"] = 315,
		["335"] = 316,
		["336"] = 316,
		["337"] = 316,
		["338"] = 316,
		["339"] = 316,
		["340"] = 317,
		["341"] = 317,
		["342"] = 317,
		["343"] = 317,
		["344"] = 317,
		["345"] = 318,
		["346"] = 318,
		["347"] = 318,
		["348"] = 318,
		["349"] = 318,
		["350"] = 319,
		["351"] = 319,
		["352"] = 319,
		["353"] = 319,
		["354"] = 321,
		["355"] = 322,
		["356"] = 322,
		["357"] = 322,
		["358"] = 322,
		["359"] = 322,
		["360"] = 323,
		["361"] = 324,
		["362"] = 325,
		["363"] = 325,
		["364"] = 326,
		["365"] = 326,
		["367"] = 314,
		["368"] = 314,
		["369"] = 308,
		["370"] = 330,
		["371"] = 331,
		["372"] = 332,
		["374"] = 334,
		["375"] = 330,
		["376"] = 336,
		["377"] = 337,
		["378"] = 338,
		["379"] = 339,
		["380"] = 340,
		["381"] = 336,
		["382"] = 342,
		["383"] = 342,
		["384"] = 342,
		["386"] = 343,
		["387"] = 344,
		["389"] = 346,
		["390"] = 347,
		["391"] = 348,
		["392"] = 348,
		["393"] = 348,
		["394"] = 349,
		["395"] = 350,
		["397"] = 348,
		["398"] = 348,
		["399"] = 353,
		["400"] = 353,
		["401"] = 353,
		["402"] = 354,
		["403"] = 355,
		["405"] = 353,
		["406"] = 353,
		["407"] = 358,
		["408"] = 359,
		["409"] = 359,
		["410"] = 359,
		["411"] = 359,
		["412"] = 359,
		["413"] = 359,
		["414"] = 359,
		["415"] = 361,
		["416"] = 362,
		["418"] = 359,
		["419"] = 359,
		["420"] = 365,
		["421"] = 365,
		["422"] = 365,
		["423"] = 366,
		["424"] = 365,
		["425"] = 365,
		["426"] = 368,
		["427"] = 368,
		["428"] = 368,
		["429"] = 369,
		["430"] = 368,
		["431"] = 368,
		["434"] = 342,
		["435"] = 375,
		["436"] = 375,
		["437"] = 375,
		["439"] = 376,
		["440"] = 377,
		["441"] = 377,
		["442"] = 377,
		["443"] = 378,
		["444"] = 379,
		["446"] = 377,
		["447"] = 377,
		["448"] = 382,
		["449"] = 382,
		["450"] = 382,
		["451"] = 383,
		["452"] = 384,
		["454"] = 382,
		["455"] = 382,
		["457"] = 388,
		["458"] = 390,
		["459"] = 394,
		["460"] = 395,
		["461"] = 395,
		["462"] = 395,
		["463"] = 395,
		["464"] = 395,
		["465"] = 395,
		["466"] = 395,
		["467"] = 397,
		["468"] = 398,
		["470"] = 395,
		["471"] = 395,
		["472"] = 401,
		["473"] = 402,
		["474"] = 402,
		["475"] = 402,
		["476"] = 403,
		["477"] = 402,
		["478"] = 402,
		["479"] = 405,
		["480"] = 405,
		["481"] = 405,
		["482"] = 406,
		["483"] = 407,
		["484"] = 408,
		["485"] = 409,
		["486"] = 410,
		["488"] = 412,
		["489"] = 412,
		["490"] = 412,
		["491"] = 412,
		["492"] = 412,
		["493"] = 412,
		["494"] = 412,
		["495"] = 412,
		["496"] = 412,
		["497"] = 412,
		["498"] = 412,
		["499"] = 412,
		["500"] = 412,
		["501"] = 412,
		["502"] = 412,
		["503"] = 425,
		["504"] = 426,
		["505"] = 405,
		["506"] = 405,
		["507"] = 442,
		["508"] = 375,
		["509"] = 450,
		["510"] = 450,
		["511"] = 450,
		["513"] = 451,
		["514"] = 451,
		["515"] = 453,
		["516"] = 454,
		["517"] = 455,
		["519"] = 457,
		["520"] = 458,
		["521"] = 451,
		["522"] = 451,
		["523"] = 451,
		["524"] = 450,
		["525"] = 465,
		["526"] = 466,
		["527"] = 466,
		["528"] = 466,
		["529"] = 466,
		["530"] = 466,
		["531"] = 466,
		["532"] = 466,
		["533"] = 466,
		["534"] = 466,
		["535"] = 466,
		["536"] = 466,
		["537"] = 466,
		["538"] = 465,
		["539"] = 481,
		["540"] = 482,
		["541"] = 482,
		["542"] = 482,
		["543"] = 482,
		["544"] = 482,
		["545"] = 482,
		["546"] = 482,
		["547"] = 482,
		["548"] = 483,
		["549"] = 485,
		["550"] = 486,
		["551"] = 489,
		["552"] = 489,
		["553"] = 491,
		["554"] = 492,
		["555"] = 493,
		["556"] = 489,
		["557"] = 489,
		["558"] = 489,
		["559"] = 481,
		["560"] = 499,
		["561"] = 500,
		["562"] = 501,
		["563"] = 501,
		["564"] = 501,
		["565"] = 501,
		["566"] = 501,
		["567"] = 504,
		["568"] = 505,
		["569"] = 508,
		["570"] = 508,
		["571"] = 508,
		["572"] = 508,
		["573"] = 508,
		["574"] = 508,
		["575"] = 508,
		["576"] = 508,
		["577"] = 510,
		["578"] = 511,
		["579"] = 512,
		["580"] = 513,
		["581"] = 516,
		["582"] = 517,
		["583"] = 517,
		["584"] = 519,
		["585"] = 520,
		["586"] = 520,
		["587"] = 520,
		["588"] = 520,
		["589"] = 520,
		["590"] = 520,
		["591"] = 520,
		["592"] = 521,
		["593"] = 517,
		["594"] = 517,
		["595"] = 517,
		["597"] = 499,
		["598"] = 528,
		["599"] = 529,
		["600"] = 530,
		["601"] = 531,
		["604"] = 535,
		["605"] = 535,
		["606"] = 535,
		["607"] = 536,
		["608"] = 537,
		["610"] = 535,
		["611"] = 535,
		["612"] = 540,
		["613"] = 546,
		["614"] = 547,
		["616"] = 550,
		["620"] = 528,
		["621"] = 555,
		["622"] = 556,
		["623"] = 557,
		["624"] = 557,
		["625"] = 557,
		["626"] = 558,
		["627"] = 559,
		["629"] = 557,
		["630"] = 557,
		["631"] = 562,
		["632"] = 562,
		["633"] = 562,
		["634"] = 563,
		["635"] = 564,
		["637"] = 562,
		["638"] = 562,
		["640"] = 568,
		["641"] = 555,
		["642"] = 570,
		["643"] = 571,
		["644"] = 572,
		["645"] = 572,
		["646"] = 572,
		["647"] = 573,
		["648"] = 574,
		["649"] = 572,
		["650"] = 572,
		["652"] = 577,
		["653"] = 570,
		["654"] = 12,
		["655"] = 4,
		["656"] = 4,
		["657"] = 4,
		["658"] = 4,
		["659"] = 4,
		["660"] = 4,
		["661"] = 4,
		["662"] = 4,
		["663"] = 12,
		["665"] = 12,
	}
)
local o = {}
local p = require("modifiers.eom_modifier")
local q = p.EOMModifier
local r = p.registerEOMModifier
local s = "prop_dynamic_clientside"
o.modifier_bunny_thinker = c()
local t = o.modifier_bunny_thinker
t.name = "modifier_bunny_thinker"
d(t, q)
function t.prototype.____constructor(self, ...)
	q.prototype.____constructor(self, ...)
	self.d_flag = false
	self.bIDLE = true
	self.bTeleported = false
	self.bLocalBattlePos = false
	self.particles = {}
	self.idle_interval = 5
	self.POS_OFFSET_X = 360
	self.POS_OFFSET_Y = 450
	self.INTERVAL_POS_X = 100
end
function t.prototype.OnCreated(self, u)
	self.lastIdleAnimRecordList = {}
	if IsClient() then
		self.p_bunnies = self.p_bunnies or {}
		self.bunnies = self.bunnies or {}
		self.INTERVAL_POS_X = 100
		self.state = 1
		self:IDLE(true)
	else
		local v = PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
		if v then
			self.self_field_id = v.index
		else
			self.self_field_id = self:GetParent():GetPlayerOwnerID()
		end
	end
	self:SetHasCustomTransmitterData(true)
end
function t.prototype.AddCustomTransmitterData(self)
	return { state = self.state, battle_field_id = self.battle_field_id, self_field_id = self.self_field_id }
end
function t.prototype.HandleCustomTransmitterData(self, w)
	self.p_bunnies = self.p_bunnies or {}
	self.bunnies = self.bunnies or {}
	self.bunny_oids = self.bunny_oids or {}
	self.self_field_id = w.self_field_id
	if w.state then
		self.state = w.state
		local x = { 4, 5, 7 }
		if e(x, self.state) then
			self.battle_field_id = w.battle_field_id
		end
		repeat
			local y = self.state
			local z = y == 1
			if z then
				do
					self:IDLE(true)
					return
				end
			end
			z = z or y == 2
			if z then
				do
					self.bIDLE = false
					self:PlayAction("ACT_DOTA_VICTORY", true)
					return
				end
			end
			z = z or y == 3
			if z then
				do
					self.bIDLE = false
					self:PlayAction("ACT_DOTA_DEFEAT", true)
					return
				end
			end
			z = z or y == 4
			if z then
				do
					self:BattleConfirm()
					return
				end
			end
			z = z or y == 5
			if z then
				do
					self:EndTeleport()
					return
				end
			end
			z = z or y == 6
			if z then
				do
					self:CreateBackTeleporParticle()
					return
				end
			end
			z = z or y == 7
			if z then
				do
					self:FinishBackHome()
					return
				end
			end
			do
				do
					self:IDLE(true)
					return
				end
			end
		until true
	else
		local A = self:GetParent():GetPlayerOwnerID()
		if CustomNetTables:GetTableValue("service", "player_bunny" .. tostring(A)) then
			local B = json.decode(CustomNetTables:GetTableValue("service", "player_bunny" .. tostring(A)).data)
			self.bunny_oids = B
			self:IDLE(true)
		end
	end
end
function t.prototype.GetModel(self, C)
	local D = KeyValues.CosmeticsKV[C]
	if D ~= nil then
		D = D.resource
	end
	local E = D
	if E == nil then
		E = "models/eom/hero/tunvlang_2/tunvlang_2.vmdl"
	end
	return E
end
function t.prototype.GetModelScale(self, C)
	local F = KeyValues.CosmeticsKV[C]
	if F ~= nil then
		F = F.model_scale
	end
	local G = F
	if G == nil then
		G = 1
	end
	return G
end
function t.prototype.OnRefresh(self, u)
	if IsClient() then
	else
		self.state = u.state
		self.battle_field_id = u.battle_field_id
		local v = PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
		if v then
			self.self_field_id = v.index
		else
			self.self_field_id = self:GetParent():GetPlayerOwnerID()
		end
		self:SendBuffRefreshToClients()
	end
end
function t.prototype.GetEnemy(self)
	local H = CustomNetTables:GetTableValue("common", "battle_data")
	for I, J in ipairs(f(H)) do
		local K = H[J]
		if K.mainPlayer.PlayerID == self:GetParent():GetPlayerOwnerID() then
			return K.customerPlayer
		end
		if K.customerPlayer.PlayerID == self:GetParent():GetPlayerOwnerID() then
			return K.mainPlayer
		end
	end
end
function t.prototype.BattleConfirm(self)
	if self.battle_field_id and self.battle_field_id ~= self.self_field_id then
		self:DestroyTeleportParticles()
		local L = h(
			g(f(self.bunny_oids), function(I, M)
				return self.bunnies[M] ~= nil
			end),
			function(I, N, O)
				return self.bunny_oids[O] - self.bunny_oids[N]
			end
		)
		local P = #L
		k(j(self.bunnies), function(I, Q)
			local R
			local S
			S = Q[1]
			R = Q[2]
			if IsValidEntity(R) then
				local T = ParticleManager:CreateParticle(self:getTeleportParticlePath(S), PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControl(T, 0, R:GetAbsOrigin())
				ParticleManager:SetParticleControl(T, 1, R:GetAbsOrigin())
				local U = math.max(0, i(L, S))
				local V = self:GetPostion(U, P, true)
				local W = ParticleManager:CreateParticle(self:getTeleportParticlePath(S), PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControl(W, 0, V)
				ParticleManager:SetParticleControl(W, 1, V)
				local X = self.particles
				X[#X + 1] = T
				local Y = self.particles
				Y[#Y + 1] = W
			end
		end)
	else
		local Z = self:GetEnemy()
		if Z.PlayerID == GetLocalPlayerID() and Z.illusion ~= 1 then
			self.bLocalBattlePos = true
			self:IDLE(true)
		end
	end
end
function t.prototype.EndTeleport(self)
	if self.battle_field_id and self.battle_field_id ~= self.self_field_id then
		self.bTeleported = true
		self:IDLE(true)
		self:DestroyTeleportParticles()
	end
end
function t.prototype.GetPostion(self, _, P, a0, a1)
	if a0 == nil then
		a0 = self.bTeleported
	end
	if a1 == nil then
		a1 = self.bLocalBattlePos
	end
	local a2
	local a3 = {
		{ Vector(360, 450 - 30, 128) },
		{ Vector(360, 450 - 30, 128), Vector(240, 354 - 30, 128) },
		{ Vector(480, 354 - 30, 128), Vector(360, 450 - 30, 128), Vector(240, 354 - 30, 128) },
		{ Vector(480, 354 - 30, 128), Vector(360, 450 - 30, 128), Vector(240, 354 - 30, 128), Vector(
			120,
			450 - 30,
			128
		) },
		{
			Vector(600, 450 - 30, 128),
			Vector(480, 354 - 30, 128),
			Vector(360, 450 - 30, 128),
			Vector(240, 354 - 30, 128),
			Vector(120, 450 - 30, 128),
		},
	}
	local a4 = a3[P]
	local a5 = a4[_ + 1]
	if a0 then
		if GetLocalPlayerID() == self:GetParent():GetPlayerOwnerID() then
			a2 = PlayerHomePos[self.battle_field_id + 1] + Vector(-a5.x, -a5.y, 128)
		else
			a2 = PlayerHomePos[self.battle_field_id + 1] + Vector(-a5.x, a5.y, 128)
		end
	else
		if a1 then
			a2 = PlayerHomePos[self.self_field_id + 1] + Vector(a5.x, -a5.y, 128)
		else
			a2 = PlayerHomePos[self.self_field_id + 1] + Vector(a5.x, a5.y, 128)
		end
	end
	return a2
end
function t.prototype.GetAngle(self)
	if self.bTeleported and GetLocalPlayerID() == self:GetParent():GetPlayerOwnerID() then
		return QAngle(0, 60, 0)
	elseif self.bLocalBattlePos then
		return QAngle(0, 120, 0)
	end
	return QAngle(0, 240, 0)
end
function t.prototype.CreateBackTeleporParticle(self)
	self:DestroyTeleportParticles()
	local L = h(
		g(f(self.bunny_oids), function(I, M)
			return self.bunnies[M] ~= nil
		end),
		function(I, N, O)
			return self.bunny_oids[O] - self.bunny_oids[N]
		end
	)
	local P = #L
	k(j(self.bunnies), function(I, Q)
		local R
		local S
		S = Q[1]
		R = Q[2]
		if IsValidEntity(R) then
			local a6 = ParticleManager:CreateParticle(self:getTeleportParticlePath(S), PATTACH_CUSTOMORIGIN, nil)
			ParticleManager:SetParticleControl(a6, 0, R:GetAbsOrigin())
			ParticleManager:SetParticleControl(a6, 1, R:GetAbsOrigin())
			local U = math.max(0, i(L, S))
			local V = self:GetPostion(U, P, false, false)
			local W = ParticleManager:CreateParticle(self:getTeleportParticlePath(S), PATTACH_CUSTOMORIGIN, nil)
			ParticleManager:SetParticleControl(W, 0, V)
			ParticleManager:SetParticleControl(W, 1, V)
			local a7 = self.particles
			a7[#a7 + 1] = a6
			local a8 = self.particles
			a8[#a8 + 1] = W
		end
	end)
end
function t.prototype.getTeleportParticlePath(self, C)
	if C ~= nil and KeyValues.CosmeticsKV[tostring(C)] ~= nil and KeyValues.CosmeticsKV[tostring(C)].extra_resource then
		return KeyValues.CosmeticsKV[tostring(C)].extra_resource
	end
	return "particles/econ/events/fall_2022/teleport/teleport_fall2022_end_lvl1.vpcf"
end
function t.prototype.FinishBackHome(self)
	self.bTeleported = false
	self.bLocalBattlePos = false
	self:IDLE(true)
	self:DestroyTeleportParticles()
end
function t.prototype.IDLE(self, a9)
	if a9 == nil then
		a9 = false
	end
	if not self.bIDLE then
		self.bIDLE = true
	end
	if a9 then
		self.lastIdleAnimRecordList = {}
		k(l(self.p_bunnies), function(I, R)
			if IsValidEntity(R) then
				R:Destroy()
			end
		end)
		k(l(self.bunnies), function(I, R)
			if IsValidEntity(R) then
				R:Destroy()
			end
		end)
		local L = {}
		k(j(self.bunny_oids), function(I, Q)
			local U
			local C
			C = Q[1]
			U = Q[2]
			if U ~= -1 then
				L[#L + 1] = C
			end
		end)
		h(L, function(I, N, O)
			return self.bunny_oids[O] - self.bunny_oids[N]
		end)
		k(L, function(I, C, _)
			self:IdleSingle(C, _, #L)
		end)
	else
	end
end
function t.prototype.PlayAction(self, aa, a9)
	if a9 == nil then
		a9 = false
	end
	if a9 then
		k(l(self.p_bunnies), function(I, R)
			if IsValidEntity(R) then
				R:Destroy()
			end
		end)
		k(l(self.bunnies), function(I, R)
			if IsValidEntity(R) then
				R:Destroy()
			end
		end)
	end
	self.d_flag = true
	self.bunnies = {}
	local L = {}
	k(j(self.bunny_oids), function(I, Q)
		local U
		local C
		C = Q[1]
		U = Q[2]
		if U ~= -1 then
			L[#L + 1] = C
		end
	end)
	self.lastIdleAnimRecordList = {}
	h(L, function(I, N, O)
		return self.bunny_oids[O] - self.bunny_oids[N]
	end)
	k(L, function(I, C, _)
		local ab = self:GetModel(C)
		local ac = aa
		if ac == nil then
			local ad = BUNNY_IDLE_ANIMATION_LIST[GetSupportGroupTypeByModelName(nil, ab)]
			ac = ad[RandomInt(0, #ad - 1) + 1]
		end
		local R = SpawnEntityFromTableSynchronous(
			s,
			{
				origin = self:GetPostion(_, #L),
				model = ab,
				angles = self:GetAngle(),
				StartingAnim = ac,
				StartingAnimationLoopMode = aa == nil and "ANIM_LOOP_MODE_NOT_LOOPING" or "ANIM_LOOP_MODE_LOOPING",
				use_animgraph = "1",
				IdleAnim = "ACT_DOTA_IDLE",
				IdleAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
				scale = tostring(self:GetModelScale(C)),
				randomizecycle = "1",
			}
		)
		self.lastIdleAnimRecordList[ab] = aa == nil and "ACT_DOTA_IDLE" or ac
		self.bunnies[C] = R
	end)
	self:StartIntervalThink(FrameTime())
end
function t.prototype.replaceBunny(self, C, ae, af)
	if af == nil then
		af = 0
	end
	ae:SetContextThink("bunnydel" .. C, function()
		if IsValidEntity(self.p_bunnies[C]) then
			self.p_bunnies[C]:Destroy()
		end
		self.p_bunnies[C] = ae
		return -1
	end, af)
end
function t.prototype.createBunnyParams(self, C, _, ag, ah, ai, aj)
	return {
		origin = self:GetPostion(_, ag),
		model = self:GetModel(C),
		angles = self:GetAngle(),
		use_animgraph = "1",
		IdleAnim = aj,
		IdleAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
		StartingAnim = ah,
		StartingAnimationLoopMode = ai,
		scale = tostring(self:GetModelScale(C)),
		randomizecycle = "1",
	}
end
function t.prototype.spawnIdleLoopBunny(self, C, _, ag, aj, ak)
	local al = self:createBunnyParams(C, _, ag, aj, "ANIM_LOOP_MODE_LOOPING", aj)
	local R = SpawnEntityFromTableSynchronous(s, al)
	self.bunnies[C] = R
	self:replaceBunny(C, R)
	R:SetContextThink("bunnyIdle" .. C, function()
		self:IdleSingle(C, _, ag)
		return -1
	end, ak)
end
function t.prototype.IdleSingle(self, C, _, ag)
	local ab = self:GetModel(C)
	local am = GetSupportGroupAnimationDataByModelName(nil, ab, self.lastIdleAnimRecordList[ab])
	local an = am.startAnimDuration
	local ak = am.idleAnimDuration
	local ao = am.startAnimName
	local aj = am.idleAnimName
	local ap = an ~= 0 and ao ~= aj
	local ai = ap and "ANIM_LOOP_MODE_NOT_LOOPING" or "ANIM_LOOP_MODE_LOOPING"
	local al = self:createBunnyParams(C, _, ag, ao, ai, aj)
	local R = SpawnEntityFromTableSynchronous(s, al)
	self.lastIdleAnimRecordList[ab] = ak == 0 and ao or aj
	self.bunnies[C] = R
	self:replaceBunny(C, R)
	if an + ak >= 0 then
		R:SetContextThink("bunnyIdle" .. C, function()
			self:spawnIdleLoopBunny(C, _, ag, aj, ak)
			return -1
		end, an)
	end
end
function t.prototype.OnIntervalThink(self)
	if IsClient() then
		if not self.d_flag then
			if self.bIDLE then
			end
		else
			k(l(self.p_bunnies), function(I, R)
				if IsValidEntity(R) then
					R:Destroy()
				end
			end)
			self.p_bunnies = shallowcopy(self.bunnies)
			self.d_flag = false
			if self.bIDLE then
			else
				self:StartIntervalThink(-1)
			end
		end
	end
end
function t.prototype.OnDestroy(self)
	if IsClient() then
		k(l(self.p_bunnies), function(I, R)
			if IsValidEntity(R) then
				R:Destroy()
			end
		end)
		k(l(self.bunnies), function(I, R)
			if IsValidEntity(R) then
				R:Destroy()
			end
		end)
	end
	self:DestroyTeleportParticles()
end
function t.prototype.DestroyTeleportParticles(self)
	if self.particles then
		k(self.particles, function(I, aq)
			ParticleManager:DestroyParticle(aq, false)
			ParticleManager:ReleaseParticleIndex(aq)
		end)
	end
	self.particles = {}
end
t = m(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	t
)
o.modifier_bunny_thinker = t
return o