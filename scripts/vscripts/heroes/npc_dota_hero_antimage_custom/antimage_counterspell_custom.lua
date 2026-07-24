--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_antimage_counterspell_custom", "heroes/npc_dota_hero_antimage_custom/antimage_counterspell_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_antimage_counterspell_custom_active", "heroes/npc_dota_hero_antimage_custom/antimage_counterspell_custom", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier( "modifier_antimage_counterspell_aura_9", "heroes/npc_dota_hero_antimage_custom/antimage_counterspell_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_antimage_counterspell_aura_9_debuff", "heroes/npc_dota_hero_antimage_custom/antimage_counterspell_custom", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier( "modifier_antimage_counterspell_aura_10", "heroes/npc_dota_hero_antimage_custom/antimage_counterspell_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_antimage_counterspell_aura_10_debuff", "heroes/npc_dota_hero_antimage_custom/antimage_counterspell_custom", LUA_MODIFIER_MOTION_NONE )

antimage_counterspell_custom = class({})

function antimage_counterspell_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_antimage/antimage_counter.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_antimage/antimage_spellshield_reflect.vpcf', context )
end

antimage_counterspell_custom.modifier_antimage_8_duration = {3,6,9}
antimage_counterspell_custom.modifier_antimage_8_damage_out = 25
antimage_counterspell_custom.modifier_antimage_8_damage_in = 250 

antimage_counterspell_custom.modifier_antimage_9_spell = {-5,-10}
antimage_counterspell_custom.modifier_antimage_9_radius = 900

antimage_counterspell_custom.modifier_antimage_10_spell = {-10,-20}
antimage_counterspell_custom.modifier_antimage_10 = 300

antimage_counterspell_custom.modifier_antimage_11_duration = {3,6,9}
antimage_counterspell_custom.modifier_antimage_11_damage_out = 25
antimage_counterspell_custom.modifier_antimage_11_damage_in = 250 

function antimage_counterspell_custom:OnSpellStart(target)
    if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():EmitSound("Hero_Antimage.Counterspell.Cast")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_antimage_counterspell_custom_active", {duration = duration})
    if self:GetCaster():HasModifier("modifier_antimage_6") then
        self:GetCaster():Purge(false, true, false, true, true)
    end

    if self:GetCaster():HasModifier("modifier_antimage_8") then
        local damage_out = self.modifier_antimage_8_damage_out - 100
        local damage_inc = self.modifier_antimage_8_damage_in - 100
        local t = CreateIllusions( self:GetCaster(), self:GetCaster(), {duration = self.modifier_antimage_8_duration[self:GetCaster():GetTalentLevel("modifier_antimage_8")], outgoing_damage=damage_out, incoming_damage = damage_inc}, 1, 100, false, false ) 
        if t and t[1] then
            FindClearSpaceForUnit(t[1], self:GetCaster():GetAbsOrigin(), true)
        end
    end

    local illusions = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
    for _, ill in pairs(illusions) do
        if ill:HasModifier("modifier_antimage_mana_overload_custom_illusion") then
            local duration = self:GetSpecialValueFor("duration")
            ill:EmitSound("Hero_Antimage.Counterspell.Cast")
            ill:AddNewModifier(self:GetCaster(), self, "modifier_antimage_counterspell_custom_active", {duration = duration})
            if self:GetCaster():HasModifier("modifier_antimage_6") then
                ill:Purge(false, true, false, true, true)
            end

            if self:GetCaster():HasModifier("modifier_antimage_8") then
                local damage_out = self.modifier_antimage_8_damage_out - 100
                local damage_inc = self.modifier_antimage_8_damage_in - 100
                local t = CreateIllusions( self:GetCaster(), self:GetCaster(), {duration = self.modifier_antimage_8_duration[self:GetCaster():GetTalentLevel("modifier_antimage_8")], outgoing_damage=damage_out, incoming_damage = damage_inc}, 1, 100, false, false ) 
                if t and t[1] then
                    FindClearSpaceForUnit(t[1], ill:GetAbsOrigin(), true)
                end
            end
        end
    end
end

function antimage_counterspell_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_antimage_7") then
        return DOTA_ABILITY_BEHAVIOR_PASSIVE
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end

function antimage_counterspell_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_antimage_7") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, level)
end


function antimage_counterspell_custom:GetIntrinsicModifierName()
	return "modifier_antimage_counterspell_custom"
end

modifier_antimage_counterspell_custom = class({})

function modifier_antimage_counterspell_custom:IsHidden() 
    return true
end

function modifier_antimage_counterspell_custom:IsPurgable() return false end

function modifier_antimage_counterspell_custom:OnCreated()
    if IsServer() then
        self:GetParent().tOldSpells = {}
        self:StartIntervalThink(FrameTime())
    end
end

