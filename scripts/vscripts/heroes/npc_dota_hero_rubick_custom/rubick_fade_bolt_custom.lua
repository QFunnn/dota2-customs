--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_rubick_fade_bolt_custom", "heroes/npc_dota_hero_rubick_custom/rubick_fade_bolt_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_rubick_fade_bolt_custom_debuff", "heroes/npc_dota_hero_rubick_custom/rubick_fade_bolt_custom", LUA_MODIFIER_MOTION_NONE)

rubick_fade_bolt_custom = class({})

rubick_fade_bolt_custom.modifier_rubick_3 = 30
rubick_fade_bolt_custom.modifier_rubick_4 = 60
rubick_fade_bolt_custom.modifier_rubick_18 = {-5,0}
rubick_fade_bolt_custom.modifier_rubick_1_max = 1
rubick_fade_bolt_custom.modifier_rubick_1_radius = 175
rubick_fade_bolt_custom.modifier_rubick_1_damage = {30,60,90}

function rubick_fade_bolt_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_rubick/rubick_fade_bolt.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_rubick/rubick_fade_bolt_debuff.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/rubick/rubick_arcana/rubick_arcana_hex_poof.vpcf", context)
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_rubick.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_rubick.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_rubick.vpcf", context)
end

function rubick_fade_bolt_custom:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    self:GetCaster():EmitSound("Hero_Rubick.FadeBolt.Cast")
    self:UseFadeBolt(self:GetCaster(), target, true, 0, nil, true, nil, nil)
end

function rubick_fade_bolt_custom:UseFadeBolt(from, target, is_jump, jump_count, targets_table, start_cast, mini, flash)
    local modifier_rubick_fade_bolt_custom = target:AddNewModifier(self:GetCaster(), self, "modifier_rubick_fade_bolt_custom", {is_jump = is_jump, jump_count = jump_count, start_cast = start_cast, mini = mini, flash = flash})
    if targets_table then
        modifier_rubick_fade_bolt_custom.targets = targets_table
    end
    if self:GetCaster():HasModifier("modifier_rubick_3") then
        self:GetCaster():Heal(self.modifier_rubick_3, self)
        SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetCaster(), self.modifier_rubick_3, nil)
    end
    ------------------------------------- Visual -------------------------------------
    local point_attach = "attach_attack1"
    if from ~= self:GetCaster() then
        point_attach = "attach_hitloc"
    end
    local pcf = ParticleManager:CreateParticle("particles/units/heroes/hero_rubick/rubick_fade_bolt.vpcf", PATTACH_CUSTOMORIGIN, nil)
    ParticleManager:SetParticleControlEnt(pcf, 0, from, PATTACH_POINT_FOLLOW, point_attach, from:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(pcf, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(pcf)
end

modifier_rubick_fade_bolt_custom = class({})
function modifier_rubick_fade_bolt_custom:IsHidden() return true end
function modifier_rubick_fade_bolt_custom:IsDebuff() return true end
function modifier_rubick_fade_bolt_custom:IsPurgable() return true end
function modifier_rubick_fade_bolt_custom:IsPurgeException() return false end
function modifier_rubick_fade_bolt_custom:RemoveOnDeath() return false end
function modifier_rubick_fade_bolt_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_rubick_fade_bolt_custom:OnCreated(data)
    if not IsServer() then return end
    self.targets = {}
    self.jump_count = data.jump_count
    self.is_jump = data.is_jump
    self.targets[self:GetParent()] = true
    self.jump_range = self:GetAbility():GetSpecialValueFor("radius")
    self.jump_damage_reduction_pct = self:GetAbility():GetSpecialValueFor("jump_damage_reduction_pct") / 100
    self.duration = self:GetAbility():GetSpecialValueFor("duration")
    if self:GetCaster():HasModifier("modifier_rubick_18") then
        self.duration = self.duration + self:GetAbility().modifier_rubick_18[self:GetCaster():GetTalentLevel("modifier_rubick_18")]
    end
    self.jump_delay = self:GetAbility():GetSpecialValueFor("jump_delay")
    self:GetParent():EmitSound("Hero_Rubick.FadeBolt.Target")
    local damage = self:GetAbility():GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_rubick_4") then
        damage = damage + (self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_rubick_4)
    end
    if data.mini then
        if data.flash then
            local rubick_flash_bolt_custom = self:GetCaster():FindAbilityByName("rubick_flash_bolt_custom")
            if rubick_flash_bolt_custom then
                damage = damage / 100 * rubick_flash_bolt_custom:GetSpecialValueFor("damage_percent")
            end
        else
            local rubick_fade_lightning_custom = self:GetCaster():FindAbilityByName("rubick_fade_lightning_custom")
            if rubick_fade_lightning_custom then
                damage = damage / 100 * rubick_fade_lightning_custom:GetSpecialValueFor("damage_percent")
            end
        end
    end
    self.damage = damage - (damage * self.jump_damage_reduction_pct * data.jump_count)
    if self:CheckSphere(self:GetParent(), data.mini, data.start_cast) then
        local damage_ability = self:GetAbility()
        if self:GetCaster():HasModifier("modifier_rubick_18") then
            damage_ability = self:GetCaster():FindAbilityByName("rubick_fade_bolt_custom_magic_immune")
        end
        if not data.mini then
            self:GetParent():AddNewModifier(self:GetCaster(), damage_ability, "modifier_rubick_fade_bolt_custom_debuff", {duration = self.duration * (1-self:GetParent():GetStatusResistance())})
        end
        ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = damage_ability})
        if self:GetCaster():HasModifier("modifier_rubick_1") then
            self:Explosion()
        end
    end
    if self:GetCaster():HasModifier("modifier_rubick_1") then
        if data.jump_count >= self:GetAbility().modifier_rubick_1_max then
            self:Destroy()
            return
        end
    end
    if self.is_jump then
        self:StartIntervalThink(self.jump_delay)
    else
        self:Destroy()
    end
