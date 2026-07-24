--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_spirit_breaker_nether_strike_custom", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_nether_strike", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spirit_breaker_nether_strike_custom_magic_debuff", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_nether_strike", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spirit_breaker_greater_bash_custom_break", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_nether_strike", LUA_MODIFIER_MOTION_NONE )

spirit_breaker_nether_strike_custom = class({})

spirit_breaker_nether_strike_custom.modifier_spirit_breaker_17_radius = 400
spirit_breaker_nether_strike_custom.modifier_spirit_breaker_17 = {-15,-30}
spirit_breaker_nether_strike_custom.modifier_spirit_breaker_17_duration = 8
spirit_breaker_nether_strike_custom.modifier_spirit_breaker_19 = {-4,-6,-8}
spirit_breaker_nether_strike_custom.modifier_spirit_breaker_6 = 4

function spirit_breaker_nether_strike_custom:GetCooldown( level )
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_spirit_breaker_19") then
		bonus = self.modifier_spirit_breaker_19[self:GetCaster():GetTalentLevel("modifier_spirit_breaker_19")]
	end
	return self.BaseClass.GetCooldown( self, level ) + bonus
end

function spirit_breaker_nether_strike_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_spirit_breaker.vsndevts", context )
end

function spirit_breaker_nether_strike_custom:OnAbilityPhaseStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local duration = self:GetCastPoint()
	target:AddNewModifier( caster, self, "modifier_spirit_breaker_nether_strike_custom", { duration = duration } )
	self:GetCaster():EmitSound("Hero_Spirit_Breaker.NetherStrike.Begin")
	return true
end

function spirit_breaker_nether_strike_custom:OnAbilityPhaseInterrupted()
    if not IsServer() then return end
	local target = self:GetCursorTarget()
	local mod = target:FindModifierByName( "modifier_spirit_breaker_nether_strike_custom" )
	if mod then mod:Destroy() end
	self:GetCaster():StopSound("Hero_Spirit_Breaker.NetherStrike.Begin")
end

function spirit_breaker_nether_strike_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local damage = self:GetSpecialValueFor( "damage" )
	local offset = 54
    if target:TriggerSpellAbsorb(self) then return end

	local direction = target:GetOrigin()-caster:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

	local pos = target:GetOrigin() + direction*offset
	caster:SetOrigin( pos )

    if self:GetCaster():HasModifier("modifier_spirit_breaker_17") then
        local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetOrigin(), nil, self.modifier_spirit_breaker_17_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
        for _, enemy in pairs(units) do
            enemy:AddNewModifier(self:GetCaster(), self, "modifier_spirit_breaker_nether_strike_custom_magic_debuff", {duration = self.modifier_spirit_breaker_17_duration * (1 - enemy:GetStatusResistance())})
        end
    end

	local mod = caster:FindModifierByName( "modifier_spirit_breaker_greater_bash_custom" )
    if self.original_owner then
        mod = self.original_owner:FindModifierByName( "modifier_spirit_breaker_greater_bash_custom" )
    end
	if mod and mod:GetAbility():GetLevel()>0 then
		mod:Bash( target, true, self:GetCaster() )
        if self:GetCaster():HasModifier("modifier_spirit_breaker_17") then
            local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetOrigin(), nil, self.modifier_spirit_breaker_17_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
            for _, enemy in pairs(units) do
                if enemy ~= target then
                    mod:Bash( enemy, true, self:GetCaster() )
                end
            end
        end
	end

    if self:GetCaster():HasModifier("modifier_spirit_breaker_6") then
        target:Purge(true, false, false, false, true)
        target:AddNewModifier(self:GetCaster(), self, "modifier_spirit_breaker_greater_bash_custom_break", {duration = self.modifier_spirit_breaker_6})
        if self:GetCaster():HasModifier("modifier_spirit_breaker_17") then
            local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetOrigin(), nil, self.modifier_spirit_breaker_17_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
            for _, enemy in pairs(units) do
                enemy:Purge(true, false, false, false, true)
                enemy:AddNewModifier(self:GetCaster(), self, "modifier_spirit_breaker_greater_bash_custom_break", {duration = self.modifier_spirit_breaker_6})
            end
        end
    end

	local damageTable = 
    {
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}

	ApplyDamage(damageTable)

    if self:GetCaster():HasModifier("modifier_spirit_breaker_17") then
        local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetOrigin(), nil, self.modifier_spirit_breaker_17_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
        for _, enemy in pairs(units) do
            if enemy ~= target then
                damageTable.victim = enemy
                ApplyDamage(damageTable)
            end
        end
    end

	FindClearSpaceForUnit( caster, pos, true )

    local new_origin = target:GetAbsOrigin() - caster:GetAbsOrigin()
    new_origin.z = 0
    new_origin = new_origin:Normalized()
    caster:SetForwardVector(new_origin)
    caster:FaceTowards(target:GetAbsOrigin())
    caster:MoveToPositionAggressive(target:GetAbsOrigin())
	caster:EmitSound("Hero_Spirit_Breaker.NetherStrike.End")
end

modifier_spirit_breaker_nether_strike_custom = class({})

function modifier_spirit_breaker_nether_strike_custom:IsHidden()
	return true
end

function modifier_spirit_breaker_nether_strike_custom:IsDebuff()
	return true
end

function modifier_spirit_breaker_nether_strike_custom:IsPurgable()
	return false
end

function modifier_spirit_breaker_nether_strike_custom:OnCreated( kv )
	if not IsServer() then return end
    self:StartIntervalThink(0.1)
end

function modifier_spirit_breaker_nether_strike_custom:OnIntervalThink()
    if not IsServer() then return end
    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_truesight", {duration = 0.2})
    AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), 100, 0.1, true)
end

modifier_spirit_breaker_nether_strike_custom_magic_debuff = class({})

function modifier_spirit_breaker_nether_strike_custom_magic_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
    }
end

function modifier_spirit_breaker_nether_strike_custom_magic_debuff:GetModifierMagicalResistanceBonus()
    return self:GetAbility().modifier_spirit_breaker_17[self:GetCaster():GetTalentLevel("modifier_spirit_breaker_17")]
end

function modifier_spirit_breaker_nether_strike_custom_magic_debuff:GetTexture() return "spirit_breaker_17" end
function modifier_spirit_breaker_nether_strike_custom_magic_debuff:GetEffectName() return "particles/neutral_fx/icefire_bomb_debuff.vpcf" end

modifier_spirit_breaker_greater_bash_custom_break = class({})
function modifier_spirit_breaker_greater_bash_custom_break:IsHidden() return false end
function modifier_spirit_breaker_greater_bash_custom_break:IsPurgable() return false end
function modifier_spirit_breaker_greater_bash_custom_break:CheckState() return {[MODIFIER_STATE_PASSIVES_DISABLED] = true} end
function modifier_spirit_breaker_greater_bash_custom_break:GetEffectName() return "particles/items3_fx/silver_edge.vpcf" end
function modifier_spirit_breaker_greater_bash_custom_break:OnCreated(table)
    if not IsServer() then return end
    self.particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_break.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(self.particle, 1, self:GetParent():GetAbsOrigin())
    self:AddParticle(self.particle, false, false, -1, false, false)
end