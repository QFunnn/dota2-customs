--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_dagon_custom", "items/item_dagon_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_dagon_custom_break", "items/item_dagon_custom", LUA_MODIFIER_MOTION_NONE)

item_dagon_custom = class({})
item_dagon_2_custom = class({})
item_dagon_3_custom = class({})
item_dagon_4_custom = class({})
item_dagon_5_custom = class({})

function item_dagon_custom:GetIntrinsicModifierName() return "modifier_item_dagon_custom" end
function item_dagon_2_custom:GetIntrinsicModifierName() return "modifier_item_dagon_custom" end
function item_dagon_3_custom:GetIntrinsicModifierName() return "modifier_item_dagon_custom" end
function item_dagon_4_custom:GetIntrinsicModifierName() return "modifier_item_dagon_custom" end
function item_dagon_5_custom:GetIntrinsicModifierName() return "modifier_item_dagon_custom" end

function item_dagon_custom:OnSpellStart()
    if not IsServer() then return end
    if self:GetCursorTarget():IsMagicImmune() then return end
    self:GetCursorTarget():EmitSound("DOTA_Item.Dagon"..self:GetLevel()..".Target")
    if self:GetCursorTarget():TriggerSpellAbsorb(self) then return end
    local radius = self:GetSpecialValueFor("aoe_radius")
    local damage = self:GetSpecialValueFor("damage")
    self:GetCaster():EmitSound("DOTA_Item.Dagon.Activate")
    local dagon_pfx = ParticleManager:CreateParticle("particles/items_fx/dagon.vpcf", PATTACH_RENDERORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt(dagon_pfx, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), false)
    ParticleManager:SetParticleControlEnt(dagon_pfx, 1, self:GetCursorTarget(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCursorTarget():GetAbsOrigin(), false)
    ParticleManager:SetParticleControl(dagon_pfx, 2, Vector(damage, 0, 0))
    ParticleManager:SetParticleControl(dagon_pfx, 3, Vector(0.3, 0, 0))
    ParticleManager:ReleaseParticleIndex(dagon_pfx)
    ApplyDamage({ attacker = self:GetCaster(), victim = self:GetCursorTarget(), ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
    if self:GetCursorTarget():IsIllusion() then
        self:GetCursorTarget():Kill(self, self:GetCaster())
    end
end

function item_dagon_2_custom:OnSpellStart()
    if not IsServer() then return end
    if self:GetCursorTarget():IsMagicImmune() then return end
    self:GetCursorTarget():EmitSound("DOTA_Item.Dagon"..self:GetLevel()..".Target")
    if self:GetCursorTarget():TriggerSpellAbsorb(self) then return end
    local radius = self:GetSpecialValueFor("aoe_radius")
    local damage = self:GetSpecialValueFor("damage")
    self:GetCaster():EmitSound("DOTA_Item.Dagon.Activate")
    local dagon_pfx = ParticleManager:CreateParticle("particles/items_fx/dagon.vpcf", PATTACH_RENDERORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt(dagon_pfx, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), false)
    ParticleManager:SetParticleControlEnt(dagon_pfx, 1, self:GetCursorTarget(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCursorTarget():GetAbsOrigin(), false)
    ParticleManager:SetParticleControl(dagon_pfx, 2, Vector(damage, 0, 0))
    ParticleManager:SetParticleControl(dagon_pfx, 3, Vector(0.3, 0, 0))
    ParticleManager:ReleaseParticleIndex(dagon_pfx)
    ApplyDamage({ attacker = self:GetCaster(), victim = self:GetCursorTarget(), ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
    if self:GetCursorTarget():IsIllusion() then
        self:GetCursorTarget():Kill(self, self:GetCaster())
    end
end

function item_dagon_3_custom:OnSpellStart()
    if not IsServer() then return end
    if self:GetCursorTarget():IsMagicImmune() then return end
    self:GetCursorTarget():EmitSound("DOTA_Item.Dagon"..self:GetLevel()..".Target")
    if self:GetCursorTarget():TriggerSpellAbsorb(self) then return end
    local radius = self:GetSpecialValueFor("aoe_radius")
    local damage = self:GetSpecialValueFor("damage")
    self:GetCaster():EmitSound("DOTA_Item.Dagon.Activate")
    local dagon_pfx = ParticleManager:CreateParticle("particles/items_fx/dagon.vpcf", PATTACH_RENDERORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt(dagon_pfx, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), false)
    ParticleManager:SetParticleControlEnt(dagon_pfx, 1, self:GetCursorTarget(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCursorTarget():GetAbsOrigin(), false)
    ParticleManager:SetParticleControl(dagon_pfx, 2, Vector(damage, 0, 0))
    ParticleManager:SetParticleControl(dagon_pfx, 3, Vector(0.3, 0, 0))
    ParticleManager:ReleaseParticleIndex(dagon_pfx)
    ApplyDamage({ attacker = self:GetCaster(), victim = self:GetCursorTarget(), ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
    if self:GetCursorTarget():IsIllusion() then
        self:GetCursorTarget():Kill(self, self:GetCaster())
    end
end

function item_dagon_4_custom:OnSpellStart()
    if not IsServer() then return end
    if self:GetCursorTarget():IsMagicImmune() then return end
    self:GetCursorTarget():EmitSound("DOTA_Item.Dagon"..self:GetLevel()..".Target")
    if self:GetCursorTarget():TriggerSpellAbsorb(self) then return end
    local radius = self:GetSpecialValueFor("aoe_radius")
    local damage = self:GetSpecialValueFor("damage")
    self:GetCaster():EmitSound("DOTA_Item.Dagon.Activate")
    local dagon_pfx = ParticleManager:CreateParticle("particles/items_fx/dagon.vpcf", PATTACH_RENDERORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt(dagon_pfx, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), false)
    ParticleManager:SetParticleControlEnt(dagon_pfx, 1, self:GetCursorTarget(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCursorTarget():GetAbsOrigin(), false)
    ParticleManager:SetParticleControl(dagon_pfx, 2, Vector(damage, 0, 0))
    ParticleManager:SetParticleControl(dagon_pfx, 3, Vector(0.3, 0, 0))
    ParticleManager:ReleaseParticleIndex(dagon_pfx)
    ApplyDamage({ attacker = self:GetCaster(), victim = self:GetCursorTarget(), ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
    if self:GetCursorTarget():IsIllusion() then
        self:GetCursorTarget():Kill(self, self:GetCaster())
    end
end

function item_dagon_5_custom:OnSpellStart()
    if not IsServer() then return end
    if self:GetCursorTarget():IsMagicImmune() then return end
    self:GetCursorTarget():EmitSound("DOTA_Item.Dagon"..self:GetLevel()..".Target")
    if self:GetCursorTarget():TriggerSpellAbsorb(self) then return end
    local radius = self:GetSpecialValueFor("aoe_radius")
    local damage = self:GetSpecialValueFor("damage")
    self:GetCaster():EmitSound("DOTA_Item.Dagon.Activate")
    local dagon_pfx = ParticleManager:CreateParticle("particles/items_fx/dagon.vpcf", PATTACH_RENDERORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt(dagon_pfx, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), false)
    ParticleManager:SetParticleControlEnt(dagon_pfx, 1, self:GetCursorTarget(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCursorTarget():GetAbsOrigin(), false)
    ParticleManager:SetParticleControl(dagon_pfx, 2, Vector(damage, 0, 0))
    ParticleManager:SetParticleControl(dagon_pfx, 3, Vector(0.3, 0, 0))
    ParticleManager:ReleaseParticleIndex(dagon_pfx)
    self:GetCursorTarget():AddNewModifier(self:GetCaster(), self, "modifier_item_dagon_custom_break", {duration = (1 - self:GetCursorTarget():GetStatusResistance())*self:GetSpecialValueFor("duration")})
    ApplyDamage({ attacker = self:GetCaster(), victim = self:GetCursorTarget(), ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
    if self:GetCursorTarget():IsIllusion() then
        self:GetCursorTarget():Kill(self, self:GetCaster())
    end
end

modifier_item_dagon_custom = class({})

function modifier_item_dagon_custom:IsHidden() return true end
function modifier_item_dagon_custom:IsPurgable() return false end
function modifier_item_dagon_custom:IsPurgeException() return false end
function modifier_item_dagon_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE  end

function modifier_item_dagon_custom:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    }
end

function modifier_item_dagon_custom:GetModifierBonusStats_Strength() 
    if self:GetAbility() then return self:GetAbility():GetSpecialValueFor("bonus_str") end 
end

function modifier_item_dagon_custom:GetModifierBonusStats_Agility()
    if self:GetAbility() then return self:GetAbility():GetSpecialValueFor("bonus_agi") end 
end

function modifier_item_dagon_custom:GetModifierBonusStats_Intellect()
    if self:GetAbility() then return self:GetAbility():GetSpecialValueFor("bonus_int") end 
end


modifier_item_dagon_custom_break = class({})

function modifier_item_dagon_custom_break:IsHidden() return false end
function modifier_item_dagon_custom_break:IsPurgable() return false end
function modifier_item_dagon_custom_break:CheckState() return {[MODIFIER_STATE_PASSIVES_DISABLED] = true} end
function modifier_item_dagon_custom_break:GetEffectName() return "particles/items3_fx/silver_edge.vpcf" end

function modifier_item_dagon_custom_break:OnCreated(table)
    if not IsServer() then return end
    self.particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_break.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(self.particle, 1, self:GetParent():GetAbsOrigin())
    self:AddParticle(self.particle, false, false, -1, false, false)
end