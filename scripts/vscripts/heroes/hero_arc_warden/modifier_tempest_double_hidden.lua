--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tempest_double_hidden = class({})

function modifier_tempest_double_hidden:IsHidden() return true end
function modifier_tempest_double_hidden:IsPurgable() return false end

function modifier_tempest_double_hidden:OnCreated()
	if not IsServer() then return end
	local parent = self:GetParent()
	if not parent or parent:IsNull() then return end
	parent:Stop()
	parent:Interrupt()
	parent:InterruptChannel()
	parent:InterruptMotionControllers(true)
	parent:AddEffects(EF_NODRAW)
	parent:SetAbsOrigin(Vector(0, 0, -8000))
	parent:RemoveModifierByName("modifier_life_stealer_infest")
	parent:RemoveModifierByName("modifier_life_stealer_infest_enemy_hero")
	parent:RemoveModifierByName("modifier_life_stealer_infest_effect")
	parent:RemoveModifierByName("modifier_life_stealer_infest_creep")
    if parent:HasModifier("modifier_life_stealer_infest_effect") then
        local modifier = parent:FindModifierByName("modifier_life_stealer_infest_effect")
        local hInfester =  modifier:GetCaster()
        hInfester:RemoveModifierByName("modifier_life_stealer_infest")
        local ability = hInfester:FindAbilityByName("life_stealer_consume")
        if ability then
       	    ability:OnSpellStart()
        end
    end
end

function modifier_tempest_double_hidden:OnDestroy()
	if not IsServer() then return end
	local parent = self:GetParent()
	if not parent or parent:IsNull() then return end
	parent:RemoveEffects(EF_NODRAW)
end

function modifier_tempest_double_hidden:DeclareFunctions() 
    return
    {
        MODIFIER_PROPERTY_TEMPEST_DOUBLE
    }
end

function modifier_tempest_double_hidden:GetModifierTempestDouble( params )
    return 1
end

function modifier_tempest_double_hidden:CheckState()
	return 
    {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_BLIND] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}
end