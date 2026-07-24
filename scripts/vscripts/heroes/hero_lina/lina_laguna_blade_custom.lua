--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_lina_laguna_blade_custom", "heroes/hero_lina/lina_laguna_blade_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lina_laguna_blade_custom_passive", "heroes/hero_lina/lina_laguna_blade_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lina_laguna_blade_custom_damage", "heroes/hero_lina/lina_laguna_blade_custom", LUA_MODIFIER_MOTION_NONE )

lina_laguna_blade_custom = class({})

lina_laguna_blade_custom.bRoundDueled = false

function lina_laguna_blade_custom:GetIntrinsicModifierName()
	return "modifier_lina_laguna_blade_custom_passive"
end

function lina_laguna_blade_custom:OnUpgrade()
	local caster = self:GetCaster()

	if not caster:HasModifier("modifier_lina_laguna_blade_custom_passive") then
		caster:AddNewModifier(caster, self, "modifier_lina_laguna_blade_custom_passive", {})
	end
end

function lina_laguna_blade_custom:GetAbilityDamageType()
	local bHasFacet = self:GetSpecialValueFor("stun_facet") > 0
	if bHasFacet then
		return DAMAGE_TYPE_PURE
	end

	return DAMAGE_TYPE_MAGICAL
end

function lina_laguna_blade_custom:GetAOERadius()
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor("radius")
	end
	return 0
end

function lina_laguna_blade_custom:CastFilterResultTarget( hTarget )
	if hTarget:IsMagicImmune() and (not self:GetCaster():HasTalent("special_bonus_unique_lina_7")) then
		return UF_FAIL_MAGIC_IMMUNE_ENEMY
	end

	if not IsServer() then return UF_SUCCESS end
	local nResult = UnitFilter(
		hTarget,
		self:GetAbilityTargetTeam(),
		self:GetAbilityTargetType(),
		self:GetAbilityTargetFlags(),
		self:GetCaster():GetTeamNumber()
	)

	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end

function lina_laguna_blade_custom:OnSpellStart()
	if not IsServer() then return end
	local delay = self:GetSpecialValueFor( "damage_delay" )
	local radius = self:GetSpecialValueFor("radius")
	local target = self:GetCursorTarget()

	if self:GetCaster():HasScepter() then
		local targets = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
		for _,enemy in pairs( targets ) do
			self:PlayEffects( enemy )
			enemy:AddNewModifier( self:GetCaster(), self, "modifier_lina_laguna_blade_custom", { duration = delay } )
		end
	else
		self:PlayEffects( target )
		target:AddNewModifier( self:GetCaster(), self, "modifier_lina_laguna_blade_custom", { duration = delay } )
	end
end

function lina_laguna_blade_custom:PlayEffects( target )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_lina/lina_spell_laguna_blade.vpcf", PATTACH_CUSTOMORIGIN, nil )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self:GetCaster():EmitSound("Ability.LagunaBladeImpact")
end

modifier_lina_laguna_blade_custom = class({})

function modifier_lina_laguna_blade_custom:IsHidden()
	return true
end

function modifier_lina_laguna_blade_custom:IsPurgable()
	return false
end

function modifier_lina_laguna_blade_custom:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_lina_laguna_blade_custom:OnCreated( kv )
	if not IsServer() then return end

	local grace_period = self:GetAbility():GetSpecialValueFor("grace_period")

	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_lina_laguna_blade_custom_damage", {duration = grace_period})

	local bonus_damage = 0

	local bonus_damage_modifier = self:GetCaster():FindModifierByName("modifier_lina_laguna_blade_custom_passive")

	if bonus_damage_modifier then
		bonus_damage = bonus_damage + ( self:GetAbility():GetSpecialValueFor("damage_per_kill") * bonus_damage_modifier:GetStackCount() )
	end
	
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" ) + bonus_damage
end

function modifier_lina_laguna_blade_custom:OnDestroy()
	if not IsServer() then return end
	if self:GetParent():IsInvulnerable() then return end
	if self:GetParent():TriggerSpellAbsorb( self:GetAbility() ) then return end
	-- if self:GetAbility():GetSpecialValueFor("stun_facet") > 0 then
	-- 	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", {duration=self:GetAbility():GetSpecialValueFor("stun_facet")})
	-- end
	ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage, damage_type = self:GetAbility():GetAbilityDamageType(), ability = self:GetAbility() })
end

modifier_lina_laguna_blade_custom_passive = class({})

--function modifier_lina_laguna_blade_custom_passive:IsHidden() return self:GetStackCount() == 0 end
function modifier_lina_laguna_blade_custom_passive:IsPurgable() return false end
function modifier_lina_laguna_blade_custom_passive:IsPurgeException() return false end
function modifier_lina_laguna_blade_custom_passive:RemoveOnDeath() return false end
function modifier_lina_laguna_blade_custom_passive:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_PERMANENT end
function modifier_lina_laguna_blade_custom_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP
	}
end

function modifier_lina_laguna_blade_custom_passive:OnTooltip()
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("damage_per_kill")
end

-- Стаки бонус-урона (за килы) храним на самом герое: при отражении Лагуны
-- (ванильные Lotus/Mirror/Counterspell) движок сносит общий по имени intrinsic-модификатор
-- у отражающего и обратно его не выдаёт. Восстанавливаем сохранённое значение / пере-выдаём
-- пассивку, чтобы стаки не пропадали.
function modifier_lina_laguna_blade_custom_passive:OnCreated()
	if not IsServer() then return end
	local stored = self:GetParent().laguna_kill_stacks
	if stored and stored > 0 then
		self:SetStackCount(stored)
	end
end

function modifier_lina_laguna_blade_custom_passive:OnRefresh()
	self:OnCreated()
end

function modifier_lina_laguna_blade_custom_passive:OnDestroy()
	if not IsServer() then return end
	local hParent = self:GetParent()
	if not hParent or hParent:IsNull() then return end
	-- Ложное удаление от отражения (ванильные Lotus/Mirror/Counterspell): копия Лагуны
	-- при очистке сносит общий по имени intrinsic-модификатор, и реальная способность
	-- обратно его НЕ выдаёт. Если способность всё ещё выучена — пере-выдаём пассивку на
	-- следующий кадр, OnCreated восстановит стаки. При relearn способность реально
	-- удаляется => на след. кадре её уже нет => пропуск.
	Timers:CreateTimer(0, function()
		if not hParent or hParent:IsNull() then return end
		local ab = hParent:FindAbilityByName("lina_laguna_blade_custom")
		if ab and not ab:IsNull() and ab:GetLevel() > 0
			and not hParent:HasModifier("modifier_lina_laguna_blade_custom_passive") then
			hParent:AddNewModifier(hParent, ab, "modifier_lina_laguna_blade_custom_passive", {})
		end
	end)
end

function modifier_lina_laguna_blade_custom_passive:OnDeathEvent(params)
	if params.unit == nil or params.unit == self:GetParent() then return end

	local bHasBuff = params.unit:FindModifierByNameAndCaster("modifier_lina_laguna_blade_custom_damage", self:GetParent()) ~= nil
	if not bHasBuff then return end

	if not params.unit:IsHero() then
		if self:GetAbility().bRoundDueled == true then return end
		self:GetAbility().bRoundDueled = true
	end

	self:IncrementStackCount()
	self:GetParent().laguna_kill_stacks = self:GetStackCount()
end

modifier_lina_laguna_blade_custom_damage = class({})

function modifier_lina_laguna_blade_custom_damage:IsHidden() return true end
function modifier_lina_laguna_blade_custom_damage:IsPurgable() return false end