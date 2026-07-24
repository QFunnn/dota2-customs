--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_generic_arc_lua", "modifiers/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier("modifier_zuus_heavenly_jump_custom_debuff", "heroes/npc_dota_hero_zuus_custom/zuus_heavenly_jump_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zuus_heavenly_jump_custom_double_jump", "heroes/npc_dota_hero_zuus_custom/zuus_heavenly_jump_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zuus_heavenly_jump_custom_buff_magic_immune", "heroes/npc_dota_hero_zuus_custom/zuus_heavenly_jump_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zuus_heavenly_jump_custom_handler", "heroes/npc_dota_hero_zuus_custom/zuus_heavenly_jump_custom", LUA_MODIFIER_MOTION_NONE)

zuus_heavenly_jump_custom = class({})
zuus_heavenly_jump_custom.modifier_zuus_10 = 10
zuus_heavenly_jump_custom.modifier_zuus_1 = {1,2}
zuus_heavenly_jump_custom.modifier_zuus_2 = {1,2}
zuus_heavenly_jump_custom.modifier_zuus_2_radius = 350
zuus_heavenly_jump_custom.modifier_zuus_3 = {0.8,1.6}
zuus_heavenly_jump_custom.modifier_zuus_3_radius = 350
zuus_heavenly_jump_custom.modifier_zuus_4 = {1,5,10} -- creep-illusion / champ / hero
zuus_heavenly_jump_custom.modifier_zuus_1_cd = {-2,-4}

function zuus_heavenly_jump_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_zuus/zuus_shard_head.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_zuus/zuus_lightning_bolt_aoe.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_zuus/zuus_shard_slow.vpcf", context)
end

function zuus_heavenly_jump_custom:GetBehavior()
    local behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET
    if self:GetCaster():HasModifier("modifier_zuus_4") then
        behavior = DOTA_ABILITY_BEHAVIOR_POINT
    end
    if self:GetCaster():HasModifier("modifier_zuus_6") then
        return behavior + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    return behavior + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
end

function zuus_heavenly_jump_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    if point == self:GetCaster():GetAbsOrigin() then
        point = point + self:GetCaster():GetForwardVector()
    end
    local vision_radius = self:GetSpecialValueFor("vision_radius")
    local vision_duration = self:GetSpecialValueFor("vision_duration")
    AddFOWViewer(self:GetCaster():GetTeamNumber(), point, vision_radius, vision_duration, false)
    self:Jump(point)
end

function zuus_heavenly_jump_custom:GetIntrinsicModifierName()
    if self:GetAbilityName() == "zuus_heavenly_jump_custom_immune" then return end
    return "modifier_zuus_heavenly_jump_custom_handler"
end

function zuus_heavenly_jump_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_zuus_1") then
        bonus = self.modifier_zuus_1_cd[self:GetCaster():GetTalentLevel("modifier_zuus_1")]
    end
    if self:GetCaster():HasModifier("modifier_zuus_heavenly_jump_custom_double_jump") then
        return 0
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function zuus_heavenly_jump_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_zuus_heavenly_jump_custom_double_jump") then
        return 0
    end
    if self:GetCaster():HasModifier("modifier_zuus_4") then
        return 0
    end
    self.BaseClass.GetManaCost(self, iLevel)
end

