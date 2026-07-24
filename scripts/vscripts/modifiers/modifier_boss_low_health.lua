--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_boss_low_health = class({})
function modifier_boss_low_health:IsPurgable() return false end
function modifier_boss_low_health:IsHidden() return self:GetStackCount() == 1 end
function modifier_boss_low_health:IsPurgeException() return false end
function modifier_boss_low_health:GetTexture() return "item_aeon_disk" end

function modifier_boss_low_health:OnCreated(kv)
    if not IsServer() then return end
    kv = kv or {}
    self.max_health = self:GetParent():GetMaxHealth()
    self.charge_counter = math.max(1, tonumber(kv.stages) or tonumber(kv.charge_counter) or 4)
    self.max_charge_counter = self.charge_counter
    self.invul_duration = 1
    self.new_charge_health = math.max(1, math.floor(self.max_health / self.charge_counter))
    self.max_health = math.floor(self.new_charge_health * self.charge_counter)
    self:GetParent():SetBaseMaxHealth(self.new_charge_health)
    self:GetParent():SetMaxHealth(self.new_charge_health)
    self:GetParent():SetHealth(self.new_charge_health)
end

function modifier_boss_low_health:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
		MODIFIER_PROPERTY_MIN_HEALTH,
	}
end

function modifier_boss_low_health:GetModifierTotal_ConstantBlock(params)
    if not IsServer() then return 0 end
    if self.charge_counter <= 1 then return 0 end
    if not params.damage or params.damage <= 0 then return 0 end
    local parent = self:GetParent()
    local hp = parent:GetHealth()
    if hp - params.damage < 1 then
        return params.damage - (hp - 1)
    end
end

function modifier_boss_low_health:GetMinHealth()
    if self.charge_counter <= 1 then return end
    return 1
end

function modifier_boss_low_health:OnTakeDamage(params)
	if not IsServer() then return end
	if self:GetParent() ~= params.unit then return end
	if not params.attacker then return end
	if not self:GetParent():IsAlive() then return end
	if self.charge_counter <= 1 then return end
	if self:GetParent():HasModifier("modifier_boss_low_health_buff") then return end
    if self:GetParent():GetHealth() > 1 then return end
	self:GetParent():Purge( false, true, false, true, true )
	self:GetParent():EmitSound("DOTA_Item.ComboBreaker")
	self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_boss_low_health_buff", {duration = self.invul_duration})
    self:GetParent():SetHealth(self.new_charge_health)
    self.charge_counter = math.max(self.charge_counter - 1, 1)
    local modifier_boss_shadow_fiend_passive_dark_cyclone = self:GetParent():FindModifierByName("modifier_boss_shadow_fiend_passive_dark_cyclone")
    if modifier_boss_shadow_fiend_passive_dark_cyclone and self.charge_counter <= 4 and not modifier_boss_shadow_fiend_passive_dark_cyclone.activated then
        modifier_boss_shadow_fiend_passive_dark_cyclone.activated = true
        modifier_boss_shadow_fiend_passive_dark_cyclone:Start() 
    end
end

function modifier_boss_low_health:AddStages(stages)
    self.charge_counter = self.charge_counter + stages
end

modifier_boss_low_health_buff = class({})
function modifier_boss_low_health_buff:IsPurgable() return false end
function modifier_boss_low_health_buff:IsPurgeException() return false end
function modifier_boss_low_health_buff:GetTexture() return "item_aeon_disk" end

function modifier_boss_low_health_buff:OnCreated(kv)
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle("particles/items4_fx/combo_breaker_buff.vpcf", PATTACH_POINT_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
	self:AddParticle(particle, false, false, -1, true, false)
end

function modifier_boss_low_health_buff:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	}
end

function modifier_boss_low_health_buff:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_boss_low_health_buff:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_boss_low_health_buff:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_boss_low_health_buff:GetModifierStatusResistanceStacking()
	return 75
end