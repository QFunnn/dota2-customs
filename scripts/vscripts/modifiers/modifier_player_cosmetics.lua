--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_player_cosmetics = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsPermanent             = function(self) return true end,
    RemoveOnDeath           = function(self) return false end,
    GetAttributes           = function(self) return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_PERMANENT end,

    DeclareFunctions        = function(self) 
        return {
            MODIFIER_PROPERTY_PROJECTILE_NAME,
        } 
    end,
    
    GetModifierProjectileName   = function (self)
        return self.CurrentAttackEffect
    end
})

function modifier_player_cosmetics:OnCreated()
    if not IsServer() then return end

    --Основная информация
    self.Hero = self:GetParent()
    self.HeroName = self.Hero:GetUnitName()
    self.PlayerID = self.Hero:GetPlayerOwnerID()

    if not self.Hero:IsHero() then
        self.HeroName = self:GetCaster():GetUnitName()
        self.PlayerID = self:GetCaster():GetPlayerOwnerID()
    end

    --Информация о текущих одетых эффектах
    self.Pet = Server:GetPlayerSlotItemInfo(self.PlayerID, ITEMS_DEFAULT_SLOTS.PET)
    self.HeroEffect = Server:GetPlayerSlotItemInfo(self.PlayerID, ITEMS_DEFAULT_SLOTS.FX_HERO)
    self.AttackEffect = Server:GetPlayerSlotItemInfo(self.PlayerID, ITEMS_DEFAULT_SLOTS.FX_ATTACK)
    self.PersonalHeroEffect = Server:GetPlayerSlotItemInfo(self.PlayerID, self.HeroName)
    self.Weather = Server:GetPlayerSlotItemInfo(self.PlayerID, ITEMS_DEFAULT_SLOTS.WEATHER)

    if not self.new then
        self.new = true

        --Переменные для пета
        self.CurrentSelectedPet = nil
        self.hPet = nil
        self.NextMoveTime = 0
        self.MoveCooldown = 0.5
        self.MoveCooldownCurrent = 0
        self.DistanceToMove = 410
        self.TimeToMove = 5
        self.DistanceToTeleport = 1200

        self.TeleportStartFxName = "particles/econ/items/pets/pet_generic/pet_flee.vpcf"
        self.TeleportEndFxName = "particles/econ/items/pets/pet_generic/pet_spawn.vpcf"

        --Переменные к базовым эффектам героя
        self.CurrentHeroEffect = nil

        --Переменные к персональным эффектам героя
        self.CurrentPersonalHeroEffect = nil

        --Переменные к погоде
        self.CurrentWeatherEffect = nil

        --Переменные к эффектам атаки
        self.CurrentAttackEffect = ""
    end

    if not self.Hero:IsIllusion() then
        if self.Pet ~= nil then
            if self.CurrentSelectedPet ~= self.Pet.game_value then
                self:CreatePet(self.Pet.game_value, self.Pet.game_value_2)
            end
        else
            if self.hPet ~= nil then
                self:RemovePet()
            end
        end
    end

    if self.HeroEffect ~= nil then
        if self.CurrentHeroEffect ~= self.HeroEffect.game_value then
            if self.CurrentHeroEffect ~= nil then
                ParticleManager:DestroyParticle(self.CurrentHeroEffect, false)
                self.CurrentHeroEffect = nil
            end
            self.CurrentHeroEffect = ParticleManager:CreateParticle(self.HeroEffect.game_value, PATTACH_ABSORIGIN_FOLLOW, self.Hero)
            self:AddParticle(self.CurrentHeroEffect, false, false,  -1, false, false)
        end
    else
        if self.CurrentHeroEffect ~= nil then
            ParticleManager:DestroyParticle(self.CurrentHeroEffect, false)
            self.CurrentHeroEffect = nil
        end
    end

    if self.PersonalHeroEffect ~= nil then
        if self.CurrentPersonalHeroEffect ~= self.PersonalHeroEffect.game_value then
            if self.CurrentPersonalHeroEffect ~= nil then
                ParticleManager:DestroyParticle(self.CurrentPersonalHeroEffect, false)
                self.CurrentPersonalHeroEffect = nil
            end
            self.CurrentPersonalHeroEffect = ParticleManager:CreateParticle(self.PersonalHeroEffect.game_value, PATTACH_ABSORIGIN_FOLLOW, self.Hero)
            self:AddParticle(self.CurrentPersonalHeroEffect, false, false,  -1, false, false)
        end
    else
        if self.CurrentPersonalHeroEffect ~= nil then
            ParticleManager:DestroyParticle(self.CurrentPersonalHeroEffect, false)
            self.CurrentPersonalHeroEffect = nil
        end
    end
    
    if self.AttackEffect ~= nil then
        if self.CurrentAttackEffect ~= self.AttackEffect.game_value then
            self.CurrentAttackEffect = self.AttackEffect.game_value
        end
    else
        if self.CurrentAttackEffect ~= nil then
            self.CurrentAttackEffect = ""
        end
    end

    if not self.Hero:IsIllusion() then
        if self.Weather ~= nil then
            if self.CurrentWeatherEffect ~= self.Weather.game_value then
                if self.CurrentWeatherEffect ~= nil then
                    ParticleManager:DestroyParticle(self.CurrentWeatherEffect, false)
                    self.CurrentWeatherEffect = nil
                end
                local Player = PlayerResource:GetPlayer(self.PlayerID)
                if Player then
                    self.CurrentWeatherEffect = ParticleManager:CreateParticleForPlayer(self.Weather.game_value, PATTACH_EYES_FOLLOW, self.Hero, Player)
                    self:AddParticle(self.CurrentWeatherEffect, false, false,  -1, false, false)
                end
            end
        else
            if self.CurrentWeatherEffect ~= nil then
                ParticleManager:DestroyParticle(self.CurrentWeatherEffect, false)
                self.CurrentWeatherEffect = nil
            end
        end
    end

    self:StartIntervalThink(0.033)
