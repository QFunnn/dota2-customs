--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_aeon_disk_lua = class({})

LinkLuaModifier("modifier_item_aeon_disk_lua", "items/item_aeon_disk_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_aeon_disk_lua_buff", "items/item_aeon_disk_lua", LUA_MODIFIER_MOTION_NONE)

function item_aeon_disk_lua:GetIntrinsicModifierName()
	return "modifier_item_aeon_disk_lua"
end

modifier_item_aeon_disk_lua = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return false end,
	GetAttributes			= function(self) return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end,

    DeclareFunctions        = function (self)
        return {
            MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
			MODIFIER_PROPERTY_HEALTH_BONUS,
			MODIFIER_PROPERTY_MANA_BONUS,
        }
    end,

	GetModifierHealthBonus	= function(self)
		return self.bonus_health or 0
	end,

	GetModifierManaBonus	= function(self)
		return self.bonus_mana or 0
	end
})

function modifier_item_aeon_disk_lua:OnCreated(keys)
	local parent = self:GetParent()
	if IsServer() and parent and parent:IsIllusion() then self:Destroy() return end

	self:OnRefresh(keys)
end

function modifier_item_aeon_disk_lua:OnRefresh(keys)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	if (not self.parent) or (not self.ability) or self.parent:IsNull() or self.ability:IsNull() then return end
	self.bonus_health = self.ability:GetSpecialValueFor("bonus_health") or 0
	self.bonus_mana = self.ability:GetSpecialValueFor("bonus_mana") or 0
	if IsServer() then
		self.health_threshold_pct = 0.01 * (self.ability:GetSpecialValueFor("health_threshold_pct") or 0)
		self.buff_duration = self.ability:GetSpecialValueFor("buff_duration") or 0
	end
end

function modifier_item_aeon_disk_lua:GetModifierIncomingDamage_Percentage(keys)
	if keys.inflictor ~= nil and keys.inflictor:GetAbilityName() == "oracle_false_promise_custom" then
		return 0
	end

	local parent = self:GetParent()
	local health_threshold = parent:GetMaxHealth() * self.health_threshold_pct
	if IsValidEntity(self.ability) and self.ability:IsCooldownReady() and parent:GetHealth() - keys.damage <= (health_threshold + 1) and self.ability:GetItemSlot() <= DOTA_ITEM_SLOT_6 then
		if parent:HasModifier("modifier_nyx_assassin_spiked_carapace_custom") then
			local modifier_nyx_assassin_spiked_carapace_custom = parent:FindModifierByName("modifier_nyx_assassin_spiked_carapace_custom")
			if modifier_nyx_assassin_spiked_carapace_custom.carapaced_units[keys.attacker:entindex()] == nil then
				return
			end
		end
        if parent:HasModifier("modifier_oracle_false_promise_custom") then return end
        if self:GetParent():HasModifier("modifier_duel_curse") then return end
		self.ability:UseResources(true, false, true, true)
		parent:EmitSound("DOTA_Item.ComboBreaker")
		parent:Purge(false, true, false, true, true)
		parent:AddNewModifier(parent, self.ability, "modifier_item_aeon_disk_lua_buff", {duration = self.buff_duration})
		if parent:GetHealth() > health_threshold then
			parent:SetHealth(health_threshold)
		end
		-- -99999999 вместо -100: engine суммирует все INCOMING_DAMAGE_PERCENTAGE
		-- в этом же damage event'е. modifier_loser_curse даёт +20% за стак —
		-- при -100 герой ловит часть урона и умирает «до создания buff'а»
		-- (buff применяется только со следующего event'a). Overwhelmingly
		-- негативное число гарантирует что damage = 0 в текущем хите.
		return -99999999
	end
end

modifier_item_aeon_disk_lua_buff = class({})

function modifier_item_aeon_disk_lua_buff:IsHidden() return false end
function modifier_item_aeon_disk_lua_buff:IsDebuff() return false end
function modifier_item_aeon_disk_lua_buff:IsPurgable() return true end

function modifier_item_aeon_disk_lua_buff:GetStatusEffectName()
	return "particles/status_fx/status_effect_combo_breaker.vpcf"
end

function modifier_item_aeon_disk_lua_buff:StatusEffectPriority()
	return 10
end

function modifier_item_aeon_disk_lua_buff:OnCreated(keys)
	self.status_resistance = self:GetAbility():GetSpecialValueFor("status_resistance")
	self.health_threshold_pct = 0.01 * self:GetAbility():GetSpecialValueFor("health_threshold_pct")

	if IsClient() then return end

	self._aeonDiagStart = GameRules:GetGameTime()
	print(string.format("[AEON_DIAG] BUFF_CREATED t=%.3f duration_arg=%s remaining=%.3f hp=%.1f/%.1f",
		self._aeonDiagStart, tostring(keys and keys.duration), self:GetRemainingTime() or -1,
		self:GetParent():GetHealth(), self:GetParent():GetMaxHealth()))

	self.buff_pfx = ParticleManager:CreateParticle("particles/items4_fx/combo_breaker_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(self.buff_pfx, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)

	self:AddParticle(self.buff_pfx, false, false, 255, true, false)
end

function modifier_item_aeon_disk_lua_buff:OnDestroy()
	if IsServer() then
		local elapsed = self._aeonDiagStart and (GameRules:GetGameTime() - self._aeonDiagStart) or -1
		local parent = self:GetParent()
		print(string.format("[AEON_DIAG] BUFF_DESTROYED elapsed=%.3f hp=%.1f alive=%s remaining=%.3f",
			elapsed, parent and parent:GetHealth() or -1, tostring(parent and parent:IsAlive()),
			self:GetRemainingTime() or -1))
	end
	if self.buff_pfx then ParticleManager:ReleaseParticleIndex(self.buff_pfx) end
end

function modifier_item_aeon_disk_lua_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
end

function modifier_item_aeon_disk_lua_buff:GetModifierIncomingDamage_Percentage(keys)
	if IsServer() then
		local atk = keys and keys.attacker
		local inf = keys and keys.inflictor
		print(string.format("[AEON_DIAG] INCOMING dmg=%.1f flags=%s type=%s atk=%s inf=%s hp=%.1f",
			keys and keys.damage or -1, tostring(keys and keys.damage_flags),
			tostring(keys and keys.damage_type),
			(atk and atk.GetUnitName) and atk:GetUnitName() or "?",
			(inf and inf.GetAbilityName) and inf:GetAbilityName() or "?",
			self:GetParent():GetHealth()))
	end
	return -99999999
end

function modifier_item_aeon_disk_lua_buff:GetAbsoluteNoDamagePhysical(keys)
	if IsServer() then print("[AEON_DIAG] ABS_NO_PHYS called dmg=" .. tostring(keys and keys.damage)) end
	return 1
end

function modifier_item_aeon_disk_lua_buff:GetAbsoluteNoDamageMagical(keys)
	if IsServer() then print("[AEON_DIAG] ABS_NO_MAG called dmg=" .. tostring(keys and keys.damage)) end
	return 1
end

function modifier_item_aeon_disk_lua_buff:GetAbsoluteNoDamagePure(keys)
	if IsServer() then print("[AEON_DIAG] ABS_NO_PURE called dmg=" .. tostring(keys and keys.damage)) end
	return 1
end

function modifier_item_aeon_disk_lua_buff:GetModifierStatusResistanceStacking()
	return self.status_resistance or 0
end

function modifier_item_aeon_disk_lua_buff:GetModifierTotalDamageOutgoing_Percentage()
	return -100
end

-- GetAbsoluteNoDamage* определены выше с диаг-логом (AEON_DIAG)