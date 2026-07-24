--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_naga_siren_rip_tide_custom", "heroes/npc_dota_hero_naga_siren_custom/naga_siren_rip_tide_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_naga_siren_rip_tide_custom_debuff", "heroes/npc_dota_hero_naga_siren_custom/naga_siren_rip_tide_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_naga_siren_rip_tide_custom_bonus_damage", "heroes/npc_dota_hero_naga_siren_custom/naga_siren_rip_tide_custom", LUA_MODIFIER_MOTION_NONE )

naga_siren_rip_tide_custom = class({})

naga_siren_rip_tide_custom.modifier_naga_siren_6 = {-2,-4}
naga_siren_rip_tide_custom.modifier_naga_siren_15 = {14,28}
naga_siren_rip_tide_custom.modifier_naga_siren_19 = {20,30,40}
naga_siren_rip_tide_custom.modifier_naga_siren_19_max_effects = 7
naga_siren_rip_tide_custom.modifier_naga_siren_19_max_effects_duration = 3

function naga_siren_rip_tide_custom:GetIntrinsicModifierName()
	return "modifier_naga_siren_rip_tide_custom"
end

modifier_naga_siren_rip_tide_custom = class({})
function modifier_naga_siren_rip_tide_custom:IsHidden() return self:GetStackCount() == 0 end
function modifier_naga_siren_rip_tide_custom:IsDebuff() return false end
function modifier_naga_siren_rip_tide_custom:IsPurgable() return false end

function modifier_naga_siren_rip_tide_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_naga_siren_rip_tide_custom:GetModifierProcAttack_Feedback( params )
	if not IsServer() then return end
	if self:GetParent():PassivesDisabled() then return end
    local attacker = self:GetParent()
    if self:GetParent():IsIllusion() then
        local modifier_illusion = self:GetParent():FindModifierByName("modifier_illusion")
        if modifier_illusion then
            attacker = modifier_illusion:GetCaster()
        end
    end
    local hits = self:GetAbility():GetSpecialValueFor( "hits" )
    local modifier_naga_siren_rip_tide_custom = attacker:FindModifierByName("modifier_naga_siren_rip_tide_custom")
    if not modifier_naga_siren_rip_tide_custom then return end
    modifier_naga_siren_rip_tide_custom:IncrementStackCount()
    if modifier_naga_siren_rip_tide_custom:GetStackCount() >= hits then
        modifier_naga_siren_rip_tide_custom:CastAoeAbility()
        modifier_naga_siren_rip_tide_custom:SetStackCount(0)
    end
end

function modifier_naga_siren_rip_tide_custom:CastAoeAbility()
    if not IsServer() then return end
    local radius = self:GetAbility():GetSpecialValueFor( "radius" )
    local duration = self:GetAbility():GetSpecialValueFor( "duration" )
    local units = {}
    table.insert(units, self:GetCaster())
    local illusions = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false )
    for _, illusion in pairs(illusions) do
        if illusion:IsIllusion() then
            local mod = illusion:FindModifierByName("modifier_illusion")
            if mod and mod:GetCaster() == self:GetCaster() then
                table.insert(units, illusion)
            end
        end
    end
    local targets = {}
    for _, unit in pairs(units) do
        self:PlayEffects(unit, radius)
        local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), unit:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
        for __, enemy in pairs(enemies) do
            if targets[enemy:entindex()] == nil then
                local damage = self:GetAbility():GetSpecialValueFor( "damage" )
                if self:GetCaster():HasModifier("modifier_naga_siren_15") then
                    damage = damage + self:GetAbility().modifier_naga_siren_15[self:GetCaster():GetTalentLevel("modifier_naga_siren_15")]
                end
                local modifier_naga_siren_rip_tide_custom_bonus_damage = enemy:FindModifierByName("modifier_naga_siren_rip_tide_custom_bonus_damage")
                if modifier_naga_siren_rip_tide_custom_bonus_damage then
                    damage = damage + (damage / 100 * (modifier_naga_siren_rip_tide_custom_bonus_damage:GetStackCount() * self:GetAbility().modifier_naga_siren_19[self:GetCaster():GetTalentLevel("modifier_naga_siren_19")]))
                end
                targets[enemy:entindex()] = enemy
                ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
                enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_naga_siren_rip_tide_custom_debuff", {duration = duration})
                if self:GetCaster():HasModifier("modifier_naga_siren_19") then
                    enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_naga_siren_rip_tide_custom_bonus_damage", {duration = self:GetAbility().modifier_naga_siren_19_max_effects_duration})
                end
            end
        end
    end
end

function modifier_naga_siren_rip_tide_custom:PlayEffects(parent, radius)
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_siren/naga_siren_riptide.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:SetParticleControl( effect_cast, 3, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	parent:EmitSound("Hero_NagaSiren.Riptide.Cast")
end

modifier_naga_siren_rip_tide_custom_debuff = class({})

function modifier_naga_siren_rip_tide_custom_debuff:OnCreated( kv )
	self.armor = self:GetAbility():GetSpecialValueFor( "armor_reduction" )
    if self:GetCaster():HasModifier("modifier_naga_siren_6") then
        self.armor = self.armor + self:GetAbility().modifier_naga_siren_6[self:GetCaster():GetTalentLevel("modifier_naga_siren_6")]
    end
end

function modifier_naga_siren_rip_tide_custom_debuff:OnRefresh( kv )
	self:OnCreated()
end

function modifier_naga_siren_rip_tide_custom_debuff:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_naga_siren_rip_tide_custom_debuff:GetModifierPhysicalArmorBonus()
	return self.armor
end

function modifier_naga_siren_rip_tide_custom_debuff:GetEffectName()
	return "particles/units/heroes/hero_siren/naga_siren_riptide_debuff.vpcf"
end

function modifier_naga_siren_rip_tide_custom_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_naga_siren_rip_tide_custom_bonus_damage = class({})
function modifier_naga_siren_rip_tide_custom_bonus_damage:GetTexture() return "naga_siren_19" end
function modifier_naga_siren_rip_tide_custom_bonus_damage:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(1)
    if self:GetParent():IsHero() then
        self.particle = ParticleManager:CreateParticle("particles/naga_siren_riptide_counterstack.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControl(self.particle, 1, Vector(0,self:GetStackCount(),0))
        self:AddParticle(self.particle, false, false, -1, false, false)
    end
end
function modifier_naga_siren_rip_tide_custom_bonus_damage:OnRefresh()
    if not IsServer() then return end
    if self:GetStackCount() < self:GetAbility().modifier_naga_siren_19_max_effects then
        self:IncrementStackCount()
    end
    if self.particle then
        ParticleManager:SetParticleControl(self.particle, 1, Vector(0,self:GetStackCount(),0))
    end
end