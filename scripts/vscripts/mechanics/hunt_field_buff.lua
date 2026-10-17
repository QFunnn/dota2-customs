--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "mechanics/hunt_field_buff"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ArrayMap
local e = b.__TS__ArraySlice
local f = b.__TS__New
local g = b.__TS__ArraySetLength
local h = b.__TS__ArraySort
local i = b.__TS__ArrayIncludes
local j = b.__TS__ArrayFilter
local k = b.__TS__ObjectValues
local l = {}
local m = require("class.weight_pool")
local n = m.CWeightPool
local o = require("modifiers.hunt_boss.modifier_hunt_potion")
local p = o.GetHuntPotionController
local q = require("mechanics.hunt_field_effects")
local r = q.CHuntFieldEffects
local s = require("mechanics.hunt_field_config")
local t = s.HUNT_FIXED_MODIFIERS
local u = s.GetHuntFieldBuffConfig
local v = s.GetHuntFieldEffectError
local w = s.ParseHuntFixedAffixes
local x = require("class.dungeon_helper")
local y = x.AnalyzeCenterPositions
l.CHuntBossFieldBuffManager = c()
local z = l.CHuntBossFieldBuffManager
z.name = "CHuntBossFieldBuffManager"
function z.prototype.____constructor(self)
	self.logPrefix = "[HuntBossFieldBuff]"
	self.buffConfigById = {}
	self.previousRandomAffixIds = {}
	self.currentFixedAffixIds = {}
	self.currentRandomAffixIds = {}
	self.isBattleActive = false
	self.fixedAffixHeroes = {}
	self.validGridPositions = {}
	self.getBattleEnemies = function()
		return {}
	end
end
function z.prototype.LoadConfigs(self, A)
	self:Reset()
	self.buffConfigById = self:ParseFieldBuffConfigs()
	local B = KeyValues.hunt_difficulty_affix
	if B ~= nil then
		B = B[tostring(A)]
	end
	local C = B
	if C == nil then
		self:Error("missing difficulty affix config difficulty=" .. tostring(A))
		return false
	end
	local D = w
	local E = tostring
	local F = C.FixedAffixes
	if F == nil then
		F = ""
	end
	local G = D(nil, E(F))
	if G == nil then
		self:Error("invalid or duplicate fixed affix levels difficulty=" .. tostring(A))
		return false
	end
	local H = d(G, function(I, J)
		return J.id
	end)
	for I, K in ipairs(G) do
		local L = K.id
		local M = K.level
		local N = u(nil, L, M)
		local O = self.buffConfigById[L]
		if (O and O.type) ~= 1 or N == nil or L ~= "potion" and t[L] == nil then
			self:Error(
				(((("invalid fixed affix difficulty=" .. tostring(A)) .. " id=") .. L) .. " level=") .. tostring(M)
			)
			return false
		end
		self.buffConfigById[L] = N
	end
	local P = math.floor(toFiniteNumber(C.FieldBuffCount, -1))
	local Q = self:GetRandomPool().ValidCount
	if P < 0 or P > Q then
		self:Error(
			(
				((("invalid random affix count difficulty=" .. tostring(A)) .. " count=") .. tostring(P))
				.. " candidates="
			) .. tostring(Q)
		)
		return false
	end
	if P > 0 and P == Q then
		self:Error(
			(("random affix candidates permit only one combination difficulty=" .. tostring(A)) .. " count=")
				.. tostring(P)
		)
		return false
	end
	self.difficultyAffix = { fixedAffixIds = H, fieldBuffCount = P }
	return true
end
function z.prototype.PrepareNextLevel(self, M)
	local R = self.nextLevelSelection
	if (R and R.level) == M then
		return true
	end
	if self.difficultyAffix == nil then
		self:Error("PrepareNextLevel called before LoadConfigs")
		return false
	end
	local S = self:DrawRandomAffixes(self.difficultyAffix.fieldBuffCount)
	if S == nil then
		return false
	end
	self.nextLevelSelection = { level = M, ids = S }
	return true
end
function z.prototype.GetNextLevelBuffs(self)
	local T = self.GetBuffPreviews
	local U = self.nextLevelSelection
	return T(self, U and U.ids or {})
end
function z.prototype.GetFixedBuffs(self)
	local V = self.GetBuffPreviews
	local W = self.difficultyAffix
	return V(self, W and W.fixedAffixIds or {})
end
function z.prototype.GetCurrentLevelBuffs(self)
	return self:GetBuffPreviews(self.currentRandomAffixIds)
end
function z.prototype.GetBuffPreviews(self, S)
	return d(S, function(I, L)
		local N = self.buffConfigById[L]
		return { id = L, level = N.level }
	end)
