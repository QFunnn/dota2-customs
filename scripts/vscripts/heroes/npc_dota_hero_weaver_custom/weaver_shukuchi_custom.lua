--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_weaver_shukuchi_custom", "heroes/npc_dota_hero_weaver_custom/weaver_shukuchi_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_shukuchi_custom_shield", "heroes/npc_dota_hero_weaver_custom/weaver_shukuchi_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_shukuchi_custom_damage_debuff", "heroes/npc_dota_hero_weaver_custom/weaver_shukuchi_custom", LUA_MODIFIER_MOTION_NONE)

weaver_shukuchi_custom = class({})

weaver_shukuchi_custom.modifier_weaver_15_base = 30
weaver_shukuchi_custom.modifier_weaver_15_max_mana = {3,6}
weaver_shukuchi_custom.modifier_weaver_16 = {100,200,300}
weaver_shukuchi_custom.modifier_weaver_16_duration = 5
weaver_shukuchi_custom.modifier_weaver_18 = 5
weaver_shukuchi_custom.modifier_weaver_18_max = {4,9}
weaver_shukuchi_custom.modifier_weaver_18_duration = 7
weaver_shukuchi_custom.modifier_weaver_21 = 100
weaver_shukuchi_custom.modifier_weaver_21_cooldown = -2
weaver_shukuchi_custom.modifier_weaver_20 = {-6,-12,-18}

function weaver_shukuchi_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_weaver_3") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, level)
end

function weaver_shukuchi_custom:GetHealthCost(level)
    if self:GetCaster():HasModifier("modifier_weaver_3") then
        return self.BaseClass.GetManaCost(self, level)
    end
    return 0
end

function weaver_shukuchi_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_weaver_21") then
        bonus = self.modifier_weaver_21_cooldown
    end
    return self.BaseClass.GetCooldown( self, iLevel ) + bonus
end

function weaver_shukuchi_custom:OnSpellStart()
    if not IsServer() then return end
	self:GetCaster():EmitSound("Hero_Weaver.Shukuchi")
	if self:GetCaster():FindModifierByNameAndCaster("modifier_weaver_shukuchi_custom", self:GetCaster()) then
		self:GetCaster():RemoveModifierByName("modifier_weaver_shukuchi_custom")
	end
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_weaver_shukuchi_custom", {duration = self:GetSpecialValueFor("duration")})
    if self:GetCaster():HasModifier("modifier_weaver_16") then
        self:GetCaster():RemoveModifierByName("modifier_weaver_shukuchi_custom_shield")
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_weaver_shukuchi_custom_shield", {duration = self.modifier_weaver_16_duration})
    end
end

modifier_weaver_shukuchi_custom = class({})

function modifier_weaver_shukuchi_custom:IsPurgable() return false end
function modifier_weaver_shukuchi_custom:IsPurgeException() return false end

function modifier_weaver_shukuchi_custom:GetEffectName()
	return "particles/units/heroes/hero_weaver/weaver_shukuchi.vpcf"
end

function modifier_weaver_shukuchi_custom:OnCreated()
	self.min_movespeed_override = self:GetAbility():GetSpecialValueFor("min_movespeed_override")
    self.status_resistance = self:GetAbility():GetSpecialValueFor("status_resistance")
	if not IsServer() then return end
	self.damage_type		= self:GetAbility():GetAbilityDamageType()
	self.damage				= self:GetAbility():GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_weaver_15") then
        self.damage = self.damage + (self:GetCaster():GetMaxMana() / 100 * self:GetAbility().modifier_weaver_15_max_mana[self:GetCaster():GetTalentLevel("modifier_weaver_15")]) + self:GetAbility().modifier_weaver_15_base
    end
	self.radius				= self:GetAbility():GetSpecialValueFor("radius")
	self.hit_targets		= {}
	self.shukuchi_particle	= nil
	self.damage_table		= 
    {
		victim 			= nil,
		damage 			= self.damage,
		damage_type		= self.damage_type,
		damage_flags 	= DOTA_DAMAGE_FLAG_NONE,
		attacker 		= self:GetParent(),
		ability 		= self:GetAbility()
	}	
	self:StartIntervalThink(FrameTime())
end

function modifier_weaver_shukuchi_custom:OnIntervalThink()
    if not IsServer() then return end
	self.enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
	for _, enemy in pairs(self.enemies) do
		if not self.hit_targets[enemy] then
			local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_weaver/weaver_shukuchi_damage_arc.vpcf", PATTACH_ABSORIGIN, enemy)
			ParticleManager:SetParticleControl(particle, 1, self:GetParent():GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(particle)
			self.damage_table.victim = enemy
			ApplyDamage(self.damage_table)
            if self:GetCaster():HasModifier("modifier_weaver_18") then
                enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_weaver_shukuchi_custom_damage_debuff", {duration = self:GetAbility().modifier_weaver_18_duration})
            end
			self.hit_targets[enemy]	= true
		end
	end
end

function modifier_weaver_shukuchi_custom:OnDestroy()
    if not IsServer() then return end
    if not self:GetCaster():HasModifier("modifier_weaver_3") then return end
    local modifier_weaver_geminate_attack_custom = self:GetCaster():FindModifierByName("modifier_weaver_geminate_attack_custom")
    if modifier_weaver_geminate_attack_custom == nil then return end
    for enemy, _ in pairs(self.hit_targets) do
        modifier_weaver_geminate_attack_custom:FastAttack(enemy)
    end
end

function modifier_weaver_shukuchi_custom:CheckState()
    return 
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION]	= true,
        [MODIFIER_STATE_UNSLOWABLE]			= true
    }
