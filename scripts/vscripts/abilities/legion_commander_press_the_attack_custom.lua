--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_legion_commander_press_the_attack_custom_buff", "abilities/legion_commander_press_the_attack_custom", LUA_MODIFIER_MOTION_NONE)

legion_commander_press_the_attack_custom = class({})

function legion_commander_press_the_attack_custom:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_commander_press.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_commander_press_hands.vpcf", context )
    PrecacheResource( "particle", "particles/items_fx/black_king_bar_avatar.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_avatar.vpcf", context )
end

function legion_commander_press_the_attack_custom:OnSpellStart()
	if not IsServer() then return end
    local target = self:GetCaster()
	target:Purge(false , true, false , true, false)
	local duration = self:GetSpecialValueFor("duration")
	target:EmitSound("Hero_LegionCommander.PressTheAttack")
	
	-- Добавляем модификатор BKB для полного иммунитета к магии
	target:AddNewModifier(self:GetCaster(), self, "modifier_black_king_bar_immune", {duration = duration})
	-- Добавляем наш модификатор для дополнительного сопротивления 60%, регенерации и скорости
	target:AddNewModifier(self:GetCaster(), self, "modifier_legion_commander_press_the_attack_custom_buff", {duration = duration})
	
    local radius = self:GetSpecialValueFor("radius")
    if radius > 0 then
        local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, 0, false)
        for _, unit in pairs(units) do
            unit:AddNewModifier(self:GetCaster(), self, "modifier_black_king_bar_immune", {duration = duration})
            unit:AddNewModifier(self:GetCaster(), self, "modifier_legion_commander_press_the_attack_custom_buff", {duration = duration})
        end
    end
end

modifier_legion_commander_press_the_attack_custom_buff = class({})

function modifier_legion_commander_press_the_attack_custom_buff:OnCreated(table)
	self.move_speed = self:GetAbility():GetSpecialValueFor("move_speed")
	self.hp_regen = self:GetAbility():GetSpecialValueFor("hp_regen")
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_legion_commander/legion_commander_press.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( particle, 1, self:GetParent():GetAbsOrigin() )
	self:AddParticle(particle, false, false, -1, false, false)
	local cast = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_press_hands.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent())
	ParticleManager:SetParticleControlEnt(cast, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetParent():GetAbsOrigin(), true )
	ParticleManager:SetParticleControlEnt(cast, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetParent():GetAbsOrigin(), true )
	ParticleManager:SetParticleControlEnt(cast, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetParent():GetAbsOrigin(), true )
	self:AddParticle(cast, false, false, -1, false, false)
end

function modifier_legion_commander_press_the_attack_custom_buff:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_legion_commander_press_the_attack_custom_buff:GetModifierConstantHealthRegen()
	return self.hp_regen
end

function modifier_legion_commander_press_the_attack_custom_buff:GetModifierMoveSpeedBonus_Percentage()
	return self.move_speed
end

function modifier_legion_commander_press_the_attack_custom_buff:GetModifierMagicalResistanceBonus()
	return 60
end

-- Визуальные эффекты BKB теперь идут от modifier_black_king_bar_immune
-- Здесь оставляем только дополнительные эффекты Legion Commander

function modifier_legion_commander_press_the_attack_custom_buff:IsPurgable()
	return false
end