--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_zues_dash"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_zues_dash"
d(j, h)
function j.prototype.OnCreated(self)
	if IsServer() then
		self.lastHitTime = 0
		local k = self:GetSpecialValueFor("hit_interval")
		local l = self:GetSpecialValueFor("hit_count")
		local m = self:GetSpecialValueFor("hit_radius")
		local n = self:GetSpecialValueFor("radius")
		local o = self:GetCaster()
		self:StartThink(0, function()
			if self.dashStart and GameRules:GetGameTime() - self.lastHitTime >= k then
				self.lastHitTime = GameRules:GetGameTime()
				local p = self:GetSpecialValueFor("damage")
				local q = FindUnitsInRadiusWithAbility(o, o:GetAbsOrigin(), n, self)
				do
					local r = 0
					while r < l do
						local s = o:GetAbsOrigin()
						local t
						for u, v in ipairs(q) do
							if v:IsAlive() then
								t = v:GetAbsOrigin()
								local w = FindUnitsInRadiusWithAbility(o, t, m, self)
								if #w > 0 then
									o:DealDamage(w, self, p)
								end
								break
							end
						end
						if not t then
							t = s + RandomVector(RandomInt(50, n))
						end
						local x = ParticleManager:CreateParticle(
							"particles/abilities/zuus_thundergods_wrath.vpcf",
							PATTACH_WORLDORIGIN,
							nil
						)
						local y = RandomVector(RandomInt(250, 80))
						y.z = 900
						ParticleManager:SetParticleControl(x, 0, t + y)
						ParticleManager:SetParticleControl(x, 1, t)
						ParticleManager:ReleaseParticleIndex(x)
						x = ParticleManager:CreateParticle(
							"particles/units/heroes/hero_zuus/zuus_lightning_bolt_aoe.vpcf",
							PATTACH_WORLDORIGIN,
							nil
						)
						ParticleManager:SetParticleControl(x, 0, t)
						ParticleManager:SetParticleControl(x, 1, Vector(m, 0, 0))
						ParticleManager:ReleaseParticleIndex(x)
						r = r + 1
					end
				end
			end
		end)
	end
end
function j.prototype.EventListener(self)
	return {
		dash_start = function(z, A)
			if A.caster ~= self:GetCaster() then
				return
			end
			self.startPos = A.start
			self.dashStart = true
		end,
		dash_end = function(z, A)
			local o = self:GetCaster()
			if not self.startPos or o ~= A.caster then
				return
			end
			self.lastHitTime = 0
			self.dashStart = false
		end,
	}
end
j = e({ i(nil) }, j)
return f