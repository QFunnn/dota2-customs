--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_wisp_relocate_custom", "heroes/npc_dota_hero_wisp_custom/wisp_relocate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_relocate_custom_cast_delay", "heroes/npc_dota_hero_wisp_custom/wisp_relocate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_relocate_custom_thinker", "heroes/npc_dota_hero_wisp_custom/wisp_relocate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_relocate_custom_thinker_end", "heroes/npc_dota_hero_wisp_custom/wisp_relocate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_relocate_custom_armor_debuff", "heroes/npc_dota_hero_wisp_custom/wisp_relocate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_relocate_custom_thinker_souls", "heroes/npc_dota_hero_wisp_custom/wisp_relocate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_relocate_custom_thinker_souls_debuff", "heroes/npc_dota_hero_wisp_custom/wisp_relocate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_relocate_custom_thinker_souls_cooldown", "heroes/npc_dota_hero_wisp_custom/wisp_relocate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_relocate_custom_thinker_souls_buff", "heroes/npc_dota_hero_wisp_custom/wisp_relocate_custom", LUA_MODIFIER_MOTION_NONE)

wisp_relocate_custom = class({})
wisp_relocate_custom.modifier_wisp_20_range = 1800 
wisp_relocate_custom.modifier_wisp_20_cooldown = {-10,-20,-30} 
wisp_relocate_custom.modifier_wisp_20_cast_point = {0.5,1.5,2.5}
wisp_relocate_custom.modifier_wisp_6 = {-10,-20}
wisp_relocate_custom.modifier_wisp_6_duration = 8
wisp_relocate_custom.modifier_wisp_18_silence_duration = 3
wisp_relocate_custom.modifier_wisp_18_duration = 9
wisp_relocate_custom.modifier_wisp_18_radius = 650
wisp_relocate_custom.modifier_wisp_18_cooldown = 6
wisp_relocate_custom.modifier_wisp_19 = {8,16,24}

function wisp_relocate_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_wisp/wisp_relocate_timer.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_wisp/wisp_relocate_channel.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_wisp/wisp_relocate_teleport.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_wisp/wisp_relocate.vpcf", context)
    PrecacheResource("particle", "particles/armor_debufff_aghanim.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_wisp/wisp_relocate_marker_endpoint.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_wisp/wisp_relocate_marker.vpcf", context)
    PrecacheResource("particle", "particles/wisp_custom/shadow_thinker.vpcf", context)
end

function wisp_relocate_custom:GetCastRange(vLocation, hTarget)
    if self:GetCaster():HasModifier("modifier_wisp_20") then
        if IsClient() then
            return self.modifier_wisp_20_range
        end
    end
    return self.BaseClass.GetCastRange(self, vLocation, hTarget)
end

