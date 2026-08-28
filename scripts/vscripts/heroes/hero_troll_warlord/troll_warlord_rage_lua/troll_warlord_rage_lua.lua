--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_troll_warlord_rage_lua_ranged",
	"heroes/hero_troll_warlord/troll_warlord_rage_lua/troll_warlord_rage_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_imba_berserkers_rage_slow",
	"heroes/hero_troll_warlord/troll_warlord_rage_lua/troll_warlord_rage_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_troll_warlord_rage_lua_melee",
	"heroes/hero_troll_warlord/troll_warlord_rage_lua/troll_warlord_rage_lua",
	LUA_MODIFIER_MOTION_NONE
)

troll_warlord_rage_lua = class({})

function troll_warlord_rage_lua:IsHiddenWhenStolen()
	return false
end
function troll_warlord_rage_lua:IsRefreshable()
	return true
end
function troll_warlord_rage_lua:IsStealable()
	return false
end
function troll_warlord_rage_lua:IsNetherWardStealable()
	return false
end
function troll_warlord_rage_lua:ResetToggleOnRespawn()
	return true
end

function troll_warlord_rage_lua:ProcsMagicStick()
	return false
end

function troll_warlord_rage_lua:OnUpgrade()
	if IsServer() then
		local caster = self:GetCaster()

		if self:GetLevel() == 1 then
			caster:FindAbilityByName("troll_warlord_whirling_axes_melee_lua"):SetActivated(false)
		end

		if
			not (
				caster:HasModifier("modifier_troll_warlord_rage_lua_ranged")
				or caster:HasModifier("modifier_troll_warlord_rage_lua_melee")
			)
		then
			if self:GetToggleState() then
				caster:AddNewModifier(caster, self, "modifier_troll_warlord_rage_lua_melee", {})
			else
				caster:AddNewModifier(caster, self, "modifier_troll_warlord_rage_lua_ranged", {})
			end
		end
	end
end

function troll_warlord_rage_lua:OnOwnerSpawned()
	if self.mode == 1 then
		self:ToggleAbility()
		self:ToggleAbility()
		self:ToggleAbility()
	end
end

function troll_warlord_rage_lua:OnToggle()
	if IsServer() then
		local caster = self:GetCaster()
		caster:EmitSound("Hero_TrollWarlord.BerserkersRage.Toggle")
		if RollPercentage(25) and (caster:GetName() == "npc_dota_hero_troll_warlord") and not caster.beserk_sound then
			caster:EmitSound("troll_warlord_troll_beserker_0" .. math.random(1, 4))
			caster.beserk_sound = true
			Timers:CreateTimer(10, function()
				caster.beserk_sound = nil
			end)
		end

		caster:StartGesture(ACT_DOTA_CAST_ABILITY_1)

		if caster:HasModifier("modifier_troll_warlord_rage_lua_ranged") and self:GetToggleState() then
			caster:RemoveModifierByName("modifier_troll_warlord_rage_lua_ranged")
			caster:AddNewModifier(caster, self, "modifier_troll_warlord_rage_lua_melee", {})
			--			caster:SwapAbilities("troll_warlord_whirling_axes_ranged_lua", "troll_warlord_whirling_axes_melee_lua", false, true)

			caster:FindAbilityByName("troll_warlord_whirling_axes_melee_lua"):SetActivated(true)
			caster:FindAbilityByName("troll_warlord_whirling_axes_ranged_lua"):SetActivated(false)
			caster:SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
			self.mode = 2
		else
			caster:RemoveModifierByName("modifier_troll_warlord_rage_lua_melee")
			caster:AddNewModifier(caster, self, "modifier_troll_warlord_rage_lua_ranged", {})
			--			caster:SwapAbilities("troll_warlord_whirling_axes_ranged_lua", "troll_warlord_whirling_axes_melee_lua", true, false)

			caster:FindAbilityByName("troll_warlord_whirling_axes_melee_lua"):SetActivated(false)
			caster:FindAbilityByName("troll_warlord_whirling_axes_ranged_lua"):SetActivated(true)
			caster:SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)
			self.mode = 1
		end
	end
