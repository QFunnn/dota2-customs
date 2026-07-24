--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_riki_permanent_invisibility_custom", "heroes/npc_dota_hero_riki_custom/riki_permanent_invisibility_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_riki_permanent_invisibility_custom_invis", "heroes/npc_dota_hero_riki_custom/riki_permanent_invisibility_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_riki_permanent_invisibility_custom_buff", "heroes/npc_dota_hero_riki_custom/riki_permanent_invisibility_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_riki_permanent_invisibility_custom_buff_cooldown", "heroes/npc_dota_hero_riki_custom/riki_permanent_invisibility_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_riki_permanent_invisibility_custom_immortality_buff", "heroes/npc_dota_hero_riki_custom/riki_permanent_invisibility_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_riki_permanent_invisibility_custom_immortality_cooldown", "heroes/npc_dota_hero_riki_custom/riki_permanent_invisibility_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_riki_permanent_invisibility_custom_cooldown_fx", "heroes/npc_dota_hero_riki_custom/riki_permanent_invisibility_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_riki_permanent_invisibility_custom_pull", "heroes/npc_dota_hero_riki_custom/riki_permanent_invisibility_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_riki_permanent_invisibility_custom_illusion", "heroes/npc_dota_hero_riki_custom/riki_permanent_invisibility_custom", LUA_MODIFIER_MOTION_NONE)

riki_permanent_invisibility_custom = class({})
riki_permanent_invisibility_custom.modifier_riki_7_radius = 1200
riki_permanent_invisibility_custom.modifier_riki_7_strength = 50
riki_permanent_invisibility_custom.modifier_riki_7_duration = 5
riki_permanent_invisibility_custom.modifier_riki_7_cooldown = 5
riki_permanent_invisibility_custom.modifier_riki_14_cooldown = 25
riki_permanent_invisibility_custom.modifier_riki_14_duration = 25
riki_permanent_invisibility_custom.modifier_riki_14_incoming_damage = 100
riki_permanent_invisibility_custom.modifier_riki_14_outgoing_damage = 100
riki_permanent_invisibility_custom.modifier_riki_14_health = 666
riki_permanent_invisibility_custom.modifier_riki_14_distance = 666
riki_permanent_invisibility_custom.modifier_riki_18 = {10,20}
riki_permanent_invisibility_custom.modifier_riki_20_duration = {1,2}
riki_permanent_invisibility_custom.modifier_riki_20_heal = {10,20}
riki_permanent_invisibility_custom.modifier_riki_20_cooldown = 120
riki_permanent_invisibility_custom.modifier_riki_21 = 100
riki_permanent_invisibility_custom.modifier_riki_21_cooldown = 1

function riki_permanent_invisibility_custom:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_dazzle/dazzle_nothl_voyage_tether.vpcf", context)
    PrecacheResource("particle", "particles/helm_of_the_undying_custom.vpcf", context)
    PrecacheResource("particle", "particles/riki_effect_uninvis.vpcf", context)
    PrecacheResource("particle", "particles/helm_riki.vpcf", context)
    PrecacheResource("particle", "particles/riki_web_nothl.vpcf", context)
end

function riki_permanent_invisibility_custom:GetCastRange(vLocation, hTarget)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_riki_21") then
        bonus = self.modifier_riki_21
    end
    return self:GetSpecialValueFor("radius") - bonus
end

function riki_permanent_invisibility_custom:GetCooldown(iLevel)
    if self:GetCaster():HasModifier("modifier_riki_14") then
        return self.modifier_riki_14_cooldown
    end
end

function riki_permanent_invisibility_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_riki_14") then
        return "riki_14"
    end
    return "riki_permanent_invisibility"
end

function riki_permanent_invisibility_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_riki_14") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET
    end
    return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function riki_permanent_invisibility_custom:GetIntrinsicModifierName()
    return "modifier_riki_permanent_invisibility_custom"
end

