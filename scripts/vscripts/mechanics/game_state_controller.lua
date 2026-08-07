--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/game_state_controller"
local b = require("lualib_bundle")
local c = b.__TS__ArrayIncludes
local d = b.__TS__StringSplit
local e = b.__TS__ArrayIndexOf
local f = b.__TS__ArraySplice
local g = b.__TS__ArrayForEach
local h = b.__TS__ArrayFilter
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 22,
		["12"] = 4,
		["13"] = 4,
		["14"] = 5,
		["15"] = 5,
		["16"] = 6,
		["17"] = 6,
		["18"] = 40,
		["19"] = 41,
		["20"] = 42,
		["22"] = 40,
		["23"] = 45,
		["24"] = 46,
		["25"] = 47,
		["26"] = 49,
		["27"] = 50,
		["28"] = 52,
		["29"] = 54,
		["30"] = 55,
		["31"] = 57,
		["32"] = 62,
		["34"] = 65,
		["35"] = 65,
		["36"] = 65,
		["37"] = 65,
		["38"] = 65,
		["39"] = 65,
		["40"] = 65,
		["41"] = 45,
		["42"] = 70,
		["43"] = 71,
		["44"] = 72,
		["45"] = 77,
		["47"] = 80,
		["48"] = 81,
		["49"] = 82,
		["50"] = 83,
		["51"] = 84,
		["53"] = 82,
		["54"] = 88,
		["56"] = 91,
		["57"] = 92,
		["58"] = 93,
		["59"] = 94,
		["60"] = 95,
		["61"] = 96,
		["62"] = 97,
		["63"] = 97,
		["64"] = 97,
		["65"] = 97,
		["66"] = 97,
		["67"] = 97,
		["68"] = 97,
		["69"] = 97,
		["70"] = 97,
		["71"] = 97,
		["72"] = 97,
		["73"] = 97,
		["74"] = 111,
		["76"] = 114,
		["77"] = 115,
		["78"] = 116,
		["80"] = 117,
		["81"] = 117,
		["83"] = 118,
		["84"] = 119,
		["85"] = 120,
		["87"] = 124,
		["88"] = 126,
		["89"] = 129,
		["90"] = 130,
		["94"] = 117,
		["97"] = 133,
		["98"] = 114,
		["99"] = 141,
		["100"] = 142,
		["101"] = 143,
		["103"] = 145,
		["104"] = 146,
		["106"] = 148,
		["107"] = 149,
		["108"] = 151,
		["109"] = 152,
		["110"] = 154,
		["111"] = 156,
		["112"] = 156,
		["113"] = 156,
		["114"] = 156,
		["115"] = 156,
		["116"] = 156,
		["117"] = 156,
		["118"] = 156,
		["119"] = 156,
		["120"] = 163,
		["121"] = 172,
		["122"] = 173,
		["123"] = 173,
		["124"] = 173,
		["125"] = 173,
		["126"] = 174,
		["127"] = 175,
		["129"] = 175,
		["131"] = 178,
		["132"] = 185,
		["133"] = 185,
		["134"] = 185,
		["135"] = 185,
		["136"] = 185,
		["139"] = 190,
		["140"] = 192,
		["141"] = 192,
		["142"] = 192,
		["143"] = 192,
		["144"] = 192,
		["145"] = 192,
		["146"] = 192,
		["147"] = 192,
		["148"] = 192,
		["150"] = 195,
		["152"] = 173,
		["153"] = 173,
		["154"] = 173,
		["155"] = 173,
		["156"] = 198,
		["157"] = 201,
		["158"] = 173,
		["159"] = 173,
		["160"] = 204,
		["162"] = 207,
		["163"] = 208,
		["164"] = 209,
		["165"] = 210,
		["167"] = 213,
		["168"] = 214,
		["170"] = 224,
		["171"] = 225,
		["172"] = 225,
		["173"] = 225,
		["174"] = 225,
		["175"] = 225,
		["176"] = 225,
		["177"] = 225,
		["178"] = 225,
		["179"] = 234,
		["180"] = 235,
		["181"] = 236,
		["183"] = 238,
		["184"] = 239,
		["185"] = 241,
		["186"] = 242,
		["187"] = 242,
		["188"] = 242,
		["189"] = 244,
		["192"] = 248,
		["193"] = 249,
		["195"] = 257,
		["196"] = 258,
		["197"] = 258,
		["198"] = 258,
		["199"] = 258,
		["200"] = 259,
		["202"] = 263,
		["203"] = 264,
		["204"] = 265,
		["205"] = 265,
		["206"] = 265,
		["207"] = 265,
		["208"] = 266,
		["211"] = 269,
		["212"] = 270,
		["213"] = 271,
		["214"] = 273,
		["216"] = 273,
		["218"] = 275,
		["219"] = 279,
		["220"] = 281,
		["223"] = 286,
		["224"] = 288,
		["225"] = 293,
		["226"] = 294,
		["227"] = 295,
		["228"] = 296,
		["231"] = 299,
		["232"] = 300,
		["234"] = 302,
		["235"] = 302,
		["236"] = 302,
		["237"] = 302,
		["238"] = 302,
		["239"] = 302,
		["240"] = 302,
		["241"] = 302,
		["242"] = 302,
		["243"] = 303,
		["244"] = 304,
		["247"] = 265,
		["248"] = 265,
		["249"] = 265,
		["250"] = 265,
		["251"] = 308,
		["252"] = 242,
		["253"] = 242,
		["255"] = 312,
		["256"] = 313,
		["257"] = 314,
		["258"] = 316,
		["259"] = 319,
		["260"] = 320,
		["262"] = 323,
		["263"] = 327,
		["264"] = 327,
		["265"] = 327,
		["266"] = 327,
		["267"] = 328,
		["269"] = 331,
		["270"] = 336,
		["271"] = 337,
		["273"] = 340,
		["274"] = 342,
		["276"] = 345,
		["277"] = 347,
		["279"] = 354,
		["280"] = 355,
		["281"] = 356,
		["282"] = 357,
		["283"] = 357,
		["284"] = 357,
		["285"] = 358,
		["286"] = 359,
		["287"] = 360,
		["288"] = 361,
		["289"] = 362,
		["291"] = 357,
		["292"] = 357,
		["293"] = 367,
		["295"] = 369,
		["296"] = 369,
		["298"] = 370,
		["299"] = 371,
		["301"] = 372,
		["302"] = 373,
		["303"] = 374,
		["307"] = 369,
		["310"] = 378,
		["311"] = 378,
		["312"] = 378,
		["313"] = 378,
		["314"] = 380,
		["316"] = 381,
		["317"] = 381,
		["319"] = 382,
		["320"] = 383,
		["321"] = 384,
		["323"] = 386,
		["324"] = 387,
		["326"] = 388,
		["327"] = 389,
		["328"] = 391,
		["331"] = 381,
		["334"] = 394,
		["335"] = 397,
		["337"] = 402,
		["338"] = 403,
		["339"] = 405,
		["340"] = 406,
		["344"] = 413,
		["346"] = 416,
		["347"] = 417,
		["348"] = 418,
		["351"] = 422,
		["353"] = 425,
		["354"] = 428,
		["355"] = 430,
		["356"] = 432,
		["359"] = 437,
		["360"] = 438,
		["361"] = 440,
		["362"] = 440,
		["363"] = 440,
		["364"] = 441,
		["365"] = 442,
		["367"] = 440,
		["368"] = 440,
		["369"] = 446,
		["371"] = 449,
		["372"] = 454,
		["374"] = 25,
		["375"] = 26,
		["376"] = 27,
		["377"] = 29,
		["378"] = 31,
		["379"] = 32,
		["380"] = 34,
		["381"] = 35,
		["382"] = 36,
		["384"] = 31,
		["385"] = 221,
		["386"] = 222,
		["387"] = 223,
		["388"] = 460,
		["389"] = 461,
		["390"] = 462,
		["391"] = 462,
		["393"] = 462,
		["394"] = 462,
		["396"] = 462,
		["399"] = 462,
		["400"] = 462,
		["402"] = 462,
		["404"] = 462,
		["405"] = 463,
		["406"] = 464,
		["408"] = 466,
		["409"] = 460,
	}
)
local j = {}
local k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z, A, B, C, D, E
local F = require("service.http_utils")
local G = F.HttpUtils
local H = require("service.sync_data_entity")
local I = H.SyncDataEntity
local J = require("service.sync_entity")
local K = J.CSyncEntity
function j.manualPollModeSwithStateRetry(self)
	if w and x then
		j.manualPollModeSwithState(nil, w, x)
	end
