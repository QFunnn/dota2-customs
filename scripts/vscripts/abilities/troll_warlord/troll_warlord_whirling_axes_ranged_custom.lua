--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_troll_warlord_whirling_axes_ranged_custom", "abilities/troll_warlord/troll_warlord_whirling_axes_ranged_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_whirling_axes_ranged_quest", "abilities/troll_warlord/troll_warlord_whirling_axes_ranged_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_whirling_axes_silence_cd", "abilities/troll_warlord/troll_warlord_whirling_axes_ranged_custom", LUA_MODIFIER_MOTION_NONE)





troll_warlord_whirling_axes_ranged_custom = class({})

troll_warlord_whirling_axes_ranged_custom.axes = {}
troll_warlord_whirling_axes_ranged_custom.axes_index = 0

function troll_warlord_whirling_axes_ranged_custom:GetAbilityTextureName()
    return wearables_system:GetAbilityIconReplacement(self.caster, "troll_warlord_whirling_axes_ranged", self)
end


function troll_warlord_whirling_axes_ranged_custom:GetAbilityTargetFlags()
if self:GetCaster():HasScepter() then 
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
else 
	return DOTA_UNIT_TARGET_FLAG_NONE
end

end


function troll_warlord_whirling_axes_ranged_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/troll_ranged.vpcf", context )
PrecacheResource( "particle","particles/troll_ranged_legen.vpcf", context )
end


function troll_warlord_whirling_axes_ranged_custom:OnAbilityPhaseStart()
if self:GetCaster():HasModifier("modifier_troll_warlord_battle_trance_custom") then
	self:SetOverrideCastPoint(0)
else
	self:SetOverrideCastPoint(0.2)
end

return true
end



