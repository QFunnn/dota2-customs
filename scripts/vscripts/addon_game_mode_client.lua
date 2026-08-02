--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "addon_game_mode_client"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Delete
local f = b.__TS__DecorateLegacy
local g = b.__TS__New
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 12,
		["11"] = 12,
		["12"] = 2,
		["13"] = 4,
		["15"] = 6,
		["16"] = 7,
		["18"] = 9,
		["19"] = 10,
		["21"] = 14,
		["22"] = 15,
		["23"] = 17,
		["24"] = 17,
		["25"] = 18,
		["26"] = 22,
		["27"] = 23,
		["28"] = 24,
		["29"] = 25,
		["31"] = 48,
		["32"] = 49,
		["33"] = 50,
		["34"] = 50,
		["35"] = 52,
		["36"] = 53,
		["37"] = 50,
		["38"] = 50,
		["39"] = 50,
		["40"] = 57,
		["41"] = 57,
		["42"] = 59,
		["43"] = 60,
		["44"] = 61,
		["47"] = 65,
		["48"] = 66,
		["51"] = 70,
		["52"] = 71,
		["53"] = 72,
		["54"] = 73,
		["56"] = 75,
		["58"] = 77,
		["59"] = 78,
		["60"] = 78,
		["61"] = 78,
		["62"] = 78,
		["63"] = 78,
		["64"] = 79,
		["66"] = 57,
		["67"] = 57,
		["68"] = 57,
		["69"] = 84,
		["70"] = 84,
		["71"] = 86,
		["72"] = 87,
		["73"] = 84,
		["74"] = 84,
		["75"] = 84,
		["76"] = 91,
		["77"] = 91,
		["78"] = 93,
		["79"] = 94,
		["80"] = 91,
		["81"] = 91,
		["82"] = 91,
		["83"] = 98,
		["84"] = 98,
		["85"] = 100,
		["86"] = 101,
		["87"] = 98,
		["88"] = 98,
		["89"] = 98,
		["90"] = 105,
		["91"] = 105,
		["92"] = 107,
		["93"] = 108,
		["94"] = 105,
		["95"] = 105,
		["96"] = 105,
		["97"] = 112,
		["98"] = 112,
		["99"] = 114,
		["100"] = 115,
		["101"] = 112,
		["102"] = 112,
		["103"] = 112,
		["104"] = 119,
		["105"] = 119,
		["106"] = 121,
		["107"] = 122,
		["108"] = 119,
		["109"] = 119,
		["110"] = 119,
		["111"] = 126,
		["112"] = 126,
		["113"] = 128,
		["114"] = 129,
		["115"] = 126,
		["116"] = 126,
		["117"] = 126,
		["118"] = 133,
		["119"] = 133,
		["120"] = 135,
		["121"] = 136,
		["122"] = 133,
		["123"] = 133,
		["124"] = 133,
		["125"] = 140,
		["126"] = 140,
		["127"] = 142,
		["128"] = 143,
		["129"] = 140,
		["130"] = 140,
		["131"] = 140,
		["132"] = 147,
		["133"] = 147,
		["134"] = 149,
		["135"] = 150,
		["136"] = 151,
		["137"] = 151,
		["138"] = 151,
		["139"] = 151,
		["140"] = 151,
		["141"] = 151,
		["142"] = 151,
		["143"] = 151,
		["144"] = 151,
		["145"] = 151,
		["146"] = 151,
		["147"] = 151,
		["148"] = 151,
		["149"] = 151,
		["150"] = 151,
		["151"] = 151,
		["152"] = 151,
		["153"] = 151,
		["154"] = 151,
		["155"] = 151,
		["156"] = 151,
		["157"] = 151,
		["158"] = 151,
		["159"] = 151,
		["160"] = 151,
		["161"] = 151,
		["162"] = 181,
		["163"] = 182,
		["164"] = 184,
		["165"] = 185,
		["166"] = 187,
		["167"] = 188,
		["168"] = 190,
		["169"] = 191,
		["170"] = 192,
		["171"] = 193,
		["172"] = 194,
		["173"] = 195,
		["174"] = 196,
		["175"] = 197,
		["176"] = 198,
		["177"] = 199,
		["178"] = 200,
		["179"] = 201,
		["180"] = 202,
		["181"] = 203,
		["182"] = 204,
		["183"] = 205,
		["184"] = 206,
		["185"] = 207,
		["186"] = 208,
		["188"] = 210,
		["189"] = 147,
		["190"] = 147,
		["191"] = 147,
		["192"] = 214,
		["193"] = 214,
		["194"] = 216,
		["195"] = 217,
		["196"] = 214,
		["197"] = 214,
		["198"] = 214,
		["199"] = 221,
		["200"] = 221,
		["201"] = 223,
		["202"] = 224,
		["203"] = 225,
		["205"] = 221,
		["206"] = 221,
		["207"] = 221,
		["208"] = 22,
		["209"] = 257,
		["210"] = 258,
		["211"] = 259,
		["212"] = 260,
		["213"] = 257,
		["214"] = 262,
		["215"] = 263,
		["216"] = 264,
		["217"] = 262,
		["218"] = 266,
		["219"] = 267,
		["220"] = 268,
		["221"] = 266,
		["222"] = 270,
		["223"] = 271,
		["224"] = 272,
		["225"] = 273,
		["227"] = 274,
		["228"] = 275,
		["230"] = 276,
		["233"] = 278,
		["235"] = 279,
		["236"] = 280,
		["238"] = 282,
		["242"] = 285,
		["244"] = 286,
		["245"] = 287,
		["254"] = 270,
		["255"] = 295,
		["256"] = 296,
		["257"] = 297,
		["258"] = 298,
		["259"] = 299,
		["260"] = 295,
		["261"] = 302,
		["262"] = 303,
		["263"] = 304,
		["264"] = 305,
		["265"] = 306,
		["266"] = 307,
		["267"] = 308,
		["269"] = 310,
		["270"] = 302,
		["271"] = 313,
		["272"] = 314,
		["273"] = 315,
		["275"] = 317,
		["276"] = 318,
		["277"] = 319,
		["280"] = 322,
		["281"] = 322,
		["282"] = 322,
		["283"] = 322,
		["284"] = 322,
		["285"] = 322,
		["286"] = 322,
		["287"] = 313,
		["288"] = 329,
		["289"] = 330,
		["290"] = 329,
		["291"] = 338,
		["292"] = 339,
		["293"] = 340,
		["294"] = 341,
		["295"] = 342,
		["296"] = 343,
		["298"] = 345,
		["300"] = 347,
		["301"] = 348,
		["304"] = 338,
		["305"] = 358,
		["306"] = 359,
		["307"] = 360,
		["308"] = 361,
		["309"] = 362,
		["310"] = 363,
		["311"] = 364,
		["315"] = 358,
		["316"] = 370,
		["317"] = 371,
		["318"] = 372,
		["319"] = 373,
		["320"] = 374,
		["321"] = 374,
		["322"] = 374,
		["323"] = 374,
		["324"] = 375,
		["325"] = 376,
		["326"] = 377,
		["329"] = 370,
		["330"] = 17,
		["331"] = 407,
		["332"] = 408,
		["334"] = 410,
		["335"] = 411,
		["337"] = 413,
		["338"] = 414,
		["339"] = 414,
		["340"] = 414,
		["341"] = 414,
		["342"] = 414,
		["343"] = 414,
		["344"] = 414,
		["345"] = 414,
		["346"] = 414,
		["347"] = 414,
		["349"] = 425,
		["350"] = 426,
		["352"] = 428,
		["353"] = 429,
		["355"] = 432,
	}
)
local i = {}
local j = require("lib.tstl-utils")
local k = j.reloadable
if _G.debug == nil then
	_G.debug = {}
