--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_warlock_boss_golem_fists_tracker", "abilities/warlock_boss/warlock_boss_golem_fists_passive.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_warlock_boss_golem_fists_death", "abilities/warlock_boss/warlock_boss_golem_fists_passive.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_warlock_boss_golem_fists_debuff", "abilities/warlock_boss/warlock_boss_golem_fists_passive.lua", LUA_MODIFIER_MOTION_NONE)


warlock_boss_golem_fists_passive = class({})

function warlock_boss_golem_fists_passive:GetIntrinsicModifierName()
return "modifier_warlock_boss_golem_fists_tracker"
end



modifier_warlock_boss_golem_fists_tracker = class({})

function modifier_warlock_boss_golem_fists_tracker:IsHidden() return true end
function modifier_warlock_boss_golem_fists_tracker:IsPurgable() return false end

function modifier_warlock_boss_golem_fists_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PROCATTACK_FEEDBACK
}
end


function modifier_warlock_boss_golem_fists_tracker:OnCreated()
self.parent = self:GetParent()
self.parent:AddDeathEvent(self)
end


function modifier_warlock_boss_golem_fists_tracker:DeathEvent(params)
if not IsServer() then return end
if not self:GetParent().summoner then return end
if self:GetParent().summoner:IsNull() then return end
if self:GetParent().summoner ~= params.unit then return end

local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
ParticleManager:SetParticleControlEnt( particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true)
ParticleManager:SetParticleControlEnt( particle, 2, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true )
ParticleManager:SetParticleControlEnt( particle, 3, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
ParticleManager:ReleaseParticleIndex( particle )

self:GetParent():EmitSound("Hero_OgreMagi.Bloodlust.Cast")
self:GetParent():EmitSound("Hero_OgreMagi.Bloodlust.Target")
self:GetParent():EmitSound("Warlock.Golem_rage")

self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_warlock_boss_golem_fists_death", {})
end




function modifier_warlock_boss_golem_fists_tracker:GetModifierProcAttack_Feedback(params)
if not IsServer() then return end
if self:GetParent() ~= params.attacker then return end
if not params.target:IsUnit() then return end

params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_warlock_boss_golem_fists_debuff", {duration = self:GetAbility():GetSpecialValueFor("duration")})
end





modifier_warlock_boss_golem_fists_death = class({})
function modifier_warlock_boss_golem_fists_death:IsHidden() return true end
function modifier_warlock_boss_golem_fists_death:IsPurgable() return false end

function modifier_warlock_boss_golem_fists_death:OnCreated(table)
self.speed = self:GetAbility():GetSpecialValueFor("death_speed")
self.damage = self:GetAbility():GetSpecialValueFor("death_damage")
self.move = self:GetAbility():GetSpecialValueFor("death_move")
self.incoming = self:GetAbility():GetSpecialValueFor("death_incoming")

if not IsServer() then return end

self:GetParent():SetRenderColor(255, 255 * 0.3, 255 * 0.3)

end



function modifier_warlock_boss_golem_fists_death:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MODEL_SCALE,
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}

end

function modifier_warlock_boss_golem_fists_death:GetEffectName()
	return "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff.vpcf"
end

function modifier_warlock_boss_golem_fists_death:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end


function modifier_warlock_boss_golem_fists_death:GetModifierModelScale()
return 40
end

function modifier_warlock_boss_golem_fists_death:GetModifierIncomingDamage_Percentage()
return self.incoming
end



function modifier_warlock_boss_golem_fists_death:GetModifierAttackSpeedBonus_Constant()
return self.speed
end


function modifier_warlock_boss_golem_fists_death:GetModifierDamageOutgoing_Percentage()
return self.damage
end


function modifier_warlock_boss_golem_fists_death:GetModifierMoveSpeedBonus_Percentage()
return self.move
end



modifier_warlock_boss_golem_fists_debuff = class({})
function modifier_warlock_boss_golem_fists_debuff:IsHidden() return false end
function modifier_warlock_boss_golem_fists_debuff:IsPurgable() return false end

function modifier_warlock_boss_golem_fists_debuff:OnCreated(table)
self.damage = self:GetAbility():GetSpecialValueFor("damage")
self.max = self:GetAbility():GetSpecialValueFor("max_1")


if self:GetCaster().summoner and not self:GetCaster().summoner:IsNull() and self:GetCaster().summoner:GetUpgradeStack("modifier_waveupgrade_boss") == 2 then 
	self.max = self:GetAbility():GetSpecialValueFor("max_2")
end

if not IsServer() then return end


self:GetParent():EmitSound("Item.StarEmblem.Enemy")
self.particle_peffect = ParticleManager:CreateParticle("particles/general/generic_armor_reduction.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())	
ParticleManager:SetParticleControl(self.particle_peffect, 0, self:GetParent():GetAbsOrigin())
self:AddParticle(self.particle_peffect, false, false, -1, false, true)

self:SetStackCount(1)
end


function modifier_warlock_boss_golem_fists_debuff:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()
end



function modifier_warlock_boss_golem_fists_debuff:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end


function modifier_warlock_boss_golem_fists_debuff:GetModifierIncomingDamage_Percentage()
return self:GetStackCount()*self.damage
end