--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_doom_bringer_doom_custom", "heroes/npc_dota_hero_doom_bringer_custom/doom_bringer_doom_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_doom_bringer_doom_custom_aura", "heroes/npc_dota_hero_doom_bringer_custom/doom_bringer_doom_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_doom_bringer_doom_custom_cooldown", "heroes/npc_dota_hero_doom_bringer_custom/doom_bringer_doom_custom", LUA_MODIFIER_MOTION_NONE)

doom_bringer_doom_custom = class({})

doom_bringer_doom_custom.modifier_doom_bringer_3 = 300
doom_bringer_doom_custom.modifier_doom_bringer_5 = {1,2,3}
doom_bringer_doom_custom.modifier_doom_bringer_4 = {1,2,3}
doom_bringer_doom_custom.modifier_doom_bringer_4_hp = 300

function doom_bringer_doom_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/status_fx/status_effect_doom.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_doom_bringer/doom_bringer_doom.vpcf', context )
end

function doom_bringer_doom_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_doom_bringer_7") then
		return DOTA_ABILITY_BEHAVIOR_PASSIVE
	end
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end

function doom_bringer_doom_custom:GetCooldown(level)
	if self:GetCaster():HasModifier("modifier_doom_bringer_7") then
		return 0
	end
    return self.BaseClass.GetCooldown( self, level )
end

function doom_bringer_doom_custom:GetManaCost(level)
	if self:GetCaster():HasModifier("modifier_doom_bringer_7") then
		return 0
	end
    return self.BaseClass.GetManaCost(self, level)
end

function doom_bringer_doom_custom:GetIntrinsicModifierName()
	if self:GetCaster():HasModifier("modifier_doom_bringer_7") then
		return "modifier_doom_bringer_doom_custom_aura"
	end
end

function doom_bringer_doom_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb( self ) then return end
	local duration = self:GetSpecialValueFor( "duration" )
	self:ApplyDoom(target, duration)
end

function doom_bringer_doom_custom:ApplyDoom(target, duration)
	if not IsServer() then return end
    if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        target:Purge(true, false, false, false, false)
        duration = duration * (1 - target:GetStatusResistance())
    end
	if self:GetCaster():HasModifier("modifier_doom_bringer_3") then
        local modifier_doom_bringer_doom_custom_aura = target:FindModifierByName("modifier_doom_bringer_doom_custom_aura")
        if modifier_doom_bringer_doom_custom_aura and modifier_doom_bringer_doom_custom_aura:GetRemainingTime() > duration then return end
		target:AddNewModifier( self:GetCaster(), self, "modifier_doom_bringer_doom_custom_aura", { duration = duration } )
		return
	end
    local modifier_doom_bringer_doom_custom = target:FindModifierByName("modifier_doom_bringer_doom_custom")
    if modifier_doom_bringer_doom_custom and modifier_doom_bringer_doom_custom:GetRemainingTime() > duration then return end
	target:AddNewModifier( self:GetCaster(), self, "modifier_doom_bringer_doom_custom", { duration = duration } )
end

modifier_doom_bringer_doom_custom = class({})

function modifier_doom_bringer_doom_custom:IsHidden()
	return false
end

function modifier_doom_bringer_doom_custom:IsDebuff()
	return true
end

function modifier_doom_bringer_doom_custom:IsStunDebuff()
	return false
end

function modifier_doom_bringer_doom_custom:IsPurgable()
	return false
end

function modifier_doom_bringer_doom_custom:OnCreated( kv )
	self.interval = 1

	if not IsServer() then return end

	if self:GetCaster():HasModifier("modifier_doom_bringer_5") and not self:GetParent():HasModifier("modifier_doom_bringer_doom_custom_cooldown") then
		local percent_damage = self:GetCaster():GetMaxHealth() / 100 * self:GetAbility().modifier_doom_bringer_5[self:GetCaster():GetTalentLevel("modifier_doom_bringer_5")]
		ApplyDamage( { victim = self:GetParent(), attacker = self:GetCaster(), damage = percent_damage, damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility()} )
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_doom_bringer_doom_custom_cooldown", {duration = 5})
	end

	self:OnIntervalThink()
	self:StartIntervalThink( self.interval )
	self:PlayEffects()