function riki_permanent_invisibility_custom:OnSpellStart()
    if not IsServer() then return end
    local illusions = CreateIllusions( self:GetCaster(), self:GetCaster(), {duration = self.modifier_riki_14_duration, outgoing_damage=self.modifier_riki_14_outgoing_damage-100, incoming_damage = self.modifier_riki_14_incoming_damage-100}, 1, 100, false, false ) 
    if illusions and illusions[1] then
        FindClearSpaceForUnit(illusions[1], illusions[1]:GetAbsOrigin(), true)
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_riki_permanent_invisibility_custom_pull", {duration = self.modifier_riki_14_duration, illusion = illusions[1]:entindex()})
        illusions[1]:AddNewModifier(self:GetCaster(), self, "modifier_riki_permanent_invisibility_custom_illusion", {})
        illusions[1]:SetBaseMaxHealth(self.modifier_riki_14_health)
        illusions[1]:SetMaxHealth(self.modifier_riki_14_health)
        illusions[1]:SetHealth(self.modifier_riki_14_health)
    end
end

modifier_riki_permanent_invisibility_custom = class({})
function modifier_riki_permanent_invisibility_custom:IsHidden() return true end
function modifier_riki_permanent_invisibility_custom:IsPurgable() return false end
function modifier_riki_permanent_invisibility_custom:IsPurgeException() return false end
function modifier_riki_permanent_invisibility_custom:RemoveOnDeath() return false end
function modifier_riki_permanent_invisibility_custom:OnCreated()
    if not IsServer() then return end
    self.fade_delay = self:GetAbility():GetSpecialValueFor("fade_delay")
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.enemies_checkout = false
    self.bonus_xp_kill = self:GetAbility():GetSpecialValueFor("bonus_xp_kill")
    self.bonus_xp_assist = self:GetAbility():GetSpecialValueFor("bonus_xp_assist")
    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_riki_permanent_invisibility_custom_invis", {})
end
function modifier_riki_permanent_invisibility_custom:OnRefresh()
    if not IsServer() then return end
    self.fade_delay = self:GetAbility():GetSpecialValueFor("fade_delay")
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.bonus_xp_kill = self:GetAbility():GetSpecialValueFor("bonus_xp_kill")
    self.bonus_xp_assist = self:GetAbility():GetSpecialValueFor("bonus_xp_assist")
end
function modifier_riki_permanent_invisibility_custom:UpdateTalent()
    self.fade_delay = self:GetAbility():GetSpecialValueFor("fade_delay") - self:GetAbility().modifier_riki_21_cooldown
    self.radius = self:GetAbility():GetSpecialValueFor("radius") - self:GetAbility().modifier_riki_21
end
function modifier_riki_permanent_invisibility_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MIN_HEALTH,
        MODIFIER_EVENT_ON_ASSIST,
        MODIFIER_EVENT_ON_KILL,
    }
end

