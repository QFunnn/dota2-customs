--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_night_stalker_day_walker", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_day_walker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_night_stalker_day_walker_vision", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_day_walker", LUA_MODIFIER_MOTION_NONE)

night_stalker_day_walker = class({})

night_stalker_day_walker.modifier_night_stalker_13 = {-15,-30,-45}
night_stalker_day_walker.modifier_night_stalker_13_pigfrog_vision = 15
night_stalker_day_walker.modifier_night_stalker_17_max = 600
night_stalker_day_walker.modifier_night_stalker_17_regen = 50

function night_stalker_day_walker:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_night_stalker_13") then
        bonus = self.modifier_night_stalker_13[self:GetCaster():GetTalentLevel("modifier_night_stalker_13")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function night_stalker_day_walker:OnSpellStart()
    if not IsServer() then return end

    local duration = self:GetSpecialValueFor("duration")

    self:GetCaster():RemoveModifierByName("modifier_night_stalker_day_walker")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_night_stalker_day_walker", {duration = duration})
    
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_night_stalker/nightstalker_ulti_day.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, self:GetCaster():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)

    if self:GetCaster():HasModifier("modifier_night_stalker_13") then
        local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + MODIFIER_STATE_OUT_OF_GAME, FIND_CLOSEST, false)
        for _, unit in pairs(units) do
            if unit and (unit:GetUnitName() == "npc_woda_pig" or unit:GetUnitName() == "npc_woda_frog" or unit:HasModifier("modifier_wodacreepchampion") or unit:HasModifier("modifier_wodacreepchampionred")) then
                unit:AddNewModifier(self:GetCaster(), self, "modifier_night_stalker_day_walker_vision", {duration = self.modifier_night_stalker_13_pigfrog_vision})
                break
            end
        end
    end

    for i = 0, 5 do
        local ability = self:GetCaster():GetAbilityByIndex(i)
        if ability ~= nil and ability ~= self then
            ability:EndCooldown()
        end
    end

    self:GetCaster():EmitSound("Hero_Nightstalker.Darkness")
end

modifier_night_stalker_day_walker = class({})
function modifier_night_stalker_day_walker:IsPurgable() return false end
function modifier_night_stalker_day_walker:IsPurgeException() return false end

function modifier_night_stalker_day_walker:OnCreated()
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

function modifier_night_stalker_day_walker:CheckState()
    return
    {
        [MODIFIER_STATE_FLYING] = true,
        [MODIFIER_STATE_FORCED_FLYING_VISION] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end
function modifier_night_stalker_day_walker:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
        MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
        MODIFIER_PROPERTY_BONUS_DAY_VISION
    }
end

function modifier_night_stalker_day_walker:GetBonusDayVision()
    return 1000
end

function modifier_night_stalker_day_walker:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield,
        has_shield = self.has_shield
	}
	return data
end

function modifier_night_stalker_day_walker:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
    self.has_shield = data.has_shield
end

function modifier_night_stalker_day_walker:OnIntervalThink()
    if not IsServer() then return end
    if not self.has_shield then return end
    self.current_shield = math.min(self.current_shield + (self:GetAbility().modifier_night_stalker_17_regen * 0.1), self.max_shield)
    self:SendBuffRefreshToClients()
end

function modifier_night_stalker_day_walker:GetModifierIncomingDamageConstant( params )
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

function modifier_night_stalker_day_walker:GetModifierProcAttack_BonusDamage_Physical(params)
    if params.target then
        local mana_steal = self:GetAbility():GetSpecialValueFor("mana_purge")
        if params.target:GetMana() <= 0 then return end
        if params.target:GetMaxMana() <= 0 then return end
        if self:GetParent():HasModifier("modifier_night_stalker_17") then return end
        local effect_cast = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_manaburn.vpcf", PATTACH_ABSORIGIN, params.target )
	    ParticleManager:ReleaseParticleIndex( effect_cast )
        return params.target:Script_ReduceMana(mana_steal, self:GetAbility()) 
    end
end

function modifier_night_stalker_day_walker:GetModifierPreAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_night_stalker_day_walker:OnDestroy()
	if not IsServer() then return end
    FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
    GridNav:DestroyTreesAroundPoint(self:GetParent():GetAbsOrigin(), 200, true)
end

function modifier_night_stalker_day_walker:GetActivityTranslationModifiers()
	return "hunter_night"
end

modifier_night_stalker_day_walker_vision = class({})
function modifier_night_stalker_day_walker_vision:IsHidden() return true end
function modifier_night_stalker_day_walker_vision:IsPurgable() return false end
function modifier_night_stalker_day_walker_vision:IsPurgeException() return false end
function modifier_night_stalker_day_walker_vision:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end
function modifier_night_stalker_day_walker_vision:OnIntervalThink()
    if not IsServer() then return end
    AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), 600, 0.1, true)
end