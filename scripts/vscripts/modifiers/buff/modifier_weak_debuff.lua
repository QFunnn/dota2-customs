--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_weak_debuff"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_weak_debuff"
d(j, h)
function j.prototype.OnCreated(self, k)
	local l = self:GetParent()
	if IsServer() then
		self:AddStackCountDuration(k.stack, WEAK_DURATION, WEAK_MAX_STACK)
	else
		self.particleID =
			ParticleManager:CreateParticle("particles/generic_gameplay/generic_weak.vpcf", PATTACH_OVERHEAD_FOLLOW, l)
		ParticleManager:SetParticleControl(self.particleID, 60, Vector(222, 254, 254))
		self:UpdateRecordCountParticle()
		self:AddParticle(self.particleID, false, false, -1, false, true)
	end
end
function j.prototype.OnRefresh(self, k)
	if IsServer() then
		self:AddStackCountDuration(k.stack, WEAK_DURATION, WEAK_MAX_STACK)
	else
		self:UpdateRecordCountParticle()
	end
end
function j.prototype.UpdateRecordCountParticle(self)
	if IsClient() and self.particleID then
		local m = self:GetStackCount()
		local n = math.floor(m / 10)
		local o = m % 10
		ParticleManager:SetParticleControl(self.particleID, 1, Vector(n, o, 0))
	end
end
function j.prototype.StaticProperty(self)
	return { [PropertyFunction.DAMAGE_AMPLIFY] = self:GetStackCount() * -WEAK_REDUCE_DAMAGE_PCT }
end
j = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	j
)
return f