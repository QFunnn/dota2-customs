--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



jakiro_liquid_fire_lua = class({})

LinkLuaModifier("modifier_liquid_fire_lua", "heroes/hero_jakiro/jakiro_liquid_fire_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_liquid_fire_lua_orb", "heroes/hero_jakiro/jakiro_liquid_fire_lua", LUA_MODIFIER_MOTION_NONE)

function jakiro_liquid_fire_lua:IsHiddenWhenStolen() 		return false end
function jakiro_liquid_fire_lua:IsRefreshable() 			return true end
function jakiro_liquid_fire_lua:IsStealable() 				return false end
function jakiro_liquid_fire_lua:IsNetherWardStealable() 	return false end

function jakiro_liquid_fire_lua:GetIntrinsicModifierName() return "modifier_liquid_fire_lua_orb" end

function jakiro_liquid_fire_lua:GetCastRange(vLocation, hTarget)
	return self:GetSpecialValueFor("cast_range_tooltip")
end

function jakiro_liquid_fire_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local info =
	{
		Target = target,
		Source = caster,
		SourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
		Ability = self,
		EffectName = "particles/units/heroes/hero_jakiro/jakiro_base_attack_fire.vpcf",
		iMoveSpeed = self:GetSpecialValueFor("speed"),
		vSourceLoc= caster:GetAbsOrigin(),
		bDrawsOnMinimap = false,
		bDodgeable = true,
		bIsAttack = false,
		bVisibleToEnemies = true,
		bReplaceExisting = false,
		flExpireTime = GameRulesCustom:GetGameTime() + 10,
		bProvidesVision = false,
	}
	projectile = ProjectileManager:CreateTrackingProjectile(info)
end

function jakiro_liquid_fire_lua:OnProjectileHit(target, location)
	if not target then
		return
	end
	local caster = self:GetCaster()
	local enemies =  FindUnitsInRadius(caster:GetTeamNumber(), target:GetAbsOrigin(), nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(caster, self, "modifier_liquid_fire_lua", {duration = self:GetSpecialValueFor("duration") * enemy:GetStatusResistanceFactor(caster)})
	end
	local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_jakiro/jakiro_liquid_fire_explosion.vpcf", PATTACH_CUSTOMORIGIN, target)
	ParticleManager:SetParticleControl(pfx, 0, Vector(target:GetAbsOrigin().x, target:GetAbsOrigin().y, target:GetAbsOrigin().z + 64))
	ParticleManager:SetParticleControl(pfx, 1, Vector(self:GetSpecialValueFor("radius"), self:GetSpecialValueFor("radius"), self:GetSpecialValueFor("radius")))
	EmitSoundOn("Hero_Jakiro.LiquidFire", target)
end

modifier_liquid_fire_lua = class({})

function modifier_liquid_fire_lua:IsDebuff()			return true end
function modifier_liquid_fire_lua:IsHidden() 			return false end
function modifier_liquid_fire_lua:IsPurgable() 		return true end
function modifier_liquid_fire_lua:IsPurgeException() 	return true end

function modifier_liquid_fire_lua:GetEffectName() return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf" end
function modifier_liquid_fire_lua:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end

function modifier_liquid_fire_lua:OnCreated()
	if IsServer() then
		self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("damage_interval"))
	end
end

function modifier_liquid_fire_lua:OnIntervalThink()

	if not self:GetAbility() or self:GetAbility():IsNull() then
        return
    end

	local dmg = self:GetAbility():GetSpecialValueFor("damage") / (1.0 / self:GetAbility():GetSpecialValueFor("damage_interval"))
	local damageTable = {
						victim = self:GetParent(),
						attacker = self:GetCaster(),
						damage = dmg,
						damage_type = self:GetAbility():GetAbilityDamageType(),
						damage_flags = DOTA_DAMAGE_FLAG_PROPERTY_FIRE, --Optional.
						ability = self:GetAbility(), --Optional.
						}
	ApplyDamage(damageTable)