function modifier_riki_permanent_invisibility_custom:OnAssist(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    print("riki assist")
    self:GetParent():ModifyGold(self.bonus_xp_assist, false, 0)
end

function modifier_riki_permanent_invisibility_custom:OnKill(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    print("riki kill")
    self:GetParent():ModifyGold(self.bonus_xp_kill, false, 0)
end

function modifier_riki_permanent_invisibility_custom:GetMinHealth()
	if self:GetParent():IsIllusion() then return end
    if not self:GetParent():HasModifier("modifier_riki_20") then return end
	if self:GetParent():HasModifier("modifier_riki_permanent_invisibility_custom_immortality_cooldown") then return end
	return 1
end
function modifier_riki_permanent_invisibility_custom:OnTakeDamage(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if not self:GetParent():HasModifier("modifier_riki_20") then return end
	if self:GetParent():GetHealth() > 1 then return end
	if self:GetParent():HasModifier("modifier_riki_permanent_invisibility_custom_immortality_buff") then return end
	if self:GetParent():HasModifier("modifier_riki_permanent_invisibility_custom_immortality_cooldown") then return end
	self:GetParent():EmitSound("Item.Brooch.Cast")
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_riki_permanent_invisibility_custom_immortality_buff", {duration = self:GetAbility().modifier_riki_20_duration[self:GetCaster():GetTalentLevel("modifier_riki_20")]})
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_riki_permanent_invisibility_custom_immortality_cooldown", {duration = self:GetAbility().modifier_riki_20_cooldown})
    self:GetParent():Purge(false, true, false, true, true)
end
function modifier_riki_permanent_invisibility_custom:OnIntervalThink()
    if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_riki_permanent_invisibility_custom_illusion") then return end
    if not self:GetParent():HasModifier("modifier_riki_permanent_invisibility_custom_pull") then
        if not self:GetParent():IsAlive() then 
            self:StartIntervalThink(FrameTime())
            return
        end
        local enemies = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_ANY_ORDER, false)
        if #enemies > 0 then
            self:StartIntervalThink(FrameTime())
            self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_riki_permanent_invisibility_custom_cooldown_fx", {duration = self.fade_delay})
            self.enemies_checkout = true
            return
        end
        if self.enemies_checkout then
            self.enemies_checkout = false
            self:StartIntervalThink(self.fade_delay)
            return
        end
    end
    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_riki_permanent_invisibility_custom_invis", {})
    self:StartIntervalThink(-1)
end
function modifier_riki_permanent_invisibility_custom:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if self.enemies_checkout then return end
    if self:GetParent():HasModifier("modifier_riki_permanent_invisibility_custom_pull") then return end
    self:GetParent():RemoveModifierByName("modifier_riki_permanent_invisibility_custom_invis")
    self:StartIntervalThink(self.fade_delay)
    self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_riki_permanent_invisibility_custom_cooldown_fx", {duration = self.fade_delay})
end

modifier_riki_permanent_invisibility_custom_invis = class({})
function modifier_riki_permanent_invisibility_custom_invis:IsPurgable() return false end
function modifier_riki_permanent_invisibility_custom_invis:IsPurgeException() return false end
function modifier_riki_permanent_invisibility_custom_invis:RemoveOnDeath() return false end
function modifier_riki_permanent_invisibility_custom_invis:OnCreated()
    if not IsServer() then return end
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    if self:GetCaster():HasModifier("modifier_riki_21") then
        self.radius = self.radius - self:GetAbility().modifier_riki_21
    end
    local particle = ParticleManager:CreateParticle("particles/generic_hero_status/status_invisibility_start.vpcf", PATTACH_ABSORIGIN, self:GetParent())
    ParticleManager:ReleaseParticleIndex(particle)
    self:StartIntervalThink(FrameTime())
end

function modifier_riki_permanent_invisibility_custom_invis:OnIntervalThink()
    if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_riki_permanent_invisibility_custom_pull") then return end
    local modifier_riki_permanent_invisibility_custom = self:GetParent():FindModifierByName("modifier_riki_permanent_invisibility_custom")
    local enemies = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_ANY_ORDER, false)
    if #enemies > 0 then
        self:Destroy()
        if modifier_riki_permanent_invisibility_custom then
            modifier_riki_permanent_invisibility_custom:StartIntervalThink(modifier_riki_permanent_invisibility_custom.fade_delay)
            self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_riki_permanent_invisibility_custom_cooldown_fx", {duration = modifier_riki_permanent_invisibility_custom.fade_delay})
            modifier_riki_permanent_invisibility_custom:OnIntervalThink()
        end
    end
end

function modifier_riki_permanent_invisibility_custom_invis:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
        MODIFIER_PROPERTY_INVISIBILITY_ATTACK_BEHAVIOR_EXCEPTION,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_riki_permanent_invisibility_custom_invis:GetModifierMoveSpeedBonus_Percentage()
    if self:GetCaster():HasModifier("modifier_riki_18") then
        return self:GetAbility().modifier_riki_18[self:GetCaster():GetTalentLevel("modifier_riki_18")]
    end
end

function modifier_riki_permanent_invisibility_custom_invis:GetModifierInvisibilityLevel()
    return 1
end

function modifier_riki_permanent_invisibility_custom_invis:GetModifierInvisibilityAttackBehaviorException()
    return 1
end

function modifier_riki_permanent_invisibility_custom_invis:CheckState()
    return
    { 
        [MODIFIER_STATE_UNTARGETABLE_ENEMY] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR_FOR_ENEMIES] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
        [MODIFIER_STATE_ATTACK_IMMUNE] = true,
        [MODIFIER_STATE_NEUTRALS_DONT_ATTACK] = true,
    }
end

function modifier_riki_permanent_invisibility_custom_invis:OnDestroy()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_riki_7") and not self:GetCaster():HasModifier("modifier_riki_permanent_invisibility_custom_buff_cooldown") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_riki_permanent_invisibility_custom_buff", {duration = self:GetAbility().modifier_riki_7_duration})
        self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_riki_permanent_invisibility_custom_buff_cooldown", {duration = self:GetAbility().modifier_riki_7_cooldown})
    end
end

