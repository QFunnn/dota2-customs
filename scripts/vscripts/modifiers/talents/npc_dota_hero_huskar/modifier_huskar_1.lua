--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_huskar_1=class({})

LinkLuaModifier("modifier_huskar_1_buff", "modifiers/talents/npc_dota_hero_huskar/modifier_huskar_1", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_huskar_1_buff_cooldown", "modifiers/talents/npc_dota_hero_huskar/modifier_huskar_1", LUA_MODIFIER_MOTION_NONE)

function modifier_huskar_1:IsHidden() return true end
function modifier_huskar_1:IsPurgable() return false end
function modifier_huskar_1:IsPurgeException() return false end
function modifier_huskar_1:RemoveOnDeath() return false end

function modifier_huskar_1:OnCreated()
    self.cooldown = {120,60}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_huskar_1:OnRefresh()
    self.cooldown = {120,60}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_huskar_1:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_MIN_HEALTH
    }
end

function modifier_huskar_1:GetModifierIncomingDamage_Percentage()
    return 15
end

function modifier_huskar_1:GetMinHealth()
	if self:GetParent():IsIllusion() then return end
	if self:GetParent():HasModifier("modifier_huskar_1_buff_cooldown") then return end
	return 1
end

function modifier_huskar_1:OnTakeDamage(params)
	if not IsServer() then return end
	if params.unit ~= self:GetParent() then return end
	if self:GetParent():GetHealth() > 1 then return end
	if self:GetParent():HasModifier("modifier_huskar_1_buff") then return end
	if self:GetParent():HasModifier("modifier_huskar_1_buff_cooldown") then return end
	self:GetParent():EmitSound("Item.Brooch.Cast")
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_huskar_1_buff", {duration = 1})
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_huskar_1_buff_cooldown", {duration = self.cooldown[self:GetStackCount()]})
end

modifier_huskar_1_buff = class({})
function modifier_huskar_1_buff:GetEffectName() return "particles/helm_of_the_huskar.vpcf" end
function modifier_huskar_1_buff:IsHidden() return false end
function modifier_huskar_1_buff:IsPurgable() return false end
function modifier_huskar_1_buff:GetTexture() return "huskar_1" end
function modifier_huskar_1_buff:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MIN_HEALTH,
	}
end
function modifier_huskar_1_buff:GetMinHealth()
	return 1
end
function modifier_huskar_1_buff:OnDestroy()
	if not IsServer() then return end
	self:GetParent():Heal(self:GetParent():GetMaxHealth() * 0.15, nil)
end

modifier_huskar_1_buff_cooldown = class({})
function modifier_huskar_1_buff_cooldown:IsHidden() return false end
function modifier_huskar_1_buff_cooldown:IsPurgable() return false end
function modifier_huskar_1_buff_cooldown:IsDebuff() return true end
function modifier_huskar_1_buff_cooldown:RemoveOnDeath() return false end
function modifier_huskar_1_buff_cooldown:GetTexture() return "huskar_1" end