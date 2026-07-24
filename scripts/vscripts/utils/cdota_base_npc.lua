--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--- Env: `server` or `client`
function CDOTA_BaseNPC:IsMonkeyClone()
    return (self:HasModifier("modifier_monkey_king_fur_army_soldier") or self:HasModifier("modifier_wukongs_command_warrior"))
end

--- Env: only in `server`
function CDOTA_BaseNPC:IsMainHero()
    return self and (not self:IsNull()) and self:IsRealHero() and (not self:IsTempestDouble()) and
        (not self:IsMonkeyClone())
end

--- Есть ли шард у юнита.
--- Env: `server` or `client`
---@return boolean
function CDOTA_BaseNPC:HasShard()
    if not self or self:IsNull() then return false end
    return self:HasModifier("modifier_item_aghanims_shard")
end

-- Talent handling
function CDOTA_BaseNPC:HasTalent(talent_name)
    if not self or self:IsNull() then return end

    local talent = self:FindAbilityByName(talent_name)
    if talent and talent:GetLevel() > 0 then return true end
end

function CDOTA_BaseNPC:FindTalentValue(talent_name, key)
    if self:HasTalent(talent_name) then
        local value_name = key or "value"
        return self:FindAbilityByName(talent_name):GetSpecialValueFor(value_name)
    end
    return 0
end

function CDOTA_BaseNPC:GetTalentValue(talent_name)
    local talent = self:FindAbilityByName(talent_name)
    if talent and talent:GetLevel() >= 1 then return talent:GetSpecialValueFor("value") end

    return 0
end

---Удалить навык, сохранив горячую клавишу
---@param ability_name string
function CDOTA_BaseNPC:RemoveAbilityForEmpty(ability_name)
    local ability = self:FindAbilityByName(ability_name)
    if not ability then return end
    local index = ability:GetAbilityIndex()
    ability:Disable()
    if index <= 5 then -- only swap if we get assigned hotkey, otherwise pointless
        local emptyAbility = self:FindAbilityByName("empty_" .. index)
        if emptyAbility then
            self:SwapAbilities(ability, emptyAbility, false, false)
        end
    end
    ability:SetRemovalTimer()
end

---Пересортировать, не сохраняя привязки клавиш
---@param ability_name string
function CDOTA_BaseNPC:RemoveAbilityWithRestructure(ability_name)
    local ability = self:FindAbilityByName(ability_name)
    if not ability then return end

    ability:Disable()

    local index = ability:GetAbilityIndex()
    local emptyAbility = self:FindAbilityByName("empty_" .. index)
    if not emptyAbility then
        emptyAbility = self:AddAbility("empty_" .. index)
    end
    self:SwapAbilities(ability, emptyAbility, false, false)

    ability:SetRemovalTimer()

    if index > 5 then return end
    Timers:CreateTimer(function()
        for i = index, self:GetAbilityCount() - 2 do
            local nextAbility = self:GetAbilityByIndex(i + 1)
            if nextAbility and not nextAbility.placeholder and not nextAbility:IsHidden() then
                local nextAbilityName = nextAbility:GetAbilityName()
                if not nextAbilityName:find("special_bonus") and not HeroBuilder:IsInnateAbility(nextAbilityName) then
                    self:SwapAbilities(emptyAbility, nextAbility, false, true)
                end
            end
        end
    end)
end

--- Env: only in `server`
function CDOTA_BaseNPC:FindHotKeyForAbility(sAbilityName)
    Timers:CreateTimer(function()
        local ability = self:FindAbilityByName(sAbilityName)
        for i = 0, self:GetAbilityCount() - 1 do
            local hPlaceholderAability = self:GetAbilityByIndex(i)
            if hPlaceholderAability and hPlaceholderAability:GetAbilityName() and ability then
                local sPlaceholderAbilityName = hPlaceholderAability:GetAbilityName()
                if sPlaceholderAbilityName == sAbilityName then
                    break
                end
                if hPlaceholderAability.nPlaceholder then
                    self:SwapAbilities(hPlaceholderAability, ability, false, true)
                    break
                end
            end
        end
    end)
end

_G.vanillaSwapAbilities = _G.vanillaSwapAbilities or CDOTA_BaseNPC.SwapAbilities
--- Безопасный свап абилок
--- Env: only in `server`
---@param ability1 CDOTABaseAbility
---@param ability2 CDOTABaseAbility
---@param enabled1 boolean
---@param enabled2 boolean
function CDOTA_BaseNPC:SwapAbilities(ability1, ability2, enabled1, enabled2)
    if not self or self:IsNull() then return end

    local abilityName1 = ability1:GetAbilityName()
    local abilityName2 = ability2:GetAbilityName()
    vanillaSwapAbilities(self, abilityName1, abilityName2, enabled1, enabled2)
    -- Временно убран таймер, нужно потестить
    if IsValid(ability1) then
        ability1:SetHidden(not enabled1)
    end
    if IsValid(ability2) then
        ability2:SetHidden(not enabled2)
    end
end

