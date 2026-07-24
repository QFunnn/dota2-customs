--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


primal_beast_innate = class({})

function primal_beast_innate:GetIntrinsicModifierName()
	return "modifier_primal_beast_innate"
end

LinkLuaModifier("modifier_primal_beast_innate", "heroes/hero_primal_beast/primal_beast_innate", LUA_MODIFIER_MOTION_NONE)

modifier_primal_beast_innate = class({})

function modifier_primal_beast_innate:IsHidden() return true end
function modifier_primal_beast_innate:IsPurgable() return false end
function modifier_primal_beast_innate:RemoveOnDeath() return false end

function modifier_primal_beast_innate:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(1.0)
end

function modifier_primal_beast_innate:OnIntervalThink()
	if not IsServer() then return end
	
	local caster = self:GetParent()
	local level = caster:GetLevel()
	
	-- Даем способность Petrification на 40 уровне
	if level >= 40 then
		if not caster:HasAbility("primal_beast_petrification") then
			local ability = caster:AddAbility("primal_beast_petrification")
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
