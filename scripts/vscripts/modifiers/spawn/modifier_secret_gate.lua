--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/spawn/modifier_secret_gate"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_secret_gate"
d(j, h)
function j.prototype.OnDestroy(self)
	if IsServer() then
		EmitSoundOn("Dungeon.SmashCrateShort", self.parent)
	end
end
function j.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_BLIND] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
	}
end
function j.prototype.StaticState(self)
	return { [StateEnum.BREAKABLE] = true }
end
function j.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PROVIDES_FOW_POSITION }
end
function j.prototype.GetModifierProvidesFOWVision(self)
	return 1
end
function j.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.MIN_HEALTH] = function(k, l)
			local m = self:GetParent()
			local n = m:GetHealth() - 1
			m:EmitSound("Building_Generic.PartialDestruction")
			local o = ParticleManager:CreateParticleForce(
				"particles/breakable/eom_column_006_hurt.vpcf",
				PATTACH_ABSORIGIN,
				m
			)
			ParticleManager:ReleaseParticleIndex(o)
			if n <= 0 then
				m:EmitSound("Building_Generic.Destruction")
				local o = ParticleManager:CreateParticleForce(
					"particles/breakable/eom_column_006_destory_smoke.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControl(o, 0, m:GetAbsOrigin())
				ParticleManager:ReleaseParticleIndex(o)
			end
			return n
		end,
	}
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
				RemoveOnDeath = false,
			}
		),
	},
	j
)
return f