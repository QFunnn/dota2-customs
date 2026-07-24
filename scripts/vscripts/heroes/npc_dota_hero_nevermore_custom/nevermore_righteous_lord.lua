--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_nevermore_righteous_lord", "heroes/npc_dota_hero_nevermore_custom/nevermore_righteous_lord", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_righteous_lord_debuff", "heroes/npc_dota_hero_nevermore_custom/nevermore_righteous_lord", LUA_MODIFIER_MOTION_NONE)

nevermore_righteous_lord = class({})

function nevermore_righteous_lord:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_doom_bringer/doom_bringer_doom_aura_for_nevermore.vpcf", context )
    PrecacheResource( "particle", "particles/doom_bringer_doom_aura_2_ring_11111.vpcf", context )
    PrecacheResource( "particle", "particles/doom_bringer_doom_aura_2_ring_22222.vpcf", context )
end

function nevermore_righteous_lord:GetBehavior()
    if self:GetCaster():HasModifier("modifier_nevermore_2") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_TOGGLE + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_TOGGLE + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_HIDDEN + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE
end

nevermore_righteous_lord.modifier_nevermore_4 = {150,300}

function nevermore_righteous_lord:OnToggle()
    local caster = self:GetCaster()
    local toggle = self:GetToggleState()
    if not IsServer() then return end
    if toggle then
        self.modifier = caster:AddNewModifier( caster, self, "modifier_nevermore_righteous_lord", {} )
    else
        if self.modifier and not self.modifier:IsNull() then
            self.modifier:Destroy()
        end
        self.modifier = nil
    end
    self:StartCooldown(1)
end

function nevermore_righteous_lord:GetCastRange(vLocation, hTarget)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_nevermore_4") then
		bonus = self.modifier_nevermore_4[self:GetCaster():GetTalentLevel("modifier_nevermore_4")]
	end
	return self:GetSpecialValueFor("radius") + bonus
end

modifier_nevermore_righteous_lord = class({})

function modifier_nevermore_righteous_lord:OnCreated()
	if not IsServer() then return end
	self.aura = false
    local bonus = 0
	if self:GetCaster():HasModifier("modifier_nevermore_4") then
		bonus = self:GetAbility().modifier_nevermore_4[self:GetCaster():GetTalentLevel("modifier_nevermore_4")]
	end
    self.current_radius =  self:GetCaster():GetAoeBonus(self:GetAbility():GetSpecialValueFor("radius") + bonus)
	self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_doom_bringer/doom_bringer_doom_aura_for_nevermore.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(self.particle, 1, Vector(self.current_radius, self.current_radius, self.current_radius))
	self:AddParticle(self.particle, false, false, -1, false, false)
	self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("interval"))
end

function modifier_nevermore_righteous_lord:OnIntervalThink()
	if not IsServer() then return end
    if self.current_radius ~= self:GetAuraRadius() then
        self.current_radius = self:GetAuraRadius()
        if self.particle then
            ParticleManager:DestroyParticle(self.particle, true)
            ParticleManager:ReleaseParticleIndex(self.particle)
        end
        self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_doom_bringer/doom_bringer_doom_aura_for_nevermore.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(self.particle, 1, Vector(self.current_radius, self.current_radius, self.current_radius))
        self:AddParticle(self.particle, false, false, -1, false, false)
    end
	self.aura = false
	local damage_self = ( (self:GetParent():GetMaxHealth() / 100 * self:GetAbility():GetSpecialValueFor("damage_self")) + self:GetAbility():GetSpecialValueFor("base_damage_self") ) * self:GetAbility():GetSpecialValueFor("interval")
	if not self:GetParent():IsMagicImmune() then
		damage_self = ApplyDamage({victim = self:GetParent(), attacker = self:GetParent(), damage = damage_self, ability = self:GetAbility(), damage_flags = DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_NON_LETHAL, damage_type = DAMAGE_TYPE_MAGICAL})
	end
	if self:GetParent():GetHealth() < damage_self and not self:GetParent():IsMagicImmune() then
		self.aura = false
		self:GetAbility():ToggleAbility()
		return
	end
	self.aura = true
	self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("interval"))
end

function modifier_nevermore_righteous_lord:IsAura()
	return self.aura
end

function modifier_nevermore_righteous_lord:GetModifierAura()
    return "modifier_nevermore_righteous_lord_debuff"
end

function modifier_nevermore_righteous_lord:GetAuraRadius()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_nevermore_4") then
		bonus = self:GetAbility().modifier_nevermore_4[self:GetCaster():GetTalentLevel("modifier_nevermore_4")]
	end
    return self:GetCaster():GetAoeBonus(self:GetAbility():GetSpecialValueFor("radius") + bonus)
end

function modifier_nevermore_righteous_lord:GetAuraDuration()
    return 0.1
end

function modifier_nevermore_righteous_lord:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_nevermore_righteous_lord:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_OTHER
end

function modifier_nevermore_righteous_lord:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
end

function modifier_nevermore_righteous_lord:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_nevermore_righteous_lord:GetModifierSpellAmplify_Percentage()
	return self:GetAbility():GetSpecialValueFor("spell_amplify")
end

modifier_nevermore_righteous_lord_debuff = class({})

function modifier_nevermore_righteous_lord_debuff:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("interval"))
end

function modifier_nevermore_righteous_lord_debuff:OnIntervalThink()
	if not IsServer() then return end

    if self:GetParent():IsOther() and self:GetParent():GetUnitName() ~= "npc_dota_weaver_swarm" then
        return
    end

	local damage = ( (self:GetCaster():GetMaxHealth() / 100 * self:GetAbility():GetSpecialValueFor("damage_enemy_health")) + self:GetAbility():GetSpecialValueFor("base_damage_enemy") ) * self:GetAbility():GetSpecialValueFor("interval")
    local damage_type = DAMAGE_TYPE_MAGICAL
    if self:GetCaster():HasModifier("modifier_nevermore_5") then
        damage_type = DAMAGE_TYPE_PURE
    end
	ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, ability = self:GetAbility(), damage_type = damage_type})

	self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("interval"))

	if self:GetCaster():HasModifier("modifier_nevermore_1") then
		if self:GetParent():GetUnitName() == "npc_woda_pig" or self:GetParent():GetUnitName() == "npc_woda_frog" or self:GetParent():GetUnitName() == "npc_woda_pig_pve" or self:GetParent():GetUnitName() == "npc_woda_frog_pve" or self:GetParent():GetUnitName() == "npc_dota_weaver_swarm" then
			if self:GetParent().sf_pig_killer == nil then
				self:GetParent().sf_pig_killer = 0.25
			end
			self:GetParent().sf_pig_killer = self:GetParent().sf_pig_killer + 0.25
			if self:GetParent().sf_pig_killer >= 1 then
				self:GetParent().sf_pig_killer = 0

                if self:GetParent():GetUnitName() == "npc_dota_weaver_swarm" then
                    self:GetCaster():PerformAttack(self:GetParent(), true, true, true, true, false, false, true)
                else
                    if self:GetParent():GetHealth() <= 1 then
                        self:GetParent():Kill(self:GetAbility(), self:GetCaster())
                    else
                        self:GetParent():SetHealth(self:GetParent():GetHealth() - 1)
                    end
                end
			end
		end
	end
end