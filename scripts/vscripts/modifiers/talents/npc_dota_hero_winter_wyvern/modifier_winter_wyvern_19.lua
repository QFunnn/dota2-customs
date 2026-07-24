--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_winter_wyvern_19=class({})

LinkLuaModifier("modifier_winter_wyvern_19_buff", "modifiers/talents/npc_dota_hero_winter_wyvern/modifier_winter_wyvern_19", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_winter_wyvern_19_buff_cooldown", "modifiers/talents/npc_dota_hero_winter_wyvern/modifier_winter_wyvern_19", LUA_MODIFIER_MOTION_NONE)

function modifier_winter_wyvern_19:IsHidden() return true end
function modifier_winter_wyvern_19:IsPurgable() return false end
function modifier_winter_wyvern_19:IsPurgeException() return false end
function modifier_winter_wyvern_19:RemoveOnDeath() return false end

function modifier_winter_wyvern_19:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_winter_wyvern_19:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_winter_wyvern_19:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MIN_HEALTH
	}
end

function modifier_winter_wyvern_19:GetMinHealth()
	if self:GetParent():IsIllusion() then return end
	if self:GetParent():HasModifier("modifier_winter_wyvern_19_buff_cooldown") then return end
	return 1
end

function modifier_winter_wyvern_19:OnTakeDamage(params)
	if not IsServer() then return end
	if params.unit ~= self:GetParent() then return end
	if self:GetParent():GetHealth() > 1 then return end
	if self:GetParent():HasModifier("modifier_winter_wyvern_19_buff") then return end
	if self:GetParent():HasModifier("modifier_winter_wyvern_19_buff_cooldown") then return end
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_winter_wyvern_19_buff", {duration = 2})
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_winter_wyvern_19_buff_cooldown", {duration = 120})
	self:GetParent():Purge(false, true, false, true, true)
    local winter_wyvern_cold_embrace_custom = self:GetCaster():FindAbilityByName("winter_wyvern_cold_embrace_custom")
    if winter_wyvern_cold_embrace_custom and winter_wyvern_cold_embrace_custom:GetLevel() > 0 then
        self:GetCaster():EmitSound("Hero_Winter_Wyvern.ColdEmbrace.Cast")
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_winter_wyvern/wyvern_cold_embrace_start.vpcf", PATTACH_POINT, self:GetCaster())
        ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
        ParticleManager:SetParticleControl(particle, 1, self:GetCaster():GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
        self:GetCaster():AddNewModifier(self:GetCaster(), winter_wyvern_cold_embrace_custom, "modifier_winter_wyvern_cold_embrace_custom", {duration = 2})
    end
end

modifier_winter_wyvern_19_buff = class({})
function modifier_winter_wyvern_19_buff:IsHidden() return false end
function modifier_winter_wyvern_19_buff:IsPurgable() return false end
function modifier_winter_wyvern_19_buff:GetTexture() return "winter_wyvern_19" end
function modifier_winter_wyvern_19_buff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MIN_HEALTH,
	}
end

function modifier_winter_wyvern_19_buff:GetMinHealth()
	return 1
end

function modifier_winter_wyvern_19_buff:CheckState()
	return 
    {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_SILENCED] = true,
	}
end

modifier_winter_wyvern_19_buff_cooldown = class({})
function modifier_winter_wyvern_19_buff_cooldown:IsHidden() return false end
function modifier_winter_wyvern_19_buff_cooldown:IsPurgable() return false end
function modifier_winter_wyvern_19_buff_cooldown:IsDebuff() return true end
function modifier_winter_wyvern_19_buff_cooldown:RemoveOnDeath() return false end
function modifier_winter_wyvern_19_buff_cooldown:GetTexture() return "winter_wyvern_19" end