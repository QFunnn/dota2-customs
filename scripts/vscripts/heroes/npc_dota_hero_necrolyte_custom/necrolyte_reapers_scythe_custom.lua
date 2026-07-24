--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_necrolyte_reapers_scythe_custom", "heroes/npc_dota_hero_necrolyte_custom/necrolyte_reapers_scythe_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_necrolyte_reapers_scythe_custom_buff", "heroes/npc_dota_hero_necrolyte_custom/necrolyte_reapers_scythe_custom", LUA_MODIFIER_MOTION_NONE)

necrolyte_reapers_scythe_custom = class({})

necrolyte_reapers_scythe_custom.modifier_necrolyte_16 = {-10,-20,-30}
necrolyte_reapers_scythe_custom.modifier_necrolyte_17 = 1

function necrolyte_reapers_scythe_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/necrolyte_scythe_start_custom.vpcf", context )
    PrecacheResource( "particle_folder", "particles/units/heroes/hero_necrolyte/", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_necrolyte.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_necrolyte.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_necrolyte.vpcf", context)
end

function necrolyte_reapers_scythe_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_necrolyte_2") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, iLevel)
end

function necrolyte_reapers_scythe_custom:GetHealthCost(iLevel)
    if self:GetCaster():HasModifier("modifier_necrolyte_2") then
        return self.BaseClass.GetManaCost(self, iLevel)
    end
    return 0
end

function necrolyte_reapers_scythe_custom:GetIntrinsicModifierName()
    return "modifier_necrolyte_reapers_scythe_custom_buff"
end

function necrolyte_reapers_scythe_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_necrolyte_16") then
        bonus = self.modifier_necrolyte_16[self:GetCaster():GetTalentLevel("modifier_necrolyte_16")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function necrolyte_reapers_scythe_custom:CastFilterResultTarget( target )
    local find_target = DOTA_UNIT_TARGET_HERO

    if target:HasModifier("modifier_wodacreepchampion") then
		return UF_FAIL_ANCIENT
	end

	if target:HasModifier("modifier_wodacreepchampionred") then
		return UF_FAIL_ANCIENT
	end

    if string.find(target:GetUnitName(), "boss_") then
        return UF_FAIL_ANCIENT
    end

    if self:GetCaster():HasModifier("modifier_necrolyte_16") then
        find_target = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
    end

    if self:GetCaster():HasModifier("modifier_necrolyte_17") then
        find_target = DOTA_UNIT_TARGET_BASIC
    end

	local nResult = UnitFilter(
		target,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		find_target,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,
		self:GetCaster():GetTeamNumber()
	)

	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end

function necrolyte_reapers_scythe_custom:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    if target:TriggerSpellAbsorb(self) then return end
    self:GetCaster():EmitSound("Hero_Necrolyte.ReapersScythe.Cast")
	target:EmitSound("Hero_Necrolyte.ReapersScythe.Target")
    local stun_duration = self:GetSpecialValueFor("stun_duration")
    target:AddNewModifier(self:GetCaster(), self, "modifier_necrolyte_reapers_scythe_custom", {duration = stun_duration})
end

modifier_necrolyte_reapers_scythe_custom = class({})
function modifier_necrolyte_reapers_scythe_custom:IsPurgable() return false end
function modifier_necrolyte_reapers_scythe_custom:IsPurgeException() return false end
function modifier_necrolyte_reapers_scythe_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_necrolyte_reapers_scythe_custom:OnCreated()
	if not IsServer() then return end

    self.damage_per_health = self:GetAbility():GetSpecialValueFor("damage_per_health")

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_necrolyte/necrolyte_scythe_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)

	local particle_2 = ParticleManager:CreateParticle("particles/generic_gameplay/generic_stunned.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
	self:AddParticle(particle_2, false, false, -1, false, false)

	local particle_3 = ParticleManager:CreateParticle("particles    /units/heroes/hero_necrolyte/necrolyte_scythe_orig.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControl(particle_3, 1, self:GetParent():GetAbsOrigin())
	self:AddParticle(particle_3, false, false, -1, false, false)
end

function modifier_necrolyte_reapers_scythe_custom:GetEffectName()
	return "particles/units/heroes/hero_necrolyte/necrolyte_scythe.vpcf"
end

function modifier_necrolyte_reapers_scythe_custom:StatusEffectPriority()
	return MODIFIER_PRIORITY_ULTRA
end

function modifier_necrolyte_reapers_scythe_custom:GetPriority()
	return MODIFIER_PRIORITY_ULTRA
end

function modifier_necrolyte_reapers_scythe_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_necrolyte_reapers_scythe_custom:CheckState()
	return
    {
        [MODIFIER_STATE_STUNNED] = true
    }
end

function modifier_necrolyte_reapers_scythe_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_DISABLE_TURNING,
        MODIFIER_EVENT_ON_TAKEDAMAGE_KILLCREDIT
    }
end

function modifier_necrolyte_reapers_scythe_custom:GetModifierDisableTurning()
    return 1
end

function modifier_necrolyte_reapers_scythe_custom:OnRemoved()
	if not IsServer() then return end
    if not self:GetParent():IsAlive() then
        local modifier_necrolyte_reapers_scythe_custom_buff = self:GetCaster():FindModifierByName("modifier_necrolyte_reapers_scythe_custom_buff")
        if modifier_necrolyte_reapers_scythe_custom_buff then
            modifier_necrolyte_reapers_scythe_custom_buff:IncrementStackCount()
        end
        return 
    end

    if not self:GetParent():IsHero() then
        SendOverheadEventMessage(nil, OVERHEAD_ALERT_DAMAGE, self:GetParent(), self:GetParent():GetMaxHealth(), nil)
        if self:GetParent():GetUnitName() ~= "npc_dota_creature_barrel" and self:GetParent():GetUnitName() ~= "small_barrel" and self:GetParent():GetUnitName() ~= "small_barrel_side" and self:GetParent():GetUnitName() ~= "big_barrel" and self:GetParent():GetUnitName() ~= "boss_1_pve" and self:GetParent():GetUnitName() ~= "boss_2_pve" and self:GetParent():GetUnitName() ~= "boss_3_pve" and self:GetParent():GetUnitName() ~= "boss_4_pve" and self:GetParent():GetUnitName() ~= "boss_5_pve" and self:GetParent():GetUnitName() ~= "boss_6_pve" and self:GetParent():GetUnitName() ~= "boss_3" and self:GetParent():GetUnitName() ~= "boss_5" then 
            self:GetParent():Kill(self:GetAbility(), self:GetCaster())
        end
    else
        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", {duration = FrameTime()})
        local damage = (self:GetParent():GetMaxHealth() - self:GetParent():GetHealth()) * self.damage_per_health
        local actually_dmg = ApplyDamage({attacker = self:GetCaster(), victim = self:GetParent(), ability = self:GetAbility(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
        SendOverheadEventMessage(nil, OVERHEAD_ALERT_DAMAGE, self:GetParent(), actually_dmg, nil)
    end

    if not self:GetParent():IsAlive() then
        local modifier_necrolyte_reapers_scythe_custom_buff = self:GetCaster():FindModifierByName("modifier_necrolyte_reapers_scythe_custom_buff")
        if modifier_necrolyte_reapers_scythe_custom_buff then
            modifier_necrolyte_reapers_scythe_custom_buff:IncrementStackCount()
        end
        return 
    end
end

function modifier_necrolyte_reapers_scythe_custom:OnTakeDamageKillCredit(params)
	if params.target == self:GetParent() then
        if params.damage >= self:GetParent():GetHealth() then
            self:GetParent():Kill(self:GetAbility(), self:GetCaster())
        end
    end
end

modifier_necrolyte_reapers_scythe_custom_buff = class({})
function modifier_necrolyte_reapers_scythe_custom_buff:IsPurgable() return false end
function modifier_necrolyte_reapers_scythe_custom_buff:IsPurgeException() return false end
function modifier_necrolyte_reapers_scythe_custom_buff:RemoveOnDeath() return false end
function modifier_necrolyte_reapers_scythe_custom_buff:IsHidden() return self:GetStackCount() == 0 end
function modifier_necrolyte_reapers_scythe_custom_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
    }
end

function modifier_necrolyte_reapers_scythe_custom_buff:GetModifierConstantHealthRegen()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_necrolyte_17") then
        bonus = self:GetAbility().modifier_necrolyte_17
    end
    return self:GetStackCount() * (self:GetAbility():GetSpecialValueFor("hp_per_kill") + bonus)
end

function modifier_necrolyte_reapers_scythe_custom_buff:GetModifierConstantManaRegen()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_necrolyte_17") then
        bonus = self:GetAbility().modifier_necrolyte_17
    end
    return self:GetStackCount() * (self:GetAbility():GetSpecialValueFor("mana_per_kill") + bonus)
end

