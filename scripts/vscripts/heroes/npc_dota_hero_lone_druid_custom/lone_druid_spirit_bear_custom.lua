--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lone_druid_spirit_bear_custom", "heroes/npc_dota_hero_lone_druid_custom/lone_druid_spirit_bear_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lone_druid_spirit_bear_custom_disarmed", "heroes/npc_dota_hero_lone_druid_custom/lone_druid_spirit_bear_custom", LUA_MODIFIER_MOTION_NONE)

lone_druid_spirit_bear_custom = class({})

function lone_druid_spirit_bear_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_lone_druid/lone_druid_bear_blink_start.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_lone_druid/lone_druid_bear_blink_end.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_spirit_bear.vpcf", context )
    PrecacheResource( "particle", "particles/generic_gameplay/generic_disarm.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_lone_druid.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_lone_druid.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_lone_druid.vpcf", context)
end

lone_druid_spirit_bear_custom.modifier_lone_druid_2_bonus_dmg = {20,40,60}
lone_druid_spirit_bear_custom.modifier_lone_druid_3_armor = {5,10}
lone_druid_spirit_bear_custom.modifier_lone_druid_5_health = {5,10}
lone_druid_spirit_bear_custom.modifier_lone_druid_6_damage = {0.5,1}
lone_druid_spirit_bear_custom.modifier_lone_druid_7_attack_speed = {0.5,1,1.5}

function lone_druid_spirit_bear_custom:OnUpgrade()
    for _, unit in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED, FIND_ANY_ORDER, false)) do
        if unit:GetUnitName() == "npc_dota_lone_druid_bear_custom" and unit:GetOwner() == self:GetCaster() then
			unit:RemoveModifierByName("modifier_lone_druid_spirit_bear_custom")
			unit:AddNewModifier(self:GetCaster(), self, 'modifier_lone_druid_spirit_bear_custom', {})            
        end
    end
end

function lone_druid_spirit_bear_custom:OnHeroLevelUp()
    for _, unit in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED, FIND_ANY_ORDER, false)) do
        if unit:GetUnitName() == "npc_dota_lone_druid_bear_custom" and unit:GetOwner() == self:GetCaster() then
			unit:RemoveModifierByName("modifier_lone_druid_spirit_bear_custom")
			unit:AddNewModifier(self:GetCaster(), self, 'modifier_lone_druid_spirit_bear_custom', {})            
        end
    end
end

function lone_druid_spirit_bear_custom:OnSpellStart()
	if not IsServer() then return end

	local bear_count = 1

	if self:GetCaster():HasModifier("modifier_lone_druid_4") then
		bear_count = 2
	end

    for _, unit in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)) do
        if unit:GetUnitName() == "npc_dota_lone_druid_bear_custom" and unit:GetOwner() == self:GetCaster() then
            unit:ForceKill(false)               
        end
    end

	for bears = 1, bear_count do
		local origin = self:GetCaster():GetAbsOrigin() + RandomVector(100)

		local bear = CreateUnitByName("npc_dota_lone_druid_bear_custom", origin, true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
        bear:SetControllableByPlayer(self:GetCaster():GetPlayerID(), true)
        bear:SetOwner(self:GetCaster())
        bear:AddNewModifier(self:GetCaster(), self, 'modifier_lone_druid_spirit_bear_custom', {})
        bear:SetForwardVector( self:GetCaster():GetForwardVector() )
        bear:EmitSound("Hero_LoneDruid.SpiritBear.Cast")
        bear:SetHealth(bear:GetMaxHealth())
		bear:SetMana(bear:GetMaxMana())

        local start_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lone_druid/lone_druid_bear_blink_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, bear)
        ParticleManager:SetParticleControl(start_particle, 0, bear:GetAbsOrigin()) 

		local end_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lone_druid/lone_druid_bear_blink_end.vpcf", PATTACH_ABSORIGIN_FOLLOW, bear)
        ParticleManager:SetParticleControl(end_particle, 0, bear:GetAbsOrigin())
	end
end

modifier_lone_druid_spirit_bear_custom = class({})

function modifier_lone_druid_spirit_bear_custom:IsPurgeException() 	return false end
function modifier_lone_druid_spirit_bear_custom:IsHidden() return false end
function modifier_lone_druid_spirit_bear_custom:IsPurgable() return false end
function modifier_lone_druid_spirit_bear_custom:RemoveOnDeath() return false end
function modifier_lone_druid_spirit_bear_custom:IsPermanent() 		return true end

