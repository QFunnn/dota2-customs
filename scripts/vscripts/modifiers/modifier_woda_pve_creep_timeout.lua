--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_pve_creep_timeout_armor_debuff", "modifiers/modifier_woda_pve_creep_timeout", LUA_MODIFIER_MOTION_NONE)

modifier_woda_pve_creep_timeout = class({})

function modifier_woda_pve_creep_timeout:GetTexture()
	return "ogre_magi_bloodlust"
end

function modifier_woda_pve_creep_timeout:IsHidden()
	return false
end

function modifier_woda_pve_creep_timeout:IsDebuff()
	return false
end

function modifier_woda_pve_creep_timeout:IsPurgable()
	return false
end

function modifier_woda_pve_creep_timeout:GetEffectName()
    return "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff.vpcf"
end

function modifier_woda_pve_creep_timeout:OnCreated( kv )
	if IsServer() then
		self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_tower_truesight_aura", {})
		self:StartIntervalThink( 1 )
        self:SetStackCount(1)
		self:GetParent():EmitSound("Hero_OgreMagi.Bloodlust.Target")
    	self:GetParent():EmitSound("Hero_OgreMagi.Bloodlust.Target.FP")
	end
end

function modifier_woda_pve_creep_timeout:OnIntervalThink()
	if IsServer() then
        if self:GetParent():HasModifier("modifier_woda_pve_creep_timeout_cooldown") then
            self:SetStackCount(0)
        else
	       self:SetStackCount(self:GetStackCount()+1)
        end

        if self:GetParent():GetUnitName() == "npc_woda_pig_pve" or self:GetParent():GetUnitName() == "npc_woda_frog_pve" then
            local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
            for _,enemy in pairs(enemies) do
                ApplyDamage({attacker = self:GetParent(), victim = enemy, ability = nil, damage = enemy:GetMaxHealth() / 100 * self:GetStackCount(), damage_type = DAMAGE_TYPE_PURE})
            end
        end
	end
end

function modifier_woda_pve_creep_timeout:DeclareFunctions()
    local funcs = {
    	 
    	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,
		MODIFIER_PROPERTY_MODEL_SCALE,
	}
	return funcs
end

function modifier_woda_pve_creep_timeout:CheckState()
	local state =
	{
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [MODIFIER_STATE_CANNOT_MISS] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
	return state
end

function modifier_woda_pve_creep_timeout:OnAttackLanded(params)
    if IsServer() then
        if self:GetParent() == params.attacker then
            local hTarget = params.target
            if self:GetParent():HasModifier("modifier_woda_pve_creep_timeout_cooldown") then return end
            if hTarget ~= nil then
                local hDebuff = hTarget:FindModifierByName("modifier_woda_pve_creep_timeout_armor_debuff")
                if hDebuff == nil then
                    hDebuff = hTarget:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_woda_pve_creep_timeout_armor_debuff", { duration = 12.0 })
                    if hDebuff ~= nil then
                        hDebuff:SetStackCount(0)
                    end
                end
                if hDebuff ~= nil then
                    hDebuff:SetStackCount(hDebuff:GetStackCount() + 1)
                    hDebuff:SetDuration(12.0, true)
                end
            end
        end
    end
    return 0
end

function modifier_woda_pve_creep_timeout:GetModifierAttackSpeedBonus_Constant(params)
   	return self:GetStackCount() *5
end

function modifier_woda_pve_creep_timeout:GetModifierDamageOutgoing_Percentage(params)
   	return self:GetStackCount() *15
end

function modifier_woda_pve_creep_timeout:GetModifierMoveSpeed_AbsoluteMin(params)
   return self:GetParent():GetBaseMoveSpeed()+math.floor(self:GetParent():GetBaseMoveSpeed() * self:GetStackCount() * 0.05)
end

function modifier_woda_pve_creep_timeout:GetModifierModelScale(params)
    return 55
end

modifier_woda_pve_creep_timeout_armor_debuff = class({})

function modifier_woda_pve_creep_timeout_armor_debuff:GetTexture()
	return "item_desolator"
end

function modifier_woda_pve_creep_timeout_armor_debuff:IsHidden()
	return false
end

function modifier_woda_pve_creep_timeout_armor_debuff:IsDebuff()
	return true
end

function modifier_woda_pve_creep_timeout_armor_debuff:IsPurgable()
	return false
end

function modifier_woda_pve_creep_timeout_armor_debuff:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
	return funcs
end

function modifier_woda_pve_creep_timeout_armor_debuff:GetModifierPhysicalArmorBonus(params)
   	return -1 * self:GetStackCount()
end

modifier_woda_pve_creep_timeout_manacost = class({})
function modifier_woda_pve_creep_timeout_manacost:GetTexture()
    return "nyx_assassin_mana_burn"
end
function modifier_woda_pve_creep_timeout_manacost:IsPurgable() return false end
function modifier_woda_pve_creep_timeout_manacost:IsDebuff() return true end
function modifier_woda_pve_creep_timeout_manacost:IsPurgeException() return false end
function modifier_woda_pve_creep_timeout_manacost:RemoveOnDeath() return false end
function modifier_woda_pve_creep_timeout_manacost:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_woda_pve_creep_timeout_manacost:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(1)
end

function modifier_woda_pve_creep_timeout_manacost:OnIntervalThink()
	if not IsServer() then return end
    if self:GetParent():IsAlive() and not self:GetParent():HasModifier("modifier_woda_pve_creep_timeout_cooldown") then
	   self:IncrementStackCount()
       ApplyDamage({ attacker = self:GetParent(), victim = self:GetParent(), ability = nil, damage = 100 * self:GetStackCount(), damage_type = DAMAGE_TYPE_PURE })
    else
        self:SetStackCount(0)
    end
end


function modifier_woda_pve_creep_timeout_manacost:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING
	}
