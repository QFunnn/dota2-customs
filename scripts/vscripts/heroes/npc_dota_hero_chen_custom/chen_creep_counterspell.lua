--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_chen_creep_counterspell", "heroes/npc_dota_hero_chen_custom/chen_creep_counterspell", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_chen_creep_counterspell_active", "heroes/npc_dota_hero_chen_custom/chen_creep_counterspell", LUA_MODIFIER_MOTION_NONE )

chen_creep_counterspell = class({})

function chen_creep_counterspell:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_antimage.vsndevts", context )
    PrecacheResource( "particle", 'particles/creep_particles/creep_counter.vpcf', context )
    PrecacheResource( "particle", 'particles/creep_particles/creep_reflect.vpcf', context )
end

function chen_creep_counterspell:OnSpellStart(target)
    if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():EmitSound("Hero_Antimage.Counterspell.Cast")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_chen_creep_counterspell_active", {duration = duration})

    local illusions = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
    for _, ill in pairs(illusions) do
        local modifier_illusion = ill:FindModifierByName("modifier_illusion")
        if modifier_illusion and modifier_illusion:GetCaster() == self:GetCaster() then
            ill:EmitSound("Hero_Antimage.Counterspell.Cast")
            ill:AddNewModifier(self:GetCaster(), self, "modifier_chen_creep_counterspell_active", {duration = duration})
        end
    end
end

function chen_creep_counterspell:GetIntrinsicModifierName()
	return "modifier_chen_creep_counterspell"
end

modifier_chen_creep_counterspell = class({})

function modifier_chen_creep_counterspell:IsHidden() 
    return true
end

function modifier_chen_creep_counterspell:IsPurgable() return false end

function modifier_chen_creep_counterspell:OnCreated()
    if IsServer() then
        self:GetParent().tOldSpells = {}
        self:StartIntervalThink(FrameTime())
    end
end

function modifier_chen_creep_counterspell:OnIntervalThink()
    if IsServer() then
        local caster = self:GetParent()
        for i=#caster.tOldSpells,1,-1 do
            local hSpell = caster.tOldSpells[i]
            if hSpell:GetIntrinsicModifierName() ~= nil then
                local modifier_intrinsic = caster:FindModifierByName(hSpell:GetIntrinsicModifierName())
                if modifier_intrinsic and hSpell:GetName() ~= "item_gungir" then
                    modifier_intrinsic:Destroy()
                end
            end
            if hSpell:NumModifiersUsingAbility() <= -1 and not hSpell:IsChanneling() then
                hSpell:RemoveSelf()
                table.remove(caster.tOldSpells,i)
            end
        end
    end
end

function modifier_chen_creep_counterspell:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
    }
end

function modifier_chen_creep_counterspell:GetModifierMagicalResistanceBonus()
    return self:GetAbility():GetSpecialValueFor("magic_resistance")
end

modifier_chen_creep_counterspell_active = class({})

function modifier_chen_creep_counterspell_active:OnCreated()
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle( "particles/creep_particles/creep_counter.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true )
	ParticleManager:SetParticleControl(particle, 1, Vector(100,0,0))
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_chen_creep_counterspell_active:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_REFLECT_SPELL,
		MODIFIER_PROPERTY_ABSORB_SPELL,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
	return funcs
end

function modifier_chen_creep_counterspell_active:GetAbsorbSpell( params )
	if not IsServer() then return end
    if self:GetParent():GetTeamNumber() == params.ability:GetCaster():GetTeamNumber() then
        return nil
    end
	local particle = ParticleManager:CreateParticle( "particles/creep_particles/creep_reflect.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex( particle )
	self:GetParent():EmitSound("Hero_Antimage.SpellShield.Reflect")
	return 1
end

local function SpellReflect(parent, params)
    local reflected_spell_name = params.ability:GetAbilityName()
    local target = params.ability:GetCaster()

    if reflected_spell_name == "tidehunter_dead_in_the_water" then return end
    target:EmitSound("Hero_Antimage.Counterspell.Target")

    if target:GetTeamNumber() == parent:GetTeamNumber() then
        return nil
    end

    if target:HasModifier("modifier_item_lotus_orb_active") then
        return nil
    end

    if target:HasModifier("modifier_item_mirror_shield") then
        return nil
    end

    if params.ability.spell_shield_reflect then
        return nil
    end

    local old_spell = false
    for _,hSpell in pairs(parent.tOldSpells) do
        if hSpell ~= nil and hSpell:GetAbilityName() == reflected_spell_name then
            old_spell = true
            break
        end
    end

    local has_this_spell = parent:FindAbilityByName(reflected_spell_name)

    if old_spell or (has_this_spell and not has_this_spell:IsStolen()) then
        ability = parent:FindAbilityByName(reflected_spell_name)
    else
        ability = parent:AddAbility(reflected_spell_name)
        ability:SetStolen(true)
        ability:SetHidden(true)
        ability.spell_shield_reflect = true
        ability:SetRefCountsModifiers(true)
        if ability:GetIntrinsicModifierName() ~= nil then
            local modifier_intrinsic = parent:FindModifierByName(ability:GetIntrinsicModifierName())
            if modifier_intrinsic and ability:GetName() ~= "item_gungir" then
                modifier_intrinsic:Destroy()
            end
        end
        table.insert(parent.tOldSpells, ability)
    end

    ability:SetLevel(params.ability:GetLevel())
    parent:SetCursorCastTarget(target)
    ability:OnSpellStart()

    if ability.OnChannelFinish then
        ability:OnChannelFinish(false)
    end

    return false
end

function modifier_chen_creep_counterspell_active:GetReflectSpell( params )
    if not IsServer() then return 0 end
	return SpellReflect(self:GetParent(), params)
end