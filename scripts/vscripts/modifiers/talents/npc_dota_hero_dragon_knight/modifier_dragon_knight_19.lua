--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dragon_knight_19_debuff", "modifiers/talents/npc_dota_hero_dragon_knight/modifier_dragon_knight_19", LUA_MODIFIER_MOTION_NONE)

modifier_dragon_knight_19=class({})

function modifier_dragon_knight_19:IsHidden() return true end
function modifier_dragon_knight_19:IsPurgable() return false end
function modifier_dragon_knight_19:IsPurgeException() return false end
function modifier_dragon_knight_19:RemoveOnDeath() return false end

function modifier_dragon_knight_19:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_dragon_knight_19:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_dragon_knight_19:DeclareFunctions()
	return {
		 
	}
end

function modifier_dragon_knight_19:OnTakeDamage(params)
	if not IsServer() then return end
	if params.unit ~= self:GetParent() then return end
	if params.attacker == self:GetParent() then return end
	local distance = (params.attacker:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D()
	if distance < 1400 then
		params.attacker:AddNewModifier(self:GetParent(), nil, "modifier_dragon_knight_19_debuff", {duration = 4})
	end
end

modifier_dragon_knight_19_debuff = class({})

modifier_dragon_knight_19_debuff.heal_and_mana_reduce = {-15,-30}

function modifier_dragon_knight_19_debuff:GetTexture() return "dragon_knight_19" end

function modifier_dragon_knight_19_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
		--MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE
	}
end

function modifier_dragon_knight_19_debuff:GetModifierHPRegenAmplify_Percentage()
	return self.heal_and_mana_reduce[self:GetCaster():GetTalentLevel("modifier_dragon_knight_19")]
end

function modifier_dragon_knight_19_debuff:GetModifierManaRegenPercentDecreaseCustom()
    return self.heal_and_mana_reduce[self:GetCaster():GetTalentLevel("modifier_dragon_knight_19")]
end