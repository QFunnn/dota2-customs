--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_creep_controll = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsPermanent             = function(self) return true end,
    GetAttributes           = function(self) return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_IGNORE_DODGE + MODIFIER_ATTRIBUTE_PERMANENT end,

    IsBerserked             = function(self) return self:GetStackCount() > 0 end,

    DeclareFunctions        = function(self)
        return
        {
            MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
            MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
            MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
            MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
            MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
            MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
            MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,
            MODIFIER_PROPERTY_MODEL_SCALE,
            MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
        }
    end,

    CheckState              = function(self)
        -- Беспрепятственное передвижение активируется в двух случаях:
        -- 1. При берсерке (GetStackCount() > 0).
        -- 2. Для крипов, заспавненных на 60+ раунде — даже до берсерка
        --    (по задаче #45 из tasks.txt: чтобы крипы не зависали на 60+).
        local lateRoundFreeMove = (self.SpawnRound or 0) >= 60
        return {
            [MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = (self.FullMove == 1 or self:GetStackCount() > 0 or lateRoundFreeMove),
            [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = (self:GetStackCount() > 0 or lateRoundFreeMove),
            [MODIFIER_STATE_CANNOT_MISS] = self:GetStackCount() > 0,
        }
    end,

    -- IsAura                  = function(self) return true end,
    -- GetModifierAura         = function(self) return "modifier_truesight" end,
    -- GetAuraRadius           = function(self) return 2500 end,
    -- GetAuraDuration         = function(self) return 0.5 end,
    -- GetAuraSearchFlags      = function(self) return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE end,
    -- GetAuraSearchTeam       = function(self) return DOTA_UNIT_TARGET_TEAM_ENEMY end,
    -- GetAuraSearchType       = function(self) return DOTA_UNIT_TARGET_ALL end,
    
    OnCreated               = function(self, table)
        self.UnitName = self:GetParent():GetUnitName()

        if not IsServer() then return end

        self.UpgradeStacks = table.upgrader_stacks or 0
        self.SpellAmplifyStacks = table.spell_amplify_stacks or 0
        self.ResistStacks = table.resist_stacks or 0
        self.FullMove = table.full_move or 0
        self.SpawnRound = table.spawn_round or 0
        self.TeamID = table.team_id
        -- self.TrueSight = table.true_sight or 0

        -- if self.TrueSight == 1 then
        --     self:ApplyTruesightParticle()
        -- end

        self.LateResist = 0
        self.MagicResistancePerLateRound = GetGameSetting("CREEP_BONUS_MAGIC_RESISTANCE_PER_LATE_ROUND")

        self:SetHasCustomTransmitterData(true)
    end,

    OnRoundOverTime         = function(self, LateResist)
        -- self.TrueSight = 1

        -- self:ApplyTruesightParticle()

        if self.bBerserkFxCreated == nil then
            self.bBerserkFxCreated = true
            local Parent = self:GetParent()
            if Parent and not Parent:IsNull() and Parent:IsAlive() then
                self:AddParticle(ParticleManager:CreateParticle("particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, Parent), true, false, -1, false, true)
            end
        end

        self:OnIntervalThink()
        self:StartIntervalThink(1)

        if LateResist == true then
            self.LateResist = 1
        end

        self:SendBuffRefreshToClients()
    end,

    OnIntervalThink         = function(self)
        local Parent = self:GetParent()
        if not Parent or Parent:IsNull() or not Parent:IsAlive() then
            self:StartIntervalThink(-1)
            return
        end

        self:IncrementStackCount()

        if self:GetStackCount()>60 then
            -- [проклятие] Радиус — на ВСЮ арену: бьём ВСЕХ героев (и их юнитов) КОМАНДЫ
            -- этого крипа, где бы они ни были, а не в растущем кольце. Привязка к игрокам
            -- команды (а не к радиусу) => от проклятия нельзя убежать и не задевает чужие
            -- команды. Урон рамповый, как раньше: 0.5% от макс.HP × (стаки-60) в секунду.
            local dmgMul = self:GetStackCount() - 60

            -- Множество PlayerID команды этого крипа.
            local teamPlayers = nil
            if self.TeamID then
                local active = Players:GetTeamActivePlayers(self.TeamID)
                if active then
                    teamPlayers = {}
                    for pid, _ in pairs(active) do teamPlayers[pid] = true end
                end
            end

            local enemies = FindUnitsInRadius(
                DOTA_TEAM_NEUTRALS,
                Parent:GetOrigin(),
                Parent,
                -- по сути «вся карта»; конкретную команду фильтруем ниже по PlayerID
                (teamPlayers ~= nil) and 25000 or (350 + dmgMul*5),
                DOTA_UNIT_TARGET_TEAM_ENEMY,
                DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,
                FIND_ANY_ORDER,
                false
            )
            for _,hEnemy in ipairs(enemies) do
                if hEnemy and (not hEnemy:HasModifier("modifier_hero_refreshing"))
                    -- если знаем команду — бьём только её игроков (и их юнитов);
                    -- иначе (нет team_id, старый крип) — старое поведение по радиусу.
                    and (teamPlayers == nil or teamPlayers[hEnemy:GetPlayerOwnerID()]) then
                    ApplyDamage({
                        attacker = Parent,
                        victim = hEnemy,
                        damage_type = DAMAGE_TYPE_PURE,
                        damage = hEnemy:GetMaxHealth() * 0.005 * dmgMul,
                        damage_flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_BYPASSES_INVULNERABILITY,
                        ability = Bans:GetDebuffImmuneAbility()
                    })
                end
            end
        end
    end,

    ApplyTruesightParticle  = function(self)
        -- if self.bTrueSightFxCreated == nil then
        --     self.bTrueSightFxCreated = true
        --     local Parent = self:GetParent()
        --     if Parent and not Parent:IsNull() and Parent:IsAlive() then
        --         self:AddParticle(ParticleManager:CreateParticle("particles/econ/wards/f2p/f2p_ward/f2p_ward_true_sight_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, Parent), true, false, -1, false, true)
        --     end
        -- end
    end,

    AddCustomTransmitterData    = function(self)
        self.TransmitterTable = self.TransmitterTable or {}

        self.TransmitterTable.MagicResistancePerLateRound = self.MagicResistancePerLateRound
        self.TransmitterTable.UpgradeStacks = self.UpgradeStacks
        self.TransmitterTable.SpellAmplifyStacks = self.SpellAmplifyStacks
        self.TransmitterTable.ResistStacks = self.ResistStacks
        self.TransmitterTable.FullMove = self.FullMove
        self.TransmitterTable.SpawnRound = self.SpawnRound

        return self.TransmitterTable
    end,

    HandleCustomTransmitterData = function(self, data)
        self.MagicResistancePerLateRound = data.MagicResistancePerLateRound
        self.UpgradeStacks = data.UpgradeStacks
        self.SpellAmplifyStacks = data.SpellAmplifyStacks
        self.ResistStacks = data.ResistStacks
        self.FullMove = data.FullMove
        self.SpawnRound = data.SpawnRound
        -- self.TrueSight = data.TrueSight
    end,

    AttackLandedModifier        = function(self, event)
        if IsServer() and self:GetStackCount() > 0 then
            local Parent = self:GetParent()
            local Attacker = event.attacker
            local Target = event.target
            if Parent and Parent == Attacker and Target then
                Target:AddNewModifier(Target, nil, "modifier_creep_controll_berserk_debuff", {duration=12})
            end
        end
    end,

    GetModifierMoveSpeedBonus_Constant          = function(self) return CREEP_BONUS_MOVE_SPEED_PER_LATE_ROUND * self.UpgradeStacks end,
    GetModifierDamageOutgoing_Percentage        = function(self) return self:GetStackCount() * 15 end,
    GetModifierMoveSpeed_AbsoluteMin            = function(self) 
        if self:GetStackCount() > 0 then
            local Parent = self:GetParent()
            if Parent and not Parent:IsNull() then
                return Parent:GetBaseMoveSpeed()+math.floor(Parent:GetBaseMoveSpeed() * self:GetStackCount() * 0.05) 
            end
        end
        return 0
    end,
    GetModifierModelScale                       = function(self) 
        if self:GetStackCount() > 0 then
            if self.UnitName == "npc_dota_roshan" then return 25 end
            if self.UnitName == "npc_dota_nian" then return 25 end
            
            return 55
        end
        return 0
    end,
    GetModifierAttackSpeedBonus_Constant        = function(self) return (CREEP_BONUS_ATTACK_SPEED_PER_LATE_ROUND * self.UpgradeStacks) + (self:GetStackCount() * 5) end,
    GetModifierMagicalResistanceBonus           = function(self) 
        local Bonus = self.MagicResistancePerLateRound * self.UpgradeStacks
        -- Убрали бонус к магическому сопротивлению от берсерка
        return Bonus
    end,
    GetModifierStatusResistanceStacking         = function(self) 
        local Bonus = 0
        if self:GetStackCount() > 0 then
            local BerserkBonus = 25
            if self.LateResist == 0 then
                if self.UnitName == "npc_dota_roshan" then BerserkBonus = 0 end
                if self.UnitName == "npc_dota_nian" then BerserkBonus = 0 end
                if self.UnitName == "npc_dota_granite_golem" then BerserkBonus = 0 end
            end
            Bonus = Bonus + BerserkBonus
        end

        return Bonus
    end,
    GetModifierSpellAmplify_Percentage          = function(self) return 9 * self.SpellAmplifyStacks end,
    GetModifierIncomingDamage_Percentage        = function(self) return -1 * self.ResistStacks end,
})

modifier_creep_controll_berserk_debuff = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsDebuff                = function(self) return true end,
    GetTexture              = function(self) return "item_desolator" end,

    DeclareFunctions        = function(self)
        return
        {
            MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        }
    end,

    GetModifierPhysicalArmorBonus       = function(self)
        return -1 * self:GetStackCount()
    end,

    OnCreated               = function(self)
        if not IsServer() then return end

        self:OnRefresh()
    end,

    OnRefresh               = function(self)
        if not IsServer() then return end

        self:IncrementStackCount()
    end,
})