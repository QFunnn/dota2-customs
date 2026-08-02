--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


drow_cross_lua = class({})

LinkLuaModifier(
	"modifier_drow_cross_lua",
	"heroes/hero_drow_ranger/drow_ranger_powershot_lua/drow_cross_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_drow_cross_lua_debuff",
	"heroes/hero_drow_ranger/drow_ranger_powershot_lua/drow_cross_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_drow_cross_lua_autocast",
	"heroes/hero_drow_ranger/drow_ranger_powershot_lua/drow_cross_lua",
	LUA_MODIFIER_MOTION_NONE
)

function drow_cross_lua:OnSpellStart()
	self.caster = self:GetCaster()
	self.width_initial = 100
	self.width_end = 100
	self.speed = self:GetSpecialValueFor("speed")
	self.distance = self:GetSpecialValueFor("distance")
	self.count = math.floor(self:GetSpecialValueFor("count") / 2)
	self.armorReductionDuration = self:GetSpecialValueFor("armor_reduction_duration")
	self.shot_damage = self:GetSpecialValueFor("damage")

	local front = self:GetCaster():GetForwardVector():Normalized()
	local target_pos = self:GetCaster():GetOrigin() + front * 700

	local center_distance = { 0, 200, 400, 600, 800 }

	local orso_distance = { 100, 200, 300, 400, 500 }

	local a = target_pos
	local b = self:GetCaster():GetOrigin()
	local length = 0
	local c1 = self:GetCaster():GetOrigin()
	local c2 = self:GetCaster():GetOrigin()

	for i = 1, self.count do
		local offset = target_pos

		if a.x - b.x < 0 then
			offset.x = a.x - center_distance[i] * math.cos(math.atan((b.y - a.y) / (b.x - a.x)))
			offset.y = a.y - center_distance[i] * math.sin(math.atan((b.y - a.y) / (b.x - a.x)))
		else
			offset.x = a.x + center_distance[i] * math.cos(math.atan((b.y - a.y) / (b.x - a.x)))
			offset.y = a.y + center_distance[i] * math.sin(math.atan((b.y - a.y) / (b.x - a.x)))
		end

		length = orso_distance[i]
		c1.x = b.x + (
				length
				* (offset.y - b.y)
				/ math.sqrt((offset.x - b.x) * (offset.x - b.x) + (offset.y - b.y) * (offset.y - b.y))
			)
		c1.y = b.y - (
				length
				* (offset.x - b.x)
				/ math.sqrt((offset.x - b.x) * (offset.x - b.x) + (offset.y - b.y) * (offset.y - b.y))
			)
		c2.x = b.x - (
				length
				* (offset.y - b.y)
				/ math.sqrt((offset.x - b.x) * (offset.x - b.x) + (offset.y - b.y) * (offset.y - b.y))
			)
		c2.y = b.y + (
				length
				* (offset.x - b.x)
				/ math.sqrt((offset.x - b.x) * (offset.x - b.x) + (offset.y - b.y) * (offset.y - b.y))
			)

		local vDirection1 = offset - c1
		vDirection1.z = 0.0
		vDirection1 = vDirection1:Normalized()
		local vDirection2 = offset - c2
		vDirection2.z = 0.0
		vDirection2 = vDirection2:Normalized()
		self.speed = self.speed * (self.distance / (self.distance - self.width_initial))

		local info1 = {
			EffectName = "particles/econ/items/windrunner/windranger_arcana/windranger_arcana_spell_powershot_v2.vpcf",
			Ability = self,
			vSpawnOrigin = c1,
			fStartRadius = self.width_initial,
			fEndRadius = self.width_end,
			vVelocity = vDirection1 * self.speed,
			fDistance = self.distance,
			Source = self:GetCaster(),
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			bProvidesVision = true,
			iVisionRadius = 200,
		}
		ProjectileManager:CreateLinearProjectile(info1)
		local info2 = {
			EffectName = "particles/econ/items/windrunner/windranger_arcana/windranger_arcana_spell_powershot_v2.vpcf",
			Ability = self,
			vSpawnOrigin = c2,
			fStartRadius = self.width_initial,
			fEndRadius = self.width_end,
			vVelocity = vDirection2 * self.speed,
			fDistance = self.distance,
			Source = self:GetCaster(),
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			bProvidesVision = true,
			iVisionRadius = 200,
		}
		ProjectileManager:CreateLinearProjectile(info2)
	end

	self:GetCaster():EmitSound("Ability.Powershot") --调用音效
end

function drow_cross_lua:OnProjectileHit(hTarget, vLocation)
	if hTarget and (not hTarget:IsMagicImmune()) and (not hTarget:IsInvulnerable()) then
		local caster = self:GetCaster()

		ApplyDamage({
			attacker = caster,
			victim = hTarget,
			damage = self.shot_damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
				+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
			ability = self,
		})

		local armorReductionMod = hTarget:FindModifierByName("modifier_drow_cross_lua_debuff")

		if armorReductionMod then
			armorReductionMod:ForceRefresh()
		else
			hTarget:AddNewModifier(
				caster,
				self,
				"modifier_drow_cross_lua_debuff",
				{ duration = self.armorReductionDuration }
			)
		end
	end
end

function drow_cross_lua:GetIntrinsicModifierName()
	return "modifier_drow_cross_lua_autocast"
end

function drow_cross_lua:OnAttack(params)
	if not IsServer() then
		return
	end
	if params.attacker ~= self:GetCaster() then
		return
	end
	if not self:GetAutoCastState() then
		return
	end
	if not self:IsCooldownReady() then
		return
	end
	if self:GetManaCost(-1) > self:GetCaster():GetMana() then
		return
	end

	self:OnSpellStart()
	self:UseResources(true, false, false, true)
end

modifier_drow_cross_lua_autocast = class({})

function modifier_drow_cross_lua_autocast:IsHidden()
	return true
end

function modifier_drow_cross_lua_autocast:IsPurgable()
	return false
end

function modifier_drow_cross_lua_autocast:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK,
	}
end

function modifier_drow_cross_lua_autocast:OnAttack(params)
	if not IsServer() then
		return
	end
	if params.attacker ~= self:GetParent() then
		return
	end

	local ability = self:GetAbility()
	if not ability then
		return
	end

	ability:OnAttack(params)
end

modifier_drow_cross_lua_debuff = class({})

function modifier_drow_cross_lua_debuff:IsDebuff()
	return true
end
function modifier_drow_cross_lua_debuff:IsHidden()
	return false
end
function modifier_drow_cross_lua_debuff:IsPurgable()
	return true
end
function modifier_drow_cross_lua_debuff:GetTexture()
	return "powershot"
end
function modifier_drow_cross_lua_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end
function modifier_drow_cross_lua_debuff:OnCreated(kv)
	local ability = self:GetAbility()

	self.armorReduction = ability:GetSpecialValueFor("armor_reduction")
end
function modifier_drow_cross_lua_debuff:GetModifierPhysicalArmorBonus()
	return -self.armorReduction
end

modifier_drow_cross_lua = class({})

function modifier_drow_cross_lua:IsDebuff()
	return false
end
function modifier_drow_cross_lua:IsHidden()
	return true
end
function modifier_drow_cross_lua:IsPurgable()
	return false
end
function modifier_drow_cross_lua:IsPurgeException()
	return false
end
function modifier_drow_cross_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end
function modifier_drow_cross_lua:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.reduction = kv.reduction
end
function modifier_drow_cross_lua:GetModifierMoveSpeedBonus_Percentage(params)
	return self.reduction
end