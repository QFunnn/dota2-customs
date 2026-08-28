--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local campfires_vectors = {
	{ pos = Vector(-10816, 6528, 416), range = 480 },
	{ pos = Vector(-9110, 7560, 416), range = 405 },
	{ pos = Vector(-9692, 9345, 416), range = 395 },
	{ pos = Vector(-11461, 10848, 416), range = 455 },
	{ pos = Vector(-11880, 8536, 367), range = 460 },
	{ pos = Vector(-14154, 9952, 367), range = 450 },
	{ pos = Vector(-15040, 7847, 367), range = 700 },
	{ pos = Vector(-15520, 11232, 240), range = 480 },
	{ pos = Vector(-14802, 13406, 240), range = 380 },
	{ pos = Vector(-14779, 14689, 240), range = 380 },
	{ pos = Vector(-15616, 14049, 240), range = 380 },
}

modifier_cold_map_ability = class({})

function modifier_cold_map_ability:IsHidden()
	return self:IsProtected()
end

function modifier_cold_map_ability:IsDebuff()
	return true
end

function modifier_cold_map_ability:IsPurgable()
	return false
end

function modifier_cold_map_ability:GetTexture()
	return "cold"
end

function modifier_cold_map_ability:OnCreated(kv)
	if IsServer() then
		self:StartIntervalThink(0.5)
	end
end

function modifier_cold_map_ability:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DISABLE_HEALING,
	}
	return funcs
end

function modifier_cold_map_ability:GetDisableHealing()
	if self:IsProtected() then
		return 0
	end
	return 1
end

function modifier_cold_map_ability:OnIntervalThink()
	if IsServer() then
		local parent = self:GetParent()

		local trigger = Entities:FindByName(nil, "cold_trigger")
		if trigger and not trigger:IsTouching(parent) then
			self:Destroy()
		end

		if self:IsProtected() then
			return
		end
		if parent:IsAlive() then
			local damageTable = {
				victim = parent,
				attacker = parent,
				damage = parent:GetMaxHealth() * 0.015,
				damage_type = DAMAGE_TYPE_PURE,
				damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
					+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
			}

			parent:EmitSound("Hero_Ancient_Apparition.IceBlastRelease.Tick")

			ApplyDamage(damageTable)
		end
	end
end

function modifier_cold_map_ability:IsProtected()
	local parent = self:GetParent()
	if parent:HasModifier("modifier_item_lich_heart") then
		return true
	end
	local parent_pos = parent:GetAbsOrigin()
	for _, fire in ipairs(campfires_vectors) do
		if (parent_pos - fire.pos):Length2D() < fire.range then
			return true
		end
	end
	return false
end