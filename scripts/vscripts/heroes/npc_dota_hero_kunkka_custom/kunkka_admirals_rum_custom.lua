--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kunkka_admirals_rum_custom", "heroes/npc_dota_hero_kunkka_custom/kunkka_admirals_rum_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kunkka_admirals_rum_custom_buff", "heroes/npc_dota_hero_kunkka_custom/kunkka_admirals_rum_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kunkka_admirals_rum_custom_debuff", "heroes/npc_dota_hero_kunkka_custom/kunkka_admirals_rum_custom", LUA_MODIFIER_MOTION_NONE)

kunkka_admirals_rum_custom = class({})
kunkka_admirals_rum_custom.modifier_kunkka_6 = 2.5
kunkka_admirals_rum_custom.modifier_kunkka_21 = 30

function kunkka_admirals_rum_custom:GetIntrinsicModifierName()
    return "modifier_kunkka_admirals_rum_custom"
end

function kunkka_admirals_rum_custom:ApplyGhostShip(target)
    local buff_duration = self:GetSpecialValueFor("buff_duration")
    target:AddNewModifier(self:GetCaster(), self, "modifier_kunkka_admirals_rum_custom_buff", {duration = buff_duration, multiplier = 2, ultimate = true})
end

modifier_kunkka_admirals_rum_custom = class({})
function modifier_kunkka_admirals_rum_custom:IsHidden() return true end
function modifier_kunkka_admirals_rum_custom:IsPurgable() return false end
function modifier_kunkka_admirals_rum_custom:IsPurgeException() return false end
function modifier_kunkka_admirals_rum_custom:RemoveOnDeath() return false end

function modifier_kunkka_admirals_rum_custom:OnCreated()
    self.damage_threshold = self:GetAbility():GetSpecialValueFor("damage_threshold")
    self.buff_duration = self:GetAbility():GetSpecialValueFor("buff_duration")
end

