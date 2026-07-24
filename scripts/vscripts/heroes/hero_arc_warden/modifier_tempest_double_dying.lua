--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tempest_double_dying = class({})

function modifier_tempest_double_dying:IsPurgable() return false end

function modifier_tempest_double_dying:CheckState()
	return {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_NO_TEAM_SELECT] = true,
	}
end
function modifier_tempest_double_dying:RemoveOnDeath()
	return false
end
function modifier_tempest_double_dying:OnCreated()
	if not IsServer() then return end
	local hParent = self:GetParent()
	if not hParent or hParent:IsNull() then return end

    local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_arc_warden/arc_warden_death.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent )
	ParticleManager:SetParticleControlEnt(particle, 0, hParent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", hParent:GetAbsOrigin(), true)
	hParent:Interrupt()
	hParent:InterruptChannel()
	hParent:InterruptMotionControllers(true)
end

function modifier_tempest_double_dying:OnDestroy()
	if not IsServer() then return end
	local hParent = self:GetParent()
	if not hParent:HasModifier("modifier_tempest_double_illusion") then
		hParent:AddNewModifier(self.caster, self.ability, "modifier_tempest_double_hidden", {})
	end

	hParent:AddNoDraw()
	-- hParent:RemoveGesture(ACT_DOTA_DIE)
end