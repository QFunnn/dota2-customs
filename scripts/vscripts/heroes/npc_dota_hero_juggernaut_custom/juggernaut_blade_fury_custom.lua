--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_juggernaut_blade_fury_custom", "heroes/npc_dota_hero_juggernaut_custom/juggernaut_blade_fury_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_blade_fury_custom_attack_damage", "heroes/npc_dota_hero_juggernaut_custom/juggernaut_blade_fury_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_blade_fury_custom_slow", "heroes/npc_dota_hero_juggernaut_custom/juggernaut_blade_fury_custom", LUA_MODIFIER_MOTION_NONE)

juggernaut_blade_fury_custom = class({})

function juggernaut_blade_fury_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_juggernaut/juggernaut_blade_fury_tgt.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_juggernaut/juggernaut_blade_fury.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_juggernaut.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_juggernaut.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_juggernaut.vpcf", context)
end

juggernaut_blade_fury_custom.modifier_juggernaut_15 = {-2,-4,-6}
juggernaut_blade_fury_custom.modifier_juggernaut_16 = {25,50,75}
juggernaut_blade_fury_custom.modifier_juggernaut_16_slow = {-5,-10,-15}
juggernaut_blade_fury_custom.modifier_juggernaut_18 = {10,20,30}
juggernaut_blade_fury_custom.modifier_juggernaut_19 = {50,100}
juggernaut_blade_fury_custom.modifier_juggernaut_21 = 8

function juggernaut_blade_fury_custom:GetCooldown(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_juggernaut_15") then
        bonus = self.modifier_juggernaut_15[self:GetCaster():GetTalentLevel("modifier_juggernaut_15")]
    end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function juggernaut_blade_fury_custom:GetInterval()
    -- local speed = (1/self:GetCaster():GetAttacksPerSecond(true))
    -- local k = self:GetSpecialValueFor("blade_fury_aspd_multiplier")
    -- return speed / k 
    return self:GetSpecialValueFor("blade_fury_damage_tick")
end

function juggernaut_blade_fury_custom:BladeFury_DealDamage(point, radius)
	if not IsServer() then return end
	local damage = self:GetSpecialValueFor("blade_fury_damage")
    local blade_fury_damage_tick = self:GetSpecialValueFor("blade_fury_damage_tick")
	if self:GetCaster():HasModifier("modifier_juggernaut_18") then
		damage = damage + (self:GetCaster():GetIntellect(false) / 100 * self.modifier_juggernaut_18[self:GetCaster():GetTalentLevel("modifier_juggernaut_18")])
	end
    damage = damage * self:GetInterval()
	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
	for _, enemy in ipairs(enemies) do
		if self:GetCaster():HasModifier("modifier_juggernaut_16") then
			enemy:AddNewModifier(self:GetCaster(), self, "modifier_juggernaut_blade_fury_custom_slow", {duration = self:GetInterval()+FrameTime()})
		end
  		ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
  		local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_juggernaut/juggernaut_blade_fury_tgt.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy )
  		ParticleManager:ReleaseParticleIndex( effect_cast )
	end
end

function juggernaut_blade_fury_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    if self:GetCaster():HasModifier("modifier_juggernaut_blade_fury_custom") then 
        self:GetCaster():RemoveModifierByName("modifier_juggernaut_blade_fury_custom")
    end
    self:GetCaster():StartGesture(ACT_DOTA_OVERRIDE_ABILITY_1)
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_juggernaut_blade_fury_custom", {duration = duration })
    self:GetCaster():Purge(false, true, false, false, false)
end

modifier_juggernaut_blade_fury_custom = class({})

function modifier_juggernaut_blade_fury_custom:IsPurgable() return false end