end
if _G.debug.traceback == nil then
	_G.debug.traceback = function(...)
		return ""
	end
end
if _G.debug.getinfo == nil then
	_G.debug.getinfo = function(...)
		return { source = "", what = "", short_src = "" }
	end
end
require("requires")
require("precache")
local l = c()
l.name = "CClient"
d(l, CModule)
function l.prototype.init(self, m)
	if not m then
		self.tAbilityKeyEvent = {}
		self.tLocalConsoleMessageEvent = {}
	end
	SendToConsole('bind ENTER ""')
	SendToConsole('bind KP_ENTER ""')
	GameEvent("client_reload_game_keyvalues", function()
		require("addon_game_mode_client")
	end, nil)
	GameEvent("client_request_event", function(n)
		local o = tRequestEvents[n.event]
		if o == nil then
			return
		end
		local p = json.decode(n.data)
		if p == nil then
			return
		end
		local q
		local r = o.callback
		if o.context ~= nil then
			q = r(o.context, p)
		else
			q = r(p)
		end
		if n._IsFire ~= true and type(q) == "table" then
			local s = unpack(json.encode(q), 1, 1)
			_G.ClientRequestEventResult = s
		end
	end, nil)
	GameEvent("custom_local_console_message", function(self, ...)
		return self:OnRegisterLocalConsoleMessage(...)
	end, self)
	GameEvent("custom_get_ability_special_value", function(self, ...)
		return self:OnGetAbilitySpecialValue(...)
	end, self)
	GameEvent("custom_get_unit_data", function(self, ...)
		return self:OnGetUnitData(...)
	end, self)
	GameEvent("custom_get_player_data", function(self, ...)
		return self:OnGetPlayerData(...)
	end, self)
	GameEvent("custom_ability_key_event", function(self, ...)
		return self:OnAbilityKeyEvent(...)
	end, self)
	GameEvent("custom_update_portrait_name", function(self, ...)
		return self:OnCustomUpdatePortraitName(...)
	end, self)
	GameEvent("custom_update_preview_attacker_model", function(self, ...)
		return self:OnCustomUpdatePreviewAttackerModel(...)
	end, self)
	RequestEvent("register_ability_key_event", function(self, ...)
		return self:OnRegisterAbilityKeyEvent(...)
	end, self)
	RequestEvent("unregister_ability_key_event", function(self, ...)
		return self:OnUnregisterAbilityKeyEvent(...)
	end, self)
	RequestEvent("get_unit_stats_data", function(self, t)
		local u = EntIndexToHScript(t.unit)
		local q = {
			Attack = 0,
			Critical = 0,
			CriticalDamage = 0,
			Evasion = 0,
			EvasionReduce = 0,
			Power = 0,
			PhysicalReduce = 0,
			MagicalReduce = 0,
			PhysicalDamage = 0,
			MagicalDamage = 0,
			StateResistance = 0,
			ManaRegen = 0,
			Shield = 0,
			Injury = 0,
			Fury = 0,
			Ice = 0,
			Poison = 0,
			FuryPct = 0,
			IcePct = 0,
			Regen = 0,
			RegenPct = 0,
			WispInterval = 0,
			ChaosDamage = 0,
			Chaos = 0,
		}
		if u ~= nil then
			q.Attack = GetAttackDamage(u)
			q.Critical = GetPhysicalCriticalChance(u)
			q.CriticalDamage = GetPhysicalCriticalDamage(u)
			q.Evasion = GetEvasion(u)
			q.EvasionReduce = GetEvasionIncomingDamageReducePercentage(u)
			q.Power = GetUltiPower(u)
			q.PhysicalReduce = GetIncomingPhysicalDamagePercent(u)
			q.MagicalReduce = GetIncomingMagicalDamagePercent(u)
			q.PhysicalDamage = GetOutgoingPhysicalDamagePercent(u)
			q.MagicalDamage = GetOutgoingMagicalDamagePercent(u)
			q.StateResistance = GetStateResistance(u)
			q.ManaRegen = GetManaRegen(u)
			q.Shield = GetShieldBonus(u)
			q.Injury = GetInjuryBonus(u)
			q.Fury = GetFuryBonus(u)
			q.Ice = GetIceBonus(u)
			q.Poison = GetPoisonBonus(u)
			q.FuryPct = GetFuryBonusPct(u)
			q.IcePct = GetIceBonusPct(u)
			q.Regen = GetHealBonus(u)
			q.RegenPct = GetHealAmplify(u)
			q.WispInterval = GetWispInterval(u)
			q.ChaosDamage = GetChaosDamageBonus(u)
			q.Chaos = GetChaosBonus(u)
		end
		return q
	end, self)
	GameEvent("date_now", function(self, v)
		_G.date_now = v.date
	end, self)
	GameEvent("client_side_event", function(self, v)
		if v.event_name == "cosmetics_update" then
			self.tCurrentCosmetics = json.decode(v.event_data)
		end
	end, self)
