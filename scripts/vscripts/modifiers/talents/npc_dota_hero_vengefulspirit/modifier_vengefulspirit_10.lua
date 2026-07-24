--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_vengefulspirit_10=class({})

LinkLuaModifier("modifier_vengefulspirit_10_buff", "modifiers/talents/npc_dota_hero_vengefulspirit/modifier_vengefulspirit_10", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_vengefulspirit_10_buff_cooldown", "modifiers/talents/npc_dota_hero_vengefulspirit/modifier_vengefulspirit_10", LUA_MODIFIER_MOTION_NONE)

function modifier_vengefulspirit_10:IsHidden() return true end
function modifier_vengefulspirit_10:IsPurgable() return false end
function modifier_vengefulspirit_10:IsPurgeException() return false end
function modifier_vengefulspirit_10:RemoveOnDeath() return false end

function modifier_vengefulspirit_10:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_vengefulspirit_10:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_vengefulspirit_10:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MIN_HEALTH
	}
end

function modifier_vengefulspirit_10:GetMinHealth()
	if self:GetParent():IsIllusion() then return end
	if self:GetParent():HasModifier("modifier_vengefulspirit_10_buff_cooldown") then return end
	return 1
end

function modifier_vengefulspirit_10:OnTakeDamage(params)
	if not IsServer() then return end
	if params.unit ~= self:GetParent() then return end
	if self:GetParent():GetHealth() > 1 then return end
	if self:GetParent():HasModifier("modifier_vengefulspirit_10_buff") then return end
	if self:GetParent():HasModifier("modifier_vengefulspirit_10_buff_cooldown") then return end
	self:GetParent():EmitSound("Item.Brooch.Cast")
	self:GetParent():Purge(false, true, false, true, true)
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_vengefulspirit_10_buff", {duration = 3})
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_vengefulspirit_10_buff_cooldown", {duration = 120})
end

modifier_vengefulspirit_10_buff = class({})

function modifier_vengefulspirit_10_buff:IsHidden() return false end
function modifier_vengefulspirit_10_buff:IsPurgable() return false end

function modifier_vengefulspirit_10_buff:GetStatusEffectName()
	return "particles/status_fx/status_effect_vengeful_venge_image.vpcf"
end

function modifier_vengefulspirit_10_buff:StatusEffectPriority() return 10 end

function modifier_vengefulspirit_10_buff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MIN_HEALTH,
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
	}
end

function modifier_vengefulspirit_10_buff:GetMinHealth()
	return 1
end

function modifier_vengefulspirit_10_buff:GetModifierInvisibilityLevel()
	return 1
end

function modifier_vengefulspirit_10_buff:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}
end

function modifier_vengefulspirit_10_buff:OnDestroy()
	if not IsServer() then return end
	self:GetParent():Purge(false, true, false, true, true)
	self:GetParent():Heal(self:GetParent():GetMaxHealth() * 0.1, nil)
	self:GetParent():GiveMana(self:GetParent():GetMaxMana() * 0.1)
end

function modifier_vengefulspirit_10_buff:GetTexture()
	return "vengefulspirit_10"
end

modifier_vengefulspirit_10_buff_cooldown = class({})

function modifier_vengefulspirit_10_buff_cooldown:IsHidden() return false end
function modifier_vengefulspirit_10_buff_cooldown:IsPurgable() return false end
function modifier_vengefulspirit_10_buff_cooldown:IsDebuff() return true end
function modifier_vengefulspirit_10_buff_cooldown:RemoveOnDeath() return false end

function modifier_vengefulspirit_10_buff_cooldown:GetTexture()
	return "vengefulspirit_10"
end