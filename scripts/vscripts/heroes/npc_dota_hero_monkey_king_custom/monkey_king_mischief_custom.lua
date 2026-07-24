--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_monkey_king_mischief_custom", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_mischief_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_transform_courier", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_mischief_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_transform_runes", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_mischief_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_17_barrier", "modifiers/talents/npc_dota_hero_monkey_king/modifier_monkey_king_17", LUA_MODIFIER_MOTION_NONE)

monkey_king_mischief_custom = class({})
monkey_king_mischief_custom.modifier_monkey_king_13 = 5
monkey_king_mischief_custom.modifier_monkey_king_13_duration = {1,2,3}

function monkey_king_mischief_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_monkey_king_13") then
        bonus = self.modifier_monkey_king_13
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function monkey_king_mischief_custom:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_monkey_king/monkey_king_disguise.vpcf", context)
end

function monkey_king_mischief_custom:OnSpellStart()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_monkey_king_21") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_monkey_king_transform_courier", {})
    elseif self:GetCaster():HasModifier("modifier_monkey_king_13") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_monkey_king_transform_runes", {})
    else
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_monkey_king_transform", {})
    end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_monkey_king_mischief_custom", {})
    if self:GetCaster():HasModifier("modifier_monkey_king_17") then
        self:GetCaster():RemoveModifierByName("modifier_monkey_king_17_barrier")
        self:GetCaster():AddNewModifier(self:GetCaster(), nil, "modifier_monkey_king_17_barrier", {duration = 24})
    end
end

modifier_monkey_king_mischief_custom = class({})
function modifier_monkey_king_mischief_custom:IsHidden() return true end
function modifier_monkey_king_mischief_custom:IsPurgable() return false end
function modifier_monkey_king_mischief_custom:IsPurgeException() return false end
function modifier_monkey_king_mischief_custom:OnCreated()
    if not IsServer() then return end
    local modifier_woda_emblem = self:GetParent():FindModifierByName("modifier_woda_emblem")
    if modifier_woda_emblem then
        local status_effect = modifier_woda_emblem.status_effect
        self.effect_id = modifier_woda_emblem.effect_id
        modifier_woda_emblem:Destroy()
    end
    local monkey_king_untransform_custom = self:GetCaster():FindAbilityByName("monkey_king_untransform_custom")
    if monkey_king_untransform_custom then
        monkey_king_untransform_custom:SetLevel(1)
    end
    if self:GetCaster():HasModifier("modifier_monkey_king_17") then
        local monkey_king_primal_spring_custom = self:GetCaster():FindAbilityByName("monkey_king_primal_spring_custom")
        if monkey_king_primal_spring_custom then
            monkey_king_primal_spring_custom:SetActivated(true)
        end
    end
    self:GetCaster():SwapAbilities("monkey_king_mischief_custom", "monkey_king_untransform_custom", false, true)
    self:StartIntervalThink(FrameTime())
end

function modifier_monkey_king_mischief_custom:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():HasModifier("modifier_monkey_king_transform") and not self:GetParent():HasModifier("modifier_monkey_king_transform_courier") and not self:GetParent():HasModifier("modifier_monkey_king_transform_runes") then
        self:Destroy()
    end
end

function modifier_monkey_king_mischief_custom:OnDestroy()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_monkey_king_17") and not self:GetCaster():HasModifier("modifier_monkey_king_tree_dance_custom") then
        local monkey_king_primal_spring_custom = self:GetCaster():FindAbilityByName("monkey_king_primal_spring_custom")
        if monkey_king_primal_spring_custom then
            monkey_king_primal_spring_custom:SetActivated(false)
        end
    end
    if self.effect_id then
        player_system:AddPlayerEmblem(self.effect_id, self:GetParent())
    end
    self:GetCaster():SwapAbilities("monkey_king_untransform_custom", "monkey_king_mischief_custom", false, true)
end

monkey_king_untransform_custom = class({})

