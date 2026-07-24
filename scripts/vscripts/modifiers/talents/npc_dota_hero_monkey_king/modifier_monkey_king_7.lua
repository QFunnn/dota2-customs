--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_monkey_king_7=class({})

function modifier_monkey_king_7:IsHidden() return true end
function modifier_monkey_king_7:IsPurgable() return false end
function modifier_monkey_king_7:IsPurgeException() return false end
function modifier_monkey_king_7:RemoveOnDeath() return false end

function modifier_monkey_king_7:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    Timers:CreateTimer(FrameTime(), function()
        if self:GetParent():HasModifier("modifier_monkey_king_wukongs_command_custom_buff") then return 0.2 end
        local original_ability = "monkey_king_jingu_mastery_custom"
        if self:GetParent():HasModifier("modifier_monkey_king_18") then
            original_ability = "monkey_king_jingu_magic_custom"
        end
        self:GetCaster():SwapAbilities(original_ability, "monkey_king_transfiguration_custom", true, true)
        local monkey_king_transfiguration_custom = self:GetCaster():FindAbilityByName("monkey_king_transfiguration_custom")
        if not monkey_king_transfiguration_custom:IsTrained() then
            monkey_king_transfiguration_custom:SetLevel(1)
        end
    end)
end

function modifier_monkey_king_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end