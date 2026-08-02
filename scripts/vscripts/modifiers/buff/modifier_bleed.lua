--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_bleed"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArraySplice
local f = b.__TS__Delete
local g = b.__TS__ObjectKeys
local h = b.__TS__DecorateLegacy
local i = {}
local j = require("modifiers.eom_modifier.eom_modifier")
local k = j.EOMModifier
local l = j.registerEOMModifier
local m = c()
m.name = "modifier_bleed"
d(m, k)
function m.prototype.GetBleedKey(self, n)
	return tostring(n)
end
function m.prototype.GetBleedDamage(self, o)
	local p = 0
	do
		local q = 0
		while q < #o.segments do
			p = p + o.segments[q + 1].damage
			q = q + 1
		end
	end
	return p
end
function m.prototype.ConsumeBleedTick(self, o)
	do
		local q = #o.segments - 1
		while q >= 0 do
			local r = o.segments[q + 1]
			r.damageCount = r.damageCount - 1
			if r.damageCount <= 0 then
				e(o.segments, q, 1)
			end
			q = q - 1
		end
	end
end
function m.prototype.OnCreated(self, s)
	if IsServer() then
		self.bleedStacks = {}
		self.position = self:GetParent():GetAbsOrigin()
		self:AddBleedStack(s.entIndex, s.stack)
		self:StartIntervalThink(0)
	else
		local t = ParticleManager:CreateParticle(
			"particles/units/benediction/ringmaster_dagger_target_bleed.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		self:AddParticle(t, false, false, -1, false, true)
	end
end
function m.prototype.OnRefresh(self, s)
	if IsServer() then
		self:AddBleedStack(s.entIndex, s.stack)
	end
end
function m.prototype.AddBleedStack(self, n, u)
	local v = self:GetBleedKey(n)
	local w = self.bleedStacks[v]
	if w ~= nil then
		local x = w.segments
		x[#x + 1] = { damage = u, damageCount = BLEED_DAMAGE_COUNT }
	else
		self.bleedStacks[v] = {
			entIndex = n,
			segments = { { damage = u, damageCount = BLEED_DAMAGE_COUNT } },
			distance = 0,
			nextMoveDamageTime = 0,
		}
		self:StartThink(BLEED_DAMAGE_INTERVAL, v, function()
			local o = self.bleedStacks[v]
			if o == nil then
				self:StartThink(-1, v)
				return
			end
			local y = EntIndexToHScript(o.entIndex)
			if not IsValid(y) then
				f(self.bleedStacks, v)
				self:StartThink(-1, v)
				return
			end
			local p = self:GetBleedDamage(o)
			if p <= 0 then
				f(self.bleedStacks, v)
				self:StartThink(-1, v)
				if #g(self.bleedStacks) <= 0 then
					self:Destroy()
				end
				return
			end
			local z = p * (1 + GetBleedDamageAmplify(y, { target = self:GetParent() }) / 100)
			y:DealDamage(
				self:GetParent(),
				nil,
				z,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
				EOM_DAMAGE_FLAGS.BLEEDING_DAMAGE + EOM_DAMAGE_FLAGS.NO_CRIT + EOM_DAMAGE_FLAGS.NO_MANA_REGEN
			)
			self:ConsumeBleedTick(o)
			if #o.segments <= 0 then
				f(self.bleedStacks, v)
				self:StartThink(-1, v)
			end
			if #g(self.bleedStacks) <= 0 then
				self:Destroy()
			end
		end)
	end
end
function m.prototype.GetBleedStack(self, n)
	local A = 0
	for v, o in pairs(self.bleedStacks) do
		if o.entIndex == n then
			A = A + self:GetBleedDamage(o)
		end
	end
	return A
end
function m.prototype.OnIntervalThink(self)
	local B = self:GetParent()
	local C = B:GetAbsOrigin()
	local D = CalcDistance(C, self.position)
	local E = GameRules:GetGameTime()
	self.position = C
	local F = {}
	for v, o in pairs(self.bleedStacks) do
		do
			local p = self:GetBleedDamage(o)
			if p <= 0 then
				F[#F + 1] = v
				goto G
			end
			o.distance = o.distance + D
			if o.distance >= BLEED_MOVE_DAMAGE_DISTANCE_THRESHOLD and E >= o.nextMoveDamageTime then
				o.distance = o.distance - BLEED_MOVE_DAMAGE_DISTANCE_THRESHOLD
				o.nextMoveDamageTime = E + BLEED_MOVE_DAMAGE_COOLDOWN
				local y = EntIndexToHScript(o.entIndex)
				if not IsValid(y) then
					F[#F + 1] = v
					goto G
				end
				local H = p * BLEED_MOVE_DAMAGE_PCT * 0.01 * (1 + GetBleedDamageAmplify(y, { target = B }) / 100)
				y:DealDamage(
					B,
					nil,
					H,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
					EOM_DAMAGE_FLAGS.BLEEDING_DAMAGE + EOM_DAMAGE_FLAGS.NO_CRIT + EOM_DAMAGE_FLAGS.NO_MANA_REGEN
				)
			end
		end
		::G::
	end
	do
		local q = 0
		while q < #F do
			local v = F[q + 1]
			f(self.bleedStacks, v)
			self:StartThink(-1, v)
			q = q + 1
		end
	end
	if #g(self.bleedStacks) <= 0 then
		self:Destroy()
	end
end
function m.prototype.TriggerBleed(self, y, I)
	for v, o in pairs(self.bleedStacks) do
		if o.entIndex == y:entindex() then
			local J = self:GetBleedDamage(o) * (1 + GetBleedDamageAmplify(y, { target = self:GetParent() }) / 100) * I
			y:DealDamage(
				self:GetParent(),
				nil,
				J,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
				EOM_DAMAGE_FLAGS.BLEEDING_DAMAGE + EOM_DAMAGE_FLAGS.NO_CRIT + EOM_DAMAGE_FLAGS.NO_MANA_REGEN
			)
		end
	end
end
m = h(
	{
		l(
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
	m
)
return i