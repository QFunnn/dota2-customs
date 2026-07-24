--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_razor_static_link_custom", "heroes/npc_dota_hero_razor_custom/razor_static_link_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_static_link_custom_target", "heroes/npc_dota_hero_razor_custom/razor_static_link_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_static_link_custom_caster", "heroes/npc_dota_hero_razor_custom/razor_static_link_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_static_link_custom_attacking", "heroes/npc_dota_hero_razor_custom/razor_static_link_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_static_link_custom_handler", "heroes/npc_dota_hero_razor_custom/razor_static_link_custom", LUA_MODIFIER_MOTION_NONE)

razor_static_link_custom = class({})

razor_static_link_custom.modifier_razor_13 = 3
razor_static_link_custom.modifier_razor_11 = {2,4}
razor_static_link_custom.modifier_razor_8 = {1,2}
razor_static_link_custom.modifier_razor_14 = 4

function razor_static_link_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle","particles/units/heroes/hero_razor/razor_static_link.vpcf", context )
end

function razor_static_link_custom:CastFilterResultTarget( target )
	if not target:IsHero() and not self:GetCaster():HasModifier("modifier_razor_8") then
		return UF_FAIL_CREEP
	end

	local nResult = UnitFilter(
		target,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		self:GetCaster():GetTeamNumber()
	)

	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end

function razor_static_link_custom:GetIntrinsicModifierName()
    return "modifier_razor_static_link_custom_handler"
end

function razor_static_link_custom:GetCastPoint()
    if self:GetCaster():HasModifier("modifier_razor_14") then
        return 0
    end
    return 0.3
end

function razor_static_link_custom:OnAbilityPhaseStart()
	local target = self:GetCursorTarget()
    local modifier_razor_static_link_custom_target = target:FindModifierByName("modifier_razor_static_link_custom_target")
	if modifier_razor_static_link_custom_target and modifier_razor_static_link_custom_target:GetDuration() <= -1 then
        local player = PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID())
        if player then
            CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message="#dota_hud_error_cant_cast_twice"})
        end
        return false
    end
	return true
end

function razor_static_link_custom:OnSpellStart(new_target)
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb(self) then return end
    local duration = self:GetSpecialValueFor("drain_length")
    if self:GetCaster():HasModifier("modifier_razor_8") and not target:IsHero() then
        duration = duration / 2
        Timers:CreateTimer(0, function()
            self:EndCooldown()
            self:StartCooldown(self:GetEffectiveCooldown(-1) / 2)
        end)
    end
    local static_links = 
    {
        "modifier_razor_armor_link_custom",
        "modifier_razor_magic_link_custom",
        "modifier_razor_spell_link_custom",
    }
    for _, mod in pairs(static_links) do
        local mods = caster:FindAllModifiersByName(mod)
        for _, mod_handle in pairs(mods) do
            mod_handle:Destroy()
        end
    end
    caster:EmitSound("Ability.static.start")
    caster:AddNewModifier(caster, self, "modifier_razor_static_link_custom", {target = target:entindex(), duration = duration})
end 

