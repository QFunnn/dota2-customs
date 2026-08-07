--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/rune/item_rune_weaken"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.registerEOMModifier
local i = g.EOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMItem
local l = j.registerEOMAbility
local m = c()
m.name = "item_rune_weaken"
d(m, k)
function m.prototype.OnCreated(self)
	self:RefreshConfigData()
end
function m.prototype.OnRefresh(self)
	self:RefreshConfigData()
end
function m.prototype.RefreshConfigData(self)
	self.config = {
		apply_count = self:GetSpecialValueFor("apply_count"),
		buff_duration = self:GetSpecialValueFor("buff_duration"),
		effect_per_stack = self:GetSpecialValueFor("effect_per_stack"),
		stack_max = self:GetSpecialValueFor("stack_max"),
	}
end
function m.prototype.EventListener(self)
	return {
		damage_event = function(n, o)
			local p = self:GetCaster()
			local q = o.target
			local r = o.ability
			if not IsValid(p) or not IsValid(q) then
				return
			end
			if not IsValid(r) or r:GetAbilityTag() ~= self.abilityTag then
				return
			end
			if o.attacker ~= p or p:IsFriendly(q) or o.damage <= 0 then
				return
			end
			q:AddNewModifier(
				p,
				self,
				"modifier_rune_weaken_slow",
				{
					stack = self.config.apply_count,
					duration = self.config.buff_duration,
					effect_per_stack = self.config.effect_per_stack,
					max_stack = self.config.stack_max,
				}
			)
		end,
	}
end
m = e({ l(nil) }, m)
local s = c()
s.name = "item_rune_weaken_upgrade1"
d(s, k)
function s.prototype.OnCreated(self)
	self:RefreshConfigData()
end
function s.prototype.OnRefresh(self)
	self:RefreshConfigData()
end
function s.prototype.RefreshConfigData(self)
	self.config = {
		weaken_apply_count = self:GetSpecialValueFor("weaken_apply_count"),
		weaken_buff_duration = self:GetSpecialValueFor("weaken_buff_duration"),
		weaken_per_stack = self:GetSpecialValueFor("weaken_per_stack"),
		weaken_stack_max = self:GetSpecialValueFor("weaken_stack_max"),
	}
end
function s.prototype.EventListener(self)
	return {
		damage_event = function(n, o)
			local p = self:GetCaster()
			local q = o.target
			local r = o.ability
			if not IsValid(p) or not IsValid(q) then
				return
			end
			if not IsValid(r) or r:GetAbilityTag() ~= self.abilityTag then
				return
			end
			if o.attacker ~= p or p:IsFriendly(q) or o.damage <= 0 then
				return
			end
			q:AddNewModifier(
				p,
				self,
				"modifier_rune_weaken_damage_reduce",
				{
					stack = self.config.weaken_apply_count,
					duration = self.config.weaken_buff_duration,
					effect_per_stack = self.config.weaken_per_stack,
					max_stack = self.config.weaken_stack_max,
				}
			)
		end,
	}
end
s = e({ l(nil) }, s)
local t = c()
t.name = "modifier_rune_weaken_slow"
d(t, i)
function t.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.effectPerStack = 0
end
function t.prototype.OnCreated(self, u)
	self.effectPerStack = u.effect_per_stack or 0
	if IsServer() then
		self:AddStackCountDuration(u.stack, u.duration, u.max_stack)
		self:StartIntervalThink(0.2)
	end
end
function t.prototype.OnRefresh(self, u)
	self.effectPerStack = u.effect_per_stack or self.effectPerStack
	if IsServer() then
		self:AddStackCountDuration(u.stack, u.duration, u.max_stack)
	end
end
function t.prototype.OnIntervalThink(self)
	if IsServer() and self:GetStackCount() <= 0 then
		self:Destroy()
	end
end
function t.prototype.StaticProperty(self)
	local v = self:GetStackCount() * self.effectPerStack
	return { [PropertyFunction.ATTACKSPEED_REDUCTION] = v, [PropertyFunction.MOVESPEED_AMPLIFY] = -v }
end
t = e(
	{
		h(
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
	t
)
local w = c()
w.name = "modifier_rune_weaken_damage_reduce"
d(w, i)
function w.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.effectPerStack = 0
end
function w.prototype.OnCreated(self, u)
	self.effectPerStack = u.effect_per_stack or 0
	if IsServer() then
		self:AddStackCountDuration(u.stack, u.duration, u.max_stack)
		self:StartIntervalThink(0.2)
	end
end
function w.prototype.OnRefresh(self, u)
	self.effectPerStack = u.effect_per_stack or self.effectPerStack
	if IsServer() then
		self:AddStackCountDuration(u.stack, u.duration, u.max_stack)
	end
end
function w.prototype.OnIntervalThink(self)
	if IsServer() and self:GetStackCount() <= 0 then
		self:Destroy()
	end
end
function w.prototype.StaticProperty(self)
	return { [PropertyFunction.FINAL_DAMAGE] = -self:GetStackCount() * self.effectPerStack }
end
w = e(
	{
		h(
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
	w
)
return f