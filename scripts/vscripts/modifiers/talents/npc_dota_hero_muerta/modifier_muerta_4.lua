--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_modifier_muerta_4_cooldown", "modifiers/talents/npc_dota_hero_muerta/modifier_muerta_4", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_muerta_dead_shot_custom_fear", "heroes/npc_dota_hero_muerta_custom/muerta_dead_shot_custom", LUA_MODIFIER_MOTION_NONE)

modifier_muerta_4=class({})

function modifier_muerta_4:IsHidden() return true end
function modifier_muerta_4:IsPurgable() return false end
function modifier_muerta_4:IsPurgeException() return false end
function modifier_muerta_4:RemoveOnDeath() return false end

function modifier_muerta_4:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local muerta_dead_shot_custom = self:GetCaster():FindAbilityByName("muerta_dead_shot_custom")
	if muerta_dead_shot_custom then
		muerta_dead_shot_custom:SetHidden(true)
		muerta_dead_shot_custom:SetActivated(false)
	end
end

function modifier_muerta_4:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_muerta_4:DeclareFunctions()
	return {
		 
	}
end

function modifier_muerta_4:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target == self:GetParent() then return end
	if params.target:IsMagicImmune() then return end
	if self:GetParent():HasModifier("modifier_modifier_muerta_4_cooldown") then return end
	local muerta_dead_shot_custom = self:GetCaster():FindAbilityByName("muerta_dead_shot_custom")
	if muerta_dead_shot_custom then
		params.target:AddNewModifier(self:GetCaster(), muerta_dead_shot_custom, "modifier_muerta_dead_shot_custom_fear", {duration = 1, x = self:GetCaster():GetAbsOrigin().x, y = self:GetCaster():GetAbsOrigin().y})
		local cooldown = {11,9,7}
		self:GetCaster():AddNewModifier(self:GetCaster(), muerta_dead_shot_custom, "modifier_modifier_muerta_4_cooldown", {duration = cooldown[self:GetStackCount()]})
	end
end

modifier_modifier_muerta_4_cooldown = class({})
function modifier_modifier_muerta_4_cooldown:IsPurgable() return false end
function modifier_modifier_muerta_4_cooldown:IsPurgeException() return false end
function modifier_modifier_muerta_4_cooldown:RemoveOnDeath() return false end
function modifier_modifier_muerta_4_cooldown:IsDebuff() return true end