end

function modifier_woda_pve_creep_timeout_manacost:GetModifierPercentageManacostStacking()
	return -15 * self:GetStackCount()
end

modifier_woda_pve_creep_upgrade_wave = class({})

function modifier_woda_pve_creep_upgrade_wave:IsHidden() return true end

function modifier_woda_pve_creep_upgrade_wave:IsPurgable() return false end

function modifier_woda_pve_creep_upgrade_wave:IsPurgeException() return false end

function modifier_woda_pve_creep_upgrade_wave:OnCreated(data)
	if not IsServer() then return end

    self:SetStackCount(data.wave)

    -- Переменные
    local pve_bonus_per_wave_bonus_damage = data.pve_bonus_per_wave_bonus_damage * data.wave
    local pve_bonus_per_wave_bonus_damage_pct = data.pve_bonus_per_wave_bonus_damage_pct * data.wave
    local pve_bonus_per_wave_armor = data.pve_bonus_per_wave_armor * data.wave
    local pve_bonus_per_wave_armor_pct = data.pve_bonus_per_wave_armor_pct * data.wave
    local pve_bonus_per_wave_magical_resistance = data.pve_bonus_per_wave_magical_resistance * data.wave
    local pve_bonus_per_wave_health = data.pve_bonus_per_wave_health * data.wave
    local pve_bonus_per_wave_health_pct = data.pve_bonus_per_wave_health_pct * data.wave
    local pve_bonus_per_wave_spell_amplify = data.pve_bonus_per_wave_spell_amplify * data.wave
    local pve_bonus_per_wave_attack_speed = data.pve_bonus_per_wave_attack_speed * data.wave
    local pve_bonus_per_wave_move_speed = data.pve_bonus_per_wave_move_speed * data.wave
    local pve_bonus_per_wave_global_damage = data.pve_bonus_per_wave_global_damage * data.wave
    local pve_bonus_per_wave_status_resistance = data.pve_bonus_per_wave_status_resistance * data.wave
    -- Урон
    local damage_from_base_min = self:GetParent():GetBaseDamageMin() + pve_bonus_per_wave_bonus_damage
    local damage_from_base_max = self:GetParent():GetBaseDamageMin() + pve_bonus_per_wave_bonus_damage
	damage_from_base_min = damage_from_base_min + (damage_from_base_min / 100 * pve_bonus_per_wave_bonus_damage_pct)
	damage_from_base_max = damage_from_base_max + (damage_from_base_max / 100 * pve_bonus_per_wave_bonus_damage_pct)

    -- Броня
    local armor = self:GetParent():GetPhysicalArmorBaseValue() + pve_bonus_per_wave_armor
    armor = armor + (armor / 100 * pve_bonus_per_wave_armor_pct)

    -- Магический резист
    self.magical_resistance = math.min(pve_bonus_per_wave_magical_resistance, 90)

    -- Здоровье
    local health = self:GetParent():GetMaxHealth() + pve_bonus_per_wave_health
    health = health + (health / 100 * pve_bonus_per_wave_health_pct)

    -- Магический Урон
    self.spell_amplify = pve_bonus_per_wave_spell_amplify

    -- Скорость атаки
    self.attack_speed = pve_bonus_per_wave_attack_speed

    -- передвижение
    self.move_speed = pve_bonus_per_wave_move_speed

    -- входящий Урон
    self.incoming_damage = pve_bonus_per_wave_global_damage

    -- Сопротивление эффектам
    self.status_resist = pve_bonus_per_wave_status_resistance

    self:GetParent():SetPhysicalArmorBaseValue(armor)
    self:GetParent():SetBaseDamageMin(damage_from_base_min)
    self:GetParent():SetBaseDamageMax(damage_from_base_max)
    self:GetParent():SetBaseMaxHealth(health)
    self:GetParent():SetHealth(self:GetParent():GetMaxHealth())
    self:SetHasCustomTransmitterData(true)
    self:StartIntervalThink(0.1)