function modifier_juggernaut_blade_fury_custom:OnCreated(table)
	if not IsServer() then return end
	self.tick = self:GetAbility():GetInterval()
	self:PlayEffects()
	self.count = 5
	self.has_damage = false
	if self:GetParent():IsHero() then 
		local juggernaut_blade_fury_custom = self:GetCaster():FindAbilityByName("juggernaut_blade_fury_custom")
		local juggernaut_omni_slash_custom = self:GetCaster():FindAbilityByName("juggernaut_omni_slash_custom")
		local juggernaut_swift_slash_custom = self:GetCaster():FindAbilityByName("juggernaut_swift_slash_custom")
		if juggernaut_blade_fury_custom then 
			juggernaut_blade_fury_custom:SetActivated(false)
		end
		if not self:GetCaster():HasModifier("modifier_juggernaut_20") then
			if juggernaut_omni_slash_custom then 
				juggernaut_omni_slash_custom:SetActivated(false)
			end
		end
		if not self:GetCaster():HasModifier("modifier_juggernaut_20") then
			if juggernaut_swift_slash_custom then 
				juggernaut_swift_slash_custom:SetActivated(false)
			end
		end
	end
    self.has_shield = false
	if self:GetCaster():HasModifier("modifier_juggernaut_21") then
        self.has_shield = true
        self.barrier = self:GetCaster():GetMaxMana() / 100 * self:GetAbility().modifier_juggernaut_21
        self.max_shield = self.barrier
	    self.current_shield = self.barrier
	end
	self.magic_damage = -80
	self:SetHasCustomTransmitterData(true)
    self:OnIntervalThink()
    self:StartIntervalThink(self.tick)
end

function modifier_juggernaut_blade_fury_custom:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE
	}
end

function modifier_juggernaut_blade_fury_custom:GetAbsoluteNoDamagePure(params)
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 1
    end
end

function modifier_juggernaut_blade_fury_custom:GetModifierMagicalResistanceBonus(params)
    if IsClient() then 
        return 80
    end
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 80
    end
end

function modifier_juggernaut_blade_fury_custom:AddCustomTransmitterData() 
	return 
	{
		magic_damage = self.magic_damage,
        max_shield = self.max_shield,
        current_shield = self.current_shield,
        has_shield = self.has_shield
	} 
end

function modifier_juggernaut_blade_fury_custom:HandleCustomTransmitterData(data)
	self.magic_damage  = data.magic_damage
    self.max_shield = data.max_shield
    self.current_shield = data.current_shield
    self.has_shield = data.has_shield
end

function modifier_juggernaut_blade_fury_custom:GetModifierIncomingDamageConstant( params )
    if not self.has_shield then return end
    if not IsServer() then
        if params.report_max then
            return self.max_shield
        else
            return self.current_shield
        end
    end
    if params.damage >= self.current_shield then
        local dodge = self.current_shield
        self.current_shield = 0
        self:SendBuffRefreshToClients()
        return -dodge
    else
        self.current_shield = self.current_shield-params.damage
        self:SendBuffRefreshToClients()
        return -params.damage
    end
end

function modifier_juggernaut_blade_fury_custom:OnTakeDamage(params)
	if not IsServer() then return end
	if params.unit ~= self:GetParent() then return end
	if params.attacker == self:GetParent() then return end
	if params.damage <= 0 then return end
	self.has_damage = true
end

function modifier_juggernaut_blade_fury_custom:CheckState()
 	return 
 	{
 		[MODIFIER_STATE_DEBUFF_IMMUNE] = true
	}
end

function modifier_juggernaut_blade_fury_custom:GetModifierMoveSpeedBonus_Constant()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_juggernaut_16") then
    	bonus = self:GetAbility().modifier_juggernaut_16[self:GetCaster():GetTalentLevel("modifier_juggernaut_16")]
    end
	return bonus
end

function modifier_juggernaut_blade_fury_custom:GetModifierProcAttack_BonusDamage_Physical( params ) 
	if params.target:IsBuilding() then return end
	if self:GetParent():HasModifier("modifier_juggernaut_20") and self:GetParent():HasModifier("modifier_juggernaut_omni_slash_custom") then return end
	if self:GetParent():HasModifier("modifier_juggernaut_blade_fury_custom_attack_damage") then return end
	return -params.damage
end

