--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil/greevil_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__StringSplit
local g = b.__TS__ArrayIncludes
local h = b.__TS__ArraySome
local i = b.__TS__ArrayForEach
local j = b.__TS__New
local k = b.__TS__SourceMapTraceBack
k(
	debug.getinfo(1).short_src,
	{
		["13"] = 1,
		["14"] = 1,
		["15"] = 2,
		["16"] = 2,
		["17"] = 2,
		["18"] = 3,
		["19"] = 3,
		["20"] = 3,
		["21"] = 4,
		["22"] = 9,
		["23"] = 10,
		["24"] = 11,
		["25"] = 12,
		["26"] = 13,
		["27"] = 13,
		["31"] = 17,
		["32"] = 27,
		["33"] = 17,
		["34"] = 27,
		["35"] = 28,
		["36"] = 29,
		["37"] = 30,
		["39"] = 28,
		["40"] = 27,
		["41"] = 17,
		["42"] = 17,
		["43"] = 17,
		["44"] = 17,
		["45"] = 17,
		["46"] = 17,
		["47"] = 17,
		["48"] = 17,
		["49"] = 17,
		["50"] = 17,
		["51"] = 27,
		["53"] = 27,
		["54"] = 35,
		["55"] = 36,
		["56"] = 35,
		["57"] = 36,
		["58"] = 37,
		["59"] = 38,
		["60"] = 37,
		["61"] = 36,
		["62"] = 35,
		["63"] = 36,
		["65"] = 36,
		["66"] = 42,
		["67"] = 50,
		["68"] = 42,
		["69"] = 50,
		["70"] = 51,
		["71"] = 52,
		["72"] = 51,
		["73"] = 56,
		["74"] = 57,
		["75"] = 56,
		["76"] = 50,
		["77"] = 42,
		["78"] = 42,
		["79"] = 42,
		["80"] = 42,
		["81"] = 42,
		["82"] = 42,
		["83"] = 42,
		["84"] = 42,
		["85"] = 50,
		["87"] = 50,
		["88"] = 61,
		["89"] = 69,
		["90"] = 61,
		["91"] = 69,
		["93"] = 69,
		["94"] = 79,
		["95"] = 61,
		["96"] = 80,
		["97"] = 81,
		["98"] = 82,
		["99"] = 83,
		["100"] = 84,
		["101"] = 85,
		["102"] = 86,
		["103"] = 87,
		["104"] = 88,
		["105"] = 80,
		["106"] = 91,
		["107"] = 92,
		["108"] = 93,
		["109"] = 94,
		["110"] = 91,
		["111"] = 100,
		["112"] = 101,
		["113"] = 103,
		["114"] = 104,
		["115"] = 105,
		["118"] = 106,
		["119"] = 107,
		["120"] = 108,
		["121"] = 109,
		["122"] = 110,
		["124"] = 112,
		["126"] = 115,
		["127"] = 116,
		["128"] = 117,
		["129"] = 118,
		["130"] = 119,
		["131"] = 119,
		["132"] = 119,
		["133"] = 120,
		["134"] = 120,
		["135"] = 121,
		["136"] = 122,
		["137"] = 123,
		["138"] = 124,
		["139"] = 124,
		["140"] = 124,
		["141"] = 124,
		["142"] = 125,
		["143"] = 125,
		["146"] = 119,
		["147"] = 119,
		["150"] = 100,
		["151"] = 133,
		["152"] = 134,
		["153"] = 135,
		["155"] = 133,
		["156"] = 139,
		["157"] = 140,
		["158"] = 141,
		["160"] = 139,
		["161"] = 145,
		["162"] = 146,
		["163"] = 147,
		["166"] = 148,
		["167"] = 149,
		["168"] = 150,
		["171"] = 153,
		["172"] = 154,
		["173"] = 157,
		["174"] = 158,
		["175"] = 159,
		["176"] = 160,
		["177"] = 161,
		["178"] = 162,
		["179"] = 163,
		["180"] = 164,
		["181"] = 165,
		["182"] = 166,
		["183"] = 167,
		["184"] = 168,
		["185"] = 169,
		["186"] = 170,
		["188"] = 172,
		["189"] = 173,
		["191"] = 176,
		["192"] = 177,
		["193"] = 178,
		["194"] = 179,
		["195"] = 179,
		["196"] = 179,
		["197"] = 180,
		["198"] = 179,
		["199"] = 179,
		["202"] = 184,
		["203"] = 185,
		["204"] = 186,
		["205"] = 187,
		["206"] = 187,
		["207"] = 187,
		["208"] = 187,
		["209"] = 187,
		["210"] = 188,
		["211"] = 188,
		["212"] = 188,
		["213"] = 190,
		["215"] = 191,
		["216"] = 191,
		["217"] = 192,
		["218"] = 193,
		["219"] = 194,
		["221"] = 191,
		["224"] = 197,
		["225"] = 197,
		["226"] = 197,
		["227"] = 197,
		["228"] = 198,
		["231"] = 199,
		["232"] = 200,
		["233"] = 201,
		["235"] = 197,
		["236"] = 197,
		["237"] = 204,
		["238"] = 204,
		["239"] = 204,
		["240"] = 204,
		["241"] = 204,
		["242"] = 204,
		["243"] = 204,
		["244"] = 188,
		["245"] = 188,
		["246"] = 145,
		["247"] = 69,
		["248"] = 61,
		["249"] = 61,
		["250"] = 61,
		["251"] = 61,
		["252"] = 61,
		["253"] = 61,
		["254"] = 61,
		["255"] = 61,
		["256"] = 69,
		["258"] = 69,
	}
)
local l = {}
local m = require("class.weight_pool")
local n = m.CWeightPool
local o = require("lib.dota_ts_adapter")
local p = o.BaseAbility
local q = o.registerAbility
local r = require("modifiers.eom_modifier")
local s = r.EOMModifier
local t = r.registerEOMModifier
local u = { n = {}, r = {}, sr = {} }
for v, w in pairs(KeyValues.AbilityUpgradesKvs) do
	if w.Triggerable ~= nil and w.script_ability ~= nil then
		local x = w.rarity
		if u[x] ~= nil then
			local y = u[x]
			y[#y + 1] = v
		end
	end
end
l.modifier_skin_greevil_1 = c()
local z = l.modifier_skin_greevil_1
z.name = "modifier_skin_greevil_1"
d(z, s)
function z.prototype.OnCreated(self, A)
	if IsServer() then
		self.parent:SetSkin(1)
	end
end
z = e(
	{
		t(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetStatusEffectName = "particles/gameplay/greevil_amibent_status_1.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_ULTRA,
				RemoveOnDeath = false,
			}
		),
	},
	z
)
l.modifier_skin_greevil_1 = z
l.greevil_1 = c()
local B = l.greevil_1
B.name = "greevil_1"
d(B, p)
function B.prototype.GetIntrinsicModifierName(self)
	return "modifier_greevil_1"
