--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_attributes_book_custom", "items/item_attribute_books", LUA_MODIFIER_MOTION_NONE)

item_book_of_strength_custom = class({})
function item_book_of_strength_custom:OnChargeCountChanged(iCharges) end

function item_book_of_strength_custom:OnSpellStart()
    if not IsServer() then return end
    local PlayerID = self:GetCaster():GetPlayerOwnerID()

    local modifier_attributes_book_custom = self:GetCaster():FindModifierByName("modifier_attributes_book_custom")
    if modifier_attributes_book_custom == nil then
        modifier_attributes_book_custom = self:GetCaster():AddNewModifier(self:GetCaster(), nil, "modifier_attributes_book_custom", {})
        modifier_attributes_book_custom:Upgrade("str")
    else
        modifier_attributes_book_custom:Upgrade("str")
    end
    HeroBuilder:IncrementAttributeBook(PlayerID, "attribute_book_str")
    self:SpendCharge(0)
end

item_book_of_agility_custom = class({})
function item_book_of_agility_custom:OnChargeCountChanged(iCharges) end

function item_book_of_agility_custom:OnSpellStart()
    if not IsServer() then return end
    local PlayerID = self:GetCaster():GetPlayerOwnerID()

    local modifier_attributes_book_custom = self:GetCaster():FindModifierByName("modifier_attributes_book_custom")
    if modifier_attributes_book_custom == nil then
        modifier_attributes_book_custom = self:GetCaster():AddNewModifier(self:GetCaster(), nil, "modifier_attributes_book_custom", {})
        modifier_attributes_book_custom:Upgrade("agi")
    else
        modifier_attributes_book_custom:Upgrade("agi")
    end
    HeroBuilder:IncrementAttributeBook(PlayerID, "attribute_book_agi")
    self:SpendCharge(0)
end

item_book_of_intelligence_custom = class({})
function item_book_of_intelligence_custom:OnChargeCountChanged(iCharges) end

function item_book_of_intelligence_custom:OnSpellStart()
    if not IsServer() then return end
    local PlayerID = self:GetCaster():GetPlayerOwnerID()

    local modifier_attributes_book_custom = self:GetCaster():FindModifierByName("modifier_attributes_book_custom")
    if modifier_attributes_book_custom == nil then
        modifier_attributes_book_custom = self:GetCaster():AddNewModifier(self:GetCaster(), nil, "modifier_attributes_book_custom", {})
        modifier_attributes_book_custom:Upgrade("int")
    else
        modifier_attributes_book_custom:Upgrade("int")
    end
    HeroBuilder:IncrementAttributeBook(PlayerID, "attribute_book_int")
    self:SpendCharge(0)
end

modifier_attributes_book_custom = class({})
function modifier_attributes_book_custom:IsPurgable() return false end
function modifier_attributes_book_custom:IsPurgeException() return false end
function modifier_attributes_book_custom:RemoveOnDeath() return false end

function modifier_attributes_book_custom:GetTexture()
    return "../items/attribute_book"
end

function modifier_attributes_book_custom:OnCreated()
    if not IsServer() then return end
    self.str = 0
    self.agi = 0
    self.int = 0
    self:SetHasCustomTransmitterData(true)
    self:SendBuffRefreshToClients()
end

function modifier_attributes_book_custom:Upgrade(attribute)
    if not IsServer() then return end
    if attribute == "str" then
        self.str = self.str + 3
    elseif attribute == "agi" then
        self.agi = self.agi + 3
    elseif attribute == "int" then
        self.int = self.int + 3
    end
    self:GetParent():CalculateStatBonus(true)
    self:SendBuffRefreshToClients()
end

function modifier_attributes_book_custom:AddCustomTransmitterData()
    self.TransmitterTable = self.TransmitterTable or {}

    self.TransmitterTable.str = self.str
    self.TransmitterTable.agi = self.agi
    self.TransmitterTable.int = self.int
    
    return self.TransmitterTable
end

function modifier_attributes_book_custom:HandleCustomTransmitterData( data )
    self.str = data.str
    self.agi = data.agi
    self.int = data.int
end

function modifier_attributes_book_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    }
end

function modifier_attributes_book_custom:GetModifierBonusStats_Strength()
    return self.str
end

function modifier_attributes_book_custom:GetModifierBonusStats_Agility()
    return self.agi
end

function modifier_attributes_book_custom:GetModifierBonusStats_Intellect()
    return self.int
end