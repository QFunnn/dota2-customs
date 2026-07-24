--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_minigames_unit = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

    CheckState              = function(self)
        return {
            [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
            [MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
        }
    end,

	DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_HEALTHBAR_PIPS,
            MODIFIER_PROPERTY_ALWAYS_AUTOATTACK_WHILE_HOLD_POSITION,
        }
    end,

	GetModifierHealthBarPips = function(self)
		return self:GetParent():GetMaxHealth()/2
	end,

	GetAlwaysAutoAttackWhileHoldPosition = function(self)
		return 0
	end,
})

function modifier_minigames_unit:OnCreated(table)
    if not IsServer() then return end
    local TeamID = table.team

    if TeamID == nil then return end

    local TeamColor = GameMode:GetTeamColor(TeamID)

    if TeamColor == nil then return end

    local fx = ParticleManager:CreateParticle("particles/boss_lightning.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(fx, 1, self:GetParent(), PATTACH_OVERHEAD_FOLLOW, "", Vector(0,0,0), true)
    ParticleManager:SetParticleControl(fx, 3, Vector(TeamColor[1],TeamColor[2],TeamColor[3]))
    ParticleManager:SetParticleControl(fx, 4, Vector(75, 0, 0))

    local fTeamPlayerID, PlayerInfo = Players:GetTeamPlayerByNum(TeamID, 1)
    if fTeamPlayerID and PlayerInfo then
        if Players:IsValidHero(PlayerInfo.hero) then
            local HeroInfo = KeyValues:GetHero(PlayerInfo.hero:GetUnitName())
            if HeroInfo then
                local Icon = HeroInfo.minimap_icon_id
                if Icon > -1 then
                    ParticleManager:SetParticleControl(fx, 2, Vector(Icon,32,0))
                end
            end
        end
    end

    self:AddParticle(fx, false, false, -1, false, true)

    local TeamFx = ParticleManager:CreateParticleForTeam("particles/boss_lightning_team.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), TeamID)
    ParticleManager:SetParticleControl(TeamFx, 3, Vector(TeamColor[1],TeamColor[2],TeamColor[3]))
    ParticleManager:SetParticleControl(TeamFx, 4, Vector(75, 0, 0))
    self:AddParticle(TeamFx, false, false, -1, false, false)

    local WinBuffs = table.win_buffs
    if WinBuffs ~= nil and WinBuffs < 100 then
        local Digits = extractDigits(WinBuffs)
        local fDigit = Digits[1]
        local sDigit = Digits[2]
        
        local iIsTwoDigits = fDigit > 0 and 1 or 0
        local WinFx = ParticleManager:CreateParticle("particles/minigames/win_buff_counter/win_buff_counter.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControl(WinFx, 3, Vector(0,0,250))
        ParticleManager:SetParticleControl(WinFx, 1, Vector(iIsTwoDigits, sDigit, 0))
        ParticleManager:SetParticleControl(WinFx, 2, Vector(iIsTwoDigits, fDigit, 0))
        self:AddParticle(WinFx, false, false, -1, false, false)
    end


    self.SpecialInterval = 0

    self:StartIntervalThink(0.01)
end

function modifier_minigames_unit:OnIntervalThink()
    if not IsServer() then return end
    
    if GameRules:GetGameTime() >= self.SpecialInterval then
        self.SpecialInterval = GameRules:GetGameTime() + FrameTime()
        CustomGameEventManager:Send_ServerToAllClients("set_player_icon", { entity = self:GetParent():entindex(), hero = self:GetCaster():entindex() })
    end

    for _, modif in ipairs(self:GetParent():FindAllModifiers()) do
        if modif:GetAuraOwner() ~= nil then
            modif:Destroy()
        end
    end
end