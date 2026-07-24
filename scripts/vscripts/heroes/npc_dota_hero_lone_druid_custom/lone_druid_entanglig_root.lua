--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lone_druid_entanglig_root", "heroes/npc_dota_hero_lone_druid_custom/lone_druid_entanglig_root", LUA_MODIFIER_MOTION_NONE)

lone_druid_entanglig_root = class({})

function lone_druid_entanglig_root:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_treant/treant_leech_seed_projectile.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_lone_druid/lone_druid_bear_entangle.vpcf", context )
end

function lone_druid_entanglig_root:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	self:GetCaster():StartGesture(ACT_DOTA_ATTACK)
    local info = {
        EffectName = "particles/units/heroes/hero_treant/treant_leech_seed_projectile.vpcf",
        Ability = self,
        iMoveSpeed = 1000,
        Source = self:GetCaster(),
        Target = target,
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2
    }
    ProjectileManager:CreateTrackingProjectile( info )
end

function lone_druid_entanglig_root:OnProjectileHit( target, vLocation )
    if not IsServer() then return end
    if target ~= nil and ( not target:IsMagicImmune() ) and ( not target:TriggerSpellAbsorb( self ) ) then
        target:AddNewModifier(self:GetCaster(), self, "modifier_lone_druid_entanglig_root", {duration = self:GetSpecialValueFor("duration") * (1 - target:GetStatusResistance())})
		target:EmitSound("LoneDruid_SpiritBear.Entangle")
    end
    return true
end

modifier_lone_druid_entanglig_root = class({})

function modifier_lone_druid_entanglig_root:CheckState()
	return {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true
	}
end

function modifier_lone_druid_entanglig_root:GetEffectName()
    return "particles/units/heroes/hero_lone_druid/lone_druid_bear_entangle.vpcf"
end

function modifier_lone_druid_entanglig_root:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_lone_druid_entanglig_root:DeclareFunctions()
	return {
		 
	}
end

function modifier_lone_druid_entanglig_root:OnAttackLanded(params)
	if params.target ~= self:GetParent() then return end
	self:Destroy()
end