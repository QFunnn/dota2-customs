--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_sniper_12_debuff", "modifiers/talents/npc_dota_hero_sniper/modifier_sniper_12", LUA_MODIFIER_MOTION_NONE)

modifier_sniper_12=class({})

function modifier_sniper_12:IsHidden() return self:GetParent():HasModifier("modifier_sniper_12_debuff") end
function modifier_sniper_12:IsPurgable() return false end
function modifier_sniper_12:IsPurgeException() return false end
function modifier_sniper_12:RemoveOnDeath() return false end

function modifier_sniper_12:OnCreated()
	self.bonus = {1,2}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_sniper_12:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_sniper_12:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
        MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE
	}
end

function modifier_sniper_12:OnTakeDamage(params)
	if not IsServer() then return end
	if params.unit ~= self:GetParent() then return end
	if params.attacker == self:GetParent() then return end
    if params.damage <= 0 then return end
	self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_sniper_12_debuff", {duration = 3})
end

function modifier_sniper_12:GetModifierHealthRegenPercentage()
	if self.bonus == nil and self:GetStackCount() == 0 then return end
	if self:GetParent():HasModifier("modifier_sniper_12_debuff") then return end
	return self.bonus[self:GetStackCount()]
end

function modifier_sniper_12:GetModifierTotalPercentageManaRegen()
	if self.bonus == nil and self:GetStackCount() == 0 then return end
	if self:GetParent():HasModifier("modifier_sniper_12_debuff") then return end
	return self.bonus[self:GetStackCount()]
end

function modifier_sniper_12:GetTexture() return "sniper_12" end

modifier_sniper_12_debuff = class({})
function modifier_sniper_12_debuff:IsDebuff() return true end
function modifier_sniper_12_debuff:IsPurgable() return false end
function modifier_sniper_12_debuff:RemoveOnDeath() return false end
function modifier_sniper_12_debuff:GetTexture() return "sniper_12" end