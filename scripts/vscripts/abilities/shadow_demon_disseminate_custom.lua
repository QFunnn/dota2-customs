--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_shadow_demon_disseminate_custom", "abilities/shadow_demon_disseminate_custom", LUA_MODIFIER_MOTION_NONE)

shadow_demon_disseminate_custom = class({})

function shadow_demon_disseminate_custom:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    local duration = self:GetSpecialValueFor("duration")
    local radius = self:GetSpecialValueFor("radius")

    target:EmitSound("Hero_ShadowDemon.Soul_Catcher")

    local cast_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_new.vpcf", PATTACH_WORLDORIGIN, target)
    ParticleManager:SetParticleControl(cast_particle, 0, target:GetAbsOrigin())
    ParticleManager:SetParticleControl(cast_particle, 1, Vector(radius, 0, 0))
    ParticleManager:ReleaseParticleIndex(cast_particle)

    target:AddNewModifier(caster, self, "modifier_shadow_demon_disseminate_custom", { duration = duration })
end

modifier_shadow_demon_disseminate_custom = class({})

function modifier_shadow_demon_disseminate_custom:IsDebuff()
    return self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber()
end

function modifier_shadow_demon_disseminate_custom:IsPurgable()
    return true
end

function modifier_shadow_demon_disseminate_custom:GetEffectName()
    return "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_debuff.vpcf"
end

function modifier_shadow_demon_disseminate_custom:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

function modifier_shadow_demon_disseminate_custom:OnCreated(kv)
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.reflect = self.ability:GetSpecialValueFor("damage_reflection_pct")
    self.radius = self.ability:GetSpecialValueFor("radius")
    if not IsServer() then return end
    self.caster = self:GetCaster()
    self.dmg_list = {}
    self.total_incoming = 0
    self.total_reflected = 0
    self:StartIntervalThink(1.0)
end

function modifier_shadow_demon_disseminate_custom:OnRefresh(kv)
    self:OnCreated(kv)
end

function modifier_shadow_demon_disseminate_custom:OnIntervalThink()
    if not IsServer() then return end
    self:FlushDamage("TICK")
end

function modifier_shadow_demon_disseminate_custom:OnDestroy()
    if not IsServer() then return end
    self:FlushDamage("DESTROY")
end

function modifier_shadow_demon_disseminate_custom:FlushDamage(source)
    local count = 0
    local total = 0
    for _, dmg_t in pairs(self.dmg_list) do
        if dmg_t.victim and not dmg_t.victim:IsNull() then
            count = count + 1
            total = total + dmg_t.damage
            self.total_reflected = self.total_reflected + dmg_t.damage
            ApplyDamage(dmg_t)
        end
    end
    self.dmg_list = {}
end

function modifier_shadow_demon_disseminate_custom:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    }
end

function modifier_shadow_demon_disseminate_custom:GetModifierIncomingDamage_Percentage(params)
    if not IsServer() then return end
    if self:FlagExist(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) then
        return
    end

    local reflect = self.reflect
    local reflect_damage = params.original_damage * reflect / 100
    self.total_incoming = self.total_incoming + params.original_damage

    -- [NP3-4 / вар.A] Атакующий в ДРУГОЙ арене (глобалка кросс-арена) → отражаем одной
    -- целью В НЕГО, без радиуса (иначе рефлект лупит по крипам своей арены, а не в источник).
    do
        local attacker = params.attacker
        if attacker and not attacker:IsNull() then
            local atkArena = Players:GetUnitArena(attacker)
            local myArena = Players:GetUnitArena(self.parent)
            if atkArena and myArena and atkArena ~= myArena then
                self.total_reflected = self.total_reflected + reflect_damage
                ApplyDamage({
                    attacker = self.caster,
                    ability = self:GetAbility(),
                    damage_flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_REFLECTION,
                    victim = attacker,
                    damage = reflect_damage,
                    damage_type = params.damage_type,
                })
                return 0
            end
        end
    end

    local enemies = FindUnitsInRadius(
        self.caster:GetTeamNumber(),
        self.parent:GetOrigin(),
        nil,
        self.radius,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false
    )
    for _, enemy in pairs(enemies) do
        if enemy == self.parent then goto continue end
        local idx = enemy:entindex()

        -- Героям (вкл. иллюзии) возвращаем сразу — иначе у атакующего игрока
        -- секунда «бил и ничего не получал», потом разом большой dmg-spike.
        -- Крипы по-прежнему батчатся через self.dmg_list, чтобы не плодить
        -- сотни ApplyDamage в массовых боях и не убивать перфоманс.
        if enemy:IsHero() then
            self.total_reflected = self.total_reflected + reflect_damage
            ApplyDamage({
                attacker = self.caster,
                ability = self:GetAbility(),
                damage_flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_REFLECTION,
                victim = enemy,
                damage = reflect_damage,
                damage_type = params.damage_type,
            })
        else
            if self.dmg_list[idx] then
                self.dmg_list[idx].damage = self.dmg_list[idx].damage + reflect_damage
            else
                self.dmg_list[idx] = {
                    attacker = self.caster,
                    ability = self:GetAbility(),
                    damage_flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_REFLECTION,
                    victim = enemy,
                    damage = reflect_damage,
                    damage_type = params.damage_type,
                }
            end
        end
        ::continue::
    end
    return 0
end

function modifier_shadow_demon_disseminate_custom:FlagExist(a, b)
    local p, c, d = 1, 0, b
    while a > 0 and b > 0 do
        local ra, rb = a % 2, b % 2
        if ra + rb > 1 then c = c + p end
        a, b, p = (a - ra) / 2, (b - rb) / 2, p * 2
    end
    return c == d
end