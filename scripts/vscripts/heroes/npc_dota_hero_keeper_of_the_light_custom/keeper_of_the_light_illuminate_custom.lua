--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_keeper_of_the_light_illuminate_custom", "heroes/npc_dota_hero_keeper_of_the_light_custom/keeper_of_the_light_illuminate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_keeper_of_the_light_illuminate_custom_thinker", "heroes/npc_dota_hero_keeper_of_the_light_custom/keeper_of_the_light_illuminate_custom", LUA_MODIFIER_MOTION_NONE)

keeper_of_the_light_illuminate_custom = class({})
keeper_of_the_light_illuminate_custom.modifier_keeper_of_the_light_19 = {30}
keeper_of_the_light_illuminate_custom.modifier_keeper_of_the_light_15 = {5, 10, 15}
keeper_of_the_light_illuminate_custom.modifier_keeper_of_the_light_21 = 2

function keeper_of_the_light_illuminate_custom:Precache(context)
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_keeper_of_the_light.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_keeper_of_the_light.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_keeper_of_the_light.vpcf", context)
end

function keeper_of_the_light_illuminate_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_spirit_form_custom") then
        return DOTA_ABILITY_BEHAVIOR_POINT
    end
    return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_CHANNELLED
end

function keeper_of_the_light_illuminate_custom:GetChannelTime()
    local max_channel_time = self:GetSpecialValueFor("max_channel_time")
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_21") then
        max_channel_time = max_channel_time / self.modifier_keeper_of_the_light_21
    end
    return max_channel_time
end

