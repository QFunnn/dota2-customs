--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_duel_curse = class({})

function modifier_duel_curse:IsHidden() return true end
function modifier_duel_curse:IsDebuff() return false end
function modifier_duel_curse:IsPurgable() return false end
function modifier_duel_curse:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_duel_curse:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end

function modifier_duel_curse:OnIntervalThink()
    if not IsServer() then return end
    local hp = self:GetParent():GetHealth()
    local max_hp = self:GetParent():GetMaxHealth()

    local new_hp = hp - max_hp * 0.005

    if new_hp < 2 then
        self:GetParent():Kill(nil, self:GetParent())
    else
        self:GetParent():SetHealth(new_hp)
    end

    local modifier_item_aeon_disk_lua_buff = self:GetParent():FindModifierByName("modifier_item_aeon_disk_lua_buff")
    if modifier_item_aeon_disk_lua_buff then
        modifier_item_aeon_disk_lua_buff:Destroy()
    end
    
    local modifier_item_aeon_disk_buff = self:GetParent():FindModifierByName("modifier_item_aeon_disk_buff")
    if modifier_item_aeon_disk_buff then
        modifier_item_aeon_disk_buff:Destroy()
    end

    if not self:GetCaster():HasModifier("modifier_duel_curse") then
        self:Destroy()
    end
end

function modifier_duel_curse:DeclareFunctions()
    local funcs = 
    {
    	MODIFIER_PROPERTY_DISABLE_HEALING,
	}
	return funcs
end

function modifier_duel_curse:GetDisableHealing()
    return 1
end

modifier_duel_curse_cooldown = class({})

function modifier_duel_curse_cooldown:IsHidden() return true end
function modifier_duel_curse_cooldown:IsDebuff() return false end
function modifier_duel_curse_cooldown:IsPurgable() return false end
function modifier_duel_curse_cooldown:IsPurgeException() return false end
function modifier_duel_curse_cooldown:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_IGNORE_DODGE end
function modifier_duel_curse_cooldown:RemoveOnDeath() return false end

function modifier_duel_curse_cooldown:OnCreated()
    if not IsServer() then return end

    local parent = self:GetParent()
    if parent == nil or parent:IsNull() then return end

    -- print("Created")

    for _, AbilityName in ipairs(DUEL_DEACTIVATE_LIST) do
        local Ability = parent:FindAbilityByName(AbilityName)
        if Ability then
            Ability._IsDuelDeactivated = true
            Ability:SetActivated(false)
        end
    end

    for _, AbilityName in ipairs(DUEL_COOLDOWN_LIST) do
        local Ability = parent:FindAbilityByName(AbilityName)
        if Ability then
            Ability:SetActivated(false)
        end
    end

    self:OnIntervalThink()
    self:StartIntervalThink(0.01)
end

-- Держит способность на замороженной 5-сек перезарядке. Работает по ИМЕНИ, поэтому ловит
-- и СТЯНУТУЮ Spell Steal'ом копию (у неё то же имя, новый объект) — этим и блокируется абуз:
-- SetActivated(false) вешается один раз на объект в OnCreated и на украденную копию не действует,
-- а этот пофреймовый фриз находит её заново каждый тик.
local function _FreezeAbilityCooldown(parent, AbilityName)
    local Ability = parent:FindAbilityByName(AbilityName)
    if Ability and Ability:GetCooldownTimeRemaining() <= 5 then
        Ability:EndCooldown()
        Ability:StartCooldown(5)

        if not Ability._Frozened then
            Ability._Frozened = true
            Ability:SetFrozenCooldown(true)
        end
    end
end

function modifier_duel_curse_cooldown:OnIntervalThink()
    if not IsServer() then return end

    local parent = self:GetParent()
    if parent == nil or parent:IsNull() then return end

    -- print("Thinked on ".. parent:GetUnitName() .."")

    for _, AbilityName in ipairs(DUEL_COOLDOWN_LIST) do
        _FreezeAbilityCooldown(parent, AbilityName)
    end

    -- Анти-абуз Spell Steal: те же способности из DEACTIVATE_LIST дополнительно держим на
    -- замороженной перезарядке каждый тик. SetActivated(false) в OnCreated глушит только
    -- ОРИГИНАЛ; стянутую копию (новый объект, то же имя) ловит только этот пофреймовый фриз.
    for _, AbilityName in ipairs(DUEL_DEACTIVATE_LIST) do
        _FreezeAbilityCooldown(parent, AbilityName)
    end
end

function modifier_duel_curse_cooldown:OnDestroy()
    if not IsServer() then return end

    local parent = self:GetParent()
    if parent == nil or parent:IsNull() then return end

    for _, AbilityName in ipairs(DUEL_DEACTIVATE_LIST) do
        local Ability = parent:FindAbilityByName(AbilityName)
        if Ability then
            Ability:SetActivated(true)
            Ability._IsDuelDeactivated = nil
            -- Снимаем фриз перезарядки, навешенный анти-абузным фризом в OnIntervalThink.
            Ability._Frozened = nil
            Ability:SetFrozenCooldown(false)
            Ability:EndCooldown()
        end
    end

    -- print("Deleted on ".. parent:GetUnitName() .."")

    for _, AbilityName in ipairs(DUEL_COOLDOWN_LIST) do
        local Ability = parent:FindAbilityByName(AbilityName)
        if Ability then
            Ability._Frozened = nil
            Ability:SetFrozenCooldown(false)
            Ability:SetActivated(true)
        end
    end
end