end
function j.manualPollModeSwithState(self, L, M)
	w = L
	A = z
	x = M
	local N = M.constructor.name
	y = 1
	if N == "GameState_BattleEnd" then
		y = 1
	elseif
		N == "GameState_ConfirmBattle"
		or N == "GameState_ConfirmNeutral"
		or N == "GameState_Prepare"
		or N == "GameState_Neutral"
	then
		y = 2
	end
	return n(nil, PlayerData, L, M, y)
end
function k(self, y, O)
	local P = y > 0 and O.hero and json.encode(O:ToJSON()) or ""
	local Q = y > 1 and O.hero and json.encode(O.hero:ToJSON()) or ""
	return (P .. "|") .. Q
end
function l(self, y, R)
	local S = ""
	R:eachPlayer(function(T, O)
		if O:IsBotData() or c(B, O.SteamID) then
			S = S .. k(nil, y, O) .. "|"
		end
	end)
	return S
end
function m(self, y, U, V, N, W, X)
	local P = y > 0 and V.hero and json.encode(V:ToJSON()) or ""
	local Q = y > 1 and V.hero and json.encode(V.hero:ToJSON()) or ""
	local Y = ""
	local Z = ""
	local _ = ""
	local a0 = {
		uid = U,
		game_id = Match.matchId,
		round = Rounds:getCurrentRoundX(),
		state = N,
		player_data = P,
		hero_data = Q,
		random_data = Z,
		robot_data = Y,
		sect_adjust = _,
		seconds_count_down = X,
	}
	return a0