function keeper_of_the_light_illuminate_custom:OnSpellStart()
    if not IsServer() then return end
    local max_channel_time = self:GetSpecialValueFor("max_channel_time")
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_21") then
        max_channel_time = max_channel_time / self.modifier_keeper_of_the_light_21
    end
    local modifier_keeper_of_the_light_spirit_form_custom = self:GetCaster():FindModifierByName("modifier_keeper_of_the_light_spirit_form_custom")
    local index = DoUniqueString("keeper_of_the_light_illuminate_custom")
    local point = self:GetCursorPosition()
    local direction = (point - self:GetCaster():GetAbsOrigin())
    direction.z = 0
    direction = direction:Normalized()
    self[index] = {}
    if modifier_keeper_of_the_light_spirit_form_custom then
        local thinker = CreateModifierThinker(self:GetCaster(), self, "modifier_keeper_of_the_light_illuminate_custom", {duration = max_channel_time, index = index}, self:GetCaster():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
        thinker:AddNewModifier(thinker, nil, "modifier_phased", {})
        thinker:SetAbsOrigin(self:GetCaster():GetAbsOrigin())
        thinker:SetForwardVector(direction)
        self.thinker = thinker
        local modifier_keeper_of_the_light_illuminate_custom = thinker:FindModifierByName("modifier_keeper_of_the_light_illuminate_custom")
        if modifier_keeper_of_the_light_illuminate_custom then
            modifier_keeper_of_the_light_illuminate_custom.direction = direction
            local pfx_kotl = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_illuminate_charge_spirit_form.vpcf", PATTACH_CUSTOMORIGIN, nil)
		    ParticleManager:SetParticleAlwaysSimulate(pfx_kotl)
		    ParticleManager:SetParticleControl(pfx_kotl, 0, self:GetCaster():GetAbsOrigin())
		    ParticleManager:SetParticleControl(pfx_kotl, 1, self:GetCaster():GetAbsOrigin())
		    ParticleManager:SetParticleControl(pfx_kotl, 3, self:GetCaster():GetAbsOrigin())
		    ParticleManager:SetParticleControlForward(pfx_kotl, 3, direction)
		    ParticleManager:SetParticleControlEnt(pfx_kotl, 6, self:GetCaster(), PATTACH_CUSTOMORIGIN, nil, self:GetCaster():GetAbsOrigin(), true )
            modifier_keeper_of_the_light_illuminate_custom:AddParticle(pfx_kotl, false, false, -1, false, false)
        end
    else
        local modifier_keeper_of_the_light_illuminate_custom = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_keeper_of_the_light_illuminate_custom", {duration = max_channel_time, index = index})
        if modifier_keeper_of_the_light_illuminate_custom then
            modifier_keeper_of_the_light_illuminate_custom.direction = direction
        end
    end
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
function modifier_keeper_of_the_light_illuminate_custom:OnCreated(params)
	if not IsServer() then return end
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()
    local keeper_of_the_light_illuminate_end_custom = self:GetCaster():FindAbilityByName("keeper_of_the_light_illuminate_end_custom")
    if keeper_of_the_light_illuminate_end_custom then
        keeper_of_the_light_illuminate_end_custom:SetLevel(self:GetAbility():GetLevel())
    end

    self.illuminate_heal = 0
    local modifier_keeper_of_the_light_spirit_form_custom = self:GetCaster():FindModifierByName("modifier_keeper_of_the_light_spirit_form_custom")
    if modifier_keeper_of_the_light_spirit_form_custom then
        self.illuminate_heal = modifier_keeper_of_the_light_spirit_form_custom:GetAbility():GetSpecialValueFor("illuminate_heal")
        if self:GetCaster():HasModifier("modifier_keeper_of_the_light_19") then
            self.illuminate_heal = self.illuminate_heal + self:GetAbility().modifier_keeper_of_the_light_19[self:GetCaster():GetTalentLevel("modifier_keeper_of_the_light_19")]
        end
    end

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
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/kotl_illuminate_cast.vpcf", PATTACH_POINT_FOLLOW, self.caster)
        ParticleManager:SetParticleControlEnt(particle, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_attack1", self.caster:GetAbsOrigin(), true)
        self:AddParticle(particle, false, false, -1, false, false)
    end

    self:GetCaster():SwapAbilities("keeper_of_the_light_illuminate_custom", "keeper_of_the_light_illuminate_end_custom", false, true)
    self.index = params.index
	self:GetParent():EmitSound("Hero_KeeperOfTheLight.Illuminate.Charge")

    self:StartIntervalThink(FrameTime())
end

function modifier_keeper_of_the_light_illuminate_custom:OnIntervalThink()
	if not IsServer() then return end
	if GameRules:GetGameTime() - self.vision_time_count >= self.channel_vision_interval then
		self.vision_time_count = GameRules:GetGameTime()
		self.ability:CreateVisibilityNode(self.caster_location + (self.direction * self.channel_vision_step * self.vision_counter), self.channel_vision_radius, self.channel_vision_duration)
		self.vision_counter = self.vision_counter + 1
	end
end

function modifier_keeper_of_the_light_illuminate_custom:OnDestroy()
	if not IsServer() then return end
	local distance = self:GetAbility():GetSpecialValueFor("range") + self:GetCaster():GetCastRangeBonus()
    local speed = self:GetAbility():GetSpecialValueFor("speed")
    local total_damage = self:GetAbility():GetSpecialValueFor("total_damage")
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_15") then
        total_damage = total_damage + (self:GetCaster():GetMaxMana() / 100 * self:GetAbility().modifier_keeper_of_the_light_15[self:GetCaster():GetTalentLevel("modifier_keeper_of_the_light_15")])
    end
    total_damage = total_damage * math.max(0.5, self:GetElapsedTime() / self:GetDuration())
    local vVelocity = self:GetParent():GetForwardVector() * speed
    CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_keeper_of_the_light_illuminate_custom_thinker", {duration = distance / speed, illuminate_heal = self.illuminate_heal, direction_x = vVelocity.x, direction_y = vVelocity.y, damage = total_damage, index = self.index}, self:GetParent():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
    self:GetParent():StopSound("Hero_KeeperOfTheLight.Illuminate.Charge")
    self:GetParent():EmitSound("Hero_KeeperOfTheLight.Illuminate.Discharge")
    self:GetCaster():SwapAbilities("keeper_of_the_light_illuminate_end_custom", "keeper_of_the_light_illuminate_custom", false, true)
end

modifier_keeper_of_the_light_illuminate_custom_thinker = class({})

function modifier_keeper_of_the_light_illuminate_custom_thinker:OnCreated( params )
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
            local damageTable = { victim = target, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self.caster, ability = self.ability }
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
                local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_illuminate_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
                ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
                ParticleManager:ReleaseParticleIndex(particle)
                table.insert(self.hit_targets, target)
                self:GetAbility()[self.index][target:entindex()] = true
            end
        end
    end
    self.parent:SetAbsOrigin(self.parent:GetAbsOrigin() + (self.direction * FrameTime()))
end

function modifier_keeper_of_the_light_illuminate_custom_thinker:OnDestroy()
    if not IsServer() then return end
    self.parent:RemoveSelf()
end

keeper_of_the_light_illuminate_end_custom = class({})
function keeper_of_the_light_illuminate_end_custom:OnSpellStart()
    if not IsServer() then return end
    local keeper_of_the_light_illuminate_custom = self:GetCaster():FindAbilityByName("keeper_of_the_light_illuminate_custom")
    if keeper_of_the_light_illuminate_custom and keeper_of_the_light_illuminate_custom.thinker and not keeper_of_the_light_illuminate_custom.thinker:IsNull() then
        keeper_of_the_light_illuminate_custom.thinker:RemoveModifierByName("modifier_keeper_of_the_light_illuminate_custom")
    else
        local modifier_keeper_of_the_light_illuminate_custom = self:GetCaster():FindModifierByName("modifier_keeper_of_the_light_illuminate_custom")
        if modifier_keeper_of_the_light_illuminate_custom then
            modifier_keeper_of_the_light_illuminate_custom:Destroy()
        end
    end
    local modifier_keeper_of_the_light_obscure = self:GetCaster():FindModifierByName("modifier_keeper_of_the_light_obscure")
    if modifier_keeper_of_the_light_obscure then
        modifier_keeper_of_the_light_obscure:Destroy()
    end
end