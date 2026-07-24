--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_gem_shard", "items/item_gem_shard", LUA_MODIFIER_MOTION_NONE )

item_gem_shard = class({})
function item_gem_shard:OnChargeCountChanged(iCharges) end

function item_gem_shard:OnSpellStart()
	if not IsServer() then return end
    local caster = self:GetCaster()
    local item = self
    caster:AddNewModifier(caster, nil, "modifier_item_gem_shard", {})
    item:SpendCharge(0)
end

modifier_item_gem_shard = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsPermanent             = function(self) return true end,
    RemoveOnDeath           = function(self) return false end,
    GetAttributes           = function(self) return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_PERMANENT end,

    GetTexture              = function(self) return "item_gem_shard" end,

    DeclareFunctions        = function(self) return { MODIFIER_PROPERTY_TOOLTIP } end,
    OnTooltip               = function(self) return 500 end,

    IsAura                  = function (self) return true end,
    IsAuraActiveOnDeath     = function (self) return false end,
    GetAuraRadius           = function (self) return 500 end,
    GetModifierAura         = function (self) return "modifier_truesight" end,
    GetAuraSearchTeam       = function (self) return DOTA_UNIT_TARGET_TEAM_ENEMY end,
    GetAuraSearchFlags      = function (self) return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE end,
    GetAuraSearchType       = function (self) return DOTA_UNIT_TARGET_ALL end,
    GetAuraDuration         = function (self) return 0.1 end,
})

LinkLuaModifier( "modifier_item_gem_shard_2", "items/item_gem_shard", LUA_MODIFIER_MOTION_NONE )

item_gem_shard_2 = class({})
function item_gem_shard_2:OnChargeCountChanged(iCharges) end

function item_gem_shard_2:OnSpellStart()
	if not IsServer() then return end
    local caster = self:GetCaster()
    local item = self
    caster:AddNewModifier(caster, nil, "modifier_item_gem_shard_2", {})
    item:SpendCharge(0)
end

modifier_item_gem_shard_2 = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsPermanent             = function(self) return true end,
    RemoveOnDeath           = function(self) return false end,
    GetAttributes           = function(self) return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_PERMANENT end,

    GetTexture              = function(self) return "item_gem_shard" end,

    DeclareFunctions        = function(self) return { MODIFIER_PROPERTY_TOOLTIP } end,
    OnTooltip               = function(self) return 1000 end,

    IsAura                  = function (self) return true end,
    IsAuraActiveOnDeath     = function (self) return false end,
    GetAuraRadius           = function (self) return 1000 end,
    GetModifierAura         = function (self) return "modifier_truesight" end,
    GetAuraSearchTeam       = function (self) return DOTA_UNIT_TARGET_TEAM_ENEMY end,
    GetAuraSearchFlags      = function (self) return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE end,
    GetAuraSearchType       = function (self) return DOTA_UNIT_TARGET_ALL end,
    GetAuraDuration         = function (self) return 0.1 end,
})