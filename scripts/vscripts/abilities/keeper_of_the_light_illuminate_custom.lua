--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_keeper_of_the_light_illuminate_custom", "abilities/keeper_of_the_light_illuminate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_keeper_of_the_light_illuminate_custom_thinker", "abilities/keeper_of_the_light_illuminate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_keeper_of_the_light_illuminate_custom_disarmed", "abilities/keeper_of_the_light_illuminate_custom", LUA_MODIFIER_MOTION_NONE)

keeper_of_the_light_illuminate_custom = class({})

function keeper_of_the_light_illuminate_custom:OnSpellStart()
    if not IsServer() then return end
    local index = DoUniqueString("keeper_of_the_light_illuminate_custom")
    self[index] = {}
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_keeper_of_the_light_illuminate_custom", {duration = self:GetChannelTime(), index = index})
end

function keeper_of_the_light_illuminate_custom:OnChannelFinish(bInterrupted)
    if not IsServer() then return end
    local modifier_keeper_of_the_light_illuminate_custom = self:GetCaster():FindModifierByName("modifier_keeper_of_the_light_illuminate_custom")
    if modifier_keeper_of_the_light_illuminate_custom then
        modifier_keeper_of_the_light_illuminate_custom:Destroy()
    end
end

modifier_keeper_of_the_light_illuminate_custom = class({})
function modifier_keeper_of_the_light_illuminate_custom:IsHidden() return true end
function modifier_keeper_of_the_light_illuminate_custom:IsPurgable() return false end
function modifier_keeper_of_the_light_illuminate_custom:GetEffectName()
	return "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_spirit_form_ambient.vpcf"
end
function modifier_keeper_of_the_light_illuminate_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_keeper_spirit_form.vpcf"
end
function modifier_keeper_of_the_light_illuminate_custom:OnCreated(params)
	if not IsServer() then return end
    self.index = params.index
	self:GetParent():EmitSound("Hero_KeeperOfTheLight.Illuminate.Charge")
    if self:GetCaster():HasScepter() then
        -- Используем стандартный модификатор BKB для иммунитета к магии
        -- Длительность равна времени каналирования способности
        local duration = self:GetAbility():GetChannelTime()
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_black_king_bar_immune", {duration = duration})
    end
end

function modifier_keeper_of_the_light_illuminate_custom:OnDestroy()
	if not IsServer() then return end
	local distance = self:GetAbility():GetSpecialValueFor("range")
    local speed = self:GetAbility():GetSpecialValueFor("speed")
    local total_damage = self:GetAbility():GetSpecialValueFor("total_damage") * math.max(0.5, self:GetElapsedTime() / self:GetDuration())
    local vVelocity = self:GetParent():GetForwardVector() * speed
    for i = 1, 12 do
        CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_keeper_of_the_light_illuminate_custom_thinker", {duration = distance / speed, direction_x = vVelocity.x, direction_y = vVelocity.y, damage = total_damage, index = self.index}, self:GetParent():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
        vVelocity = RotatePosition(Vector(0,0,0), QAngle(0,30*i,0), self:GetCaster():GetForwardVector()) * speed
    end
    self:GetParent():StopSound("Hero_KeeperOfTheLight.Illuminate.Charge")
    self:GetParent():EmitSound("Hero_KeeperOfTheLight.Illuminate.Discharge")
    -- Удаляем модификатор BKB при завершении каналирования
    local modifier_bkb = self:GetParent():FindModifierByName("modifier_black_king_bar_immune")
    if modifier_bkb and modifier_bkb:GetAbility() == self:GetAbility() then
        modifier_bkb:Destroy()
    end
end

modifier_keeper_of_the_light_illuminate_custom_thinker = class({})

function modifier_keeper_of_the_light_illuminate_custom_thinker:OnCreated( params )
    if not IsServer() then return end
    self.index = params.index
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self.radius = self.ability:GetSpecialValueFor("radius")
    self.speed = self.ability:GetSpecialValueFor("speed")
    self.damage = params.damage
    self.duration           = params.duration
    self.direction          = Vector(params.direction_x, params.direction_y, 0)
    self.direction_angle    = math.deg(math.atan2(self.direction.x, self.direction.y))
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/kotl_illuminate.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControl(self.particle, 1, self.direction)
    ParticleManager:SetParticleControl(self.particle, 2, Vector(1,0,0))
    ParticleManager:SetParticleControl(self.particle, 8, Vector(1,0,0))
    ParticleManager:SetParticleControl(self.particle, 10, Vector(1,0,0))
    ParticleManager:SetParticleControl(self.particle, 3, self.parent:GetAbsOrigin())
    self:AddParticle(self.particle, false, false, -1, false, false)
    self.hit_targets = {}
    self:OnIntervalThink()
    self:StartIntervalThink(FrameTime())
end

function modifier_keeper_of_the_light_illuminate_custom_thinker:OnIntervalThink()
    if not IsServer() then return end
    if not self.parent or self.parent:IsNull() or not self.parent:IsAlive() then return end

    local parentPos = self.parent:GetAbsOrigin()
    if not parentPos then return end

    local targets = FindUnitsInRadius(self.caster:GetTeamNumber(), parentPos, nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    local valid_targets =   {}
    for _, target in pairs(targets) do
        local target_pos = target:GetAbsOrigin()
        if not target_pos then
            goto continue
        end
        
        if not parentPos then
            goto continue
        end
        
        local target_angle = math.deg(math.atan2((target_pos.x - parentPos.x), target_pos.y - parentPos.y))
        local difference = math.abs(self.direction_angle - target_angle)
        if difference <= 90 or difference >= 270 then
            table.insert(valid_targets, target)
        end
        
        ::continue::
    end
    for _, target in pairs(valid_targets) do
        local hit_already = false
        for _, hit_target in pairs(self.hit_targets) do
            if hit_target == target then
                hit_already = true
                break
            end
        end
        if not hit_already then
            local damageTable = 
            {
                victim          = target,
                damage          = self.damage,
                damage_type     = DAMAGE_TYPE_MAGICAL,
                damage_flags    = DOTA_DAMAGE_FLAG_NONE,
                attacker        = self.caster,
                ability         = self.ability
            }
            if self:GetAbility()[self.index][target:entindex()] == nil then
                ApplyDamage(damageTable)
                target:EmitSound("Hero_KeeperOfTheLight.Illuminate.Target")
                target:EmitSound("Hero_KeeperOfTheLight.Illuminate.Target.Secondary")
                local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_illuminate_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
                ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
                ParticleManager:ReleaseParticleIndex(particle)
                target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_keeper_of_the_light_illuminate_custom_disarmed", {duration = 4})
                table.insert(self.hit_targets, target)
                self:GetAbility()[self.index][target:entindex()] = true
            end
        end
    end
    if self.parent and not self.parent:IsNull() and parentPos then
        self.parent:SetAbsOrigin(parentPos + (self.direction * FrameTime()))
    end
end

function modifier_keeper_of_the_light_illuminate_custom_thinker:OnDestroy()
    if not IsServer() then return end
    if self.parent and not self.parent:IsNull() and self.parent:IsAlive() then
        self.parent:RemoveSelf()
    end
end

modifier_keeper_of_the_light_illuminate_custom_disarmed = class({})
function modifier_keeper_of_the_light_illuminate_custom_disarmed:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
    }
end