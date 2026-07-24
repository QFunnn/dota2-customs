--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_generic_arc_lua", "modifiers/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier("modifier_pangolier_shield_crash_custom_buff", "heroes/npc_dota_hero_pangolier_custom/pangolier_shield_crash_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_shield_crash_custom_magic_immune", "heroes/npc_dota_hero_pangolier_custom/pangolier_shield_crash_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_shield_crash_custom_double_jump", "heroes/npc_dota_hero_pangolier_custom/pangolier_shield_crash_custom", LUA_MODIFIER_MOTION_NONE)

pangolier_shield_crash_custom = class({})
pangolier_shield_crash_custom.modifier_pangolier_19 = {30,60,90}
pangolier_shield_crash_custom.modifier_pangolier_4 = {1,2}
pangolier_shield_crash_custom.modifier_pangolier_13 = {1,2}
pangolier_shield_crash_custom.modifier_pangolier_16 = {20,40,60}

function pangolier_shield_crash_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump_cast.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump_hero.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_egg.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_streaks.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf", context)
    PrecacheResource("particle", "particles/status_fx/status_effect_snapfire_slow.vpcf", context)
end

function pangolier_shield_crash_custom:GetCooldown(iLevel)
    if self:GetCaster():HasModifier("modifier_pangolier_shield_crash_custom_double_jump") then
        return 0
    end
    if self:GetCaster():HasModifier("modifier_pangolier_gyroshell_custom") or self:GetCaster():HasModifier("modifier_pangolier_rollup_custom") then
        local pangolier_gyroshell_custom = self:GetCaster():FindAbilityByName("pangolier_gyroshell_custom")
        if pangolier_gyroshell_custom then
            return pangolier_gyroshell_custom:GetSpecialValueFor("shield_crash_cooldown")
        end
    end
    return self.BaseClass.GetCooldown(self, iLevel)
end

function pangolier_shield_crash_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_pangolier_3") then
        return 0
    end
    if self:GetCaster():HasModifier("modifier_pangolier_shield_crash_custom_double_jump") then
        return 0
    end
    self.BaseClass.GetManaCost(self, iLevel)
end

function pangolier_shield_crash_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_pangolier_shield_crash_custom_double_jump") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE + DOTA_ABILITY_BEHAVIOR_UNRESTRICTED
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end

