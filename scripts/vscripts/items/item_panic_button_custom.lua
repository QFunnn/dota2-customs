--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_panic_button_custom", "items/item_panic_button_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_panic_button_custom_buff", "items/item_panic_button_custom", LUA_MODIFIER_MOTION_NONE)

item_panic_button_custom = class({})

function item_panic_button_custom:GetIntrinsicModifierName()
    return "modifier_item_panic_button_custom"
end

modifier_item_panic_button_custom = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
	RemoveOnDeath			= function(self) return false end,

    DeclareFunctions        = function (self)
        return {
            MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
			MODIFIER_PROPERTY_HEALTH_BONUS
        }
    end,

	GetModifierHealthBonus	= function(self) return self.BonusHealth or 0 end,
})

function modifier_item_panic_button_custom:OnCreated()
	local ability = self:GetAbility()
	if ability then
		self.Duration = ability:GetSpecialValueFor("buff_duration")
		self.Threshold = ability:GetSpecialValueFor("health_threshold")
		self.HealPct = ability:GetSpecialValueFor("heal")
		self.BonusHealth = ability:GetSpecialValueFor("bonus_health")
	end
end

modifier_item_panic_button_custom.OnRefresh = modifier_item_panic_button_custom.OnCreated

function modifier_item_panic_button_custom:GetModifierIncomingDamage_Percentage(event)
	local attacker = event.attacker
	local parent = self:GetParent()
	local ability = self:GetAbility()
	local damage_flags = event.damage_flags
	local damage = event.damage

	if not parent:IsAlive() or parent:HasModifier("modifier_duel_curse") then return 0 end
	
	-- Magic Lamp не спасает от отложенного урона False Promise
	if parent:HasModifier("modifier_oracle_false_promise_custom") then return 0 end

	if ability and ability:IsCooldownReady() and attacker ~= parent and not parent:HasModifier("modifier_item_panic_button_custom_buff") and not parent:IsIllusion() then
		local CurrentHealth = parent:GetHealth()
		local HealthThreshold = parent:GetMaxHealth() * 0.01 * self.Threshold

		local Heal = parent:GetMaxHealth() * 0.01 * self.HealPct

		local ResultHealth = math.max(CurrentHealth - damage, 0)
		
		if ResultHealth <= HealthThreshold and bit:_and(damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) ~= DOTA_DAMAGE_FLAG_HPLOSS then
			parent:Purge( false, true, false, true, true )
			parent:AddNewModifier(parent, ability, "modifier_item_panic_button_custom_buff", {duration = self.Duration})

			parent:SetHealth(math.min(CurrentHealth, HealthThreshold))
			parent:Heal(Heal, ability)

			-- CDR не работает на Magic Lamp
			ability:UseResources(false, false, false, true)

			-- -99999999 вместо -100: engine суммирует все INCOMING_DAMAGE_PERCENTAGE
			-- в текущем damage event'е, а buff появится только со следующего.
			-- modifier_loser_curse даёт +20% за стак — при -100 герой ловит
			-- часть урона и умирает «до создания buff'а». Overwhelmingly
			-- негативное число гарантирует damage = 0 в этом хите.
			return -99999999
		end
	end
end

modifier_item_panic_button_custom_buff = class({
    IsHidden                = function(self) return false end,
    -- [Magic Lamp] бафф неуязвимости теперь пуржится (Nullifier/диспелы снимают).
    IsPurgable              = function(self) return true end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

    DeclareFunctions        = function (self)
        return {
            MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
			MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
			MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
			MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
			MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        }
    end,

	-- ABSOLUTE_NO_DAMAGE гарантирует полную неуязвимость независимо от
	-- усилений входящего урона (modifier_loser_curse даёт +20% за стак —
	-- без абсолютной защиты buff -100% становится -80%/-60%/.../0% и
	-- герой умирает «внутри неуязвимости»).
	GetModifierIncomingDamage_Percentage 	= function(self) return -100 end,
	GetModifierTotalDamageOutgoing_Percentage	= function(self) return -100 end,
	GetAbsoluteNoDamagePhysical 			= function(self) return 1 end,
	GetAbsoluteNoDamageMagical 				= function(self) return 1 end,
	GetAbsoluteNoDamagePure 				= function(self) return 1 end,
})

function modifier_item_panic_button_custom_buff:OnCreated()
	if IsServer() then
		self:GetParent():EmitSound("DOTA_Item.ComboBreaker")
		local fx = ParticleManager:CreateParticle("particles/items4_fx/combo_breaker_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControlEnt(fx, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
		self:AddParticle(fx, false, false, -1, true, false)
	end
end