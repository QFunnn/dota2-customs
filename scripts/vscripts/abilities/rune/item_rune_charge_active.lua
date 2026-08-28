--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/rune/item_rune_charge_active"
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
n.name = "item_rune_charge_active"
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
	self.config = e({}, self.baseConfig, self.upgrade1Config)
end
function n.prototype.RefreshBaseConfigData(self)
	self.baseConfig = {
		charge_consume = self:GetSpecialValueFor("charge_consume"),
		damage_boost = self:GetSpecialValueFor("damage_boost"),
	}
end
function n.prototype.RefreshUpgradeConfigData(self)
	local o = RuneBuild:GetSkillRuneEffectItem(self:GetCaster(), self.abilityTag, "item_rune_charge_active_upgrade1")
	self.upgrade1Config = o and o.upgrade1Config or { reset_cd_prop = 0 }
end
function n.prototype.EventListener(self)
	return {
		ability_cast_start = function(p, q)
			if not self.config then
				return
			end
			if self.abilityTag == nil then
				return
			end
			if self:HasActiveBuff() then
				return
			end
			local r = self:GetCaster()
			if not IsValid(r) then
				return
			end
			if q.caster ~= r then
				return
			end
			if not IsValid(q.ability) then
				return
			end
			if q.abilityTag ~= self.abilityTag then
				return
			end
			self:TryApplyNextCastBuff(r, q.ability)
		end,
	}
end
function n.prototype.TryApplyNextCastBuff(self, r, s)
	if not IsValid(s) then
		return
	end
	local t = r:FindModifierByName("modifier_rune_charge")
	if not IsValid(t) then
		return
	end
	local u = self.config.charge_consume
	if u <= 0 then
		return
	end
	if t:GetStackCount() < u then
		return
	end
	local v = not RollPercentage(self.config.reset_cd_prop)
	local w = r:AddNewModifier(
		r,
		self,
		"modifier_rune_charge_active",
		{
			abilityTag = self.abilityTag,
			targetAbilityEntIndex = s:entindex(),
			sourceItemEntIndex = self:entindex(),
			damageBoost = self.config.damage_boost,
		}
	)
	if IsValid(w) then
		self.activeModifier = w
		if v then
			t:SetStackCount(t:GetStackCount() - u)
		end
	end
end
function n.prototype.HasActiveBuff(self)
	local x = self.activeModifier
	return IsValid(x)
end
n = f({ m(nil) }, n)
local y = c()
y.name = "item_rune_charge_active_upgrade1"
d(y, l)
function y.prototype.OnCreated(self)
	self:RefreshConfigData()
end
function y.prototype.OnRefresh(self)
	self:RefreshConfigData()
end
function y.prototype.RefreshConfigData(self)
	self.upgrade1Config = { reset_cd_prop = self:GetSpecialValueFor("reset_cd_prop") }
	local z = RuneBuild:GetSkillRuneEffectItem(self:GetCaster(), self.abilityTag, "item_rune_charge_active")
	if z ~= nil then
		z:RefreshConfigData()
	end
end
y = f({ m(nil) }, y)
local A = c()
A.name = "modifier_rune_charge_active"
d(A, j)
function A.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.damageBoost = 0
end
function A.prototype.OnCreated(self, B)
	self.abilityTag = B.abilityTag or AbilityTag.None
	self.targetAbilityEntIndex = B.targetAbilityEntIndex
	self.sourceItemEntIndex = B.sourceItemEntIndex
	self.damageBoost = B.damageBoost or 0
	local s = self:GetTargetAbility()
	if not IsValid(s) then
		self:Destroy()
		return
	end
	self.sourceId = (
		((("rune_charge_active:" .. tostring(self.sourceItemEntIndex or 0)) .. ":") .. tostring(s:entindex())) .. ":"
	) .. tostring(self:GetSerialNumber())
	if self.damageBoost ~= 0 then
		PropertySystem:AddAbilityStaticProperty(
			s,
			"final_damage_102",
			self.sourceId,
			self.damageBoost,
			{ source = "rune_charge_active" }
		)
	end
end
function A.prototype.OnDestroy(self)
	local s = self:GetTargetAbility()
	if IsValid(s) and self.sourceId ~= nil then
		PropertySystem:RemoveAbilityStaticProperty(s, self.sourceId, "final_damage_102")
	end
	local C = self:GetSourceItem()
	if IsValid(C) and IsValid(C.activeModifier) and C.activeModifier == self then
		C.activeModifier = nil
	end
end
function A.prototype.EventListener(self)
	return {
		ability_cast_start = function(p, q)
			local r = self:GetCaster()
			if not IsValid(r) or q.caster ~= r then
				return
			end
			if not IsValid(q.ability) then
				return
			end
			if self.targetAbilityEntIndex == nil then
				return
			end
			if q.ability:entindex() ~= self.targetAbilityEntIndex then
				return
			end
			self:Destroy()
		end,
	}
end
function A.prototype.GetTargetAbility(self)
	if self.targetAbilityEntIndex == nil then
		return
	end
	local D = EntIndexToHScript(self.targetAbilityEntIndex)
	return IsValid(D) and D or nil
end
function A.prototype.GetSourceItem(self)
	if self.sourceItemEntIndex == nil then
		return
	end
	local E = EntIndexToHScript(self.sourceItemEntIndex)
	return IsValid(E) and E or nil
end
A = f(
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
	A
)
return g