end

function troll_warlord_rage_lua:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_troll_warlord_rage_lua_melee") then
		return "troll_warlord_berserkers_rage_active"
	else
		return "troll_warlord_berserkers_rage"
	end
end

-------------------------------------------

modifier_troll_warlord_rage_lua_melee = modifier_troll_warlord_rage_lua_melee or class({})
function modifier_troll_warlord_rage_lua_melee:AllowIllusionDuplicate()
	return true
end
function modifier_troll_warlord_rage_lua_melee:IsDebuff()
	return false
end
function modifier_troll_warlord_rage_lua_melee:IsHidden()
	return true
end
function modifier_troll_warlord_rage_lua_melee:IsPurgable()
	return false
end
function modifier_troll_warlord_rage_lua_melee:IsPurgeException()
	return false
end
function modifier_troll_warlord_rage_lua_melee:IsStunDebuff()
	return false
end
function modifier_troll_warlord_rage_lua_melee:RemoveOnDeath()
	return false
end

function modifier_troll_warlord_rage_lua_melee:OnCreated()
	self.bonus_hp = self:GetAbility():GetSpecialValueFor("bonus_hp")
end

function modifier_troll_warlord_rage_lua_melee:DeclareFunctions()
	local decFuns = {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
	}
	return decFuns
end

function modifier_troll_warlord_rage_lua_melee:GetAttackSound()
	return "Hero_TrollWarlord.ProjectileImpact"
end

function modifier_troll_warlord_rage_lua_melee:GetModifierMoveSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_move_speed")
end

function modifier_troll_warlord_rage_lua_melee:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_troll_warlord_rage_lua_melee:GetModifierBaseAttackTimeConstant()
	local bat = self:GetAbility():GetSpecialValueFor("base_attack_time")
	local parent = self:GetParent()
	if parent and parent.dms_bat_factor then
		bat = bat * parent.dms_bat_factor
	end
	return bat
end

function modifier_troll_warlord_rage_lua_melee:GetModifierHealthBonus()
	return self.bonus_hp
end

function modifier_troll_warlord_rage_lua_melee:GetActivityTranslationModifiers()
	if self:GetParent():GetName() == "npc_dota_hero_troll_warlord" then
		return "melee"
	end
	return 0
end

function modifier_troll_warlord_rage_lua_melee:GetPriority()
	return 1
end

function modifier_troll_warlord_rage_lua_melee:GetModifierAttackRangeBonus()
	return -350
end

function modifier_troll_warlord_rage_lua_melee:GetEffectName()
	return "particles/units/heroes/hero_troll_warlord/troll_warlord_berserk_buff.vpcf"
end

function modifier_troll_warlord_rage_lua_melee:GetEffectAttachType()
	return PATTACH_POINT_FOLLOW
end
-------------------------------------------
modifier_troll_warlord_rage_lua_ranged = modifier_troll_warlord_rage_lua_ranged or class({})
function modifier_troll_warlord_rage_lua_ranged:AllowIllusionDuplicate()
	return true
end
function modifier_troll_warlord_rage_lua_ranged:IsDebuff()
	return false
end
function modifier_troll_warlord_rage_lua_ranged:IsHidden()
	return true
end
function modifier_troll_warlord_rage_lua_ranged:IsPurgable()
	return false
end
function modifier_troll_warlord_rage_lua_ranged:IsPurgeException()
	return false
end
function modifier_troll_warlord_rage_lua_ranged:IsStunDebuff()
	return false
end
function modifier_troll_warlord_rage_lua_ranged:RemoveOnDeath()
	return false
end
-------------------------------------------

function modifier_troll_warlord_rage_lua_ranged:DeclareFunctions()
	local decFuns = {
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
	}
	return decFuns
end

function modifier_troll_warlord_rage_lua_ranged:GetModifierBaseAttackTimeConstant()
	local bat = 1.5
	local parent = self:GetParent()
	if parent and parent.dms_bat_factor then
		bat = bat * parent.dms_bat_factor
	end
	return bat
end

function modifier_troll_warlord_rage_lua_ranged:GetPriority()
	return 1
end