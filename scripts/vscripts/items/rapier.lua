--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_rapier_custom", "items/rapier", LUA_MODIFIER_MOTION_NONE)

item_rapier_custom = class({})

function item_rapier_custom:Spawn()
    if not IsServer() then return end
    local item = self
    if item and item.itembuydisabled == nil and item.timerscreated == nil then
        item.timerscreated = false
        item:SetCurrentCharges(self:GetSpecialValueFor("max_charges"))
        Timers:CreateTimer(10, function()
            if item and not item:IsNull() then
                item.itembuydisabled = false
                item:SetSellable(false)
            end
        end)
    end
end

function item_rapier_custom:OnOwnerDied(params)
    local hOwner = self:GetOwner()
    if not hOwner:IsReincarnating() and hOwner:IsRealHero() then
        self:SetCurrentCharges(self:GetCurrentCharges() - 1)
        if self:GetCurrentCharges() <= 0 then
            self:Destroy()
        end
    end
end

function item_rapier_custom:DropItem(hItem, sNewItemName, bLaunchLoot)
    local vLocation = GetGroundPosition(self:GetCaster():GetAbsOrigin(), self:GetCaster())
    local sName
    local vRandomVector = RandomVector(100)

    if hItem then
        sName = hItem:GetName()
        self:GetCaster():DropItemAtPositionImmediate(hItem, vLocation)
    else
        sName = sNewItemName
        hItem = CreateItem(sNewItemName, nil, nil)
        CreateItemOnPositionSync(vLocation, hItem)
        hItem:SetPurchaser(nil)
        hItem:SetPurchaseTime(0)
        hItem:SetDroppable(false)
    end

    if bLaunchLoot then
        hItem:LaunchLoot(false, 250, 0.5, vLocation + vRandomVector)
    end
end

function item_rapier_custom:GetIntrinsicModifierName() return "modifier_item_rapier_custom" end

modifier_item_rapier_custom = class({})

function modifier_item_rapier_custom:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_rapier_custom:IsPurgable() return false end
function modifier_item_rapier_custom:IsHidden() return true end

function modifier_item_rapier_custom:OnCreated(args)
    if not IsServer() then return end
    self.critProc = true
end

function modifier_item_rapier_custom:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    }
end

function modifier_item_rapier_custom:AttackStartModifier(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.target:IsWard() then return end
    if RollPercentage( self:GetAbility():GetSpecialValueFor("truestrike_chance") ) then
        self.critProc = true
    else
        self.critProc = false
    end
end

function modifier_item_rapier_custom:GetModifierPreAttack_BonusDamage(params)
    local bonus = self:GetAbility():GetSpecialValueFor("bonus_damage")
    if _G.Players and _G.Players.QueueAttackBonus and params and params.attacker and params.target then
        _G.Players:QueueAttackBonus(params.attacker, params.target, bonus, "item_rapier_custom", DAMAGE_TYPE_PHYSICAL)
    end
    return bonus
end

function modifier_item_rapier_custom:GetModifierSpellAmplify_Percentage()
    return self:GetAbility():GetSpecialValueFor("spell_amplify")
end

function modifier_item_rapier_custom:CheckState()
    local state = {}
    if self.critProc then
        state = {[MODIFIER_STATE_CANNOT_MISS] = true}
    end
    return state
end