end

function modifier_woda_pve_creep_upgrade_wave:OnIntervalThink()
    if not IsServer() then return end
    if self.mana_b == nil then
        self.mana_b = true
        self:GetParent():SetMana(self:GetParent():GetMaxMana())
    end
    self:SendBuffRefreshToClients()
end

function modifier_woda_pve_creep_upgrade_wave:AddCustomTransmitterData()
    return 
    {
        magical_resistance = self.magical_resistance,
        spell_amplify = self.spell_amplify,
        attack_speed = self.attack_speed,
        move_speed = self.move_speed,
        incoming_damage = self.incoming_damage,
        status_resist = self.status_resist,
    }
end

function modifier_woda_pve_creep_upgrade_wave:HandleCustomTransmitterData( data )
    self.magical_resistance = data.magical_resistance
    self.spell_amplify = data.spell_amplify
    self.attack_speed = data.attack_speed
    self.move_speed = data.move_speed
    self.incoming_damage = data.incoming_damage
    self.status_resist = data.status_resist
end

function modifier_woda_pve_creep_upgrade_wave:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_MAX,
        MODIFIER_PROPERTY_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_MANA_BONUS,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
	}
end

function modifier_woda_pve_creep_upgrade_wave:GetModifierStatusResistanceStacking()
    return self.status_resist
end

function modifier_woda_pve_creep_upgrade_wave:GetModifierMoveSpeedBonus_Constant()
    return self.move_speed
end

function modifier_woda_pve_creep_upgrade_wave:GetModifierIncomingDamage_Percentage()
    return self.incoming_damage
end

function modifier_woda_pve_creep_upgrade_wave:GetModifierMoveSpeed_Max( params )
    return 30000
end

function modifier_woda_pve_creep_upgrade_wave:GetModifierMoveSpeed_Limit( params )
    return 30000
end

function modifier_woda_pve_creep_upgrade_wave:GetModifierIgnoreMovespeedLimit( params )
    return 1
end

function modifier_woda_pve_creep_upgrade_wave:GetModifierAttackSpeedBonus_Constant()
    return self.attack_speed
end

function modifier_woda_pve_creep_upgrade_wave:GetModifierMagicalResistanceBonus()
    return self.magical_resistance
end

function modifier_woda_pve_creep_upgrade_wave:GetModifierTotalDamageOutgoing_Percentage(params)
    if params.damage_category == DOTA_DAMAGE_CATEGORY_SPELL then 
    	return self.spell_amplify
    end
end

function modifier_woda_pve_creep_upgrade_wave:GetModifierManaBonus()
    return self:GetCaster():GetMaxHealth() / 4
end

modifier_woda_pve_creep_timeout_cooldown = class({})
function modifier_woda_pve_creep_timeout_cooldown:IsPurgable() return false end
function modifier_woda_pve_creep_timeout_cooldown:IsPurgeException() return false end
function modifier_woda_pve_creep_timeout_cooldown:IsHidden() return true end
function modifier_woda_pve_creep_timeout_cooldown:RemoveOnDeath() return false end