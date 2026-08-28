--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/spawn/modifier_spawn_skeleton"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_spawn_skeleton"
d(j, h)
function j.prototype.OnCreated(self, k)
	if IsServer() then
		local l = self:GetParent()
		l:AddNoDraw()
		l:EmitSound("SeasonalConsumable.TI10.Portal.Loop")
		self:SetDuration(1, true)
		local m = ParticleManager:CreateParticleForce(
			"particles/econ/events/ti10/portal/portal_open_good.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControlEnt(m, 0, l, PATTACH_ABSORIGIN_FOLLOW, nil, l:GetAbsOrigin(), false)
		self:AddParticle(m, false, false, -1, false, false)
	end
end
function j.prototype.OnRefresh(self, k)
	if IsServer() then
	end
end
function j.prototype.OnDestroy(self)
	if IsServer() then
		local l = self:GetParent()
		l:RemoveNoDraw()
		l:StopSound("SeasonalConsumable.TI10.Portal.Loop")
		local m = ParticleManager:CreateParticleForce(
			"particles/econ/events/ti10/portal/portal_revealed_nothing_good_3.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(m, 0, l:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(m)
	end
end
function j.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function j.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
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