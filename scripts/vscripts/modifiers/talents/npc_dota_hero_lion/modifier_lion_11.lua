--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_lion_11=class({})

LinkLuaModifier("modifier_lion_11_buff", "modifiers/talents/npc_dota_hero_lion/modifier_lion_11", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lion_11_buff_cooldown", "modifiers/talents/npc_dota_hero_lion/modifier_lion_11", LUA_MODIFIER_MOTION_NONE)

function modifier_lion_11:IsHidden() return true end
function modifier_lion_11:IsPurgable() return false end
function modifier_lion_11:IsPurgeException() return false end
function modifier_lion_11:RemoveOnDeath() return false end

function modifier_lion_11:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_lion_11:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_lion_11:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MIN_HEALTH
	}
end

function modifier_lion_11:GetMinHealth()
	if self:GetParent():IsIllusion() then return end
	if self:GetParent():HasModifier("modifier_lion_11_buff_cooldown") then return end
	return 1
end

function modifier_lion_11:OnTakeDamage(params)
	if not IsServer() then return end
	if params.unit ~= self:GetParent() then return end
	if self:GetParent():GetHealth() > 1 then return end
	if self:GetParent():HasModifier("modifier_lion_11_buff") then return end
	if self:GetParent():HasModifier("modifier_lion_11_buff_cooldown") then return end
	self:GetParent():EmitSound("Hero_Lion.Hex.Target")
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_lion/lion_spell_voodoo.vpcf", PATTACH_ABSORIGIN, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_lion_11_buff", {duration = 1})
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_lion_11_buff_cooldown", {duration = 120})
	self:GetParent():Purge(false, true, false, true, true)
end

modifier_lion_11_buff = class({})

function modifier_lion_11_buff:IsHidden() return false end
function modifier_lion_11_buff:IsPurgable() return false end

function modifier_lion_11_buff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MIN_HEALTH,
		MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE,
		MODIFIER_PROPERTY_MODEL_CHANGE,
	}
end

function modifier_lion_11_buff:GetMinHealth()
	return 1
end

function modifier_lion_11_buff:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.9)
end

function modifier_lion_11_buff:OnIntervalThink()
    if not IsServer() then return end
    local heal = self:GetParent():GetMaxHealth() / 100 * 10
    self:GetParent():SetHealth(heal)
    self:StartIntervalThink(-1)
end

function modifier_lion_11_buff:OnDestroy()
	if not IsServer() then return end
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_lion/lion_spell_voodoo.vpcf", PATTACH_ABSORIGIN, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_lion_11_buff:GetTexture()
	return "lion_11"
end

function modifier_lion_11_buff:GetModifierMoveSpeedOverride()
	return 550
end

function modifier_lion_11_buff:GetModifierModelChange()
	return "models/props_gameplay/frog.vmdl"
end

function modifier_lion_11_buff:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_SILENCED] = true,
	}
end

modifier_lion_11_buff_cooldown = class({})

function modifier_lion_11_buff_cooldown:IsHidden() return false end
function modifier_lion_11_buff_cooldown:IsPurgable() return false end
function modifier_lion_11_buff_cooldown:IsDebuff() return true end
function modifier_lion_11_buff_cooldown:RemoveOnDeath() return false end

function modifier_lion_11_buff_cooldown:GetTexture()
	return "lion_11"
end