--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skelet_reincarnation", "heroes/npc_dota_hero_skeleton_king_custom/skeleton_king_bone_guard_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_skeleton_vampiric_aura_ghost", "heroes/npc_dota_hero_skeleton_king_custom/skeleton_king_bone_guard_custom", LUA_MODIFIER_MOTION_NONE )

skeleton_king_bone_guard_custom = class({})
skeleton_king_bone_guard_custom.modifier_skeleton_king_15 = {300,400,500}
skeleton_king_bone_guard_custom.modifier_skeleton_king_15_health = {100,150,200}

function skeleton_king_bone_guard_custom:OnSpellStart()
    local charges = self:GetSpecialValueFor("max_skeleton_charges")
    local delay = self:GetSpecialValueFor("spawn_interval")
    self:GetCaster():EmitSound("Hero_SkeletonKing.MortalStrike.Cast")
    local all_skeletons = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, 0, FIND_CLOSEST, false )
    for _, skelet in pairs(all_skeletons) do
        if skelet.skelet then
            skelet:RemoveModifierByName("modifier_skelet_reincarnation")
            skelet:ForceKill(false)
        end
    end
    for i=0,charges - 1 do
        Timers:CreateTimer(delay * i, function ()
            self:CreateSkeleton(self:GetCaster():GetOrigin()+RandomVector(300), nil, nil, true)
        end)
    end
end

function skeleton_king_bone_guard_custom:CreateSkeleton(origin, target, duration_custom, reincarnation, ultimate)
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("skeleton_duration")
    if duration_custom then
        duration = duration_custom
    end
    local unit_name = "npc_dota_wraith_king_skeleton_warrior"
    if self:GetCaster():HasModifier("modifier_skeleton_king_15") then
        unit_name = "npc_dota_wraith_king_skeleton_ghost"
    end
    local skeleton_damage_tooltip = self:GetSpecialValueFor("skeleton_damage_tooltip")
    local skelet = CreateUnitByName( unit_name, origin, true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber() )
    ParticleManager:ReleaseParticleIndex( ParticleManager:CreateParticle( "particles/neutral_fx/skeleton_spawn.vpcf", PATTACH_ABSORIGIN, skelet ) )
    skelet:SetOwner( self:GetCaster() )
    skelet:SetBaseDamageMin(skeleton_damage_tooltip)
    skelet:SetBaseDamageMax(skeleton_damage_tooltip)
    skelet:AddNewModifier(self:GetCaster(), self, "modifier_kill", {duration = duration})
    skelet:SetControllableByPlayer(self:GetCaster():GetPlayerOwnerID(), true)
    skelet.owner = self:GetCaster()
    skelet.skelet = true
    skelet:EmitSound("n_creep_Skeleton.Spawn")
    skelet:EmitSound("n_creep_TrollWarlord.RaiseDead")
    if self:GetCaster():HasModifier("modifier_skeleton_king_15") then
        skelet:SetRenderColor(34, 139, 34)
        skelet:AddNewModifier(self:GetCaster(), self, "modifier_skeleton_vampiric_aura_ghost", {})
    else
        if reincarnation then
            skelet:AddNewModifier(self:GetCaster(), self, "modifier_skelet_reincarnation", {})
        end
    end
end

modifier_skelet_reincarnation = class({})

function modifier_skelet_reincarnation:IsHidden()
    return true
end

function modifier_skelet_reincarnation:RemoveOnDeath()
    return true
end

function modifier_skelet_reincarnation:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_EVENT_ON_DEATH,
    }
    return funcs
end

function modifier_skelet_reincarnation:OnDeath( params )
    if not IsServer() then return end
    if params.attacker == nil then return end
    if params.unit ~= self:GetParent() then return end
    if params.attacker == self:GetParent() then return end
 	local point = self:GetParent():GetAbsOrigin()
  	local team = self:GetParent():GetTeamNumber()
  	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local duration = 0
	local modifier_kill = self:GetParent():FindModifierByName("modifier_kill")
	local delay_reincarnation = self:GetAbility():GetSpecialValueFor("reincarnate_time")
	if modifier_kill then
		duration = modifier_kill:GetRemainingTime()
	end
	local name = self:GetParent():GetUnitName()
	Timers:CreateTimer(delay_reincarnation, function()
		if caster ~= nil and not caster:IsNull() then 
			ability:CreateSkeleton(point, nil, duration, false)
		end
	end)
end

modifier_skeleton_vampiric_aura_ghost = class({})
function modifier_skeleton_vampiric_aura_ghost:IsPurgable() return false end
function modifier_skeleton_vampiric_aura_ghost:IsPurgeException() return false end
function modifier_skeleton_vampiric_aura_ghost:IsHidden() return true end
function modifier_skeleton_vampiric_aura_ghost:RemoveOnDeath() return false end
function modifier_skeleton_vampiric_aura_ghost:OnCreated()
    if not IsServer() then return end
    local health = self:GetParent():GetBaseMaxHealth()
    health = health + self:GetAbility().modifier_skeleton_king_15_health[self:GetCaster():GetTalentLevel("modifier_skeleton_king_15")]
    self:GetParent():SetBaseMaxHealth(health)
    self:GetParent():SetMaxHealth(health)
    self:GetParent():SetHealth(health)
end

function modifier_skeleton_vampiric_aura_ghost:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_PROPERTY_PROJECTILE_NAME,
        MODIFIER_PROPERTY_OVERRIDE_ATTACK_MAGICAL,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_skeleton_vampiric_aura_ghost:GetModifierAttackRangeBonus()
    return self:GetAbility().modifier_skeleton_king_15[self:GetCaster():GetTalentLevel("modifier_skeleton_king_15")]
end

function modifier_skeleton_vampiric_aura_ghost:GetModifierProjectileName()
    return "particles/items_fx/revenant_brooch_projectile.vpcf"
end

function modifier_skeleton_vampiric_aura_ghost:GetOverrideAttackMagical()
    return 1
end

function modifier_skeleton_vampiric_aura_ghost:GetModifierTotalDamageOutgoing_Percentage(event)
    if not IsServer() then return end
    local parent = self:GetParent()
    if event.inflictor then return 0 end
    if event.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then return 0 end
    if event.damage_type == DAMAGE_TYPE_MAGICAL then return 0 end
    local damageTable = 
    {
        attacker = parent,
        damage = event.original_damage,
        damage_type = DAMAGE_TYPE_MAGICAL,
        victim = event.target,
        ability = nil,
        damage_flags = DOTA_DAMAGE_FLAG_MAGIC_AUTO_ATTACK
    }
    ApplyDamage(damageTable)
    return -200
end