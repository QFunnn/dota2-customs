--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_zuus_thundergods_wrath_custom_fow", "heroes/npc_dota_hero_zuus_custom/zuus_thundergods_wrath_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zuus_thundergods_wrath_custom_buff_damage", "heroes/npc_dota_hero_zuus_custom/zuus_thundergods_wrath_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zuus_thundergods_wrath_custom_buff_magic_immune", "heroes/npc_dota_hero_zuus_custom/zuus_thundergods_wrath_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zuus_thundergods_wrath_custom_handler", "heroes/npc_dota_hero_zuus_custom/zuus_thundergods_wrath_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zuus_thundergods_wrath_custom_target_damage", "heroes/npc_dota_hero_zuus_custom/zuus_thundergods_wrath_custom", LUA_MODIFIER_MOTION_NONE)

zuus_thundergods_wrath_custom = class({})
zuus_thundergods_wrath_custom.modifier_zuus_5 = {-20,-40,-60}
zuus_thundergods_wrath_custom.modifier_zuus_7_duration = 30
zuus_thundergods_wrath_custom.modifier_zuus_7_damage = 80
zuus_thundergods_wrath_custom.modifier_zuus_13 = {2,4}
zuus_thundergods_wrath_custom.modifier_zuus_18 = {2,4,6}
zuus_thundergods_wrath_custom.modifier_zuus_18_damage = {20,40,60}

function zuus_thundergods_wrath_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_zuus/zuus_thundergods_wrath_start.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_zuus/zuus_thundergods_wrath.vpcf", context)
    PrecacheResource("particle", "particles/zuus_hands_buff.vpcf", context)
end

