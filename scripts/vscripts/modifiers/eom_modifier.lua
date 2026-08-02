--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/eom_modifier"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 2,
		["9"] = 2,
		["10"] = 2,
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 39,
		["15"] = 40,
		["16"] = 41,
		["17"] = 42,
		["18"] = 43,
		["19"] = 45,
		["21"] = 47,
		["23"] = 50,
		["24"] = 52,
		["25"] = 54,
		["26"] = 56,
		["27"] = 57,
		["28"] = 58,
		["29"] = 59,
		["30"] = 60,
		["31"] = 61,
		["33"] = 63,
		["34"] = 64,
		["36"] = 66,
		["37"] = 67,
		["39"] = 69,
		["40"] = 70,
		["43"] = 74,
		["45"] = 77,
		["46"] = 78,
		["47"] = 79,
		["48"] = 81,
		["49"] = 83,
		["50"] = 85,
		["51"] = 85,
		["52"] = 85,
		["53"] = 85,
		["54"] = 86,
		["55"] = 88,
		["58"] = 91,
		["59"] = 92,
		["60"] = 93,
		["61"] = 94,
		["62"] = 95,
		["63"] = 96,
		["64"] = 97,
		["65"] = 98,
		["67"] = 100,
		["68"] = 101,
		["69"] = 102,
		["71"] = 104,
		["72"] = 105,
		["74"] = 107,
		["75"] = 108,
		["77"] = 79,
		["78"] = 111,
		["79"] = 112,
		["80"] = 113,
		["81"] = 114,
		["83"] = 116,
		["84"] = 117,
		["86"] = 119,
		["87"] = 120,
		["89"] = 122,
		["90"] = 123,
		["92"] = 112,
		["93"] = 126,
		["94"] = 127,
		["95"] = 128,
		["96"] = 129,
		["98"] = 131,
		["99"] = 132,
		["101"] = 127,
		["102"] = 135,
		["103"] = 136,
		["104"] = 137,
		["105"] = 138,
		["107"] = 140,
		["108"] = 141,
		["110"] = 136,
		["111"] = 144,
		["112"] = 145,
		["113"] = 146,
		["114"] = 147,
		["115"] = 146,
		["118"] = 152,
		["119"] = 153,
		["120"] = 154,
		["121"] = 155,
		["122"] = 156,
		["123"] = 157,
		["124"] = 154,
		["126"] = 160,
		["127"] = 161,
		["128"] = 162,
		["129"] = 163,
		["130"] = 164,
		["131"] = 165,
		["132"] = 162,
		["134"] = 168,
		["135"] = 169,
		["136"] = 170,
		["137"] = 171,
		["138"] = 172,
		["139"] = 173,
		["140"] = 170,
		["142"] = 176,
		["143"] = 177,
		["145"] = 42,
		["146"] = 39,
		["147"] = 486,
		["148"] = 486,
		["149"] = 486,
		["150"] = 486,
		["152"] = 486,
		["153"] = 506,
		["154"] = 486,
		["155"] = 512,
		["156"] = 513,
		["157"] = 512,
		["158"] = 516,
		["159"] = 517,
		["162"] = 519,
		["163"] = 521,
		["164"] = 522,
		["165"] = 523,
		["166"] = 524,
		["167"] = 525,
		["168"] = 526,
		["169"] = 527,
		["170"] = 528,
		["171"] = 529,
		["173"] = 531,
		["175"] = 533,
		["177"] = 525,
		["178"] = 537,
		["179"] = 538,
		["180"] = 539,
		["181"] = 540,
		["182"] = 541,
		["183"] = 542,
		["184"] = 543,
		["185"] = 544,
		["186"] = 545,
		["189"] = 548,
		["192"] = 551,
		["193"] = 552,
		["194"] = 553,
		["195"] = 554,
		["196"] = 555,
		["197"] = 556,
		["198"] = 557,
		["199"] = 558,
		["202"] = 561,
		["205"] = 564,
		["206"] = 565,
		["207"] = 566,
		["208"] = 567,
		["209"] = 568,
		["210"] = 569,
		["211"] = 570,
		["212"] = 571,
		["213"] = 572,
		["216"] = 575,
		["219"] = 579,
		["220"] = 580,
		["221"] = 581,
		["222"] = 582,
		["223"] = 583,
		["224"] = 584,
		["225"] = 584,
		["226"] = 584,
		["228"] = 584,
		["230"] = 584,
		["231"] = 585,
		["232"] = 585,
		["233"] = 585,
		["235"] = 585,
		["237"] = 585,
		["238"] = 586,
		["242"] = 591,
		["243"] = 592,
		["244"] = 593,
		["246"] = 596,
		["247"] = 597,
		["249"] = 599,
		["250"] = 600,
		["251"] = 601,
		["253"] = 603,
		["255"] = 605,
		["257"] = 516,
		["258"] = 608,
		["259"] = 609,
		["262"] = 611,
		["263"] = 613,
		["264"] = 614,
		["265"] = 615,
		["266"] = 616,
		["267"] = 617,
		["268"] = 618,
		["269"] = 619,
		["270"] = 620,
		["271"] = 621,
		["273"] = 623,
		["275"] = 625,
		["277"] = 617,
		["278"] = 629,
		["279"] = 630,
		["280"] = 631,
		["281"] = 632,
		["282"] = 633,
		["283"] = 634,
		["284"] = 635,
		["285"] = 636,
		["286"] = 637,
		["291"] = 642,
		["292"] = 643,
		["293"] = 644,
		["294"] = 645,
		["295"] = 646,
		["296"] = 647,
		["297"] = 648,
		["298"] = 649,
		["301"] = 652,
		["304"] = 656,
		["305"] = 657,
		["307"] = 659,
		["308"] = 660,
		["309"] = 661,
		["311"] = 663,
		["313"] = 665,
		["315"] = 668,
		["316"] = 670,
		["317"] = 672,
		["318"] = 672,
		["319"] = 672,
		["320"] = 672,
		["321"] = 673,
		["322"] = 675,
		["325"] = 608,
		["326"] = 679,
		["327"] = 679,
		["328"] = 680,
		["329"] = 681,
		["330"] = 682,
		["332"] = 684,
		["333"] = 684,
		["334"] = 684,
		["335"] = 684,
		["336"] = 685,
		["337"] = 686,
		["339"] = 684,
		["340"] = 684,
		["342"] = 679,
		["343"] = 691,
		["344"] = 692,
		["345"] = 694,
		["346"] = 696,
		["347"] = 697,
		["348"] = 698,
		["349"] = 699,
		["350"] = 700,
		["351"] = 701,
		["352"] = 702,
		["353"] = 703,
		["354"] = 704,
		["356"] = 706,
		["358"] = 708,
		["360"] = 700,
		["361"] = 712,
		["362"] = 713,
		["363"] = 714,
		["364"] = 715,
		["365"] = 716,
		["366"] = 717,
		["367"] = 718,
		["368"] = 719,
		["371"] = 722,
		["373"] = 724,
		["375"] = 727,
		["376"] = 728,
		["377"] = 729,
		["378"] = 730,
		["379"] = 731,
		["380"] = 732,
		["381"] = 733,
		["384"] = 736,
		["386"] = 738,
		["388"] = 741,
		["389"] = 742,
		["390"] = 743,
		["391"] = 744,
		["392"] = 745,
		["393"] = 745,
		["394"] = 745,
		["396"] = 745,
		["398"] = 745,
		["399"] = 746,
		["400"] = 746,
		["401"] = 746,
		["403"] = 746,
		["405"] = 746,
		["406"] = 747,
		["408"] = 749,
		["410"] = 751,
		["411"] = 752,
		["413"] = 754,
		["414"] = 755,
		["416"] = 757,
		["417"] = 758,
		["418"] = 759,
		["420"] = 761,
		["422"] = 763,
		["424"] = 765,
		["425"] = 766,
		["426"] = 766,
		["427"] = 766,
		["428"] = 767,
		["429"] = 766,
		["430"] = 766,
		["432"] = 770,
		["433"] = 771,
		["436"] = 691,
		["437"] = 775,
		["438"] = 776,
		["439"] = 777,
		["440"] = 778,
		["441"] = 779,
		["442"] = 780,
		["443"] = 781,
		["444"] = 782,
		["449"] = 787,
		["450"] = 788,
		["451"] = 789,
		["452"] = 790,
		["453"] = 791,
		["459"] = 797,
		["460"] = 798,
		["462"] = 802,
		["463"] = 803,
		["464"] = 804,
		["465"] = 805,
		["466"] = 806,
		["468"] = 808,
		["469"] = 809,
		["470"] = 810,
		["471"] = 811,
		["472"] = 812,
		["474"] = 815,
		["475"] = 816,
		["476"] = 817,
		["477"] = 818,
		["478"] = 819,
		["479"] = 820,
		["480"] = 821,
		["481"] = 822,
		["484"] = 825,
		["485"] = 826,
		["486"] = 827,
		["487"] = 828,
		["488"] = 829,
		["489"] = 830,
		["490"] = 831,
		["492"] = 833,
		["493"] = 834,
		["494"] = 834,
		["495"] = 835,
		["499"] = 839,
		["500"] = 840,
		["502"] = 842,
		["503"] = 843,
		["504"] = 844,
		["507"] = 847,
		["508"] = 848,
		["509"] = 849,
		["511"] = 852,
		["512"] = 853,
		["514"] = 856,
		["515"] = 856,
		["516"] = 861,
		["517"] = 862,
		["518"] = 862,
		["519"] = 862,
		["520"] = 863,
		["523"] = 865,
		["524"] = 866,
		["525"] = 867,
		["526"] = 868,
		["527"] = 869,
		["529"] = 871,
		["530"] = 873,
		["532"] = 875,
		["533"] = 876,
		["535"] = 878,
		["537"] = 862,
		["538"] = 862,
		["543"] = 775,
		["544"] = 888,
		["545"] = 888,
		["546"] = 888,
		["547"] = 888,
		["548"] = 891,
		["549"] = 891,
		["550"] = 891,
		["551"] = 891,
		["552"] = 894,
		["553"] = 894,
		["554"] = 894,
		["555"] = 894,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseModifier
local j = h.BaseModifierMotionBoth
local k = h.BaseModifierMotionHorizontal
local l = h.BaseModifierMotionVertical
local m = h.toDotaClassInstance
g.registerEOMModifier = function(self, n)
	local o = self
	local p = n and n.name
	return function(q, r)
		if p ~= nil then
			r.name = p
		else
			p = r.name
		end
		local s = _G
		s[p] = {}
		m(nil, s[p], r)
		local t = false
		local u = LUA_MODIFIER_MOTION_NONE
		local v = r.____super
		while v do
			if
				not t
				and (
					v == g.EOMModifier
					or v == g.EOMModifierMotionBoth
					or v == g.EOMModifierMotionHorizontal
					or v == g.EOMModifierMotionVertical
				)
			then
				t = true
			end
			if v == g.EOMModifierMotionBoth or v == j then
				u = LUA_MODIFIER_MOTION_BOTH
				break
			elseif v == g.EOMModifierMotionHorizontal or v == k then
				u = LUA_MODIFIER_MOTION_HORIZONTAL
				break
			elseif v == g.EOMModifierMotionVertical or v == l then
				u = LUA_MODIFIER_MOTION_VERTICAL
				break
			end
			v = v.____super
		end
		local w = s[p].GetAbilitySpecialValue
		local x = s[p].OnCreated
		s[p].OnCreated = function(self, y)
			if IsServer() then
				if y.duration ~= nil and y.duration ~= -1 then
					local z = Round(math.max(y.duration, FRAME_TIME), 2)
					self:SetDuration(z, true)
					self._lastIndependentDuration = z
				end
			end
			self.parent = self:GetParent()
			self.caster = self:GetCaster()
			self.ability = self:GetAbility()
			self:____constructor()
			self._IsIndependent = n and n.IsIndependent
			self._IsModifierThinker = n and n.IsModifierThinker
			if self._IsIndependent then
				self._IndependentFixed = true
			end
			self._IndependentMaxCount = n and n.IndependentMaxCount
			if w then
				w(self)
			end
			if x then
				x(self, y)
			end
			if t and x ~= g.EOMModifier.prototype.OnCreated then
				g.EOMModifier.prototype.OnCreated(self, y)
			end
		end
		local A = s[p].OnRefresh
		s[p].OnRefresh = function(self, y)
			if self._IsIndependent then
				self._IndependentFixed = true
			end
			if w then
				w(self)
			end
			if A then
				A(self, y)
			end
			if t and A ~= g.EOMModifier.prototype.OnRefresh then
				g.EOMModifier.prototype.OnRefresh(self, y)
			end
		end
		local B = s[p].OnDestroy
		s[p].OnDestroy = function(self)
			if B then
				B(self)
			end
			if t and B ~= g.EOMModifier.prototype.OnDestroy then
				g.EOMModifier.prototype.OnDestroy(self)
			end
		end
		local C = s[p].OnStackCountChanged
		s[p].OnStackCountChanged = function(self, y)
			if C then
				C(self, y)
			end
			if t and C ~= g.EOMModifier.prototype.OnStackCountChanged then
				g.EOMModifier.prototype.OnStackCountChanged(self, y)
			end
		end
		for D, E in pairs(n) do
			if D ~= "name" and type(s[p][D]) ~= "function" then
				s[p][D] = function()
					return E
				end
			end
		end
		local F = s[p].GetModifierProjectileName
		if F then
			s[p].GetModifierProjectileName = function(self)
				local G = F(self)
				ParticleManager:DynamicPrecacheParticle(G)
				return G
			end
		end
		local H = s[p].GetEffectName
		if H then
			s[p].GetEffectName = function(self)
				local G = H(self)
				ParticleManager:DynamicPrecacheParticle(G)
				return G
			end
		end
		local I = s[p].GetStatusEffectName
		if I then
			s[p].GetStatusEffectName = function(self)
				local G = I(self)
				ParticleManager:DynamicPrecacheParticle(G)
				return G
			end
		end
		if o and #o > 0 then
			LinkLuaModifier(p, o, u)
		end
	end