function modifier_juggernaut_blade_fury_custom:OnIntervalThink()
	if not IsServer() then return end
	local radius = self:GetAbility():GetSpecialValueFor("blade_fury_radius")
	if self:GetCaster():HasModifier("modifier_juggernaut_19") then
		radius = radius + self:GetAbility().modifier_juggernaut_19[self:GetCaster():GetTalentLevel("modifier_juggernaut_19")]
	end
	if self:GetCaster():HasModifier("modifier_juggernaut_21") and self:GetParent():IsHero() then 
		self.count = self.count + self:GetAbility():GetInterval()
		if self.count >= 1 then 
			local shard_targets = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
			if #shard_targets > 0 then 
			    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_juggernaut_blade_fury_custom_attack_damage", {})
			    local random = RandomInt(1, #shard_targets)
			    self:GetParent():PerformAttack(shard_targets[random],true,true,true,false,false,false, false)
			    self:GetParent():RemoveModifierByName("modifier_juggernaut_blade_fury_custom_attack_damage")
			    self.count = 0
			end
		end
	end
	self:GetAbility():BladeFury_DealDamage(self:GetParent():GetAbsOrigin(), radius)
end

function modifier_juggernaut_blade_fury_custom:OnDestroy( kv )
	if not IsServer() then return end
	self:GetParent():EmitSound("Hero_Juggernaut.BladeFuryStop")
	self:GetParent():StopSound("Hero_Juggernaut.BladeFuryStart")
	self:GetParent():RemoveGesture(ACT_DOTA_OVERRIDE_ABILITY_1)
	if self:GetParent():IsHero() then 
		local juggernaut_blade_fury_custom = self:GetCaster():FindAbilityByName("juggernaut_blade_fury_custom")
		local juggernaut_omni_slash_custom = self:GetCaster():FindAbilityByName("juggernaut_omni_slash_custom")
		local juggernaut_swift_slash_custom = self:GetCaster():FindAbilityByName("juggernaut_swift_slash_custom")
		if juggernaut_swift_slash_custom then 
			juggernaut_swift_slash_custom:SetActivated(true)
		end
		if juggernaut_blade_fury_custom then 
			juggernaut_blade_fury_custom:SetActivated(true)
		end
		if juggernaut_omni_slash_custom then 
			juggernaut_omni_slash_custom:SetActivated(true)
		end
	end
	if not self.has_damage and self:GetParent():HasModifier("modifier_juggernaut_17") then
		self:GetAbility():EndCooldown()
	end
	if not self:GetCaster():HasModifier("modifier_juggernaut_17") then
    	self:GetParent():Purge(false, true, false, true, true)
    end
end

function modifier_juggernaut_blade_fury_custom:PlayEffects()
	if not IsServer() then return end
	local radius = self:GetAbility():GetSpecialValueFor("blade_fury_radius")
	if self:GetCaster():HasModifier("modifier_juggernaut_19") then
		radius = radius + self:GetAbility().modifier_juggernaut_19[self:GetCaster():GetTalentLevel("modifier_juggernaut_19")]
	end
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_juggernaut/juggernaut_blade_fury.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 5, Vector( radius, 0, 0 ) )
	if self:GetParent():IsHero() then 
		self:AddParticle(effect_cast,false,false,-1,false,false)
		self:GetParent():EmitSound("Hero_Juggernaut.BladeFuryStart")
	end
end

modifier_juggernaut_blade_fury_custom_attack_damage = class({})
function modifier_juggernaut_blade_fury_custom_attack_damage:IsHidden() return true end
function modifier_juggernaut_blade_fury_custom_attack_damage:IsPurgable() return false end


modifier_juggernaut_blade_fury_custom_slow = class({})
function modifier_juggernaut_blade_fury_custom_slow:IsPurgable() return false end
function modifier_juggernaut_blade_fury_custom_slow:IsHidden() return true end
function modifier_juggernaut_blade_fury_custom_slow:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end
function modifier_juggernaut_blade_fury_custom_slow:GetModifierMoveSpeedBonus_Percentage()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_juggernaut_16") then
    	bonus = self:GetAbility().modifier_juggernaut_16_slow[self:GetCaster():GetTalentLevel("modifier_juggernaut_16")]
    end
	return bonus
end