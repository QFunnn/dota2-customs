--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_chaos_knight_phantasm_custom", "heroes/npc_dota_hero_chaos_knight_custom/chaos_knight_phantasm_custom", LUA_MODIFIER_MOTION_NONE )

chaos_knight_phantasm_custom = class({})
chaos_knight_phantasm_custom.illusions = {}
chaos_knight_phantasm_custom.modifier_chaos_knight_11 = {-50, -100, -150}
chaos_knight_phantasm_custom.modifier_chaos_knight_14 = 1200

function chaos_knight_phantasm_custom:GetBehavior()
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function chaos_knight_phantasm_custom:OnSpellStart()
	local invuln_duration = self:GetSpecialValueFor("invuln_duration")
	local target = self:GetCaster()
	target:AddNewModifier( target, self, "modifier_chaos_knight_phantasm_custom", { duration = invuln_duration } )
end

function chaos_knight_phantasm_custom:CreateOneIllusion(point, new_duration, new_outgoing, new_hero_copy)
    local illusion_duration = self:GetSpecialValueFor( "illusion_duration" )
    local outgoing_damage = self:GetSpecialValueFor("outgoing_damage")
    local incoming_damage = self:GetSpecialValueFor("incoming_damage")
    if self:GetCaster():HasModifier("modifier_chaos_knight_11") then
        incoming_damage = incoming_damage + self.modifier_chaos_knight_11[self:GetCaster():GetTalentLevel("modifier_chaos_knight_11")]
    end
    if new_duration then
        illusion_duration = new_duration
    end
    if new_outgoing then
        outgoing_damage = new_outgoing
    end
    local hero_copy = self:GetCaster()
    if new_hero_copy then
        hero_copy = new_hero_copy
    end
    local illusions = CreateIllusions(self:GetCaster(), hero_copy, {duration = illusion_duration, outgoing_damage = outgoing_damage, incoming_damage = incoming_damage}, 1, 150, false, false ) 
    for _, illusion in pairs(illusions) do
        FindClearSpaceForUnit(illusion, point, true)
    end
    return illusions
end

modifier_chaos_knight_phantasm_custom = class({})
function modifier_chaos_knight_phantasm_custom:IsHidden() return false end
function modifier_chaos_knight_phantasm_custom:IsPurgable() return false end

function modifier_chaos_knight_phantasm_custom:OnCreated( kv )
	self.images_count = self:GetAbility():GetSpecialValueFor( "images_count" )
    if self:GetCaster():HasModifier("modifier_chaos_knight_14") then
        self.images_count = self.images_count + 1
    end
	self.illusion_duration = self:GetAbility():GetSpecialValueFor( "illusion_duration" )
	self.vision_duration = self:GetAbility():GetSpecialValueFor( "vision_duration" )
    self.outgoing_damage = self:GetAbility():GetSpecialValueFor("outgoing_damage")
    self.incoming_damage = self:GetAbility():GetSpecialValueFor("incoming_damage")
    if self:GetCaster():HasModifier("modifier_chaos_knight_11") then
        self.incoming_damage = self.incoming_damage + self:GetAbility().modifier_chaos_knight_11[self:GetCaster():GetTalentLevel("modifier_chaos_knight_11")]
    end
	if not IsServer() then return end
    local caster = self:GetParent()
    self.illusions = {}
    self:GetParent():Purge( false, true, false, false, false )
    self:GetParent():Stop()
    for _,illusion in pairs(self:GetAbility().illusions) do
        if (not illusion:IsNull()) and illusion:IsAlive() then
            illusion:ForceKill( false )
        end
        illusion = nil
    end
    self:GetAbility().illusions = {}

    local distance = 135
    local spawn = {}
    spawn[1] = caster:GetOrigin()
    spawn[2] = spawn[1] + caster:GetRightVector():Normalized() * distance
    spawn[3] = spawn[1] + caster:GetRightVector():Normalized() * -distance
    spawn[4] = spawn[1] + caster:GetForwardVector():Normalized() * -distance
    spawn[5] = spawn[1] + caster:GetForwardVector():Normalized() * distance
    
    self.points_illusions = spawn
    self.spawnSelf = table.remove(self.points_illusions, RandomInt(1, #self.points_illusions))

    self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_chaos_knight/chaos_knight_phantasm.vpcf", PATTACH_ABSORIGIN, self:GetParent() )
    ParticleManager:SetParticleControl( self.effect_cast, 0, caster:GetAbsOrigin() )
    self:AddParticle( self.effect_cast, false, false, -1, false, false )
    self:GetParent():EmitSound("Hero_ChaosKnight.Phantasm")
end

function modifier_chaos_knight_phantasm_custom:OnDestroy( kv )
	if not IsServer() then return end
    FindClearSpaceForUnit( self:GetParent(), self.spawnSelf, true )
    local illusions = CreateIllusions( self:GetCaster(), self:GetCaster(), {duration = self.illusion_duration, outgoing_damage=self.outgoing_damage, incoming_damage = self.incoming_damage}, self.images_count, 100, false, false ) 
    for _, illusion in pairs(illusions) do
        local location = nil
        if #self.points_illusions > 0 then
            location = table.remove(self.points_illusions, RandomInt(1, #self.points_illusions))
        end
        if location then
            FindClearSpaceForUnit(illusion, location, true)
        else
            FindClearSpaceForUnit(illusion, illusion:GetAbsOrigin(), true)
        end
        table.insert(self:GetAbility().illusions, illusion)
    end
    if self:GetCaster():HasModifier("modifier_chaos_knight_14") then
        local heroes = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self:GetAbility().modifier_chaos_knight_14, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, 0, false)
        for _, hero in pairs(heroes) do
            if hero:IsAlive() and hero:IsRealHero() and hero ~= self:GetCaster() and not hero:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then
                local illusions_list = self:GetAbility():CreateOneIllusion(hero:GetAbsOrigin(), nil, nil, hero)
                for _, illusion in pairs(illusions_list) do
                    table.insert(self:GetAbility().illusions, illusion)
                end
            end
        end
    end
end

function modifier_chaos_knight_phantasm_custom:CheckState()
	return
    {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_STUNNED] = IsServer(),
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end