function zuus_thundergods_wrath_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_zuus_5") then
        bonus = self.modifier_zuus_5[self:GetCaster():GetTalentLevel("modifier_zuus_5")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function zuus_thundergods_wrath_custom:OnAbilityPhaseStart()
    local precast_sound = "Hero_Zuus.GodsWrath.PreCast"
    local particle_start = "particles/units/heroes/hero_zuus/zuus_thundergods_wrath_start.vpcf"
	local attack_lock = self:GetCaster():GetAttachmentOrigin(self:GetCaster():ScriptLookupAttachment("attach_attack1"))
	local attack_lock2 = self:GetCaster():GetAttachmentOrigin(self:GetCaster():ScriptLookupAttachment("attach_attack2"))
    self.thundergod_spell_cast = ParticleManager:CreateParticle(particle_start, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt( self.thundergod_spell_cast, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetOrigin(), true )
	ParticleManager:SetParticleControlEnt( self.thundergod_spell_cast, 2, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack2", self:GetCaster():GetOrigin(), true )
	self:GetCaster():EmitSound(precast_sound)
	return true
end

function zuus_thundergods_wrath_custom:OnAbilityPhaseInterrupted()
	if self.thundergod_spell_cast then
		ParticleManager:DestroyParticle(self.thundergod_spell_cast, true)
		ParticleManager:ReleaseParticleIndex(self.thundergod_spell_cast)
	end
end

function zuus_thundergods_wrath_custom:GetIntrinsicModifierName()
    return "modifier_zuus_thundergods_wrath_custom_handler"
end

function zuus_thundergods_wrath_custom:OnSpellStart() 
    if not IsServer() then return end
    local ability = self
    local caster = self:GetCaster()
    local sight_duration = ability:GetSpecialValueFor("sight_duration")
    local max_radius = self:GetSpecialValueFor("max_radius")
    local position = self:GetCaster():GetAbsOrigin()	
    if self.thundergod_spell_cast then
        ParticleManager:DestroyParticle(self.thundergod_spell_cast, false)
        ParticleManager:ReleaseParticleIndex(self.thundergod_spell_cast)
    end
    if self:GetCaster():HasModifier("modifier_zuus_7") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_zuus_thundergods_wrath_custom_buff_damage", {duration = self.modifier_zuus_7_duration})
    end
    if self:GetCaster():HasModifier("modifier_zuus_13") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_zuus_thundergods_wrath_custom_buff_magic_immune", {duration = self.modifier_zuus_13[self:GetCaster():GetTalentLevel("modifier_zuus_13")]})
    end
    EmitSoundOnLocationForAllies(self:GetCaster():GetAbsOrigin(), "Hero_Zuus.GodsWrath", self:GetCaster())
    local damage = self:GetSpecialValueFor("damage")
    local modifier_zuus_thundergods_wrath_custom_handler = self:GetCaster():FindModifierByName("modifier_zuus_thundergods_wrath_custom_handler")
    if modifier_zuus_thundergods_wrath_custom_handler and modifier_zuus_thundergods_wrath_custom_handler:GetStackCount() > 0 and self:GetCaster():HasModifier("modifier_zuus_18") then
        damage = damage + (self.modifier_zuus_18_damage[self:GetCaster():GetTalentLevel("modifier_zuus_18")] * modifier_zuus_thundergods_wrath_custom_handler:GetStackCount())
    end
    local damage_table = {attacker = self:GetCaster(), damage = damage, ability = ability, damage_type = ability:GetAbilityDamageType() }
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, max_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS, FIND_CLOSEST, false)
    if self:GetCaster():HasModifier("modifier_zuus_18") then
        local creeps = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, max_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS, FIND_CLOSEST, false)
        local creeps_counter = 0
        for _, creep in pairs(creeps) do
            creeps_counter = creeps_counter + 1
            table.insert(units, creep)
            if creeps_counter >= self.modifier_zuus_18[self:GetCaster():GetTalentLevel("modifier_zuus_18")] then
                break
            end
        end
    end
    for _,hero in pairs(units) do
        if hero and hero:IsAlive() and not hero:IsNull() then
            local target_point = hero:GetAbsOrigin()
            local vStartPosition = target_point + Vector(0,0,4000)
            local nFXIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_thundergods_wrath.vpcf", PATTACH_CUSTOMORIGIN, hero )
            ParticleManager:SetParticleControl( nFXIndex, 0, vStartPosition )
            ParticleManager:SetParticleControlEnt( nFXIndex, 1, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero:GetOrigin(), true )
            ParticleManager:DestroyParticle(nFXIndex, false)
            ParticleManager:ReleaseParticleIndex( nFXIndex )
            if (not hero:IsMagicImmune()) and not hero:IsInvulnerable() and not hero:IsOutOfGame() and (not hero:IsInvisible() or caster:CanEntityBeSeenByMyTeam(hero)) then
                if hero:IsRealHero() then
                    hero:AddNewModifier(self:GetCaster(), self, "modifier_zuus_thundergods_wrath_custom_target_damage", {duration = 3})
                end
                damage_table.victim = hero
                ApplyDamage(damage_table)
                if self:GetCaster():HasModifier("modifier_zuus_5") then
                    self:GetCaster():PerformAttack(hero, true, true, false, true, false, false, true)
                end
            end
            CreateModifierThinker(caster, ability, "modifier_zuus_thundergods_wrath_custom_fow", {duration = sight_duration}, target_point, self:GetCaster():GetTeamNumber(), false)
            hero:EmitSound("Hero_Zuus.GodsWrath.Target")
        end
    end	
end

modifier_zuus_thundergods_wrath_custom_fow = class({})

function modifier_zuus_thundergods_wrath_custom_fow:IsHidden() return true end
function modifier_zuus_thundergods_wrath_custom_fow:IsPurgable() return false end

function modifier_zuus_thundergods_wrath_custom_fow:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_zuus_thundergods_wrath_custom_fow:OnIntervalThink()
	if not IsServer() then return end
	AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self:GetAbility():GetSpecialValueFor("sight_radius_day"), FrameTime() * 2, true)
end

function modifier_zuus_thundergods_wrath_custom_fow:GetAuraRadius()
	return 900
end

function modifier_zuus_thundergods_wrath_custom_fow:GetModifierAura()
    return "modifier_truesight"
end
   
function modifier_zuus_thundergods_wrath_custom_fow:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_zuus_thundergods_wrath_custom_fow:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_zuus_thundergods_wrath_custom_fow:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_OTHER
end