end

function modifier_weaver_shukuchi_custom:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,
	}
end

function modifier_weaver_shukuchi_custom:GetModifierMoveSpeed_AbsoluteMin()
	return self.min_movespeed_override
end

function modifier_weaver_shukuchi_custom:GetModifierInvisibilityLevel()
	return 1
end

function modifier_weaver_shukuchi_custom:GetModifierStatusResistanceStacking()
    return self.status_resistance
end

function modifier_weaver_shukuchi_custom:OnAttack(keys)
	if keys.attacker == self:GetParent() and not keys.no_attack_cooldown and self:GetDuration() - self:GetRemainingTime() > 0.25 then
		self:Destroy()
	end
end

function modifier_weaver_shukuchi_custom:GetModifierConstantHealthRegen()
    if not self:GetCaster():HasModifier("modifier_weaver_21") then return end
	return self:GetCaster():GetManaRegen() / 100 * self:GetAbility().modifier_weaver_21
end

function modifier_weaver_shukuchi_custom:GetModifierIncomingDamage_Percentage()
    if not self:GetCaster():HasModifier("modifier_weaver_20") then return end
	return self:GetAbility().modifier_weaver_20[self:GetCaster():GetTalentLevel("modifier_weaver_20")]
end

modifier_weaver_shukuchi_custom_shield = class({})
function modifier_weaver_shukuchi_custom_shield:IsPurgable() return false end
function modifier_weaver_shukuchi_custom_shield:IsPurgeException() return false end
function modifier_weaver_shukuchi_custom_shield:OnCreated(keys)
    self.start_shield = self:GetAbility().modifier_weaver_16[self:GetCaster():GetTalentLevel("modifier_weaver_16")]
    if not IsServer() then return end
	self.damage_absorb = self:GetAbility().modifier_weaver_16[self:GetCaster():GetTalentLevel("modifier_weaver_16")]
	self:SetStackCount(self.damage_absorb)
end
function modifier_weaver_shukuchi_custom_shield:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
    }
    return funcs
end
function modifier_weaver_shukuchi_custom_shield:GetModifierTotal_ConstantBlock(kv)
    if IsServer() then
        local target = self:GetParent()
        local original_shield_amount = self.damage_absorb
        if kv.damage > 0 and bit.band(kv.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) ~= DOTA_DAMAGE_FLAG_HPLOSS then
            if kv.damage < self.damage_absorb then
                SendOverheadEventMessage(nil, OVERHEAD_ALERT_BLOCK, target, kv.damage, nil)
                self.damage_absorb = self.damage_absorb - kv.damage
                self:SetStackCount(self.damage_absorb)
                return kv.damage
            else
                SendOverheadEventMessage(nil, OVERHEAD_ALERT_BLOCK, target, original_shield_amount, nil)
                self:Destroy()
                return original_shield_amount
            end
        end
    end
end
function modifier_weaver_shukuchi_custom_shield:GetModifierIncomingDamageConstant(params)
    if (not IsServer()) then
        if params.report_max then
            return self.start_shield
        end
        return self:GetStackCount()
    end
end

modifier_weaver_shukuchi_custom_damage_debuff = class({})
function modifier_weaver_shukuchi_custom_damage_debuff:IsPurgable() return false end
function modifier_weaver_shukuchi_custom_damage_debuff:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(1)
    self.particle = ParticleManager:CreateParticle("particles/weaver_stack_count_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(self.particle, 1, Vector(0, self:GetStackCount(), 0))
    self:AddParticle(self.particle, false, false, -1, false, true)
end
function modifier_weaver_shukuchi_custom_damage_debuff:OnRefresh()
    if not IsServer() then return end
    if self:GetStackCount() < self:GetAbility().modifier_weaver_18_max[self:GetCaster():GetTalentLevel("modifier_weaver_18")] then
        self:IncrementStackCount()
    end
    if self.particle then
        ParticleManager:SetParticleControl(self.particle, 1, Vector(0, self:GetStackCount(), 0))
    end
end
function modifier_weaver_shukuchi_custom_damage_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
    }
end
function modifier_weaver_shukuchi_custom_damage_debuff:GetModifierIncomingDamage_Percentage()
    return self:GetAbility().modifier_weaver_18 * self:GetStackCount()
end