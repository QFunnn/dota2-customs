--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ember_spirit_flame_guard_custom", "heroes/ember_spirit/flame_guard", LUA_MODIFIER_MOTION_NONE)

ember_spirit_flame_guard_custom = class({})

function ember_spirit_flame_guard_custom:OnSpellStart()
if not IsServer() then return end
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
		
	caster:EmitSound("Hero_EmberSpirit.FlameGuard.Cast")

	if caster:FindModifierByName("modifier_ember_spirit_flame_guard_custom") then
		caster:FindModifierByName("modifier_ember_spirit_flame_guard_custom"):Destroy()
	end

	caster:AddNewModifier(caster, self, "modifier_ember_spirit_flame_guard_custom", {duration = duration})
end

modifier_ember_spirit_flame_guard_custom = class({})

function modifier_ember_spirit_flame_guard_custom:IsDebuff() return false end
function modifier_ember_spirit_flame_guard_custom:IsHidden() return false end

function modifier_ember_spirit_flame_guard_custom:IsPurgable() 
	return false
end

function modifier_ember_spirit_flame_guard_custom:OnCreated(keys)
	if not IsServer() then return end

	self.block_amount = self:GetAbility():GetSpecialValueFor("shield_pct_absorb")/100
	self.effect_radius = self:GetAbility():GetSpecialValueFor("radius")
	self.tick_interval = self:GetAbility():GetSpecialValueFor("tick_interval")
	self.damage = self:GetAbility():GetSpecialValueFor("damage_per_second") 
	self.damage = self.damage*self.tick_interval
	self.remaining_health = self:GetAbility():GetSpecialValueFor("absorb_amount")
	print("запуск", self.remaining_health )

	self.particle_index = ParticleManager:CreateParticle("particles/units/heroes/hero_ember_spirit/ember_spirit_flameguard.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(self.particle_index, 0, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(self.particle_index, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(self.particle_index, 2, Vector(self.effect_radius,0,0))
	ParticleManager:SetParticleControl(self.particle_index, 3, Vector(125,0,0))
	self:AddParticle(self.particle_index, false, false, -1, false, false ) 

	self:SetStackCount(self.remaining_health)
	self:StartIntervalThink(self.tick_interval)

	self:GetParent():EmitSound("Hero_EmberSpirit.FlameGuard.Loop")
end

function modifier_ember_spirit_flame_guard_custom:OnDestroy()
	if not IsServer() then return end
	self:GetParent():StopSound("Hero_EmberSpirit.FlameGuard.Loop")
end

function modifier_ember_spirit_flame_guard_custom:OnIntervalThink()
	if not IsServer() then return end
	local nearby_enemies = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.effect_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
	for _, enemy in pairs(nearby_enemies) do
		local damage = self.damage
		ApplyDamage({victim = enemy, attacker = self:GetCaster(), ability = self:GetAbility(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
	end
end

function modifier_ember_spirit_flame_guard_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end

function modifier_ember_spirit_flame_guard_custom:GetModifierTotal_ConstantBlock(params)
    if not IsServer() then return end

    if self:GetParent() == params.attacker then return end
    if params.target ~= self:GetParent() then return end

    if self.remaining_health == 0 then return end
    
    if params.damage_type ~= DAMAGE_TYPE_MAGICAL then return end
    
    local blocked_damage = params.damage*self.block_amount

    if self.remaining_health > blocked_damage then
        self.remaining_health = self.remaining_health - blocked_damage
        self:SetStackCount(self.remaining_health)
        print("работает", self.remaining_health, blocked_damage)
        local i = blocked_damage
        return i
    else
    	local i = self.remaining_health
    	self.remaining_health = 0
    	self:SetStackCount(self.remaining_health)
        return i
    end
end

function modifier_ember_spirit_flame_guard_custom:GetModifierMagicalResistanceBonus()
    if not self:GetCaster():HasTalent("special_bonus_unique_cha_ember_spirit") then return end
    return 50
end
