--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/combo_events/modifier_abyssal_recovery"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.registerEOMModifier
local i = g.EOMModifier
local j = c()
j.name = "modifier_abyssal_recovery_hp"
d(j, i)
function j.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.healPct = 0
end
function j.prototype.OnCreated(self, k)
	if not IsServer() then
		return
	end
	self:UpdateParams(k)
	self:StartIntervalThink(1)
end
function j.prototype.OnRefresh(self, k)
	if not IsServer() then
		return
	end
	self:UpdateParams(k)
end
function j.prototype.OnIntervalThink(self)
	local l = self:GetParent()
	if not IsValid(l) or not l:IsAlive() then
		return
	end
	local m = l:GetMaxHealth() * self.healPct * 0.01
	l:Heal(m, self:GetAbility())
end
function j.prototype.UpdateParams(self, k)
	self.healPct = math.max(0, toFiniteNumber(k.heal_pct, 0))
end
j = e(
	{
		h(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	j
)
local n = c()
n.name = "modifier_abyssal_recovery_shield"
d(n, i)
function n.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.shieldPct = 0
end
function n.prototype.OnCreated(self, k)
	if not IsServer() then
		return
	end
	self:UpdateParams(k)
	self:StartIntervalThink(1)
end
function n.prototype.OnRefresh(self, k)
	if not IsServer() then
		return
	end
	self:UpdateParams(k)
end
function n.prototype.OnIntervalThink(self)
	local l = self:GetParent()
	if not IsValid(l) or not l:IsAlive() then
		return
	end
	local o = l:GetMaxHealth() * self.shieldPct * 0.01
	l:AddShield(o, "modifier_abyssal_shield", "add")
end
function n.prototype.UpdateParams(self, k)
	self.shieldPct = math.max(0, toFiniteNumber(k.shield_pct, 0))
end
n = e(
	{
		h(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	n
)
local p = c()
p.name = "modifier_abyssal_recovery_rage"
d(p, i)
function p.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.ragePct = 0
end
function p.prototype.OnCreated(self, k)
	if not IsServer() then
		return
	end
	self:UpdateParams(k)
	self:StartIntervalThink(1)
end
function p.prototype.OnRefresh(self, k)
	if not IsServer() then
		return
	end
	self:UpdateParams(k)
end
function p.prototype.OnIntervalThink(self)
	local l = self:GetParent()
	if not IsValid(l) or not l:IsAlive() then
		return
	end
	local q = l:GetMaxMana() * self.ragePct * 0.01
	l:GiveMana(q)
end
function p.prototype.UpdateParams(self, k)
	self.ragePct = math.max(0, toFiniteNumber(k.rage_pct, 0))
end
p = e(
	{
		h(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	p
)
return f