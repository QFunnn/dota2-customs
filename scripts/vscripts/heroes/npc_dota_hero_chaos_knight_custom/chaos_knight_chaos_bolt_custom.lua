--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


chaos_knight_chaos_bolt_custom = class({})
chaos_knight_chaos_bolt_custom.modifier_chaos_knight_16 = {300,450,600}
chaos_knight_chaos_bolt_custom.modifier_chaos_knight_20 = -1.5
chaos_knight_chaos_bolt_custom.modifier_chaos_knight_18 = {30, 60}
chaos_knight_chaos_bolt_custom.modifier_chaos_knight_15 = {1, 2}
chaos_knight_chaos_bolt_custom.modifier_chaos_knight_9 = {3,6,9}
chaos_knight_chaos_bolt_custom.modifier_chaos_knight_9_damage = -67.5

function chaos_knight_chaos_bolt_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_chaos_knight.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_chaos_knight.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_chaos_knight.vpcf", context)
end

function chaos_knight_chaos_bolt_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_chaos_knight_20") then
        bonus = self.modifier_chaos_knight_20
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function chaos_knight_chaos_bolt_custom:OnAbilityPhaseStart()
    local fake_bolt_distance = self:GetSpecialValueFor("fake_bolt_distance")
    local heroes = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, fake_bolt_distance, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, 0, false)
	local illusions = {}
	for _,hero in pairs(heroes) do
		if hero:IsIllusion() and hero:GetPlayerOwnerID()==self:GetCaster():GetPlayerOwnerID() then
			table.insert( illusions, hero )
		end
	end
    for _, illusion in pairs(illusions) do
        illusion:StartGesture(ACT_DOTA_CAST_ABILITY_1)
    end
    return true
end

function chaos_knight_chaos_bolt_custom:OnSpellStart()
    if not IsServer() then return end
	local target = self:GetCursorTarget()
    local chaos_bolt_speed = self:GetSpecialValueFor("chaos_bolt_speed")
    local chaos_bolt_speed_mult = 1
    if self:GetCaster():HasModifier("modifier_chaos_knight_18") then
        chaos_bolt_speed_mult = chaos_bolt_speed_mult + (self.modifier_chaos_knight_18[self:GetCaster():GetTalentLevel("modifier_chaos_knight_18")] / 100)
    end
	local counter = 1
    if self:GetCaster():HasModifier("modifier_chaos_knight_15") then
        counter = counter + self.modifier_chaos_knight_15[self:GetCaster():GetTalentLevel("modifier_chaos_knight_15")]
    end
    local index = DoUniqueString("chaos_knight_chaos_bolt_custom")
    self[index] = {}
    self:StartProjectile(target, counter, nil, index, true)

    -- Illusions
    local fake_bolt_distance = self:GetSpecialValueFor("fake_bolt_distance")
    local heroes = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, fake_bolt_distance, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, 0, false)
	local illusions = {}
	for _,hero in pairs(heroes) do
		if hero:IsIllusion() and hero:GetPlayerOwnerID()==self:GetCaster():GetPlayerOwnerID() then
			table.insert( illusions, hero )
		end
	end
    for _, illusion in pairs(illusions) do
        info = 
        {
            Source = illusion,
            Target = target,
            Ability = self,
            iSourceAttachment = attach,
            iMoveSpeed = chaos_bolt_speed,
            EffectName = "particles/units/heroes/hero_chaos_knight/chaos_knight_chaos_bolt.vpcf",
            bDodgeable = true,
            ExtraData = 
            {
                illusion = 1,
            }
        }
        ProjectileManager:CreateTrackingProjectile( info )
        self:GetCaster():EmitSound("Hero_ChaosKnight.ChaosBolt.Cast")
    end
end

function chaos_knight_chaos_bolt_custom:StartProjectile(target, counter, new_started, index, main)
    local chaos_bolt_speed = self:GetSpecialValueFor("chaos_bolt_speed")
    local chaos_bolt_speed_mult = 1
    if self:GetCaster():HasModifier("modifier_chaos_knight_18") then
        chaos_bolt_speed_mult = chaos_bolt_speed_mult + (self.modifier_chaos_knight_18[self:GetCaster():GetTalentLevel("modifier_chaos_knight_18")] / 100)
    end
    local source = self:GetCaster()
    local attach = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
    if new_started then
        source = new_started
        attach = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION
    end
	local projectile = "particles/units/heroes/hero_chaos_knight/chaos_knight_chaos_bolt.vpcf"
	local info = 
    {
		Source = source,
		Target = target,
		Ability = self,
		iMoveSpeed = chaos_bolt_speed * chaos_bolt_speed_mult,
		EffectName = "particles/units/heroes/hero_chaos_knight/chaos_knight_chaos_bolt.vpcf",
		bDodgeable = true,
        iSourceAttachment = attach,
        ExtraData = 
        {
            counter = counter,
            index = index,
            main = main,
        }
	}
	ProjectileManager:CreateTrackingProjectile( info )
    self:GetCaster():EmitSound("Hero_ChaosKnight.ChaosBolt.Cast")
