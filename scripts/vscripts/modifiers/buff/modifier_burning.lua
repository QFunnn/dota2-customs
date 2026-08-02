--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_burning"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Delete
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("modifiers.eom_modifier.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = c()
k.name = "modifier_burning"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self.burningStacks = {}
		self:UpdateBurningStack(l.entIndex, l.stack)
		self:StartIntervalThink(1)
	else
		local m = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_huskar/huskar_burning_spear_debuff.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		self:AddParticle(m, false, false, -1, false, true)
	end
end
function k.prototype.OnRefresh(self, l)
	if IsServer() then
		self:UpdateBurningStack(l.entIndex, l.stack)
	end
end
function k.prototype.UpdateBurningStack(self, n, o)
	if self.burningStacks[n] == nil then
		self.burningStacks[n] = 0
	end
	self.burningStacks[n] = math.max(o, self.burningStacks[n])
end
function k.prototype.GetBurningStack(self, n)
	return self.burningStacks[n] or 0
end
function k.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not self:GetParent():IsAlive() then
		self:StartIntervalThink(-1)
		return
	end
	local p = {}
	local q = self:GetParent()
	for n, r in pairs(self.burningStacks) do
		do
			local s = EntIndexToHScript(n)
			if not IsValid(s) or not s:IsAlive() then
				p[#p + 1] = n
				goto t
			end
			s:DealDamage(q, self:GetAbility(), r, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, EOM_DAMAGE_FLAGS.BURNING_DAMAGE)
		end
		::t::
	end
	do
		local u = 0
		while u < #p do
			e(self.burningStacks, p[u + 1])
			u = u + 1
		end
	end
end
function k.prototype.TriggerBurning(self, v)
	for n, r in pairs(self.burningStacks) do
		if n == v:entindex() then
			v:DealDamage(
				self:GetParent(),
				self:GetAbility(),
				r,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
				EOM_DAMAGE_FLAGS.BURNING_DAMAGE
			)
		end
	end
end
k = f(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = true,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	k
)
return g