function monkey_king_untransform_custom:OnSpellStart()
    if not IsServer() then return end
    local mods = 
    {
        "modifier_monkey_king_transform",
        "modifier_monkey_king_transform_courier",
        "modifier_monkey_king_transform_runes",
    }
    for _, mod_name in pairs(mods) do
        local modifier = self:GetCaster():FindModifierByName(mod_name)
        if modifier then
            modifier:Destroy()
        end
    end
end

modifier_monkey_king_transform_courier = class({})
function modifier_monkey_king_transform_courier:IsPurgable() return false end
function modifier_monkey_king_transform_courier:IsPurgeException() return false end
function modifier_monkey_king_transform_courier:OnCreated()
    if not IsServer() then return end
    self.invul_duration = self:GetAbility():GetSpecialValueFor("invul_duration") + 0.4
    local particle_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_disguise.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle_fx, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle_fx)
    self:GetParent():Purge(false, true, false, false, false)
    self:GetParent():EmitSound("Hero_MonkeyKing.Transform.On")
end

function modifier_monkey_king_transform_courier:OnDestroy()
    if not IsServer() then return end
    local particle_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_disguise.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle_fx, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle_fx)
    self:GetParent():EmitSound("Hero_MonkeyKing.Transform.Off")
end

function modifier_monkey_king_transform_courier:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        MODIFIER_PROPERTY_MODEL_CHANGE,
        MODIFIER_EVENT_ON_ATTACK_START,
    }
end

function modifier_monkey_king_transform_courier:GetAbsoluteNoDamagePhysical()
    if self:GetElapsedTime() > self.invul_duration then return end
    return 1
end

function modifier_monkey_king_transform_courier:GetAbsoluteNoDamageMagical()
    if self:GetElapsedTime() > self.invul_duration then return end
    return 1
end

function modifier_monkey_king_transform_courier:GetAbsoluteNoDamagePure()
    if self:GetElapsedTime() > self.invul_duration then return end
    return 1
end

function modifier_monkey_king_transform_courier:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movespeed")
end