end

function modifier_liquid_fire_lua:DeclareFunctions() return {MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT} end

function modifier_liquid_fire_lua:GetModifierAttackSpeedBonus_Constant()

    if not self:GetAbility() or self:GetAbility():IsNull() then
        return
    end

	if self:GetCaster() then
		-- local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_jakiro_4")
	    -- if talent and talent:GetLevel() > 0 then
	    --    return self:GetAbility():GetSpecialValueFor("slow_attack_speed_pct")-60
	    -- else
		--    return self:GetAbility():GetSpecialValueFor("slow_attack_speed_pct")
	    -- end
		return self:GetAbility():GetSpecialValueFor("slow_attack_speed_pct")
	else
		return self:GetAbility():GetSpecialValueFor("slow_attack_speed_pct")
	end
end

modifier_liquid_fire_lua_orb = class({})

function modifier_liquid_fire_lua_orb:IsDebuff()			return false end
function modifier_liquid_fire_lua_orb:IsHidden() 			return true end
function modifier_liquid_fire_lua_orb:IsPurgable() 		return false end
function modifier_liquid_fire_lua_orb:IsPurgeException() 	return false end

function modifier_liquid_fire_lua_orb:OnCreated()
	if IsServer() then
		if self:GetParent():IsRangedAttacker() then
			self.pfx = self:GetParent():GetRangedProjectileName()
		end
		self:StartIntervalThink(0.1)
	end
end

function modifier_liquid_fire_lua_orb:OnIntervalThink()
	if self:GetAbility():IsCooldownReady() and self:GetAbility():GetAutoCastState() then
		if self.pfx then
			self:GetParent():SetRangedProjectileName("particles/units/heroes/hero_jakiro/jakiro_base_attack_fire.vpcf")
		end
		if not self.pfx2 then
			self.pfx2 = ParticleManager:CreateParticle("particles/units/heroes/hero_jakiro/jakiro_liquid_fire_ready.vpcf", PATTACH_POINT_FOLLOW, self:GetParent())
			ParticleManager:SetParticleControlEnt(self.pfx2, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack2", self:GetParent():GetAbsOrigin(), true)
		end
	else
		if self.pfx then
			self:GetParent():SetRangedProjectileName(self.pfx)
		end
		if self.pfx2 then
			ParticleManager:DestroyParticle(self.pfx2, false)
			ParticleManager:ReleaseParticleIndex(self.pfx2)
			self.pfx2 = nil
		end
	end
end

function modifier_liquid_fire_lua_orb:OnDestroy()
	if IsServer() and self.pfx then
		self.pfx = nil
		if self.pfx2 then
			ParticleManager:DestroyParticle(self.pfx2, false)
			ParticleManager:ReleaseParticleIndex(self.pfx2)
			self.pfx2 = nil
		end
	end
end

function modifier_liquid_fire_lua_orb:DeclareFunctions() return {MODIFIER_EVENT_ON_ATTACK, MODIFIER_EVENT_ON_ATTACK_LANDED} end
function modifier_liquid_fire_lua_orb:OnAttack(keys)
	if not IsServer() then
		return
	end
	if keys.attacker ~= self:GetParent() or self:GetParent():IsSilenced() or self:GetParent():IsIllusion() or not self:GetAbility():IsCooldownReady() or not self:GetAbility():GetAutoCastState() then
		return
	end
	self:SetStackCount(1)
	self:GetParent():StartGesture(ACT_DOTA_ATTACK2)
	self:GetAbility():UseResources(true,false, true, true)
end
function modifier_liquid_fire_lua_orb:OnAttackLanded(keys)
	if not IsServer() then
		return
	end
	if keys.attacker ~= self:GetParent() or self:GetParent():IsIllusion() then
		return
	end
	if self:GetStackCount() ~= 1 then
		return
	end
	self:SetStackCount(0)
	self:GetAbility():OnProjectileHit(keys.target, keys.target:GetAbsOrigin())
end