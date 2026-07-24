--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_muerta_mercy_and_grace_custom_stats", "abilities/items/item_muerta_mercy_and_grace_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_muerta_mercy_and_grace_custom_active", "abilities/items/item_muerta_mercy_and_grace_custom", LUA_MODIFIER_MOTION_NONE)


item_muerta_mercy_and_grace_custom                = class({})
item_muerta_mercy_and_grace_full_custom                = class({})


function item_muerta_mercy_and_grace_custom:GetIntrinsicModifierName()
return "modifier_item_muerta_mercy_and_grace_custom_stats"
end

function item_muerta_mercy_and_grace_full_custom:GetIntrinsicModifierName()
return "modifier_item_muerta_mercy_and_grace_custom_stats"
end


function item_muerta_mercy_and_grace_custom:OnSpellStart()
if not IsServer() then return end

self:GetCaster():EmitSound("Muerta.Item_activate")
self:GetCaster():EmitSound("Muerta.Item_activate2")
self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_muerta_mercy_and_grace_custom_active", {duration = self:GetSpecialValueFor("duration")})

end


function item_muerta_mercy_and_grace_full_custom:OnSpellStart()
if not IsServer() then return end

self:GetCaster():EmitSound("Muerta.Item_activate")
self:GetCaster():EmitSound("Muerta.Item_activate2")
self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_muerta_mercy_and_grace_custom_active", {duration = self:GetSpecialValueFor("duration")})

end



modifier_item_muerta_mercy_and_grace_custom_stats = class({})
function modifier_item_muerta_mercy_and_grace_custom_stats:IsHidden() return true end
function modifier_item_muerta_mercy_and_grace_custom_stats:IsPurgable() return false end
function modifier_item_muerta_mercy_and_grace_custom_stats:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
}
end

function modifier_item_muerta_mercy_and_grace_custom_stats:OnCreated(table)
self.move = self:GetAbility():GetSpecialValueFor("movespeed")
self.stats = self:GetAbility():GetSpecialValueFor("stats")
self.speed = self:GetAbility():GetSpecialValueFor("attack_speed")
self.passive_damage = self:GetAbility():GetSpecialValueFor("passive_damage")/100


if not IsServer() then return end
end




function modifier_item_muerta_mercy_and_grace_custom_stats:GetModifierMoveSpeedBonus_Constant()
return self.move
end


function modifier_item_muerta_mercy_and_grace_custom_stats:GetModifierBonusStats_Strength()
return self.stats
end

function modifier_item_muerta_mercy_and_grace_custom_stats:GetModifierBonusStats_Agility()
return self.stats
end

function modifier_item_muerta_mercy_and_grace_custom_stats:GetModifierBonusStats_Intellect()
return self.stats
end

function modifier_item_muerta_mercy_and_grace_custom_stats:GetModifierAttackSpeedBonus_Constant()
return self.speed
end



function modifier_item_muerta_mercy_and_grace_custom_stats:GetModifierProcAttack_Feedback(params)
if not IsServer() then return end
if self:GetParent() ~= params.attacker then return end
if self:GetParent():IsIllusion() then return end
if not params.target:IsUnit() then return end

local health = params.target:GetHealth()

local part = "particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf"

if self:GetParent():HasModifier("modifier_item_muerta_mercy_and_grace_custom_active") then 
	health = (params.target:GetMaxHealth() - params.target:GetHealth())

	params.target:EmitSound("Muerta.Item_attack")
	part = "particles/muerta_item_heal.vpcf"
end

local bonus = 0
if self:GetAbility():GetSpecialValueFor("active_bonus") then 
	bonus = (self:GetAbility():GetSpecialValueFor("active_bonus")/100)*self:GetAbility():GetCurrentCharges()
end

local damage = health*(self.passive_damage + bonus)

if params.target:IsCreep() then 
	damage = math.min(damage, self:GetAbility():GetSpecialValueFor("passive_creeps"))
end


