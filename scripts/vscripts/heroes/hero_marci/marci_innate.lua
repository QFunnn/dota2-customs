--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


marci_innate = class({})

function marci_innate:GetIntrinsicModifierName()
	return "modifier_marci_innate"
end

LinkLuaModifier("modifier_marci_innate", "heroes/hero_marci/marci_innate", LUA_MODIFIER_MOTION_NONE)

modifier_marci_innate = class({})

function modifier_marci_innate:IsHidden() return true end
function modifier_marci_innate:IsPurgable() return false end
function modifier_marci_innate:RemoveOnDeath() return false end

function modifier_marci_innate:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(1.0)
end

function modifier_marci_innate:OnIntervalThink()
	if not IsServer() then return end
	
	local caster = self:GetParent()
	local level = caster:GetLevel()
	
	-- Даем способность Special Delivery на 40 уровне
	if level >= 40 then
		if not caster:HasAbility("ability_marci_special_delivery") then
			local ability = caster:AddAbility("ability_marci_special_delivery")
			if ability then
				ability:SetLevel(1)
				Timers:CreateTimer(0.1, function()
					if ability and not ability:IsNull() then
						ability:UpdateAbilitySlot()
					end
				end)
			end
		end
	end
end
