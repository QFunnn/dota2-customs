--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_talent_blood_cooldown", "modifiers/talents/basic/modifier_woda_talent_blood", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_woda_talent_blood_barier", "modifiers/talents/basic/modifier_woda_talent_blood", LUA_MODIFIER_MOTION_NONE)

modifier_woda_talent_blood=class({})

function modifier_woda_talent_blood:IsHidden() return true end
function modifier_woda_talent_blood:IsPurgable() return false end
function modifier_woda_talent_blood:IsPurgeException() return false end
function modifier_woda_talent_blood:RemoveOnDeath() return false end

function modifier_woda_talent_blood:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:StartIntervalThink(1)
    self:OnIntervalThink()
end

function modifier_woda_talent_blood:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_woda_talent_blood:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():IsAlive() then return end
    if self:GetParent():HasModifier("modifier_woda_talent_blood_cooldown") then return end
    local modifier_woda_talent_blood_barier = self:GetParent():FindModifierByName("modifier_woda_talent_blood_barier")
    if modifier_woda_talent_blood_barier then
        modifier_woda_talent_blood_barier:Destroy()
    end
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_woda_talent_blood_cooldown", {duration = 20})
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_woda_talent_blood_barier", {})
end

function modifier_woda_talent_blood:UpdateShieldFast()
    if not self:GetParent():IsAlive() then return end
    local modifier_woda_talent_blood_barier = self:GetParent():FindModifierByName("modifier_woda_talent_blood_barier")
    if modifier_woda_talent_blood_barier then
        modifier_woda_talent_blood_barier:Destroy()
    end
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_woda_talent_blood_cooldown", {duration = 20})
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_woda_talent_blood_barier", {})
end 

modifier_woda_talent_blood_cooldown = class({})
function modifier_woda_talent_blood_cooldown:GetTexture() return "blood" end
function modifier_woda_talent_blood_cooldown:IsPurgable() return false end
function modifier_woda_talent_blood_cooldown:IsPurgeException() return false end
function modifier_woda_talent_blood_cooldown:IsDebuff() return true end
function modifier_woda_talent_blood_cooldown:RemoveOnDeath() return false end

modifier_woda_talent_blood_barier = class({})
function modifier_woda_talent_blood_barier:IsPurgable() return false end
function modifier_woda_talent_blood_barier:IsPurgeException() return false end
function modifier_woda_talent_blood_barier:GetTexture() return "blood" end
function modifier_woda_talent_blood_barier:IsHidden() return true end
function modifier_woda_talent_blood_barier:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.barrier = {100, 200}
	if not IsServer() then return end
	self.max_shield = self.barrier[self:GetCaster():GetTalentLevel("modifier_woda_talent_blood")]
	self.current_shield = self.barrier[self:GetCaster():GetTalentLevel("modifier_woda_talent_blood")]
	self:SetHasCustomTransmitterData( true )
end

function modifier_woda_talent_blood_barier:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield
	}
	return data
end

function modifier_woda_talent_blood_barier:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_woda_talent_blood_barier:UpdateShieldFast()
    self.max_shield = self.barrier[self:GetCaster():GetTalentLevel("modifier_woda_talent_blood")]
	self.current_shield = self.barrier[self:GetCaster():GetTalentLevel("modifier_woda_talent_blood")]
    self:SendBuffRefreshToClients()
end 

function modifier_woda_talent_blood_barier:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
	return funcs
end

function modifier_woda_talent_blood_barier:GetModifierIncomingDamageConstant( params )
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