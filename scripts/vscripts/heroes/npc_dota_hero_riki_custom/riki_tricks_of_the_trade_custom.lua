--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_riki_tricks_of_the_trade_custom", "heroes/npc_dota_hero_riki_custom/riki_tricks_of_the_trade_custom", LUA_MODIFIER_MOTION_NONE )

riki_tricks_of_the_trade_custom = class({})
riki_tricks_of_the_trade_custom.modifier_riki_8 = {15,30,45}
riki_tricks_of_the_trade_custom.modifier_riki_8_cast_range = {50,100,150}
riki_tricks_of_the_trade_custom.modifier_riki_9 = 1
riki_tricks_of_the_trade_custom.modifier_riki_12_base = 1
riki_tricks_of_the_trade_custom.modifier_riki_12_agility = {300,200}

function riki_tricks_of_the_trade_custom:GetBehavior()
    local behavior = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_CHANNELLED + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
    if self:GetCaster():HasModifier("modifier_riki_9") then
        return behavior + DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
    end
    return behavior
end

function riki_tricks_of_the_trade_custom:GetCastRange(vLocation, hTarget)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_riki_8") then
        bonus = self.modifier_riki_8_cast_range[self:GetCaster():GetTalentLevel("modifier_riki_8")]
    end
    return self.BaseClass.GetCastRange(self, vLocation, hTarget) + bonus
end

function riki_tricks_of_the_trade_custom:CastFilterResultTarget( hTarget )
	local nResult = UnitFilter(
		hTarget,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,
		self:GetCaster():GetTeamNumber()
	)
	if hTarget == self:GetCaster() then
		return UF_FAIL_CUSTOM
	end
	if nResult ~= UF_SUCCESS then
		return nResult
	end
	return UF_SUCCESS
end

function riki_tricks_of_the_trade_custom:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end
end

function riki_tricks_of_the_trade_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function riki_tricks_of_the_trade_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local target = self:GetCursorTarget()
    self:GetCaster():SetAbsOrigin(point)
    if target then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_riki_tricks_of_the_trade_custom", {target = target:entindex()})
    else
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_riki_tricks_of_the_trade_custom", {x = point.x, y = point.y, z = point.z})
    end
end

function riki_tricks_of_the_trade_custom:OnChannelFinish()
    if not IsServer() then return end
    local modifier = self:GetCaster():FindModifierByName("modifier_riki_tricks_of_the_trade_custom")
    if modifier and not modifier:IsNull() then
        modifier:Destroy()
    end
end