end
g.EOMModifier = c()
local J = g.EOMModifier
J.name = "EOMModifier"
d(J, i)
function J.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.IsLogic = true
end
function J.prototype.IndependentMaxCount(self)
	return 0
end
function J.prototype.OnCreated(self, K)
	if self._bDestroyed then
		return
	end
	local L = self:GetParent()
	local M = false
	local N = false
	local O
	local P = false
	local function Q()
		if not P and IsServer() then
			P = true
			if L:IsHero() then
				L:CalculateStatBonus(true)
			else
				L:CalculateGenericBonuses()
			end
			O = L:GetMana() / L:GetMaxMana()
		end
	end
	if type(self.EDeclareFunctions) == "function" then
		self._EDeclareFunctions = self:EDeclareFunctions()
		for R = 0, #self._EDeclareFunctions - 1, 1 do
			local S = self._EDeclareFunctions[R + 1]
			if IsServer() then
				M = M or EOM_UPDATE_HEALTH_PROPERTY[S]
				N = N or EOM_UPDATE_MANA_PROPERTY[S]
				if N then
					Q(nil)
				end
			end
			RegisterModifierProperty(L, self, S)
		end
	end
	if type(self.EFunctionValues) == "function" then
		self._EFunctionValues = self:EFunctionValues()
		for S, E in pairs(self._EFunctionValues) do
			if IsServer() then
				M = M or EOM_UPDATE_HEALTH_PROPERTY[S]
				N = N or EOM_UPDATE_MANA_PROPERTY[S]
				if N then
					Q(nil)
				end
			end
			SetModifierProperty(L, self, S, E)
		end
	end
	if type(self.EDeclareFunctionsWithPriority) == "function" then
		self._EDeclareFunctionsWithPriority = self:EDeclareFunctionsWithPriority()
		for R = 0, #self._EDeclareFunctionsWithPriority - 1, 1 do
			local S = self._EDeclareFunctionsWithPriority[R + 1]
			if IsServer() then
				M = M or EOM_UPDATE_HEALTH_PROPERTY[S]
				N = N or EOM_UPDATE_MANA_PROPERTY[S]
				if N then
					Q(nil)
				end
			end
			RegisterModifierPropertyWithPriority(L, self, S)
		end
	end
	if IsServer() then
		if type(self.EDeclareEvents) == "function" then
			self._EDeclareEvents = self:EDeclareEvents()
			for T, U in pairs(self._EDeclareEvents) do
				local V, W = unpack(U, 1, 2)
				local X
				if V == -1 then
					X = nil
				else
					X = V
				end
				local Y = X
				local Z
				if W == -1 then
					Z = nil
				else
					Z = W
				end
				local _ = Z
				AddModifierEvents(T, self, Y, _)
			end
		end
	end
	if type(self.ECheckState) == "function" then
		self._ECheckState = self:ECheckState()
		RegisterModifierState(L, self)
	end
	if IsServer() and M then
		L:CalculateHealth()
	end
	if IsServer() and N and O then
		if L:IsHero() then
			L:CalculateStatBonus(true)
		else
			L:CalculateGenericBonuses()
		end
		L:SetMana(O * L:GetMaxMana())
	end