--- Env: only in `server`
function CDOTA_BaseNPC:GetStatusResistanceCaster()
    local fValue = 0

    local tModifiers = {
        modifier_item_timeless_relic = 0.2,
        modifier_tinker_rearm_lua_buff = -1
    }

    for sModifierName, _fValue in pairs(tModifiers) do
        local tBuffs = self:FindAllModifiersByName(sModifierName)
        if tBuffs and #tBuffs > 0 then
            local iCount = #(tBuffs)
            local fValueinCal = _fValue
            if _fValue == -1 then
                fValueinCal = -tBuffs[1]:GetModifierStatusResistanceCaster() *
                    0.01
            end
            fValue = 1 - ((1 - fValue) * math.pow(1 + fValueinCal, iCount))
        end
    end

    return fValue
end

--- Env: only in `server`
function CDOTA_BaseNPC:GetStatusResistanceFactor(hCaster)
    local fValue = 1 - self:GetStatusResistance()

    if IsValid(hCaster) then
        fValue = fValue * (1 - hCaster:GetStatusResistanceCaster())
    end
    return fValue
end

ATTACK_STATE_NOT_USECASTATTACKORB = 1
ATTACK_STATE_NOT_PROCESSPROCS     = 2
ATTACK_STATE_SKIPCOOLDOWN         = 8
ATTACK_STATE_IGNOREINVIS          = 16
ATTACK_STATE_NOT_USEPROJECTILE    = 32
ATTACK_STATE_FAKEATTACK           = 64
ATTACK_STATE_NEVERMISS            = 128
ATTACK_STATE_NO_CLEAVE            = 256
ATTACK_STATE_NO_EXTENDATTACK      = 512
ATTACK_STATE_SKIPCOUNTING         = 1024
ATTACK_STATE_CRIT                 = 2048

function CDOTA_BaseNPC:Attack(hTarget, iAttackState, ExtraData)
    if not IsValid(self) or not IsValid(hTarget) then return nil end

    iAttackState = iAttackState or 0

    local bUseCastAttackOrb =
        (bit.band(iAttackState, ATTACK_STATE_NOT_USECASTATTACKORB) ~= ATTACK_STATE_NOT_USECASTATTACKORB)
    local bProcessProcs =
        (bit.band(iAttackState, ATTACK_STATE_NOT_PROCESSPROCS) ~= ATTACK_STATE_NOT_PROCESSPROCS)
    local bSkipCooldown =
        (bit.band(iAttackState, ATTACK_STATE_SKIPCOOLDOWN) == ATTACK_STATE_SKIPCOOLDOWN)
    local bIgnoreInvis =
        (bit.band(iAttackState, ATTACK_STATE_IGNOREINVIS) == ATTACK_STATE_IGNOREINVIS)
    local bUseProjectile =
        (bit.band(iAttackState, ATTACK_STATE_NOT_USEPROJECTILE) ~= ATTACK_STATE_NOT_USEPROJECTILE)
    local bFakeAttack =
        (bit.band(iAttackState, ATTACK_STATE_FAKEATTACK) == ATTACK_STATE_FAKEATTACK)
    local bNeverMiss =
        (bit.band(iAttackState, ATTACK_STATE_NEVERMISS) == ATTACK_STATE_NEVERMISS)

    if not bFakeAttack and bProcessProcs and bUseCastAttackOrb then
        local params = {
            attacker     = self,
            target       = hTarget,
            attack_state = iAttackState,
            extra        = ExtraData,
        }

        if self.tSourceModifierEvents
            and self.tSourceModifierEvents[MODIFIER_EVENT_ON_ATTACK_START] then
            local tModifiers = self.tSourceModifierEvents[MODIFIER_EVENT_ON_ATTACK_START]
            for i = #tModifiers, 1, -1 do
                local hModifier = tModifiers[i]
                if IsValid(hModifier) and hModifier.OnAttackStart_AttackSystem then
                    hModifier:OnAttackStart_AttackSystem(params, ExtraData)
                end
            end
        end

        if tModifierEvents and tModifierEvents[MODIFIER_EVENT_ON_ATTACK_START] then
            local tModifiers = tModifierEvents[MODIFIER_EVENT_ON_ATTACK_START]
            for i = #tModifiers, 1, -1 do
                local hModifier = tModifiers[i]
                if IsValid(hModifier) and hModifier.OnAttackStart_AttackSystem then
                    hModifier:OnAttackStart_AttackSystem(params, ExtraData)
                end
            end
        end
    end

    self:PerformAttack(
        hTarget,
        bUseCastAttackOrb,
        bProcessProcs,
        bSkipCooldown,
        bIgnoreInvis,
        bUseProjectile,
        bFakeAttack,
        bNeverMiss
    )

    return nil
end

function CDOTA_BaseNPC:AttackFilter(iRecord, ...)
    local bool = false
    if self.ATTACK_SYSTEM == nil then self.ATTACK_SYSTEM = {} end
    for i, iAttackState in pairs({ ... }) do
        bool = bool or
            (bit.band(self.ATTACK_SYSTEM[iRecord] or 0, iAttackState) ==
                iAttackState)
    end
    return bool
end

function CDOTA_BaseNPC:HasState(iStatetoCheck)
    local buffs = self:FindAllModifiers()
    for _, buff in pairs(buffs) do
        local t = {}
        buff:CheckStateToTable(t)
        for iState, bEnable in pairs(t) do
            if tonumber(iState) == iStatetoCheck and bEnable then
                return true
            end
        end
    end
    return false
end

function CDOTA_BaseNPC:IsRoshan()
    if IsValid(self) and self.GetUnitName and type(self.GetUnitName) ==
        "function" and self:GetUnitName() == "npc_dota_roshan" then
        return true
    else
        return false
    end
end