end
function j.decodeGameLogicData(self, a1)
	local a2 = {}
	local a3 = d(a1, "|")
	do
		local a4 = 0
		while a4 < #a3 do
			do
				local a5 = a3[a4 + 1]
				if not a5 or #a5 == 0 then
					goto a6
				end
				local P = json.decode(a5)
				local U = SyncEntity:FromJSON(P, true)
				if not c(a2, U) and not I:IsBotID(U) then
					a2[#a2 + 1] = U
				end
			end
			::a6::
			a4 = a4 + 1
		end
	end
	return a2
end
function n(self, R, L, M, y)
	if Match:getMode() ~= "net" then
		return false
	end
	if not L.ManualPollMode then
		return false
	end
	CustomNetTables:SetTableValue("common", "logic_net_status", { status = 1 })
	A = A - 1
	local a7 = R:LocalSteamID()
	local N = M:getStateName()
	local V = R:getLocalPlayer()
	local a0 = m(nil, y, a7, V, N, Rounds:getCurrentRoundX(), L:getCountDown())
	a0.robot_data = l(nil, y, R)
	local a8 = GameRules:GetGameTime()
	G:Post(
		"/v1/c4/switch_game_state",
		a0,
		function(T, a9, aa, ab)
			local ac = GameRules:GetGameTime() - a8
			local ad = R:getLocalPlayer()
			if ad ~= nil then
				ad:updatePing(math.floor(ac * 1000))
			end
			if a9 ~= 200 then
				r(nil, a7, "NET Error: " .. tostring(a9))
				return
			end
			if aa == "OK" then
				p(nil, a7, R, L, N, M, y)
			else
				r(nil, a7, "NET Exception: " .. aa)
			end
		end,
		K.URL,
		K.TOKEN,
		30,
		function()
			r(nil, a7, "TIME OUT.")
		end
	)
	return true
end
function o(self, L, M)
	if v then
		StopTimer(v)
		v = nil
	end
	x = nil
	L:switchState(M)
end
function p(self, a7, R, L, N, M, y)
	local ae = { uid = a7, game_id = Match.matchId, round = Rounds:getCurrentRoundX(), state = N, force = D, ping = C }
	local af = 1
	if v then
		StopTimer(v)
	end
	local ag = 0
	local ah = 0
	E = false
	v = Timer(af, function()
		if E then
			return
		end
		ah = ah + af
		if ah > 30 then
		end
		if ag > 3 then
			ErrorMessage(0, "TOO MANY POLLing: " .. tostring(ag))
			return af
		end
		ag = ag + 1
		local a8 = GameRules:GetGameTime()
		G:Put("/v1/c4/switch_game_state_poll", ae, function(T, a9, aa, ab)
			if E then
				return
			end
			ag = ag - 1
			local ac = GameRules:GetGameTime() - a8
			C = ac
			local ai = R:getLocalPlayer()
			if ai ~= nil then
				ai:updatePing(math.floor(ac * 1000))
			end
			if a9 ~= 200 then
				ErrorMessage(0, "网络波动: " .. "POLL TIME OUT")
				D = 1
				return
			end
			D = 0
			if (string.find(aa, "WAITING", nil, true) or 0) - 1 == 0 then
				if L:timeEnded() then
					local aj = d(aa, ":")
					if aj and #aj > 1 and #aj[2] > 0 then
						ErrorMessage(0, "正在等待: " .. aj[2])
					end
				end
			elseif (string.find(aa, "DUPLICATED", nil, true) or 0) - 1 == 0 then
				ErrorMessage(0, "重复轮询: " .. aa)
			else
				E = q(nil, a7, R, E, N, y, aa)
				if E then
					o(nil, L, M)
				end
			end
		end, K.URL, K.TOKEN)
		return af
	end)
end
function q(self, a7, R, E, N, y, aa)
	local ak = json.decode(aa)
	local a1 = ak.data
	if ak.game_id ~= Match.matchId then
		ErrorMessage(0, "Game State Switch: game id miss: " .. Match.matchId)
		return false
	end
	if ak.round ~= Rounds:getCurrentRoundX() then
		ErrorMessage(0, "Game State Switch: round miss: " .. tostring(Rounds:getCurrentRoundX()))
		return false
	end
	if ak.state ~= N then
		ErrorMessage(0, "Game State Switch: next state miss: " .. N)
		return false
	end
	if ak.uid ~= a7 then
		return false
	end
	if E then
		return false
	end
	j.decodeGameLogicData(nil, a1)
	local a2 = ak.uids
	if y > 0 then
		g(a2, function(T, al)
			local am = e(B, al)
			if am >= 0 then
				f(B, am)
				PlayerData:setOnlineTag(al, true)
				ErrorMessage(0, al .. " 回到了游戏.")
			end
		end)
		local an = {}
		do
			local a4 = 0
			while a4 < 8 do
				do
					if R.playerData[a4]:IsBotData() then
						goto ao
					end
					local ap = Match:playerID2SteamID(a4)
					if ap then
						an[#an + 1] = ap
					end
				end
				::ao::
				a4 = a4 + 1
			end
		end
		local aq = h(an, function(T, al)
			return not c(a2, al)
		end)
		local ar = ""
		do
			local a4 = 0
			while a4 < #aq do
				do
					local as = aq[a4 + 1]
					if c(B, as) then
						goto at
					end
					if a4 > 0 then
						ar = ar .. ","
					end
					ar = ar .. as
					B[#B + 1] = as
					PlayerData:setOnlineTag(as, false)
				end
				::at::
				a4 = a4 + 1
			end
		end
		if #ar > 0 then
			ErrorMessage(0, ar .. " 离开了游戏.")
		end
		if AUTO_MATCH_PLAY then
			if t(nil, a2) then
				u(nil, a7)
				return false
			end
		end
	end
	return true
end
function r(self, a7, au)
	if A > 0 then
		j.manualPollModeSwithStateRetry(nil)
		return
	end
	s(nil, a7, au)
end
function s(self, a7, au)
	ErrorMessage(0, "网络异常: " .. au)
	CustomNetTables:SetTableValue("common", "logic_net_status", { status = 0 })
	if AUTO_MATCH_PLAY or AUTO_RESTART_ROOM_PLAY then
	end
end
function t(self, a2)
	local av = {}
	g(a2, function(T, aw)
		if e(AutoMatchRobotList, aw) >= 0 then
			av[#av + 1] = aw
		end
	end)
	return #av == #a2
end
function u(self, a7)
	Match:endPlay(a7)
end
y = 1
z = 2
A = z
B = {}
function j.manualPollModeReset(self)
	B = {}
	if v then
		StopTimer(v)
		v = nil
	end
end
C = 0
D = 1
E = false
function j.getDuration(self, ax)
	local ay = GAME_STATE_CONFIG[ax]
	local az
	if SYNC_LOGIC_DEBUG_FAST_MODE then
		local aA
		if ay ~= nil then
			aA = ay.duration_fast
		end
		az = aA
	else
		local aB
		if ay ~= nil then
			aB = ay.duration
		end
		az = aB
	end
	local aC = az
	if aC == nil then
		return 60
	end
	return aC
end
return j