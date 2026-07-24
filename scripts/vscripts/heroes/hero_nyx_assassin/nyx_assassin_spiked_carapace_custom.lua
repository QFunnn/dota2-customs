--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_nyx_assassin_spiked_carapace_custom", "heroes/hero_nyx_assassin/nyx_assassin_spiked_carapace_custom", LUA_MODIFIER_MOTION_NONE)

nyx_assassin_spiked_carapace_custom = class({})

function nyx_assassin_spiked_carapace_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("reflect_duration")
    if IsInToolsMode() then
        duration = 20
    end
    self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_nyx_assassin_spiked_carapace_custom", {duration = duration} )
    self:GetCaster():EmitSound("Hero_NyxAssassin.SpikedCarapace")

    if self:GetCaster():HasModifier("modifier_nyx_assassin_burrow") then
    	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, 300, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
    	for _, enemy in pairs(enemies) do
    		enemy:EmitSound("Hero_NyxAssassin.SpikedCarapace.Stun")
			local stun_duration = self:GetSpecialValueFor('stun_duration')
			enemy:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = stun_duration})
			local nfx = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_spiked_carapace_hit.vpcf", PATTACH_POINT_FOLLOW, enemy)
			ParticleManager:SetParticleControlEnt(nfx, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
			ParticleManager:SetParticleControlEnt(nfx, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
			ParticleManager:SetParticleControl(nfx, 2, Vector(1,0,0))
			ParticleManager:ReleaseParticleIndex(nfx)
    	end
    end
end

modifier_nyx_assassin_spiked_carapace_custom = class({})

function modifier_nyx_assassin_spiked_carapace_custom:IsPurgable() return false end

function modifier_nyx_assassin_spiked_carapace_custom:GetEffectName()
	return "particles/units/heroes/hero_nyx_assassin/nyx_assassin_spiked_carapace.vpcf"
end

function modifier_nyx_assassin_spiked_carapace_custom:OnCreated()
    if not IsServer() then return end
    self.carapaced_units = {}
end

function modifier_nyx_assassin_spiked_carapace_custom:OnRefresh()
    if not IsServer() then return end
    self.carapaced_units = {}
end

function modifier_nyx_assassin_spiked_carapace_custom:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
    }
    return funcs
end

function modifier_nyx_assassin_spiked_carapace_custom:FlagExist(a,b)--Bitwise Exist
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

function modifier_nyx_assassin_spiked_carapace_custom:GetModifierTotal_ConstantBlock(params)
    if not IsServer() then return end
    if params.damage <= 0 then return end
    if params.attacker == self:GetParent() then return end
    if params.attacker:IsMagicImmune() then return end
    if self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS ) then return end
    if self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION ) then return end
	
    if not self.carapaced_units[ params.attacker:entindex() ] then
    	if params.attacker:IsHero() then
            local damage = params.original_damage * 0.01 * self:GetAbility():GetSpecialValueFor("damage_reflect_pct")
        	ApplyDamage({victim = params.attacker, damage = damage, damage_type = params.damage_type, damage_flags = DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, attacker = self:GetParent(), ability = self:GetAbility()})
        end
        params.attacker:EmitSound("Hero_NyxAssassin.SpikedCarapace.Stun")
		local stun_duration = self:GetAbility():GetSpecialValueFor('stun_duration')
		params.attacker:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", {duration = stun_duration})
        self.carapaced_units[ params.attacker:entindex() ] = params.attacker
        local nfx = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_spiked_carapace_hit.vpcf", PATTACH_POINT_FOLLOW, params.attacker)
		ParticleManager:SetParticleControlEnt(nfx, 0, params.attacker, PATTACH_POINT_FOLLOW, "attach_hitloc", params.attacker:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(nfx, 1, params.attacker, PATTACH_POINT_FOLLOW, "attach_hitloc", params.attacker:GetAbsOrigin(), true)
		ParticleManager:SetParticleControl(nfx, 2, Vector(1,0,0))
		ParticleManager:ReleaseParticleIndex(nfx)
        return params.damage
    end
end