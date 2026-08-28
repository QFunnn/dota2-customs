--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_dagon_lua_passive", "items/custom_items/item_dagon.lua", LUA_MODIFIER_MOTION_NONE)

item_dagon_lua_1 = item_dagon_lua_1 or class({})
item_dagon_lua_2 = item_dagon_lua_1 or class({})
item_dagon_lua_3 = item_dagon_lua_1 or class({})
item_dagon_lua_4 = item_dagon_lua_1 or class({})
item_dagon_lua_5 = item_dagon_lua_1 or class({})

function item_dagon_lua_1:GetIntrinsicModifierName()
	return "modifier_item_dagon_lua_passive"
end

function DagonizeIt(caster, ability, source, target, damage)
	if not IsServer() then
		return
	end
	local dagon_pfx =
		ParticleManager:CreateParticle("particles/items_fx/dagon.vpcf", PATTACH_RENDERORIGIN_FOLLOW, source)
	ParticleManager:SetParticleControlEnt(
		dagon_pfx,
		0,
		source,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		source:GetAbsOrigin(),
		false
	)
	ParticleManager:SetParticleControlEnt(
		dagon_pfx,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		false
	)
	ParticleManager:SetParticleControl(dagon_pfx, 2, Vector(damage, 0, 0))
	ParticleManager:SetParticleControl(dagon_pfx, 3, Vector(0.3, 0, 0))
	ParticleManager:ReleaseParticleIndex(dagon_pfx)

	if target:IsAlive() then
		ApplyDamage({
			attacker = caster,
			victim = target,
			ability = ability,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
		})
	end
end

