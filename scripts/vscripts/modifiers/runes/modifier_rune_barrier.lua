--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_rune_barrier_cooldown", "modifiers/runes/modifier_rune_barrier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_rune_barrier_barier", "modifiers/runes/modifier_rune_barrier", LUA_MODIFIER_MOTION_NONE)

modifier_rune_barrier=class({})

function modifier_rune_barrier:IsHidden() return true end
function modifier_rune_barrier:IsPurgable() return false end
function modifier_rune_barrier:IsPurgeException() return false end
function modifier_rune_barrier:RemoveOnDeath() return false end

function modifier_rune_barrier:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:StartIntervalThink(1)
    self:OnIntervalThink()
end

function modifier_rune_barrier:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_rune_barrier:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():IsAlive() then return end
    if self:GetParent():HasModifier("modifier_rune_barrier_cooldown") then return end
    local modifier_rune_barrier_barier = self:GetParent():FindModifierByName("modifier_rune_barrier_barier")
    if modifier_rune_barrier_barier then
        modifier_rune_barrier_barier:Destroy()
    end
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_rune_barrier_cooldown", {duration = 20})
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_rune_barrier_barier", {})
end

function modifier_rune_barrier:UpdateShieldFast()
    if not self:GetParent():IsAlive() then return end
    local modifier_rune_barrier_barier = self:GetParent():FindModifierByName("modifier_rune_barrier_barier")
    if modifier_rune_barrier_barier then
        modifier_rune_barrier_barier:Destroy()
    end
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_rune_barrier_cooldown", {duration = 20})
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_rune_barrier_barier", {})
end 

modifier_rune_barrier_cooldown = class({})
function modifier_rune_barrier_cooldown:GetTexture() return "rune_barrier" end
function modifier_rune_barrier_cooldown:IsPurgable() return false end
function modifier_rune_barrier_cooldown:IsPurgeException() return false end
function modifier_rune_barrier_cooldown:IsDebuff() return true end
function modifier_rune_barrier_cooldown:RemoveOnDeath() return false end

modifier_rune_barrier_barier = class({})
function modifier_rune_barrier_barier:IsPurgable() return false end
function modifier_rune_barrier_barier:IsPurgeException() return false end
function modifier_rune_barrier_barier:GetTexture() return "rune_barrier" end
function modifier_rune_barrier_barier:IsHidden() return true end
function modifier_rune_barrier_barier:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.barrier = {10,20,30}
	if not IsServer() then return end
	self.max_shield = (self:GetParent():GetMaxMana() + self:GetParent():GetMaxHealth()) / 100 * self.barrier[self:GetCaster():GetTalentLevel("modifier_rune_barrier")]
	self.current_shield = self.max_shield
	self:SetHasCustomTransmitterData( true )
end

function modifier_rune_barrier_barier:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield
	}
	return data
end

function modifier_rune_barrier_barier:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_rune_barrier_barier:UpdateShieldFast()
    self.max_shield = (self:GetParent():GetMaxMana() + self:GetParent():GetMaxHealth()) / 100 * self.barrier[self:GetCaster():GetTalentLevel("modifier_rune_barrier")]
	self.current_shield = self.max_shield
    self:SendBuffRefreshToClients()
end 

function modifier_rune_barrier_barier:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
	return funcs
end

function modifier_rune_barrier_barier:GetModifierIncomingDamageConstant( params )
	if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.current_shield
		end
	end
	if params.damage >= self.current_shield then
        local shield = self.current_shield
		self:Destroy()
		return -shield
	else
		self.current_shield = self.current_shield-params.damage
		self:SendBuffRefreshToClients()
		return -params.damage
	end
end