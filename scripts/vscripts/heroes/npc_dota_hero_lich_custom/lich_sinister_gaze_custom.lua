--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lich_sinister_gaze_custom", "heroes/npc_dota_hero_lich_custom/lich_sinister_gaze_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lich_sinister_gaze_custom_debuff", "heroes/npc_dota_hero_lich_custom/lich_sinister_gaze_custom", LUA_MODIFIER_MOTION_NONE)

lich_sinister_gaze_custom = class({})


lich_sinister_gaze_custom.modifier_lich_1 = {1,2,3}
lich_sinister_gaze_custom.modifier_lich_1_radius = 600
lich_sinister_gaze_custom.modifier_lich_2 = 150
lich_sinister_gaze_custom.modifier_lich_4 = {-3,-6}
lich_sinister_gaze_custom.modifier_lich_6 = {0.2,0.4,0.6}

function lich_sinister_gaze_custom:GetCooldown(level)
    local bonus = 0
	if self:GetCaster():HasModifier("modifier_lich_4") then
		bonus = self.modifier_lich_4[self:GetCaster():GetTalentLevel("modifier_lich_4")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function lich_sinister_gaze_custom:GetIntrinsicModifierName()
    return "modifier_lich_sinister_gaze_custom"
end

function lich_sinister_gaze_custom:GetChannelTime()
	return self:GetCaster():GetModifierStackCount("modifier_lich_sinister_gaze_custom", self:GetCaster()) * 0.01
end

function lich_sinister_gaze_custom:OnSpellStart()
    if not IsServer() then return end
	self.target = self:GetCursorTarget()
    self.heroes = {}
    if self.target:TriggerSpellAbsorb( self ) then
		self:GetCaster():Stop()
        self:GetCaster():Interrupt()
		return
	end
    self:GetCaster():EmitSound("Hero_Lich.SinisterGaze.Cast")

    if self:GetCaster():HasModifier("modifier_lich_1") then
        local max = 1 + self.modifier_lich_1[self:GetCaster():GetTalentLevel("modifier_lich_1")]
        table.insert(self.heroes, self.target)
        local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self.modifier_lich_1_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)
        local creeps = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self.modifier_lich_1_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)
        for _, hero in pairs(enemies) do
            if max > 0 then
                max = max - 1
                table.insert(self.heroes, hero)
            else
                break
            end
        end
        if max > 0 then
            for _, creep in pairs(creeps) do
                if max > 0 then
                    max = max - 1
                    table.insert(self.heroes, creep)
                else
                    break
                end
            end
        end
        for _, target_new in pairs(self.heroes) do
            target_new:EmitSound("Hero_Lich.SinisterGaze.Target")
            local duration = self:GetChannelTime()
            local bonus = 0
            if self:GetCaster():HasModifier("modifier_lich_6") then
                bonus = self.modifier_lich_6[self:GetCaster():GetTalentLevel("modifier_lich_6")]
            end
            if target_new:IsHero() then
                duration = (self:GetSpecialValueFor("channel_duration") + bonus)
            else
                duration = (self:GetSpecialValueFor("channel_duration") + bonus) * self:GetSpecialValueFor("creep_duration_multiplier")
            end
            target_new:AddNewModifier(self:GetCaster(), self, "modifier_lich_sinister_gaze_custom_debuff", {duration = duration * (1-target_new:GetStatusResistance())})
            target_new:AddNewModifier(self:GetCaster(), nil, "modifier_truesight", {duration = duration * (1-target_new:GetStatusResistance())})
        end
    else
        self.target:EmitSound("Hero_Lich.SinisterGaze.Target")
        self.target:AddNewModifier(self:GetCaster(), self, "modifier_lich_sinister_gaze_custom_debuff", {duration = self:GetChannelTime() * (1-self.target:GetStatusResistance())})
        self.target:AddNewModifier(self:GetCaster(), nil, "modifier_truesight", {duration = self:GetChannelTime() * (1-self.target:GetStatusResistance())})
    end
end

function lich_sinister_gaze_custom:OnChannelThink(flInterval)
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_lich_1") then
        local apply = true
        for _, hero in pairs(self.heroes) do
            if hero:HasModifier("modifier_lich_sinister_gaze_custom_debuff") then
                apply = false
            end
        end
        if apply then
            if self:IsChanneling() then
                self:EndChannel(false)
                self:GetCaster():MoveToPositionAggressive(self:GetCaster():GetAbsOrigin())
            end
        end
    end
end

function lich_sinister_gaze_custom:OnChannelFinish(bInterrupted)
	if not IsServer() then return end
    if self.target then
        self.target:RemoveModifierByName("modifier_lich_sinister_gaze_custom_debuff")
        self.target:RemoveModifierByName("modifier_truesight")
    end
    if self.heroes and #self.heroes > 0 then
        for _, target in pairs(self.heroes) do
            target:RemoveModifierByName("modifier_lich_sinister_gaze_custom_debuff")
            target:RemoveModifierByName("modifier_truesight")
        end
    end
end

modifier_lich_sinister_gaze_custom = class({})
function modifier_lich_sinister_gaze_custom:IsHidden() return true end
function modifier_lich_sinister_gaze_custom:IsPurgable() return false end
function modifier_lich_sinister_gaze_custom:GetAttributes()	return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_lich_sinister_gaze_custom:DeclareFunctions()
	return {MODIFIER_EVENT_ON_ABILITY_EXECUTED}
