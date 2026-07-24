--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ogre_magi_11_buff", "modifiers/talents/npc_dota_hero_ogre_magi/modifier_ogre_magi_11", LUA_MODIFIER_MOTION_NONE)

modifier_ogre_magi_11=class({})

function modifier_ogre_magi_11:IsHidden() return true end
function modifier_ogre_magi_11:IsPurgable() return false end
function modifier_ogre_magi_11:IsPurgeException() return false end
function modifier_ogre_magi_11:RemoveOnDeath() return false end

function modifier_ogre_magi_11:OnCreated()
	self.duration = {1,2,3}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_ogre_magi_11:OnRefresh()
	self.duration = {1,2,3}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_ogre_magi_11:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_ogre_magi_11_buff", {duration = self.duration[self:GetStackCount()]})
end

modifier_ogre_magi_11_buff=class({})
function modifier_ogre_magi_11_buff:GetTexture() return "ogre_magi_11" end
function modifier_ogre_magi_11_buff:IsHidden() return false end
function modifier_ogre_magi_11_buff:IsPurgable() return false end

function modifier_ogre_magi_11_buff:OnCreated()
    self.lifesteal_per_stack = 3
	if not IsServer() then return end
	self:IncrementStackCount()
    Timers:CreateTimer(self:GetDuration(), function()
        if self and not self:IsNull() then
            self:DecrementStackCount()
            if self:GetStackCount() <= 0 then
                self:Destroy()
            end
        end
    end)
end

function modifier_ogre_magi_11_buff:OnRefresh()
	if not IsServer() then return end
    self:OnCreated()
end

function modifier_ogre_magi_11_buff:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL,
		MODIFIER_PROPERTY_MAGICAL_LIFESTEAL
	}
end

function modifier_ogre_magi_11_buff:GetModifierProperty_PhysicalLifesteal()
	return self.lifesteal_per_stack * self:GetStackCount()
end

function modifier_ogre_magi_11_buff:GetModifierProperty_MagicalLifesteal()
	return self.lifesteal_per_stack * self:GetStackCount()
end