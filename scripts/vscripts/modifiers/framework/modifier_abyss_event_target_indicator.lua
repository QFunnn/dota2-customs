--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_abyss_event_target_indicator"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_abyss_event_target_indicator"
d(j, h)
function j.prototype.OnCreated(self, k)
	self:UpdateTarget(k)
end
function j.prototype.OnRefresh(self, k)
	self:UpdateTarget(k)
end
function j.prototype.GetTargetEntIndex(self)
	return self.targetEntIndex
end
function j.prototype.OnDestroy(self)
	self:ClearParticle()
end
function j.prototype.UpdateTarget(self, k)
	if self.targetEntIndex == k.targetEntIndex and self.arrowParticleID ~= nil then
		return
	end
	self.targetEntIndex = k.targetEntIndex
	self:RefreshParticle()
end
function j.prototype.RefreshParticle(self)
	self:ClearParticle()
	if not IsServer() then
		return
	end
	local l = self:GetParent()
	if not IsValid(l) then
		return
	end
	if self.targetEntIndex == nil then
		return
	end
	local m = EntIndexToHScript(self.targetEntIndex)
	if not IsValid(m) then
		return
	end
	local n = ParticleManager:CreateParticleForPlayer(
		"particles/generic_gameplay/arrow_prompt/arrow_prompt.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil,
		l:GetPlayerOwner()
	)
	ParticleManager:SetParticleControlEnt(n, 0, l, PATTACH_ABSORIGIN_FOLLOW, "", l:GetAbsOrigin(), false)
	ParticleManager:SetParticleControlEnt(n, 1, m, PATTACH_ABSORIGIN_FOLLOW, "", m:GetAbsOrigin(), false)
	self.arrowParticleID = n
end
function j.prototype.ClearParticle(self)
	if self.arrowParticleID == nil then
		return
	end
	if IsServer() then
		ParticleManager:DestroyParticle(self.arrowParticleID, false)
		ParticleManager:ReleaseParticleIndex(self.arrowParticleID)
	end
	self.arrowParticleID = nil
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
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	j
)
return f