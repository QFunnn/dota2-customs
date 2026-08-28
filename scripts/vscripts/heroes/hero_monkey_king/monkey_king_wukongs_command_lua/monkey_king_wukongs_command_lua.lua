--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_monkey_king_wukongs_command_lua_solider_status",
	"heroes/hero_monkey_king/monkey_king_wukongs_command_lua/monkey_king_wukongs_command_lua",
	LUA_MODIFIER_MOTION_NONE
)

monkey_king_wukongs_command_lua = class({})

function monkey_king_wukongs_command_lua:OnAbilityPhaseStart()
	self:GetCaster():EmitSound("Hero_MonkeyKing.FurArmy.Channel")
	self.castHandle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_monkey_king/monkey_king_fur_army_cast.vpcf",
		PATTACH_ABSORIGIN,
		self:GetCaster()
	)
	return true
end

function monkey_king_wukongs_command_lua:OnAbilityPhaseInterrupted()
	self:GetCaster():StopSound("Hero_MonkeyKing.FurArmy.Channel")
	if self.castHandle then
		ParticleManager:DestroyParticle(self.castHandle, true)
		ParticleManager:ReleaseParticleIndex(self.castHandle)
		self.castHandle = nil
	end
end

function monkey_king_wukongs_command_lua:OnSpellStart()
	local duration = self:GetSpecialValueFor("duration")
	local count = self:GetSpecialValueFor("count")

	local ability = self:GetCaster():FindAbilityByName("special_bonus_monkey_king_7")
	if ability ~= nil and ability:GetLevel() > 0 then
		count = count + 2
	end

	for i = 1, count do
		unit = CreateUnitByName(
			"npc_dota_monkey_clone_hero",
			self:GetCaster():GetOrigin() + RandomVector(RandomInt(0, 150)),
			false,
			self:GetCaster(),
			self:GetCaster(),
			self:GetCaster():GetTeamNumber()
		)
		unit:AddNewModifier(self:GetCaster(), self, "modifier_monkey_king_wukongs_command_lua_solider_status", {})
		unit:AddNewModifier(self:GetCaster(), self, "modifier_kill", { duration = duration })
		FindClearSpaceForUnit(unit, self:GetCaster():GetOrigin() + RandomVector(RandomInt(0, 150)), false)
	end
end

--------------------------------------------------------------------------------------------------------------------------------------

modifier_monkey_king_wukongs_command_lua_solider_status = class({})

function modifier_monkey_king_wukongs_command_lua_solider_status:IsHidden()
	return true
end

function modifier_monkey_king_wukongs_command_lua_solider_status:IsPurgable()
	return false
end

function modifier_monkey_king_wukongs_command_lua_solider_status:OnCreated()
	if not IsServer() then
		return
	end

	self.attack_range = self:GetCaster():Script_GetAttackRange()

	self:GetParent():SetBaseDamageMax(self:GetCaster():GetBaseDamageMax())
	self:GetParent():SetBaseDamageMin(self:GetCaster():GetBaseDamageMin())

	self.min_speed = self:GetCaster():GetAttackSpeed(true)

	local abi = self:GetCaster():FindAbilityByName("monkey_king_banana_attack")
	if abi:GetLevel() > 0 then
		self:GetParent():AddNewModifier(self:GetCaster(), abi, abi:GetIntrinsicModifierName(), {})
	end
	local abi = self:GetCaster():FindAbilityByName("monkey_king_jingu_mastery_lua")
	if abi:GetLevel() > 0 then
		self:GetParent():AddNewModifier(self:GetCaster(), abi, abi:GetIntrinsicModifierName(), {})
	end
	local abi = self:GetCaster():FindAbilityByName("monkey_king_boundless_strike_lua")
	if abi:GetLevel() > 0 then
		self:GetParent():AddNewModifier(self:GetCaster(), abi, abi:GetIntrinsicModifierName(), {})
	end

	for i = 0, 5 do
		local item = self:GetCaster():GetItemInSlot(i)
		if item then
			local new_item = CreateItem(item:GetName(), nil, nil)
			local soldier_item = self:GetParent():AddItem(new_item)
			soldier_item:SetPurchaser(self:GetParent())
			soldier_item:SetLevel(item:GetLevel())
			if item and item:GetCurrentCharges() > 0 and new_item and not new_item:IsNull() then
				new_item:SetCurrentCharges(item:GetCurrentCharges())
			end
			if new_item and not new_item:IsNull() then
				self:GetParent():SwapItems(new_item:GetItemSlot(), i)
			end
		end
	end
	while self:GetCaster():GetLevel() > self:GetParent():GetLevel() do
		self:GetParent():CreatureLevelUp(1)
	end
end

function modifier_monkey_king_wukongs_command_lua_solider_status:GetStatusEffectName()
	return "particles/status_fx/status_effect_monkey_king_fur_army.vpcf"
end

function modifier_monkey_king_wukongs_command_lua_solider_status:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_ATTACKSPEED_BASE_OVERRIDE,
	}
	return funcs
end

function modifier_monkey_king_wukongs_command_lua_solider_status:GetActivityTranslationModifiers(params)
	return "run"
end

function modifier_monkey_king_wukongs_command_lua_solider_status:GetModifierAttackSpeedBaseOverride()
	return self.min_speed
end

function modifier_monkey_king_wukongs_command_lua_solider_status:CheckState()
	return {
		-- [MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		-- [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_MUTED] = true,
	}
end