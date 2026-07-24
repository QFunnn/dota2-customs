--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_wodarelax", "modifiers/modifier_wodarelax", LUA_MODIFIER_MOTION_NONE)

modifier_wodarelax = class({})

function modifier_wodarelax:IsPurgable() 
    return false
end

function modifier_wodarelax:IsHidden() 
    return true 
end

function modifier_wodarelax:IsPurgeException()
    return false
end

function modifier_wodarelax:RemoveOnDeath() 
    return false
end

function modifier_wodarelax:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end

function modifier_wodarelax:OnIntervalThink()
    if not IsServer() then return end
    
    if not self:GetParent():IsRealHero() then
        if not self:GetCaster():HasModifier("modifier_wodarelax") then
            self:Destroy()
            return
        end
    end

    if self:GetParent():IsRealHero() then
        if self:GetParent().bear and not self:GetParent().bear:IsNull() and self:GetParent().bear:IsAlive() then
            if not self:GetParent().bear:HasModifier("modifier_wodarelax") then
                self:GetParent().bear:AddNewModifier(self:GetParent(), nil, "modifier_wodarelax", {})
            end
        end
    end

    for i=0,6 do
        local item = self:GetParent():GetItemInSlot(i)
        if item and item:GetName() == "item_bottle" then
            if item:GetCurrentCharges() < 3 then
                item:SetCurrentCharges(3)
            end
        end
    end

    if not string.find(GetMapName(), "rating") then 
        return 
    end

    arena_system:RelaxPositionCheck(self:GetParent())
end

function modifier_wodarelax:CheckState() 
    return 
    {
        [MODIFIER_STATE_ATTACK_IMMUNE] = true,
	    [MODIFIER_STATE_MAGIC_IMMUNE] = true, 
        [MODIFIER_STATE_PROVIDES_VISION] = true,
        [MODIFIER_STATE_DISARMED] = true
    }
end

function modifier_wodarelax:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
        MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
        MODIFIER_PROPERTY_PROVIDES_FOW_POSITION,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
    }
    return funcs
end

function modifier_wodarelax:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_wodarelax:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_wodarelax:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_wodarelax:GetModifierTotalPercentageManaRegen( params )
	if not IsServer() then return end
    return 9
end

function modifier_wodarelax:GetModifierHealthRegenPercentage( params )
	if not IsServer() then return end
    return 9
end

function modifier_wodarelax:GetEffectName()
	return "particles/generic_gameplay/radiant_fountain_regen.vpcf"
end

function modifier_wodarelax:GetModifierProvidesFOWVision()
	return 1
end




modifier_wodarelax_invul = class({})

function modifier_wodarelax_invul:IsPurgable() 
    return false
end

function modifier_wodarelax_invul:IsHidden() 
    return true 
end

function modifier_wodarelax_invul:IsPurgeException()
    return false
end

function modifier_wodarelax_invul:RemoveOnDeath() 
    return false
end

function modifier_wodarelax_invul:CheckState() 
    return 
    {
        [MODIFIER_STATE_ATTACK_IMMUNE] = true,
        [MODIFIER_STATE_UNTARGETABLE] = true, 
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_DISARMED] = true, 
    }
end

function modifier_wodarelax_invul:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        MODIFIER_PROPERTY_DISABLE_HEALING
    }
    return funcs
end

function modifier_wodarelax_invul:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_wodarelax_invul:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_wodarelax_invul:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_wodarelax_invul:GetDisableHealing()
    return 1
end






