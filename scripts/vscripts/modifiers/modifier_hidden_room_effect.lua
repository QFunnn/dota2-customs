--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_hidden_room_effect = class({})

function modifier_hidden_room_effect:IsHidden()
	return false
end

function modifier_hidden_room_effect:IsDebuff()
	return true
end

function modifier_hidden_room_effect:IsPurgable()
	return false
end

function modifier_hidden_room_effect:GetTexture()
	return "cold"
end

function modifier_hidden_room_effect:OnCreated(kv)
	if IsServer() then
		self:StartIntervalThink(0.5)
	end
end

function modifier_hidden_room_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DISABLE_HEALING,
	}
	return funcs
end

function modifier_hidden_room_effect:CheckState()
	local state = {
		[MODIFIER_STATE_SILENCED] = true,
	}
	return state
end

function modifier_hidden_room_effect:GetDisableHealing()
	return 1
end

function modifier_hidden_room_effect:OnIntervalThink()
	if IsServer() then
		local parent = self:GetParent()

		local trigger = Entities:FindByName(nil, "hidden_room_trigger")
		if trigger and not trigger:IsTouching(parent) then
			self:Destroy()
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