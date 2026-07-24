--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_juggernaut_omni_slash_custom", "heroes/hero_juggernaut/juggernaut_omni_slash_custom.lua", LUA_MODIFIER_MOTION_NONE)

juggernaut_omni_slash_custom = class({})

function juggernaut_omni_slash_custom:OnSpellStart()
    if not IsServer() then return end

    local point = self:GetCursorPosition()

    self:GetCaster():Purge(false, true, false, false, false)

    local duration = self:GetSpecialValueFor("duration")

    if self:GetCaster():HasModifier("modifier_juggernaut_omni_slash_custom") then 
        self:GetCaster():RemoveModifierByName("modifier_juggernaut_omni_slash_custom")
    end

    local start_pos = self:GetCaster():GetAbsOrigin()
    
    self:GetCaster():EmitSound("Hero_Juggernaut.OmniSlash")

    FindClearSpaceForUnit(self:GetCaster(), point, false)

    local targets = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, self:GetSpecialValueFor("omni_slash_radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)
    local first_target = targets[1] 
    
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_juggernaut_omni_slash_custom", {duration = duration, first_target = first_target:entindex(), scepter = false})

    if self:GetCaster():IsRealHero() then 
        PlayerResource:SetCameraTarget(self:GetCaster():GetPlayerOwnerID(), self:GetCaster())
        PlayerResource:SetCameraTarget(self:GetCaster():GetPlayerOwnerID(), nil)
    end

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, start_pos)
    ParticleManager:SetParticleControl(particle, 1, self:GetCaster():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
end


juggernaut_swift_slash_custom = class({})

function juggernaut_swift_slash_custom:OnSpellStart()
    if not IsServer() then return end

    local point = self:GetCursorPosition()

    self:GetCaster():Purge(false, true, false, false, false)

    local duration = self:GetSpecialValueFor("duration")

    if self:GetCaster():HasModifier("modifier_juggernaut_omni_slash_custom") then 
        self:GetCaster():RemoveModifierByName("modifier_juggernaut_omni_slash_custom")
    end

    local start_pos = self:GetCaster():GetAbsOrigin()
    
    self:GetCaster():EmitSound("Hero_Juggernaut.OmniSlash")

    FindClearSpaceForUnit(self:GetCaster(), point, false)

    local targets = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, self:GetSpecialValueFor("omni_slash_radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)
    local first_target = targets[1] 
    
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_juggernaut_omni_slash_custom", {duration = duration, first_target = first_target:entindex(), scepter = true})

    if self:GetCaster():IsRealHero() then 
        PlayerResource:SetCameraTarget(self:GetCaster():GetPlayerOwnerID(), self:GetCaster())
        PlayerResource:SetCameraTarget(self:GetCaster():GetPlayerOwnerID(), nil)
    end

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, start_pos)
    ParticleManager:SetParticleControl(particle, 1, self:GetCaster():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)

    print("ПРОВЕРКА 1")
end









modifier_juggernaut_omni_slash_custom = class({})

function modifier_juggernaut_omni_slash_custom:IsPurgable() return false end

function modifier_juggernaut_omni_slash_custom:OnCreated(params)
    if not IsServer() then return end
    self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
    self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
    self.omni_slash_radius = self:GetAbility():GetSpecialValueFor("omni_slash_radius")

    self.first_target = EntIndexToHScript(params.first_target)

    self.turn = self:GetCaster():GetForwardVector()

    self.scepter = params.scepter

    self.attack_rate_multiplier = self:GetAbility():GetSpecialValueFor("attack_rate_multiplier")

    self.ishitting = false
    self.lastenemy = nil

    self:SetHasCustomTransmitterData(true)

    Timers:CreateTimer(FrameTime(),function()
        self.rate = (1/self:GetParent():GetAttacksPerSecond(true)) / self.attack_rate_multiplier
        self:slash(true)
        self:StartIntervalThink(self.rate)    
    end)
end

function modifier_juggernaut_omni_slash_custom:AddCustomTransmitterData() 
    self.TransmitterTable = self.TransmitterTable or {}

    self.TransmitterTable.damage = self.damage
    self.TransmitterTable.speed = self.speed

    return self.TransmitterTable
end

function modifier_juggernaut_omni_slash_custom:HandleCustomTransmitterData(data)
    self.damage = data.damage
    self.speed = data.speed
end

function modifier_juggernaut_omni_slash_custom:StatusEffectPriority()
    return 20
end

function modifier_juggernaut_omni_slash_custom:GetStatusEffectName()
    return "particles/status_fx/status_effect_omnislash.vpcf"
end

function modifier_juggernaut_omni_slash_custom:OnIntervalThink()
  self.rate = (1/self:GetParent():GetAttacksPerSecond(true))/(self.attack_rate_multiplier)
  self:slash(false)
  self:StartIntervalThink(self.rate)
end

function modifier_juggernaut_omni_slash_custom:TargetNear( target , near )
    if not IsServer() then return end

    for _,i in ipairs(near) do 
        if i == target then return true end
    end

    return false
end

function modifier_juggernaut_omni_slash_custom:DeclareFunctions()
	return
	{
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
  	}
end

function modifier_juggernaut_omni_slash_custom:GetModifierPreAttack_BonusDamage(params)
    local bonus = self:GetAbility():GetSpecialValueFor("bonus_damage")
    if _G.Players and _G.Players.QueueAttackBonus and params and params.attacker and params.target then
        _G.Players:QueueAttackBonus(params.attacker, params.target, bonus, "juggernaut_omni_slash_custom", DAMAGE_TYPE_PHYSICAL)
    end
    return bonus
end
function modifier_juggernaut_omni_slash_custom:GetModifierAttackSpeedBonus_Constant() return self:GetAbility():GetSpecialValueFor("bonus_attack_speed") end

function modifier_juggernaut_omni_slash_custom:OnDestroy()
    if not IsServer() then return end
    self:GetParent():FadeGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
    ExecuteOrderFromTable({
      UnitIndex = self:GetParent():entindex(),
      OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
      Position = self:GetParent():GetAbsOrigin(),
      Queue = false,
    })
end

function modifier_juggernaut_omni_slash_custom:CheckState()
    local state = {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_ROOTED] = true,
    }

    return state
