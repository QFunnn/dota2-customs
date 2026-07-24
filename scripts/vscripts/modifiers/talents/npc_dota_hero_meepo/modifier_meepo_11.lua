--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_meepo_11_shield", "modifiers/talents/npc_dota_hero_meepo/modifier_meepo_11", LUA_MODIFIER_MOTION_NONE)

modifier_meepo_11 = class({})

function modifier_meepo_11:IsHidden() return true end
function modifier_meepo_11:IsPurgable() return false end
function modifier_meepo_11:IsPurgeException() return false end
function modifier_meepo_11:RemoveOnDeath() return false end

function modifier_meepo_11:OnCreated()
	if not IsServer() then return end
    self.attack = 0
	self:SetStackCount(1)
end

function modifier_meepo_11:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_meepo_11:DeclareFunctions()
    return
    {
         
    }
end

function modifier_meepo_11:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    self.attack = self.attack + 1
    if self.attack >= 5 then
        self.attack = 0
        self:GetCaster():AddNewModifier(self:GetCaster(), nil, "modifier_meepo_11_shield", {})
    end
end

modifier_meepo_11_shield = class({})
function modifier_meepo_11_shield:IsPurgable() return false end
function modifier_meepo_11_shield:GetTexture() return "aghanim_11" end
function modifier_meepo_11_shield:OnCreated(params)
    if not IsServer() then return end
    self.max_shield = 600
    self.bonus = {50,100,150}
    self:SetStackCount(self.bonus[self:GetCaster():GetTalentLevel("modifier_meepo_11")])
end

function modifier_meepo_11_shield:OnRefresh()
    if not IsServer() then return end
    local bonus = self.bonus[self:GetCaster():GetTalentLevel("modifier_meepo_11")]
    self:SetStackCount(math.min(self.max_shield, self:GetStackCount() + bonus))
end

function modifier_meepo_11_shield:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
    }
    return funcs
end

function modifier_meepo_11_shield:GetModifierTotal_ConstantBlock(kv)
    if IsServer() then
        local target                    = self:GetParent()
        local original_shield_amount    = self:GetStackCount()
        if kv.damage > 0 then
            if kv.damage < original_shield_amount then
                SendOverheadEventMessage(nil, OVERHEAD_ALERT_BLOCK, target, kv.damage, nil)
                original_shield_amount = original_shield_amount - kv.damage
                self:SetStackCount(original_shield_amount)
                return kv.damage
            else
                SendOverheadEventMessage(nil, OVERHEAD_ALERT_BLOCK, target, original_shield_amount, nil)
                if not self:IsNull() then
                    self:Destroy()
                end
                return original_shield_amount
            end
        end
    end
end

function modifier_meepo_11_shield:GetModifierIncomingDamageConstant()
    if (not IsServer()) then
        return self:GetStackCount()
    end
end