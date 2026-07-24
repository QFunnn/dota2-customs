--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_warlock_book_custom", "items/item_warlock_book_custom", LUA_MODIFIER_MOTION_NONE)

item_warlock_book_custom = class({})

function item_warlock_book_custom:Spawn()
    if not IsServer() then return end
    if not self.isActive then
        self.isActive = true
        Timers:CreateTimer(FrameTime(), function()
            if not self:GetCaster() then return FrameTime() end
            if not self:GetCaster():IsAlive() then return FrameTime() end
            self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_warlock_book_custom", {})
        end)
    end
end

function item_warlock_book_custom:OnSpellStart()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/items3_fx/warmage_recipient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:ReleaseParticleIndex(particle)
	self:GetCaster():EmitSound("Item.TomeOfKnowledge")
    for i=1, self:GetCurrentCharges() do
        WodaTalents:AddPoint(self:GetCaster():GetPlayerOwnerID(), 1)    
    end
    local modifier_item_warlock_book_custom = self:GetCaster():FindModifierByName("modifier_item_warlock_book_custom")
    if modifier_item_warlock_book_custom then
        modifier_item_warlock_book_custom:Destroy()
    end
    self:GetCaster():ConsumeItem(self)
end

modifier_item_warlock_book_custom = class({})
function modifier_item_warlock_book_custom:IsHidden() return true end
function modifier_item_warlock_book_custom:IsPurgable() return false end
function modifier_item_warlock_book_custom:IsPurgeException() return false end
function modifier_item_warlock_book_custom:RemoveOnDeath() return false end
function modifier_item_warlock_book_custom:OnCreated()
    if not IsServer() then return end
    if self:GetAbility().cooldown_timer == nil then
        self:GetAbility().cooldown_timer = self:GetAbility():GetSpecialValueFor("bonus_change_per_time")
    end
    self:StartIntervalThink(1)
end

function modifier_item_warlock_book_custom:OnIntervalThink()
    if not IsServer() then return end
    if self:GetAbility().cooldown_timer > 0 then
        self:GetAbility().cooldown_timer = self:GetAbility().cooldown_timer - 1
        if self:GetAbility().cooldown_timer <= 0 then
            self:GetAbility():SetCurrentCharges(self:GetAbility():GetCurrentCharges() + 1)
            self:GetAbility().cooldown_timer = self:GetAbility():GetSpecialValueFor("bonus_change_per_time")
        end
    end
end

function modifier_item_warlock_book_custom:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_DEATH
    }
end
function modifier_item_warlock_book_custom:OnDeath(params)
    local attacker = params.attacker
    if attacker == nil then return end
    if attacker == self:GetCaster() or attacker:GetPlayerOwnerID() == self:GetCaster():GetPlayerOwnerID() then
        if params.unit:HasModifier("modifier_wodacreepchampion") then 
            self:GetAbility():SetCurrentCharges(self:GetAbility():GetCurrentCharges() + 1)
        elseif params.unit:HasModifier("modifier_wodacreepchampionred") then 
            self:GetAbility():SetCurrentCharges(self:GetAbility():GetCurrentCharges() + 1)
        elseif params.unit:HasModifier("modifier_wodapig") then 
            self:GetAbility():SetCurrentCharges(self:GetAbility():GetCurrentCharges() + 1)
        elseif params.unit:HasModifier("modifier_wodafrog") then 
            self:GetAbility():SetCurrentCharges(self:GetAbility():GetCurrentCharges() + 1)
        end
    end
end