end
function l.prototype.OnGetAbilitySpecialValue(self, v)
	_G.GetAbilitySpecialValue_AbilityEntIndex = v.ability_ent_index
	_G.GetAbilitySpecialValue_Level = v.level
	_G.GetAbilitySpecialValue_KeyName = v.key_name
end
function l.prototype.OnGetUnitData(self, v)
	_G.GetUnitData_UnitEntIndex = v.unit_ent_index
	_G.GetUnitData_FunctionName = v.function_name
end
function l.prototype.OnGetPlayerData(self, v)
	_G.GetPlayerData_PlayerID = v.player_id
	_G.GetPlayerData_FunctionName = v.function_name
end
function l.prototype.OnAbilityKeyEvent(self, v)
	local w = self.tAbilityKeyEvent[v.event_name]
	if w then
		local x = w.slot
		repeat
			local y = v.phase
			local z = y == 0
			if z then
				SendToConsole("dota_ability_autocast " .. tostring(x))
				break
			end
			z = z or y == 1
			if z then
				if w.quick_cast then
					SendToConsole(("dota_ability_quickcast " .. tostring(x)) .. " 1")
				else
					SendToConsole("dota_ability_execute " .. tostring(x))
				end
				break
			end
			z = z or y == 2
			if z then
				if w.quick_cast then
					SendToConsole(("dota_ability_quickcast " .. tostring(x)) .. " 0")
				end
				break
			end
			do
				break
			end
		until true
	end
