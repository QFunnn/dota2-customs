--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_abaddon_borrowed_time_custom", "heroes/npc_dota_hero_abaddon_custom/abaddon_borrowed_time_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_abaddon_borrowed_time_custom_buff", "heroes/npc_dota_hero_abaddon_custom/abaddon_borrowed_time_custom", LUA_MODIFIER_MOTION_NONE)

abaddon_borrowed_time_custom = class({})

abaddon_borrowed_time_custom.modifier_abaddon_6 = {500,1000}
abaddon_borrowed_time_custom.modifier_abaddon_5 = {30,45,60}

function abaddon_borrowed_time_custom:GetIntrinsicModifierName()
    return "modifier_abaddon_borrowed_time_custom"
end

function abaddon_borrowed_time_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():Purge(false, true, false, true, true)
    self:GetCaster():EmitSound("Hero_Abaddon.BorrowedTime")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_abaddon_borrowed_time_custom_buff", {duration = duration})
    if self:GetCaster():HasModifier("modifier_abaddon_6") then
        local abaddon_death_coil_custom = self:GetCaster():FindAbilityByName("abaddon_death_coil_custom")
        if abaddon_death_coil_custom and abaddon_death_coil_custom:GetLevel() > 0 then
            local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self.modifier_abaddon_6[self:GetCaster():GetTalentLevel("modifier_abaddon_6")], DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
            for _, unit in pairs(units) do
                abaddon_death_coil_custom:CastTarget(unit)
            end
        end
    end
end

modifier_abaddon_borrowed_time_custom = class({})
function modifier_abaddon_borrowed_time_custom:IsHidden() return true end
function modifier_abaddon_borrowed_time_custom:IsPurgeException() return false end
function modifier_abaddon_borrowed_time_custom:IsPurgable() return false end
function modifier_abaddon_borrowed_time_custom:RemoveOnDeath() return false end
function modifier_abaddon_borrowed_time_custom:DeclareFunctions()
    return
    {
         
    }
end

function modifier_abaddon_borrowed_time_custom:OnTakeDamage(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if params.damage <= 0 then return end
    if self:GetParent():IsIllusion() then return end
    if self:GetParent():PassivesDisabled() then return end
    if self:GetParent():GetHealth() <= 0 then return end
    if (self:GetParent():GetHealth() <= self:GetAbility():GetSpecialValueFor("hp_threshold")) and self:GetAbility():IsFullyCastable() then
        self:GetAbility():OnSpellStart()
        self:GetAbility():UseResources(false, false, false, true)
    end
end

modifier_abaddon_borrowed_time_custom_buff = class({})
function modifier_abaddon_borrowed_time_custom_buff:IsPurgable() return false end
function modifier_abaddon_borrowed_time_custom_buff:IsPurgeException() return false end
function modifier_abaddon_borrowed_time_custom_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
         
    }
end

function modifier_abaddon_borrowed_time_custom_buff:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_abaddon_borrowed_time_custom_buff:GetAbsoluteNoDamagePhysical(params)
    self:HealHero(params)
    return 1
end

function modifier_abaddon_borrowed_time_custom_buff:GetAbsoluteNoDamageMagical(params)
    self:HealHero(params)
    return 1
end

function modifier_abaddon_borrowed_time_custom_buff:GetAbsoluteNoDamagePure(params)
    self:HealHero(params)
    return 1
end

function modifier_abaddon_borrowed_time_custom_buff:HealHero(params)
    if not IsServer() then return end
    if params.damage <= 0 then return end
    local particle_heal = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_borrowed_time_heal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle_heal, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(particle_heal, 1, params.attacker:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle_heal)
    self:GetParent():Heal(params.damage, self:GetAbility())
end

function modifier_abaddon_borrowed_time_custom_buff:OnTakeDamage(params)
	if not IsServer() then return end
    if not self:GetCaster():HasModifier("modifier_abaddon_5") then return end
	local attacker = params.attacker
	local target = params.unit
	local original_damage = params.original_damage
	local damage_type = params.damage_type
	local damage_flags = params.damage_flags
	if params.unit == self:GetParent() and not params.attacker:IsBuilding() and params.attacker:GetTeamNumber() ~= self:GetParent():GetTeamNumber() and bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) ~= DOTA_DAMAGE_FLAG_HPLOSS and bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) ~= DOTA_DAMAGE_FLAG_REFLECTION and not attacker:IsMagicImmune() then	
		if not params.unit:IsOther() then
			EmitSoundOnClient("DOTA_Item.BladeMail.Damage", params.attacker:GetPlayerOwner())
			ApplyDamage({ victim = params.attacker, damage = params.original_damage / 100 * self:GetAbility().modifier_abaddon_5[self:GetCaster():GetTalentLevel("modifier_abaddon_5")], damage_type = params.damage_type, damage_flags = DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, attacker = self:GetParent(), ability = nil })
		end
	end
end