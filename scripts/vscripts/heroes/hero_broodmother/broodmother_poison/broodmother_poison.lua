--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_broodmother_poison_debuff",
	"heroes/hero_broodmother/broodmother_poison/broodmother_poison",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_broodmother_poison",
	"heroes/hero_broodmother/broodmother_poison/broodmother_poison",
	LUA_MODIFIER_MOTION_NONE
)

broodmother_poison = class({})

function broodmother_poison:GetIntrinsicModifierName()
	return "modifier_broodmother_poison"
end

--------------------------------------------------------

modifier_broodmother_poison = class({})

function modifier_broodmother_poison:IsHidden()
	return true
end
function modifier_broodmother_poison:IsPurgable()
	return false
end

function modifier_broodmother_poison:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
	return funcs
end

function modifier_broodmother_poison:GetModifierProcAttack_Feedback(params)
	if IsServer() then
		if params.attacker == self:GetParent() then
			modifier = params.target:AddNewModifier(
				self:GetCaster(),
				self:GetAbility(),
				"modifier_broodmother_poison_debuff",
				{ duration = self:GetAbility():GetSpecialValueFor("duration") }
			)
			if modifier:GetStackCount() < self:GetAbility():GetSpecialValueFor("stacks") then
				modifier:IncrementStackCount()
			end
		end
	end
end

------------------------------------------------------------------

modifier_broodmother_poison_debuff = class({})

function modifier_broodmother_poison_debuff:IsHidden()
	return false
end

function modifier_broodmother_poison_debuff:IsDebuff()
	return true
end

function modifier_broodmother_poison_debuff:IsPurgable()
	return false
end

function modifier_broodmother_poison_debuff:OnCreated(kv)
	if IsServer() then
		self:StartIntervalThink(1)
	end
end

function modifier_broodmother_poison_debuff:OnIntervalThink()
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	local ability = self:GetCaster():FindAbilityByName("special_bonus_broodmother_3")
	if ability ~= nil and ability:GetLevel() > 0 then
		self.damage = self.damage + 40
	end
	ApplyDamage({
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage_type = DAMAGE_TYPE_MAGICAL,
		damage = self:GetStackCount() * self.damage,
		ability = self:GetAbility(),
	})
end

function modifier_broodmother_poison_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_broodmother_poison_debuff:GetModifierPhysicalArmorBonus(params)
	return -self:GetAbility():GetSpecialValueFor("disarm")
end