function modifier_kunkka_admirals_rum_custom:OnTakeDamage(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if self:GetParent():PassivesDisabled() then return end
    if self:GetParent():GetHealthPercent() > self.damage_threshold then return end
    if self:GetParent():HasModifier("modifier_kunkka_admirals_rum_custom_buff") then return end
    if not self:GetAbility():IsFullyCastable() then return end
    self:GetAbility():UseResources(false, false, false, true)
    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_kunkka_admirals_rum_custom_buff", {duration = self.buff_duration})
end

modifier_kunkka_admirals_rum_custom_buff = class({})
function modifier_kunkka_admirals_rum_custom_buff:IsPurgeException() return false end
function modifier_kunkka_admirals_rum_custom_buff:IsHidden() return false end
function modifier_kunkka_admirals_rum_custom_buff:IsPurgable() return false end
function modifier_kunkka_admirals_rum_custom_buff:IsDebuff() return false end

function modifier_kunkka_admirals_rum_custom_buff:OnCreated(params)
	if not IsServer() then return end
    self.multiplier = params.multiplier or 1
    self.ghostship_absorb = self:GetAbility():GetSpecialValueFor("ghostship_absorb") * self.multiplier
    self.movespeed_bonus = self:GetAbility():GetSpecialValueFor("movespeed_bonus") * self.multiplier
    self.spell_amplify = self:GetAbility().modifier_kunkka_21 * self.multiplier
	self.damage_counter = 0
    self.ultimate = params.ultimate
	self.timer = 0
    self:SetHasCustomTransmitterData( true )
	self:StartIntervalThink(FrameTime())
end

function modifier_kunkka_admirals_rum_custom_buff:OnRefresh(params)
    if not IsServer() then return end
    self.multiplier = params.multiplier or 1
    self.ultimate = params.ultimate
    self.ghostship_absorb = self:GetAbility():GetSpecialValueFor("ghostship_absorb")
    self.movespeed_bonus = self:GetAbility():GetSpecialValueFor("movespeed_bonus")
    self.spell_amplify = self:GetAbility().modifier_kunkka_21 * self.multiplier
    self:SendBuffRefreshToClients()
	self:StartIntervalThink(FrameTime())
end

function modifier_kunkka_admirals_rum_custom_buff:AddCustomTransmitterData()
	local data = 
    {
		ghostship_absorb = self.ghostship_absorb,
		movespeed_bonus = self.movespeed_bonus,
        spell_amplify = self.spell_amplify,
	}
	return data
end

function modifier_kunkka_admirals_rum_custom_buff:HandleCustomTransmitterData( data )
	self.ghostship_absorb = data.ghostship_absorb
	self.movespeed_bonus = data.movespeed_bonus
    self.spell_amplify = data.spell_amplify
end

function modifier_kunkka_admirals_rum_custom_buff:OnIntervalThink()
	if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_kunkka_6") and self.ultimate then
		self.timer = self.timer + FrameTime()
		if self.timer >= self:GetAbility().modifier_kunkka_6 then
			self.timer = 0
			self:GetParent():Purge(false, true, false, true, true)
			local particle = ParticleManager:CreateParticle("particles/kunkka_purge.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
			ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex( particle )
			self:GetParent():EmitSound("Hero_Tidehunter.KrakenShell")
		end
	end
end

function modifier_kunkka_admirals_rum_custom_buff:GetModifierMoveSpeedBonus_Percentage()
	return self.movespeed_bonus
end

function modifier_kunkka_admirals_rum_custom_buff:GetModifierIncomingDamage_Percentage()
	return -self.ghostship_absorb
end

function modifier_kunkka_admirals_rum_custom_buff:GetModifierSpellAmplify_Percentage()
    if self:GetParent():HasModifier("modifier_kunkka_21") then
        return self.spell_amplify
    end
end

function modifier_kunkka_admirals_rum_custom_buff:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_HP_REGEN_CAN_BE_NEGATIVE,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_kunkka_admirals_rum_custom_buff:OnTakeDamage( params )
	if not IsServer() then return end
    if params.unit == self:GetParent() then
        local rum_reduction = (100 - self.ghostship_absorb) / 100
        local prevented_damage = params.damage / rum_reduction - params.damage
        self.damage_counter = self.damage_counter + prevented_damage
    end
end

function modifier_kunkka_admirals_rum_custom_buff:GetEffectName()
    return "particles/units/heroes/hero_kunkka/kunkka_admirals_rum.vpcf"
end

function modifier_kunkka_admirals_rum_custom_buff:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

-- particles/units/heroes/hero_kunkka/kunkka_cannonball.vpcf

function modifier_kunkka_admirals_rum_custom_buff:GetStatusEffectName()
	return "particles/status_fx/status_effect_rum.vpcf"
end

function modifier_kunkka_admirals_rum_custom_buff:StatusEffectPriority()
	return 10
end

function modifier_kunkka_admirals_rum_custom_buff:OnDestroy()
	if not IsServer() then return end
    local caster = self:GetCaster()
    local ability = self:GetAbility()
    self:GetParent():AddNewModifier(caster, ability, "modifier_kunkka_admirals_rum_custom_debuff", { duration = ability:GetSpecialValueFor("buff_duration"), stored_damage = self.damage_counter})
    self.damage_counter = 0
end

modifier_kunkka_admirals_rum_custom_debuff = class({})
function modifier_kunkka_admirals_rum_custom_debuff:IsPurgable() return false end
function modifier_kunkka_admirals_rum_custom_debuff:IsPurgeException() return false end
function modifier_kunkka_admirals_rum_custom_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_kunkka_admirals_rum_custom_debuff:OnCreated(params)
    if not IsServer() then return end
    local ability = self:GetAbility()
    if not ability then return end
    self.parent = self:GetParent()
    self.damage_duration = ability:GetSpecialValueFor("buff_duration")
    self.damage_interval = 1
    self.ticks = self.damage_duration / self.damage_interval
    self.damage_amount = math.abs((params.stored_damage or 0) / self.ticks)
    self.current_tick = 0
    self:StartIntervalThink(self.damage_interval)
end
function modifier_kunkka_admirals_rum_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    if not self.parent or self.parent:IsNull() or not self.parent:IsAlive() then
        self:StartIntervalThink(-1)
        return
    end
    local target_hp = self.parent:GetHealth()
    if target_hp - self.damage_amount < 1 then
        self.parent:SetHealth(1)
    else
        self.parent:SetHealth(target_hp - self.damage_amount)
    end
    self.current_tick = self.current_tick + 1
    if self.current_tick >= self.ticks then
        self:StartIntervalThink(-1)
    end
end