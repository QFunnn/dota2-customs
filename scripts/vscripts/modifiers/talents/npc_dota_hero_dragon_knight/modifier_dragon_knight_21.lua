--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dragon_knight_21_debuff", "modifiers/talents/npc_dota_hero_dragon_knight/modifier_dragon_knight_21", LUA_MODIFIER_MOTION_NONE)

modifier_dragon_knight_21=class({})

function modifier_dragon_knight_21:IsHidden() return true end
function modifier_dragon_knight_21:IsPurgable() return false end
function modifier_dragon_knight_21:IsPurgeException() return false end
function modifier_dragon_knight_21:RemoveOnDeath() return false end

function modifier_dragon_knight_21:OnCreated()
	self.bonus = 7
	if not IsServer() then return end
	self:SetStackCount(1)
	self:StartIntervalThink(0.1)
    local dragon_knight_elder_dragon_form_custom = self:GetParent():FindAbilityByName("dragon_knight_elder_dragon_form_custom")
    if dragon_knight_elder_dragon_form_custom then
        dragon_knight_elder_dragon_form_custom:SetLevel(math.max(dragon_knight_elder_dragon_form_custom:GetLevel(), 3))
        for i=1,4 do
            self:GetParent():RemoveModifierByName("modifier_dragon_knight_elder_dragon_form_custom_"..i)
        end
        local mod_name = "modifier_dragon_knight_elder_dragon_form_custom_3"
        self:GetParent():AddNewModifier( self:GetParent(), dragon_knight_elder_dragon_form_custom, mod_name, {} )
    end
end

function modifier_dragon_knight_21:OnRefresh()
	self.bonus = 7
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_dragon_knight_21:OnIntervalThink()
	if not IsServer() then return end
	self.Intellect = 0
	self.Intellect = self:GetParent():GetIntellect(false) / 100 * self.bonus
	self:GetParent():CalculateStatBonus(true)

    local mod_name = "modifier_dragon_knight_elder_dragon_form_custom_3"
    if self:GetParent():HasModifier(mod_name) then return end
    if self:GetParent():HasModifier("modifier_wodawisp") then return end
    local dragon_knight_elder_dragon_form_custom = self:GetParent():FindAbilityByName("dragon_knight_elder_dragon_form_custom")
    self:GetParent():AddNewModifier( self:GetParent(), dragon_knight_elder_dragon_form_custom, mod_name, {} )
end

function modifier_dragon_knight_21:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
         
	}
end

function modifier_dragon_knight_21:GetModifierBonusStats_Intellect()
	return self.Intellect
end

function modifier_dragon_knight_21:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.target == self:GetParent() then return end
    params.target:AddNewModifier(self:GetCaster(), nil, "modifier_dragon_knight_21_debuff", {duration = 3})
end

modifier_dragon_knight_21_debuff = class({})
function modifier_dragon_knight_21_debuff:GetTexture() return "dk_spell_debuff" end
function modifier_dragon_knight_21_debuff:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	}
end

function modifier_dragon_knight_21_debuff:GetModifierPercentageCooldown()
    return -50
end