function troll_warlord_whirling_axes_ranged_custom:GetCooldown(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_troll_axes_1") then
	bonus = self:GetCaster():GetTalentValue("modifier_troll_axes_1", "cd")
end
return self.BaseClass.GetCooldown( self, level ) + bonus
end


function troll_warlord_whirling_axes_ranged_custom:GetCastRange(location, target)
return self.BaseClass.GetCastRange(self, location, target)
end

function troll_warlord_whirling_axes_ranged_custom:GetManaCost(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_troll_axes_1") then
	bonus = self:GetCaster():GetTalentValue("modifier_troll_axes_1", "mana")
end
return self.BaseClass.GetManaCost(self, level) + bonus
end

function troll_warlord_whirling_axes_ranged_custom:OnSpellStart(new_target)
local caster = self:GetCaster()
local point = self:GetCursorPosition()

if self:GetCursorTarget() then 
	point = self:GetCursorTarget():GetAbsOrigin()
end

if new_target ~= nil then 
	point = new_target:GetAbsOrigin()
end

if point == caster:GetAbsOrigin() then
	point = caster:GetAbsOrigin() + caster:GetForwardVector()*10
end

if caster:HasModifier("modifier_troll_warlord_berserkers_rage_custom") and not caster:HasTalent("modifier_troll_rage_legendary") then 
	local ability = caster:FindAbilityByName("troll_warlord_berserkers_rage_custom")
	if ability and ability:IsTrained() then 
		ability:ToggleAbility()
	end 
end 

local melle_ability = caster:FindAbilityByName("troll_warlord_whirling_axes_melee_custom")

if caster:HasTalent("modifier_troll_axes_3") then 
	caster:AddNewModifier(caster, melle_ability, "modifier_troll_warlord_whirling_axes_attack", {duration = caster:GetTalentValue("modifier_troll_axes_3", "duration")})
end

local caster_abs = caster:GetAbsOrigin()
local axe_width = self:GetSpecialValueFor("axe_width")
local axe_speed = self:GetSpecialValueFor("axe_speed")
local axe_range = self:GetSpecialValueFor("axe_range") + caster:GetCastRangeBonus()
local axe_damage = self:GetSpecialValueFor("axe_damage") + caster:GetTalentValue("modifier_troll_axes_3", "damage")*caster:GetAverageTrueAttackDamage(nil)/100
local duration = self:GetSpecialValueFor("axe_slow_duration")
local axe_spread = self:GetSpecialValueFor("axe_spread")
local axe_count = self:GetSpecialValueFor("axe_count")

if caster:HasTalent("modifier_troll_axes_legendary") and melle_ability then
	melle_ability:LegendaryProc(1)
end

local direction = (point - caster_abs):Normalized()

caster:EmitSound("Hero_TrollWarlord.WhirlingAxes.Ranged")

self.axes_index = self.axes_index + 1
self.axes[self.axes_index] = {}
self.axes[self.axes_index].targets = {}
self.axes[self.axes_index].count = 0

local start_angle
local interval_angle = 0

start_angle = axe_spread / 2 * (-1)
interval_angle = axe_spread / (axe_count - 1)

for i=1, axe_count do

	self.axes[self.axes_index].count = self.axes[self.axes_index].count + 1

	local angle = start_angle + (i-1) * interval_angle
	local velocity = RotateVector2D(direction,angle,true) * axe_speed

    local particle_name = "particles/troll_ranged.vpcf"
    local pfx_immortal = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_troll_warlord/troll_warlord_whirling_axe_ranged.vpcf", self)
    if pfx_immortal ~= "particles/units/heroes/hero_troll_warlord/troll_warlord_whirling_axe_ranged.vpcf" then
        particle_name = pfx_immortal
    end

	local projectile =
	{
		Ability				= self,
		EffectName			= particle_name,
		vSpawnOrigin		= caster_abs,
		fDistance			= axe_range,
		fStartRadius		= axe_width,
		fEndRadius			= axe_width,
		Source				= caster,
		bHasFrontalCone		= false,
		bReplaceExisting	= false,
		iUnitTargetTeam		= self:GetAbilityTargetTeam(),
		iUnitTargetFlags	= self:GetAbilityTargetFlags(),
		iUnitTargetType		= self:GetAbilityTargetType(),
		fExpireTime 		= GameRules:GetGameTime() + 10.0,
		bDeleteOnHit		= false,
		vVelocity			= Vector(velocity.x,velocity.y,0),
		bProvidesVision		= false,
		ExtraData			= {index = self.axes_index, damage = axe_damage, duration = duration}
	}
	ProjectileManager:CreateLinearProjectile(projectile)
end

end

function troll_warlord_whirling_axes_ranged_custom:OnProjectileHit_ExtraData(target, location, ExtraData)

local index = ExtraData.index
local caster = self:GetCaster()

if not index then return end
if not self.axes[index] or not self.axes[index].targets then return end

if target then
	if self.axes[index].targets[target] then return end

	self.axes[index].targets[target] = true

	local current_damage = ExtraData.damage
	local melle_ability = caster:FindAbilityByName("troll_warlord_whirling_axes_melee_custom")

	if melle_ability then
		melle_ability:ProcHit(target)
	end

	if caster:GetQuest() == "Troll.Quest_6" and target:IsRealHero() then 
		local mod = target:FindModifierByName("modifier_troll_warlord_whirling_axes_melee_quest")
		if mod then 
			mod:Destroy()
			caster:UpdateQuest(1)
		else 
			target:AddNewModifier(caster, self, "modifier_troll_warlord_whirling_axes_ranged_quest", {duration = caster.quest.number})
		end
	end

	if caster:HasTalent("modifier_troll_axes_5") and not target:HasModifier("modifier_troll_warlord_whirling_axes_silence_cd") then 

		target:AddNewModifier(caster, self, "modifier_troll_warlord_whirling_axes_silence_cd", {duration = caster:GetTalentValue("modifier_troll_axes_5", "cd")})

		local vec = (target:GetAbsOrigin() - caster:GetAbsOrigin())
		local dist = math.max(0, math.min(vec:Length2D() - 120, caster:GetTalentValue("modifier_troll_axes_5", "distance")))
		local duration = caster:GetTalentValue("modifier_troll_axes_5", "duration")
		local center = target:GetAbsOrigin() + 10*vec:Normalized()

		local knockback =	
		{
		    should_stun = 0,
		    knockback_duration = duration,
		    duration = duration,
		    knockback_distance = dist,
		    knockback_height = 0,
		    center_x = center.x,
		    center_y = center.y,
		    center_z = center.z,
		}

		target:AddNewModifier(caster,caster:BkbAbility(self, caster:HasScepter()), "modifier_knockback", knockback)

		local silence = caster:GetTalentValue("modifier_troll_axes_5", "silence") + duration
		target:AddNewModifier(caster, self, "modifier_generic_silence", {sound = "Sf.Raze_Silence", duration = (1 - target:GetStatusResistance())*silence})
	end

	DoDamage({victim = target, attacker = caster, ability = self, damage = current_damage, damage_type = self:GetAbilityDamageType()})

	target:AddNewModifier(caster, caster:BkbAbility(self, caster:HasScepter()), "modifier_troll_warlord_whirling_axes_ranged_custom", {duration = ExtraData.duration * (1 - target:GetStatusResistance())})
	target:EmitSound("Hero_TrollWarlord.WhirlingAxes.Target")
	if caster:HasScepter() then
		target:Purge(true, false, false, false, false)
	end
else
	self.axes[index].count = self.axes[index].count - 1

	if self.axes[index].count <= 0 then
		self.axes[index] = nil
	end
end

end

modifier_troll_warlord_whirling_axes_ranged_custom = class({})
function modifier_troll_warlord_whirling_axes_ranged_custom:IsHidden() return false end
function modifier_troll_warlord_whirling_axes_ranged_custom:IsPurgable() return not self:GetCaster():HasScepter() end
function modifier_troll_warlord_whirling_axes_ranged_custom:GetTexture() return "troll_warlord_whirling_axes_ranged" end
function modifier_troll_warlord_whirling_axes_ranged_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_troll_warlord_whirling_axes_ranged_custom:OnCreated()
self.caster = self:GetCaster()

self.ability = self.caster:FindAbilityByName("troll_warlord_whirling_axes_ranged_custom")
if not self.ability then self:Destroy() return end
self.slow = self.ability:GetSpecialValueFor("movement_speed") * (-1) + self.caster:GetTalentValue("modifier_troll_axes_5", "slow")
end

function modifier_troll_warlord_whirling_axes_ranged_custom:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end


function RotateVector2D(v,angle,bIsDegree)
    if bIsDegree then angle = math.rad(angle) end
    local xp = v.x * math.cos(angle) - v.y * math.sin(angle)
    local yp = v.x * math.sin(angle) + v.y * math.cos(angle)

    return Vector(xp,yp,v.z):Normalized()
end



modifier_troll_warlord_whirling_axes_ranged_quest = class({})
function modifier_troll_warlord_whirling_axes_ranged_quest:IsHidden() return true end
function modifier_troll_warlord_whirling_axes_ranged_quest:IsPurgable() return false end




modifier_troll_warlord_whirling_axes_silence_cd = class({})
function modifier_troll_warlord_whirling_axes_silence_cd:IsHidden() return true end
function modifier_troll_warlord_whirling_axes_silence_cd:IsPurgable() return false end
function modifier_troll_warlord_whirling_axes_silence_cd:RemoveOnDeath() return false end