end

function modifier_doom_bringer_doom_custom:OnDestroy()
	if not IsServer() then return end
	self:GetParent():StopSound("Hero_DoomBringer.Doom")
end

function modifier_doom_bringer_doom_custom:CheckState()
	local state = 
	{
		[MODIFIER_STATE_SILENCED] = true,
		--[MODIFIER_STATE_MUTED] = true,
	}
	if self:GetCaster():HasModifier("modifier_doom_bringer_6") then
		state = 
		{
			[MODIFIER_STATE_SILENCED] = true,
			--[MODIFIER_STATE_MUTED] = true,
			[MODIFIER_STATE_PASSIVES_DISABLED] = true,
		}
	end
	return state
end

function modifier_doom_bringer_doom_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_DISABLE_HEALING
    }
end
function modifier_doom_bringer_doom_custom:GetDisableHealing()
    return 1
end

function modifier_doom_bringer_doom_custom:OnIntervalThink()
	if not IsServer() then return end

	local damage = self:GetAbility():GetSpecialValueFor( "damage" )

	if self:GetCaster():HasModifier("modifier_doom_bringer_4") then
		local bonus_damage = self:GetAbility().modifier_doom_bringer_4[self:GetCaster():GetTalentLevel("modifier_doom_bringer_4")] * (self:GetCaster():GetMaxHealth() / self:GetAbility().modifier_doom_bringer_4_hp)
		damage = damage + bonus_damage
	end

	local damageTable = 
	{
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
	}

	ApplyDamage( damageTable )
end

function modifier_doom_bringer_doom_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_doom.vpcf"
end

function modifier_doom_bringer_doom_custom:StatusEffectPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_doom_bringer_doom_custom:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_doom_bringer/doom_bringer_doom.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	self:AddParticle( effect_cast, false, false, MODIFIER_PRIORITY_SUPER_ULTRA, false, false )
	self:GetParent():EmitSound("Hero_DoomBringer.Doom")
end

modifier_doom_bringer_doom_custom_aura = class({})

function modifier_doom_bringer_doom_custom_aura:IsPurgable() return false end
function modifier_doom_bringer_doom_custom_aura:OnCreated()
	if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_doom_bringer/doom_bringer_doom_aura.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 1, Vector(self:GetCaster():GetAoeBonus(self:GetAbility().modifier_doom_bringer_3), 0, 0))
    self:AddParticle(particle, false, false, -1, false, false)
    self.particle = particle
	self:StartIntervalThink(FrameTime())
end

function modifier_doom_bringer_doom_custom_aura:OnIntervalThink()
	if not IsServer() then return end
    if (self:GetParent():PassivesDisabled() or self:GetCaster():HasModifier("modifier_disconnect_player_no_damage")) and self:GetCaster() == self:GetParent() and self:GetCaster():HasModifier("modifier_doom_bringer_7") then
        if self.particle ~= nil then
            ParticleManager:DestroyParticle(self.particle, true)
            ParticleManager:ReleaseParticleIndex(self.particle)
            self.particle = nil
        end
    else
        if self.particle == nil then
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_doom_bringer/doom_bringer_doom_aura.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
            ParticleManager:SetParticleControl(particle, 1, Vector(self:GetCaster():GetAoeBonus(self:GetAbility().modifier_doom_bringer_3), 0, 0))
            self:AddParticle(particle, false, false, -1, false, false)
            self.particle = particle
        end
    end
	if not self:GetParent():IsAlive() then
		self:Destroy()
	end
end

function modifier_doom_bringer_doom_custom_aura:IsAura()
    if self:GetParent():PassivesDisabled() and self:GetCaster() == self:GetParent() and self:GetCaster():HasModifier("modifier_doom_bringer_7") then return false end
	return true
