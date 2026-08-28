--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_broodmother_web",
	"heroes/hero_broodmother/broodmother_web/broodmother_web",
	LUA_MODIFIER_MOTION_NONE
)

broodmother_web = class({})

function broodmother_web:GetCastRange(location, target)
	return self:GetSpecialValueFor("radius")
end

function broodmother_web:OnSpellStart(scream_damage_pct, source_unit, is_talent)
	if IsServer() then
		local caster = self:GetCaster()
		local position = caster:GetAbsOrigin()
		local damage = self:GetSpecialValueFor("damage")
		local duration = self:GetSpecialValueFor("duration")
		local radius = self:GetSpecialValueFor("radius")

		local ability = self:GetCaster():FindAbilityByName("special_bonus_broodmother_1")
		if ability ~= nil and ability:GetLevel() > 0 then
			damage = damage + 175
		end

		self:GetCaster():EmitSound("Hero_Broodmother.SpawnSpiderlingsCast")

		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			position,
			nil,
			radius,
			self:GetAbilityTargetTeam(),
			self:GetAbilityTargetType(),
			self:GetAbilityTargetFlags(),
			FIND_ANY_ORDER,
			false
		)
		for _, enemy in pairs(enemies) do
			local projectile = {
				Target = enemy,
				Source = caster,
				Ability = self,
				EffectName = "particles/units/heroes/hero_broodmother/broodmother_silken_bola_projectile.vpcf",
				iMoveSpeed = 800,
				vSourceLoc = position,
				bDrawsOnMinimap = false,
				bDodgeable = true,
				bIsAttack = false,
				bVisibleToEnemies = true,
				bReplaceExisting = false,
				flExpireTime = GameRules:GetGameTime() + 20,
				bProvidesVision = false,
				iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
				ExtraData = { damage = damage, duration = duration },
			}
			ProjectileManager:CreateTrackingProjectile(projectile)
		end
	end
end

function broodmother_web:OnProjectileHit_ExtraData(target, location, ExtraData)
	if IsServer() then
		if target then
			local caster = self:GetCaster()
			target:EmitSound("Hero_Broodmother.SpawnSpiderlingsImpact")
			ApplyDamage({
				victim = target,
				attacker = caster,
				ability = self,
				damage = ExtraData.damage,
				damage_type = self:GetAbilityDamageType(),
			})
			target:AddNewModifier(caster, self, "modifier_broodmother_web", { duration = ExtraData.duration })
		end
	end
end

--------------------------------------------------------------------------------------------------------

modifier_broodmother_web = class({})

function modifier_broodmother_web:IsDebuff()
	return true
end
function modifier_broodmother_web:IsHidden()
	return false
end
function modifier_broodmother_web:IsPurgable()
	return false
end

function modifier_broodmother_web:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_broodmother_web:GetModifierMoveSpeedBonus_Percentage(params)
	return self:GetAbility():GetSpecialValueFor("slow") * -1
end

function modifier_broodmother_web:GetEffectName()
	return "particles/units/heroes/hero_broodmother/broodmother_silken_bola_root_b.vpcf"
end

function modifier_broodmother_web:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end