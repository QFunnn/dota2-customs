--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_luna_moon_glaive_custom", "heroes/npc_dota_hero_luna_custom/luna_moon_glaive_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_luna_moon_glaive_custom_slow", "heroes/npc_dota_hero_luna_custom/luna_moon_glaive_custom", LUA_MODIFIER_MOTION_NONE )

luna_moon_glaive_custom = class({})
luna_moon_glaive_custom.modifier_luna_3 = {5, 10}
luna_moon_glaive_custom.modifier_luna_4 = {-20,-40,-60}
luna_moon_glaive_custom.modifier_luna_4_duration = 1
luna_moon_glaive_custom.modifier_luna_7 = 150

function luna_moon_glaive_custom:GetIntrinsicModifierName()
	return "modifier_luna_moon_glaive_custom"
end

function luna_moon_glaive_custom:OnProjectileHit_ExtraData(hTarget, vLocation, ExtraData)
	if not IsServer() then return end
	self.bounces = self:GetSpecialValueFor( "bounces" )
	self.range = self:GetSpecialValueFor( "range" )
	self.reduction = self:GetSpecialValueFor( "damage_reduction_percent" )
    if self:GetCaster():HasModifier("modifier_luna_7") then
        self.range = self.range + self.modifier_luna_7
    end
    if self:GetCaster():HasModifier("modifier_luna_3") then
        self.reduction = self.reduction - self.modifier_luna_3[self:GetCaster():GetTalentLevel("modifier_luna_3")]
    end
	if hTarget then
		local damageTable = 
        {
			victim = hTarget,
			damage = ExtraData.damage * ((100 - self.reduction) * 0.01) ^ (ExtraData.bounces + 1),
			damage_type = DAMAGE_TYPE_PHYSICAL,
			damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL,
			attacker = self:GetCaster(),
			ability = self
		}
        if hTarget:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
            ApplyDamage(damageTable)
        end
        hTarget:EmitSound("Hero_Luna.MoonGlaive.Impact")
		if not self.target_tracker then
			self.target_tracker = {}
		end
		if not self.target_tracker[ExtraData.record] then
			self.target_tracker[ExtraData.record] = {}
		end
        if hTarget:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
            if self:GetCaster():HasModifier("modifier_luna_4") then
                hTarget:AddNewModifier(self:GetCaster(), self, "modifier_luna_moon_glaive_custom_slow", {duration = self.modifier_luna_4_duration * (1 - hTarget:GetStatusResistance())})
            end
        end
		self.target_tracker[ExtraData.record][hTarget:GetEntityIndex()] = true
	end

	ExtraData.bounces = ExtraData.bounces + 1
	
	local glaive_launched = false
	
	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), vLocation, nil, self.range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false)
	if self:GetCaster():HasModifier("modifier_luna_7") then
        table.insert(enemies, self:GetCaster())
    end
	if ExtraData.bounces < self.bounces and #enemies > 1 then
		local all_enemies_bounced = true
		for _, enemy in pairs(enemies) do
			if enemy ~= hTarget and not self.target_tracker[ExtraData.record][enemy:GetEntityIndex()] then
				all_enemies_bounced = false
				break
			end
		end
		for _, enemy in pairs(enemies) do
			if enemy ~= hTarget and (not self.target_tracker[ExtraData.record][enemy:GetEntityIndex()] or all_enemies_bounced) then
				local glaive =
				{
					Target = enemy,
					Ability = self,
					EffectName = "particles/units/heroes/hero_luna/luna_moon_glaive_bounce.vpcf",
					iMoveSpeed = self:GetCaster():GetProjectileSpeed(),
					vSourceLoc = vLocation,
					bDrawsOnMinimap = false,
					bDodgeable = false,
					bIsAttack = false,
					bVisibleToEnemies = true,
					bReplaceExisting = false,
					flExpireTime = GameRules:GetGameTime() + 10,
					bProvidesVision = false,
					ExtraData = 
                    {
						bounces	= ExtraData.bounces,
						record = ExtraData.record,
						damage = ExtraData.damage
					}
				}
				ProjectileManager:CreateTrackingProjectile(glaive)
				glaive_launched = true
				break
			end
		end
		if not glaive_launched then
			self.target_tracker[ExtraData.record] = nil
		end
	else
		self.target_tracker[ExtraData.record] = nil
	end
end

modifier_luna_moon_glaive_custom = class({})
function modifier_luna_moon_glaive_custom:IsHidden() return true end
function modifier_luna_moon_glaive_custom:IsPurgable() return false end
function modifier_luna_moon_glaive_custom:IsPurgeException() return false end
function modifier_luna_moon_glaive_custom:RemoveOnDeath() return false end

function modifier_luna_moon_glaive_custom:OnCreated()
	self.bounces = self:GetAbility():GetSpecialValueFor( "bounces" )
	self.range = self:GetAbility():GetSpecialValueFor( "range" )
	self.reduction = self:GetAbility():GetSpecialValueFor( "damage_reduction_percent" )
end

function modifier_luna_moon_glaive_custom:OnRefresh()
	self.bounces = self:GetAbility():GetSpecialValueFor( "bounces" )
	self.range = self:GetAbility():GetSpecialValueFor( "range" )
	self.reduction = self:GetAbility():GetSpecialValueFor( "damage_reduction_percent" )
end

function modifier_luna_moon_glaive_custom:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK
	}
end

function modifier_luna_moon_glaive_custom:GetModifierProcAttack_Feedback(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
    if self:GetParent():PassivesDisabled() then return end
    local target = params.target
    local range = self.range
    if self:GetCaster():HasModifier("modifier_luna_7") then
        range = range + self:GetAbility().modifier_luna_7
    end

	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false)
    if self:GetCaster():HasModifier("modifier_luna_7") then
        table.insert(enemies, self:GetCaster())
    end
    for _, enemy in pairs(enemies) do
        if enemy ~= target and enemy == enemies[2] then
            local glaive =
            {
                Target = enemy,
                Source = target,
                Ability = self:GetAbility(),
                EffectName = "particles/units/heroes/hero_luna/luna_moon_glaive_bounce.vpcf",
                iMoveSpeed = self:GetCaster():GetProjectileSpeed(),
                bDrawsOnMinimap = false,
                bDodgeable = false,
                bIsAttack = false,
                bVisibleToEnemies = true,
                bReplaceExisting = false,
                flExpireTime = GameRules:GetGameTime() + 10,
                bProvidesVision = false,
                ExtraData = 
                {
                    bounces = 0,
                    record = params.record,
                    damage = params.original_damage
                }
            }
            ProjectileManager:CreateTrackingProjectile(glaive)
        end
    end
end

modifier_luna_moon_glaive_custom_slow = class({})

function modifier_luna_moon_glaive_custom_slow:GetTexture() return "luna_4" end

function modifier_luna_moon_glaive_custom_slow:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_luna_moon_glaive_custom_slow:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility().modifier_luna_4[self:GetCaster():GetTalentLevel("modifier_luna_4")]
end

function modifier_luna_moon_glaive_custom_slow:GetStatusEffectName()
    return "particles/status_fx/status_effect_brewmaster_thunder_clap.vpcf"
end

function modifier_luna_moon_glaive_custom_slow:GetEffectName()
    return "particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap_debuff.vpcf"
end

function modifier_luna_moon_glaive_custom_slow:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_luna_moon_glaive_custom_slow:StatusEffectPriority()
    return 3
end