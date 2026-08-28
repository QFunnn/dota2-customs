--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		["147"] = 490,
		["148"] = 490,
		["149"] = 490,
		["150"] = 490,
		["152"] = 490,
		["153"] = 510,
		["154"] = 490,
		["155"] = 516,
		["156"] = 517,
		["157"] = 516,
		["158"] = 520,
		["159"] = 521,
		["162"] = 523,
		["163"] = 525,
		["164"] = 526,
		["165"] = 527,
		["166"] = 528,
		["167"] = 529,
		["168"] = 530,
		["169"] = 531,
		["170"] = 532,
		["171"] = 533,
		["173"] = 535,
		["175"] = 537,
		["177"] = 529,
		["178"] = 541,
		["179"] = 542,
		["180"] = 543,
		["181"] = 544,
		["182"] = 545,
		["183"] = 546,
		["184"] = 547,
		["185"] = 548,
		["186"] = 549,
		["189"] = 552,
		["192"] = 555,
		["193"] = 556,
		["194"] = 557,
		["195"] = 558,
		["196"] = 559,
		["197"] = 560,
		["198"] = 561,
		["199"] = 562,
		["202"] = 565,
		["205"] = 568,
		["206"] = 569,
		["207"] = 570,
		["208"] = 571,
		["209"] = 572,
		["210"] = 573,
		["211"] = 574,
		["212"] = 575,
		["213"] = 576,
		["216"] = 579,
		["219"] = 583,
		["220"] = 584,
		["221"] = 585,
		["222"] = 586,
		["223"] = 587,
		["224"] = 588,
		["225"] = 588,
		["226"] = 588,
		["228"] = 588,
		["230"] = 588,
		["231"] = 589,
		["232"] = 589,
		["233"] = 589,
		["235"] = 589,
		["237"] = 589,
		["238"] = 590,
		["242"] = 595,
		["243"] = 596,
		["244"] = 597,
		["246"] = 600,
		["247"] = 601,
		["249"] = 603,
		["250"] = 604,
		["251"] = 605,
		["253"] = 607,
		["255"] = 609,
		["257"] = 520,
		["258"] = 612,
		["259"] = 613,
		["262"] = 615,
		["263"] = 617,
		["264"] = 618,
		["265"] = 619,
		["266"] = 620,
		["267"] = 621,
		["268"] = 622,
		["269"] = 623,
		["270"] = 624,
		["271"] = 625,
		["273"] = 627,
		["275"] = 629,
		["277"] = 621,
		["278"] = 633,
		["279"] = 634,
		["280"] = 635,
		["281"] = 636,
		["282"] = 637,
		["283"] = 638,
		["284"] = 639,
		["285"] = 640,
		["286"] = 641,
		["291"] = 646,
		["292"] = 647,
		["293"] = 648,
		["294"] = 649,
		["295"] = 650,
		["296"] = 651,
		["297"] = 652,
		["298"] = 653,
		["301"] = 656,
		["304"] = 660,
		["305"] = 661,
		["307"] = 663,
		["308"] = 664,
		["309"] = 665,
		["311"] = 667,
		["313"] = 669,
		["315"] = 672,
		["316"] = 674,
		["317"] = 676,
		["318"] = 676,
		["319"] = 676,
		["320"] = 676,
		["321"] = 677,
		["322"] = 679,
		["325"] = 612,
		["326"] = 683,
		["327"] = 683,
		["328"] = 684,
		["329"] = 685,
		["330"] = 686,
		["332"] = 688,
		["333"] = 688,
		["334"] = 688,
		["335"] = 688,
		["336"] = 689,
		["337"] = 690,
		["339"] = 688,
		["340"] = 688,
		["342"] = 683,
		["343"] = 695,
		["344"] = 696,
		["345"] = 698,
		["346"] = 700,
		["347"] = 701,
		["348"] = 702,
		["349"] = 703,
		["350"] = 704,
		["351"] = 705,
		["352"] = 706,
		["353"] = 707,
		["354"] = 708,
		["356"] = 710,
		["358"] = 712,
		["360"] = 704,
		["361"] = 716,
		["362"] = 717,
		["363"] = 718,
		["364"] = 719,
		["365"] = 720,
		["366"] = 721,
		["367"] = 722,
		["368"] = 723,
		["371"] = 726,
		["373"] = 728,
		["375"] = 731,
		["376"] = 732,
		["377"] = 733,
		["378"] = 734,
		["379"] = 735,
		["380"] = 736,
		["381"] = 737,
		["384"] = 740,
		["386"] = 742,
		["388"] = 745,
		["389"] = 746,
		["390"] = 747,
		["391"] = 748,
		["392"] = 749,
		["393"] = 749,
		["394"] = 749,
		["396"] = 749,
		["398"] = 749,
		["399"] = 750,
		["400"] = 750,
		["401"] = 750,
		["403"] = 750,
		["405"] = 750,
		["406"] = 751,
		["408"] = 753,
		["410"] = 755,
		["411"] = 756,
		["413"] = 758,
		["414"] = 759,
		["416"] = 761,
		["417"] = 762,
		["418"] = 763,
		["420"] = 765,
		["422"] = 767,
		["424"] = 769,
		["425"] = 770,
		["426"] = 770,
		["427"] = 770,
		["428"] = 771,
		["429"] = 770,
		["430"] = 770,
		["432"] = 774,
		["433"] = 775,
		["436"] = 695,
		["437"] = 779,
		["438"] = 780,
		["439"] = 781,
		["440"] = 782,
		["441"] = 783,
		["442"] = 784,
		["443"] = 785,
		["444"] = 786,
		["449"] = 791,
		["450"] = 792,
		["451"] = 793,
		["452"] = 794,
		["453"] = 795,
		["459"] = 801,
		["460"] = 802,
		["462"] = 806,
		["463"] = 807,
		["464"] = 808,
		["465"] = 809,
		["466"] = 810,
		["468"] = 812,
		["469"] = 813,
		["470"] = 814,
		["471"] = 815,
		["472"] = 816,
		["474"] = 819,
		["475"] = 820,
		["476"] = 821,
		["477"] = 822,
		["478"] = 823,
		["479"] = 824,
		["480"] = 825,
		["481"] = 826,
		["484"] = 829,
		["485"] = 830,
		["486"] = 831,
		["487"] = 832,
		["488"] = 833,
		["489"] = 834,
		["490"] = 835,
		["492"] = 837,
		["493"] = 838,
		["494"] = 838,
		["495"] = 839,
		["499"] = 843,
		["500"] = 844,
		["502"] = 846,
		["503"] = 847,
		["504"] = 848,
		["507"] = 851,
		["508"] = 852,
		["509"] = 853,
		["511"] = 856,
		["512"] = 857,
		["514"] = 860,
		["515"] = 860,
		["516"] = 865,
		["517"] = 866,
		["518"] = 866,
		["519"] = 866,
		["520"] = 867,
		["523"] = 869,
		["524"] = 870,
		["525"] = 871,
		["526"] = 872,
		["527"] = 873,
		["529"] = 875,
		["530"] = 877,
		["532"] = 879,
		["533"] = 880,
		["535"] = 882,
		["537"] = 866,
		["538"] = 866,
		["543"] = 779,
		["544"] = 892,
		["545"] = 892,
		["546"] = 892,
		["547"] = 892,
		["548"] = 895,
		["549"] = 895,
		["550"] = 895,
		["551"] = 895,
		["552"] = 898,
		["553"] = 898,
		["554"] = 898,
		["555"] = 898,
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