function wisp_relocate_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_wisp_20") then
        bonus = self.modifier_wisp_20_cooldown[self:GetCaster():GetTalentLevel("modifier_wisp_20")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function wisp_relocate_custom:OnSpellStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()
    local max_distance = self.modifier_wisp_20_range
    if self:GetCaster():HasModifier("modifier_wisp_20") then
        local direction = (point - self:GetCaster():GetAbsOrigin())
        direction.z = 0
        local distance = direction:Length2D()
        direction = direction:Normalized()
        if distance > max_distance then
            point = self:GetCaster():GetAbsOrigin() + direction * max_distance
        end
    end
    local cast_delay = self:GetSpecialValueFor("cast_delay")
    if self:GetCaster():HasModifier("modifier_wisp_20") then
        cast_delay = cast_delay - self.modifier_wisp_20_cast_point[self:GetCaster():GetTalentLevel("modifier_wisp_20")]
    end
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_wisp_relocate_custom_cast_delay", {duration = cast_delay, point_x = point.x, point_y = point.y, point_z = point.z})
    AddFOWViewer(self:GetCaster():GetTeamNumber(), point, 200, cast_delay, false)
end

modifier_wisp_relocate_custom_cast_delay = class({})
function modifier_wisp_relocate_custom_cast_delay:IsPurgable() return false end
function modifier_wisp_relocate_custom_cast_delay:IsPurgeException() return false end
function modifier_wisp_relocate_custom_cast_delay:OnCreated(params)
    if not IsServer() then return end
    self.point = Vector(params.point_x, params.point_y, params.point_z)
    self:GetCaster():EmitSound("Hero_Wisp.Relocate")
    CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_wisp_relocate_custom_thinker", {duration = self:GetDuration()}, self.point, self:GetCaster():GetTeamNumber(), false)
	local channel_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_relocate_channel.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(channel_pfx, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(channel_pfx, false, false, -1, false, false)
    self:StartIntervalThink(FrameTime())
end

function modifier_wisp_relocate_custom_cast_delay:OnIntervalThink()
    if self:GetParent():HasModifier("modifier_wisp_6") then return end
	if not self:GetCaster():IsAlive() or self:GetCaster():IsStunned() or self:GetCaster():IsHexed() or self:GetCaster():IsNightmared() or self:GetCaster():IsOutOfGame() or self:GetCaster():IsRooted() then
		self:Destroy()
	end
end

function modifier_wisp_relocate_custom_cast_delay:OnDestroy()
    if not IsServer() then return end
    local return_time = self:GetAbility():GetSpecialValueFor("return_time")
    local destroy_tree_radius = self:GetAbility():GetSpecialValueFor("destroy_tree_radius")
    self:GetCaster():StopSound("Hero_Wisp.Relocate")
    if self:GetRemainingTime() <= 0 then
        EmitSoundOn("Hero_Wisp.Return", self:GetCaster())
        if not self:GetCaster():HasModifier("modifier_wisp_6") then
            EmitSoundOn("Hero_Wisp.ReturnCounter", self:GetCaster())
        end
        GridNav:DestroyTreesAroundPoint(self.point, 250, false)
        
        if self:GetCaster():HasModifier("modifier_wisp_relocate_custom") then
            local caster_teleport_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_relocate_teleport.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster())
            ParticleManager:SetParticleControl(caster_teleport_pfx, 0, self:GetCaster():GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(caster_teleport_pfx)
            
            FindClearSpaceForUnit(self:GetCaster(), self.point, true)
            self:GetCaster():Interrupt()
            
            local teleport_out_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_relocate_marker_endpoint.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
            if teleport_out_pfx then
                ParticleManager:DestroyParticle(teleport_out_pfx, false)
                ParticleManager:ReleaseParticleIndex(teleport_out_pfx)
            end

            if self:GetCaster():HasModifier("modifier_wisp_18") then
                CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_wisp_relocate_custom_thinker_souls", {duration = self:GetAbility().modifier_wisp_18_duration}, self.point, self:GetCaster():GetTeamNumber(), false)
            end
        else
            self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_wisp_relocate_custom", { duration = return_time, return_time = return_time, point_x = self.point.x, point_y = self.point.y, point_z = self.point.z })
        end
    end
end

modifier_wisp_relocate_custom_thinker = class({})

function modifier_wisp_relocate_custom_thinker:OnCreated()
    if not IsServer() then return end
    local vision_radius = self:GetAbility():GetSpecialValueFor("vision_radius")
    self.fow = AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), vision_radius, self:GetDuration(), false)
    local endpoint_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_relocate_marker_endpoint.vpcf", PATTACH_WORLDORIGIN, self:GetParent())
	ParticleManager:SetParticleControl(endpoint_pfx, 0, self:GetParent():GetAbsOrigin())
    self:AddParticle(endpoint_pfx, false, false, -1, false, false)
end

modifier_wisp_relocate_custom_thinker_end = class({})

function modifier_wisp_relocate_custom_thinker_end:OnCreated()
    if not IsServer() then return end
	self.caster_origin_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_relocate_marker.vpcf", PATTACH_WORLDORIGIN, self:GetParent())
	ParticleManager:SetParticleControl(self.caster_origin_pfx, 0, self:GetParent():GetAbsOrigin())
    self:AddParticle(self.caster_origin_pfx, false, false, -1, false, false)
end

