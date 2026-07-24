--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_keeper_of_the_light_obscure", "heroes/npc_dota_hero_keeper_of_the_light_custom/keeper_of_the_light_obscure", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_keeper_of_the_light_obscure_thinker", "heroes/npc_dota_hero_keeper_of_the_light_custom/keeper_of_the_light_obscure", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_keeper_of_the_light_obscure_motion", "heroes/npc_dota_hero_keeper_of_the_light_custom/keeper_of_the_light_obscure", LUA_MODIFIER_MOTION_BOTH)

keeper_of_the_light_obscure = class({})

function keeper_of_the_light_obscure:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_keeper_of_the_light/obscure_cast.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_keeper_of_the_light/kotl_obscure.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_obscure_impact.vpcf", context)
end

function keeper_of_the_light_obscure:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_CHANNELLED
end

function keeper_of_the_light_obscure:GetChannelTime()
    local max_channel_time = self:GetSpecialValueFor("max_channel_time")
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_21") then
        max_channel_time = max_channel_time / self.modifier_keeper_of_the_light_21
    end
    return max_channel_time
end

function keeper_of_the_light_obscure:OnSpellStart()
    if not IsServer() then return end
    local max_channel_time = self:GetSpecialValueFor("max_channel_time")
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_21") then
        max_channel_time = max_channel_time / self.modifier_keeper_of_the_light_21
    end
    local index = DoUniqueString("keeper_of_the_light_obscure")
    local point = self:GetCursorPosition()
    local direction = (point - self:GetCaster():GetAbsOrigin())
    direction.z = 0
    direction = direction:Normalized()
    self[index] = {}
    local modifier_keeper_of_the_light_obscure = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_keeper_of_the_light_obscure", {duration = max_channel_time, index = index})
    if modifier_keeper_of_the_light_obscure then
        modifier_keeper_of_the_light_obscure.direction = direction
    end
end

function keeper_of_the_light_obscure:OnChannelFinish(bInterrupted)
    if not IsServer() then return end
    local modifier_keeper_of_the_light_obscure = self:GetCaster():FindModifierByName("modifier_keeper_of_the_light_obscure")
    if modifier_keeper_of_the_light_obscure then
        modifier_keeper_of_the_light_obscure:Destroy()
    end
end

