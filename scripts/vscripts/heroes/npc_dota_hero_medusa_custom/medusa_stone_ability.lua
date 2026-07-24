--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_medusa_stone_ability", "heroes/npc_dota_hero_medusa_custom/medusa_stone_ability", LUA_MODIFIER_MOTION_NONE)

medusa_stone_ability = class({})

function medusa_stone_ability:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_medusa_stone_ability", {duration = self:GetSpecialValueFor("duration")})
end

modifier_medusa_stone_ability = class({})

function modifier_medusa_stone_ability:IsPurgable() return false end
function modifier_medusa_stone_ability:IsPurgeException() return false end

function modifier_medusa_stone_ability:OnCreated()
	if not IsServer() then return end
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_medusa/medusa_stone_gaze_debuff_stoned.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector( 0,0,0 ), true )
	self:AddParticle( effect_cast, false, false, -1, false, false )
	EmitSoundOnClient( "Hero_Medusa.StoneGaze.Stun", self:GetParent():GetPlayerOwner() )
end


function modifier_medusa_stone_ability:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
    }
end

function modifier_medusa_stone_ability:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_medusa_stone_ability:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_medusa_stone_ability:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_medusa_stone_ability:CheckState()
	return
    {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_FROZEN] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
	}
end

function modifier_medusa_stone_ability:GetStatusEffectName()
	return "particles/status_fx/status_effect_medusa_stone_gaze.vpcf"
end

function modifier_medusa_stone_ability:StatusEffectPriority()
	return MODIFIER_PRIORITY_ULTRA
end