modifier_wisp_relocate_custom = class({})
function modifier_wisp_relocate_custom:IsDebuff() return false end
function modifier_wisp_relocate_custom:IsHidden() return false end
function modifier_wisp_relocate_custom:IsPurgable() return false end
function modifier_wisp_relocate_custom:IsStunDebuff() return false end
function modifier_wisp_relocate_custom:IsPurgeException() return false end
function modifier_wisp_relocate_custom:OnCreated(params)
	if not IsServer() then return end
	self.return_time = params.return_time
	self.return_point = self:GetCaster():GetAbsOrigin()
    self.point = Vector(params.point_x, params.point_y, params.point_z)

    if self:GetCaster():HasModifier("modifier_wisp_18") then
        CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_wisp_relocate_custom_thinker_souls", {duration = self:GetAbility().modifier_wisp_18_duration}, self.point, self:GetCaster():GetTeamNumber(), false)
    end

	local caster_teleport_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_relocate_teleport.vpcf", PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControl(caster_teleport_pfx, 0, self:GetCaster():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(caster_teleport_pfx)

	FindClearSpaceForUnit(self:GetCaster(), self.point, true)
	self:GetCaster():Interrupt()

	local teleport_out_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_relocate_marker_endpoint.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:DestroyParticle(teleport_out_pfx, false)
	ParticleManager:ReleaseParticleIndex(teleport_out_pfx)

    self.modifier_wisp_relocate_custom_thinker_end = CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_wisp_relocate_custom_thinker_end", {duration = self.return_time}, self.return_point, self:GetCaster():GetTeamNumber(), false)

    local modifier_wisp_tether_custom = self:GetCaster():FindModifierByName("modifier_wisp_tether_custom")
    if modifier_wisp_tether_custom and modifier_wisp_tether_custom.target ~= nil and self:GetCaster():IsAlive() then
        local is_allow = true
        if modifier_wisp_tether_custom.target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
            is_allow = false
        end
        if is_allow or self:GetCaster():HasModifier("modifier_wisp_6") then
            FindClearSpaceForUnit(modifier_wisp_tether_custom.target, self.point, true)
            self.ally_teleport_pfx 	= ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_relocate_teleport.vpcf", PATTACH_CUSTOMORIGIN, modifier_wisp_tether_custom.target)
            ParticleManager:SetParticleControlEnt(self.ally_teleport_pfx, 0, modifier_wisp_tether_custom.target, PATTACH_POINT, "attach_hitloc", modifier_wisp_tether_custom.target:GetAbsOrigin(), true)
            modifier_wisp_tether_custom.target:Interrupt()
            if self:GetCaster():HasModifier("modifier_wisp_6") then
                modifier_wisp_tether_custom.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_wisp_relocate_custom_armor_debuff", {duration = self:GetAbility().modifier_wisp_6_duration * (1-modifier_wisp_tether_custom.target:GetStatusResistance())})
            end
        end
    end

    if not self:GetCaster():HasModifier("modifier_wisp_6") then
        self.relocate_timerPfx = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_relocate_timer.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetCaster())
        local timerCP1_x = self.return_time >= 10 and 1 or 0			
        local timerCP1_y = self.return_time % 10
        ParticleManager:SetParticleControl(self.relocate_timerPfx, 1, Vector( timerCP1_x, timerCP1_y, 0 ) )
        self:AddParticle(self.relocate_timerPfx, false, false, -1, false, false)
    end

    if self:GetParent():HasModifier("modifier_wisp_6") then
        self:Destroy()
        return
    end

	self:StartIntervalThink(1.0)
end

function modifier_wisp_relocate_custom:OnIntervalThink()
	self.return_time = self.return_time - 1
	local timerCP1_x = self.return_time >= 10 and 1 or 0
	local timerCP1_y = self.return_time % 10
	ParticleManager:SetParticleControl(self.relocate_timerPfx, 1, Vector( timerCP1_x, timerCP1_y, 0 ) )
end

function modifier_wisp_relocate_custom:OnDestroy()
	if not IsServer() then return end
    if self.modifier_wisp_relocate_custom_thinker_end and not self.modifier_wisp_relocate_custom_thinker_end:IsNull() then
        self.modifier_wisp_relocate_custom_thinker_end:Destroy()
    end
    StopSoundOn("Hero_Wisp.ReturnCounter", self:GetCaster())
    StopSoundOn("Hero_Wisp.Return", self:GetCaster())
    if self:GetParent():HasModifier("modifier_wisp_6") then return end
    if self:GetRemainingTime() > 0 then return end
	EmitSoundOn("Hero_Wisp.TeleportOut", self:GetCaster())
	local caster_teleport_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_relocate_teleport.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(caster_teleport_pfx, 0, self:GetCaster():GetAbsOrigin())
    self:GetCaster():SetAbsOrigin(self.return_point)
    FindClearSpaceForUnit(self:GetCaster(), self.return_point, true)
	self:GetCaster():Interrupt()
    local modifier_wisp_tether_custom = self:GetCaster():FindModifierByName("modifier_wisp_tether_custom")
    if modifier_wisp_tether_custom and modifier_wisp_tether_custom.target ~= nil and self:GetCaster():IsAlive() then
        local is_allow = true
        if modifier_wisp_tether_custom.target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
            is_allow = false
        end
        if is_allow or self:GetCaster():HasModifier("modifier_wisp_6") then
            modifier_wisp_tether_custom.target:SetAbsOrigin(self.return_point + RandomVector(100) )
            FindClearSpaceForUnit(modifier_wisp_tether_custom.target, self.return_point, true)
            self.ally_teleport_pfx 	= ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_relocate_teleport.vpcf", PATTACH_CUSTOMORIGIN, modifier_wisp_tether_custom.target)
            ParticleManager:SetParticleControlEnt(self.ally_teleport_pfx, 0, modifier_wisp_tether_custom.target, PATTACH_POINT, "attach_hitloc", modifier_wisp_tether_custom.target:GetAbsOrigin(), true)
            modifier_wisp_tether_custom.target:Interrupt()
        end
    end
