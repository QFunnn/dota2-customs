--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_loading_screen"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_loading_screen"
d(j, h)
function j.prototype.OnCreated(self, k)
	if IsServer() then
		local l = self:GetParent():GetPlayerOwnerID()
		local m = PlayerResource:GetPlayer(l)
		if IsValid(m) then
			local n = ParticleManager:CreateParticleForPlayer(
				"particles/scene/scene_loading/scene_loading_smoke_01fx.vpcf",
				PATTACH_EYES_FOLLOW,
				self:GetParent(),
				m
			)
			ParticleManager:SetParticleControlEnt(
				n,
				1,
				self:GetParent(),
				PATTACH_EYES_FOLLOW,
				nil,
				self:GetParent():GetAbsOrigin(),
				true
			)
			self:AddParticle(n, true, false, -1, false, false)
		end
	end
end
function j.prototype.OnDestroy(self)
	if IsServer() then
		local l = self:GetParent():GetPlayerOwnerID()
		local m = PlayerResource:GetPlayer(l)
		if IsValid(m) then
			local n = ParticleManager:CreateParticleForPlayer(
				"particles/scene/scene_loading/scene_loading_smoke_fx.vpcf",
				PATTACH_EYES_FOLLOW,
				self:GetParent(),
				m
			)
			ParticleManager:SetParticleControlEnt(
				n,
				1,
				self:GetParent(),
				PATTACH_EYES_FOLLOW,
				nil,
				self:GetParent():GetAbsOrigin(),
				true
			)
			self:AddParticle(n, false, false, -1, false, false)
		end
	end
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
			}
		),
	},
	j
)
return f