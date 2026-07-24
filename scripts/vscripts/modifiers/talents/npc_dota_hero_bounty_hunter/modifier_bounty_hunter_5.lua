--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_bounty_hunter_5=class({})

function modifier_bounty_hunter_5:IsHidden() return true end
function modifier_bounty_hunter_5:IsPurgable() return false end
function modifier_bounty_hunter_5:IsPurgeException() return false end
function modifier_bounty_hunter_5:RemoveOnDeath() return false end

function modifier_bounty_hunter_5:OnCreated()
	if not IsServer() then return end
    self.damage = 0
    self.bonus = 100
	self:SetStackCount(1)
    self:StartIntervalThink(0.5)
    self:SetHasCustomTransmitterData( true )
    self:SendBuffRefreshToClients()
end

function modifier_bounty_hunter_5:OnRefresh()
	if not IsServer() then return end
    self.bonus = 100
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_bounty_hunter_5:OnIntervalThink()
    if not IsServer() then return end
    local count = 0
    local units = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
    for _, unit in pairs(units) do
        if unit and unit:IsAlive() and unit:GetUnitName() == "npc_dota_bounty_hunter_gold_bag" then
            count = count + 1
        end
    end
    self.damage = self.bonus * count
    self:SendBuffRefreshToClients()
end

function modifier_bounty_hunter_5:AddCustomTransmitterData()
	local data = 
    {
		damage = self.damage,
	}
	return data
end

function modifier_bounty_hunter_5:HandleCustomTransmitterData( data )
	self.damage = data.damage
end

function modifier_bounty_hunter_5:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
end

function modifier_bounty_hunter_5:GetModifierPreAttack_BonusDamage()
    return self.damage
end