--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_ice_mark"
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
k.name = "modifier_ice_mark"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.damageRecord = {}
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
			"particles/units/benediction/ice_mark.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			self.parent
		)
		ParticleManager:SetParticleControl(self.particleID, 60, Vector(180, 235, 255))
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
		[PropertyFunction.DAMAGE_PROC_TARGET] = function(w, l)
			if l == nil then
				return 0
			end
			if not BitAndEquals(l.damage_flags, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE) then
				return 0
			end
			local y = self:GetCaster()
			if not IsValid(y) then
				self:Destroy()
				return 0
			end
			self:CleanupExpiredDamageRecord()
			if #self.damageRecord > 0 then
				table.remove(self.damageRecord, 1)
				if #self.damageRecord <= 0 then
					self:Destroy()
				end
				self:UpdateRecordCountParticle()
				Event:Fire("ice_mark_effect", l)
				return ICE_MARK_DAMAGE
			end
			return 0
		end,
	}
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