--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_nevermore_6=class({})

function modifier_nevermore_6:IsHidden() return true end
function modifier_nevermore_6:IsPurgable() return false end
function modifier_nevermore_6:IsPurgeException() return false end
function modifier_nevermore_6:RemoveOnDeath() return false end

function modifier_nevermore_6:OnCreated()
	self.bonus={400,300,200}
	if not IsServer() then return end
	self:SetStackCount(1)
	if self:GetParent():HasAbility("nevermore_shadowraze1_custom") then
		self:GetParent():RemoveAbility("nevermore_shadowraze1_custom")
		self:GetParent():RemoveAbilityFromIndexByName( "nevermore_shadowraze1_custom" )
	end
	if self:GetParent():HasAbility("nevermore_shadowraze2_custom") then
		self:GetParent():RemoveAbility("nevermore_shadowraze2_custom")
		self:GetParent():RemoveAbilityFromIndexByName( "nevermore_shadowraze2_custom" )
	end
	if self:GetParent():HasAbility("nevermore_shadowraze3_custom") then
		self:GetParent():RemoveAbility("nevermore_shadowraze3_custom")
		self:GetParent():RemoveAbilityFromIndexByName( "nevermore_shadowraze3_custom" )
	end
	self:StartIntervalThink(0.1)
    self:SetHasCustomTransmitterData(true)
end

function modifier_nevermore_6:OnRefresh()
	self.bonus={400,300,200}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_nevermore_6:OnIntervalThink()
	if not IsServer() then return end
	self.amp_damage = self:GetParent():GetMaxHealth() / self.bonus[self:GetStackCount()]
    self:SendBuffRefreshToClients()
end

function modifier_nevermore_6:AddCustomTransmitterData()
    return 
    {
        amp_damage = self.amp_damage,
    }
end

function modifier_nevermore_6:HandleCustomTransmitterData( data )
    self.amp_damage = data.amp_damage
end

function modifier_nevermore_6:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
end

function modifier_nevermore_6:GetModifierSpellAmplify_Percentage()
	return self.amp_damage
end