end
function l.prototype.OnRegisterAbilityKeyEvent(self, v)
	local A = DoUniqueString(v.key_name)
	SendToConsole((("bind " .. v.key_name) .. " +") .. A)
	self.tAbilityKeyEvent[A] = { slot = v.slot, key_name = v.key_name, quick_cast = v.quick_cast }
	return { event_name = A }
end
function l.prototype.OnUnregisterAbilityKeyEvent(self, v)
	local w = self.tAbilityKeyEvent[v.event_name]
	local B = false
	if w ~= nil then
		B = true
		e(self.tAbilityKeyEvent, v.event_name)
		SendToConsole((("unbind " .. w.key_name) .. " +") .. v.event_name)
	end
	return { success = B }
end
function l.prototype.OnCustomUpdatePortraitName(self, v)
	if _G._tPortraitList == nil then
		_G._tPortraitList = {}
	end
	for C = #_G._tPortraitList, 1, -1 do
		if _G._tPortraitList[C].time <= GameRules:GetGameTime() - 1 then
			table.remove(_G._tPortraitList, C)
		end
	end
	table.insert(_G._tPortraitList, { name = v.name, time = GameRules:GetGameTime() })
end
function l.prototype.OnCustomUpdatePreviewAttackerModel(self, v)
	attackerModel = v.model
end
function l.prototype.OnRegisterLocalConsoleMessage(self, v)
	local D = v.event
	local E = v.key
	if v.enable == 1 then
		if self.tLocalConsoleMessageEvent[D] == nil then
			self.tLocalConsoleMessageEvent[D] = {}
		end
		self.tLocalConsoleMessageEvent[D][E] = true
	else
		if self.tLocalConsoleMessageEvent[D] then
			self.tLocalConsoleMessageEvent[D][E] = nil
		end
	end
end
function l.prototype.SendLocalConsoleMessage(self, F, p)
	if self.tLocalConsoleMessageEvent[F] then
		local G = json.encode(p)
		G = url_encode_unicode(nil, G)
		for H, I in pairs(self.tLocalConsoleMessageEvent[F]) do
			if I then
				SendToConsole(((F .. H) .. " ") .. G)
			end
		end
	end
end
function l.prototype.GetPlayerPortraitData(self, J)
	local K = CustomNetTables:GetTableValue("player_extra_data", "player_data_index")
	if K and K[tostring(J)] then
		local L = K[tostring(J)]
		local M = CustomNetTables:GetTableValue("player_data", tostring(L))
		if M then
			local N = Wearable:getWearableID(M.heroName, L)
			return { playerID = L, unit_name = N or M.heroName or "" }
		end
	end
end
l = f({ k }, l)
if _G.Client == nil then
	_G.Client = g(l)
end
if _G.cosmeticPreviewLiveState == nil then
	_G.cosmeticPreviewLiveState = false
end
if _G.PlayerHomePos == nil then
	PlayerHomePos = {
		Vector(-11264, -11264, 0),
		Vector(0, -11264, 0),
		Vector(11264, -11264, 0),
		Vector(-11264, 0, 0),
		Vector(11264, 0, 0),
		Vector(-11264, 11264, 0),
		Vector(0, 11264, 0),
		Vector(11264, 11264, 0),
	}
end
if _G.HeroPortraitDataQueue == nil then
	_G.HeroPortraitDataQueue = {}
end
if not Activated then
	CModule:initialize()
end
require("reload")
return i