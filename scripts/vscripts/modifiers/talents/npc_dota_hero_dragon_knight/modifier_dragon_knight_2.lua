--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_dragon_knight_2=class({})

function modifier_dragon_knight_2:IsHidden() return false end
function modifier_dragon_knight_2:IsPurgable() return false end
function modifier_dragon_knight_2:IsPurgeException() return false end
function modifier_dragon_knight_2:RemoveOnDeath() return false end

function modifier_dragon_knight_2:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_dragon_knight_2:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_dragon_knight_2:DeclareFunctions()
	local funcs = {
		 
	}

	return funcs
end

function modifier_dragon_knight_2:OnAttackLanded(params)
	if params.target ~= self:GetParent() then return end
	if params.attacker == self:GetParent() then return end

	if self:GetParent():HasModifier("modifier_dragon_knight_2") then
		local ability = self:GetParent():FindAbilityByName("dragon_knight_dragon_blood_custom")
		if ability then 
			local damage = self:GetParent():GetStrength() / 100 * ability.modifier_dragon_knight_2_str_multiple[self:GetParent():GetTalentLevel("modifier_dragon_knight_2")]
			ApplyDamage({ victim = params.attacker, attacker = self:GetParent(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = ability})
			local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_centaur/centaur_return.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	    	ParticleManager:SetParticleControlEnt( particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true )
	    	ParticleManager:SetParticleControlEnt( particle, 1, params.attacker, PATTACH_POINT_FOLLOW, "attach_hitloc", params.attacker:GetOrigin(), true ) 
	    end
	end 
end

function modifier_dragon_knight_2:GetTexture()
	return "dragon_knight_2"
end