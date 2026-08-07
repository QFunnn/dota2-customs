--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/spawn/modifier_spawn_bonus_smithy"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_spawn_bonus_smithy"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.isForging = false
end
function j.prototype.OnCreated(self, k)
	if IsServer() then
		self.parent:SetHullRadius(300)
		local l = ParticleManager:CreateParticleForce(
			"particles/map/smithy_ambient.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		self:AddParticle(l, false, false, -1, false, false)
		self.parent:SetForwardVector(vec3_bottom)
		self.parent.IsForging = function()
			return self.isForging
		end
	end
end
function j.prototype.Forg(self)
	if IsServer() then
		self.particleID = ParticleManager:CreateParticleForce(
			"particles/items5_fx/repair_kit_ancient_overhead.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			self.parent
		)
		ParticleManager:SetParticleControlEnt(
			self.particleID,
			2,
			self.parent,
			PATTACH_OVERHEAD_FOLLOW,
			"",
			self.parent:GetAbsOrigin(),
			false
		)
		self:SetStackCount(3)
		self:StartIntervalThink(0.5)
		self.isForging = true
	end
end
function j.prototype.OnIntervalThink(self)
	if IsServer() then
		if self:GetStackCount() > 0 then
			self:DecrementStackCount()
			self.parent:EmitSound("DOTA_Item.HavocHammer.Cast")
		else
			if self.particleID ~= nil then
				ParticleManager:DestroyParticle(self.particleID, false)
			end
			self:StartIntervalThink(-1)
			self.isForging = false
		end
	end
end
function j.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_HEALTH_BAR] = true, [MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_UNSELECTABLE] = true }
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