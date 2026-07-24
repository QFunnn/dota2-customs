--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_axe_battle_hunger_custom_debuff", "heroes/npc_dota_hero_axe_custom/axe_battle_hunger_custom", LUA_MODIFIER_MOTION_NONE )

axe_battle_hunger_custom = class({})

axe_battle_hunger_custom.modifier_axe_19 = {0.5,1,1.5}
axe_battle_hunger_custom.modifier_axe_20 = {-10,-20}

function axe_battle_hunger_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_axe/axe_battle_hunger.vpcf", context)
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_axe.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_axe.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_axe.vpcf", context)
end

function axe_battle_hunger_custom:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    if target:TriggerSpellAbsorb( self ) then return end
    self:AddTarget(target)
end

function axe_battle_hunger_custom:AddTarget(target)
    local duration = self:GetSpecialValueFor("duration")
    target:AddNewModifier( self:GetCaster(), self, "modifier_axe_battle_hunger_custom_debuff", { duration = duration * (1-target:GetStatusResistance()) })
    target:EmitSound("Hero_Axe.Battle_Hunger")
end

modifier_axe_battle_hunger_custom_debuff = class({})

function modifier_axe_battle_hunger_custom_debuff:OnCreated( kv )
    self.slow = self:GetAbility():GetSpecialValueFor("slow")
    self.damage_per_second = self:GetAbility():GetSpecialValueFor("damage_per_second")
    self.armor_multiplier = self:GetAbility():GetSpecialValueFor("armor_multiplier")
    if self:GetCaster():HasModifier("modifier_axe_19") then
        self.armor_multiplier = self.armor_multiplier + self:GetAbility().modifier_axe_19[self:GetCaster():GetTalentLevel("modifier_axe_19")]
    end
    if not IsServer() then return end
    self.current_slow = self.slow
    self.damage_delay = 0.5
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_axe/axe_battle_hunger.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
    self:AddParticle(particle, false, false, -1, false, true)
    self:SetHasCustomTransmitterData( true )
    self:StartIntervalThink( 0.1 )
    self:OnIntervalThink()
end

function modifier_axe_battle_hunger_custom_debuff:OnDestroy()
    if not IsServer() then return end 

end

function modifier_axe_battle_hunger_custom_debuff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
        MODIFIER_EVENT_ON_DEATH,
    }
end

function modifier_axe_battle_hunger_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self.current_slow
end

function modifier_axe_battle_hunger_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    self.damage_delay = self.damage_delay + 0.1
    if self.damage_delay >= 0.5 then
        self.damage_delay = 0
        local damage = (self.damage_per_second + (self.armor_multiplier * self:GetCaster():GetPhysicalArmorValue(false))) * 0.5
	    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility(), damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK})
    end
    local caster_pos = self:GetCaster():GetAbsOrigin()
    local parent_pos = self:GetParent():GetAbsOrigin()
    local direction = (caster_pos - parent_pos):Normalized()
    local parent_angle = self:GetParent():GetAngles().y
    local center_angle = VectorToAngles(direction).y
    if math.abs(AngleDiff(center_angle, parent_angle)) > 85 or self:GetCaster():HasModifier("modifier_axe_20") then
        self.current_slow = self.slow
    else
        self.current_slow = 0
    end
    self:SendBuffRefreshToClients()
end

function modifier_axe_battle_hunger_custom_debuff:OnDeath(params)
    if not IsServer() then return end

    -- Если тот, на ком висит дебафф, совершил убийство
    if params.attacker == self:GetParent() and params.unit ~= self:GetParent() then
        if not self:GetCaster():HasModifier("modifier_axe_16") then
            self:Destroy()
        end
    end
end


function modifier_axe_battle_hunger_custom_debuff:AddCustomTransmitterData()
	local data = 
    {
		current_slow = self.current_slow,
	}
	return data
end

function modifier_axe_battle_hunger_custom_debuff:HandleCustomTransmitterData( data )
	self.current_slow = data.current_slow
end

function modifier_axe_battle_hunger_custom_debuff:GetModifierPropertyRestorationAmplification()
    if self:GetCaster():HasModifier("modifier_axe_20") then
        return self:GetAbility().modifier_axe_20[self:GetCaster():GetTalentLevel("modifier_axe_20")]
    end
    return 0
end