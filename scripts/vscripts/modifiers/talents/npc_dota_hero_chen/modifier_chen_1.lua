--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_chen_1_buff", "modifiers/talents/npc_dota_hero_chen/modifier_chen_1", LUA_MODIFIER_MOTION_NONE )

modifier_chen_1=class({})

function modifier_chen_1:IsHidden() return true end
function modifier_chen_1:IsPurgable() return false end
function modifier_chen_1:IsPurgeException() return false end
function modifier_chen_1:RemoveOnDeath() return false end

function modifier_chen_1:GetTexture()
    return "chen_1"
end

function modifier_chen_1:OnCreated()
    self.bonus3={16}
    self.bonus2={4}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():SetModel("models/creeps/lane_creeps/creep_radiant_melee/radiant_melee_mega.vmdl")
    self:GetParent():SetOriginalModel("models/creeps/lane_creeps/creep_radiant_melee/radiant_melee_mega.vmdl")
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_chen_1_buff", {})
    self.cooldown = 42
    self.current_cooldown = self.cooldown + 1
    self:OnIntervalThink()
    self:StartIntervalThink(1)
    local chen_creep_visual_mega = self:GetParent():FindAbilityByName("chen_creep_visual_mega")
    if chen_creep_visual_mega then
        chen_creep_visual_mega:SetLevel(1)
        chen_creep_visual_mega:SetHidden(false)
    end
end

function modifier_chen_1:OnIntervalThink()
    if not IsServer() then return end
    self.current_cooldown = self.current_cooldown - 1
    local chen_creep_visual_mega = self:GetCaster():FindAbilityByName("chen_creep_visual_mega")
    if chen_creep_visual_mega and chen_creep_visual_mega:IsFullyCastable() then
        chen_creep_visual_mega:StartCooldown(self.current_cooldown)
    end
    if self.current_cooldown <= 0 then
        local modifier_chen_1_buff = self:GetParent():FindModifierByName("modifier_chen_1_buff")
        if modifier_chen_1_buff then
            modifier_chen_1_buff:IncrementStackCount()
            self:GetParent():CalculateStatBonus(false)
        end
        self.current_cooldown = self.cooldown
    end
end

function modifier_chen_1:DeclareFunctions()
    return
   {
       MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
       MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
   }
end

function modifier_chen_1:GetModifierBaseAttack_BonusDamage()
    return self.bonus3[self:GetStackCount()]
end

function modifier_chen_1:GetModifierConstantHealthRegen()
    return self.bonus2[self:GetStackCount()]
end

function modifier_chen_1:OnRefresh()
    self.bonus3={16}
    self.bonus2={4}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

modifier_chen_1_buff = class({})
function modifier_chen_1_buff:GetTexture()
    return "chen_1"
end
function modifier_chen_1_buff:IsPurgable() return false end
function modifier_chen_1_buff:IsPurgeException() return false end
function modifier_chen_1_buff:RemoveOnDeath() return false end
function modifier_chen_1_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
    }
end

function modifier_chen_1_buff:GetModifierBonusStats_Strength()
    return self:GetStackCount()
end