function zuus_heavenly_jump_custom:StartAoeAttack()
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetCaster():GetAoeBonus(self.modifier_zuus_2_radius), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false)
    for _, target in pairs(units) do
        for i=1, self.modifier_zuus_2[self:GetCaster():GetTalentLevel("modifier_zuus_2")] do
            self:GetCaster():PerformAttack(target, true, true, true, false, false, false, true)
        end
        local thunder = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_shard_head.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
        ParticleManager:SetParticleControlEnt(thunder, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), true)
        ParticleManager:SetParticleControlEnt(thunder, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
        ParticleManager:SetParticleControlEnt(thunder, 2, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_origin", self:GetCaster():GetAbsOrigin(), true)
    end
    local aoe = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_lightning_bolt_aoe.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(aoe, 0, self:GetCaster():GetAbsOrigin())
    ParticleManager:SetParticleControl(aoe, 1, Vector( self:GetCaster():GetAoeBonus(self.modifier_zuus_2_radius), self:GetCaster():GetAoeBonus(self.modifier_zuus_2_radius), self:GetCaster():GetAoeBonus(self.modifier_zuus_2_radius)))
    ParticleManager:ReleaseParticleIndex(aoe)
end

function zuus_heavenly_jump_custom:StartAoeStun()
    local damage_ability = self
    if self:GetCaster():HasModifier("modifier_zuus_3") then
        damage_ability = self:GetCaster():FindAbilityByName("zuus_heavenly_jump_custom_immune")
    end
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetCaster():GetAoeBonus(self.modifier_zuus_3_radius), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false)
    for _, target in pairs(units) do
        target:AddNewModifier(self:GetCaster(), damage_ability, "modifier_stunned", {duration = self.modifier_zuus_3[self:GetCaster():GetTalentLevel("modifier_zuus_3")] * (1-target:GetStatusResistance())})
    end
end

function zuus_heavenly_jump_custom:Jump(point)
    if not IsServer() then return end
	local height = self:GetSpecialValueFor("hop_height")
	local distance = self:GetSpecialValueFor("hop_distance")
    local hop_distance = self:GetSpecialValueFor("hop_distance")
	local hop_duration = self:GetSpecialValueFor("hop_duration")
	local range = self:GetSpecialValueFor("range")
    local max_targets = self:GetSpecialValueFor("targets")
	local direction = self:GetCaster():GetForwardVector()
    if self:GetCaster():HasModifier("modifier_zuus_4") and point then
        direction = (point - self:GetCaster():GetAbsOrigin())
        direction.z = 0
        local point_distance = direction:Length2D()
        direction = direction:Normalized()
        if point_distance < range then
            distance = point_distance
        end
        if distance > hop_distance then
            distance = hop_distance
        end
    end
    self:GetCaster():EmitSound("Hero_Zuus.StaticField")
    AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), 900, 3, false)
    local is_double_jump = false
    local modifier_generic_arc_lua = self:GetCaster():FindModifierByName("modifier_generic_arc_lua")
    if self:GetCaster():HasModifier("modifier_zuus_6") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_zuus_heavenly_jump_custom_buff_magic_immune", {duration = 3})
    end
    if modifier_generic_arc_lua and modifier_generic_arc_lua.zuus_jump and self:GetCaster():HasModifier("modifier_zuus_1") then
        local origin_z = self:GetCaster():GetAbsOrigin()
        local settings = 
        { 
            dir_x = direction.x,
            dir_y = direction.y,
            duration = hop_duration,
            distance = distance,
            height = height,
            fix_end = false,
            isStun = false,
            isForward = true,
            activity = ACT_DOTA_CAST_ABILITY_3,
            start_offset = origin_z.z,
			fix_duration = true,
        }
        if modifier_generic_arc_lua then
            modifier_generic_arc_lua.double_start = true
            modifier_generic_arc_lua:Destroy()
        end
        self:GetCaster():SetAbsOrigin(origin_z)
        if self:GetCaster():HasModifier("modifier_zuus_4") and point then
            self:GetCaster():SetForwardVector(direction)
        end
        local arc = self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_generic_arc_lua", settings)
        if arc then
            arc.zuus_jump = true
            arc:SetEndCallback(function()
                if self:GetCaster():HasModifier("modifier_zuus_2") then
                    self:StartAoeAttack()
                end
                if self:GetCaster():HasModifier("modifier_zuus_3") then
                    self:StartAoeStun()
                end
                local modifier_zuus_heavenly_jump_custom_buff_magic_immune = self:GetCaster():FindModifierByName("modifier_zuus_heavenly_jump_custom_buff_magic_immune")
                if modifier_zuus_heavenly_jump_custom_buff_magic_immune then
                    modifier_zuus_heavenly_jump_custom_buff_magic_immune:Destroy()
                end
            end)
        end
        is_double_jump = true
        local modifier_zuus_heavenly_jump_custom_double_jump = self:GetCaster():FindModifierByName("modifier_zuus_heavenly_jump_custom_double_jump")
        if modifier_zuus_heavenly_jump_custom_double_jump then
            modifier_zuus_heavenly_jump_custom_double_jump:Destroy()
        end
    else
        if self:GetCaster():HasModifier("modifier_zuus_4") and point then
            self:GetCaster():SetForwardVector(direction)
        end
        local arc = self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_generic_arc_lua",{ dir_x = direction.x,dir_y = direction.y,duration = hop_duration,distance = distance,height = height,fix_end = false,isStun = false,isForward = true,activity = ACT_DOTA_CAST_ABILITY_3,})
        if arc then
            arc.zuus_jump = true
            arc:SetEndCallback(function()
                if not arc.double_start then
                    if self:GetCaster():HasModifier("modifier_zuus_2") then
                        self:StartAoeAttack()
                    end
                    if self:GetCaster():HasModifier("modifier_zuus_3") then
                        self:StartAoeStun()
                    end
                    local modifier_zuus_heavenly_jump_custom_buff_magic_immune = self:GetCaster():FindModifierByName("modifier_zuus_heavenly_jump_custom_buff_magic_immune")
                    if modifier_zuus_heavenly_jump_custom_buff_magic_immune then
                        modifier_zuus_heavenly_jump_custom_buff_magic_immune:Destroy()
                    end
                end
            end)
        end
    end

    if self:GetCaster():HasModifier("modifier_zuus_1") then
        max_targets = max_targets + self.modifier_zuus_1[self:GetCaster():GetTalentLevel("modifier_zuus_1")]
        if not is_double_jump then
            self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_zuus_heavenly_jump_custom_double_jump", {duration = hop_duration})
            self:EndCooldown()
        end
    end

	local units = {}
	local units_heroes = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO , DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, false)
	local units_creeps = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC ,  DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, false)
	if #units_heroes > 0 then 
		for i = 1, #units_heroes do 
			table.insert(units, units_heroes[i])
		end
	end
	if #units_creeps > 0 then 
		for i = 1, #units_creeps do 
			table.insert(units, units_creeps[i])
		end
	end
	if #units == 0 then return end
	local max_targets = math.min(max_targets, #units)
	for i = 1, max_targets do 
		self:DealDamage(units[i], false, false)
	end
end

function zuus_heavenly_jump_custom:DealDamage(target)
    if not IsServer() then return end
    local damage_ability = self
    if self:GetCaster():HasModifier("modifier_zuus_3") then
        damage_ability = self:GetCaster():FindAbilityByName("zuus_heavenly_jump_custom_immune")
    end
    local damage = self:GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_zuus_10") then
        damage = damage + (self:GetCaster():GetDisplayAttackSpeed() / 100 * self.modifier_zuus_10)
    end
    local duration = self:GetSpecialValueFor("duration")
    target:AddNewModifier(self:GetCaster(), damage_ability, "modifier_zuus_heavenly_jump_custom_debuff", {duration = duration})
    ApplyDamage({ victim = target, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetCaster(), ability = damage_ability })
    target:EmitSound("Hero_Zuus.ArcLightning.Target")
    local particle = "particles/units/heroes/hero_zuus/zuus_shard_head.vpcf"

    local thunder = ParticleManager:CreateParticle(particle, PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControlEnt(thunder, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(thunder, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(thunder, 2, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_origin", self:GetCaster():GetAbsOrigin(), true)
end

modifier_zuus_heavenly_jump_custom_debuff = class({})

function modifier_zuus_heavenly_jump_custom_debuff:OnCreated()
    self.move_slow = self:GetAbility():GetSpecialValueFor("move_slow")
    self.aspd_slow = self:GetAbility():GetSpecialValueFor("aspd_slow")
    if not IsServer() then return end
    local particle_slow = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_shard_slow.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    self:AddParticle(particle_slow, false, false, -1, false, false)
end

function modifier_zuus_heavenly_jump_custom_debuff:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_zuus_heavenly_jump_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.move_slow
end

function modifier_zuus_heavenly_jump_custom_debuff:GetModifierAttackSpeedBonus_Constant()
	return self.aspd_slow
end

modifier_zuus_heavenly_jump_custom_double_jump = class({})
function modifier_zuus_heavenly_jump_custom_double_jump:IsHidden() return true end
function modifier_zuus_heavenly_jump_custom_double_jump:IsPurgable() return false end
function modifier_zuus_heavenly_jump_custom_double_jump:IsPurgeException() return false end
function modifier_zuus_heavenly_jump_custom_double_jump:OnDestroy()
    if not IsServer() then return end
    if self:GetAbility():IsFullyCastable() then
        self:GetAbility():UseResources(false, false, false, true)
    end
end

modifier_zuus_heavenly_jump_custom_buff_magic_immune = class({})
function modifier_zuus_heavenly_jump_custom_buff_magic_immune:IsPurgable() return false end
function modifier_zuus_heavenly_jump_custom_buff_magic_immune:GetTexture() return "zuus_6" end

function modifier_zuus_heavenly_jump_custom_buff_magic_immune:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_zuus_heavenly_jump_custom_buff_magic_immune:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_zuus_heavenly_jump_custom_buff_magic_immune:CheckState()
    return 
    {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true
    }
end

function modifier_zuus_heavenly_jump_custom_buff_magic_immune:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end

function modifier_zuus_heavenly_jump_custom_buff_magic_immune:StatusEffectPriority()
    return 99999
end

function modifier_zuus_heavenly_jump_custom_buff_magic_immune:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE
    }
end

function modifier_zuus_heavenly_jump_custom_buff_magic_immune:GetAbsoluteNoDamagePure(params)
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 1
    end
end

function modifier_zuus_heavenly_jump_custom_buff_magic_immune:GetModifierMagicalResistanceBonus(params)
    if IsClient() then 
        return 65
    end
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 65
    end
end

modifier_zuus_heavenly_jump_custom_handler = class({})
function modifier_zuus_heavenly_jump_custom_handler:IsHidden() return true end
function modifier_zuus_heavenly_jump_custom_handler:IsPurgable() return false end
function modifier_zuus_heavenly_jump_custom_handler:IsPurgeException() return false end
function modifier_zuus_heavenly_jump_custom_handler:RemoveOnDeath() return false end
function modifier_zuus_heavenly_jump_custom_handler:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_DEATH
    }
end
function modifier_zuus_heavenly_jump_custom_handler:OnDeath(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.unit == self:GetParent() then return end
    if self:GetCaster():HasModifier("modifier_zuus_4") then
        local cooldown_reduced = self:GetAbility().modifier_zuus_4[1]
        if params.unit:HasModifier("modifier_wodacreepchampion") or params.unit:HasModifier("modifier_wodacreepchampionred") then
            cooldown_reduced = self:GetAbility().modifier_zuus_4[2]
        end
        if params.unit:IsRealHero() then
            cooldown_reduced = self:GetAbility().modifier_zuus_4[3]
        end
        if self:GetAbility():GetCooldownTimeRemaining() > 0 then
            local cooldown = self:GetAbility():GetCooldownTimeRemaining() - cooldown_reduced
            if cooldown > 0 then
                self:GetAbility():EndCooldown()
                self:GetAbility():StartCooldown(cooldown)
            else
                self:GetAbility():EndCooldown()
            end
        end
    end
end

zuus_heavenly_jump_custom_immune = zuus_heavenly_jump_custom