end
function modifier_lich_sinister_gaze_custom:OnAbilityExecuted(params)
	if not IsServer() then return end
    if params.ability == nil then return end
    if params.ability ~= self:GetAbility() then return end
    if params.ability:GetCaster() ~= self:GetCaster() then return end
    if params.target == nil then return end
    local bonus = 0
    if self:GetParent():HasModifier("modifier_lich_6") then
        bonus = self:GetAbility().modifier_lich_6[self:GetParent():GetTalentLevel("modifier_lich_6")]
    end
    if params.target:IsHero() then
        self:SetStackCount( (self:GetAbility():GetSpecialValueFor("channel_duration")+bonus) * 100)
    else
        self:SetStackCount( ((self:GetAbility():GetSpecialValueFor("channel_duration")+bonus) * self:GetAbility():GetSpecialValueFor("creep_duration_multiplier")) * 100)
    end
end

modifier_lich_sinister_gaze_custom_debuff = class({})

function modifier_lich_sinister_gaze_custom_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_lich_gaze.vpcf"
end

function modifier_lich_sinister_gaze_custom_debuff:OnCreated()
	if not IsServer() then return end
    self.interval = FrameTime()
    self.current_mana = 0
    if self:GetParent().GetMana then
		self.current_mana = self:GetParent():GetMana()
	end
    self.destination = self:GetAbility():GetSpecialValueFor("destination")
    self.duration = self:GetRemainingTime()
    self.mana_drain = self:GetAbility():GetSpecialValueFor("mana_drain")
	self.mana_per_interval	= (self.current_mana * self.mana_drain * 0.01) / (self.duration / self.interval)
    self.damage = self:GetAbility():GetSpecialValueFor("creep_damage") * self.interval
    self.damage_hero = self:GetAbility().modifier_lich_2 * self.interval
    self.distance = CalcDistanceBetweenEntityOBB(self:GetCaster(), self:GetParent()) * (self.destination / 100)
    self.status_resistance = self:GetParent():GetStatusResistance()

	if self:GetCaster():GetName() == "npc_dota_hero_lich" then
		self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lich/lich_gaze.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControlEnt(self.particle, 0, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(self.particle, 2, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_portrait", self:GetCaster():GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(self.particle, 3, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetCaster():GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(self.particle, 10, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetAbsOrigin(), true)
		self:AddParticle(self.particle, false, false, -1, false, false)
        ----------------------------------------------------------------------------------------------------------------------------------------------------------
		self.particle2 = ParticleManager:CreateParticle("particles/units/heroes/hero_lich/lich_gaze_eyes.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControlEnt(self.particle2, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_eye_l", self:GetCaster():GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(self.particle2, 2, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_eye_r", self:GetCaster():GetAbsOrigin(), true)
		self:AddParticle(self.particle2, false, false, -1, false, false)
	end
    if not self:GetParent():IsDebuffImmune() then
	    self:GetParent():Interrupt()
	    self:GetParent():MoveToNPC(self:GetCaster())
    end
	self:StartIntervalThink(self.interval)
end

function modifier_lich_sinister_gaze_custom_debuff:OnIntervalThink()
	if self:GetCaster():IsNull() or self:GetAbility():IsNull() or not self:GetAbility():IsChanneling() then
		self:Destroy()
	else
        if not self:GetParent():IsDebuffImmune() then
            self:GetParent():MoveToNPC(self:GetCaster())
		    self:GetParent():Script_ReduceMana(self.mana_per_interval, self:GetAbility())
        end
        if not self:GetParent():IsHero() then
            ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
        end
        if self:GetParent():IsHero() and self:GetCaster():HasModifier("modifier_lich_2") then
            ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage_hero, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
        end
		if self:GetCaster().GiveMana then
			self:GetCaster():GiveMana(self.mana_per_interval)
		end
	end
end

function modifier_lich_sinister_gaze_custom_debuff:OnDestroy()
	if not IsServer() then return end
    if not self:GetParent():IsDebuffImmune() then
	    self:GetParent():Interrupt()
        self:GetParent():Stop()
    end
	GridNav:DestroyTreesAroundPoint(self:GetParent():GetAbsOrigin(), 100, false)
    if not self:GetCaster():HasModifier("modifier_lich_1") then
        if self:GetAbility():IsChanneling() then
            self:GetAbility():EndChannel(false)
            self:GetCaster():MoveToPositionAggressive(self:GetCaster():GetAbsOrigin())
        end
    end
end

function modifier_lich_sinister_gaze_custom_debuff:CheckState()
	return 
    {
		[MODIFIER_STATE_HEXED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
        [MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true
	}
end

function modifier_lich_sinister_gaze_custom_debuff:DeclareFunctions()
	return {MODIFIER_PROPERTY_MOVESPEED_LIMIT}
end

function modifier_lich_sinister_gaze_custom_debuff:GetModifierMoveSpeed_Limit()
	if not IsServer() then return end
	return self.distance / (self:GetAbility():GetChannelTime() * (1 - math.min(self.status_resistance, 0.9999)))
end