end

function modifier_doom_bringer_doom_custom_aura:GetModifierAura()
	return "modifier_doom_bringer_doom_custom"
end

function modifier_doom_bringer_doom_custom_aura:GetAuraRadius()
	return self:GetCaster():GetAoeBonus(self:GetAbility().modifier_doom_bringer_3)
end

function modifier_doom_bringer_doom_custom_aura:GetAuraDuration()
	return 0
end

function modifier_doom_bringer_doom_custom_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end

function modifier_doom_bringer_doom_custom_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_doom_bringer_doom_custom_aura:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_doom_bringer_doom_custom_aura:GetAuraEntityReject(target)
	if IsServer() then
		if target == self:GetCaster() or target:GetTeamNumber() == self:GetCaster():GetTeamNumber() or target:HasModifier("modifier_wodawisp") or target:HasModifier("modifier_wodarelax") then
			return true
		else
			return false
		end
	end
end

LinkLuaModifier("modifier_doom_bringer_creep_doom_custom", "heroes/npc_dota_hero_doom_bringer_custom/doom_bringer_doom_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_doom_bringer_creep_doom_custom_aura", "heroes/npc_dota_hero_doom_bringer_custom/doom_bringer_doom_custom", LUA_MODIFIER_MOTION_NONE)

doom_bringer_creep_doom_custom = class({})

doom_bringer_creep_doom_custom.modifier_doom_bringer_3 = 300
doom_bringer_creep_doom_custom.modifier_doom_bringer_5 = {1,2,3}
doom_bringer_creep_doom_custom.modifier_doom_bringer_4 = {1,2,3}
doom_bringer_creep_doom_custom.modifier_doom_bringer_4_hp = 300

function doom_bringer_creep_doom_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb( self ) then return end
	local duration = self:GetSpecialValueFor( "duration" )

    if target:HasModifier("modifier_techies_remote_mines_custom") then
        self:EndCooldown()
        self:RefundManaCost()
        return
    end

    if not target:IsHero() and target:IsInvulnerable() and target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        self:EndCooldown()
        self:RefundManaCost()
        return
    end

	if self:GetCaster():HasModifier("modifier_doom_bringer_3") then
		target:AddNewModifier( self:GetCaster(), self, "modifier_doom_bringer_creep_doom_custom_aura", { duration = duration } )
		return
	end
	target:AddNewModifier( self:GetCaster(), self, "modifier_doom_bringer_creep_doom_custom", { duration = duration } )
end

modifier_doom_bringer_creep_doom_custom = class({})

function modifier_doom_bringer_creep_doom_custom:IsHidden()
	return false
end

function modifier_doom_bringer_creep_doom_custom:IsDebuff()
	return true
end

function modifier_doom_bringer_creep_doom_custom:IsStunDebuff()
	return false
end

function modifier_doom_bringer_creep_doom_custom:IsPurgable()
	return false
end

function modifier_doom_bringer_creep_doom_custom:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_doom_bringer_creep_doom_custom:OnCreated( kv )
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )

	self.interval = 1

	if not IsServer() then return end

	if self:GetCaster():HasModifier("modifier_doom_bringer_5") and not self:GetCaster():HasModifier("modifier_disconnect_player_no_damage") then
		local percent_damage = self:GetCaster():GetMaxHealth() / 100 * self:GetAbility().modifier_doom_bringer_5[self:GetCaster():GetTalentLevel("modifier_doom_bringer_5")]
		ApplyDamage( { victim = self:GetParent(), attacker = self:GetCaster(), damage = percent_damage, damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility()} )
	end

	self:OnIntervalThink()
	self:StartIntervalThink( self.interval )
	self:PlayEffects()
end

function modifier_doom_bringer_creep_doom_custom:OnDestroy()
	if not IsServer() then return end
	self:GetParent():StopSound("Hero_DoomBringer.Doom")