function modifier_antimage_counterspell_custom:OnIntervalThink()
    if IsServer() then

        if self:GetCaster():HasModifier("modifier_antimage_7") then
            if self:GetAbility():IsFullyCastable() then
                if self:GetParent():IsAlive() and not self:GetParent():HasModifier("modifier_wodarelax") and not self:GetParent():HasModifier("modifier_wodawisp") then
                    self:GetAbility():OnSpellStart()
                    self:GetAbility():UseResources(false, false, false, true)
                end
            end
        end

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
                print("удаляю", hSpell:GetAbilityName())
                hSpell:RemoveSelf()
                table.remove(caster.tOldSpells,i)
            end
        end
    end
end

function modifier_antimage_counterspell_custom:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
    }
end

function modifier_antimage_counterspell_custom:GetModifierMagicalResistanceBonus()
    return self:GetAbility():GetSpecialValueFor("magic_resistance")
end

modifier_antimage_counterspell_custom_active = class({})

function modifier_antimage_counterspell_custom_active:OnCreated()
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_antimage/antimage_counter.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true )
	ParticleManager:SetParticleControl(particle, 1, Vector(100,0,0))
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_antimage_counterspell_custom_active:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_REFLECT_SPELL,
		MODIFIER_PROPERTY_ABSORB_SPELL,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
	return funcs
end

function modifier_antimage_counterspell_custom_active:GetAbsorbSpell( params )
	if not IsServer() then return end
    if self:GetParent():GetTeamNumber() == params.ability:GetCaster():GetTeamNumber() then
        return nil
    end
	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_antimage/antimage_spellshield_reflect.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
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

function modifier_antimage_counterspell_custom_active:GetReflectSpell( params )
    if not IsServer() then return 0 end
    if self:GetCaster():HasModifier("modifier_antimage_11") then
        local damage_out = self:GetAbility().modifier_antimage_11_damage_out - 100
        local damage_inc = self:GetAbility().modifier_antimage_11_damage_in - 100
        local t = CreateIllusions( self:GetCaster(), self:GetCaster(), {duration = self:GetAbility().modifier_antimage_11_duration[self:GetCaster():GetTalentLevel("modifier_antimage_11")], outgoing_damage=damage_out, incoming_damage = damage_inc}, 1, 100, false, false ) 
        if t and t[1] then
            FindClearSpaceForUnit(t[1], params.ability:GetCaster():GetAbsOrigin(), true)
        end
    end
	return SpellReflect(self:GetParent(), params)
end

modifier_antimage_counterspell_aura_9 = class({})

function modifier_antimage_counterspell_aura_9:IsHidden() return true end
function modifier_antimage_counterspell_aura_9:RemoveOnDeath() return false end
function modifier_antimage_counterspell_aura_9:IsPurgable() return false end

function modifier_antimage_counterspell_aura_9:IsAura()
    return true
end

function modifier_antimage_counterspell_aura_9:GetModifierAura()
    return "modifier_antimage_counterspell_aura_9_debuff"
end

function modifier_antimage_counterspell_aura_9:GetAuraRadius()
    return self:GetAbility().modifier_antimage_9_radius
end

function modifier_antimage_counterspell_aura_9:GetAuraDuration()
    return 0.5
end

function modifier_antimage_counterspell_aura_9:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_antimage_counterspell_aura_9:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_antimage_counterspell_aura_9:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end




modifier_antimage_counterspell_aura_10 = class({})

function modifier_antimage_counterspell_aura_10:IsHidden() return true end
function modifier_antimage_counterspell_aura_10:RemoveOnDeath() return false end
function modifier_antimage_counterspell_aura_10:IsPurgable() return false end

function modifier_antimage_counterspell_aura_10:IsAura()
    return true
end

function modifier_antimage_counterspell_aura_10:GetModifierAura()
    return "modifier_antimage_counterspell_aura_10_debuff"
end

function modifier_antimage_counterspell_aura_10:GetAuraRadius()
    return self:GetAbility().modifier_antimage_10
end

function modifier_antimage_counterspell_aura_10:GetAuraDuration()
    return 0.5
end

function modifier_antimage_counterspell_aura_10:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_antimage_counterspell_aura_10:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_antimage_counterspell_aura_10:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

modifier_antimage_counterspell_aura_9_debuff = class({})

function modifier_antimage_counterspell_aura_9_debuff:IsPurgable() return false end

function modifier_antimage_counterspell_aura_9_debuff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
    }
end

function modifier_antimage_counterspell_aura_9_debuff:GetModifierSpellAmplify_Percentage()
    return self:GetAbility().modifier_antimage_9_spell[self:GetCaster():GetTalentLevel("modifier_antimage_9")]
end

modifier_antimage_counterspell_aura_10_debuff = class({})

function modifier_antimage_counterspell_aura_10_debuff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
    }
end

function modifier_antimage_counterspell_aura_10_debuff:GetModifierSpellAmplify_Percentage()
    return self:GetAbility().modifier_antimage_10_spell[self:GetCaster():GetTalentLevel("modifier_antimage_10")]
end