end

function modifier_rubick_fade_bolt_custom:CheckSphere(target, mini, start_cast)
    if not mini and start_cast then
        if target:TriggerSpellAbsorb( self:GetAbility() ) then
            return false
        end
    end
    return true
end

function modifier_rubick_fade_bolt_custom:Explosion()
    local damage_ability = self:GetAbility()
    if self:GetCaster():HasModifier("modifier_rubick_18") then
        damage_ability = self:GetCaster():FindAbilityByName("rubick_fade_bolt_custom_magic_immune")
    end
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility().modifier_rubick_1_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    for _,enemy in pairs(units) do
        ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = self:GetAbility().modifier_rubick_1_damage[self:GetCaster():GetTalentLevel("modifier_rubick_1")], damage_type = DAMAGE_TYPE_MAGICAL, ability = damage_ability })
    end
    local particle = ParticleManager:CreateParticle("particles/econ/items/rubick/rubick_arcana/rubick_arcana_hex_poof.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:ReleaseParticleIndex(particle)
end

function modifier_rubick_fade_bolt_custom:OnIntervalThink()
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.jump_range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)
    for _,enemy in pairs(units) do
        if not self.targets[enemy] then
            self.targets[enemy] = true
            self:GetAbility():UseFadeBolt(self:GetParent(), enemy, true, self.jump_count + 1, self.targets, nil)
            break
        end
    end
    self:Destroy()
end

modifier_rubick_fade_bolt_custom_debuff = class({})
function modifier_rubick_fade_bolt_custom_debuff:IsPurgable() return not self:GetCaster():HasModifier("modifier_rubick_18") end
function modifier_rubick_fade_bolt_custom_debuff:OnCreated()
    self.attack_damage_reduction = self:GetAbility():GetSpecialValueFor("attack_damage_reduction")
end

function modifier_rubick_fade_bolt_custom_debuff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_rubick_fade_bolt_custom_debuff:GetModifierBaseDamageOutgoing_Percentage(params)
    return self.attack_damage_reduction
end

function modifier_rubick_fade_bolt_custom_debuff:GetEffectName()
    return "particles/units/heroes/hero_rubick/rubick_fade_bolt_debuff.vpcf"
end

function modifier_rubick_fade_bolt_custom_debuff:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

rubick_fade_bolt_custom_magic_immune = rubick_fade_bolt_custom