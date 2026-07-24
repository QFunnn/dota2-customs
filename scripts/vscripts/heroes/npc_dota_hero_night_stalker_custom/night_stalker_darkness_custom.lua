--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_night_stalker_darkness_custom", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_darkness_custom", LUA_MODIFIER_MOTION_NONE)

night_stalker_darkness_custom = class({})

night_stalker_darkness_custom.modifier_night_stalker_6 = {-25,-50,-75}
night_stalker_darkness_custom.modifier_night_stalker_17_max = 600
night_stalker_darkness_custom.modifier_night_stalker_17_regen = 50

function night_stalker_darkness_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_night_stalker_6") then
        bonus = self.modifier_night_stalker_6[self:GetCaster():GetTalentLevel("modifier_night_stalker_6")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function night_stalker_darkness_custom:OnSpellStart()
    if not IsServer() then return end

    local duration = self:GetSpecialValueFor("duration")

    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_night_stalker_darkness_custom", {duration = duration})
    
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_night_stalker/nightstalker_ulti.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, self:GetCaster():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)

    self:GetCaster():EmitSound("Hero_Nightstalker.Darkness")
end

modifier_night_stalker_darkness_custom = class({})
function modifier_night_stalker_darkness_custom:IsPurgable() return false end
function modifier_night_stalker_darkness_custom:IsPurgeException() return false end

function modifier_night_stalker_darkness_custom:OnCreated()
    if not IsServer() then return end
    self.has_shield = false
    if self:GetCaster():HasModifier("modifier_night_stalker_17") then
        self.has_shield = true
        self.barrier = self:GetAbility().modifier_night_stalker_17_max
        self.max_shield = self.barrier
	    self.current_shield = self.barrier
        self:SetHasCustomTransmitterData( true )
        self:StartIntervalThink(0.1)
    end
end

function modifier_night_stalker_darkness_custom:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield,
        has_shield = self.has_shield
	}
	return data
end

function modifier_night_stalker_darkness_custom:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
    self.has_shield = data.has_shield
end

function modifier_night_stalker_darkness_custom:OnIntervalThink()
    if not IsServer() then return end
    if not self.has_shield then return end
    self.current_shield = math.min(self.current_shield + (self:GetAbility().modifier_night_stalker_17_regen * 0.1), self.max_shield)
    self:SendBuffRefreshToClients()
end

function modifier_night_stalker_darkness_custom:GetModifierIncomingDamageConstant( params )
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

function modifier_night_stalker_darkness_custom:CheckState()
    return
    {
        [MODIFIER_STATE_FLYING] = true,
        [MODIFIER_STATE_FORCED_FLYING_VISION] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_night_stalker_darkness_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
        MODIFIER_PROPERTY_BONUS_DAY_VISION,
    }
end

function modifier_night_stalker_darkness_custom:GetBonusDayVision()
    return 1000
end

function modifier_night_stalker_darkness_custom:GetModifierPreAttack_BonusDamage()
    if self:GetParent():HasModifier("modifier_night_stalker_17") then return end
    return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_night_stalker_darkness_custom:OnDestroy()
	if not IsServer() then return end
    FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
    GridNav:DestroyTreesAroundPoint(self:GetParent():GetAbsOrigin(), 200, true)
end

function modifier_night_stalker_darkness_custom:GetActivityTranslationModifiers()
	return "hunter_night"
end