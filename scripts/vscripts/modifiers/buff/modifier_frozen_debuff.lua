--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_frozen_debuff"
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
k.name = "modifier_frozen_debuff"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.iceStacks = {}
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:AddIceStack(l.entIndex, l.stack)
		self:StartIntervalThink(FROZEN_DECAY_INTERVAL)
	else
		local m = ParticleManager:CreateParticle(
			"particles/units/benediction/generic_slowed_cold.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		self:AddParticle(m, false, false, -1, false, false)
	end
end
function k.prototype.OnRefresh(self, l)
	if IsServer() then
		self:AddIceStack(l.entIndex, l.stack)
	end
end
function k.prototype.AddIceStack(self, n, o)
	if self.iceStacks[n] == nil then
		self.iceStacks[n] = 0
	end
	local p, q = self.iceStacks, n
	p[q] = p[q] + math.floor(o)
end
function k.prototype.GetIceStack(self, n)
	return self.iceStacks[n] or 0
end
function k.prototype.TriggerDecayOnce(self)
	if not IsServer() then
		return
	end
	self:ApplyDecayOnce()
end
function k.prototype.ApplyDecayOnce(self)
	if not self:GetParent():IsAlive() then
		self:StartIntervalThink(-1)
		return
	end
	local r = false
	local s = {}
	local t = self:GetParent()
	for n, u in pairs(self.iceStacks) do
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
			local y = GetFrozenNoAttenuationChance(x, { target = self.parent })
			if y > 0 and RollPercentage(y) then
				r = true
				goto w
			end
			local z = GetFrozenAttenuationReduction(x, { target = self.parent })
			local A = math.max(0, FROZEN_DECAY_RATE * 0.01 * (1 - z / 100))
			local B = 1 - A
			local C = math.floor(v * B)
			if C <= 0 then
				s[#s + 1] = n
			else
				self.iceStacks[n] = C
				r = true
			end
			Event:Fire("frozen_attenation", { caster = x, target = t, newStack = C, oldStack = v })
		end
		::w::
	end
	do
		local D = 0
		while D < #s do
			e(self.iceStacks, s[D + 1])
			D = D + 1
		end
	end
	if not r then
		self:Destroy()
	end
end
function k.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:ApplyDecayOnce()
end
function k.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.INCOMING_DAMAGE_AMPLIFY] = function(E, l)
			if l == nil then
				return 0
			end
			local x = l.attacker
			if not IsValid(x) then
				return 0
			end
			local F = self:GetIceStack(x:entindex())
			if F <= 0 then
				return 0
			end
			local G = math.log(2) / FROZEN_DAMAGE_AMPLIFY_HALF_STACK
			local H = FROZEN_DAMAGE_AMPLIFY_MAX * (1 - math.exp(-G * F))
			return math.min(FROZEN_DAMAGE_AMPLIFY_MAX, H)
		end,
	}
end
function k.prototype.StaticProperty(self)
	return { [PropertyFunction.MOVESPEED_AMPLIFY] = -50, [PropertyFunction.ATTACKSPEED_REDUCTION] = 25 }
end
k = f(
	{
		j(
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
	k
)
return g