modifier_razor_static_link_custom = class({})
function modifier_razor_static_link_custom:IsHidden() return true end
function modifier_razor_static_link_custom:IsPurgable() return false end 
function modifier_razor_static_link_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_razor_static_link_custom:OnCreated(table)
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()
    if not IsServer() then return end
    self.target = EntIndexToHScript(table.target)
    if not self.target or self.target:IsNull() then 
        self:Destroy()
        return
    end
    self.caster:AddNewModifier(self.caster, self.ability, "modifier_razor_static_link_custom_attacking", {target = self.target:entindex()})
    self.caster:EmitSound("Ability.static.loop")
    self.caster:StartGesture(ACT_DOTA_CAST_ABILITY_2)
    self.total_duration = self.ability:GetSpecialValueFor("drain_length")
    self.total_damage = self.ability:GetSpecialValueFor("drain_rate") * self.total_duration
    self.damage_rate = self.total_damage / self.total_duration
    self.max_range = self.ability:GetSpecialValueFor("AbilityCastRange") + self.caster:GetCastRangeBonus() + self.ability:GetSpecialValueFor("drain_range_buffer")
    self.duration = self.ability:GetSpecialValueFor("drain_duration")
    if self:GetCaster():HasModifier("modifier_razor_13") then
        self.duration = self.duration + self:GetAbility().modifier_razor_13
    end
    self.vision_radius = self.ability:GetSpecialValueFor("radius")
    self.damage_count = 0 
    if self:GetCaster():HasModifier("modifier_razor_11") then
        self.damage_count = self:GetAbility().modifier_razor_11[self:GetCaster():GetTalentLevel("modifier_razor_11")] * self.damage_rate
    end
    self.interval = FrameTime()
    self.target_mod = self.target:AddNewModifier(self.caster, self.ability, "modifier_razor_static_link_custom_target", {})
    self.caster_mod = self.caster:AddNewModifier(self.caster, self.ability, "modifier_razor_static_link_custom_caster", {})
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_razor/razor_static_link.vpcf", PATTACH_POINT_FOLLOW, self.caster)
    ParticleManager:SetParticleControlEnt(self.particle, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_static", self.caster:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(self.particle, 1, self.target, PATTACH_POINT_FOLLOW, "attach_hitloc", self.target:GetAbsOrigin(), true)
    self:AddParticle( self.particle, false, false, -1, false, false )
    self:OnIntervalThink()
    self:StartIntervalThink(self.interval)
end

function modifier_razor_static_link_custom:OnIntervalThink()
    if not IsServer() then return end
    if not self.target or self.target:IsNull() or not self.target:IsAlive() or (self.target:GetAbsOrigin() - self.caster:GetAbsOrigin()):Length2D() > self.max_range then 
        self:Destroy()
        return
    end 
    AddFOWViewer(self.caster:GetTeamNumber(), self.target:GetAbsOrigin(), self.vision_radius, self.interval*2, true)
    self.damage_count = self.damage_count + self.damage_rate * self.interval
    if self.target_mod and not self.target_mod:IsNull() then 
        self.target_mod:SetStackCount(self.damage_count)
    end 
    if self.caster_mod and not self.caster_mod:IsNull() then 
        self.caster_mod:SetStackCount(self.damage_count)
    end
end 

function modifier_razor_static_link_custom:OnDestroy()
    if IsServer() then
        self.caster:StopSound("Ability.static.loop")
    end
    if self.target_mod and not self.target_mod:IsNull() then 
        self.target_mod:SetDuration(self.duration, true)
    end 
    if self.caster_mod and not self.caster_mod:IsNull() then 
        self.caster_mod:SetDuration(self.duration, true)
    end 
    if not IsServer() then return end
    self.caster:RemoveModifierByName("modifier_razor_static_link_custom_attacking")
    self.caster:StopSound("Ability.static.loop")
    self.caster:EmitSound("Ability.static.end")
end

function modifier_razor_static_link_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_EVENT_ON_ORDER,
    }
end

function modifier_razor_static_link_custom:GetOverrideAnimation()
    return ACT_DOTA_OVERRIDE_ABILITY_2
end

function modifier_razor_static_link_custom:OnOrder( params )
    if params.unit~=self.caster then return end
    if params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET and params.target  then
        if params.target ~= self.target then 
            self.caster:RemoveModifierByName("modifier_razor_static_link_custom_attacking")
        end
        if params.target == self.target then 
            self.caster:AddNewModifier(self.caster, self.ability, "modifier_razor_static_link_custom_attacking", {target = self.target:entindex()})
        end 
    end
    if params.order_type == DOTA_UNIT_ORDER_STOP or params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION then
        self.caster:RemoveModifierByName("modifier_razor_static_link_custom_attacking") 
    end
end

modifier_razor_static_link_custom_attacking = class({})
function modifier_razor_static_link_custom_attacking:IsHidden() return true end
function modifier_razor_static_link_custom_attacking:IsPurgable() return false end
function modifier_razor_static_link_custom_attacking:OnCreated(table)
    if not IsServer() then return end
    self.target = EntIndexToHScript(table.target)
    if not self.target or self.target:IsNull() then 
        self:Destroy()
        return
    end 
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()
    self.attack_count = 0
    self.attack_max = 1/self.caster:GetAttacksPerSecond(true)
    self.interval = FrameTime()
    self:OnIntervalThink()
    self:StartIntervalThink(FrameTime())
end 