function modifier_monkey_king_transform_courier:CheckState()
	return 
    {
		[MODIFIER_STATE_NO_HEALTH_BAR_FOR_ENEMIES] = true,
		[MODIFIER_STATE_NEUTRALS_DONT_ATTACK] = true,
        [MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
        [MODIFIER_STATE_FAKE_ALLY] = true,
	}
end

function modifier_monkey_king_transform_courier:GetModifierModelChange()
    return "models/courier/aghanim_courier/aghanim_courier.vmdl"
end

function modifier_monkey_king_transform_courier:OnAttackStart(params)
    if params.attacker ~= self:GetParent() then return end
	self:Destroy()
end

function modifier_monkey_king_transform_courier:OnTakeDamage(params)	
	if params.unit ~= self:GetParent() then return end
    if params.damage <= 0 then return end
    self:Destroy()
end

modifier_monkey_king_transform_runes = class({})
function modifier_monkey_king_transform_runes:IsPurgable() return false end
function modifier_monkey_king_transform_runes:IsPurgeException() return false end
function modifier_monkey_king_transform_runes:OnCreated()
    self.rune_models =
    {
        {"models/props_gameplay/rune_doubledamage01.vmdl", "particles/generic_gameplay/rune_doubledamage.vpcf", "modifier_rune_doubledamage", "Rune.DD"},
        {"models/props_gameplay/rune_arcane.vmdl", "particles/generic_gameplay/rune_arcane.vpcf", "modifier_rune_arcane", "Rune.Arcane"},
        {"models/props_gameplay/rune_haste01.vmdl", "particles/generic_gameplay/rune_haste.vpcf", "modifier_rune_haste", "Rune.Haste"},
        {"models/props_gameplay/rune_illusion01.vmdl", "particles/generic_gameplay/rune_illusion.vpcf", "modifier_rune_illusion", "Rune.Illusion"},
        {"models/props_gameplay/rune_regeneration01.vmdl", "particles/generic_gameplay/rune_regeneration.vpcf", "modifier_rune_regen", "Rune.Regen"},
        {"models/props_gameplay/rune_shield01.vmdl", "particles/generic_gameplay/rune_shield.vpcf", "modifier_rune_shield", "Rune.Shield"},
    }
    self.current_data = self.rune_models[RandomInt(1, #self.rune_models)]
    if not IsServer() then return end
    self.invul_duration = self:GetAbility():GetSpecialValueFor("invul_duration")
    local particle_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_disguise.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle_fx, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle_fx)
    self:GetParent():EmitSound("Hero_MonkeyKing.Transform.On")
    Timers:CreateTimer(FrameTime(), function()
        local pfx = ParticleManager:CreateParticle(self.current_data[2], PATTACH_CUSTOMORIGIN_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControlEnt(particle_fx, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
        self:AddParticle(pfx, false, false, -1, false, false)
    end)
end

function modifier_monkey_king_transform_runes:OnDestroy()
    if not IsServer() then return end
    local particle_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_disguise.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle_fx, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle_fx)
    self:GetParent():EmitSound("Hero_MonkeyKing.Transform.Off")
    self:GetParent():EmitSound(self.current_data[4])
    local modifier_name = self.current_data[3]
    local modifier_duration = self:GetAbility().modifier_monkey_king_13_duration[self:GetCaster():GetTalentLevel("modifier_monkey_king_13")]
    if modifier_name == "modifier_rune_illusion" then
        self:GetParent():Purge(false, true, false, false, false)
        CreateIllusions(self:GetParent(), self:GetParent(), {duration = modifier_duration, outgoing_damage = -65, incoming_damage = 100}, 2, 75, true, true)
    else
        local modifier_handle = self:GetParent():FindModifierByName(modifier_name)
        if modifier_handle and modifier_handle:GetRemainingTime() > modifier_duration then return end
        self:GetParent():AddNewModifier(self:GetParent(), nil, modifier_name, {duration = modifier_duration})
    end
end

function modifier_monkey_king_transform_runes:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        MODIFIER_PROPERTY_MODEL_CHANGE,
        MODIFIER_EVENT_ON_ATTACK_START,
    }
end

function modifier_monkey_king_transform_runes:GetAbsoluteNoDamagePhysical()
    if self:GetElapsedTime() > self.invul_duration then return end
    return 1
end

function modifier_monkey_king_transform_runes:GetAbsoluteNoDamageMagical()
    if self:GetElapsedTime() > self.invul_duration then return end
    return 1
end

function modifier_monkey_king_transform_runes:GetAbsoluteNoDamagePure()
    if self:GetElapsedTime() > self.invul_duration then return end
    return 1
end

function modifier_monkey_king_transform_runes:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movespeed")
end

function modifier_monkey_king_transform_runes:CheckState()
	return 
    {
		[MODIFIER_STATE_NO_HEALTH_BAR_FOR_ENEMIES] = true,
		[MODIFIER_STATE_NEUTRALS_DONT_ATTACK] = true,
        [MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
        [MODIFIER_STATE_FAKE_ALLY] = true,
	}
end

function modifier_monkey_king_transform_runes:GetModifierModelChange()
    return self.current_data[1]
end

function modifier_monkey_king_transform_runes:OnAbilityFullyCast(params)
    if params.unit ~= self:GetParent() then return end
    if params.ability == self:GetAbility() then return end
    self:Destroy()
end

function modifier_monkey_king_transform_runes:OnAttackStart(params)
    if params.attacker ~= self:GetParent() then return end
	self:Destroy()
end

function modifier_monkey_king_transform_runes:OnTakeDamage(params)	
	if params.unit ~= self:GetParent() then return end
    if params.damage <= 0 then return end
    self:Destroy()
end