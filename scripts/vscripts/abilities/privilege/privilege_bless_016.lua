--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_016"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g
local h = require("modifiers.eom_modifier.eom_modifier")
local i = h.registerEOMModifier
local j = h.EOMModifier
local k = require("abilities.eom_privilege")
local l = k.EOMPrivilege
local m = k.RegisterPrivilege
local n = c()
n.name = "privilege_bless_016"
d(n, l)
function n.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.cost_gold = 0
	self.damage_bonus = 0
	self.effectPlayerID = -1
end
function n.prototype.OnCreated(self)
	local o = self:GetCaster()
	if IsValid(o) then
		self.effectPlayerID = o:GetPlayerID()
	end
end
function n.prototype.UpdateDamageBonus(self)
	local o = self:GetCaster()
	if not IsValid(o) then
		return
	end
	local p = self:GetSpecialValueFor("per_cost_gold") or 100
	local q = math.floor(self.cost_gold / p)
	if q <= 0 then
		return
	end
	self.cost_gold = self.cost_gold - q * p
	o:AddNewModifier(o, nil, g.name, { stack = q })
end
function n.prototype.EventListener(self)
	return {
		shop_item_purchased = function(r, s)
			if s.playerID ~= self.effectPlayerID then
				return
			end
			self.cost_gold = self.cost_gold + s.cost
			self:UpdateDamageBonus()
		end,
		wishing_pool_reward = function(r, s)
			if s.playerID ~= self.effectPlayerID then
				return
			end
			self.cost_gold = self.cost_gold + s.cost
			self:UpdateDamageBonus()
		end,
	}
end
n = e({ m(nil) }, n)
g = c()
g.name = "modifier_privilege_bless_016_damage_bonus"
d(g, j)
function g.prototype.UpdateStacks(self, t)
	local u = math.min(self:GetStackCount() + t, self.stack_limit)
	self:SetStackCount(u)
end
function g.prototype.OnCreated(self, v)
	if IsServer() then
		local w = Privilege:GetPrivilegeSpecialValue("privilege_bless_016", 1, "damage_bonus", nil)
		local x = Privilege:GetPrivilegeSpecialValue("privilege_bless_016", 1, "damage_bonus_max", nil)
		self.stack_limit = math.floor(x / w)
		self.value = w
		self:UpdateStacks(v.stack or 1)
	end
end
function g.prototype.OnRefresh(self, v)
	if IsServer() then
		self:UpdateStacks(v.stack or 1)
	end
end
function g.prototype.StaticProperty(self)
	return { [PropertyFunction.DAMAGE_AMPLIFY] = toFiniteNumber(self.value) * self:GetStackCount() }
end
g = e(
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
	g
)
return f