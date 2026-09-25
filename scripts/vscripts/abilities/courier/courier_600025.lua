--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/courier/courier_600025"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMAbility
local l = j.registerEOMAbility
local m = require("abilities.courier.courier_base")
local n = m.CourierModifierBase
local o = m.CourierBuffConfig
local p = m.CourierMainConfig
local q = c()
q.name = "courier_600025"
d(q, k)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_courier_600025"
end
q = e({ l(nil) }, q)
local r = c()
r.name = "modifier_courier_600025"
d(r, n)
function r.prototype.GetBuffModifierName(self)
	return "modifier_courier_600025_buff"
end
r = e({ i(a, p) }, r)
local s = c()
s.name = "modifier_courier_600025_buff"
d(s, h)
function s.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.artifactCount = 0
end
function s.prototype.GetAbilitySpecialValue(self)
	self.attribute_pct = self:GetAbilitySpecialValueFor("attribute_pct")
	self.stack_max = self:GetAbilitySpecialValueFor("stack_max")
end
function s.prototype.OnCreated(self, t)
	if IsServer() then
		self:UpdateArtifactCount()
	end
end
function s.prototype.OnRefresh(self, t)
	if IsServer() then
		self:UpdateArtifactCount()
	end
end
function s.prototype.EventListener(self)
	return {
		item_added = function(u, v)
			if v.unit == self:GetParent() then
				self:UpdateArtifactCount()
			end
		end,
		item_removed = function(u, v)
			if v.unit == self:GetParent() then
				self:UpdateArtifactCount()
			end
		end,
	}
end
function s.prototype.UpdateArtifactCount(self)
	local w = self:GetParent():GetAllItems()
	local x = 0
	for u, y in ipairs(w) do
		if IsValid(y) and KeyValues.artifact[y:GetAbilityName()] ~= nil then
			x = x + 1
		end
	end
	self.artifactCount = x
end
function s.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.PHYSICAL_DAMAGE_MULTIPLIER_MUL] = function()
			return math.min(self.artifactCount, self.stack_max) * self.attribute_pct
		end,
	}
end
s = e({ i(a, o) }, s)
return f