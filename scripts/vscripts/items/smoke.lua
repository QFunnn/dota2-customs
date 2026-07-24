--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_smoke_of_deceit_cha_custom", "items/smoke", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_smoke_of_deceit_hookah_master_immunity", "items/smoke", LUA_MODIFIER_MOTION_NONE)

item_smoke_of_deceit_custom = class({})
function item_smoke_of_deceit_custom:OnChargeCountChanged(iCharges) end

function item_smoke_of_deceit_custom:OnSpellStart()
    if not IsServer() then return end
    
    -- Флаг для предотвращения триггера криптонита при неудачной активации
    self.bSmokeActivated = false
    
    self:GetCaster():EmitSound("DOTA_Item.SmokeOfDeceit.Activate")
    local particle = ParticleManager:CreateParticle("particles/items2_fx/smoke_of_deceit.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, Vector(800, 1, 800))
    ParticleManager:ReleaseParticleIndex(particle)

    -- На персональных аренах игроков (team_X_arena) смок не должен прерываться из-за других игроков,
    -- кроме случая дуэли — там работает стандартная логика
    local CasterArena = Players:GetUnitArena(self:GetCaster())
    local bIsPlayerArena = CasterArena ~= nil and string.match(CasterArena, "^team_%d+_arena") ~= nil
    local CasterPID = self:GetCaster():GetPlayerOwnerID()
    local bInDuel = CasterPID ~= nil and CasterPID ~= -1 and Rounds:IsPlayerInPVPDuel(CasterPID)

    if not bIsPlayerArena or bInDuel then
        local area = FindUnitsInRadius( self:GetCaster():GetTeam(), self:GetCaster():GetAbsOrigin(), nil, 1200, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false )
        if area[1] and Players:IsUnitCanAttackOrCastOnThis(area[1], self:GetCaster()) then
            self.bSmokeActivated = false
            return
        end
    end
    
    -- Смок успешно активирован
    self.bSmokeActivated = true

    local targets = FindUnitsInRadius( self:GetCaster():GetTeam(), self:GetCaster():GetAbsOrigin(), nil, self:GetSpecialValueFor("application_radius"), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false )

    local duration = self:GetSpecialValueFor("duration")

    if self:GetCaster():HasModifier("modifier_skill_smoker") then
        duration = duration + duration
    end

    for k, v in pairs(targets) do
        print(v:IsHero(), v:IsTempestDouble(), v:HasModifier("modifier_arc_warden_tempest_double_lua"))
       -- if v:IsHero() or (v:IsTempestDouble() and v:HasModifier("modifier_arc_warden_tempest_double_lua")) or (v:GetUnitName() == "npc_dota_lone_druid_bear1" or v:GetUnitName() == "npc_dota_lone_druid_bear2" or v:GetUnitName() == "npc_dota_lone_druid_bear3" or v:GetUnitName() == "npc_dota_lone_druid_bear4") then
            ProjectileManager:ProjectileDodge(v)
            v:AddNewModifier(self:GetCaster(), nil, "modifier_smoke_of_deceit_cha_custom", {duration = duration})
       --- end
    end

    --if self:GetCaster().tempest_double_hClone and self:GetCaster().tempest_double_hClone:IsAlive() then
    --    ProjectileManager:ProjectileDodge(self:GetCaster().tempest_double_hClone)
    --    self:GetCaster().tempest_double_hClone:AddNewModifier(self:GetCaster(), nil, "modifier_smoke_of_deceit_cha_custom", {duration = self:GetSpecialValueFor("duration")})
    --end
    
    self:SpendCharge(0)
    
    -- Сбрасываем флаг после использования
    Timers:CreateTimer(FrameTime(), function()
        self.bSmokeActivated = false
    end)
end

modifier_smoke_of_deceit_cha_custom = class({})
function modifier_smoke_of_deceit_cha_custom:IsPurgable() return false end
function modifier_smoke_of_deceit_cha_custom:GetPriority() return MODIFIER_PRIORITY_SUPER_ULTRA end
function modifier_smoke_of_deceit_cha_custom:HeroEffectPriority() return MODIFIER_PRIORITY_SUPER_ULTRA end
function modifier_smoke_of_deceit_cha_custom:GetTexture() return "item_smoke_of_deceit" end

function modifier_smoke_of_deceit_cha_custom:OnCreated(args)
    if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_skill_hookah_master") then
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_smoke_of_deceit_hookah_master_immunity", {})
    end
    self.radius = 1200
    self:StartIntervalThink(FrameTime())
end

function modifier_smoke_of_deceit_cha_custom:OnDestroy()
    if not IsServer() then return end
    self:GetParent():RemoveModifierByName("modifier_smoke_of_deceit_hookah_master_immunity")
end

function modifier_smoke_of_deceit_cha_custom:OnIntervalThink()
    local parent = self:GetParent()
    self:GetParent():RemoveModifierByName("modifier_gem_active_truesight")
    self:GetParent():RemoveModifierByName("modifier_truesight")

    -- На персональных аренах игроков смок не прерывается из-за других игроков,
    -- кроме случая дуэли — там работает стандартная логика
    local ParentArena = Players:GetUnitArena(parent)
    local bIsPlayerArena = ParentArena ~= nil and string.match(ParentArena, "^team_%d+_arena") ~= nil
    local RealParent = GetRealUnit(parent)
    local ParentPID = RealParent and RealParent.GetPlayerOwnerID and RealParent:GetPlayerOwnerID() or parent:GetPlayerOwnerID()
    local bInDuel = ParentPID ~= nil and ParentPID ~= -1 and Rounds:IsPlayerInPVPDuel(ParentPID)

    if bIsPlayerArena and not bInDuel then
        return
    end

    local area = FindUnitsInRadius( self:GetParent():GetTeam(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS, FIND_ANY_ORDER, false )

    for _, unit in ipairs(area) do
        if Players:IsUnitCanAttackOrCastOnThis(unit, parent) then
            self:Destroy()
            return
        end
    end
end

function modifier_smoke_of_deceit_cha_custom:CheckState()
    return {
        [MODIFIER_STATE_INVISIBLE] = true,
        [MODIFIER_STATE_TRUESIGHT_IMMUNE] = true
    }
end

function modifier_smoke_of_deceit_cha_custom:GetEffectName()
    return "particles/items2_fx/smoke_of_deceit_buff.vpcf"
end

function modifier_smoke_of_deceit_cha_custom:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_smoke_of_deceit_cha_custom:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ALWAYS_AUTOATTACK_WHILE_HOLD_POSITION,
        MODIFIER_PROPERTY_INVISIBILITY_ATTACK_BEHAVIOR_EXCEPTION,
        MODIFIER_PROPERTY_PERSISTENT_INVISIBILITY,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
    }
end

function modifier_smoke_of_deceit_cha_custom:GetModifierInvisibilityLevel()
    return 1
end

function modifier_smoke_of_deceit_cha_custom:GetModifierInvisibilityAttackBehaviorException()
    return 1
end

function modifier_smoke_of_deceit_cha_custom:GetModifierPersistentInvisibility()
    return 1
end

function modifier_smoke_of_deceit_cha_custom:GetAlwaysAutoAttackWhileHoldPosition()
    return 1
end

function modifier_smoke_of_deceit_cha_custom:GetModifierMoveSpeedBonus_Percentage()
    return 15
end

function modifier_smoke_of_deceit_cha_custom:GetModifierTotalDamageOutgoing_Percentage()
    if not self:GetParent():HasModifier("modifier_skill_hookah_master") then return end
    return 20
end

modifier_smoke_of_deceit_hookah_master_immunity = class({})
function modifier_smoke_of_deceit_hookah_master_immunity:IsHidden() return true end
function modifier_smoke_of_deceit_hookah_master_immunity:IsPurgable() return false end
function modifier_smoke_of_deceit_hookah_master_immunity:IsPurgeException() return false end
function modifier_smoke_of_deceit_hookah_master_immunity:DeclareFunctions()
	return
	{
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
end
function modifier_smoke_of_deceit_hookah_master_immunity:GetModifierIncomingDamage_Percentage(params)
	if not IsServer() then return end
	if not params.attacker then return end
	if not params.inflictor then return end
	if self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION ) then
		return -100 
	end
	local behavior = params.inflictor:GetAbilityTargetFlags()
	if not self:FlagExist( behavior, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES ) then
    	if params.damage_type == DAMAGE_TYPE_MAGICAL then 
        	return -80
    	end
	end
end

function modifier_smoke_of_deceit_hookah_master_immunity:FlagExist(a,b)
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

function modifier_smoke_of_deceit_hookah_master_immunity:GetModifierMagicalResistanceBonus()
	if not IsClient() then return end
	return 80
end
function modifier_smoke_of_deceit_hookah_master_immunity:CheckState()
 	return 
 	{
 		[MODIFIER_STATE_DEBUFF_IMMUNE] = true
	}
end

function modifier_smoke_of_deceit_hookah_master_immunity:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end