--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_first_dungeon_guide"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_first_dungeon_guide"
d(j, h)
function j.prototype.OnCreated(self, k)
	self:UpdateTarget(k)
end
function j.prototype.OnRefresh(self, k)
	self:UpdateTarget(k)
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
	if not IsValid(l) or self.targetEntIndex == nil then
		return
	end
	local m = EntIndexToHScript(self.targetEntIndex)
	local n = PlayerResource:GetPlayer(l:GetPlayerOwnerID())
	if not IsValid(m) or n == nil then
		return
	end
	local o = ParticleManager:CreateParticleForPlayer(
		"particles/generic_gameplay/arrow_prompt/arrow_prompt.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil,
		n
	)
	ParticleManager:SetParticleControlEnt(o, 0, l, PATTACH_ABSORIGIN_FOLLOW, "", l:GetAbsOrigin(), false)
	ParticleManager:SetParticleControlEnt(o, 1, m, PATTACH_ABSORIGIN_FOLLOW, "", m:GetAbsOrigin(), false)
	self.arrowParticleID = o
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	j
)
return f