local apply = DoDamage({victim = params.target, attacker = self:GetCaster(), ability = self:GetAbility(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})


self:GetParent():Heal(apply, self:GetAbility())

if self:GetParent():HasModifier("modifier_item_muerta_mercy_and_grace_custom_active") then 
	SendOverheadEventMessage(params.target, 6, params.target, apply, nil)
end

local effect_cast = ParticleManager:CreateParticle( part, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
ParticleManager:SetParticleControlEnt(effect_cast, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex( effect_cast )
end



modifier_item_muerta_mercy_and_grace_custom_active = class({})
function modifier_item_muerta_mercy_and_grace_custom_active:IsHidden() return false end
function modifier_item_muerta_mercy_and_grace_custom_active:IsPurgable() return false end
function modifier_item_muerta_mercy_and_grace_custom_active:GetTexture() return "buffs/muerta_full" end
function modifier_item_muerta_mercy_and_grace_custom_active:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PROJECTILE_NAME,
}
end

function modifier_item_muerta_mercy_and_grace_custom_active:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.active_bonus = self.ability:GetSpecialValueFor("active_bonus")
self.active_max = self.ability:GetSpecialValueFor("active_max")

self.parent:AddDeathEvent(self, true)
self.parent:AddAttackStartEvent_out(self, true)
end

function modifier_item_muerta_mercy_and_grace_custom_active:DeathEvent(params)
if not IsServer() then return end
if not IsValid(self.ability) then return end
if self.parent ~= params.attacker then return end
if not params.unit:IsRealHero() then return end
if params.unit:IsReincarnating() then return end
if self.active_max == 0 then return end

self.parent:EmitSound("Muerta.Quest_hero_kill")

self.ability:SetCurrentCharges(self.ability:GetCurrentCharges() + 1)

CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self.parent:GetPlayerOwnerID()), "muerta_quest_panel",  { max = 5, stack = self.ability:GetCurrentCharges(), stage = 3})


local effect_cast = ParticleManager:CreateParticle( "particles/heroes/muerta/muerta_quest_kill.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt(effect_cast, 2, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex( effect_cast )

if self.ability:GetCurrentCharges() >= self.ability:GetSpecialValueFor("active_max") then 

	local particle_peffect = ParticleManager:CreateParticle("particles/muerta/muerta_quest_item.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(particle_peffect, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_peffect, 2, self:GetCaster():GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle_peffect)
	self:GetCaster():EmitSound("Muerta.Quest_item")
	self:GetCaster():EmitSound("Muerta.Quest_item2")


	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self.parent:GetPlayerOwnerID()), "muerta_quest_alert",  {type = 6})
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self.parent:GetPlayerOwnerID()), "muerta_quest_panel",  {stage = 4})

	self.ability:Destroy()
  local full = CreateItem("item_muerta_mercy_and_grace_full_custom", self.parent, self.parent)
  self.parent:AddItem(full)

end

end



function modifier_item_muerta_mercy_and_grace_custom_active:AttackStartEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end

local projectile =
{
  Target = params.target,
  Source = self.parent,
  Ability = self:GetAbility(),
  EffectName = "particles/units/heroes/hero_muerta/muerta_ultimate_projectile_alternate.vpcf",
  iMoveSpeed = self.parent:GetProjectileSpeed(),
  vSourceLoc = self.parent:GetAbsOrigin(),
  bDodgeable = true,
  bProvidesVision = false,
}

local hProjectile = ProjectileManager:CreateTrackingProjectile( projectile )

end



function modifier_item_muerta_mercy_and_grace_custom_active:GetEffectName()
	return "particles/muerta_item_active.vpcf"
end

function modifier_item_muerta_mercy_and_grace_custom_active:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_muerta_mercy_and_grace_custom_active:GetPriority()
return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_item_muerta_mercy_and_grace_custom_active:GetModifierProjectileName()
	return "particles/units/heroes/hero_muerta/muerta_ultimate_projectile_alternate.vpcf"
end