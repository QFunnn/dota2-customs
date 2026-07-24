--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skeleton_king_reincarnation_custom_damage_buff", "heroes/npc_dota_hero_skeleton_king_custom/skeleton_king_reincarnation_blink", LUA_MODIFIER_MOTION_NONE)

skeleton_king_reincarnation_blink = class({})

skeleton_king_reincarnation_blink.modifier_skeleton_king_5 = {26,18}
skeleton_king_reincarnation_blink.modifier_skeleton_king_4 = {10,20,30}
skeleton_king_reincarnation_blink.modifier_skeleton_king_4_duration = 4

function skeleton_king_reincarnation_blink:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()

    local direction = (point - self:GetCaster():GetAbsOrigin())
	direction.z = 0

    local particle_start = ParticleManager:CreateParticle( "particles/wraith_king_blink_effect.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( particle_start, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControlForward( particle_start, 0, direction:Normalized() )
	ParticleManager:ReleaseParticleIndex( particle_start )

    ProjectileManager:ProjectileDodge(self:GetCaster())

    FindClearSpaceForUnit(self:GetCaster(), point, true)
    self:GetCaster():EmitSound("DOTA_Item.BlinkDagger.Activate")
    self:GetCaster():EmitSound("DOTA_Item.Overwhelming_Blink.Activate")

	local particle_end = ParticleManager:CreateParticle( "particles/econ/events/ti10/blink_dagger_end_ti10.vpcf", PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( particle_end, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControlForward( particle_end, 0, direction:Normalized() )
	ParticleManager:ReleaseParticleIndex( particle_end )

    local skeleton_king_hellfire_blast_custom = self:GetCaster():FindAbilityByName("skeleton_king_hellfire_blast_custom")
    if skeleton_king_hellfire_blast_custom then
        skeleton_king_hellfire_blast_custom:EndCooldown()
    end

    if self:GetCaster():HasModifier("modifier_skeleton_king_4") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_skeleton_king_reincarnation_custom_damage_buff", {duration = self.modifier_skeleton_king_4_duration})
    end
end

modifier_skeleton_king_reincarnation_custom_damage_buff = class({})

function modifier_skeleton_king_reincarnation_custom_damage_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
    }
end

function modifier_skeleton_king_reincarnation_custom_damage_buff:GetModifierTotalDamageOutgoing_Percentage()
    return self:GetAbility().modifier_skeleton_king_4[self:GetCaster():GetTalentLevel("modifier_skeleton_king_4")]
end

function modifier_skeleton_king_reincarnation_custom_damage_buff:GetEffectName()
    return "particles/wk_reincanartion_damage_buff.vpcf"
end