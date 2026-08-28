--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/rune/item_rune_celerity"
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
n.name = "item_rune_celerity"
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
		apply_count = self:GetSpecialValueFor("apply_count"),
		buff_duration = self:GetSpecialValueFor("buff_duration"),
		effect_per_stack = self:GetSpecialValueFor("effect_per_stack"),
		max_stack_count = self:GetSpecialValueFor("max_stack_count"),
	}
end
function n.prototype.RefreshUpgradeConfigData(self)
	local o = RuneBuild:GetSkillRuneEffectItem(self:GetCaster(), self.abilityTag, "item_rune_celerity_upgrade1")
	self.upgrade1Config = o and o.upgrade1Config or { cd_reduce = 0, plus_duration = 0, plus_effect = 0 }
end
function n.prototype.EventListener(self)
	return {
		ability_cast_complete = function(p, q)
			if not self.config then
				return
			end
			if q.caster ~= self:GetCaster() then
				return
			end
			if q.abilityTag ~= self.abilityTag then
				return
			end
			local r = q.caster:AddNewModifier(
				q.caster,
				self,
				"modifier_rune_celerity",
				{
					stack = self.config.apply_count,
					duration = self.config.buff_duration,
					effect_per_stack = self.config.effect_per_stack,
					max_stack_count = self.config.max_stack_count,
					cd_reduce = self.config.cd_reduce,
					plus_duration = self.config.plus_duration,
					plus_effect = self.config.plus_effect,
				}
			)
			if IsValid(r) then
				r:TryTriggerUpgrade(q.ability)
			end
		end,
	}
end
n = f({ m(nil) }, n)
local s = c()
s.name = "item_rune_celerity_upgrade1"
d(s, l)
function s.prototype.OnCreated(self)
	self:RefreshConfigData()
end
function s.prototype.OnRefresh(self)
	self:RefreshConfigData()
end
function s.prototype.RefreshConfigData(self)
	self.upgrade1Config = {
		cd_reduce = self:GetSpecialValueFor("cd_reduce"),
		plus_duration = self:GetSpecialValueFor("plus_duration"),
		plus_effect = self:GetSpecialValueFor("plus_effect"),
	}
	local t = RuneBuild:GetSkillRuneEffectItem(self:GetCaster(), self.abilityTag, "item_rune_celerity")
	if t ~= nil then
		t:RefreshConfigData()
	end
end
s = f({ m(nil) }, s)
local u = c()
u.name = "modifier_rune_celerity"
d(u, j)
function u.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.effectPerStack = 0
	self.maxStackCount = 0
	self.cdReduce = 0
	self.plusDuration = 0
	self.plusEffect = 0
end
function u.prototype.OnCreated(self, v)
	self:RefreshParams(v)
	if IsServer() then
		self:AddStackCountDuration(v.stack, v.duration, v.max_stack_count)
	end
end
function u.prototype.OnRefresh(self, v)
	self:RefreshParams(v)
	if IsServer() then
		self:AddStackCountDuration(v.stack, v.duration, v.max_stack_count)
	end
end
function u.prototype.StaticProperty(self)
	local w = self:GetStackCount() * self.effectPerStack
	return { [PropertyFunction.ATTACKSPEED] = w, [PropertyFunction.MOVESPEED_AMPLIFY] = w }
end
function u.prototype.OnStackCountChanged(self, x)
	if IsServer() and self:GetStackCount() <= 0 then
		self:Destroy()
	end
end
function u.prototype.RefreshParams(self, v)
	self.effectPerStack = v.effect_per_stack or self.effectPerStack
	self.maxStackCount = v.max_stack_count or self.maxStackCount
	self.cdReduce = v.cd_reduce or self.cdReduce
	self.plusDuration = v.plus_duration or self.plusDuration
	self.plusEffect = v.plus_effect or self.plusEffect
end
function u.prototype.HasUpgrade(self)
	return self.cdReduce > 0 and self.plusDuration > 0 and self.plusEffect > 0
end
function u.prototype.TryTriggerUpgrade(self, y)
	if not IsServer() then
		return
	end
	if not self:HasUpgrade() then
		return
	end
	if self.maxStackCount <= 0 or self:GetStackCount() < self.maxStackCount then
		return
	end
	local z = self:GetParent()
	if not IsValid(z) then
		return
	end
	if not IsValid(y) then
		return
	end
	local A = y:GetCooldownTimeRemaining()
	if A <= 0 then
		return
	end
	y:ReduceCooldown(A * self.cdReduce * 0.01)
	z:AddNewModifier(
		z,
		self:GetAbility(),
		"modifier_rune_celerity_plus",
		{ duration = self.plusDuration, plus_effect = self.plusEffect }
	)
	self:SetStackCount(0)
	self:Destroy()
end
u = f(
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
	u
)
local B = c()
B.name = "modifier_rune_celerity_plus"
d(B, j)
function B.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.plusEffect = 0
end
function B.prototype.OnCreated(self, v)
	self.plusEffect = v.plus_effect or 0
end
function B.prototype.OnRefresh(self, v)
	self.plusEffect = v.plus_effect or self.plusEffect
end
function B.prototype.StaticProperty(self)
	return { [PropertyFunction.ATTACKSPEED] = self.plusEffect, [PropertyFunction.MOVESPEED_AMPLIFY] = self.plusEffect }
end
B = f(
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
	B
)
return g