end
function J.prototype.OnRefresh(self, K)
	if self._bDestroyed then
		return
	end
	local L = self:GetParent()
	local M = false
	local N = false
	local O
	local P = false
	local function Q()
		if not P and IsServer() then
			P = true
			if L:IsHero() then
				L:CalculateStatBonus(true)
			else
				L:CalculateGenericBonuses()
			end
			O = L:GetMana() / L:GetMaxMana()
		end
	end
	if type(self.EDeclareFunctions) == "function" then
		self._EDeclareFunctions = self:EDeclareFunctions()
		for R = 0, #self._EDeclareFunctions - 1, 1 do
			local S = self._EDeclareFunctions[R + 1]
			if IsServer() then
				M = M or EOM_UPDATE_HEALTH_PROPERTY[S]
				N = N or EOM_UPDATE_MANA_PROPERTY[S]
				if N then
					Q(nil)
				end
			end
		end
	end
	if type(self.EFunctionValues) == "function" then
		self._EFunctionValues = self:EFunctionValues()
		for S, E in pairs(self._EFunctionValues) do
			if IsServer() then
				M = M or EOM_UPDATE_HEALTH_PROPERTY[S]
				N = N or EOM_UPDATE_MANA_PROPERTY[S]
				if N then
					Q(nil)
				end
			end
			SetModifierProperty(L, self, S, E)
		end
	end
	if IsServer() and M then
		L:CalculateHealth()
	end
	if IsServer() and N and O then
		if L:IsHero() then
			L:CalculateStatBonus(true)
		else
			L:CalculateGenericBonuses()
		end
		L:SetMana(O * L:GetMaxMana())
	end
	if IsServer() then
		if K.duration ~= nil and K.duration ~= -1 then
			local z = Round(math.max(K.duration, FRAME_TIME), 2)
			self:SetDuration(z, false)
			self._lastIndependentDuration = z
		end
	end
