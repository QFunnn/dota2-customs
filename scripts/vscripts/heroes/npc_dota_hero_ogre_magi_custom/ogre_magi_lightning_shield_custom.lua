--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ogre_magi_lightning_shield_custom_buff", "heroes/npc_dota_hero_ogre_magi_custom/ogre_magi_lightning_shield_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ogre_magi_lightning_shield_custom_spell_amp", "heroes/npc_dota_hero_ogre_magi_custom/ogre_magi_lightning_shield_custom", LUA_MODIFIER_MOTION_NONE)

ogre_magi_lightning_shield_custom = class({})

ogre_magi_lightning_shield_custom.modifier_ogre_magi_19_damage = {36,72}
ogre_magi_lightning_shield_custom.modifier_ogre_magi_20_duration = {4,6}
ogre_magi_lightning_shield_custom.modifier_ogre_magi_20_pct_per_100_mana = 2

function ogre_magi_lightning_shield_custom:Precache(context)
    PrecacheResource("particle", "particles/ogre_magi_shield/ogre_magi_shield.vpcf", context)
    PrecacheResource("particle", "particles/ogre_magi_shield/shield_amb.vpcf", context)
    PrecacheResource("particle", "particles/ogre_magi_shield_electr/ogre_magi_shield_electr.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_zuus/zuus_arc_lightning.vpcf", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts", context)
end

function ogre_magi_lightning_shield_custom:OnSpellStart(new_target)
    if not IsServer() then return end
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    if new_target then
        target = new_target
    end
    if not target then return end
    target:EmitSound("Hero_OgreMagi.FireShield.Target")
    target:AddNewModifier(caster, self, "modifier_ogre_magi_lightning_shield_custom_buff", {duration = self:GetSpecialValueFor("duration")})
end

modifier_ogre_magi_lightning_shield_custom_buff = class({})
function modifier_ogre_magi_lightning_shield_custom_buff:IsHidden() return false end

function modifier_ogre_magi_lightning_shield_custom_buff:OnCreated()
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()
    self.radius = self.ability:GetSpecialValueFor("radius")
    self.interval = 1
    if not IsServer() then return end
    self.damageTable = {attacker = self.caster, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability}
    self:StartIntervalThink(self.interval)

    local particle_3 = ParticleManager:CreateParticle("particles/ogre_magi_shield_electr/ogre_magi_shield_electr.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt(particle_3, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
    self:AddParticle(particle_3, false, false, -1, false, false)
end

function modifier_ogre_magi_lightning_shield_custom_buff:OnIntervalThink()
    if not IsServer() then return end
    local damage_per_second = self:GetAbility():GetSpecialValueFor("damage_per_second")
    local enemies = FindUnitsInRadius(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    self.damageTable.damage = damage_per_second * self.interval
    for _, enemy in pairs(enemies) do
        self.damageTable.victim = enemy
        ApplyDamage(self.damageTable)
        self.lightning_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_arc_lightning.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
        ParticleManager:SetParticleControlEnt(self.lightning_particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
        ParticleManager:SetParticleControlEnt(self.lightning_particle, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
        ParticleManager:ReleaseParticleIndex(self.lightning_particle)
        enemy:EmitSound("Hero_Zuus.ArcLightning.Target")
    end
end

function modifier_ogre_magi_lightning_shield_custom_buff:OnAbilityFullyCast(params)
    if not IsServer() then return end
    if params.unit ~= self.parent then return end
    if not self.caster:HasModifier("modifier_ogre_magi_20") then return end
    local ability = params.ability
    if not ability or ability:IsItem() then return end
    local mana = ability:GetEffectiveManaCost(ability:GetLevel()) or 0
    if mana <= 0 then return end
    local spell_amplify = (mana / 100) * self.ability.modifier_ogre_magi_20_pct_per_100_mana
    self.parent:AddNewModifier(self.caster, self.ability, "modifier_ogre_magi_lightning_shield_custom_spell_amp", {duration = self.ability.modifier_ogre_magi_20_duration[self.caster:GetTalentLevel("modifier_ogre_magi_20")], spell_amplify = spell_amplify})
end

modifier_ogre_magi_lightning_shield_custom_spell_amp = class({})
function modifier_ogre_magi_lightning_shield_custom_spell_amp:IsHidden() return false end
function modifier_ogre_magi_lightning_shield_custom_spell_amp:IsPurgable() return false end
function modifier_ogre_magi_lightning_shield_custom_spell_amp:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_ogre_magi_lightning_shield_custom_spell_amp:GetTexture() return "ogre_magi_20" end

function modifier_ogre_magi_lightning_shield_custom_spell_amp:OnCreated(params)
    if not IsServer() then return end
    self.spell_amplify = params.spell_amplify
    self:SetHasCustomTransmitterData(true)
end

function modifier_ogre_magi_lightning_shield_custom_spell_amp:AddCustomTransmitterData() 
	return 
	{
		spell_amplify = self.spell_amplify,
	} 
end

function modifier_ogre_magi_lightning_shield_custom_spell_amp:HandleCustomTransmitterData(data)
	self.spell_amplify  = data.spell_amplify
end


function modifier_ogre_magi_lightning_shield_custom_spell_amp:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
    }
end

function modifier_ogre_magi_lightning_shield_custom_spell_amp:GetModifierSpellAmplify_Percentage()
    return self.spell_amplify or 0
end