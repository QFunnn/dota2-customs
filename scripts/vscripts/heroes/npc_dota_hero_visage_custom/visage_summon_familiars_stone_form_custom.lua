--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_visage_summon_familiars_stone_form_custom", "heroes/npc_dota_hero_visage_custom/visage_summon_familiars_stone_form_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_visage_summon_familiars_stone_form_custom_root", "heroes/npc_dota_hero_visage_custom/visage_summon_familiars_stone_form_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_visage_summon_familiars_stone_form_custom_buff", "heroes/npc_dota_hero_visage_custom/visage_summon_familiars_stone_form_custom", LUA_MODIFIER_MOTION_NONE)

visage_summon_familiars_stone_form_custom = class({})

visage_summon_familiars_stone_form_custom.modifier_visage_5_cd = -5
visage_summon_familiars_stone_form_custom.modifier_visage_6_radius = {75,150,225}
visage_summon_familiars_stone_form_custom.modifier_visage_6_damage = {40,80,120}
visage_summon_familiars_stone_form_custom.modifier_visage_19_damage = {100,200}
function visage_summon_familiars_stone_form_custom:ProcsMagicStick() return false end

function visage_summon_familiars_stone_form_custom:GetAOERadius()
    return self:GetSpecialValueFor("stun_radius")
end

function visage_summon_familiars_stone_form_custom:GetBehavior()
    if self:GetCaster():GetModifierStackCount("modifier_visage_summon_familiars_stone_form_custom", self:GetCaster()) == 1 then
        return
        DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE +
        DOTA_ABILITY_BEHAVIOR_POINT +
        DOTA_ABILITY_BEHAVIOR_AOE +
        DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL +
        DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE +
        1099511627776
    end
    return
    DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE +
    DOTA_ABILITY_BEHAVIOR_NO_TARGET +
    DOTA_ABILITY_BEHAVIOR_IMMEDIATE +
    DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL +
    DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE +
    1099511627776
end

function visage_summon_familiars_stone_form_custom:GetCooldown(iLevel)
    local cooldown = self.BaseClass.GetCooldown(self, iLevel)
    if self:GetCaster():HasModifier("modifier_visage_summon_familiars_custom_cooldown") then
        cooldown = cooldown + self.modifier_visage_5_cd
    end
    return math.max(cooldown, 0)
end

function visage_summon_familiars_stone_form_custom:GetIntrinsicModifierName()
    return "modifier_visage_summon_familiars_stone_form_custom"
end

function visage_summon_familiars_stone_form_custom:OnSpellStart(is_die)
    if not IsServer() then return end
    self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_visage_summon_familiars_stone_form_custom_root", {duration = self:GetSpecialValueFor("stun_delay"), is_die = is_die})
end

modifier_visage_summon_familiars_stone_form_custom_root = class({})
function modifier_visage_summon_familiars_stone_form_custom_root:IsPurgable() return false end
function modifier_visage_summon_familiars_stone_form_custom_root:OnCreated(params)
    if not IsServer() then return end
    self.is_die = params.is_die
    local visage_summon_familiars_recall_custom = self:GetCaster():FindAbilityByName("visage_summon_familiars_recall_custom")
    if visage_summon_familiars_recall_custom then
        visage_summon_familiars_recall_custom:SetActivated(false)
    end
end
function modifier_visage_summon_familiars_stone_form_custom_root:OnDestroy()
	if not IsServer() or not self:GetAbility() or self:GetRemainingTime() > 0 then return end
	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_visage_summon_familiars_stone_form_custom_buff", {duration = self:GetAbility():GetSpecialValueFor("stone_duration"), is_die = self.is_die})
end
function modifier_visage_summon_familiars_stone_form_custom_root:CheckState()
	local disarmed = true
	local hero = self:GetCaster() and self:GetCaster():GetOwner()
	if hero and not hero:IsNull() and hero:HasModifier("modifier_visage_14") then
		disarmed = false
	end
	return
    {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = disarmed,
		[MODIFIER_STATE_SILENCED] = true,
	}
end

modifier_visage_summon_familiars_stone_form_custom_buff = class({})

function modifier_visage_summon_familiars_stone_form_custom_buff:GetEffectName()
	return "particles/units/heroes/hero_visage/visage_stone_form_area_energy.vpcf"
end

