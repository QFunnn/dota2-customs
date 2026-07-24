--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_woda_neutral_last_will_custom", "neutrals/woda_neutral_last_will_custom", LUA_MODIFIER_MOTION_NONE )

woda_neutral_last_will_custom = class({})

function woda_neutral_last_will_custom:GetIntrinsicModifierName()
	return "modifier_woda_neutral_last_will_custom"
end

modifier_woda_neutral_last_will_custom = class({})
function modifier_woda_neutral_last_will_custom:IsPurgable() return false end
function modifier_woda_neutral_last_will_custom:IsHidden() return true end
function modifier_woda_neutral_last_will_custom:IsPurgeException() return false end
function modifier_woda_neutral_last_will_custom:RemoveOnDeath() return false end
function modifier_woda_neutral_last_will_custom:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_DEATH,
    }
end
function modifier_woda_neutral_last_will_custom:OnDeath(params)
	if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    local damage = self:GetCaster():GetMaxHealth() / 100 * self:GetAbility():GetSpecialValueFor("damage")
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self:GetAbility():GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _, enemy in pairs(enemies) do
		ApplyDamage({attacker = self:GetCaster(), victim = enemy, ability = self:GetAbility(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
		local particle = ParticleManager:CreateParticle("particles/items_fx/necronomicon_warrior_last_will.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent())
		ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(particle, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(particle)
	end
end