end
B = e({ q(nil) }, B)
l.greevil_1 = B
l.modifier_greevil_1 = c()
local C = l.modifier_greevil_1
C.name = "modifier_greevil_1"
d(C, s)
function C.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function C.prototype.OnBattleStartBefore(self, A)
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_greevil_1_battle_buff", {})
end
C = e(
	{
		t(
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
	C
)
l.modifier_greevil_1 = C
l.modifier_greevil_1_battle_buff = c()
local D = l.modifier_greevil_1_battle_buff
D.name = "modifier_greevil_1_battle_buff"
d(D, s)
function D.prototype.____constructor(self, ...)
	s.prototype.____constructor(self, ...)
	self.rarityList = {}
end
function D.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.dice_max = self:GetAbilitySpecialValueFor("dice_max")
	self.v_1 = self:GetAbilitySpecialValueFor("v_1")
	self.v_2 = self:GetAbilitySpecialValueFor("v_2")
	self.v_3 = self:GetAbilitySpecialValueFor("v_3")
	self.v_4 = self:GetAbilitySpecialValueFor("v_4")
	self.v_5 = self:GetAbilitySpecialValueFor("v_5")
	self.v_6 = self:GetAbilitySpecialValueFor("v_6")
end
function D.prototype.EDeclareEvents(self)
	local E = self:GetParent()
	local F = E:GetCaster()
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { F, F },
	}
end
function D.prototype.OnCreated(self)
	if IsServer() then
		local G = self.parent:GetPlayerOwnerID()
		local H = PlayerData:getplayerData(G)
		if not H then
			return
		end
		local I = H.heroName
		local J = {}
		local K = AbilityShop:GetRecommendSectByHeroName(I)
		if K and K ~= "sect_none" then
			J = f(K, "|")
		else
			J = AbilityShop.pickList
		end
		local L = PlayerData:getHero(G)
		local M = L:getAbilityUpgradeData()
		for N in pairs(u) do
			self.rarityList[N] = {}
			i(u[N], function(O, v)
				local P = M[v]
				local Q = P and P.level or 0
				if Q > 0 then
					local R = KeyValues.AbilityUpgradesKvs[v]
					local S = f(R.sect, "|")
					if h(J, function(O, T)
						return g(S, T)
					end) then
						local U = self.rarityList[N]
						U[#U + 1] = v
					end
				end
			end)
		end
	end
end
function D.prototype.OnBattleStart(self)
	if IsServer() then
		self:StartIntervalThink(self.interval)
	end
end
function D.prototype.OnBattleEnd(self)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
function D.prototype.OnIntervalThink(self)
	local E = self:GetParent()
	if not IsInjurable(E) then
		return
	end
	local F = E:GetCaster()
	local V = E:GetEnemy()
	if not IsInjurable(F, V) then
		return
	end
	local W = math.floor(self.dice_max)
	local X = RandomInt(1, W)
	local Y = 0
	local Z = { "n" }
	if X == 1 then
		Y = self.v_1
	elseif X == 2 then
		Y = self.v_2
	elseif X == 3 then
		Y = self.v_3
	elseif X == 4 then
		Y = self.v_4
		Z = { "n", "r" }
	elseif X == 5 then
		Y = self.v_5
		Z = { "n", "r" }
	else
		Y = self.v_6
		Z = { "n", "r", "sr" }
	end
	local _ = j(n, {})
	for N in pairs(self.rarityList) do
		if g(Z, N) then
			i(self.rarityList[N], function(O, v)
				_:add(v, 1)
			end)
		end
	end
	E:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	E:EmitSound("Hero_Zuus.Taunt.Jump")
	local a0 = ParticleManager:CreateParticle("particles/gameplay/cube_dice_custom.vpcf", PATTACH_OVERHEAD_FOLLOW, E)
	ParticleManager:SetParticleControl(a0, 1, Vector(X, 0, 0))
	GameTimer(0.2, function()
		local a1 = {}
		do
			local a2 = 0
			while a2 < Y do
				local v = _:random()
				if v then
					a1[#a1 + 1] = v
				end
				a2 = a2 + 1
			end
		end
		ForWithInterval(0.15, #a1, function(a3)
			if not IsInjurable(F, V) then
				return
			end
			local v = a1[a3 + 1]
			if v then
				TriggerSectAbilityByName(F, v)
			end
		end)
		CustomGameEventManager:Send_ServerToAllClients(
			"dice_trigger_ability",
			{ ent = E:entindex(), ability_list = json.encode(a1) }
		)
	end)
end
D = e(
	{
		t(
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
	D
)
l.modifier_greevil_1_battle_buff = D
return l