function pangolier_shield_crash_custom:OnSpellStart(new_ability, new_duration)
    if not IsServer() then return end
    local caster = self:GetCaster()
    local distance = self:GetSpecialValueFor("jump_horizontal_distance")
    local duration = self:GetSpecialValueFor("jump_duration")
    local height = self:GetSpecialValueFor("jump_height")
    local radius = self:GetSpecialValueFor("radius")
    if self:GetCaster():HasModifier("modifier_pangolier_19") then
        radius = radius + self.modifier_pangolier_19[self:GetCaster():GetTalentLevel("modifier_pangolier_19")]
    end
    local buff_duration = self:GetSpecialValueFor("duration")
    local slow_duration = self:GetSpecialValueFor("slow_duration")
    local passive = caster:FindAbilityByName("pangolier_lucky_shot_custom")
    local ulti = caster:FindAbilityByName("pangolier_gyroshell_custom")
    local damage = self:GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_pangolier_19") then
        damage = damage + self.modifier_pangolier_19[self:GetCaster():GetTalentLevel("modifier_pangolier_19")]
    end
    if self:GetCaster():HasModifier("modifier_pangolier_4") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_pangolier_shield_crash_custom_magic_immune", {duration = self.modifier_pangolier_4[self:GetCaster():GetTalentLevel("modifier_pangolier_4")]})
    end
    caster:StartGesture(ACT_DOTA_CAST_ABILITY_2)
    caster:EmitSound("Hero_Pangolier.TailThump.Cast")
    local ulti_mod = caster:FindModifierByName("modifier_pangolier_gyroshell_custom")
    if ulti_mod  then 
        duration = self:GetSpecialValueFor("jump_duration_gyroshell")
        height = self:GetSpecialValueFor("jump_height_gyroshell")
        distance = ulti_mod.max_speed*duration
    end
    if caster:HasModifier("modifier_pangolier_rollup_custom") then 
        duration = self:GetSpecialValueFor("jump_duration_gyroshell")
        height = self:GetSpecialValueFor("jump_height_gyroshell")
        distance = 1
        caster:StartGesture(ACT_DOTA_RUN)
    end
    if new_ability then
        self:SetActivated(false)
        new_ability:SetActivated(false)
    end

    local origin_z = self:GetCaster():GetAbsOrigin()
    local is_double_jumping = false
    if self:GetCaster():HasModifier("modifier_pangolier_16") then
        if not self:GetCaster():HasModifier("modifier_pangolier_shield_crash_custom_double_jump") then
            self:EndCooldown()
            self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_pangolier_shield_crash_custom_double_jump", {})
        else
            local modifier_generic_arc_lua = self:GetCaster():FindModifierByName("modifier_generic_arc_lua")
            if modifier_generic_arc_lua and modifier_generic_arc_lua.pango_jump then
                modifier_generic_arc_lua.destroyed = true
                modifier_generic_arc_lua:Destroy()
            end
            self:GetCaster():RemoveModifierByName("modifier_pangolier_shield_crash_custom_double_jump")
            is_double_jumping = true
        end
    end

    if not is_double_jumping then
        if caster:IsRooted() or caster:IsStunned() then
            distance = 1
            height = height*0.7
        end
    end
    local speed = math.max(1, distance/duration)
    local point = caster:GetAbsOrigin() + caster:GetForwardVector()*distance
    
    local mod_settings = 
    {
        target_x = point.x,
        target_y = point.y,
        distance = distance,
        speed = speed,
        height = height,
        fix_end = false,
        isStun = not caster:HasModifier("modifier_pangolier_gyroshell_custom"),
    }

    if is_double_jumping then
        mod_settings = 
        {
            target_x = point.x,
            target_y = point.y,
            distance = distance,
            speed = speed,
            height = height,
            fix_end = false,
            isStun = not caster:HasModifier("modifier_pangolier_gyroshell_custom"),
            start_offset = origin_z.z,
        }

        if self:GetCaster():HasModifier("modifier_pangolier_16") then
            damage = damage + (damage / 100 * self.modifier_pangolier_16[self:GetCaster():GetTalentLevel("modifier_pangolier_16")])
        end
    end

    local arc = caster:AddNewModifier( caster, self, "modifier_generic_arc_lua", mod_settings)
    if is_double_jumping then
        self:GetCaster():SetAbsOrigin(origin_z)
    end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump_cast.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
    ParticleManager:ReleaseParticleIndex(particle)

    if not arc then return end
    arc.pango_jump = true

    if self:GetCaster():HasModifier("modifier_pangolier_13") and not is_double_jumping then
        local pangolier_swashbuckle_custom = self:GetCaster():FindAbilityByName("pangolier_swashbuckle_custom")
        if pangolier_swashbuckle_custom and pangolier_swashbuckle_custom:GetLevel() > 0 then
            local moves = 
            {
                self:GetCaster():GetForwardVector(),
                self:GetCaster():GetForwardVector() * -1,
                self:GetCaster():GetRightVector(),
                self:GetCaster():GetLeftVector(),
            }
            for _,move in pairs(moves) do
                self:GetCaster():AddNewModifier(self:GetCaster(), pangolier_swashbuckle_custom, "modifier_pangolier_swashbuckle_custom_attacks", {dir_x = move.x, dir_y = move.y, duration = 3, new_strikes = self.modifier_pangolier_13[self:GetCaster():GetTalentLevel("modifier_pangolier_13")]})
            end
        end
    end

    arc:SetEndCallback(function(is_interrupt)
        if arc.destroyed then return end
        self:GetCaster():RemoveModifierByName("modifier_pangolier_shield_crash_custom_double_jump")
        if self:GetCaster():HasModifier("modifier_pangolier_shield_crash_custom_double_jump") then return end
        if not caster:HasModifier(("modifier_pangolier_gyroshell_custom")) and not new_ability then 
            caster:FadeGesture(ACT_DOTA_RUN)
        else 
            caster:AddNewModifier(caster, ulti, "modifier_pangolier_gyroshell_custom_turn_boost", {duration = ulti:GetSpecialValueFor("jump_recover_time")})
        end
        caster:FadeGesture(ACT_DOTA_RUN)
        if not is_interrupt then
            local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false)
            local enemies_hero = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS, FIND_CLOSEST, false)
            if #enemies_hero > 0 then
                caster:AddNewModifier(caster, self, "modifier_pangolier_shield_crash_custom_buff", {duration = buff_duration, enemies = #enemies_hero, is_double_jumping = is_double_jumping})
            end
            for _,enemy in pairs(enemies) do
                if passive and passive:GetLevel() > 0 then 
                    passive:ProcPassive(enemy, false)
                end
                ApplyDamage({victim = enemy, attacker = caster, ability = self, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL })
            end
            local smash = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump_hero.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager:SetParticleControl(smash, 0, caster:GetAbsOrigin())
            ParticleManager:DestroyParticle(smash, false)
            ParticleManager:ReleaseParticleIndex(smash)
            EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), "Hero_Pangolier.TailThump", caster)
        end
        if new_ability and new_duration then
            if not is_interrupt then
                Timers:CreateTimer(FrameTime(), function()
                    new_ability:UseResources(false, false, false, true)
                    self:GetCaster():AddNewModifier(self:GetCaster(), new_ability, "modifier_pangolier_gyroshell_custom", {duration = new_duration, original = 1})
                end)
            end
            --caster:StartGesture(ACT_DOTA_RUN)
            self:SetActivated(true)
            Timers:CreateTimer(FrameTime(), function()
                new_ability:SetActivated(true)
            end)
        end
    end)