end

function modifier_juggernaut_omni_slash_custom:GetModifierIgnoreCastAngle()
   return 1
end

function modifier_juggernaut_omni_slash_custom:slash( first )
if not IsServer() then return end
print("ПРОВЕРКА 4")
local order = FIND_ANY_ORDER

if first then
  order = FIND_CLOSEST
  number = 1 
else 
  number = number + 1 
end

self.ishitting = false

local target = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("omni_slash_radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS  + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, order, false)
    
if #target >= 1 then 

  for _,enemy in ipairs(target) do

    local can_hit = true

    if can_hit == true then

      print("ПРОВЕРКА 5")
      self.ishitting = true
      self:GetParent():RemoveGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
      self:GetParent():StartGesture(ACT_DOTA_OVERRIDE_ABILITY_4)

      local position1 = self:GetParent():GetAbsOrigin()

      if number%2 ~= 0 then       
        local position = (enemy:GetAbsOrigin() - (self.turn)*70)
        FindClearSpaceForUnit(self:GetParent(), position, false)
      else 
        local position = (enemy:GetAbsOrigin() + (self.turn)*70)
        FindClearSpaceForUnit(self:GetParent(), position, false)   
      end

      if number ~= 1 then  
          
        local angel = (enemy:GetAbsOrigin() - self:GetParent():GetAbsOrigin())
        angel.z = 0.0
        angel = angel:Normalized()

        self:GetParent():SetForwardVector(angel)
        self:GetParent():FaceTowards(enemy:GetAbsOrigin())
        print("ПРОВЕРКА 6")
      end

      local position2 = self:GetParent():GetAbsOrigin()

      local linken = false 
      if first and self:GetParent():IsRealHero() then 
        if enemy:TriggerSpellAbsorb(self:GetAbility()) then 
          linken = true
          print("ПРОВЕРКА 8")
        end
      end

      if linken == false then

        self:GetParent():PerformAttack(enemy, true, true, true, false, false, false, false)
        self.root_target = enemy

  
        enemy:EmitSound("Hero_Juggernaut.OmniSlash")
        print("ПРОВЕРКА 7")
      end


      local effect = "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_tgt.vpcf"
      if self.scepter == 1 then effect = "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_tgt_scepter.vpcf" end

      
         local particle = ParticleManager:CreateParticle( effect, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
          ParticleManager:SetParticleControlEnt( particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_sword", self:GetCaster():GetAbsOrigin(), true )
          ParticleManager:SetParticleControl( particle, 1, position2 )

   
      effect = "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf"
      if self.scepter == 1 then effect = "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail_scepter.vpcf" end

      local trail_pfx = ParticleManager:CreateParticle(effect, PATTACH_ABSORIGIN, self:GetParent())
      ParticleManager:SetParticleControl(trail_pfx, 0, position1)
      ParticleManager:SetParticleControl(trail_pfx, 1, position2)
      ParticleManager:ReleaseParticleIndex(trail_pfx)


      self.lastenemy = enemy
      return

    end
  end
end
Timers:CreateTimer(0.15,function()
if self then 

  if self ~= nil and not self:IsNull() and self.ishitting == false and self:GetParent() ~= nil then

    if not self:GetParent():IsRealHero() then 
      self:GetParent():ForceKill(false)
    end  
    print("ПРОВЕРКА 9")
    self:Destroy() 
  end

end

end)
   
end