end

modifier_wisp_relocate_custom_armor_debuff = class({})
function modifier_wisp_relocate_custom_armor_debuff:GetTexture() return "wisp_6" end
function modifier_wisp_relocate_custom_armor_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
end
function modifier_wisp_relocate_custom_armor_debuff:GetModifierPhysicalArmorBonus()
    return self:GetAbility().modifier_wisp_6[self:GetCaster():GetTalentLevel("modifier_wisp_6")]
end
function modifier_wisp_relocate_custom_armor_debuff:GetEffectName()
    return "particles/armor_debufff_aghanim.vpcf"
end
function modifier_wisp_relocate_custom_armor_debuff:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

modifier_wisp_relocate_custom_thinker_souls = class({})

function modifier_wisp_relocate_custom_thinker_souls:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/wisp_custom/shadow_thinker.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, Vector(self:GetDuration(), 0, 0))
    self:AddParticle(particle, false, false, -1, false, false)
    self:StartIntervalThink(0.1)
end

function modifier_wisp_relocate_custom_thinker_souls:OnIntervalThink()
    if not IsServer() then return end
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetCaster():GetAoeBonus(self:GetAbility().modifier_wisp_18_radius), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    for _,unit in pairs(units) do
        if not unit:HasModifier("modifier_wisp_relocate_custom_thinker_souls_cooldown") then
            unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_wisp_relocate_custom_thinker_souls_cooldown", {duration = self:GetAbility().modifier_wisp_18_cooldown})
            unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_wisp_relocate_custom_thinker_souls_debuff", {duration = self:GetAbility().modifier_wisp_18_silence_duration * (1-unit:GetStatusResistance())})
        end
    end
end

function modifier_wisp_relocate_custom_thinker_souls:IsAura()
    return self:GetCaster():HasModifier("modifier_wisp_19")
end

function modifier_wisp_relocate_custom_thinker_souls:GetModifierAura()
    return "modifier_wisp_relocate_custom_thinker_souls_buff"
end

function modifier_wisp_relocate_custom_thinker_souls:GetAuraRadius()
    return self:GetCaster():GetAoeBonus(self:GetAbility().modifier_wisp_18_radius)
end

function modifier_wisp_relocate_custom_thinker_souls:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_wisp_relocate_custom_thinker_souls:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_wisp_relocate_custom_thinker_souls:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_wisp_relocate_custom_thinker_souls_debuff = class({})

function modifier_wisp_relocate_custom_thinker_souls_debuff:GetTexture() return "wisp_18" end

function modifier_wisp_relocate_custom_thinker_souls_debuff:CheckState()
    return
    {
        [MODIFIER_STATE_SILENCED] = true,
    }
end

function modifier_wisp_relocate_custom_thinker_souls_debuff:GetEffectName()
    return "particles/generic_gameplay/generic_silence.vpcf"
end

function modifier_wisp_relocate_custom_thinker_souls_debuff:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

modifier_wisp_relocate_custom_thinker_souls_cooldown = class({})
function modifier_wisp_relocate_custom_thinker_souls_cooldown:IsHidden() return true end
function modifier_wisp_relocate_custom_thinker_souls_cooldown:IsPurgable() return false end
function modifier_wisp_relocate_custom_thinker_souls_cooldown:IsPurgeException() return false end

modifier_wisp_relocate_custom_thinker_souls_buff = class({})
function modifier_wisp_relocate_custom_thinker_souls_buff:GetTexture() return "wisp_19" end
function modifier_wisp_relocate_custom_thinker_souls_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
    }
end
function modifier_wisp_relocate_custom_thinker_souls_buff:GetModifierTotalDamageOutgoing_Percentage()
    return self:GetAbility().modifier_wisp_19[self:GetCaster():GetTalentLevel("modifier_wisp_19")]
end