function item_dagon_lua_1:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if target:GetTeam() ~= caster:GetTeam() then
		if target:TriggerSpellAbsorb(self) then
			return nil
		end
	end

	if target:IsMagicImmune() then
		return nil
	end

	local damage = self:GetSpecialValueFor("damage")
	local bounce_damage = damage / 100 * self:GetSpecialValueFor("bounce_damage_pct")
	local bounce_range = self:GetSpecialValueFor("bounce_range")

	local targets_hit = { target }
	local search_sources = { target }

	caster:EmitSound("DOTA_Item.Dagon.Activate")
	target:EmitSound("DOTA_Item.Dagon" .. self:GetLevel() .. ".Target")

	if target:IsIllusion() and not Custom_bIsStrongIllusion(target) then
		target:Kill(self, caster)
	end

	DagonizeIt(caster, self, caster, target, damage)

	while #search_sources > 0 do
		local new_sources = {}
		for _, potential_source in ipairs(search_sources) do
			local nearby_enemies = FindUnitsInRadius(
				caster:GetTeamNumber(),
				potential_source:GetAbsOrigin(),
				potential_source,
				bounce_range,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
				FIND_ANY_ORDER,
				false
			)
			for _, potential_target in ipairs(nearby_enemies) do
				local already_hit = false
				for _, hit_target in ipairs(targets_hit) do
					if potential_target == hit_target then
						already_hit = true
						break
					end
				end
				if not already_hit then
					DagonizeIt(caster, self, potential_source, potential_target, bounce_damage)
					targets_hit[#targets_hit + 1] = potential_target
					new_sources[#new_sources + 1] = potential_target
				end
			end
		end
		search_sources = new_sources
	end
end

modifier_item_dagon_lua_passive = modifier_item_dagon_lua_passive or class({})

function modifier_item_dagon_lua_passive:IsHidden()
	return true
end
function modifier_item_dagon_lua_passive:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_dagon_lua_passive:OnCreated()
	self.bonus_all_stats = self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_dagon_lua_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end

function modifier_item_dagon_lua_passive:GetModifierBonusStats_Strength()
	return self.bonus_all_stats
end

function modifier_item_dagon_lua_passive:GetModifierBonusStats_Agility()
	return self.bonus_all_stats
end

function modifier_item_dagon_lua_passive:GetModifierBonusStats_Intellect()
	return self.bonus_all_stats
end

-- LinkLuaModifier("modifier_item_dagon_lua_passive", "items/custom_items/item_dagon.lua", LUA_MODIFIER_MOTION_NONE)

-- item_dagon_lua_1 = item_dagon_lua_1 or class({})
-- item_dagon_lua_2 = item_dagon_lua_1 or class({})
-- item_dagon_lua_3 = item_dagon_lua_1 or class({})
-- item_dagon_lua_4 = item_dagon_lua_1 or class({})
-- item_dagon_lua_5 = item_dagon_lua_1 or class({})

-- function item_dagon_lua_1:GetIntrinsicModifierName()
-- 	return "modifier_item_dagon_lua_passive"
-- end

-- function DagonizeIt(caster, ability, source, target, damage)
-- 	if not IsServer() then return end
-- 	local dagon_pfx = ParticleManager:CreateParticle("particles/items_fx/dagon.vpcf", PATTACH_RENDERORIGIN_FOLLOW, source)
-- 	ParticleManager:SetParticleControlEnt(dagon_pfx, 0, source, PATTACH_POINT_FOLLOW, "attach_attack1", source:GetAbsOrigin(), false)
-- 	ParticleManager:SetParticleControlEnt(dagon_pfx, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false)
-- 	ParticleManager:SetParticleControl(dagon_pfx, 2, Vector(damage, 0, 0))
-- 	ParticleManager:SetParticleControl(dagon_pfx, 3, Vector(0.3, 0, 0))
-- 	ParticleManager:ReleaseParticleIndex(dagon_pfx)

-- 	if target:IsAlive() then
-- 		ApplyDamage({
-- 			attacker = caster,
-- 			victim = target,
-- 			ability = ability,
-- 			damage = damage,
-- 			damage_type = DAMAGE_TYPE_MAGICAL
-- 		})
-- 	end
-- end

-- function item_dagon_lua_1:OnSpellStart()
-- 	if not IsServer() then return end

-- 	local caster = self:GetCaster()
-- 	local target = self:GetCursorTarget()

-- 	if target:GetTeam() ~= caster:GetTeam() then
-- 		if target:TriggerSpellAbsorb(self) then
-- 			return nil
-- 		end
-- 	end

-- 	if target:IsMagicImmune() then
-- 		return nil
-- 	end

-- 	local damage = self:GetSpecialValueFor("damage")
-- 	local bounce_damage = damage / 100 * self:GetSpecialValueFor("bounce_damage_pct")
-- 	local bounce_range = self:GetSpecialValueFor("bounce_range")

-- 	local targets_hit = {
-- 		target
-- 	}
-- 	local search_sources = {
-- 		target
-- 	}

-- 	caster:EmitSound("DOTA_Item.Dagon.Activate")

-- 	target:EmitSound("DOTA_Item.Dagon"..self:GetLevel()..".Target")

-- 	if target:IsIllusion() and not Custom_bIsStrongIllusion(target) then
-- 		target:Kill(self, caster)
-- 	end

-- 	DagonizeIt(caster, self, caster, target, damage)

-- 	while #search_sources > 0 do
-- 		for potential_source_index, potential_source in pairs(search_sources) do
-- 			local nearby_enemies = FindUnitsInRadius(caster:GetTeamNumber(), potential_source:GetAbsOrigin(), potential_source, bounce_range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)
-- 			for _, potential_target in pairs(nearby_enemies) do
-- 				local already_hit = false
-- 				for _, hit_target in pairs(targets_hit) do
-- 					if potential_target == hit_target then
-- 						already_hit = true
-- 						break
-- 					end
-- 				end
-- 				if not already_hit then
-- 					DagonizeIt(caster, self, potential_source, potential_target, bounce_damage)
-- 					targets_hit[#targets_hit+1] = potential_target
-- 					search_sources[#search_sources+1] = potential_target
-- 				end
-- 			end
-- 			table.remove(search_sources, potential_source_index)
-- 		end
-- 	end
-- end

-- modifier_item_dagon_lua_passive = modifier_item_dagon_lua_passive or class({})

-- function modifier_item_dagon_lua_passive:IsHidden() return true end
-- function modifier_item_dagon_lua_passive:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

-- function modifier_item_dagon_lua_passive:OnCreated()
-- 	self.bonus_all_stats = self:GetAbility():GetSpecialValueFor("bonus_all_stats")
-- end

-- function modifier_item_dagon_lua_passive:DeclareFunctions()
-- 	return {
-- 		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
-- 		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
-- 		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
-- 	}
-- end

-- function modifier_item_dagon_lua_passive:GetModifierBonusStats_Strength()
-- 	return self.bonus_all_stats
-- end

-- function modifier_item_dagon_lua_passive:GetModifierBonusStats_Agility()
-- 	return self.bonus_all_stats
-- end

-- function modifier_item_dagon_lua_passive:GetModifierBonusStats_Intellect()
-- 	return self.bonus_all_stats
-- end