end

function modifier_doom_bringer_creep_doom_custom:CheckState()
    if self:GetCaster():HasModifier("modifier_disconnect_player_no_damage") then
        return {}
    end
	local state = 
	{
		[MODIFIER_STATE_SILENCED] = true,
		--[MODIFIER_STATE_MUTED] = true,
	}
	if self:GetCaster():HasModifier("modifier_doom_bringer_6") then
		state = 
		{
			[MODIFIER_STATE_SILENCED] = true,
			--[MODIFIER_STATE_MUTED] = true,
			[MODIFIER_STATE_PASSIVES_DISABLED] = true,
		}
	end
	return state
end

function modifier_doom_bringer_creep_doom_custom:OnIntervalThink()
	if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_disconnect_player_no_damage") then return end
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )

	if self:GetCaster():HasModifier("modifier_doom_bringer_4") then
		local bonus_damage = self:GetAbility().modifier_doom_bringer_4[self:GetCaster():GetTalentLevel("modifier_doom_bringer_4")] * (self:GetCaster():GetMaxHealth() / self:GetAbility().modifier_doom_bringer_4_hp)
		damage = damage + bonus_damage
	end

	local damageTable = 
	{
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
	}

	ApplyDamage( damageTable )
end

function modifier_doom_bringer_creep_doom_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_doom.vpcf"
end

function modifier_doom_bringer_creep_doom_custom:StatusEffectPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_doom_bringer_creep_doom_custom:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_doom_bringer/doom_bringer_doom.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	self:AddParticle( effect_cast, false, false, MODIFIER_PRIORITY_SUPER_ULTRA, false, false )
	self:GetParent():EmitSound("Hero_DoomBringer.Doom")
end
function modifier_doom_bringer_creep_doom_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_DISABLE_HEALING
    }
end
function modifier_doom_bringer_creep_doom_custom:GetDisableHealing()
    if self:GetCaster():HasModifier("modifier_disconnect_player_no_damage") then return end
    return 1
end

modifier_doom_bringer_creep_doom_custom_aura = class({})
function modifier_doom_bringer_creep_doom_custom_aura:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end
function modifier_doom_bringer_creep_doom_custom_aura:IsPurgable() return false end
function modifier_doom_bringer_creep_doom_custom_aura:OnCreated()
	if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_doom_bringer/doom_bringer_doom_aura.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 1, Vector(self:GetCaster():GetAoeBonus(self:GetAbility().modifier_doom_bringer_3), 0, 0))
    self:AddParticle(particle, false, false, -1, false, false)
	self:StartIntervalThink(FrameTime())
end

function modifier_doom_bringer_creep_doom_custom_aura:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetParent():IsAlive() then
		self:Destroy()
	end
end

function modifier_doom_bringer_creep_doom_custom_aura:IsAura()
	return true
end

function modifier_doom_bringer_creep_doom_custom_aura:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_doom_bringer_creep_doom_custom_aura:GetModifierAura()
	return "modifier_doom_bringer_creep_doom_custom"
end

function modifier_doom_bringer_creep_doom_custom_aura:GetAuraRadius()
	return self:GetCaster():GetAoeBonus(self:GetAbility().modifier_doom_bringer_3)
end

function modifier_doom_bringer_creep_doom_custom_aura:GetAuraEntityReject(target)
	if IsServer() then
		if target == self:GetCaster() or target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
			return true
		else
			return false
		end
	end
end

function modifier_doom_bringer_creep_doom_custom_aura:GetAuraDuration()
	return 0
end

function modifier_doom_bringer_creep_doom_custom_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end

function modifier_doom_bringer_creep_doom_custom_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_doom_bringer_doom_custom_cooldown = class({})
function modifier_doom_bringer_doom_custom_cooldown:IsHidden() return true end
function modifier_doom_bringer_doom_custom_cooldown:IsPurgable() return false end
function modifier_doom_bringer_doom_custom_cooldown:IsPurgeException() return false end