end
function J.prototype.EOM_SetDuration(self, ...)
	local a0 = { ... }
	if IsServer() then
		if self._ModifierTime then
			TimerManager:StopTimer(self._ModifierTime)
		end
		self._ModifierTime = TimerManager:GameTimer(self, a0[1], function()
			if IsValid(self) then
				self:Destroy()
			end
		end)
	end
end
function J.prototype.OnDestroy(self)
	self._bDestroyed = true
	local L = self:GetParent()
	local M = false
	local N = false
	local O
	local P = false
	local function Q()
		if not P and IsServer() then
			P = true
			if L:IsHero() then
				L:CalculateStatBonus(true)
			else
				L:CalculateGenericBonuses()
			end
			O = L:GetMana() / L:GetMaxMana()
		end
	end
	if self._EDeclareFunctions ~= nil then
		for R = 0, #self._EDeclareFunctions - 1, 1 do
			local S = self._EDeclareFunctions[R + 1]
			if IsServer() then
				M = M or EOM_UPDATE_HEALTH_PROPERTY[S]
				N = N or EOM_UPDATE_MANA_PROPERTY[S]
				if N then
					Q(nil)
				end
			end
			UnregisterModifierProperty(L, self, S)
		end
		self._EDeclareFunctions = nil
	end
	if self._EFunctionValues ~= nil then
		for S, E in pairs(self._EFunctionValues) do
			if IsServer() then
				M = M or EOM_UPDATE_HEALTH_PROPERTY[S]
				N = N or EOM_UPDATE_MANA_PROPERTY[S]
				if N then
					Q(nil)
				end
			end
			SetModifierProperty(L, self, S, nil)
		end
		self._EFunctionValues = nil
	end
	if IsServer() then
		if self._EDeclareEvents ~= nil then
			for T, U in pairs(self._EDeclareEvents) do
				local V, W = unpack(U, 1, 2)
				local a1
				if V == -1 then
					a1 = nil
				else
					a1 = V
				end
				local Y = a1
				local a2
				if W == -1 then
					a2 = nil
				else
					a2 = W
				end
				local _ = a2
				RemoveModifierEvents(T, self, Y, _)
			end
			self._EDeclareEvents = nil
		end
		if self._ECheckState ~= nil then
			UnregisterModifierState(L, self)
		end
		if M then
			L:CalculateHealth()
		end
		if N and O then
			if L:IsHero() then
				L:CalculateStatBonus(true)
			else
				L:CalculateGenericBonuses()
			end
			L:SetMana(O * L:GetMaxMana())
		end
		if self._HookList then
			e(self._HookList, function(q, a3)
				DamageSystem:unHook(a3)
			end)
		end
		if self._IsModifierThinker then
			L:RemoveSelf()
		end
	end
