--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_phoenix_super_supernova_custom_buff", "heroes/npc_dota_hero_phoenix_custom/phoenix_super_supernova_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_super_supernova_custom_handler", "heroes/npc_dota_hero_phoenix_custom/phoenix_super_supernova_custom", LUA_MODIFIER_MOTION_NONE)

phoenix_super_supernova_custom = class({})

function phoenix_super_supernova_custom:GetIntrinsicModifierName()
    return "modifier_phoenix_super_supernova_custom_handler"
end

function phoenix_super_supernova_custom:OnSpellStart(no_heal)
	if not IsServer() then return end
    self:GetCaster():Purge(false, true, false, true, true)
	StartSoundEvent( "Hero_Phoenix.SuperNova.Explode", self:GetCaster())
	local pfx = ParticleManager:CreateParticle( "particles/units/heroes/hero_phoenix/phoenix_supernova_reborn.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl(pfx, 0, self:GetCaster():GetAbsOrigin() )
	ParticleManager:SetParticleControl(pfx, 1, Vector(1.5,1.5,1.5) )
	ParticleManager:SetParticleControl(pfx, 3, self:GetCaster():GetAbsOrigin() )
	ParticleManager:ReleaseParticleIndex(pfx)
    local health = self:GetCaster():GetMaxHealth() / 100 * self:GetSpecialValueFor("health_restore")
    local mana = self:GetCaster():GetMaxMana() / 100 * self:GetSpecialValueFor("health_restore")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_phoenix_super_supernova_custom_buff", {duration = self:GetSpecialValueFor("invul_duration")})
    if not no_heal then
	    self:GetCaster():Heal(health, self)
    end
    self:GetCaster():GiveMana( mana )
	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false )
	for _, enemy in pairs(enemies) do
        enemy:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = self:GetSpecialValueFor("stun_duration") * (1 - enemy:GetStatusResistance())} )
	end
end

modifier_phoenix_super_supernova_custom_buff = class({})
function modifier_phoenix_super_supernova_custom_buff:IsPurgable() return false end
function modifier_phoenix_super_supernova_custom_buff:IsPurgeException() return false end
function modifier_phoenix_super_supernova_custom_buff:CheckState()
    return
    {
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_UNTARGETABLE] = true,
    }
end

function modifier_phoenix_super_supernova_custom_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
    }
end

function modifier_phoenix_super_supernova_custom_buff:GetAbsoluteNoDamagePhysical() return 1 end
function modifier_phoenix_super_supernova_custom_buff:GetAbsoluteNoDamageMagical() return 1 end
function modifier_phoenix_super_supernova_custom_buff:GetAbsoluteNoDamagePure() return 1 end

modifier_phoenix_super_supernova_custom_handler = class({})
function modifier_phoenix_super_supernova_custom_handler:IsHidden() return true end
function modifier_phoenix_super_supernova_custom_handler:IsPurgable() return false end
function modifier_phoenix_super_supernova_custom_handler:IsPurgeException() return false end
function modifier_phoenix_super_supernova_custom_handler:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MIN_HEALTH,
	}
end
function modifier_phoenix_super_supernova_custom_handler:OnTakeDamage(params)
	if not IsServer() then return end
	if not self:GetParent():IsRealHero() then return end
	if not params.attacker then return end
	if not self:GetParent():IsAlive() then return end
	if self:GetParent() ~= params.unit then return end
    if self:GetParent():PassivesDisabled() then return end
	if self:GetParent():GetHealth() > 1 then return end
	if not self:GetAbility():IsCooldownReady() then return end
    self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_phoenix_super_supernova_custom_buff", {duration = self:GetAbility():GetSpecialValueFor("invul_duration")})
    local health = self:GetCaster():GetMaxHealth() / 100 * self:GetAbility():GetSpecialValueFor("health_restore")
    local min_health = 1
    self:GetParent():SetHealth(math.max(health, math.min(params.cost, min_health)))
    self:GetAbility():OnSpellStart(true)
	self:GetAbility():UseResources(false, false, false, true)
end

function modifier_phoenix_super_supernova_custom_handler:GetMinHealth()
	if not IsServer() then return end
	if not self:GetParent():IsRealHero() then return end
	if not self:GetParent():IsAlive() then return end
	if not self:GetAbility():IsCooldownReady() then return end
    if self:GetParent():PassivesDisabled() then return end
	return 1
end