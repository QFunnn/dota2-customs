--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/rune/item_rune_substitute"
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
n.name = "item_rune_substitute"
d(n, l)
function n.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.chargeCount = 0
end
function n.prototype.OnCreated(self)
	self:RefreshConfigData()
end
function n.prototype.OnRefresh(self)
	self:RefreshConfigData()
end
function n.prototype.RefreshConfigData(self)
	self:RefreshBaseConfigData()
	self:RefreshUpgradeConfigData()
	self.config = e({}, self.baseConfig, self.upgrade1Config)
end
function n.prototype.RefreshBaseConfigData(self)
	self.baseConfig = {
		charge_count = self:GetSpecialValueFor("charge_count"),
		charge_count_max = self:GetSpecialValueFor("charge_count_max"),
		damage_boost = self:GetSpecialValueFor("damage_boost"),
	}
end
function n.prototype.RefreshUpgradeConfigData(self)
	local o = RuneBuild:GetSkillRuneEffectItem(self:GetCaster(), self.abilityTag, "item_rune_substitute_upgrade1")
	self.upgrade1Config = o and o.upgrade1Config or { double_charge_prop = 0 }
end
function n.prototype.EventListener(self)
	return {
		ability_cast_complete = function(p, q)
			if not self.config then
				return
			end
			local r = self:GetCaster()
			local s = q.ability
			if not IsValid(r) then
				return
			end
			if q.caster ~= r then
				return
			end
			if not IsValid(s) or s:GetAbilityTag() ~= self.abilityTag then
				return
			end
			self:GainCharge()
		end,
	}
end
function n.prototype.GainCharge(self)
	if not self.config then
		return
	end
	if self.config.charge_count <= 0 or self.config.charge_count_max <= 0 then
		return
	end
	if self.chargeCount >= self.config.charge_count_max and self:HasActiveBuff() then
		return
	end
	local t = RollPercentage(self.config.double_charge_prop) and 2 or 1
	self.chargeCount = math.min(self.chargeCount + self.config.charge_count * t, self.config.charge_count_max)
	if self.chargeCount >= self.config.charge_count_max then
		self:TryApplyDamageBuff()
	end
end
function n.prototype.TryApplyDamageBuff(self)
	if not self.config then
		return
	end
	if self:HasActiveBuff() then
		return
	end
	local r = self:GetCaster()
	if not IsValid(r) then
		return
	end
	local u = r:GetAbilityByTag(self.abilityTag)
	if not IsValid(u) then
		return
	end
	local v = r:AddNewModifier(
		r,
		self,
		"modifier_rune_substitute",
		{
			abilityTag = self.abilityTag,
			targetAbilityEntIndex = u:entindex(),
			sourceItemEntIndex = self:entindex(),
			damageBoost = self.config.damage_boost,
		}
	)
	if IsValid(v) then
		self.activeModifier = v
	end
end
function n.prototype.ConsumeDamageBuff(self, v)
	if IsValid(self.activeModifier) and self.activeModifier == v then
		self.activeModifier = nil
	end
	self.chargeCount = 0
end
function n.prototype.HasActiveBuff(self)
	return IsValid(self.activeModifier)
end
n = f({ m(nil) }, n)
local w = c()
w.name = "item_rune_substitute_upgrade1"
d(w, l)
function w.prototype.OnCreated(self)
	self:RefreshConfigData()
end
function w.prototype.OnRefresh(self)
	self:RefreshConfigData()
end
function w.prototype.RefreshConfigData(self)
	self.upgrade1Config = { double_charge_prop = self:GetSpecialValueFor("double_charge_prop") }
	local x = RuneBuild:GetSkillRuneEffectItem(self:GetCaster(), self.abilityTag, "item_rune_substitute")
	if x ~= nil then
		x:RefreshConfigData()
	end
end
w = f({ m(nil) }, w)
local y = c()
y.name = "modifier_rune_substitute"
d(y, j)
function y.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.damageBoost = 0
	self.createdGameTime = 0
end
function y.prototype.OnCreated(self, z)
	self.abilityTag = z.abilityTag or AbilityTag.None
	self.targetAbilityEntIndex = z.targetAbilityEntIndex
	self.sourceItemEntIndex = z.sourceItemEntIndex
	self.damageBoost = z.damageBoost or 0
	self.createdGameTime = GameRules:GetGameTime()
	local u = self:GetTargetAbility()
	if not IsValid(u) then
		self:Destroy()
		return
	end
	self.sourceId = (
		((("rune_substitute:" .. tostring(self.sourceItemEntIndex or 0)) .. ":") .. tostring(u:entindex())) .. ":"
	) .. tostring(self:GetSerialNumber())
	if self.damageBoost ~= 0 then
		PropertySystem:AddAbilityStaticProperty(
			u,
			"final_damage_103",
			self.sourceId,
			self.damageBoost,
			{ source = "rune_substitute" }
		)
	end
end
function y.prototype.OnDestroy(self)
	local u = self:GetTargetAbility()
	if IsValid(u) and self.sourceId ~= nil then
		PropertySystem:RemoveAbilityStaticProperty(u, self.sourceId, "final_damage_103")
	end
	local A = self:GetSourceItem()
	if IsValid(A) then
		A:ConsumeDamageBuff(self)
	end
end
function y.prototype.EventListener(self)
	return {
		ability_cast_complete = function(p, B)
			local r = self:GetCaster()
			if not IsValid(r) or B.caster ~= r then
				return
			end
			if not IsValid(B.ability) then
				return
			end
			if self.targetAbilityEntIndex == nil then
				return
			end
			if B.ability:entindex() ~= self.targetAbilityEntIndex then
				return
			end
			if GameRules:GetGameTime() <= self.createdGameTime then
				return
			end
			self:Destroy()
		end,
	}
end
function y.prototype.GetTargetAbility(self)
	if self.targetAbilityEntIndex == nil then
		return
	end
	local s = EntIndexToHScript(self.targetAbilityEntIndex)
	return IsValid(s) and s or nil
end
function y.prototype.GetSourceItem(self)
	if self.sourceItemEntIndex == nil then
		return
	end
	local C = EntIndexToHScript(self.sourceItemEntIndex)
	return IsValid(C) and C or nil
end
y = f(
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	y
)
return g