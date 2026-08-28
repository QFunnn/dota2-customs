--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/rune/item_rune_circle"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ObjectAssign
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("modifiers.eom_modifier.eom_modifier")
local i = h.registerEOMModifier
local j = h.EOMModifier
local k = require("abilities.eom_ability")
local l = k.EOMItem
local m = k.registerEOMAbility
local n = c()
n.name = "item_rune_circle"
d(n, l)
function n.prototype.OnCreated(self)
	self:RefreshConfigData()
end
function n.prototype.OnRefresh(self)
	self:RefreshConfigData()
end
function n.prototype.RefreshConfigData(self)
	self:RefreshBaseConfigData()
	self:RefreshUpgradeConfigData()
	self.config = e({}, self.baseConfig, { upgrade = self.upgrade1Config })
end
function n.prototype.RefreshBaseConfigData(self)
	self.baseConfig = {
		charge_count = self:GetSpecialValueFor("charge_count"),
		trigger_charge = self:GetSpecialValueFor("trigger_charge"),
		duration = self:GetSpecialValueFor("duration"),
		range = self:GetSpecialValueFor("range"),
		damage_boost = self:GetSpecialValueFor("damage_boost"),
	}
end
function n.prototype.RefreshUpgradeConfigData(self)
	local o = RuneBuild:GetSkillRuneEffectItem(self:GetCaster(), self.abilityTag, "item_rune_circle_upgrade1")
	self.upgrade1Config = o and o.upgrade1Config
		or { charge_count = 0, plus_duration = 0, damage_boost = 0, range = 0, plus_stack_max = 0, has_upgrade1 = false }
end
function n.prototype.EventListener(self)
	return {
		ability_cast_complete = function(p, q)
			if not self.config then
				return
			end
			local r = self:GetCaster()
			local s = q.ability
			if not IsValid(r) or q.caster ~= r then
				return
			end
			if not IsValid(s) or s:GetAbilityTag() ~= self.abilityTag then
				return
			end
			local t = r:AddNewModifier(
				r,
				self,
				"modifier_rune_circle_charge",
				{ stack = self.config.charge_count, trigger_charge = self.config.trigger_charge }
			)
			if not IsValid(t) or not t:TryConsumeTriggerCharge() then
				return
			end
			self:ApplyAura(self.config.upgrade.has_upgrade1)
		end,
	}
end
function n.prototype.ApplyAura(self, u)
	if u == nil then
		u = false
	end
	local r = self:GetCaster()
	if not IsValid(r) or not self.config then
		return
	end
	local v = self.config.upgrade
	if u and v.charge_count > 0 and v.plus_duration > 0 and v.plus_stack_max > 0 then
		r:AddNewModifier(
			r,
			self,
			"modifier_rune_circle_mastery",
			{
				stack = v.charge_count,
				duration = v.plus_duration,
				max_stack = v.plus_stack_max,
				damage_boost = v.damage_boost,
				range = v.range,
			}
		)
	end
	local w = r:FindModifierByName("modifier_rune_circle_mastery")
	local x = IsValid(w) and w:GetStackCount() or 0
	local y = IsValid(w) and (w.damageBoostPerStack or 0) or 0
	local z = IsValid(w) and (w.rangeBoostPerStack or 0) or 0
	local A = self.config.damage_boost * (1 + x * y * 0.01)
	local B = self.config.range * (1 + x * z * 0.01)
	r:AddNewModifier(
		r,
		self,
		"modifier_rune_circle_aura",
		{ duration = self.config.duration, radius = B, damage_boost = A }
	)
end
n = f({ m(nil) }, n)
local C = c()
C.name = "item_rune_circle_upgrade1"
d(C, l)
function C.prototype.OnCreated(self)
	self:RefreshConfigData()
end
function C.prototype.OnRefresh(self)
	self:RefreshConfigData()
end
function C.prototype.RefreshConfigData(self)
	self.upgrade1Config = {
		charge_count = self:GetSpecialValueFor("charge_count"),
		plus_duration = self:GetSpecialValueFor("plus_duration"),
		damage_boost = self:GetSpecialValueFor("damage_boost"),
		range = self:GetSpecialValueFor("range"),
		plus_stack_max = self:GetSpecialValueFor("plus_stack_max"),
		has_upgrade1 = true,
	}
	local D = RuneBuild:GetSkillRuneEffectItem(self:GetCaster(), self.abilityTag, "item_rune_circle")
	if D ~= nil then
		D:RefreshConfigData()
	end
end
C = f({ m(nil) }, C)
local E = c()
E.name = "modifier_rune_circle_charge"
d(E, j)
function E.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.triggerCharge = 0
end
function E.prototype.OnCreated(self, F)
	self.triggerCharge = F.trigger_charge or 0
	if IsServer() then
		self:IncrementStackCount(F.stack or 0)
	end
end
function E.prototype.OnRefresh(self, F)
	self.triggerCharge = F.trigger_charge or self.triggerCharge
	if IsServer() then
		self:IncrementStackCount(F.stack or 0)
	end