end
function z.prototype.PrepareLevel(self, M)
	if self.difficultyAffix == nil then
		self:Error("PrepareLevel called before LoadConfigs")
		return false
	end
	self:EndLevel()
	if not self:PrepareNextLevel(M) then
		return false
	end
	local X = self.nextLevelSelection.ids
	self.nextLevelSelection = nil
	self.currentLevel = M
	self.currentFixedAffixIds = e(self.difficultyAffix.fixedAffixIds)
	self.currentRandomAffixIds = X
	self.previousRandomAffixIds = e(X)
	if self.battleCenter == nil then
		self:EndLevel()
		return false
	end
	self.fieldEffects = f(
		r,
		d(X, function(I, L)
			return self.buffConfigById[L]
		end),
		{
			center = self.battleCenter,
			validGridPositions = self.validGridPositions,
			heroes = function()
				return self.fixedAffixHeroes
			end,
			enemies = self.getBattleEnemies,
		}
	)
	if not self:CreatePotionEffect() then
		self:EndLevel()
		return false
	end
	self:Print(
		(
			(
				((("prepared level=" .. tostring(M)) .. " fixed=[") .. table.concat(self.currentFixedAffixIds, ","))
				.. "] random=["
			) .. table.concat(self.currentRandomAffixIds, ",")
		) .. "]"
	)
	return true
