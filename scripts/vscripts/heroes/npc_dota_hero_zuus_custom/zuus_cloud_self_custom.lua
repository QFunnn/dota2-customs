--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_zuus_cloud_self_custom", "heroes/npc_dota_hero_zuus_custom/zuus_cloud_self_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zuus_cloud_self_custom_handler", "heroes/npc_dota_hero_zuus_custom/zuus_cloud_self_custom", LUA_MODIFIER_MOTION_NONE)

zuus_cloud_self_custom = class({})

function zuus_cloud_self_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_zeus/zeus_cloud.vpcf", context)
end

function zuus_cloud_self_custom:GetIntrinsicModifierName()
    if self:GetCaster():IsIllusion() then return end
    return "modifier_zuus_cloud_self_custom_handler"
end

modifier_zuus_cloud_self_custom_handler = class({})
function modifier_zuus_cloud_self_custom_handler:IsPurgable() return false end
function modifier_zuus_cloud_self_custom_handler:IsPurgeException() return false end
function modifier_zuus_cloud_self_custom_handler:RemoveOnDeath() return false end
function modifier_zuus_cloud_self_custom_handler:IsHidden() return true end
function modifier_zuus_cloud_self_custom_handler:OnCreated()
    if not IsServer() then return end
    if self:GetCaster():IsIllusion() then return end
	self.target_point = self:GetParent():GetAbsOrigin()
	local caster = self:GetCaster()
	local cloud_bolt_interval = self:GetAbility():GetSpecialValueFor("cloud_bolt_interval")
	local cloud_duration = self:GetAbility():GetSpecialValueFor("cloud_duration")
	local cloud_radius = self:GetAbility():GetSpecialValueFor("cloud_radius")
	EmitSoundOnLocationWithCaster(self.target_point, "Hero_Zuus.Cloud.Cast", caster)
	self.zuus_nimbus_unit = CreateUnitByName("npc_dota_zeus_cloud", Vector(self.target_point.x, self.target_point.y, 450), false, caster, nil, caster:GetTeam())
	self.zuus_nimbus_unit:SetModelScale(0.7)
    self.zuus_nimbus_unit:SetOwner(self:GetCaster())
	self.zuus_nimbus_unit:AddNewModifier(self.zuus_nimbus_unit, self, "modifier_phased", {})
	self.zuus_nimbus_unit:AddNewModifier(caster, self:GetAbility(), "modifier_zuus_cloud_self_custom", {cloud_bolt_interval = cloud_bolt_interval, cloud_radius = cloud_radius})
end
function modifier_zuus_cloud_self_custom_handler:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
    }
end

modifier_zuus_cloud_self_custom = class({})
function modifier_zuus_cloud_self_custom:IsHidden() return true end
function modifier_zuus_cloud_self_custom:IsPurgable() return false end
function modifier_zuus_cloud_self_custom:IsPurgeException() return false end

function modifier_zuus_cloud_self_custom:OnCreated(keys)
	if not IsServer() then return end
	self.ability = self
	self.cloud_radius = keys.cloud_radius
	self.cloud_bolt_interval = keys.cloud_bolt_interval
	self.lightning_bolt = self:GetCaster():FindAbilityByName("zuus_lightning_bolt_custom")
	local target_point 	= GetGroundPosition(self:GetParent():GetAbsOrigin(), self:GetParent())
	self.original_z = target_point.z
    self:GetParent():SetBaseMaxHealth(self:GetAbility():GetSpecialValueFor("creep_hits_to_kill_tooltip"))
    self:GetParent():SetMaxHealth(self:GetAbility():GetSpecialValueFor("creep_hits_to_kill_tooltip"))
    self:GetParent():SetHealth(self:GetAbility():GetSpecialValueFor("creep_hits_to_kill_tooltip"))
	self:SetStackCount(self.original_z)
	self.counter = self.cloud_bolt_interval
	self.zuus_nimbus_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zeus/zeus_cloud.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(self.zuus_nimbus_particle, 0, Vector(target_point.x, target_point.y, 450))
	ParticleManager:SetParticleControl(self.zuus_nimbus_particle, 1, Vector(self:GetCaster():GetAoeBonus(self.cloud_radius), 0, 0))
    ParticleManager:SetParticleControlEnt(self.zuus_nimbus_particle, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
	self:AddParticle(self.zuus_nimbus_particle, false, false, -1, false, false)
	self:StartIntervalThink(0.01)
end

function modifier_zuus_cloud_self_custom:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_VISUAL_Z_DELTA,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_PROPERTY_HEALTHBAR_PIPS
	}
