--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_generic_arc_lua", "modifiers/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier("modifier_zuus_heavenly_jump_custom_debuff", "abilities/zuus_heavenly_jump_custom", LUA_MODIFIER_MOTION_NONE)

zuus_heavenly_jump_custom = class({})

function zuus_heavenly_jump_custom:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_zuus/zuzuus_shard_slowus_shard_head.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_zuus/.vpcf", context)
end

function zuus_heavenly_jump_custom:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    self:Jump()

    -- Талант L25 _zeus_jump_charges даёт 3 заряда, но движок выставляет
    -- AbilityCooldown=7 после каждого каста, что блокирует chain-cast даже
    -- при наличии зарядов. KV-оператор `=0` через talent-binding не работает
    -- (проверено дебагом). Сбрасываем CD руками если ещё остался хотя бы один
    -- заряд — на последнем касте (charges==0) НЕ трогаем, чтобы заряд-реген
    -- через AbilityChargeRestoreTime отработал штатно.
    if caster:HasTalent("special_bonus_unique_zeus_jump_charges") then
        Timers:CreateTimer(FrameTime() * 2, function()
            if not self or self:IsNull() then return end
            if (self:GetCurrentAbilityCharges() or 0) > 0 then
                self:EndCooldown()
            end
        end)
    end
end

function zuus_heavenly_jump_custom:Jump(point)
    if not IsServer() then return end
	local height = self:GetSpecialValueFor("hop_height")
	local distance = self:GetSpecialValueFor("hop_distance")
    local hop_distance = self:GetSpecialValueFor("hop_distance")
	local hop_duration = self:GetSpecialValueFor("hop_duration")
	local range = self:GetSpecialValueFor("range")
    local max_targets = self:GetSpecialValueFor("targets")
	local direction = self:GetCaster():GetForwardVector()
    self:GetCaster():EmitSound("Hero_Zuus.StaticField")
    AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), 900, 3, false)
    self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_generic_arc_lua",{ dir_x = direction.x,dir_y = direction.y,duration = hop_duration,distance = distance,height = height,fix_end = false,isStun = false,isForward = true,activity = ACT_DOTA_CAST_ABILITY_3,})
	local units = {}
	local units_heroes = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, false)
	local units_creeps = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC,  DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, false)
	if #units_heroes > 0 then 
		for i = 1, #units_heroes do 
			table.insert(units, units_heroes[i])
		end
	end
	if #units_creeps > 0 then 
		for i = 1, #units_creeps do 
			table.insert(units, units_creeps[i])
		end
	end
	if #units == 0 then return end
	local max_targets = math.min(max_targets, #units)
	for i = 1, max_targets do 
		self:DealDamage(units[i], false, false)
	end
end

function zuus_heavenly_jump_custom:DealDamage(target)
    if not IsServer() then return end
    local damage_ability = self
    local damage_max_health = self:GetSpecialValueFor("damage_max_health")
    local duration = self:GetSpecialValueFor("duration")
    target:AddNewModifier(self:GetCaster(), damage_ability, "modifier_zuus_heavenly_jump_custom_debuff", {duration = duration})
    local damage_percent = target:GetMaxHealth() / 100 * damage_max_health
    ApplyDamage({victim = target, attacker = self:GetCaster(), damage = damage_percent, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
    target:EmitSound("Hero_Zuus.ArcLightning.Target")
    local particle = "particles/units/heroes/hero_zuus/zuus_shard_head.vpcf"
    local thunder = ParticleManager:CreateParticle(particle, PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControlEnt(thunder, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(thunder, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(thunder, 2, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_origin", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(thunder)
end

modifier_zuus_heavenly_jump_custom_debuff = class({})

function modifier_zuus_heavenly_jump_custom_debuff:OnCreated()
    self.move_slow = self:GetAbility():GetSpecialValueFor("move_slow")
    self.aspd_slow = self:GetAbility():GetSpecialValueFor("aspd_slow")
    if not IsServer() then return end
    local particle_slow = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_shard_slow.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    self:AddParticle(particle_slow, false, false, -1, false, false)
end

function modifier_zuus_heavenly_jump_custom_debuff:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_zuus_heavenly_jump_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.move_slow
end

function modifier_zuus_heavenly_jump_custom_debuff:GetModifierAttackSpeedBonus_Constant()
	return self.aspd_slow
end