end
function E.prototype.TryConsumeTriggerCharge(self)
	if self.triggerCharge <= 0 or self:GetStackCount() < self.triggerCharge then
		return false
	end
	self:SetStackCount(0)
	return true
end
E = f(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	E
)
local G = c()
G.name = "modifier_rune_circle_mastery"
d(G, j)
function G.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.damageBoostPerStack = 0
	self.rangeBoostPerStack = 0
	self.maxStack = 0
end
function G.prototype.OnCreated(self, F)
	self:RefreshParams(F)
	if IsServer() then
		self:AddStackCountDuration(F.stack, F.duration, self.maxStack)
		self:StartIntervalThink(0.2)
	end
end
function G.prototype.OnRefresh(self, F)
	self:RefreshParams(F)
	if IsServer() then
		self:AddStackCountDuration(F.stack, F.duration, self.maxStack)
	end
end
function G.prototype.RefreshParams(self, F)
	self.damageBoostPerStack = math.max(self.damageBoostPerStack or 0, F.damage_boost or 0)
	self.rangeBoostPerStack = math.max(self.rangeBoostPerStack or 0, F.range or 0)
	self.maxStack = math.max(self.maxStack or 0, F.max_stack or 0)
end
function G.prototype.OnIntervalThink(self)
	if IsServer() and self:GetStackCount() <= 0 then
		self:Destroy()
	end
end
G = f(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	G
)
local H = c()
H.name = "modifier_rune_circle_aura"
d(H, j)
function H.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.radius = 0
	self.damageBoost = 0
	self.particleID = nil
end
function H.prototype.GetAuraRadius(self)
	return self.radius
end
function H.prototype.GetModifierAura(self)
	return "modifier_rune_circle_aura_buff"
end
function H.prototype.OnCreated(self, F)
	self:RefreshParams(F)
end
function H.prototype.OnDestroy(self)
	if IsServer() then
		self:DestroyParticle()
	end
end
function H.prototype.OnRefresh(self, F)
	self:RefreshParams(F)
	if IsServer() then
		self:RefreshAuraBuffProperties()
	end
end
function H.prototype.RefreshParams(self, F)
	local B = F.radius or self.radius
	local I = B ~= self.radius
	self.radius = B
	self.damageBoost = F.damage_boost or self.damageBoost
	if IsServer() and (self.particleID == nil or I) then
		self:UpdateAuraParticle()
	end
end
function H.prototype.DestroyParticle(self)
	if self.particleID ~= nil then
		ParticleManager:DestroyParticle(self.particleID, false)
		ParticleManager:ReleaseParticleIndex(self.particleID)
		self.particleID = nil
	end
end
function H.prototype.UpdateAuraParticle(self)
	local J = self:GetParent()
	if not IsValid(J) then
		return
	end
	self:DestroyParticle()
	if self.particleID == nil then
		self.particleID = ParticleManager:CreateParticle(
			"particles/units/benediction/formation_buff_fx.vpcf",
			PATTACH_CUSTOMORIGIN,
			J
		)
		ParticleManager:SetParticleControlEnt(
			self.particleID,
			0,
			J,
			PATTACH_ABSORIGIN_FOLLOW,
			nil,
			J:GetAbsOrigin(),
			true
		)
	end
	local K = self.particleID
	if K ~= nil then
		ParticleManager:SetParticleControl(K, 1, Vector(self.radius, 0, 0))
	end
end
function H.prototype.RefreshAuraBuffProperties(self)
	local J = self:GetParent()
	if not IsValid(J) then
		return
	end
	local L = FindUnitsInRadius(
		J:GetTeamNumber(),
		J:GetAbsOrigin(),
		nil,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for p, M in ipairs(L) do
		local N = M:FindModifierByName("modifier_rune_circle_aura_buff")
		if IsValid(N) then
			N:RefreshAuraProperty()
		end
	end
end
H = f(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
				IsAura = true,
				GetAuraSearchFlags = DOTA_UNIT_TARGET_FLAG_NONE,
				GetAuraSearchTeam = DOTA_UNIT_TARGET_TEAM_FRIENDLY,
				GetAuraSearchType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			}
		),
	},
	H
)
local O = c()
O.name = "modifier_rune_circle_aura_buff"
d(O, j)
function O.prototype.StaticProperty(self)
	return { [PropertyFunction.FINAL_DAMAGE_101] = self:GetAuraDamageBoost() }
end
function O.prototype.RefreshAuraProperty(self)
	self:RegisterStaticProperties()
end
function O.prototype.GetAuraDamageBoost(self)
	if not IsServer() then
		return 0
	end
	local P = self:GetAuraOwner()
	if not IsValid(P) then
		return 0
	end
	local Q = P and P:FindModifierByName("modifier_rune_circle_aura")
	if not IsValid(Q) then
		return 0
	end
	return Q.damageBoost
end
O = f(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	O
)
return g