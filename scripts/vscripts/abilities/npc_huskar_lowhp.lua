--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_huskar_lowhp", "abilities/npc_huskar_lowhp.lua", LUA_MODIFIER_MOTION_NONE)

npc_huskar_lowhp = class({})


function npc_huskar_lowhp:GetIntrinsicModifierName() return "modifier_huskar_lowhp" end
 
function npc_huskar_lowhp:Precache(context)
PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_berserkers_blood.vpcf", context )

end



modifier_huskar_lowhp = class ({})

function modifier_huskar_lowhp:IsHidden() return true end
function modifier_huskar_lowhp:IsPurgable() return false end

function modifier_huskar_lowhp:OnCreated(table)
self.health = self:GetAbility():GetSpecialValueFor("health")
self.speed = self:GetAbility():GetSpecialValueFor("speed")
self.armor = self:GetAbility():GetSpecialValueFor("armor")
self.low = false 
self:StartIntervalThink(0.1)

end
function modifier_huskar_lowhp:DeclareFunctions()
   return   {
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    MODIFIER_PROPERTY_MODEL_SCALE,
    MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
    MODIFIER_PROPERTY_TOOLTIP,
    MODIFIER_PROPERTY_TOOLTIP2
  }

 
end

function modifier_huskar_lowhp:OnTooltip() return self.speed end
function modifier_huskar_lowhp:OnTooltip2() return self.armor end

function modifier_huskar_lowhp:OnIntervalThink() 
if not IsServer() then return end
	if self:GetParent():GetHealthPercent() <= self.health and not self.low then 
		self.low = true  
		self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_huskar/huskar_berserkers_blood.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControl(self.particle, 1, Vector( 50, 0, 0))
		self:GetParent():SetRenderColor(255, 40, 40)
	end

	if self:GetParent():GetHealthPercent() > self.health and self.low then 
		self.low = false
		ParticleManager:DestroyParticle(self.particle, false)
		self:GetParent():SetRenderColor(255, 255, 255)
	end

end

function modifier_huskar_lowhp:GetModifierAttackSpeedBonus_Constant() 
if self:GetParent():GetHealthPercent() <= self.health then 
	return self.speed else return 0 end

end

function modifier_huskar_lowhp:GetModifierModelScale() 
if self:GetParent():GetHealthPercent() <= self.health then 
	return 30 else return 0 end
end


function modifier_huskar_lowhp:GetModifierPhysicalArmorBonus() 
if self:GetParent():GetHealthPercent() <= self.health then 
	return 8 else return 0 end

end


function modifier_huskar_lowhp:GetModifierProcAttack_Feedback( params ) 
    if not IsServer() then end 
    if params.attacker == self:GetParent() and self:GetParent():GetHealthPercent() <= self.health then
        local heal = self:GetAbility():GetSpecialValueFor("heal")
        params.attacker:Heal(params.attacker:GetMaxHealth()*heal/100, self:GetParent())
              local particle = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.attacker)
        ParticleManager:ReleaseParticleIndex( particle )
       
    end

end