end
function z.prototype.StartRun(self, Y, Z, _)
	self:RemoveFixedAffixModifiers()
	self.fixedAffixHeroes = e(Y)
	self.battleCenter = Z
	self.validGridPositions = y(nil, { center = Z, rings = 3, gridSize = GRID_SIZE })
	self:Print("grid analyzed count=" .. tostring(#self.validGridPositions))
	self.getBattleEnemies = _
	local a0 = self.difficultyAffix
	for I, a1 in ipairs(a0 and a0.fixedAffixIds or {}) do
		do
			local N = self.buffConfigById[a1]
			if N == nil or N.time > 0 then
				goto a2
			end
			for I, a3 in ipairs(self.fixedAffixHeroes) do
				do
					if not IsValid(a3) then
						goto a4
					end
					local a5 = t[a1]
					if a5 ~= nil then
						a3:AddNewModifier(
							a3,
							nil,
							a5,
							{ reducePct = N.params.ReducePct or 0, freezePct = N.params.FreezePct or 400 }
						)
					end
				end
				::a4::
			end
		end
		::a2::
	end
end
function z.prototype.StartOrResumeBattle(self)
	if self.currentLevel == nil or self.isBattleActive then
		return
	end
	self.isBattleActive = true
	self:SetPotionPaused(false)
	local a6 = self.fieldEffects
	if a6 ~= nil then
		a6:SetPaused(false)
	end
	self:Print("resumed level=" .. tostring(self.currentLevel))
end
function z.prototype.PauseBattle(self)
	if not self.isBattleActive then
		return
	end
	self.isBattleActive = false
	self:SetPotionPaused(true)
	local a7 = self.fieldEffects
	if a7 ~= nil then
		a7:SetPaused(true)
	end
	self:Print("paused level=" .. tostring(self.currentLevel))
end
function z.prototype.EndLevel(self)
	if self.currentLevel ~= nil then
		self:Print("cleared level=" .. tostring(self.currentLevel))
	end
	self.isBattleActive = false
	local a8 = self.fieldEffects
	self.fieldEffects = nil
	if a8 ~= nil then
		a8:Dispose()
	end
	self:DestroyPotionEffect()
	self.currentLevel = nil
	self.currentFixedAffixIds = {}
	self.currentRandomAffixIds = {}
end
function z.prototype.Reset(self)
	self:RemoveFixedAffixModifiers()
	self.difficultyAffix = nil
	self.buffConfigById = {}
	self.previousRandomAffixIds = {}
	self.nextLevelSelection = nil
	self.battleCenter = nil
	self.getBattleEnemies = function()
		return {}
	end
	self:EndLevel()
	g(self.validGridPositions, 0)
end
function z.prototype.GetCurrentFixedAffixIds(self)
	return self.currentFixedAffixIds
end
function z.prototype.GetCurrentRandomAffixIds(self)
	return self.currentRandomAffixIds
end
function z.prototype.ParseFieldBuffConfigs(self)
	local a9 = {}
	local aa = KeyValues.hunt_field_buff
	local ab = pairs
	local ac = aa
	if ac == nil then
		ac = {}
	end
	for ad in ab(ac) do
		do
			local L = tostring(ad)
			local N = u(nil, L)
			if N == nil then
				self:Error("invalid buff configuration id=" .. L)
				goto ae
			end
			if N.weight < 0 or N.type == 1 and N.weight ~= 0 then
				self:Error(
					(((("invalid buff weight id=" .. L) .. " type=") .. tostring(N.type)) .. " weight=")
						.. tostring(N.weight)
				)
				goto ae
			end
			if N.type == 2 and not self:ValidateRandomEffect(L, N.params) then
				goto ae
			end
			a9[L] = N
		end
		::ae::
	end
	return a9
end
function z.prototype.ValidateRandomEffect(self, L, af)
	local ag = v(nil, L, af)
	if not r:Supports(L) or ag ~= nil then
		self:Error((("invalid random effect parameters id=" .. L) .. ": ") .. (ag or "unsupported effect"))
		return false
	end
	return true
end
function z.prototype.GetRandomPool(self)
	local ah = f(n)
	for L, N in pairs(self.buffConfigById) do
		if N.type == 2 and N.weight > 0 then
			ah:Set(L, N.weight)
		end
	end
	return ah
end
function z.prototype.DrawRandomAffixes(self, ai)
	if ai == 0 then
		return {}
	end
	local ah = self:GetRandomPool()
	if ah.ValidCount < ai then
		self:Error(
			(("insufficient random candidates count=" .. tostring(ai)) .. " candidates=") .. tostring(ah.ValidCount)
		)
		return nil
	end
	local aj = #self.previousRandomAffixIds == ai
	do
		local ak = 1
		while ak <= 16 do
			local al = h(ah:MultipleRandomWithoutReplacement(ai))
			if not aj or not self:IsSameCombination(al, self.previousRandomAffixIds) then
				return al
			end
			ak = ak + 1
		end
	end
	self:Error("unable to draw a combination distinct from previous level")
	return nil
end
function z.prototype.IsSameCombination(self, am, an)
	if #am ~= #an then
		return false
	end
	do
		local ao = 0
		while ao < #am do
			if am[ao + 1] ~= an[ao + 1] then
				return false
			end
			ao = ao + 1
		end
	end
	return true
end
function z.prototype.CreatePotionEffect(self)
	if not i(self.currentFixedAffixIds, "potion") then
		return true
	end
	local N = self.buffConfigById.potion
	if N == nil or self.battleCenter == nil then
		self:Error("missing potion configuration")
		return false
	end
	local ap = N.params.Interval or 0
	local ai = math.floor(N.params.Count or 0)
	local aq = N.params.Lifetime or 0
	local ar = #j({ "item_health_potion_1", "item_health_potion_2", "item_health_potion_3" }, function(I, as)
		return (N.params[as] or 0) > 0 and KeyValues.items[as] ~= nil
	end)
	if ap <= 0 or ai <= 0 or aq <= 0 or ar <= 0 then
		self:Error(
			(
				(
					(
						((("invalid potion parameters interval=" .. tostring(ap)) .. " count=") .. tostring(ai))
						.. " lifetime="
					) .. tostring(aq)
				) .. " items="
			) .. tostring(ar)
		)
		return false
	end
	local at = CreateModifierThinker(
		nil,
		nil,
		"modifier_hunt_potion",
		{
			firstDelay = N.time,
			interval = ap,
			count = ai,
			lifetime = aq,
			item_health_potion_1 = N.params.item_health_potion_1 or 0,
			item_health_potion_2 = N.params.item_health_potion_2 or 0,
			item_health_potion_3 = N.params.item_health_potion_3 or 0,
		},
		self.battleCenter,
		DOTA_TEAM_NEUTRALS,
		false
	)
	if not IsValid(at) then
		self:Error("potion thinker creation failed")
		return false
	end
	local au = p(nil, at)
	if au == nil then
		UTIL_Remove(at)
		return false
	end
	au:SetSpawnContext(self.validGridPositions, function()
		return self.fixedAffixHeroes
	end)
	self.potionThinker = at
	return true
end
function z.prototype.SetPotionPaused(self, av)
	if not IsValid(self.potionThinker) then
		return
	end
	local aw = p(nil, self.potionThinker)
	if aw ~= nil then
		aw:SetStackCount(av and 0 or 1)
	end
end
function z.prototype.DestroyPotionEffect(self)
	local at = self.potionThinker
	self.potionThinker = nil
	if not IsValid(at) then
		return
	end
	at:RemoveModifierByName("modifier_hunt_potion")
end
function z.prototype.RemoveHero(self, a3)
	self.fixedAffixHeroes = j(self.fixedAffixHeroes, function(I, ax)
		return ax ~= a3
	end)
	if not IsValid(a3) then
		return
	end
	for I, a5 in ipairs(k(t)) do
		a3:RemoveModifierByName(a5)
	end
end
function z.prototype.RemoveFixedAffixModifiers(self)
	for I, a3 in ipairs(self.fixedAffixHeroes) do
		do
			if not IsValid(a3) then
				goto ay
			end
			for I, a5 in ipairs(k(t)) do
				a3:RemoveModifierByName(a5)
			end
		end
		::ay::
	end
	self.fixedAffixHeroes = {}
end
function z.prototype.Print(self, az)
	print((self.logPrefix .. " ") .. az)
end
function z.prototype.Error(self, az)
	print((self.logPrefix .. " ERROR ") .. az)
end
return l