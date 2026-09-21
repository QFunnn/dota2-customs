--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_gem_suit_006"
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
n.name = "privilege_gem_suit_006"
d(n, i)
function n.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.attackCount = 0
end
function n.prototype.EventListener(self)
	return {
		attack_event = function(o, p)
			local q = self:GetCaster()
			if p.attacker ~= q or not IsValid(q) then
				return
			end
			self.attackCount = self.attackCount + 1
			local r = math.max(1, self:GetSpecialValueFor("hit_count"))
			if self.attackCount < r then
				return
			end
			self.attackCount = 0
			q:AddNewModifier(
				q,
				nil,
				g.name,
				{
					duration = self:GetSpecialValueFor("duration"),
					attack_speed = self:GetSpecialValueFor("attack_speed"),
					skill_damage = self:GetSpecialValueFor("skill_damage"),
				}
			)
		end,
	}
end
function n.prototype.OnDestroy(self)
	local q = self:GetCaster()
	if IsValid(q) then
		q:RemoveModifierByName(g.name)
	end
	i.prototype.OnDestroy(self)
end
n = e({ j(nil) }, n)
g = c()
g.name = "modifier_privilege_gem_suit_006"
d(g, l)
function g.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.attackSpeed = 0
	self.skillDamage = 0
end
function g.prototype.OnCreated(self, s)
	self:UpdateValues(s)
end
function g.prototype.OnRefresh(self, s)
	self:UpdateValues(s)
end
function g.prototype.StaticProperty(self)
	return { [PropertyFunction.ATTACKSPEED] = self.attackSpeed, [PropertyFunction.SKILL_DAMAGE_BOOST] = self.skillDamage }
end
function g.prototype.UpdateValues(self, s)
	self.attackSpeed = toFiniteNumber(s.attack_speed)
	self.skillDamage = toFiniteNumber(s.skill_damage)
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
			}
		),
	},
	g
)
return f