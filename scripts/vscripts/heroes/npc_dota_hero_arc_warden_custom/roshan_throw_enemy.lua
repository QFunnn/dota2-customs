--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_roshan_throw_enemy_buff", "heroes/npc_dota_hero_arc_warden_custom/roshan_throw_enemy", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_roshan_throw_enemy_debuff", "heroes/npc_dota_hero_arc_warden_custom/roshan_throw_enemy", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_generic_arc_lua", "modifiers/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )

roshan_throw_enemy = class({})
roshan_throw_enemy.modifier_arc_warden_18 = {-10,-20,-30}

function roshan_throw_enemy:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/generic_gameplay/dust_impact_large.vpcf", context)
end

function roshan_throw_enemy:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_arc_warden_18") then
        bonus = self.modifier_arc_warden_18[self:GetCaster():GetTalentLevel("modifier_arc_warden_18")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function roshan_throw_enemy:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    if target:TriggerSpellAbsorb(self) then return end
    if self:GetCaster():GetUnitName() ~= "npc_dota_hero_arc_warden" then return end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_roshan_throw_enemy_buff", {duration = 1.5})
    target:AddNewModifier(self:GetCaster(), self, "modifier_roshan_throw_enemy_debuff", {duration = 1.1})
    self:GetCaster():EmitSound("Roshan.Grab")
end

modifier_roshan_throw_enemy_buff = class({})
function modifier_roshan_throw_enemy_buff:IsHidden() return true end
function modifier_roshan_throw_enemy_buff:IsPurgeException() return false end
function modifier_roshan_throw_enemy_buff:IsPurgable() return false end
function modifier_roshan_throw_enemy_buff:CheckState()
    return
    {
        [MODIFIER_STATE_STUNNED] = true,
    }
end

function modifier_roshan_throw_enemy_buff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
    }
end
    
function modifier_roshan_throw_enemy_buff:GetOverrideAnimation()
    return ACT_DOTA_CAST_ABILITY_2
end

modifier_roshan_throw_enemy_debuff = class({})
function modifier_roshan_throw_enemy_debuff:IsHidden() return true end
function modifier_roshan_throw_enemy_debuff:OnCreated()
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()
    if not IsServer() then return end
    self.interrupt_pos = self.caster:GetOrigin() + self.caster:GetForwardVector() * 200
    self.cast_pos = self.caster:GetOrigin()
    self.pos_threshold = 100
    self.attach_name = "attach_grab"
    if self:GetCaster():GetUnitName() ~= "npc_dota_hero_arc_warden" then
        self.attach_name = "attach_hitloc"
    end
    local hitloc_enum = self.parent:ScriptLookupAttachment( "attach_hitloc" )
    local hitloc_pos = self.parent:GetAttachmentOrigin( hitloc_enum )
    self.deltapos = self.parent:GetOrigin() - hitloc_pos
    if not self:ApplyHorizontalMotionController() then
        self:Destroy()
        return
    end
    if not self:ApplyVerticalMotionController() then
        self:Destroy()
        return
    end
    self:SetPriority( DOTA_MOTION_CONTROLLER_PRIORITY_HIGHEST )
    self:StartIntervalThink( 0.75 )

    self:GetParent():FollowEntityMerge(self:GetCaster(), "attach_grab")
end

function modifier_roshan_throw_enemy_debuff:OnDestroy()
    if not IsServer() then return end
    if not self:GetParent():IsAlive() or not self:GetCaster():IsAlive() then
        self:GetParent():FollowEntityMerge(nil, "")
        self:GetParent():FollowEntity(nil, false)
        return
    end
    local distance = self:GetAbility():GetSpecialValueFor("distance")
    local damage = self:GetAbility():GetSpecialValueFor("damage")
    local start_position = self:GetParent():GetAbsOrigin()
    local direction = self:GetParent():GetForwardVector()
    local end_position = start_position + direction * distance
    local settings = 
    { 
        dir_x = direction.x,
        dir_y = direction.y,
        duration = 0.4,
        distance = distance,
        height = 100,
        fix_end = false,
        isStun = true,
        isForward = true,
        activity = ACT_DOTA_FLAIL,
        start_offset = start_position.z,
        fix_duration = true,
    }
    local parent = self:GetParent()
    local caster = self:GetCaster()
    local ability = self:GetAbility()
    self:GetParent():FollowEntityMerge(nil, "")
    self:GetParent():FollowEntity(nil, false)
    self:GetCaster():EmitSound("Roshan.Throw")
    Timers:CreateTimer(FrameTime(), function()
        if parent:HasModifier("modifier_wodarelax") then return end
        local arc = parent:AddNewModifier( caster, ability, "modifier_generic_arc_lua", settings)
        if arc then
            arc:SetEndCallback(function()
                ApplyDamage({ victim = parent, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = ability })
                local particle = ParticleManager:CreateParticle( "particles/generic_gameplay/dust_impact_large.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
                ParticleManager:ReleaseParticleIndex( particle )
                parent:EmitSound("Roshan.Throw.Impact")
                GridNav:DestroyTreesAroundPoint(parent:GetOrigin(), 200, true)
            end)
        end
    end)
end

function modifier_roshan_throw_enemy_debuff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
    }
end
    
function modifier_roshan_throw_enemy_debuff:GetOverrideAnimation()
    return ACT_DOTA_FLAIL
end

function modifier_roshan_throw_enemy_debuff:CheckState()
    return
    {
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true,
    }
end
    
function modifier_roshan_throw_enemy_debuff:GetPriority()
    return DOTA_MOTION_CONTROLLER_PRIORITY_HIGHEST
end
    
function modifier_roshan_throw_enemy_debuff:GetMotionPriority()
    return DOTA_MOTION_CONTROLLER_PRIORITY_HIGHEST
end