function modifier_visage_summon_familiars_stone_form_custom_buff:OnCreated(params)
	if not self:GetAbility() then self:Destroy() return end
	self.hp_regen = self:GetAbility():GetSpecialValueFor("hp_regen")
	if not IsServer() then return end
    self.is_die = params.is_die
	self.stun_radius = self:GetAbility():GetSpecialValueFor("stun_radius")
	self.stun_damage = self:GetAbility():GetSpecialValueFor("stun_damage")
	local hero = self:GetCaster() and self:GetCaster():GetOwner()
	if hero and not hero:IsNull() and hero:HasModifier("modifier_visage_6") then
		local level = hero:GetTalentLevel("modifier_visage_6")
		self.stun_radius = self.stun_radius + self:GetAbility().modifier_visage_6_radius[level]
		self.stun_damage = self.stun_damage + (self:GetCaster():GetMaxHealth() * self:GetAbility().modifier_visage_6_damage[level] / 100)
	end
    if hero and not hero:IsNull() and hero:HasModifier("modifier_visage_19") then
		local level = hero:GetTalentLevel("modifier_visage_19")
		self.stun_damage = self.stun_damage + (self:GetParent():GetAverageTrueAttackDamage(nil) * self:GetAbility().modifier_visage_19_damage[level] / 100)
	end
	self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")
	self.stone_duration	= self:GetAbility():GetSpecialValueFor("stone_duration")
	self:GetParent():EmitSound("Visage_Familar.StoneForm.Cast")
	local stone_form_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_visage/visage_stone_form.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(stone_form_particle, 1, Vector(self.stun_radius, 1, 1))
	self:AddParticle(stone_form_particle, false, false, -1, false, false)
	GridNav:DestroyTreesAroundPoint(self:GetParent():GetAbsOrigin(), self:GetParent():GetHullRadius(), true)
	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self.stun_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
	local damageTable = { victim = nil, damage = self.stun_damage, damage_type	= self:GetAbility():GetAbilityDamageType(), damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetParent(), ability = self:GetAbility()}
	if #enemies >= 1 then
		self:GetParent():EmitSound("Visage_Familar.StoneForm.Stun")
	end
	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_stunned", {duration = self.stun_duration * (1 - enemy:GetStatusResistance())})
		damageTable.victim	= enemy
		ApplyDamage(damageTable)
	end
	self.counter = self.stone_duration
	self:StartIntervalThink(1)
end

function modifier_visage_summon_familiars_stone_form_custom_buff:OnIntervalThink()
	self.counter = self.counter - 1
	self.stone_form_overhead_particle = ParticleManager:CreateParticleForTeam("particles/units/heroes/hero_visage/visage_stoneform_overhead_timer.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent(), self:GetParent():GetTeamNumber())
	ParticleManager:SetParticleControl(self.stone_form_overhead_particle, 1, Vector(0, self.counter, 0))
	ParticleManager:SetParticleControl(self.stone_form_overhead_particle, 2, Vector(1, 0, 0))
	ParticleManager:ReleaseParticleIndex(self.stone_form_overhead_particle)
end

function modifier_visage_summon_familiars_stone_form_custom_buff:OnDestroy()
    if not IsServer() then return end
	local stone_form_transform_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_visage/visage_familiar_transform.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:ReleaseParticleIndex(stone_form_transform_particle)
    local visage_summon_familiars_recall_custom = self:GetCaster():FindAbilityByName("visage_summon_familiars_recall_custom")
    if visage_summon_familiars_recall_custom then
        visage_summon_familiars_recall_custom:SetActivated(true)
    end
    local parent = self:GetParent()
    if self.is_die then
        local particle = ParticleManager:CreateParticle("particles/econ/events/fall_2021/blink_dagger_fall_2021_end.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
        parent:AddNoDraw()
        parent:ForceKill(false)
    end
end

function modifier_visage_summon_familiars_stone_form_custom_buff:CheckState()
	if not IsServer() then return end
	local stunned = true
    local rooted = true
	local hero = self:GetCaster() and self:GetCaster():GetOwner()
	if hero and not hero:IsNull() and hero:HasModifier("modifier_visage_14") then
		stunned = false
	end
	return
    {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_STUNNED] = stunned,
        [MODIFIER_STATE_ROOTED] = true
	}
end

function modifier_visage_summon_familiars_stone_form_custom_buff:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_VISUAL_Z_DELTA
		
	}
end

function modifier_visage_summon_familiars_stone_form_custom_buff:GetModifierConstantHealthRegen()
	return self.hp_regen
end

function modifier_visage_summon_familiars_stone_form_custom_buff:GetVisualZDelta()
	return 0
end

modifier_visage_summon_familiars_stone_form_custom = class({})
function modifier_visage_summon_familiars_stone_form_custom:IsHidden() return true end
function modifier_visage_summon_familiars_stone_form_custom:IsPurgable() return false end
function modifier_visage_summon_familiars_stone_form_custom:IsPurgeException() return false end
function modifier_visage_summon_familiars_stone_form_custom:RemoveOnDeath() return false end
function modifier_visage_summon_familiars_stone_form_custom:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end
function modifier_visage_summon_familiars_stone_form_custom:OnIntervalThink()
    if not IsServer() then return end
    if self:GetStackCount() == 0 and self:GetAbility():GetAltCastState() then
        self:SetStackCount(1)
    elseif self:GetStackCount() == 1 and not self:GetAbility():GetAltCastState() then
        self:SetStackCount(0)
    end
end