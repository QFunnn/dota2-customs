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
	return 
    {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
	}
end

function modifier_tempest_double_dying:OnCreated()
	if not IsServer() then return end
	local parent = self:GetParent()
	if not parent or parent:IsNull() then return end
    local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_arc_warden/arc_warden_death.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent )
	ParticleManager:SetParticleControlEnt(particle, 0, parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", parent:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(particle)
	parent:Interrupt()
	parent:InterruptChannel()
	parent:InterruptMotionControllers(true)
end

function modifier_tempest_double_dying:OnDestroy()
	if not IsServer() then return end
	local parent = self:GetParent()
	if self:GetCaster():HasAbility("life_stealer_consume") then
        local  hInfest = self:GetCaster():FindAbilityByName("life_stealer_consume")
        if hInfest and hInfest:IsFullyCastable() then
            ExecuteOrderFromTable({
                UnitIndex = self:GetCaster():entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
                AbilityIndex = hInfest:entindex(),
            })
        end
    end
	if not parent:HasModifier("modifier_tempest_double_illusion") then
		parent:AddNewModifier(self.caster, self.ability, "modifier_tempest_double_hidden", {})
	end
	parent:RemoveGesture(ACT_DOTA_DIE)
end