end

function modifier_player_cosmetics:OnRefresh()
    self:OnCreated()
end

function modifier_player_cosmetics:CreatePet(PetModel, PetModelScale)
    if self.Hero then
        if self.hPet == nil then
            local RandomPos = self.Hero:GetAbsOrigin() + RandomVector(RandomFloat(150, 400))
            self.hPet = CreateUnitByName("cosmetic_pet", RandomPos, true, nil, nil, self.Hero:GetTeamNumber())
            self.hPet:AddNewModifier(self.Hero, nil, "modifier_player_cosmetics_pet", {model=PetModel})
            self.hPet:SetModelScale(PetModelScale)
        else
            self.hPet:AddNewModifier(self.Hero, nil, "modifier_player_cosmetics_pet", {model=PetModel})
            self.hPet:SetModelScale(PetModelScale)
        end
    end
end

function modifier_player_cosmetics:RemovePet()
    if self.hPet and not self.hPet:IsNull() and self.hPet:IsAlive() then
        UTIL_Remove(self.hPet)
        self.hPet = nil
        self.CurrentSelectedPet = nil
    end
end

function modifier_player_cosmetics:OnDestroy()
    if not IsServer() then return end

    self:RemovePet()
end

function modifier_player_cosmetics:OnIntervalThink()
    if self.Hero and self.hPet and not self.hPet:IsNull() and self.hPet:IsAlive() then
        local DistanceToOwner = CalculateDistance(self.hPet, self.Hero)
        local RandomPosNearOwner = self.Hero:GetAbsOrigin() + RandomVector(RandomFloat(150, 400))
        if DistanceToOwner >= self.DistanceToTeleport then
            if self.MoveCooldownCurrent <= GameRules:GetGameTime() then
                self.MoveCooldownCurrent = GameRules:GetGameTime() + self.MoveCooldown

                local CurrentPos = self.hPet:GetAbsOrigin()
                local fxStart = ParticleManager:CreateParticle(self.TeleportStartFxName, PATTACH_CUSTOMORIGIN, nil)
                ParticleManager:SetParticleControl(fxStart, 0, CurrentPos)
                ParticleManager:ReleaseParticleIndex(fxStart)

                self.hPet:Stop()
                FindClearSpaceForUnit(self.hPet, RandomPosNearOwner, true)

                local fxEnd = ParticleManager:CreateParticle(self.TeleportStartFxName, PATTACH_CUSTOMORIGIN, nil)
                ParticleManager:SetParticleControl(fxEnd, 0, RandomPosNearOwner)
                ParticleManager:ReleaseParticleIndex(fxEnd)
            end
        elseif DistanceToOwner >= self.DistanceToMove then
            if self.MoveCooldownCurrent <= GameRules:GetGameTime() then
                self.MoveCooldownCurrent = GameRules:GetGameTime() + self.MoveCooldown
                self.NextMoveTime = GameRules:GetGameTime() + self.TimeToMove

                local RandomPosForward = (self.Hero:GetAbsOrigin() + (self.Hero:GetForwardVector() * 400)) + RandomVector(RandomFloat(0, 200))

                self.hPet:MoveToPosition(RandomPosForward)
            end
        elseif self.NextMoveTime <= GameRules:GetGameTime() then
            self.NextMoveTime = GameRules:GetGameTime() + self.TimeToMove

            self.hPet:MoveToPosition(RandomPosNearOwner)
        end
    end
end

modifier_player_cosmetics_pet = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
            MODIFIER_PROPERTY_MODEL_CHANGE
        }
    end,
    CheckState              = function(self)
        return {
            [MODIFIER_STATE_INVULNERABLE] = true,
            [MODIFIER_STATE_NO_HEALTH_BAR] = true,
            [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
            [MODIFIER_STATE_UNSELECTABLE] = true,
            [MODIFIER_STATE_UNTARGETABLE] = true,
            [MODIFIER_STATE_MAGIC_IMMUNE] = true,
            [MODIFIER_STATE_OUT_OF_GAME] = true,
            [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true
        }
    end,

    GetDisableAutoAttack    = function(self) return 1 end,
    GetModifierModelChange  = function (self) return self.Model end,
})

function modifier_player_cosmetics_pet:OnCreated(table)
    self.Model = table.model or ""
end

function modifier_player_cosmetics_pet:OnRefresh(table)
    self:OnCreated(table)
end