--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_poison_custom"
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
k.name = "modifier_poison_custom"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self.poisonStacks = {}
		self:AddPoisonStack(l.entIndex, l.stack)
		self:StartIntervalThink(POISON_DECAY_INTERVAL)
	else
		local m = ParticleManager:CreateParticle(
			"particles/units/benediction/venomancer_gale_poison_debuff.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		self:AddParticle(m, false, false, -1, false, false)
	end
end
function k.prototype.OnRefresh(self, l)
	if IsServer() then
		self:AddPoisonStack(l.entIndex, l.stack)
	end
end
function k.prototype.AddPoisonStack(self, n, o)
	if self.poisonStacks[n] == nil then
		self.poisonStacks[n] = 0
	end
	local p, q = self.poisonStacks, n
	p[q] = p[q] + math.floor(o)
end
function k.prototype.GetPoisonStack(self, n)
	return self.poisonStacks[n] or 0
end
function k.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not self:GetParent():IsAlive() then
		self:StartIntervalThink(-1)
		return
	end
	local r = false
	local s = {}
	local t = self:GetParent()
	for n, u in pairs(self.poisonStacks) do
		do
			local v = u
			if v <= 0 then
				s[#s + 1] = n
				goto w
			end
			local x = EntIndexToHScript(n)
			if not IsValid(x) or not x:IsAlive() then
				s[#s + 1] = n
				goto w
			end
			local y = v * (1 + GetPoisonDamageAmplify(x, { target = t }) / 100)
			x:DealDamage(t, nil, y, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.POISON_DAMAGE)
			local z = GetPoisonNoAttenuationChance(x, { target = self.parent })
			if z > 0 and RollPercentage(z) then
				r = true
				goto w
			end
			local A = GetPoisonAttenuationReduction(x, { target = self.parent })
			local B = math.max(0, POISON_DECAY_RATE * 0.01 * (1 - A / 100))
			local C = 1 - B
			local D = math.floor(v * C)
			if D <= 0 then
				s[#s + 1] = n
			else
				self.poisonStacks[n] = D
				r = true
			end
		end
		::w::
	end
	do
		local E = 0
		while E < #s do
			e(self.poisonStacks, s[E + 1])
			E = E + 1
		end
	end
	if not r then
		self:Destroy()
	end
end
function k.prototype.TriggerPoison(self, F)
	for n, u in pairs(self.poisonStacks) do
		if n == F:entindex() then
			local t = self:GetParent()
			local y = u * (1 + GetPoisonDamageAmplify(F, { target = t }) / 100)
			F:DealDamage(t, nil, y, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.POISON_DAMAGE)
			local m = ParticleManager:CreateParticle(
				"particles/econ/items/necrolyte/necronub_death_pulse/necrolyte_pulse_ka_enemy_explosion.vpcf",
				PATTACH_CUSTOMORIGIN,
				t
			)
			ParticleManager:SetParticleControlEnt(
				m,
				3,
				t,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				t:GetAbsOrigin(),
				true
			)
			ParticleManager:ReleaseParticleIndex(m)
			t:EmitSound("Hero_ShadowDemon.ShadowPoison.Release")
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