modifier_riki_tricks_of_the_trade_custom = class({})
function modifier_riki_tricks_of_the_trade_custom:IsHidden() return true end
function modifier_riki_tricks_of_the_trade_custom:IsPurgable() return false end
function modifier_riki_tricks_of_the_trade_custom:IsPurgeException() return false end
function modifier_riki_tricks_of_the_trade_custom:OnCreated(params)
    self.attack_damage = self:GetAbility():GetSpecialValueFor("attack_damage")
    if not IsServer() then return end
    if params.target then
        self.target = EntIndexToHScript(params.target)
    end
    if params.x then
        self.start_point = Vector(params.x, params.y, params.z)
    end
    self.attack_count = self:GetAbility():GetSpecialValueFor("attack_count")
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self:GetParent():EmitSound("Hero_Riki.TricksOfTheTrade")
    if self:GetCaster():HasModifier("modifier_riki_12") then
        self.attack_count = self.attack_count + (self:GetAbility().modifier_riki_12_base + math.floor((self:GetCaster():GetAgility() / self:GetAbility().modifier_riki_12_agility[self:GetCaster():GetTalentLevel("modifier_riki_12")])))
    end

    local particle_start = ParticleManager:CreateParticle("particles/units/heroes/hero_riki/riki_tricks_cast.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle_start, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle_start)

    self.particle_radius = ParticleManager:CreateParticle("particles/units/heroes/hero_riki/riki_tricks.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.particle_radius, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(self.particle_radius, 1, Vector(self.radius, 0, self.radius))
    ParticleManager:SetParticleControl(self.particle_radius, 2, Vector(self.radius, 0, self.radius))
    self:AddParticle(self.particle_radius, false, false, -1, false, false)

    self:GetParent():AddNoDraw()
    
    self.attack_time = (self:GetAbility():GetChannelTime() / (self.attack_count))
    self.current_interval = self.attack_time
    self:OnIntervalThink()
    self:StartIntervalThink(0.01)
end

function modifier_riki_tricks_of_the_trade_custom:OnDestroy()
    if not IsServer() then return end
    if self.start_point then
        FindClearSpaceForUnit(self:GetParent(), self.start_point, true)
    else
        FindClearSpaceForUnit(self:GetParent(), self.target:GetAbsOrigin(), true)
    end
    self:GetParent():StopSound("Hero_Riki.TricksOfTheTrade")
    self:GetParent():RemoveNoDraw()
    local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_riki/riki_tricks_end.vpcf", PATTACH_ABSORIGIN, self:GetParent())
    ParticleManager:ReleaseParticleIndex(particle)
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_phased", {duration = FrameTime()})
end

function modifier_riki_tricks_of_the_trade_custom:OnRefresh(params)
    if not IsServer() then return end
    self:OnCreated(params)
end

function modifier_riki_tricks_of_the_trade_custom:OnIntervalThink()
    if not IsServer() then return end
    
    self.current_interval = self.current_interval + 0.01
    
    if self.target then
        self:GetCaster():SetAbsOrigin(self.target:GetAbsOrigin())
        ParticleManager:SetParticleControl(self.particle_radius, 0, self:GetParent():GetAbsOrigin())
    end

    if self.target and (self.target:IsNull() or not self.target:IsAlive()) then
        self:Destroy()
        self:GetParent():Interrupt()
        return
    end

    if self.attack_count <= 0 then
        self:Destroy()
        self:GetParent():Interrupt()
        return
    end

    if self.current_interval >= self.attack_time then
        self.current_interval = 0
        local targets = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY , DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC , DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES+DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_ANY_ORDER , false)
        local random_targets = {}
        if #targets > 0 then
            for _, target in pairs(targets) do
                if target:IsAlive() and not target:IsAttackImmune() then
                    table.insert(random_targets, target)
                end
            end
        end
        if #random_targets > 0 then
            local targets_counter_max = self:GetAbility():GetSpecialValueFor("interval_targets")
            for i=1, targets_counter_max do
                if #random_targets == 0 then break end
                local target = table.remove(random_targets, RandomInt(1, #random_targets))
                local origin = target:GetAbsOrigin() - target:GetForwardVector() * 150
                self:GetParent():SetAbsOrigin(origin)
                self:GetParent():PerformAttack(target, true, true, true, false, false, false, false)
                print("attack")
            end
            self.attack_count = self.attack_count - 1
            if self.start_point then
                self:GetParent():SetAbsOrigin(self.start_point)
            else
                self:GetParent():SetAbsOrigin(self.target:GetAbsOrigin())
            end
        end
    end
end

function modifier_riki_tricks_of_the_trade_custom:DeclareFunctions()
    if self:GetParent():HasModifier("modifier_riki_9") then
        return
        {
            MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        }
    end
    return
    {
        MODIFIER_PROPERTY_OVERRIDE_ATTACK_DAMAGE,
    }
end

function modifier_riki_tricks_of_the_trade_custom:GetModifierPreAttack_BonusDamage()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_riki_8") then
        bonus = self:GetAbility().modifier_riki_8[self:GetCaster():GetTalentLevel("modifier_riki_8")]
    end
    return self.attack_damage + bonus
end

function modifier_riki_tricks_of_the_trade_custom:GetModifierOverrideAttackDamage()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_riki_8") then
        bonus = self:GetAbility().modifier_riki_8[self:GetCaster():GetTalentLevel("modifier_riki_8")]
    end
    local modifier_riki_backstab_custom = self:GetCaster():FindModifierByName("modifier_riki_backstab_custom")
    if modifier_riki_backstab_custom then
        bonus = bonus + modifier_riki_backstab_custom:GetBonusDamage()
    end
    return self.attack_damage + bonus
end

function modifier_riki_tricks_of_the_trade_custom:CheckState()
    return
    {   
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end