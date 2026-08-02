--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/rune/item_rune_vulnerable"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ObjectAssign
local f = b.__TS__Delete
local g = b.__TS__DecorateLegacy
local h = b.__TS__ObjectKeys
local i = b.__TS__ArraySplice
local j = {}
local k = require("modifiers.eom_modifier.eom_modifier")
local l = k.registerEOMModifier
local m = k.EOMModifier
local n = require("abilities.eom_ability")
local o = n.EOMItem
local p = n.registerEOMAbility
local q = { AbilityTag.Attack, AbilityTag.Skill, AbilityTag.Dodge, AbilityTag.Defense, AbilityTag.Ultimate }
local r = c()
r.name = "item_rune_vulnerable"
d(r, o)
function r.prototype.OnCreated(self)
	self:RefreshConfigData()
end
function r.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local s = self:GetCaster()
	local t = IsValid(s) and s:GetPlayerOwnerID() or nil
	if t == nil then
		return
	end
	Timer:GameTimer(FrameTime(), function()
		r:RefreshPlayerExtraMaxStackCountCacheByPlayer(t)
	end)
end
function r.prototype.OnRefresh(self)
	self:RefreshConfigData()
end
function r.prototype.RefreshConfigData(self)
	self:RefreshBaseConfigData()
	self:RefreshUpgradeConfigData()
	self.config = e(
		{},
		self.baseConfig,
		{
			extra_max_stack_count = self.upgrade1Config.extra_max_stack_count,
			ally_damage_boost = self.upgrade1Config.ally_damage_boost,
		}
	)
	r:RefreshPlayerExtraMaxStackCountCache(self:GetCaster())
end
function r.prototype.RefreshBaseConfigData(self)
	self.baseConfig = {
		apply_count = self:GetSpecialValueFor("apply_count"),
		buff_duration = self:GetSpecialValueFor("buff_duration"),
		effect_per_stack = self:GetSpecialValueFor("effect_per_stack"),
		max_stack_count = self:GetSpecialValueFor("max_stack_count"),
	}
end
function r.prototype.RefreshUpgradeConfigData(self)
	local u = RuneBuild:GetSkillRuneEffectItem(self:GetCaster(), self.abilityTag, "item_rune_vulnerable_upgrade1")
	self.upgrade1Config = u and u.upgrade1Config or { extra_max_stack_count = 0, ally_damage_boost = false }
end
function r.prototype.EventListener(self)
	return {
		damage_event = function(v, w)
			local s = self:GetCaster()
			local x = w.target
			local y = w.ability
			if not IsValid(s) or not IsValid(x) then
				return
			end
			if not IsValid(y) or y:GetAbilityTag() ~= self.abilityTag then
				return
			end
			if w.attacker ~= s or s:IsFriendly(x) or w.damage <= 0 then
				return
			end
			local z = x.__VulnerabilityModifier
			if not IsValid(z) then
				z = x:AddNewModifier(s, self, "modifier_rune_vulnerable", {})
			end
			local A = self.config
			local t = s:GetPlayerOwnerID()
			local B = A.max_stack_count + r:GetPlayerExtraMaxStackCount(t)
			if IsValid(z) then
				z:AddVulnerabilityStack(
					t,
					s:GetTeamNumber(),
					A.apply_count,
					A.buff_duration,
					A.effect_per_stack,
					B,
					A.ally_damage_boost
				)
			end
		end,
	}
end
function r.RefreshPlayerExtraMaxStackCountCache(self, s)
	if not IsServer() then
		return
	end
	if not IsValid(s) then
		return
	end
	self:RefreshPlayerExtraMaxStackCountCacheByPlayer(s:GetPlayerOwnerID())
end
function r.RefreshPlayerExtraMaxStackCountCacheByPlayer(self, t)
	local s = PlayerResource:GetSelectedHeroEntity(t)
	if not IsValid(s) then
		f(self.playerExtraMaxStackCountCache, t)
		return
	end
	local C = 0
	for v, D in ipairs(q) do
		local E = RuneBuild:GetSkillRuneEffectItem(s, D, "item_rune_vulnerable")
		if IsValid(E) then
			local F = E.config
			C = C + (F and F.extra_max_stack_count or 0)
		end
	end
	if C > 0 then
		self.playerExtraMaxStackCountCache[t] = C
	else
		f(self.playerExtraMaxStackCountCache, t)
	end
end
function r.GetPlayerExtraMaxStackCount(self, t)
	return self.playerExtraMaxStackCountCache[t] or 0