end
function J.prototype.OnStackCountChanged(self, a4)
	if IsServer() then
		local M = false
		if self._EDeclareFunctions ~= nil then
			for R = 0, #self._EDeclareFunctions - 1, 1 do
				local S = self._EDeclareFunctions[R + 1]
				M = M or EOM_UPDATE_HEALTH_PROPERTY[S]
				if M then
					break
				end
			end
		end
		if not M and self._EFunctionValues ~= nil then
			for S, E in pairs(self._EFunctionValues) do
				if IsServer() then
					M = M or EOM_UPDATE_HEALTH_PROPERTY[S]
					if M then
						break
					end
				end
			end
		end
		if M then
			self:GetParent():CalculateHealth()
		end
		if self._IsIndependent then
			local a5 = self:GetStackCount() - a4
			local a6 = self._IndependentMaxCount ~= nil and self:_IndependentMaxCount() or self:IndependentMaxCount()
			if a6 > 0 then
				a5 = math.min(a5, a6)
			end
			if a5 > 0 then
				local a7 = self:GetStackCount()
				local a8 = self:GetDieTime()
				if self._tIndependentData == nil then
					self._tIndependentData = {}
				end
				if a6 > 0 then
					local a9 = false
					if #self._tIndependentData > 0 then
						local aa = GameRules:GetGameTime()
						while self._tIndependentData[1] ~= nil and self._tIndependentData[1].flDieTime <= aa do
							a7 = a7 - self._tIndependentData[1].iStackCount
							table.remove(self._tIndependentData, 1)
							a9 = true
						end
					end
					local ab = a7 - a6
					while ab > 0 and #self._tIndependentData >= 1 do
						if ab >= self._tIndependentData[1].iStackCount then
							a7 = a7 - self._tIndependentData[1].iStackCount
							ab = ab - self._tIndependentData[1].iStackCount
							a9 = true
							table.remove(self._tIndependentData, 1)
						else
							a7 = a7 - ab
							local ac, ad = self._tIndependentData[1], "iStackCount"
							ac[ad] = ac[ad] - ab
							ab = 0
							break
						end
					end
					if a7 ~= self:GetStackCount() then
						self:SetStackCount(a7)
					end
					if a9 and self._hIndependentTimer ~= nil then
						StopTimer(self._hIndependentTimer)
						self._hIndependentTimer = nil
					end
				end
				if self._IndependentFixed then
					self._IndependentFixed = nil
					a8 = a8 + 0.04
				end
				if self._lastIndependentDuration ~= nil then
					a8 = GameRules:GetGameTime() + self._lastIndependentDuration
				end
				local ae = self._tIndependentData
				ae[#ae + 1] = { iStackCount = a5, flDieTime = a8 }
				if self._hIndependentTimer == nil then
					self._hIndependentTimer = GameTimer(
						self._tIndependentData[1].flDieTime - GameRules:GetGameTime(),
						function()
							if not IsValid(self) then
								return
							end
							local aa = GameRules:GetGameTime()
							local af = 0
							while self._tIndependentData[1] ~= nil and self._tIndependentData[1].flDieTime <= aa do
								af = af + self._tIndependentData[1].iStackCount
								table.remove(self._tIndependentData, 1)
							end
							if af > 0 then
								self:DecrementStackCount(af)
							end
							if #self._tIndependentData > 0 then
								return self._tIndependentData[1].flDieTime - aa
							else
								self._hIndependentTimer = nil
							end
						end
					)
				end
			end
		end
	end
end
g.EOMModifierMotionHorizontal = c()
local ag = g.EOMModifierMotionHorizontal
ag.name = "EOMModifierMotionHorizontal"
d(ag, g.EOMModifier)
g.EOMModifierMotionVertical = c()
local ah = g.EOMModifierMotionVertical
ah.name = "EOMModifierMotionVertical"
d(ah, g.EOMModifier)
g.EOMModifierMotionBoth = c()
local ai = g.EOMModifierMotionBoth
ai.name = "EOMModifierMotionBoth"
d(ai, g.EOMModifier)
return g