modifier_keeper_of_the_light_obscure = class({})
function modifier_keeper_of_the_light_obscure:IsHidden() return true end
function modifier_keeper_of_the_light_obscure:IsPurgable() return false end
function modifier_keeper_of_the_light_obscure:OnCreated(params)
	if not IsServer() then return end
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()
    local keeper_of_the_light_illuminate_end_custom = self:GetCaster():FindAbilityByName("keeper_of_the_light_illuminate_end_custom")
    if keeper_of_the_light_illuminate_end_custom then
        keeper_of_the_light_illuminate_end_custom:SetLevel(self:GetAbility():GetLevel())
    end
    self.illuminate_heal = 0
    self.caster_location = self.caster:GetAbsOrigin()
    self.vision_counter = 1
    self.direction = self.caster:GetForwardVector()
	self.vision_time_count = GameRules:GetGameTime()
    self.vision_radius = self:GetAbility():GetSpecialValueFor("vision_radius")
    self.vision_duration = self:GetAbility():GetSpecialValueFor("vision_duration")
    self.channel_vision_radius = self:GetAbility():GetSpecialValueFor("channel_vision_radius")
    self.channel_vision_interval = self:GetAbility():GetSpecialValueFor("channel_vision_interval")
    self.channel_vision_duration = self:GetAbility():GetSpecialValueFor("channel_vision_duration")
    self.channel_vision_step = self:GetAbility():GetSpecialValueFor("channel_vision_step")

    if self:GetParent() == self:GetCaster() then
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/obscure_cast.vpcf", PATTACH_POINT_FOLLOW, self.caster)
        ParticleManager:SetParticleControlEnt(particle, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_attack1", self.caster:GetAbsOrigin(), true)
        self:AddParticle(particle, false, false, -1, false, false)
    end

    self:GetCaster():SwapAbilities("keeper_of_the_light_obscure", "keeper_of_the_light_illuminate_end_custom", false, true)
    self.index = params.index
	self:GetParent():EmitSound("Hero_KeeperOfTheLight.Illuminate.Charge")

    self:StartIntervalThink(FrameTime())
end

function modifier_keeper_of_the_light_obscure:OnIntervalThink()
	if not IsServer() then return end
	if GameRules:GetGameTime() - self.vision_time_count >= self.channel_vision_interval then
		self.vision_time_count = GameRules:GetGameTime()
		self.ability:CreateVisibilityNode(self.caster_location + (self.direction * self.channel_vision_step * self.vision_counter), self.channel_vision_radius, self.channel_vision_duration)
		self.vision_counter = self.vision_counter + 1
	end
end

function modifier_keeper_of_the_light_obscure:OnDestroy()
	if not IsServer() then return end
	local distance = self:GetAbility():GetSpecialValueFor("range")
    local speed = self:GetAbility():GetSpecialValueFor("speed")
    local total_damage = self:GetAbility():GetSpecialValueFor("total_damage")
    total_damage = total_damage * math.max(0.5, self:GetElapsedTime() / self:GetDuration())
    local vVelocity = self:GetParent():GetForwardVector() * speed
    self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_keeper_of_the_light_obscure_motion", {duration = distance / speed, direction_x = vVelocity.x, direction_y = vVelocity.y})
    local spawn_position = self:GetCaster():GetAbsOrigin() - self:GetParent():GetForwardVector() * 200
    CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_keeper_of_the_light_obscure_thinker", {duration = distance / speed, illuminate_heal = self.illuminate_heal, direction_x = vVelocity.x, direction_y = vVelocity.y, damage = total_damage, index = self.index}, spawn_position, self:GetCaster():GetTeamNumber(), false)
    self:GetParent():StopSound("Hero_KeeperOfTheLight.Illuminate.Charge")
    self:GetParent():EmitSound("Hero_KeeperOfTheLight.Illuminate.Discharge")
    self:GetCaster():SwapAbilities("keeper_of_the_light_illuminate_end_custom", "keeper_of_the_light_obscure", false, true)
end

modifier_keeper_of_the_light_obscure_thinker = class({})

function modifier_keeper_of_the_light_obscure_thinker:OnCreated( params )
    if not IsServer() then return end
    self.index = params.index
    self.illuminate_heal = params.illuminate_heal
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self.radius = self.ability:GetSpecialValueFor("radius")
    self.speed = self.ability:GetSpecialValueFor("speed")
    self.damage = params.damage
    self.duration = params.duration
    self.direction = Vector(params.direction_x, params.direction_y, 0)
    self.direction_angle = math.deg(math.atan2(self.direction.x, self.direction.y))
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/kotl_obscure.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
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

function modifier_keeper_of_the_light_obscure_thinker:OnIntervalThink()
    if not IsServer() then return end
    local targets = FindUnitsInRadius(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    local valid_targets =   {}
    for _, target in pairs(targets) do
        local target_pos    = target:GetAbsOrigin()
        local target_angle  = math.deg(math.atan2((target_pos.x - self.parent:GetAbsOrigin().x), target_pos.y - self.parent:GetAbsOrigin().y))
        local difference = math.abs(self.direction_angle - target_angle)
        if difference <= 90 or difference >= 270 then
            table.insert(valid_targets, target)
        end
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
            local damageTable = { victim = target, damage = self.damage, damage_type = DAMAGE_TYPE_PURE, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self.caster, ability = self.ability }
            if self:GetAbility()[self.index][target:entindex()] == nil then
                if target:GetTeamNumber() ~= self.caster:GetTeamNumber() then
                    ApplyDamage(damageTable)
                else
                    if self.illuminate_heal > 0 then
                        local heal = self.damage * self.illuminate_heal / 100
                        target:HealWithParams(heal, self.ability, false, true, self.caster, false)
                        if target:IsHero() then
                            SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, target, heal, nil)
                        end
                    end
                end
                target:EmitSound("Hero_KeeperOfTheLight.Illuminate.Target")
                target:EmitSound("Hero_KeeperOfTheLight.Illuminate.Target.Secondary")
                local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_obscure_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
                ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
                ParticleManager:ReleaseParticleIndex(particle)
                table.insert(self.hit_targets, target)
                self:GetAbility()[self.index][target:entindex()] = true
            end
        end
    end
    self.parent:SetAbsOrigin(self.parent:GetAbsOrigin() + (self.direction * FrameTime()))
end

function modifier_keeper_of_the_light_obscure_thinker:OnDestroy()
    if not IsServer() then return end
    self.parent:RemoveSelf()
end

modifier_keeper_of_the_light_obscure_motion = class({})
function modifier_keeper_of_the_light_obscure_motion:IsHidden() return true end
function modifier_keeper_of_the_light_obscure_motion:IsPurgable() return false end
function modifier_keeper_of_the_light_obscure_motion:IsPurgeException() return false end
function modifier_keeper_of_the_light_obscure_motion:OnCreated( kv )
	if not IsServer() then return end
    self.direction = Vector(kv.direction_x, kv.direction_y, 0)
	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
		return
	end
    self:StartIntervalThink(FrameTime())
end

function modifier_keeper_of_the_light_obscure_motion:OnIntervalThink()
    if not IsServer() then return end
    self:ApplyHorizontalMotionController()
end

function modifier_keeper_of_the_light_obscure_motion:CheckState()
    return
    {
        --[MODIFIER_STATE_ROOTED] = true,
    }
end

function modifier_keeper_of_the_light_obscure_motion:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_DISABLE_TURNING,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
end

function modifier_keeper_of_the_light_obscure_motion:GetOverrideAnimation()
    return ACT_DOTA_RUN
end

function modifier_keeper_of_the_light_obscure_motion:OnDestroy()
    if not IsServer() then return end
    self:GetParent():RemoveGesture(ACT_DOTA_RUN)
end

function modifier_keeper_of_the_light_obscure_motion:GetModifierDisableTurning()
    return 1
end

function modifier_keeper_of_the_light_obscure_motion:OnOrder( params )
	if params.unit ~= self:GetParent() then return end
	if
		params.order_type==DOTA_UNIT_ORDER_STOP or 
		params.order_type==DOTA_UNIT_ORDER_CAST_TARGET or
		params.order_type==DOTA_UNIT_ORDER_CAST_POSITION or
		params.order_type==DOTA_UNIT_ORDER_HOLD_POSITION
	then
		self:Destroy()
	end	
end

function modifier_keeper_of_the_light_obscure_motion:UpdateHorizontalMotion( me, dt )
	if self:GetParent():IsRooted() then return end
	local nextpos = me:GetOrigin() + self.direction * dt
	me:SetOrigin(nextpos)
end