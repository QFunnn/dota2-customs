--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



jakiro_liquid_ice_lua = class({})

LinkLuaModifier("modifier_liquid_ice_lua", "heroes/hero_jakiro/jakiro_liquid_ice_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_liquid_ice_lua_orb", "heroes/hero_jakiro/jakiro_liquid_ice_lua", LUA_MODIFIER_MOTION_NONE)

function jakiro_liquid_ice_lua:IsHiddenWhenStolen() 		return false end
function jakiro_liquid_ice_lua:IsRefreshable() 			return true end
function jakiro_liquid_ice_lua:IsStealable() 				return false end
function jakiro_liquid_ice_lua:IsNetherWardStealable() 	return false end

function jakiro_liquid_ice_lua:GetIntrinsicModifierName() return "modifier_liquid_ice_lua_orb" end

function jakiro_liquid_ice_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local info = 
	{
		Target = target,
		Source = caster,
		SourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
		Ability = self,	
		EffectName = "particles/units/heroes/hero_jakiro/jakiro_base_attack.vpcf",
		iMoveSpeed = 900,
		vSourceLoc= caster:GetAbsOrigin(),
		bDrawsOnMinimap = false,
		bDodgeable = true,
		bIsAttack = false,
		bVisibleToEnemies = true,
		bReplaceExisting = false,
		flExpireTime = GameRules:GetGameTime() + 10,
		bProvidesVision = false,	
	}
	projectile = ProjectileManager:CreateTrackingProjectile(info)
end

function jakiro_liquid_ice_lua:OnProjectileHit(target, location)
	if not target then
		return
	end
	local caster = self:GetCaster()
	local enemies =  FindUnitsInRadius(caster:GetTeamNumber(), target:GetAbsOrigin(), nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
	
	--7.30液态冰添加眩晕
	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(caster, self, "modifier_stunned", {duration = self:GetSpecialValueFor("stun_duration")})
	end

	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(caster, self, "modifier_liquid_ice_lua", {duration = self:GetSpecialValueFor("duration")})
	end
	local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_jakiro/jakiro_base_attack_frost_explosion.vpcf", PATTACH_CUSTOMORIGIN, target)
	ParticleManager:SetParticleControl(pfx, 0, Vector(target:GetAbsOrigin().x, target:GetAbsOrigin().y, target:GetAbsOrigin().z + 64))
	ParticleManager:SetParticleControl(pfx, 1, Vector(self:GetSpecialValueFor("radius"), self:GetSpecialValueFor("radius"), self:GetSpecialValueFor("radius")))
	target:EmitSound("Hero_Jakiro.LiquidFire")
end

modifier_liquid_ice_lua = class({})

function modifier_liquid_ice_lua:IsDebuff()			return true end
function modifier_liquid_ice_lua:IsHidden() 			return false end
function modifier_liquid_ice_lua:IsPurgable() 		return true end
function modifier_liquid_ice_lua:IsPurgeException() 	return true end

function modifier_liquid_ice_lua:GetEffectName() return "particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_debuff.vpcf" end
function modifier_liquid_ice_lua:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end

function modifier_liquid_ice_lua:OnCreated()
	if IsServer() then
		self:StartIntervalThink(1.0)
	end
end

function modifier_liquid_ice_lua:OnIntervalThink()
	local ability = self:GetAbility()
	-- [#25] Урон = база + %макс.HP для всех, включая Roshan/Nian. %HP по ним наносится,
	-- но НЕ усиливается спелл-ампом (масштаб base/total в modifier_spell_amplify_controller);
	-- усиливается только базовая часть.
	local dmg = ability:GetSpecialValueFor("base_damage") + self:GetParent():GetMaxHealth()*(ability:GetSpecialValueFor("pct_health_damage")/100)
	local damageTable = {
						victim = self:GetParent(),
						attacker = self:GetCaster(),
						damage = dmg,
						damage_type = self:GetAbility():GetAbilityDamageType(),
						ability = self:GetAbility(), --Optional.
						}
	ApplyDamage(damageTable)
end

function modifier_liquid_ice_lua:DeclareFunctions() return {MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE} end

function modifier_liquid_ice_lua:GetModifierMoveSpeedBonus_Constant()
	if self:GetCaster() then
		return -1*self:GetAbility():GetSpecialValueFor("movement_slow")  
	end
end

modifier_liquid_ice_lua_orb = class({})

function modifier_liquid_ice_lua_orb:IsDebuff()			return false end
function modifier_liquid_ice_lua_orb:IsHidden() 			return true end
function modifier_liquid_ice_lua_orb:IsPurgable() 		return false end
function modifier_liquid_ice_lua_orb:IsPurgeException() 	return false end

function modifier_liquid_ice_lua_orb:OnCreated()
	if IsServer() then
	end
end

function modifier_liquid_ice_lua_orb:AttackModifier(keys)
	if not IsServer() then
		return 
	end
	if keys.attacker ~= self:GetParent() then
		return
	end
    if self:GetParent():IsSilenced() or self:GetParent():IsIllusion() or not self:GetAbility():IsCooldownReady() or not self:GetAbility():GetAutoCastState() then
        return
    end
	self:SetStackCount(1)
	self:GetParent():StartGesture(ACT_DOTA_ATTACK2)
	self:GetAbility():UseResources(true, false, true, true)
end

function modifier_liquid_ice_lua_orb:AttackLandedModifier(keys)
	if not IsServer() then
		return 
	end
	if keys.attacker ~= self:GetParent() then
		return
	end
    if self:GetParent():IsIllusion() then return end
	if self:GetStackCount() ~= 1 then
		return
	end
	self:SetStackCount(0)
	self:GetAbility():OnProjectileHit(keys.target, keys.target:GetAbsOrigin())
end