function modifier_lone_druid_spirit_bear_custom:OnCreated()
	self.bear_bat = self:GetAbility():GetSpecialValueFor("bear_bat")
	self.bear_hp = self:GetAbility():GetSpecialValueFor("bear_hp")
	self.bear_regen_tooltip = self:GetAbility():GetSpecialValueFor("bear_regen_tooltip")
	self.bear_armor = self:GetAbility():GetSpecialValueFor("bear_armor")
	self.backlash_damage = self:GetAbility():GetSpecialValueFor("backlash_damage")
	self.movespeed_tooltip = self:GetAbility():GetSpecialValueFor("movespeed_tooltip")
	self.scale = self:GetAbility():GetSpecialValueFor("scale")

	if not IsServer() then return end

	self.magic_amplify = self:GetCaster():GetSpellAmplification(false) 

	self.bonus_damage_talent = 0
	self.attack_speed_talent = 0
	self.health_talent = 0

	self.movespeed_talent = 0
	self.armor_talent = 0
	self.magical_resistance = 0


	if self:GetCaster():HasModifier("modifier_lone_druid_2") then
		self.bonus_damage_talent = self:GetAbility().modifier_lone_druid_2_bonus_dmg[self:GetCaster():GetTalentLevel("modifier_lone_druid_2")]
        self.movespeed_talent = self:GetAbility().modifier_lone_druid_2_bonus_dmg[self:GetCaster():GetTalentLevel("modifier_lone_druid_2")]
	end

	if self:GetCaster():HasModifier("modifier_lone_druid_3") then
		self.armor_talent = self:GetAbility().modifier_lone_druid_3_armor[self:GetCaster():GetTalentLevel("modifier_lone_druid_3")]
	end

	if self:GetCaster():HasModifier("modifier_lone_druid_5") then
		self.health_talent = self:GetCaster():GetStrength() * self:GetAbility().modifier_lone_druid_5_health[self:GetCaster():GetTalentLevel("modifier_lone_druid_5")]
	end

	if self:GetCaster():HasModifier("modifier_lone_druid_6") then
		self.bonus_damage_talent = self.bonus_damage_talent + (self:GetCaster():GetStrength() * self:GetAbility().modifier_lone_druid_6_damage[self:GetCaster():GetTalentLevel("modifier_lone_druid_6")])
	end

	if self:GetCaster():HasModifier("modifier_lone_druid_7") then
		self.attack_speed_talent = self.attack_speed_talent + (self:GetCaster():GetStrength() * self:GetAbility().modifier_lone_druid_7_attack_speed[self:GetCaster():GetTalentLevel("modifier_lone_druid_7")])
	end

	if self:GetCaster():HasModifier("modifier_lone_druid_23") then
		self.armor_talent = self.armor_talent + 10
		self.magical_resistance = 20
	end

	self.bonus_hp_per_level = self:GetAbility():GetSpecialValueFor("bonus_hp_per_level")
	self.bonus_damage_per_level = self:GetAbility():GetSpecialValueFor("bonus_damage_per_level")

	self.health_bonus = self.bear_hp + (self:GetCaster():GetLevel() * self.bonus_hp_per_level)

	local damage_min = 28 + ( (self:GetCaster():GetLevel() - 1) * self.bonus_damage_per_level )
	local damage_max = 28 + ( (self:GetCaster():GetLevel() - 1) * self.bonus_damage_per_level )

	self:GetParent():SetModelScale(self.scale)
	self:GetParent():SetBaseHealthRegen(self.bear_regen_tooltip)
	self:GetParent():SetPhysicalArmorBaseValue(self.bear_armor)
	self:GetParent():SetBaseMoveSpeed(self.movespeed_tooltip)
	self:GetParent():SetBaseDamageMin(damage_min)
	self:GetParent():SetBaseDamageMax(damage_max)

	local lone_druid_spirit_bear_return = self:GetParent():FindAbilityByName("lone_druid_spirit_bear_return")
	if lone_druid_spirit_bear_return then
		lone_druid_spirit_bear_return:SetLevel(self:GetAbility():GetLevel())
		lone_druid_spirit_bear_return:SetHidden(false)
	end

	local lone_druid_savage_roar_bear = self:GetParent():FindAbilityByName("lone_druid_savage_roar_custom")
	if lone_druid_savage_roar_bear then
		local lone_druid_savage_roar_bear_caster = self:GetCaster():FindAbilityByName("lone_druid_savage_roar_custom")
		if lone_druid_savage_roar_bear_caster and lone_druid_savage_roar_bear_caster:GetLevel() > 0 then
			lone_druid_savage_roar_bear:SetLevel(lone_druid_savage_roar_bear_caster:GetLevel())
			lone_druid_savage_roar_bear:SetHidden(false)
			lone_druid_savage_roar_bear:StartCooldown(lone_druid_savage_roar_bear_caster:GetCooldownTimeRemaining())
		else
			lone_druid_savage_roar_bear:SetHidden(true)
			lone_druid_savage_roar_bear:StartCooldown(lone_druid_savage_roar_bear_caster:GetCooldownTimeRemaining())
		end
	end
    
    local lone_druid_entangle = self:GetCaster():FindAbilityByName("lone_druid_entangle")
	local lone_druid_spirit_bear_entangle = self:GetParent():FindAbilityByName("lone_druid_spirit_bear_entangle")
	if lone_druid_spirit_bear_entangle and lone_druid_entangle then
		lone_druid_spirit_bear_entangle:SetLevel(lone_druid_entangle:GetLevel())
		lone_druid_spirit_bear_entangle:SetHidden(false)
	end

	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()

	self:StartIntervalThink(FrameTime())
