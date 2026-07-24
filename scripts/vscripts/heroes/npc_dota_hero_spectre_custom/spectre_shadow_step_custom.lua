--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_spectre_shadow_step_custom", "heroes/npc_dota_hero_spectre_custom/spectre_shadow_step_custom", LUA_MODIFIER_MOTION_NONE )

spectre_shadow_step_custom = class({})

function spectre_shadow_step_custom:CastFilterResultTarget( hTarget )
    if not IsServer() then return UF_SUCCESS end

    if string.find(GetMapName(), "rating") or GetMapName() == "overthrow" then
        local flgas = self:GetAbilityTargetType()
        if self:GetCaster():HasModifier("modifier_spectre_19") then
            flgas = flgas + DOTA_UNIT_TARGET_BASIC
        end
        local nResult = UnitFilter(
            hTarget,
            self:GetAbilityTargetTeam(),
            flgas,
            self:GetAbilityTargetFlags(),
            self:GetCaster():GetTeamNumber()
        )

        if nResult ~= UF_SUCCESS then
            return nResult
        end

        return UF_SUCCESS
    else
        local flgas = self:GetAbilityTargetType() + DOTA_UNIT_TARGET_BASIC
        local nResult = UnitFilter(
            hTarget,
            self:GetAbilityTargetTeam(),
            flgas,
            self:GetAbilityTargetFlags(),
            self:GetCaster():GetTeamNumber()
        )

        if nResult ~= UF_SUCCESS then
            return nResult
        end

        return UF_SUCCESS
    end
end

function spectre_shadow_step_custom:OnUpgrade( level )
	if not IsServer() then return end
	local sub = self:GetCaster():FindAbilityByName( "spectre_reality_custom" )
	if sub then
		sub:SetLevel( 1 )
	end
end

function spectre_shadow_step_custom:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local origin = self:GetCaster():GetAbsOrigin()
    local incoming_damage = self:GetSpecialValueFor("illusion_damage_incoming") - 100
    local outgoing_damage = self:GetSpecialValueFor("illusion_outgoing_damage") - 100
    local duration = self:GetSpecialValueFor("duration")
    local target = self:GetCursorTarget()
    self:GetCaster():EmitSound("Hero_Spectre.ShadowStep.Cast")
    local illusions = CreateIllusions( caster, caster, { outgoing_damage = outgoing_damage, incoming_damage = incoming_damage, duration = -1}, 1, 150, false, false )
    for _, illusion in pairs(illusions) do
        FindClearSpaceForUnit(illusion, illusion:GetAbsOrigin() + illusion:GetForwardVector() * 75, true)
        illusion:SetControllableByPlayer( -1, false )
        illusion:AddNewModifier( caster, self, "modifier_spectre_shadow_step_custom", { duration = -1, target = target:entindex() })
    end
end

modifier_spectre_shadow_step_custom = class({})
function modifier_spectre_shadow_step_custom:IsHidden() return true end
function modifier_spectre_shadow_step_custom:IsPurgable() return false end

function modifier_spectre_shadow_step_custom:OnCreated( kv )
	if not IsServer() then return end
	self.target = EntIndexToHScript( kv.target )
	self.distance = 70
    self.duration_buff = self:GetAbility():GetSpecialValueFor("duration")
    self.buff_applied = false
    self:GetParent():EmitSound("Hero_Spectre.ShadowStep")
	self:StartIntervalThink( FrameTime() )
end

function modifier_spectre_shadow_step_custom:CheckState()
	local state = 
	{
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
	}
	return state
end

function modifier_spectre_shadow_step_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
    }
end

function modifier_spectre_shadow_step_custom:GetActivityTranslationModifiers()
    return "shadow_step"
end

function modifier_spectre_shadow_step_custom:GetModifierMoveSpeed_Absolute()
    if self.buff_applied then return end
    return self:GetAbility():GetSpecialValueFor("move_speed")
end

function modifier_spectre_shadow_step_custom:OnIntervalThink()
	self:FollowThink()
end

function modifier_spectre_shadow_step_custom:FollowThink()
	if not self.target:IsAlive() then
		self:GetParent():ForceKill( false )
		self:Destroy()
		return
	end
	local parent = self:GetParent()
	local origin = self.target:GetOrigin()
	local seen = self:GetCaster():CanEntityBeSeenByMyTeam( self.target )
    if not self.buff_applied and (parent:GetOrigin()-origin):Length2D()<=250 then
        self.buff_applied = true
        local modifier_illusion = parent:FindModifierByName("modifier_illusion")
        if modifier_illusion then
            modifier_illusion:SetDuration(self.duration_buff, true)
        end
    end
	if not seen then
		if (parent:GetOrigin()-origin):Length2D()>self.distance/2 then
			parent:MoveToPosition( origin )
		end
	else
		if parent:GetAggroTarget()~=self.target then
			local order = {
				UnitIndex = parent:entindex(),
				OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
				TargetIndex = self.target:entindex(),
			}
			ExecuteOrderFromTable( order )
		end
	end
end