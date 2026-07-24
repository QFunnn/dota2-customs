--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skywrath_mage_16_cooldown", "modifiers/talents/npc_dota_hero_skywrath_mage/modifier_skywrath_mage_16", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_16_barier", "modifiers/talents/npc_dota_hero_skywrath_mage/modifier_skywrath_mage_16", LUA_MODIFIER_MOTION_NONE)

modifier_skywrath_mage_16=class({})

function modifier_skywrath_mage_16:IsHidden() return true end
function modifier_skywrath_mage_16:IsPurgable() return false end
function modifier_skywrath_mage_16:IsPurgeException() return false end
function modifier_skywrath_mage_16:RemoveOnDeath() return false end

function modifier_skywrath_mage_16:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:StartIntervalThink(1)
    self:OnIntervalThink()
end

function modifier_skywrath_mage_16:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_skywrath_mage_16:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():IsAlive() then return end
    if self:GetParent():HasModifier("modifier_skywrath_mage_16_cooldown") then return end
    local modifier_skywrath_mage_16_barier = self:GetParent():FindModifierByName("modifier_skywrath_mage_16_barier")
    if modifier_skywrath_mage_16_barier then
        modifier_skywrath_mage_16_barier:Destroy()
    end
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_skywrath_mage_16_cooldown", {duration = 20})
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_skywrath_mage_16_barier", {})
end

function modifier_skywrath_mage_16:UpdateShieldFast()
    if not self:GetParent():IsAlive() then return end
    local modifier_skywrath_mage_16_barier = self:GetParent():FindModifierByName("modifier_skywrath_mage_16_barier")
    if modifier_skywrath_mage_16_barier then
        modifier_skywrath_mage_16_barier:Destroy()
    end
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_skywrath_mage_16_cooldown", {duration = 20})
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_skywrath_mage_16_barier", {})
end 

modifier_skywrath_mage_16_cooldown = class({})
function modifier_skywrath_mage_16_cooldown:GetTexture() return "skywrath_mage_16" end
function modifier_skywrath_mage_16_cooldown:IsPurgable() return false end
function modifier_skywrath_mage_16_cooldown:IsPurgeException() return false end
function modifier_skywrath_mage_16_cooldown:IsDebuff() return true end
function modifier_skywrath_mage_16_cooldown:RemoveOnDeath() return false end

modifier_skywrath_mage_16_barier = class({})
function modifier_skywrath_mage_16_barier:IsPurgable() return false end
function modifier_skywrath_mage_16_barier:IsPurgeException() return false end
function modifier_skywrath_mage_16_barier:GetTexture() return "skywrath_mage_16" end
function modifier_skywrath_mage_16_barier:IsHidden() return true end
function modifier_skywrath_mage_16_barier:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.barrier = {100, 200}
	if not IsServer() then return end
	self.max_shield = self.barrier[self:GetCaster():GetTalentLevel("modifier_skywrath_mage_16")]
	self.current_shield = self.barrier[self:GetCaster():GetTalentLevel("modifier_skywrath_mage_16")]
	self:SetHasCustomTransmitterData( true )
end

function modifier_skywrath_mage_16_barier:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield
	}
	return data
end

function modifier_skywrath_mage_16_barier:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_skywrath_mage_16_barier:UpdateShieldFast()
    self.max_shield = self.barrier[self:GetCaster():GetTalentLevel("modifier_skywrath_mage_16")]
	self.current_shield = self.barrier[self:GetCaster():GetTalentLevel("modifier_skywrath_mage_16")]
    self:SendBuffRefreshToClients()
end 

function modifier_skywrath_mage_16_barier:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
	return funcs
end

function modifier_skywrath_mage_16_barier:GetModifierIncomingDamageConstant( params )
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