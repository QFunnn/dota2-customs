--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_techies_2 = class({})

function modifier_techies_2:IsHidden() return true end
function modifier_techies_2:IsPurgable() return false end
function modifier_techies_2:IsPurgeException() return false end
function modifier_techies_2:RemoveOnDeath() return false end

function modifier_techies_2:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self.max_shield = self:GetParent():GetMaxHealth()
	self.current_shield = self:GetParent():GetMaxHealth()
    self.shield_regen_cooldown = 0
	self:SetHasCustomTransmitterData( true )
    self:StartIntervalThink(FrameTime())
    self:GetCaster():RemoveModifierByName("modifier_techies_reactive_tazer_custom")
    local techies_reactive_tazer_custom = self:GetCaster():FindAbilityByName("techies_reactive_tazer_custom")
    if techies_reactive_tazer_custom then
        techies_reactive_tazer_custom:SetActivated(false)
        techies_reactive_tazer_custom:SetHidden(true)
    end
end

function modifier_techies_2:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_techies_2:OnIntervalThink()
    if not IsServer() then return end
    local max_health = self:GetParent():GetMaxHealth()
    local current_health = self:GetParent():GetHealth()
    self.max_shield = max_health * 0.1
    if self.current_shield > self.max_shield then
        self.current_shield = self.max_shield
    end
    if self.current_shield < self.max_shield then
        self.shield_regen_cooldown = self.shield_regen_cooldown + FrameTime()
        local shield_regen = {0.5,0.75,1}
        local regen_shield_point = (max_health / 100 * shield_regen[self:GetStackCount()]) * 0.1
        if self:GetParent():HasModifier("modifier_wodarelax") then
            regen_shield_point = self.max_shield
        end
        if self.shield_regen_cooldown >= 0.1 then
            self.current_shield = math.min(self.current_shield + regen_shield_point, self.max_shield)
            self.shield_regen_cooldown = 0
        end
    end
    self:SendBuffRefreshToClients()
end

function modifier_techies_2:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield
	}
	return data
end

function modifier_techies_2:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_techies_2:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
        MODIFIER_EVENT_ON_RESPAWN
	}
	return funcs
end

function modifier_techies_2:OnRespawn( params )
    if params.unit == self:GetParent() then
        self.current_shield = self.max_shield
        self:SendBuffRefreshToClients()
    end
end

function modifier_techies_2:GetModifierIncomingDamageConstant( params )
	if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.current_shield
		end
	end
	if params.damage >= self.current_shield then
        local ignore_damage = self.current_shield
        self.current_shield = 0
        self:SendBuffRefreshToClients()
		return -ignore_damage
	else
		self.current_shield = self.current_shield-params.damage
		self:SendBuffRefreshToClients()
		return -params.damage
	end
end