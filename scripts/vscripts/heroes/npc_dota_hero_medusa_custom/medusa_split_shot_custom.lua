--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_medusa_split_shot_custom", "heroes/npc_dota_hero_medusa_custom/medusa_split_shot_custom", LUA_MODIFIER_MOTION_NONE )

medusa_split_shot_custom = class({})

medusa_split_shot_custom.modifier_medusa_1 = {5,10}
medusa_split_shot_custom.modifier_medusa_4 = {10,15,20}

function medusa_split_shot_custom:ResetToggleOnRespawn() return false end

function medusa_split_shot_custom:Spawn()
    if not IsServer() then return end
    Timers:CreateTimer(FrameTime(), function()
        if self:GetCaster():IsIllusion() then
            local modifier_illusion = self:GetCaster():FindModifierByName("modifier_illusion")
            if modifier_illusion then
                local caster = modifier_illusion:GetCaster()
                local medusa_split_shot_custom_caster = caster:FindAbilityByName("medusa_split_shot_custom")
                if medusa_split_shot_custom_caster then
                    if medusa_split_shot_custom_caster:GetToggleState() then
                        self:ToggleAbility()
                    end
                end
            end
        end
    end)
end

function medusa_split_shot_custom:OnToggle()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local toggle = self:GetToggleState()
	if toggle then
		self.modifier = caster:AddNewModifier( caster, self, "modifier_medusa_split_shot_custom", {} )
	else
		if self.modifier and not self.modifier:IsNull() then
			self.modifier:Destroy()
		end
		self.modifier = nil
	end
end

function medusa_split_shot_custom:OnProjectileHit( target, location )
	if not target then return end
	self:GetCaster().split_shot_attack = true
	self:GetCaster():PerformAttack( target, false, false, true, false, false, false, false )
	self:GetCaster().split_shot_attack = false
end

modifier_medusa_split_shot_custom = class({})
function modifier_medusa_split_shot_custom:IsHidden() return true end
function modifier_medusa_split_shot_custom:IsPurgable() return false end
function modifier_medusa_split_shot_custom:IsPurgeException() return false end
function modifier_medusa_split_shot_custom:RemoveOnDeath() return false end
function modifier_medusa_split_shot_custom:GetPriority() return MODIFIER_PRIORITY_HIGH end

function modifier_medusa_split_shot_custom:OnCreated( kv )
	self.reduction = self:GetAbility():GetSpecialValueFor( "damage_modifier_custom" )
	self.count = self:GetAbility():GetSpecialValueFor( "arrow_count_custom" )
	self.bonus_range = self:GetAbility():GetSpecialValueFor( "split_shot_bonus_range" )
	self.parent = self:GetParent()
	self.use_modifier = false
	if not IsServer() then return end
	self.projectile_name = self.parent:GetRangedProjectileName()
	self.projectile_speed = self.parent:GetProjectileSpeed()
    self.modifier_medusa_split_shot = self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_medusa_split_shot", {})
end

function modifier_medusa_split_shot_custom:OnRefresh( kv )
	self.reduction = self:GetAbility():GetSpecialValueFor( "damage_modifier_custom" )
	self.count = self:GetAbility():GetSpecialValueFor( "arrow_count_custom" )
	self.bonus_range = self:GetAbility():GetSpecialValueFor( "split_shot_bonus_range" )
end

function modifier_medusa_split_shot_custom:OnDestroy()
    if not IsServer() then return end
    if self.modifier_medusa_split_shot then
        self.modifier_medusa_split_shot:Destroy()
    end
end

function modifier_medusa_split_shot_custom:DeclareFunctions()
	return
    {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_medusa_split_shot_custom:OnAttack( params )
	if not IsServer() then return end
	if params.attacker~=self.parent then return end
	if params.no_attack_cooldown then return end
	if params.target:GetTeamNumber()==params.attacker:GetTeamNumber() then return end
	if self.parent:PassivesDisabled() then return end
	if not params.process_procs then return end
	if self.split_shot then return end
	if self.use_modifier or self:GetCaster():HasModifier("modifier_medusa_5") then
		self:SplitShotModifier( params.target )
	else
		self:SplitShotNoModifier( params.target )
	end
end

function modifier_medusa_split_shot_custom:GetModifierDamageOutgoing_Percentage()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_medusa_1") then
        bonus = self:GetAbility().modifier_medusa_1[self:GetCaster():GetTalentLevel("modifier_medusa_1")]
    end
	return self.reduction + bonus
end

function modifier_medusa_split_shot_custom:SplitShotModifier( target )
	local radius = self.parent:Script_GetAttackRange() + self.bonus_range
	local enemies = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_COURIER, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false)
	local count = 0

    if self:GetCaster():HasModifier("modifier_medusa_4") then
        if RollPercentage(self:GetAbility().modifier_medusa_4[self:GetCaster():GetTalentLevel("modifier_medusa_4")]) then
            for i=1, self.count do
                self.split_shot = true
			    self.parent:PerformAttack( target, false, self:GetCaster():HasModifier("modifier_medusa_5"), true, false, true, false, false)
			    self.split_shot = false
            end
            --self.parent:EmitSound("Hero_Medusa.AttackSplit")
            return
        end
    end

	for _,enemy in pairs(enemies) do
		if enemy ~= target then
			self.split_shot = true
			self.parent:PerformAttack( enemy, false, self:GetCaster():HasModifier("modifier_medusa_5"), true, false, true, false, false)
			self.split_shot = false
			count = count + 1
			if count>=self.count then break end
		end
	end

	if count > 1 then
		--self.parent:EmitSound("Hero_Medusa.AttackSplit")
	end
end

function modifier_medusa_split_shot_custom:SplitShotNoModifier( target )
	local radius = self.parent:Script_GetAttackRange() + self.bonus_range
	local enemies = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_COURIER, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false)
	local count = 0

    if self:GetCaster():HasModifier("modifier_medusa_4") then
        if RollPercentage(self:GetAbility().modifier_medusa_4[self:GetCaster():GetTalentLevel("modifier_medusa_4")]) then
            for i=1, self.count do
                local info = 
                {
                    Target = target,
                    Source = self.parent,
                    Ability = self:GetAbility(),	
                    EffectName = self.projectile_name,
                    iMoveSpeed = self.projectile_speed,
                    bDodgeable = true,
                }
                ProjectileManager:CreateTrackingProjectile(info)
            end
            --self.parent:EmitSound("Hero_Medusa.AttackSplit")
            return
        end
    end

	for _,enemy in pairs(enemies) do
		if enemy ~= target and enemy:GetUnitName() ~= "npc_dota_techies_land_mine" then
			local info = 
            {
				Target = enemy,
				Source = self.parent,
				Ability = self:GetAbility(),	
				EffectName = self.projectile_name,
				iMoveSpeed = self.projectile_speed,
				bDodgeable = true,
			}
			ProjectileManager:CreateTrackingProjectile(info)
			count = count + 1
			if count>=self.count then break end
		end
	end
	if count > 1 then
		--self.parent:EmitSound("Hero_Medusa.AttackSplit")
	end
end