modifier_riki_permanent_invisibility_custom_buff_cooldown = class({})
function modifier_riki_permanent_invisibility_custom_buff_cooldown:GetTexture() return "riki_7" end
function modifier_riki_permanent_invisibility_custom_buff_cooldown:IsDebuff() return true end
function modifier_riki_permanent_invisibility_custom_buff_cooldown:IsPurgable() return false end
function modifier_riki_permanent_invisibility_custom_buff_cooldown:IsPurgeException() return false end
function modifier_riki_permanent_invisibility_custom_buff_cooldown:IsHidden() return true end

modifier_riki_permanent_invisibility_custom_buff = class({})
function modifier_riki_permanent_invisibility_custom_buff:GetTexture() return "riki_7" end

function modifier_riki_permanent_invisibility_custom_buff:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/riki_effect_uninvis.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:ReleaseParticleIndex(particle)
    self:StartIntervalThink(FrameTime())
end

function modifier_riki_permanent_invisibility_custom_buff:OnRefresh()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/riki_effect_uninvis.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:ReleaseParticleIndex(particle)
end

function modifier_riki_permanent_invisibility_custom_buff:OnIntervalThink()
    if not IsServer() then return end
    AddFOWViewer(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self:GetAbility().modifier_riki_7_radius, FrameTime(), false)
end

function modifier_riki_permanent_invisibility_custom_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    }
end

function modifier_riki_permanent_invisibility_custom_buff:GetModifierBonusStats_Strength()
    return self:GetAbility().modifier_riki_7_strength
end

modifier_riki_permanent_invisibility_custom_immortality_buff = class({})
function modifier_riki_permanent_invisibility_custom_immortality_buff:GetTexture() return "riki_20" end
function modifier_riki_permanent_invisibility_custom_immortality_buff:IsHidden() return false end
function modifier_riki_permanent_invisibility_custom_immortality_buff:IsPurgable() return false end
function modifier_riki_permanent_invisibility_custom_immortality_buff:GetEffectName() return "particles/helm_riki.vpcf" end
function modifier_riki_permanent_invisibility_custom_immortality_buff:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MIN_HEALTH,
        MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
        MODIFIER_PROPERTY_INVISIBILITY_ATTACK_BEHAVIOR_EXCEPTION,
	}
end

function modifier_riki_permanent_invisibility_custom_immortality_buff:GetMinHealth()
	return 1
end

function modifier_riki_permanent_invisibility_custom_immortality_buff:GetModifierInvisibilityLevel()
    return 1
end

function modifier_riki_permanent_invisibility_custom_immortality_buff:GetModifierInvisibilityAttackBehaviorException()
    return 1
end

function modifier_riki_permanent_invisibility_custom_immortality_buff:CheckState()
    return
    { 
        [MODIFIER_STATE_UNTARGETABLE_ENEMY] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR_FOR_ENEMIES] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
        [MODIFIER_STATE_ATTACK_IMMUNE] = true,
        [MODIFIER_STATE_NEUTRALS_DONT_ATTACK] = true,
        [MODIFIER_STATE_INVISIBLE] = true,
        [MODIFIER_STATE_TRUESIGHT_IMMUNE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
    }
end

function modifier_riki_permanent_invisibility_custom_immortality_buff:OnDestroy()
	if not IsServer() then return end
	self:GetParent():Heal(self:GetParent():GetMaxHealth() / 100 * self:GetAbility().modifier_riki_20_heal[self:GetCaster():GetTalentLevel("modifier_riki_20")], self:GetAbility())
end

modifier_riki_permanent_invisibility_custom_immortality_cooldown = class({})
function modifier_riki_permanent_invisibility_custom_immortality_cooldown:GetTexture() return "riki_20" end
function modifier_riki_permanent_invisibility_custom_immortality_cooldown:IsHidden() return false end
function modifier_riki_permanent_invisibility_custom_immortality_cooldown:IsPurgable() return false end
function modifier_riki_permanent_invisibility_custom_immortality_cooldown:IsDebuff() return true end
function modifier_riki_permanent_invisibility_custom_immortality_cooldown:RemoveOnDeath() return false end

modifier_riki_permanent_invisibility_custom_cooldown_fx = class({})
function modifier_riki_permanent_invisibility_custom_cooldown_fx:GetTexture() return "riki_permanent_invisibility" end
function modifier_riki_permanent_invisibility_custom_cooldown_fx:IsHidden() return false end
function modifier_riki_permanent_invisibility_custom_cooldown_fx:IsPurgable() return false end
function modifier_riki_permanent_invisibility_custom_cooldown_fx:IsDebuff() return true end
function modifier_riki_permanent_invisibility_custom_cooldown_fx:RemoveOnDeath() return false end