end

function modifier_zuus_cloud_self_custom:GetModifierHealthBarPips()
    return 4
end

function modifier_zuus_cloud_self_custom:GetVisualZDelta()
	return 450
end

function modifier_zuus_cloud_self_custom:OnIntervalThink()
	if not IsServer() then return end
    local new_point = self:GetCaster():GetAbsOrigin()
    self:GetParent():SetAbsOrigin(new_point)

    if self.zuus_nimbus_particle then
        ParticleManager:SetParticleControl(self.zuus_nimbus_particle, 0, Vector(new_point.x, new_point.y, 450))
	    ParticleManager:SetParticleControl(self.zuus_nimbus_particle, 1, Vector(self:GetCaster():GetAoeBonus(self.cloud_radius), 0, 0))
	    ParticleManager:SetParticleControl(self.zuus_nimbus_particle, 2, Vector(new_point.x, new_point.y, new_point.z + 450))
    end

    if not self:GetCaster():IsAlive() or self:GetCaster():HasModifier("modifier_wodawispdeath_wisp") or self:GetCaster():HasModifier("modifier_wodarelax") or self:GetCaster():HasModifier("modifier_smoke_of_deceit") or self:GetCaster():HasModifier("modifier_wodawisp") then 
        self:GetParent():AddNoDraw() 
        return 
    end

    if self:GetCaster():HasModifier("modifier_disconnect_player_no_damage") then
        self:GetParent():AddNoDraw() 
        return
    end

    self:GetParent():RemoveNoDraw()

    local nearby_enemy_units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetCaster():GetAoeBonus(self.cloud_radius), DOTA_UNIT_TARGET_TEAM_ENEMY, self.lightning_bolt:GetAbilityTargetType(), DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false )
        
	if self.lightning_bolt and self.lightning_bolt:GetLevel() > 0 and self.counter >= self.cloud_bolt_interval then
		if #nearby_enemy_units > 0 then
            self.lightning_bolt:CastLightningBolt(self:GetCaster(), nearby_enemy_units[1], nearby_enemy_units[1]:GetAbsOrigin(), self:GetParent())
            self.counter = 0
        end
	end

    local check_pigs = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetCaster():GetAoeBonus(self.cloud_radius), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
    if #check_pigs > 0 then
        if check_pigs[1]:GetUnitName() == "npc_woda_pig" or check_pigs[1]:GetUnitName() == "npc_woda_frog" or check_pigs[1]:GetUnitName() == "npc_woda_pig_pve" or check_pigs[1]:GetUnitName() == "npc_woda_frog_pve" or check_pigs[1]:GetUnitName() == "npc_dota_weaver_swarm" then
            if check_pigs[1].zuus_pig_killer == nil then
                check_pigs[1].zuus_pig_killer = 0.01
            end
            check_pigs[1].zuus_pig_killer = check_pigs[1].zuus_pig_killer + 0.01
            if check_pigs[1].zuus_pig_killer >= 0.5 then
                check_pigs[1].zuus_pig_killer = 0
                if check_pigs[1]:GetUnitName() == "npc_dota_weaver_swarm" then
                    self:GetCaster():PerformAttack(check_pigs[1], true, true, true, true, false, false, true)
                else
                    if check_pigs[1]:GetHealth() <= 1 then
                        check_pigs[1]:Kill(self:GetAbility(), self:GetCaster())
                    else
                        check_pigs[1]:SetHealth(check_pigs[1]:GetHealth() - 1)
                    end
                end
            end
        end
    end

    if self.counter <= self.cloud_bolt_interval then
	    self.counter = self.counter + 0.01
    end
end

function modifier_zuus_cloud_self_custom:OnAttack(params)
	if params.target == self:GetParent() then
		local damage = 2
		if not params.attacker:IsHero() then 
			damage = 1
		end 
		if self:GetParent():GetHealth() > damage then 
			self:GetParent():SetHealth(self:GetParent():GetHealth() - damage)
		else 
			self:GetParent():ForceKill(false)
		end
	end
end

function modifier_zuus_cloud_self_custom:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_zuus_cloud_self_custom:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_zuus_cloud_self_custom:GetAbsoluteNoDamagePure()
	return 1
end

function modifier_zuus_cloud_self_custom:OnDestroy()
	if not IsServer() then return end
	if self.zuus_nimbus_particle then
		ParticleManager:DestroyParticle(self.zuus_nimbus_particle, false)
	end
end

function modifier_zuus_cloud_self_custom:CheckState()
    return
    {
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
    }
end