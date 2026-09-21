--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_ice_curse"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_ice_curse"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.enable = true
end
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			local m = self:GetCaster()
			local n = l.target
			if l.attacker ~= m or not self.enable or not IsValid(n) or n:IsBreakable() then
				return
			end
			if not n:IsAlive() then
				return
			end
			if n:GetHealthPercent() > self:GetSpecialValueFor("threshold") then
				return
			end
			self.enable = false
			do
				local o, p = pcall(function()
					local q = self:GetSpecialValueFor("radius")
					local r = self:GetSpecialValueFor("damage")
					local s = n:GetAbsOrigin()
					if n:IsAlive() then
						DamageSystem:DealDamage({
							attacker = m,
							target = n,
							ability = self,
							damage = n:GetHealth(),
							damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE,
							damage_flags = bit.bor(
								bit.bor(EOM_DAMAGE_FLAGS.FREEZE_DAMAGE, EOM_DAMAGE_FLAGS.NO_CRIT),
								EOM_DAMAGE_FLAGS.NO_DAMAGE_AMPLIFY
							),
						})
					end
					if IsValid(n) then
						s = n:GetAbsOrigin()
					end
					local t = FindUnitsInRadiusWithAbility(m, s, q, self)
					for k, u in ipairs(t) do
						m:Frozen(u)
						m:DealDamage(u, self, r, nil, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE)
					end
					local v = ParticleManager:CreateParticle(
						"particles/units/benediction/ice_curse.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					if v ~= -1 then
						ParticleManager:SetParticleControl(v, 3, s)
						ParticleManager:SetParticleControl(v, 1, Vector(q, q, q))
						ParticleManager:SetParticleControl(v, 2, Vector(q, 0, 0))
						ParticleManager:ReleaseParticleIndex(v)
					end
					m:EmitSound("Hero_Crystal.CrystalNova")
				end)
				do
					self.enable = true
				end
				if not o then
					error(p, 0)
				end
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f