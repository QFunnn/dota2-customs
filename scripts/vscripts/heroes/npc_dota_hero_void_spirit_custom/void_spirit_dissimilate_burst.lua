--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_void_spirit_dissimilate_burst", "heroes/npc_dota_hero_void_spirit_custom/void_spirit_dissimilate_burst", LUA_MODIFIER_MOTION_NONE)

void_spirit_dissimilate_burst = class({})

function void_spirit_dissimilate_burst:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function void_spirit_dissimilate_burst:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local void_spirit_dissimilate_custom = self:GetCaster():FindAbilityByName("void_spirit_dissimilate_custom")
    if not void_spirit_dissimilate_custom then return end
    local delay = self:GetSpecialValueFor("delay")
    CreateModifierThinker(self:GetCaster(), self, "modifier_void_spirit_dissimilate_burst", {duration = delay}, point, self:GetCaster():GetTeamNumber(), false)
end

modifier_void_spirit_dissimilate_burst = class({})

function modifier_void_spirit_dissimilate_burst:OnCreated()
    if not IsServer() then return end
    self.void_spirit_dissimilate_custom = self:GetCaster():FindAbilityByName("void_spirit_dissimilate_custom")
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    local radius = self.radius + 25
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate.vpcf", PATTACH_WORLDORIGIN, self:GetParent())
	ParticleManager:SetParticleControl( effect_cast, 0, GetGroundPosition(self:GetParent():GetAbsOrigin(), self:GetParent()) )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, 0, 1 ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( 1, 0, 0 ) )
	self:AddParticle( effect_cast, false, false, -1, false, false )
    EmitSoundOnLocationWithCaster( self:GetParent():GetAbsOrigin(), "Hero_VoidSpirit.Dissimilate.Portals", self:GetCaster() )
end

function modifier_void_spirit_dissimilate_burst:OnDestroy()
    if not IsServer() then return end
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate_dmg.vpcf", PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetAbsOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( 183, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
    self:GetParent():EmitSound("Hero_VoidSpirit.Dissimilate.TeleportIn")
    local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    local damage = self.void_spirit_dissimilate_custom:GetSpecialValueFor("damage")
    local damage_percent = self:GetAbility():GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_void_spirit_18") then
        damage = damage + self:GetCaster():GetMana() / 100 * self.void_spirit_dissimilate_custom.modifier_void_spirit_18[self:GetCaster():GetTalentLevel("modifier_void_spirit_18")]
    end
    damage = damage / 100 * damage_percent
    for _,enemy in pairs(enemies) do
        local deal_damage = damage
        ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = deal_damage, damage_type = self.void_spirit_dissimilate_custom:GetAbilityDamageType(), ability = self.void_spirit_dissimilate_custom})
        if self:GetCaster():HasModifier("modifier_void_spirit_20") then
            local modifier_rooted = enemy:AddNewModifier(self:GetCaster(), self.void_spirit_dissimilate_custom, "modifier_rooted", {duration = self.void_spirit_dissimilate_custom.modifier_void_spirit_20[self:GetCaster():GetTalentLevel("modifier_void_spirit_20")] * (1-enemy:GetStatusResistance())})
            if modifier_rooted then
                local pfx = ParticleManager:CreateParticle("particles/void_custom/oracle_fortune_purge_root_pnt.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
                modifier_rooted:AddParticle(pfx, false, false, -1, false, false)
            end
        end
    end
end