modifier_riki_permanent_invisibility_custom_illusion = class({})
function modifier_riki_permanent_invisibility_custom_illusion:IsPurgable() return false end
function modifier_riki_permanent_invisibility_custom_illusion:IsHidden() return true end
function modifier_riki_permanent_invisibility_custom_illusion:IsPurgeException() return false end
function modifier_riki_permanent_invisibility_custom_illusion:OnCreated()
    if not IsServer() then return end
    self:GetAbility():SetActivated(false)
    self:StartIntervalThink(FrameTime())
end
function modifier_riki_permanent_invisibility_custom_illusion:OnDestroy()
    if not IsServer() then return end
    self:GetAbility():SetActivated(true)
end
function modifier_riki_permanent_invisibility_custom_illusion:OnIntervalThink()
    if not IsServer() then return end
    self:GetParent():SetBaseMaxHealth(self:GetAbility().modifier_riki_14_health)
    self:GetParent():SetMaxHealth(self:GetAbility().modifier_riki_14_health)
end
function modifier_riki_permanent_invisibility_custom_illusion:CheckState()
    return
    {
        [MODIFIER_STATE_NO_HEALTH_BAR] = self:GetElapsedTime() < 0.2,
    }
end
function modifier_riki_permanent_invisibility_custom_illusion:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_DISABLE_HEALING,
        MODIFIER_PROPERTY_FORCE_MAX_HEALTH,
    }
end
function modifier_riki_permanent_invisibility_custom_illusion:GetDisableHealing() return 1 end
function modifier_riki_permanent_invisibility_custom_illusion:GetModifierForceMaxHealth() return self:GetAbility().modifier_riki_14_health end

modifier_riki_permanent_invisibility_custom_pull = class({})
function modifier_riki_permanent_invisibility_custom_pull:IsPurgable() return false end
function modifier_riki_permanent_invisibility_custom_pull:IsPurgeException() return false end

function modifier_riki_permanent_invisibility_custom_pull:OnCreated(data)
    if not IsServer() then return end
    self.illusion = EntIndexToHScript(data.illusion)
    local modifier_riki_permanent_invisibility_custom = self:GetParent():FindModifierByName("modifier_riki_permanent_invisibility_custom")
    if modifier_riki_permanent_invisibility_custom then
        modifier_riki_permanent_invisibility_custom:OnIntervalThink()
    end
    local modifier_riki_permanent_invisibility_custom_cooldown_fx = self:GetParent():FindModifierByName("modifier_riki_permanent_invisibility_custom_cooldown_fx")
    if modifier_riki_permanent_invisibility_custom_cooldown_fx then
        modifier_riki_permanent_invisibility_custom_cooldown_fx:Destroy()
    end
    local particle = ParticleManager:CreateParticle("particles/riki_web_nothl.vpcf", PATTACH_POINT_FOLLOW, self.illusion)
    ParticleManager:SetParticleControlEnt(particle, 0, self.illusion, PATTACH_POINT_FOLLOW, "attach_hitloc", self.illusion:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(particle, false, false, -1, false, false)
    self:StartIntervalThink(0.1)
end

function modifier_riki_permanent_invisibility_custom_pull:OnIntervalThink()
    if not IsServer() then return end
    if self.illusion and self.illusion:IsNull() then
        self:Destroy()
    elseif self.illusion and not self.illusion:IsNull() and not self.illusion:IsAlive() then
        self:Destroy()
    else
        local distance = (self.illusion:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D()
        if distance >= self:GetAbility().modifier_riki_14_distance then
            self:Destroy()
        end
    end
end

function modifier_riki_permanent_invisibility_custom_pull:OnDestroy()
    if not IsServer() then return end
    if self.illusion and not self.illusion:IsNull() and self.illusion:IsAlive() then
        self.illusion:Kill(nil, self:GetParent())
    end
    local modifier_riki_permanent_invisibility_custom = self:GetParent():FindModifierByName("modifier_riki_permanent_invisibility_custom")
    if modifier_riki_permanent_invisibility_custom then
        modifier_riki_permanent_invisibility_custom:OnIntervalThink()
    end
end