--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_zeus_crit"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_zeus_crit"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.pendingDamage = {}
	self.flushScheduled = false
end
function j.prototype.QueueLightningStrike(self, k, l, m)
	if BlessPerformance.Enabled then
		BlessPerformance:Increment("zeus_crit_queued")
	end
	local n = tostring(l:entindex())
	local o = self.pendingDamage[n]
	if o == nil then
		self.pendingDamage[n] = { target = l, damage = m }
	else
		o.damage = o.damage + m
	end
	if self.flushScheduled then
		return
	end
	self.flushScheduled = true
	k:StartThink(0, "item_zeus_crit_aggregate_" .. tostring(self:entindex()), function()
		local p = self.pendingDamage
		self.pendingDamage = {}
		self.flushScheduled = false
		if not IsValid(k) then
			return -1
		end
		for q, r in pairs(p) do
			if IsValid(r.target) and r.target:IsAlive() then
				if BlessPerformance.Enabled then
					BlessPerformance:Increment("zeus_crit_aggregated_strikes")
				end
				k:LightningStrike(r.target, r.damage, bit.bor(EOM_DAMAGE_FLAGS.NO_CRIT, EOM_DAMAGE_FLAGS.NO_EXPOSE))
			end
		end
		return -1
	end)
end
function j.prototype.EventListener(self)
	return {
		crit_event = function(s, t)
			local k = self:GetCaster()
			if k == t.attacker then
				local m = self:GetSpecialValueFor("damage")
				self:QueueLightningStrike(k, t.target, m)
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f