function modifier_zuus_thundergods_wrath_custom_fow:GetAuraDuration()
    return 0.5
end

modifier_zuus_thundergods_wrath_custom_buff_damage = class({})
function modifier_zuus_thundergods_wrath_custom_buff_damage:IsPurgable() return false end
function modifier_zuus_thundergods_wrath_custom_buff_damage:GetTexture() return "zuus_7" end
function modifier_zuus_thundergods_wrath_custom_buff_damage:OnCreated()
    if not IsServer() then return end
    self:GetParent():SetRenderColor(251, 83, 83)
end
function modifier_zuus_thundergods_wrath_custom_buff_damage:OnDestroy()
    if not IsServer() then return end
    self:GetParent():SetRenderColor(255, 255, 255)
end
function modifier_zuus_thundergods_wrath_custom_buff_damage:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
    }
end
function modifier_zuus_thundergods_wrath_custom_buff_damage:GetModifierBaseDamageOutgoing_Percentage()
    return self:GetAbility().modifier_zuus_7_damage
end
function modifier_zuus_thundergods_wrath_custom_buff_damage:GetEffectName()
    return "particles/zuus_hands_buff.vpcf"
end
function modifier_zuus_thundergods_wrath_custom_buff_damage:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

modifier_zuus_thundergods_wrath_custom_buff_magic_immune = class({})
function modifier_zuus_thundergods_wrath_custom_buff_magic_immune:IsPurgable() return false end
function modifier_zuus_thundergods_wrath_custom_buff_magic_immune:GetTexture() return "zuus_13" end

function modifier_zuus_thundergods_wrath_custom_buff_magic_immune:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_zuus_thundergods_wrath_custom_buff_magic_immune:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_zuus_thundergods_wrath_custom_buff_magic_immune:CheckState()
    return 
    {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true
    }
end

function modifier_zuus_thundergods_wrath_custom_buff_magic_immune:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end

function modifier_zuus_thundergods_wrath_custom_buff_magic_immune:StatusEffectPriority()
    return 99999
end

function modifier_zuus_thundergods_wrath_custom_buff_magic_immune:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE
    }
end

function modifier_zuus_thundergods_wrath_custom_buff_magic_immune:GetAbsoluteNoDamagePure(params)
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 1
    end
end

function modifier_zuus_thundergods_wrath_custom_buff_magic_immune:GetModifierMagicalResistanceBonus(params)
    if IsClient() then 
        return 65
    end
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 65
    end
end

modifier_zuus_thundergods_wrath_custom_handler = class({})
function modifier_zuus_thundergods_wrath_custom_handler:IsHidden() return not self:GetCaster():HasModifier("modifier_zuus_18") end
function modifier_zuus_thundergods_wrath_custom_handler:GetTexture() return "zuus_18" end
function modifier_zuus_thundergods_wrath_custom_handler:IsPurgable() return false end
function modifier_zuus_thundergods_wrath_custom_handler:IsPurgeException() return false end
function modifier_zuus_thundergods_wrath_custom_handler:RemoveOnDeath() return false end

modifier_zuus_thundergods_wrath_custom_target_damage = class({})
function modifier_zuus_thundergods_wrath_custom_target_damage:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_zuus_thundergods_wrath_custom_target_damage:IsHidden() return true end
function modifier_zuus_thundergods_wrath_custom_target_damage:IsPurgable() return false end

function modifier_zuus_thundergods_wrath_custom_target_damage:DeclareFunctions()
	return 
    {
		MODIFIER_EVENT_ON_DEATH
	}
end

function modifier_zuus_thundergods_wrath_custom_target_damage:OnDeath(params)
	if params.unit ~= self:GetParent() then return end
	if not params.unit:IsRealHero() then return end
	local modifier = self:GetCaster():FindModifierByName("modifier_zuus_thundergods_wrath_custom_handler")
	if modifier then
		modifier:IncrementStackCount()
		self:GetCaster():CalculateStatBonus(true)
	end
end