end

function chaos_knight_chaos_bolt_custom:OnProjectileHit_ExtraData( target, vLocation, kv )
	if target == nil or target:IsInvulnerable() then return end
    if kv.illusion then return end
    self[kv.index][target:entindex()] = true
    local is_spell_absorb = false
    if target:TriggerSpellAbsorb( self ) then
        is_spell_absorb = true
    end

	if not is_spell_absorb then
        local damage_min = self:GetSpecialValueFor("damage_min")
        local damage_max = self:GetSpecialValueFor("damage_max")
        if self:GetCaster():HasModifier("modifier_chaos_knight_16") then
            damage_min = damage_min + (self:GetCaster():GetManaRegen() / 100 * self.modifier_chaos_knight_16[self:GetCaster():GetTalentLevel("modifier_chaos_knight_16")])
            damage_max = damage_max + (self:GetCaster():GetManaRegen() / 100 * self.modifier_chaos_knight_16[self:GetCaster():GetTalentLevel("modifier_chaos_knight_16")])
        end
        local stun_min = self:GetSpecialValueFor("stun_min")
        local stun_max = self:GetSpecialValueFor("stun_max")
        local rand = math.random()
        local damage_act = self:Expand(rand,damage_min,damage_max)
        local stun_act = self:Expand(1-rand,stun_min,stun_max)
        ApplyDamage( { victim = target, attacker = self:GetCaster(), damage = damage_act, damage_type = DAMAGE_TYPE_MAGICAL, ability = self } )
        target:AddNewModifier( self:GetCaster(), self, "modifier_stunned", { duration = stun_act * (1 - target:GetStatusResistance()) } )
        self:StunPFX( target, stun_act, damage_act )
        if self:GetCaster():HasModifier("modifier_chaos_knight_9") and kv.main then
            local chaos_knight_phantasm_custom = self:GetCaster():FindAbilityByName("chaos_knight_phantasm_custom")
            if chaos_knight_phantasm_custom and chaos_knight_phantasm_custom:GetLevel() > 0 then
                chaos_knight_phantasm_custom:CreateOneIllusion(target:GetAbsOrigin(), self.modifier_chaos_knight_9[self:GetCaster():GetTalentLevel("modifier_chaos_knight_9")], self.modifier_chaos_knight_9_damage)
            end
        end
    end

    local counter = kv.counter - 1
    if counter > 0 then
        local heroes = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetOrigin(), nil, self:GetCastRange(target:GetAbsOrigin(), target), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false)
        local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetOrigin(), nil, self:GetCastRange(target:GetAbsOrigin(), target), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, 0, 0, false)
        local next_target = nil
        if #heroes > 0 then
            for _, unit in pairs(heroes) do
                if not self[kv.index][unit:entindex()] then
                    next_target = unit
                    break
                end
            end
        end
        if not next_target then
            for _, unit in pairs(units) do
                if not self[kv.index][unit:entindex()] then
                    next_target = unit
                    break
                end
            end
        end
        if next_target then
            self:StartProjectile(next_target, counter, target, kv.index)
        end
    end
end

function chaos_knight_chaos_bolt_custom:Expand( value, min, max )
	return (max - min) * value + min
end

function chaos_knight_chaos_bolt_custom:StunPFX( target, stun, damage )
	local digit = 4
	if damage < 100 then digit = 3 end
	local digit1 = damage%10
	local digit2 = math.floor((damage%100)/10)
	local digit3 = math.floor((damage%1000)/100)
	local number = digit3*100 + digit2*10 + digit1
	local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_chaos_knight/chaos_knight_bolt_msg.vpcf", PATTACH_OVERHEAD_FOLLOW, target )
	ParticleManager:SetParticleControl( nFXIndex, 0, target:GetOrigin() )
	ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 0, number, 3 ) )
	ParticleManager:SetParticleControl( nFXIndex, 2, Vector( 2, digit, 0 ) )
	ParticleManager:SetParticleControl( nFXIndex, 3, Vector( 0,	stun, 4 ) )
	ParticleManager:SetParticleControl( nFXIndex, 4, Vector( 2,	2, 0 ) )
	ParticleManager:ReleaseParticleIndex( nFXIndex )
	target:EmitSound("Hero_ChaosKnight.ChaosBolt.Impact")
end