--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_gem_suit_015"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g
local h = require("abilities.eom_privilege")
local i = h.EOMPrivilege
local j = h.RegisterPrivilege
local k = require("modifiers.eom_modifier.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = c()
n.name = "privilege_gem_suit_015"
d(n, i)
function n.prototype.OnCreated(self)
	self:AddEffectModifier()
end
function n.prototype.OnRefresh(self)
	i.prototype.OnRefresh(self)
	self:AddEffectModifier()
end
function n.prototype.OnDestroy(self)
	local o = self:GetCaster()
	if IsValid(o) then
		o:RemoveModifierByName(g.name)
	end
	i.prototype.OnDestroy(self)
end
function n.prototype.AddEffectModifier(self)
	local o = self:GetCaster()
	if not IsValid(o) then
		return
	end
	o:AddNewModifier(
		o,
		nil,
		g.name,
		{
			value = self:GetSpecialValueFor("value"),
			radius = self:GetSpecialValueFor("radius"),
			interval = self:GetSpecialValueFor("interval"),
		}
	)
end
n = e({ j(nil) }, n)
g = c()
g.name = "modifier_privilege_gem_suit_015"
d(g, l)
function g.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.value = 0
	self.radius = 0
	self.interval = 0.1
	self.hasProperty = false
end
function g.prototype.OnCreated(self, p)
	if not IsServer() then
		return
	end
	self:UpdateValues(p)
	self:UpdateProperty()
	self:StartIntervalThink(self.interval)
end
function g.prototype.OnRefresh(self, p)
	if not IsServer() then
		return
	end
	self:UpdateValues(p)
	self:UpdateProperty(true)
	self:StartIntervalThink(self.interval)
end
function g.prototype.OnIntervalThink(self)
	self:UpdateProperty()
end
function g.prototype.OnDestroy(self)
	self:RemoveProperty()
end
function g.prototype.UpdateValues(self, p)
	self.value = toFiniteNumber(p.value)
	self.radius = math.max(0, toFiniteNumber(p.radius))
	self.interval = math.max(FrameTime(), toFiniteNumber(p.interval))
end
function g.prototype.UpdateProperty(self, q)
	if q == nil then
		q = false
	end
	local r = self:GetParent()
	if #FindEnemiesInRadius(r, r:GetAbsOrigin(), self.radius) > 0 then
		self:RemoveProperty()
		return
	end
	if not self.hasProperty or q then
		self:AddProperty()
	end
end
function g.prototype.AddProperty(self)
	PropertySystem:AddStaticProperty(self:GetParent():entindex(), "ranged_damage_boost", self:GetName(), self.value)
	self.hasProperty = true
end
function g.prototype.RemoveProperty(self)
	if not self.hasProperty then
		return
	end
	PropertySystem:RemoveStaticProperty(self:GetParent():entindex(), self:GetName(), "ranged_damage_boost")
	self.hasProperty = false
end
g = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	g
)
return f