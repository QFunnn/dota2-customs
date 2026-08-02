--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_expose"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFilter
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("modifiers.eom_modifier.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = c()
k.name = "modifier_expose"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.damageRecord = {}
	self.lastTriggerTime = -1
end
function k.prototype.ShouldUseOverheadOffset(self)
	return true
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:AddDamageRecord(l.stack, l.duration)
		self:UpdateRecordCountParticle()
	else
		self.particleID = ParticleManager:CreateParticle(
			"particles/generic_gameplay/generic_expose.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			self.parent
		)
		ParticleManager:SetParticleControl(self.particleID, 60, Vector(222, 254, 254))
		self:AddParticle(self.particleID, false, false, -1, false, true)
	end
	self:StartIntervalThink(0.1)
end
function k.prototype.OnRefresh(self, l)
	if IsServer() then
		self:AddDamageRecord(l.stack, l.duration)
		self:UpdateRecordCountParticle()
	end
end
function k.prototype.OnIntervalThink(self)
	if IsServer() then
		if BlessPerformance.Enabled then
			BlessPerformance:Increment("expose_ticks")
		end
		self:CleanupExpiredDamageRecord()
	else
		if self.particleID ~= nil then
			local m = self:GetStackCount()
			local n = math.floor(m / 10)
			local o = m % 10
			ParticleManager:SetParticleControl(self.particleID, 1, Vector(n, o, 0))
		end
	end
end
function k.prototype.AddDamageRecord(self, p, q)
	local r = GameRules:GetGameTime() + q
	do
		local s = 0
		while s < p do
			local t = self.damageRecord
			t[#t + 1] = { destroyTime = r }
			s = s + 1
		end
	end
end
function k.prototype.CleanupExpiredDamageRecord(self)
	local u = GameRules:GetGameTime()
	local v = #self.damageRecord
	self.damageRecord = e(self.damageRecord, function(w, x)
		return x.destroyTime > u
	end)
	if v ~= #self.damageRecord then
		if #self.damageRecord <= 0 then
			self:Destroy()
			return
		end
		self:UpdateRecordCountParticle()
	end
end
function k.prototype.UpdateRecordCountParticle(self)
	if IsServer() then
		self:SetStackCount(#self.damageRecord)
	end
end
function k.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.INCOMING_DAMAGE_AMPLIFY] = function(w, l)
			if l == nil then
				return 0
			end
			if BitAndEquals(l.damage_flags, EOM_DAMAGE_FLAGS.NO_EXPOSE) then
				return 0
			end
			local y = self:GetCaster()
			if not IsValid(y) then
				self:Destroy()
				return 0
			end
			self:CleanupExpiredDamageRecord()
			if #self.damageRecord > 0 then
				local z = GameRules:GetGameTime()
				if z - self.lastTriggerTime < k.TRIGGER_INTERVAL then
					return 0
				end
				self.lastTriggerTime = z
				if not self:PRD(GetExposeKeepChance(y, l), "Expose") then
					table.remove(self.damageRecord, 1)
					if #self.damageRecord <= 0 then
						self:Destroy()
					end
				end
				self:UpdateRecordCountParticle()
				if BlessPerformance.Enabled then
					BlessPerformance:Increment("expose_effects")
				end
				Event:Fire("expose_effect", l)
				return EXPOSE_DAMAGE_PCT + GetShockDamageAmplify(y)
			end
			return 0
		end,
	}
end
k.TRIGGER_INTERVAL = 0.1
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