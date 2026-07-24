--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_dragon_knight_13=class({})

LinkLuaModifier("modifier_dragon_knight_13_buff", "modifiers/talents/npc_dota_hero_dragon_knight/modifier_dragon_knight_13", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dragon_knight_13_buff_cooldown", "modifiers/talents/npc_dota_hero_dragon_knight/modifier_dragon_knight_13", LUA_MODIFIER_MOTION_NONE)

function modifier_dragon_knight_13:IsHidden() return true end
function modifier_dragon_knight_13:IsPurgable() return false end
function modifier_dragon_knight_13:IsPurgeException() return false end
function modifier_dragon_knight_13:RemoveOnDeath() return false end

function modifier_dragon_knight_13:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_dragon_knight_13:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_dragon_knight_13:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MIN_HEALTH
	}
end

function modifier_dragon_knight_13:GetMinHealth()
	if self:GetParent():IsIllusion() then return end
	if self:GetParent():HasModifier("modifier_dragon_knight_13_buff_cooldown") then return end
	return 1
end

function modifier_dragon_knight_13:OnTakeDamage(params)
	if not IsServer() then return end
	if params.unit ~= self:GetParent() then return end
	if self:GetParent():GetHealth() > 1 then return end
	if self:GetParent():HasModifier("modifier_dragon_knight_13_buff") then return end
	if self:GetParent():HasModifier("modifier_dragon_knight_13_buff_cooldown") then return end
	self:GetParent():EmitSound("Item.Brooch.Cast")
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_dragon_knight_13_buff", {duration = 1})
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_dragon_knight_13_buff_cooldown", {duration = 120})
    self:GetParent():Purge(false, true, false, true, true)
end

modifier_dragon_knight_13_buff = class({})

function modifier_dragon_knight_13_buff:GetEffectName() return "particles/helm_of_the_undying_custom_3.vpcf" end
function modifier_dragon_knight_13_buff:IsHidden() return false end
function modifier_dragon_knight_13_buff:IsPurgable() return false end

function modifier_dragon_knight_13_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MIN_HEALTH,
	}
end

function modifier_dragon_knight_13_buff:GetMinHealth()
	return 1
end

function modifier_dragon_knight_13_buff:OnDestroy()
	if not IsServer() then return end
	self:GetParent():Heal(self:GetParent():GetMaxHealth() * 0.15, nil)
end

function modifier_dragon_knight_13_buff:GetTexture()
	return "dragon_knight_13"
end

modifier_dragon_knight_13_buff_cooldown = class({})

function modifier_dragon_knight_13_buff_cooldown:IsHidden() return false end
function modifier_dragon_knight_13_buff_cooldown:IsPurgable() return false end
function modifier_dragon_knight_13_buff_cooldown:IsDebuff() return true end
function modifier_dragon_knight_13_buff_cooldown:RemoveOnDeath() return false end

function modifier_dragon_knight_13_buff_cooldown:GetTexture()
	return "dragon_knight_13"
end