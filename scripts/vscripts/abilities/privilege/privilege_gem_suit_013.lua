--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_gem_suit_013"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArraySplice
local g = {}
local h
local i = require("abilities.eom_privilege")
local j = i.EOMPrivilege
local k = i.RegisterPrivilege
local l = require("modifiers.eom_modifier.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
local o = c()
o.name = "privilege_gem_suit_013"
d(o, j)
function o.prototype.EventListener(self)
	return {
		ability_cast_complete = function(p, q)
			local r = self:GetCaster()
			if q.caster ~= r or not IsValid(r) or not self:IsTriggerAbility(q.abilityTag) then
				return
			end
			r:AddNewModifier(
				r,
				nil,
				h.name,
				{
					duration = self:GetSpecialValueFor("duration"),
					value = self:GetSpecialValueFor("value"),
					stack_limit = self:GetSpecialValueFor("stack_limit"),
				}
			)
		end,
	}
end
function o.prototype.OnDestroy(self)
	local r = self:GetCaster()
	if IsValid(r) then
		r:RemoveModifierByName(h.name)
	end
	j.prototype.OnDestroy(self)
end
function o.prototype.IsTriggerAbility(self, s)
	return s == AbilityTag.Skill or s == AbilityTag.Dodge or s == AbilityTag.Defense or s == AbilityTag.Ultimate
end
o = e({ k(nil) }, o)
h = c()
h.name = "modifier_privilege_gem_suit_013"
d(h, m)
function h.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.stackExpireTimes = {}
	self.value = 0
	self.stackLimit = 1
end
function h.prototype.OnCreated(self, t)
	if not IsServer() then
		return
	end
	self:UpdateValues(t)
	self:AddStack(t.duration)
	self:StartIntervalThink(0.1)
end
function h.prototype.OnRefresh(self, t)
	if not IsServer() then
		return
	end
	self:UpdateValues(t)
	self:AddStack(t.duration)
end
function h.prototype.OnIntervalThink(self)
	local u = self:GetElapsedTime()
	local v = false
	do
		local w = #self.stackExpireTimes - 1
		while w >= 0 do
			if u >= self.stackExpireTimes[w + 1] then
				f(self.stackExpireTimes, w, 1)
				v = true
			end
			w = w - 1
		end
	end
	if not v then
		return
	end
	self:SetStackCount(#self.stackExpireTimes)
	if #self.stackExpireTimes == 0 then
		self:Destroy()
	end
end
function h.prototype.StaticProperty(self)
	return { [PropertyFunction.ULTIMATE_DAMAGE_BOOST] = self:GetStackCount() * self.value }
end
function h.prototype.UpdateValues(self, t)
	self.value = toFiniteNumber(t.value)
	self.stackLimit = math.max(1, math.floor(toFiniteNumber(t.stack_limit)))
end
function h.prototype.AddStack(self, x)
	local y = self.stackExpireTimes
	y[#y + 1] = self:GetElapsedTime() + toFiniteNumber(x)
	while #self.stackExpireTimes > self.stackLimit do
		f(self.stackExpireTimes, 0, 1)
	end
	self:SetStackCount(#self.stackExpireTimes)
end
h = e(
	{
		n(
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
	h
)
return g