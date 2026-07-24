--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_keeper_of_the_light_blinding_light_custom_debuff", "heroes/npc_dota_hero_keeper_of_the_light_custom/keeper_of_the_light_blinding_light_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )

keeper_of_the_light_blinding_light_custom = class({})
keeper_of_the_light_blinding_light_custom.modifier_keeper_of_the_light_1 = {120,180}
keeper_of_the_light_blinding_light_custom.modifier_keeper_of_the_light_18 = {25,50}
keeper_of_the_light_blinding_light_custom.modifier_keeper_of_the_light_18_damage = {90,180}

function keeper_of_the_light_blinding_light_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function keeper_of_the_light_blinding_light_custom:OnSpellStart()
    local point = self:GetCursorPosition()
    local duration = self:GetSpecialValueFor("duration")
    local radius = self:GetSpecialValueFor("radius")
    local knockback_duration = self:GetSpecialValueFor("knockback_duration")
    local knockback_distance = self:GetSpecialValueFor("knockback_distance")
    local damage = self:GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_18") then
        damage = damage + self.modifier_keeper_of_the_light_18_damage[self:GetCaster():GetTalentLevel("modifier_keeper_of_the_light_18")]
    end
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_1") then
        damage = damage + (self:GetCaster():GetStrength() / 100 * self.modifier_keeper_of_the_light_1[self:GetCaster():GetTalentLevel("modifier_keeper_of_the_light_1")])
    end

    EmitSoundOnLocationWithCaster(point, "Hero_KeeperOfTheLight.BlindingLight", self:GetCaster())

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_blinding_light_aoe.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, point)
	ParticleManager:SetParticleControl(particle, 1, point)
	ParticleManager:SetParticleControl(particle, 2, Vector(radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)

    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)	
    for _, enemy in pairs(enemies) do
        ApplyDamage({victim = enemy, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetCaster(), ability = self})
        local direction = enemy:GetAbsOrigin() - point
        direction.z = 0
        direction = direction:Normalized()
        enemy:AddNewModifier(self:GetCaster(), self, "modifier_keeper_of_the_light_blinding_light_custom_debuff", {duration = duration * (1 - enemy:GetStatusResistance())})
        enemy:AddNewModifier(self:GetCaster(), self, "modifier_generic_knockback_lua", {duration = knockback_duration, distance = knockback_distance, direction_x = direction.x, direction_y = direction.y})
    end
end

modifier_keeper_of_the_light_blinding_light_custom_debuff = class({})

function modifier_keeper_of_the_light_blinding_light_custom_debuff:GetEffectName()
	return "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_blinding_light_debuff.vpcf"
end

function modifier_keeper_of_the_light_blinding_light_custom_debuff:OnCreated()
	self.ability	= self:GetAbility()
	self.miss_rate	= self.ability:GetSpecialValueFor("miss_rate")
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_18") then
        self.miss_rate = self.miss_rate + self:GetAbility().modifier_keeper_of_the_light_18[self:GetCaster():GetTalentLevel("modifier_keeper_of_the_light_18")]
    end
end

function modifier_keeper_of_the_light_blinding_light_custom_debuff:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MISS_PERCENTAGE
    }
end

function modifier_keeper_of_the_light_blinding_light_custom_debuff:GetModifierMiss_Percentage()
    return self.miss_rate
end