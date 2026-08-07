--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_027"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArraySplice
local g = {}
local h
local i = require("modifiers.eom_modifier.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("abilities.eom_privilege")
local m = l.EOMPrivilege
local n = l.PrivilegeValue
local o = l.RegisterPrivilege
local p = c()
p.name = "privilege_myth_027"
d(p, m)
function p.prototype.EventListener(self)
	return {
		spent_mana = function(q, r)
			local s = self:GetCaster()
			if r.unit == s then
				self:IncrementStackCount(r.cost)
				local t = self:GetSpecialValueFor("mana_cost")
				while t > 0 and self:GetStackCount() >= t do
					s:AddNewModifier(
						s,
						nil,
						h.name,
						{
							value = self.value,
							duration = self:GetSpecialValueFor("duration"),
							stack_limit = self:GetSpecialValueFor("stack_limit"),
						}
					)
					self:SetStackCount(self:GetStackCount() - t)
				end
			end
		end,
	}
end
function p.prototype.OnDestroy(self)
	local s = self:GetCaster()
	if IsValid(s) then
		s:RemoveModifierByName(h.name)
	end
end
e({ n(nil) }, p.prototype, "value", nil)
p = e({ o(nil) }, p)
h = c()
h.name = "modifier_privilege_myth_027"
d(h, j)
function h.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.stacks = {}
end
function h.prototype.OnCreated(self, u)
	if IsServer() then
		self.stack_limit = u.stack_limit
		self.value = u.value
		self:AddStack(u.duration)
		self:StartIntervalThink(1)
	end
end
function h.prototype.OnRefresh(self, u)
	if IsServer() then
		self.stack_limit = u.stack_limit
		self.value = u.value
		self:AddStack(u.duration)
	end
end
function h.prototype.AddStack(self, v)
	local w = self.stacks
	w[#w + 1] = self:GetElapsedTime() + v
	while #self.stacks > self.stack_limit do
		f(self.stacks, 0, 1)
	end
	self:UpdateStackCount()
end
function h.prototype.OnIntervalThink(self)
	local x = false
	do
		local y = #self.stacks - 1
		while y >= 0 do
			if self:GetElapsedTime() >= self.stacks[y + 1] then
				f(self.stacks, y, 1)
				x = true
			end
			y = y - 1
		end
	end
	if x then
		self:UpdateStackCount()
		if #self.stacks <= 0 then
			self:Destroy()
		end
	end
end
function h.prototype.UpdateStackCount(self)
	self:SetStackCount(#self.stacks * self.value)
end
function h.prototype.StaticProperty(self)
	return { [PropertyFunction.DAMAGE_AMPLIFY] = self:GetStackCount() }
end
h = e(
	{
		k(
			a,
			{
				IsHidden = false,
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