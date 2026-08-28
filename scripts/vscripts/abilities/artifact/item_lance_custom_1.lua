--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_lance_custom_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_lance_custom_1"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.pursuitEnable = false
	self.distanceRecord = 0
end
function j.prototype.OnCreated(self)
	local k = self:GetCaster()
	self.position = k:GetAbsOrigin()
	local l = self:GetSpecialValueFor("distance")
	self:StartThink(0, "move", function()
		local m = k:GetAbsOrigin()
		local n = m:__sub(self.position):Length2D()
		self.distanceRecord = self.distanceRecord + n
		self.position = m
		if self.distanceRecord >= l then
			self.distanceRecord = 0
			self.pursuitEnable = true
		end
	end)
end
function j.prototype.EventListener(self)
	return {
		damage_event = function(o, p)
			local k = self:GetCaster()
			if k ~= p.attacker then
				return
			end
			if p.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then
				return
			end
			if not self.pursuitEnable then
				return
			end
			local q = p.target
			self:StartThink(0.15, "attack", function()
				if IsValid(q) and q:IsAlive() then
					local r = ParticleManager:CreateParticle(
						"particles/generic_gameplay/lance_custom.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					ParticleManager:SetParticleControlTransformForward(
						r,
						1,
						q:GetAbsOrigin(),
						CalcDirection2D(k:GetAbsOrigin(), q:GetAbsOrigin())
					)
					k:Attack(q)
				end
				return -1
			end)
			self.pursuitEnable = false
		end,
	}
end
j = e({ i(nil) }, j)
return f