end

modifier_pangolier_shield_crash_custom_buff = class({})
function modifier_pangolier_shield_crash_custom_buff:IsHidden() return false end
function modifier_pangolier_shield_crash_custom_buff:IsPurgable() return false end
function modifier_pangolier_shield_crash_custom_buff:OnCreated(table)
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.hero_shield = self.ability:GetSpecialValueFor("hero_shield")
    if table.is_double_jumping and table.is_double_jumping == 1 then
        self.hero_shield = self.hero_shield + (self.hero_shield / 100 * self.ability.modifier_pangolier_16[self:GetCaster():GetTalentLevel("modifier_pangolier_16")])
    end
    if not IsServer() then return end
    self.buff_particles = {}
    self.parent:EmitSound("Hero_Pangolier.TailThump.Shield")
    self.max_shield = self.hero_shield * table.enemies
	self.current_shield = self.hero_shield * table.enemies
    self.buff_particles[1] = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt(self.buff_particles[1], 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), false) 
    self:AddParticle(self.buff_particles[1], false, false, -1, true, false)
    ParticleManager:SetParticleControl( self.buff_particles[1], 3, Vector( 255, 255, 255 ) )

    self.buff_particles[2] = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_egg.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt(self.buff_particles[2], 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), false) 
    self:AddParticle(self.buff_particles[2], false, false, -1, true, false)

    self.buff_particles[3] = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_streaks.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt(self.buff_particles[3], 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), false) 
    self:AddParticle(self.buff_particles[3], false, false, -1, true, false)

    self:SetHasCustomTransmitterData(true)
    self:OnIntervalThink()
    self:StartIntervalThink(0.1)
end

function modifier_pangolier_shield_crash_custom_buff:OnRefresh(table)
    self.hero_shield = self.ability:GetSpecialValueFor("hero_shield")
    if table.is_double_jumping and table.is_double_jumping == 1 then
        self.hero_shield = self.hero_shield + (self.hero_shield / 100 * self.ability.modifier_pangolier_16[self:GetCaster():GetTalentLevel("modifier_pangolier_16")])
    end
    if not IsServer() then return end
    self.buff_particles = {}
    self.parent:EmitSound("Hero_Pangolier.TailThump.Shield")
    self.max_shield = self.max_shield + (self.hero_shield * table.enemies)
	self.current_shield = self.current_shield + (self.hero_shield * table.enemies)
end

function modifier_pangolier_shield_crash_custom_buff:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield
	}
	return data
end

function modifier_pangolier_shield_crash_custom_buff:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_pangolier_shield_crash_custom_buff:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
	return funcs
end

function modifier_pangolier_shield_crash_custom_buff:GetModifierIncomingDamageConstant( params )
	if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.current_shield
		end
	end
	if params.damage >= self.current_shield then
        local shield = self.current_shield
		self:Destroy()
		return -shield
	else
		self.current_shield = self.current_shield-params.damage
		self:SendBuffRefreshToClients()
		return -params.damage
	end
end

modifier_pangolier_shield_crash_custom_magic_immune = class({})
function modifier_pangolier_shield_crash_custom_magic_immune:IsPurgable() return false end
function modifier_pangolier_shield_crash_custom_magic_immune:GetTexture() return "pangolier_4" end

function modifier_pangolier_shield_crash_custom_magic_immune:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_pangolier_shield_crash_custom_magic_immune:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_pangolier_shield_crash_custom_magic_immune:CheckState()
    return 
    {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true
    }
end

function modifier_pangolier_shield_crash_custom_magic_immune:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end

function modifier_pangolier_shield_crash_custom_magic_immune:StatusEffectPriority()
    return 99999
end

function modifier_pangolier_shield_crash_custom_magic_immune:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE
    }
end

function modifier_pangolier_shield_crash_custom_magic_immune:GetAbsoluteNoDamagePure(params)
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 1
    end
end

function modifier_pangolier_shield_crash_custom_magic_immune:GetModifierMagicalResistanceBonus(params)
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

modifier_pangolier_shield_crash_custom_double_jump = class({})
function modifier_pangolier_shield_crash_custom_double_jump:IsHidden() return true end
function modifier_pangolier_shield_crash_custom_double_jump:IsPurgable() return false end
function modifier_pangolier_shield_crash_custom_double_jump:IsPurgeException() return false end
function modifier_pangolier_shield_crash_custom_double_jump:OnDestroy()
    if not IsServer() then return end
    if self:GetAbility():IsFullyCastable() then
        self:GetAbility():UseResources(false, false, false, true)
    end
end