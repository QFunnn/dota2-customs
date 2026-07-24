--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_zuus_arc_lightning_custom", "heroes/npc_dota_hero_zuus_custom/zuus_arc_lightning_custom", LUA_MODIFIER_MOTION_NONE)

zuus_arc_lightning_custom = class({})

zuus_arc_lightning_custom.modifier_zuus_10 = 12

function zuus_arc_lightning_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_zuus/zuus_arc_lightning_head.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_zuus/zuus_arc_lightning.vpcf", context)
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_zuus.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_zuus.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_zuus.vpcf", context)
end

function zuus_arc_lightning_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_zuus_10") then
        return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end

function zuus_arc_lightning_custom:OnSpellStart(new_target)
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	if new_target then 
		target = new_target
	end
	if target:TriggerSpellAbsorb(self) then return end
    local jump_count = self:GetSpecialValueFor("jump_count")
	self:StartArc(target, jump_count)
end

function zuus_arc_lightning_custom:StartArc(target, bounces, damage_reduce)
    if not IsServer() then return end
    if not damage_reduce then
        self:GetCaster():EmitSound("Hero_Zuus.ArcLightning.Cast")
    end
    local head_name_part = "particles/units/heroes/hero_zuus/zuus_arc_lightning_head.vpcf"
    local head_particle = ParticleManager:CreateParticle(head_name_part, PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControlEnt(head_particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(head_particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(head_particle)
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_zuus_arc_lightning_custom", {starting_unit_entindex = target:entindex(), bounces = bounces, damage_reduce = damage_reduce})
end

modifier_zuus_arc_lightning_custom = class({})
function modifier_zuus_arc_lightning_custom:IsHidden() return true end
function modifier_zuus_arc_lightning_custom:IsPurgable() return false end
function modifier_zuus_arc_lightning_custom:RemoveOnDeath()	return false end
function modifier_zuus_arc_lightning_custom:GetAttributes()	return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_zuus_arc_lightning_custom:OnCreated(params)
    if not IsServer() or not self:GetAbility() then return end
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.jump_count	= params.bounces
    self.damage_reduce = params.damage_reduce
	self.jump_delay = self:GetAbility():GetSpecialValueFor("jump_delay")
	self.starting_unit_entindex	= params.starting_unit_entindex
	self.units_affected	= {}
	if self.starting_unit_entindex and EntIndexToHScript(self.starting_unit_entindex) then
		self.current_unit = EntIndexToHScript(self.starting_unit_entindex)
		self.units_affected[self.current_unit] = 1
		self:DoDamage(self.current_unit)
	else
		self:Destroy()
		return
	end
	self.unit_counter = 0
	self:StartIntervalThink(self.jump_delay)
end

function modifier_zuus_arc_lightning_custom:DoDamage(target)
    if not IsServer() then return end
    local arc_damage = self:GetAbility():GetSpecialValueFor("arc_damage")
    if self:GetCaster():HasModifier("modifier_zuus_10") then
        arc_damage = arc_damage + (self:GetCaster():GetDisplayAttackSpeed() / 100 * self:GetAbility().modifier_zuus_10)
    end
    if self.damage_reduce then
        arc_damage = arc_damage / 100 * self.damage_reduce
    end
    ApplyDamage({ victim = target, damage = arc_damage, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetCaster(), ability = self:GetAbility() })
    target:EmitSound("Hero_Zuus.ArcLightning.Target")
end

function modifier_zuus_arc_lightning_custom:OnIntervalThink()
    self.zapped = false
    local team = DOTA_UNIT_TARGET_TEAM_ENEMY
    for _, enemy in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self.current_unit:GetAbsOrigin(), nil, self.radius, team, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, false)) do
        if not self.units_affected[enemy] and enemy ~= self.current_unit and enemy:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
            local ligth_particle = "particles/units/heroes/hero_zuus/zuus_arc_lightning.vpcf"
            self.lightning_particle = ParticleManager:CreateParticle(ligth_particle, PATTACH_ABSORIGIN_FOLLOW, self.current_unit)
            ParticleManager:SetParticleControlEnt(self.lightning_particle, 0, self.current_unit, PATTACH_POINT_FOLLOW, "attach_hitloc", self.current_unit:GetAbsOrigin(), true)
            ParticleManager:SetParticleControlEnt(self.lightning_particle, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
            ParticleManager:ReleaseParticleIndex(self.lightning_particle)
            self.unit_counter = self.unit_counter + 1
            self.previous_unit = self.current_unit
            self.current_unit = enemy
            self.units_affected[self.current_unit] = true
            self.zapped	= true
            if enemy:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then 
                self:DoDamage(enemy)
            end
            break
        end
    end
    if (self.unit_counter >= self.jump_count and self.jump_count > 0) or not self.zapped then
        self:StartIntervalThink(-1)
        self:Destroy()
    end
end