end
r.playerExtraMaxStackCountCache = {}
r = g({ p(nil) }, r)
local G = c()
G.name = "item_rune_vulnerable_upgrade1"
d(G, o)
function G.prototype.OnCreated(self)
	self:RefreshConfigData()
end
function G.prototype.OnRefresh(self)
	self:RefreshConfigData()
end
function G.prototype.RefreshConfigData(self)
	self.upgrade1Config =
		{ extra_max_stack_count = self:GetSpecialValueFor("max_stack_count"), ally_damage_boost = true }
	local H = RuneBuild:GetSkillRuneEffectItem(self:GetCaster(), self.abilityTag, "item_rune_vulnerable")
	if H ~= nil then
		H:RefreshConfigData()
	end
end
G = g({ p(nil) }, G)
local I = c()
I.name = "modifier_rune_vulnerable"
d(I, m)
function I.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.vulnerabilityData = {}
end
function I.prototype.OnCreated(self, J)
	if IsServer() then
		local K = self:GetParent()
		K.__VulnerabilityModifier = self
		self:StartIntervalThink(0.2)
	end
end
function I.prototype.AddVulnerabilityStack(self, t, L, M, N, O, B, P)
	if not IsServer() then
		return
	end
	local Q, R = self.vulnerabilityData, t
	if Q[R] == nil then
		Q[R] =
			{ segments = {}, teamNumber = L, effectPerStack = O, allyDamageBoost = P, playerValue = 0, globalValue = 0 }
	end
	local w = self.vulnerabilityData[t]
	w.teamNumber = L
	w.effectPerStack = O
	w.allyDamageBoost = P
	local S = w.segments
	S[#S + 1] = { stack = math.floor(M), expireTime = GameRules:GetGameTime() + N }
	self:TrimOverflowStacks(w, B)
	self:UpdateValue(t, w)
	self:UpdateStackCount()
end
function I.prototype.GetVulnerabilityValue(self, T)
	if not IsValid(T) then
		return 0
	end
	local U = 0
	local V = T:GetPlayerOwnerID()
	local W = T:GetTeamNumber()
	for X, w in pairs(self.vulnerabilityData) do
		if X == V then
			U = U + w.playerValue
		elseif w.teamNumber == W then
			U = U + w.globalValue
		end
	end
	return U
end
function I.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RemoveExpiredSegments(GameRules:GetGameTime())
	self:UpdateStackCount()
	if #h(self.vulnerabilityData) <= 0 then
		self:Destroy()
	end
end
function I.prototype.OnDestroy(self)
	if IsServer() then
		local K = self:GetParent()
		if IsValid(K) and K.__VulnerabilityModifier == self then
			K.__VulnerabilityModifier = nil
		end
	end
end
function I.prototype.RemoveExpiredSegments(self, Y)
	for t, w in pairs(self.vulnerabilityData) do
		do
			local Z = #w.segments - 1
			while Z >= 0 do
				if w.segments[Z + 1].expireTime <= Y or w.segments[Z + 1].stack <= 0 then
					i(w.segments, Z, 1)
				end
				Z = Z - 1
			end
		end
		if #w.segments <= 0 then
			f(self.vulnerabilityData, t)
		else
			self:UpdateValue(t, w)
		end
	end
end
function I.prototype.TrimOverflowStacks(self, w, B)
	local _ = self:GetTotalStack(w)
	local a0 = _ - B
	while a0 > 0 and #w.segments > 0 do
		local a1 = w.segments[1]
		local a2 = math.min(a1.stack, a0)
		a1.stack = a1.stack - a2
		a0 = a0 - a2
		_ = _ - a2
		if a1.stack <= 0 then
			i(w.segments, 0, 1)
		end
	end
end
function I.prototype.UpdateValue(self, t, w)
	local U = self:GetTotalStack(w) * w.effectPerStack
	w.playerValue = U
	w.globalValue = w.allyDamageBoost and U or 0
	if #w.segments <= 0 then
		f(self.vulnerabilityData, t)
	end
end
function I.prototype.UpdateStackCount(self)
	local _ = 0
	for a3, w in pairs(self.vulnerabilityData) do
		_ = _ + self:GetTotalStack(w)
	end
	self:SetStackCount(_)
end
function I.prototype.GetTotalStack(self, w)
	local _ = 0
	do
		local Z = 0
		while Z < #w.segments do
			_ = _ + w.segments[Z + 1].stack
			Z = Z + 1
		end
	end
	return _
end
I = g(
	{
		l(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	I
)
return j