end

function modifier_lone_druid_spirit_bear_custom:OnRefresh()
	self.bear_bat = self:GetAbility():GetSpecialValueFor("bear_bat")
	self:OnCreated()
end

function modifier_lone_druid_spirit_bear_custom:OnIntervalThink()
	if not IsServer() then return end

	self.bonus_damage_talent = 0
	self.attack_speed_talent = 0
	self.health_talent = 0

	self.movespeed_talent = 0
	self.armor_talent = 0
	self.magical_resistance = 0
	
	if self:GetCaster():HasModifier("modifier_lone_druid_2") then
		self.bonus_damage_talent = self:GetAbility().modifier_lone_druid_2_bonus_dmg[self:GetCaster():GetTalentLevel("modifier_lone_druid_2")]
        self.movespeed_talent = self:GetAbility().modifier_lone_druid_2_bonus_dmg[self:GetCaster():GetTalentLevel("modifier_lone_druid_2")]
	end

	if self:GetCaster():HasModifier("modifier_lone_druid_3") then
		self.armor_talent = self:GetAbility().modifier_lone_druid_3_armor[self:GetCaster():GetTalentLevel("modifier_lone_druid_3")]
	end

	if self:GetCaster():HasModifier("modifier_lone_druid_5") then
		self.health_talent = self:GetCaster():GetStrength() * self:GetAbility().modifier_lone_druid_5_health[self:GetCaster():GetTalentLevel("modifier_lone_druid_5")]
	end

	if self:GetCaster():HasModifier("modifier_lone_druid_6") then
		self.bonus_damage_talent = self.bonus_damage_talent + (self:GetCaster():GetStrength() * self:GetAbility().modifier_lone_druid_6_damage[self:GetCaster():GetTalentLevel("modifier_lone_druid_6")])
	end

	if self:GetCaster():HasModifier("modifier_lone_druid_7") then
		self.attack_speed_talent = self.attack_speed_talent + (self:GetCaster():GetStrength() * self:GetAbility().modifier_lone_druid_7_attack_speed[self:GetCaster():GetTalentLevel("modifier_lone_druid_7")])
	end

	if self:GetCaster():HasModifier("modifier_lone_druid_23") then
		self.armor_talent = self.armor_talent + 10
		self.magical_resistance = 20
	end

	self.magic_amplify = self:GetCaster():GetSpellAmplification(false) 

	local distance = (self:GetCaster():GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D()

	if distance < self:GetAbility():GetSpecialValueFor("distance_silence") then
		self:GetParent():RemoveModifierByName("modifier_lone_druid_spirit_bear_custom_disarmed")
	else
		self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_lone_druid_spirit_bear_custom_disarmed", {})
	end

	local lone_druid_savage_roar_bear = self:GetParent():FindAbilityByName("lone_druid_savage_roar_custom")
	if lone_druid_savage_roar_bear then
		local lone_druid_savage_roar_bear_caster = self:GetCaster():FindAbilityByName("lone_druid_savage_roar_custom")
		if lone_druid_savage_roar_bear_caster and lone_druid_savage_roar_bear_caster:GetLevel() > 0 then
			lone_druid_savage_roar_bear:SetLevel(lone_druid_savage_roar_bear_caster:GetLevel())
			lone_druid_savage_roar_bear:SetHidden(false)
		else
			lone_druid_savage_roar_bear:SetHidden(true)
		end
	end

    local lone_druid_entangle = self:GetCaster():FindAbilityByName("lone_druid_entangle")
	local lone_druid_spirit_bear_entangle = self:GetParent():FindAbilityByName("lone_druid_spirit_bear_entangle")
	if lone_druid_spirit_bear_entangle and lone_druid_entangle then
		lone_druid_spirit_bear_entangle:SetLevel(lone_druid_entangle:GetLevel())
		lone_druid_spirit_bear_entangle:SetHidden(false)
        if lone_druid_entangle:GetLevel() > 0 then
            local lone_druid_entangle_new = self:GetParent():FindAbilityByName("lone_druid_entangle")
            if not lone_druid_entangle_new then
                lone_druid_entangle_new = self:GetParent():AddAbility("lone_druid_entangle")
                lone_druid_entangle_new:SetHidden(true)
            end
            if lone_druid_entangle_new then
                lone_druid_entangle_new:SetLevel(lone_druid_entangle:GetLevel())
            end
        end
	end
    

	self:SendBuffRefreshToClients()

	if not self:GetCaster():IsAlive() then
		self:GetParent():ForceKill(false)
	end
end

function modifier_lone_druid_spirit_bear_custom:CheckState()
    if not self:GetCaster():HasModifier("modifier_lone_druid_3") then return end
    return
    {
        [MODIFIER_STATE_CANNOT_MISS] = true
    }
end

function modifier_lone_druid_spirit_bear_custom:DeclareFunctions()
	return 
	{
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end

function modifier_lone_druid_spirit_bear_custom:AddCustomTransmitterData()
    return 
    {
        health_bonus = self.health_bonus,
        bonus_damage_talent = self.bonus_damage_talent,
        attack_speed_talent = self.attack_speed_talent,
        health_talent = self.health_talent,
        movespeed_talent = self.movespeed_talent,
		armor_talent = self.armor_talent,
		magical_resistance = self.magical_resistance,
    }
end

function modifier_lone_druid_spirit_bear_custom:HandleCustomTransmitterData( data )
    self.health_bonus = data.health_bonus
    self.bonus_damage_talent = data.bonus_damage_talent
    self.attack_speed_talent = data.attack_speed_talent
    self.health_talent = data.health_talent
    self.movespeed_talent = data.movespeed_talent
	self.armor_talent = data.armor_talent
	self.magical_resistance = data.magical_resistance
end

function modifier_lone_druid_spirit_bear_custom:GetModifierHealthBonus()
    return self.health_bonus + self.health_talent
end

function modifier_lone_druid_spirit_bear_custom:GetModifierExtraHealthBonus()
    return self.health_bonus + self.health_talent
end

function modifier_lone_druid_spirit_bear_custom:GetModifierPreAttack_BonusDamage()
    return self.bonus_damage_talent
end

function modifier_lone_druid_spirit_bear_custom:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed_talent
end

function modifier_lone_druid_spirit_bear_custom:GetModifierMoveSpeedBonus_Constant()
	return self.movespeed_talent
end

function modifier_lone_druid_spirit_bear_custom:GetModifierPhysicalArmorBonus()
	return self.armor_talent
end

function modifier_lone_druid_spirit_bear_custom:GetModifierMagicalResistanceBonus()
	return self.magical_resistance
end

function modifier_lone_druid_spirit_bear_custom:OnDeath(params)
	if not IsServer() then return end
	if params.unit ~= self:GetParent() then return end
    if params.attacker and params.attacker:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
        local backlash_damage = self:GetAbility():GetSpecialValueFor("backlash_damage")
        ApplyDamage({attacker = params.attacker, victim = self:GetParent(), damage = self:GetParent():GetMaxHealth() / 100 * backlash_damage, damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility()})
    end
	if self:GetParent():HasModifier("modifier_lone_druid_unity_with_nature_bear") then
		self:GetCaster():RemoveModifierByName("modifier_lone_druid_unity_with_nature")
	end
end

function modifier_lone_druid_spirit_bear_custom:GetModifierBaseAttackTimeConstant()
	return self.bear_bat
end

modifier_lone_druid_spirit_bear_custom_disarmed = class({})

function modifier_lone_druid_spirit_bear_custom_disarmed:IsHidden() return true end
function modifier_lone_druid_spirit_bear_custom_disarmed:IsPurgable() return false end

function modifier_lone_druid_spirit_bear_custom_disarmed:CheckState()
	return 
	{
		[MODIFIER_STATE_DISARMED] = true,
	}
end

function modifier_lone_druid_spirit_bear_custom_disarmed:GetStatusEffectName()
	return "particles/status_fx/status_effect_spirit_bear.vpcf"
end

function modifier_lone_druid_spirit_bear_custom_disarmed:StatusEffectPriority()
    return 99999
end

function modifier_lone_druid_spirit_bear_custom_disarmed:GetEffectName()
	return "particles/generic_gameplay/generic_disarm.vpcf"
end

function modifier_lone_druid_spirit_bear_custom_disarmed:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end