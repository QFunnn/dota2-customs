--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_aegis = class({})

function modifier_aegis:IsHidden() return self:GetStackCount() <= 0 end
function modifier_aegis:GetTexture() return "item_aegis" end
function modifier_aegis:IsPermanent() return true end
function modifier_aegis:IsPurgable() return false end

function modifier_aegis:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_REINCARNATION,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_aegis:Reincarnate()
    local hCaster = self:GetParent()
    local hAbility = self:GetAbility()
	Timers:CreateTimer({ endTime = AEGIS_REINCARNATE_DELAY, callback = function()
        local nParticle = ParticleManager:CreateParticle("particles/items_fx/aegis_respawn_timer.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
        ParticleManager:SetParticleControl(nParticle, 1, Vector(0, 0, 0))
        ParticleManager:SetParticleControl(nParticle, 3, hCaster:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(nParticle)
    end})

	Util:RefreshAbilityAndItem( hCaster )
	Timers:CreateTimer({ endTime = AEGIS_REINCARNATE_DELAY+0.3, callback = function()
		hCaster:AddNewModifier(hCaster, hAbility, "modifier_aegis_buff", {duration=AEGIS_REINCARNATE_BUFF_DURATION})
	end})

    self:DecrementStackCount()
    HeroBuilder:UpdatePlayerLifesCount(self:GetParent():GetPlayerOwnerID(), -1, "add")
end

function modifier_aegis:GetModifierIncomingDamage_Percentage(params)
    local nPlayerID
    if self:GetParent().GetPlayerOwnerID then
        nPlayerID = self:GetParent():GetPlayerOwnerID()
    end
	if nPlayerID and PlayerResource:GetConnectionState(nPlayerID) == DOTA_CONNECTION_STATE_ABANDONED then
        return 5000
    end
end

function modifier_aegis:ReincarnateTime()
    if not IsServer() then return end
	local nPlayerID
    if self:GetParent().GetPlayerOwnerID then
       nPlayerID = self:GetParent():GetPlayerOwnerID()
    end
    if nPlayerID and PlayerResource:GetConnectionState(nPlayerID) == DOTA_CONNECTION_STATE_ABANDONED then return end
    
    if nPlayerID == nil then return end
     
    -- Если игрок на дуэли, запрещаем перерождение
    if Rounds:IsPlayerInPVPDuel(nPlayerID) then return end

    if not Players:IsActivePlayer(nPlayerID) then return end

    if Rounds:RoundTypeIs(ROUND_TYPES.VOTING) then return end

    if self:GetStackCount() <= 0 then return end

    self:Reincarnate()

	return AEGIS_REINCARNATE_DELAY
end
