--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_meepo_boss_h_aura", "modifiers/modifier_meepo_boss_h", LUA_MODIFIER_MOTION_NONE)

modifier_meepo_boss_h = class({})

function modifier_meepo_boss_h:IsHidden() return true end
function modifier_meepo_boss_h:IsPurgable() return false end

function modifier_meepo_boss_h:IsAura() return true end

function modifier_meepo_boss_h:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_BOTH end

function modifier_meepo_boss_h:GetAuraSearchType()
    return DOTA_UNIT_TARGET_ALL
end

function modifier_meepo_boss_h:GetModifierAura()
    return "modifier_meepo_boss_h_aura"
end

function modifier_meepo_boss_h:GetAuraRadius()
    return -1
end

function modifier_meepo_boss_h:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_meepo_boss_h:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end

function modifier_meepo_boss_h:OnIntervalThink()
    if not IsServer() then return end
    for i=1,24 do
        AddFOWViewer(i, self:GetCaster():GetAbsOrigin(), 1200, 0.1, true)
    end
end

function modifier_meepo_boss_h:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH, MODIFIER_PROPERTY_PROVIDES_FOW_POSITION, MODIFIER_PROPERTY_MODEL_SCALE
	}
end
function modifier_meepo_boss_h:CheckState()
	return 
	{
		[MODIFIER_STATE_PROVIDES_VISION] = true,
	}
end

function modifier_meepo_boss_h:GetModifierProvidesFOWVision()
	return 1
end

function modifier_meepo_boss_h:OnDeath(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    self:Destroy()
end

function modifier_meepo_boss_h:GetModifierModelScale( params )
    return 140
end

modifier_meepo_boss_h_aura = class({})

function modifier_meepo_boss_h_aura:IsHidden() return true end

function modifier_meepo_boss_h_aura:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
	local health = self:GetCaster():GetHealth()
	local max_health = self:GetCaster():GetMaxHealth()
	local unit_name = self:GetCaster():GetUnitName()
end

function modifier_meepo_boss_h_aura:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_meepo_boss_h_aura:GetModifierTotalDamageOutgoing_Percentage(params)
    if self:GetParent() ~= self:GetCaster() then
        if params.target ~= self:GetCaster() then
            return -100
        end
    end
end

function modifier_meepo_boss_h_aura:OnIntervalThink()
	if not IsServer() then return end
	local health = self:GetCaster():GetHealth()
	local max_health = self:GetCaster():GetMaxHealth()
	local unit_name = self:GetCaster():GetUnitName()
	local persentage = self:GetCaster():GetHealthPercent() / 100
	if PlayerResource:GetPlayer(self:GetParent():GetPlayerOwnerID()) then 
		CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetParent():GetPlayerOwnerID()), "event_woda_boss_health_bar_update", {health = health, max_health = max_health, unit_name = unit_name, hp = persentage, })
	end
	if self:GetParent():CanEntityBeSeenByMyTeam(self:GetCaster()) and self:GetCaster():IsAlive() then
		if PlayerResource:GetPlayer(self:GetParent():GetPlayerOwnerID()) then 
			local health = self:GetCaster():GetHealth()
			local max_health = self:GetCaster():GetMaxHealth()
			local unit_name = self:GetCaster():GetUnitName()
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetParent():GetPlayerOwnerID()), "event_woda_boss_health_bar_start", {health = health, max_health = max_health, unit_name = unit_name, })
		end
	else
		if PlayerResource:GetPlayer(self:GetParent():GetPlayerOwnerID()) then 
			CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetParent():GetPlayerOwnerID()), "event_woda_boss_health_bar_end", {})
		end
	end
end

function modifier_meepo_boss_h_aura:OnDestroy()
	if not IsServer() then return end
	local max_health = self:GetParent():GetMaxHealth()
	if PlayerResource:GetPlayer(self:GetParent():GetPlayerOwnerID()) then 
		CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetParent():GetPlayerOwnerID()), "event_woda_boss_health_bar_update", {health = 0, max_health = max_health, unit_name = unit_name, hp = 0, })
	end
	if PlayerResource:GetPlayer(self:GetParent():GetPlayerOwnerID()) then 
		CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetParent():GetPlayerOwnerID()), "event_woda_boss_health_bar_end", {})
	end
end