function modifier_razor_static_link_custom_attacking:OnIntervalThink()
    if not IsServer() then return end 
    if not self.target or self.target:IsNull() or not self.target:IsAlive()  then 
        self:Destroy()
        return
    end 
    self.attack_count = self.attack_count + self.interval
    self.attack_max = 1/self.caster:GetAttacksPerSecond(true)
    local dir = (self.target:GetAbsOrigin() - self.caster:GetAbsOrigin())
    if self.attack_count >= self.attack_max and not self.caster:IsStunned() and not self.caster:IsDisarmedCustom({["modifier_razor_static_link_custom_attacking"] = true,}) and not self.caster:IsHexed() and not self.caster:IsChanneling() then 
        self.attack_count = 0
        self.caster:FadeGesture(ACT_DOTA_ATTACK)
        self.caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, self.caster:GetDisplayAttackSpeed() / 100)
        self.caster:PerformAttack(self.target, true, true, false, false, true, false, false)
    end 
    dir.z = 0
    if not self.caster:IsCurrentlyHorizontalMotionControlled() and not self.caster:IsCurrentlyVerticalMotionControlled() and not self.caster:GetCurrentActiveAbility() then
        dir = dir:Normalized()
        local yaw = math.deg(math.atan2(dir.y, dir.x))
        self.caster:SetAngles(0, yaw, 0)
        --self.caster:SetForwardVector(dir:Normalized())
        self.caster:FaceTowards(self.target:GetAbsOrigin())
    end
    self.rotate_interval = 0
end

function modifier_razor_static_link_custom_attacking:DeclareFunctions()
	return
    {
    	MODIFIER_PROPERTY_DISABLE_TURNING,
        MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
	}
end

function modifier_razor_static_link_custom_attacking:GetModifierDisableTurning()
	return 1
end

function modifier_razor_static_link_custom_attacking:GetModifierIgnoreCastAngle()
	return 1
end

function modifier_razor_static_link_custom_attacking:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true
    }
end

modifier_razor_static_link_custom_caster = class({})
function modifier_razor_static_link_custom_caster:IsHidden() return false end 
function modifier_razor_static_link_custom_caster:IsPurgable() return false end
function modifier_razor_static_link_custom_caster:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_razor_static_link_custom_caster:OnCreated()
    if not IsServer() then return end
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_razor/razor_static_link_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    self:AddParticle( self.particle, false, false, -1, false, false )
    self.modifier_razor_14 = self:GetCaster():HasModifier("modifier_razor_14")
    if not self.modifier_razor_14 then return end
    local modifier_razor_static_link_custom_handler = self:GetCaster():FindModifierByName("modifier_razor_static_link_custom_handler")
    if modifier_razor_static_link_custom_handler then
        modifier_razor_static_link_custom_handler:IncrementStackCount()
    end
end 

function modifier_razor_static_link_custom_caster:OnStackCountChanged(iStackCount)
    if not IsServer() then return end 
    if not self.particle then return end 
    ParticleManager:SetParticleControl(self.particle, 1, Vector(self:GetStackCount(), 0, 0))
end 

function modifier_razor_static_link_custom_caster:OnDestroy()
    if not IsServer() then return end
    if not self.modifier_razor_14 then return end
    local modifier_razor_static_link_custom_handler = self:GetCaster():FindModifierByName("modifier_razor_static_link_custom_handler")
    if modifier_razor_static_link_custom_handler then
        modifier_razor_static_link_custom_handler:DecrementStackCount()
    end
end

function modifier_razor_static_link_custom_caster:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
end 

function modifier_razor_static_link_custom_caster:GetModifierPreAttack_BonusDamage()
    return self:GetStackCount()
end


modifier_razor_static_link_custom_target = class({})
function modifier_razor_static_link_custom_target:IsHidden() return false end 
function modifier_razor_static_link_custom_target:IsPurgable() return false end
function modifier_razor_static_link_custom_target:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_razor_static_link_custom_target:OnCreated()
    if not IsServer() then return end
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_razor/razor_static_link_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    self:AddParticle( self.particle, false, false, -1, false, false )
end 

function modifier_razor_static_link_custom_target:OnStackCountChanged(iStackCount)
    if not IsServer() then return end 
    if not self.particle then return end 
    ParticleManager:SetParticleControl(self.particle, 1, Vector(self:GetStackCount(), 0, 0))
end 

function modifier_razor_static_link_custom_target:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
end 

function modifier_razor_static_link_custom_target:GetModifierPreAttack_BonusDamage()
    return self:GetStackCount() * -1
end

modifier_razor_static_link_custom_handler = class({})
function modifier_razor_static_link_custom_handler:GetTexture() return "razor_14" end
function modifier_razor_static_link_custom_handler:IsHidden() return self:GetStackCount() <= 0 end
function modifier_razor_static_link_custom_handler:IsPurgable() return false end
function modifier_razor_static_link_custom_handler:RemoveOnDeath() return false end
function modifier_razor_static_link_custom_handler:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
    }
end

function modifier_razor_static_link_custom_handler:GetModifierAttackSpeedPercentage()
    return self:GetStackCount() * self:GetAbility().modifier_razor_14
end

function modifier_razor_static_link_custom_handler:GetModifierTotalDamageOutgoing_Percentage()
    return self:GetStackCount() * self:GetAbility().modifier_razor_14
end