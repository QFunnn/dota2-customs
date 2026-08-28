--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_wind_bleed"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.registerAbility
local i = require("abilities.eom_ability")
local j = i.EOMItem
local k = c()
k.name = "item_wind_bleed"
d(k, j)
function k.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.wisps = {}
end
function k.prototype.OnCreated(self)
	local l = self:GetCaster()
	local m = self:GetSpecialValueFor("count")
	do
		local n = 0
		while n < m do
			local o = l:CreateWisp("wind_bleed", { attack = 0 })
			if o ~= nil then
				local p = self.wisps
				p[#p + 1] = o
			end
			n = n + 1
		end
	end
end
function k.prototype.OnDestroy(self)
	local l = self:GetCaster()
	do
		local n = 0
		while n < #self.wisps do
			local o = self.wisps[n + 1]
			if IsValid(o) then
				l:RemoveWisp(o)
			end
			n = n + 1
		end
	end
	self.wisps = {}
end
function k.prototype.EventListener(self)
	return {
		damage_event = function(q, r)
			do
				local n = 0
				while n < #self.wisps do
					if r.attacker == self.wisps[n + 1] then
						local l = self:GetCaster()
						local s = self:GetSpecialValueFor("bleed") * (1 + GetWispDamage(l) / 100)
						l:Bleed(r.target, s)
						l:DealDamage(r.target, self, s)
						l:EmitSound("Hero_BrewMaster.CinderBrew.Ignite", r.target:GetAbsOrigin())
						break
					end
					n = n + 1
				end
			end
		end,
	}
end
k = e({ h(nil) }, k)
return f