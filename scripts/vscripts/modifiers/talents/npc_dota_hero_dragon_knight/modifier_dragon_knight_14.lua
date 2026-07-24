--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_dragon_knight_14=class({})

function modifier_dragon_knight_14:IsHidden() return true end
function modifier_dragon_knight_14:IsPurgable() return false end
function modifier_dragon_knight_14:IsPurgeException() return false end
function modifier_dragon_knight_14:RemoveOnDeath() return false end

function modifier_dragon_knight_14:OnCreated()
	self.bonus = 7
	if not IsServer() then return end
	self:SetStackCount(1)
	self:StartIntervalThink(0.1)
    local dragon_knight_elder_dragon_form_custom = self:GetParent():FindAbilityByName("dragon_knight_elder_dragon_form_custom")
    if dragon_knight_elder_dragon_form_custom then
        dragon_knight_elder_dragon_form_custom:SetLevel(math.max(dragon_knight_elder_dragon_form_custom:GetLevel(), 1))
        for i=1,4 do
            self:GetParent():RemoveModifierByName("modifier_dragon_knight_elder_dragon_form_custom_"..i)
        end
        local mod_name = "modifier_dragon_knight_elder_dragon_form_custom_1"
        self:GetParent():AddNewModifier( self:GetParent(), dragon_knight_elder_dragon_form_custom, mod_name, {} )
    end
end

function modifier_dragon_knight_14:OnRefresh()
	self.bonus = 7
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_dragon_knight_14:OnIntervalThink()
	if not IsServer() then return end
	self.Agility = 0
	self.Agility = self:GetParent():GetAgility() / 100 * self.bonus
	self:GetParent():CalculateStatBonus(true)

    local mod_name = "modifier_dragon_knight_elder_dragon_form_custom_1"
    if self:GetParent():HasModifier(mod_name) then return end
    if self:GetParent():HasModifier("modifier_wodawisp") then return end
    local dragon_knight_elder_dragon_form_custom = self:GetParent():FindAbilityByName("dragon_knight_elder_dragon_form_custom")
    self:GetParent():AddNewModifier( self:GetParent(), dragon_knight_elder_dragon_form_custom, mod_name, {} )
end

function modifier_dragon_knight_14:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS
	}
end

function modifier_dragon_knight_14:GetModifierBonusStats_Agility()
	return self.Agility
end