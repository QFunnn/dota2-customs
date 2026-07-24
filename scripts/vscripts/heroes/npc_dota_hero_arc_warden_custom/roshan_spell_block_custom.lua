--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_roshan_spell_block_custom", "heroes/npc_dota_hero_arc_warden_custom/roshan_spell_block_custom", LUA_MODIFIER_MOTION_NONE)

roshan_spell_block_custom = class({})

function roshan_spell_block_custom:GetIntrinsicModifierName()
    return "modifier_roshan_spell_block_custom"
end

modifier_roshan_spell_block_custom = class({})
function modifier_roshan_spell_block_custom:IsHidden() return true end
function modifier_roshan_spell_block_custom:IsPurgable() return false end
function modifier_roshan_spell_block_custom:IsPurgeException() return false end
function modifier_roshan_spell_block_custom:RemoveOnDeath() return false end

function modifier_roshan_spell_block_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ABSORB_SPELL,
        --MODIFIER_PROPERTY_REFLECT_SPELL,
        MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
    }
end

function modifier_roshan_spell_block_custom:GetModifierStatusResistanceStacking()
    return self:GetAbility():GetSpecialValueFor("status_resistance")
end

function modifier_roshan_spell_block_custom:OnCreated()
    if IsServer() then
        self:GetParent().tOldSpells = {}
        self:StartIntervalThink(FrameTime())
    end
end

function modifier_roshan_spell_block_custom:GetAbsorbSpell( params )
	if not IsServer() then return end
    if self:GetParent():GetTeamNumber() == params.ability:GetCaster():GetTeamNumber() then
        return nil
    end
	if self:GetParent():PassivesDisabled() then return end
    if self:GetAbility():IsFullyCastable() then
        local particle = ParticleManager:CreateParticle( "particles/items_fx/immunity_sphere.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControlEnt( particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true )
        ParticleManager:ReleaseParticleIndex( particle )
        self:GetParent():EmitSound("DOTA_Item.LinkensSphere.Activate")
        self:GetAbility():UseResources(false, false, false, true)
        if self:GetCaster():HasModifier("modifier_arc_warden_20") then
            self:SpellReflect(self:GetParent(), params)
        end
        return 1
    end
end

function modifier_roshan_spell_block_custom:OnIntervalThink()
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

function modifier_roshan_spell_block_custom:SpellReflect(parent, params)
    local reflected_spell_name = params.ability:GetAbilityName()
    local target = params.ability:GetCaster()

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

function modifier_roshan_spell_block_custom:GetReflectSpell( params )
    if not self:GetCaster():HasModifier("modifier_arc_warden_20") then return end
    if not IsServer() then return 0 end
    if self:GetAbility():IsFullyCastable() then
	    return SpellReflect(self:GetParent(), params)
    end
end