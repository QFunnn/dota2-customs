--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GameEvents.Subscribe("event_create_particle_damage_for_player", CreateDamageParticleUp);

function GetShortDamageData(value)
{
    let damage = Number(value)

    let first_value = damage
    let third_value = 0

    if (damage >= 10000)
    {
        third_value = Math.floor(Math.log10(damage) / 4)

        if (third_value > 9)
        {
            third_value = 9
        }
        first_value = Math.floor(damage / Math.pow(10000, third_value))
    }
    return {
        value: first_value,
        suffix_id: third_value,
        length: String(first_value).length + (third_value > 0 ? 1 : 0)
    }
}

function CreateDamageParticleUp(data)
{
    let shortData = GetShortDamageData(data.value)

    let pfx_name = "particles/custom_message/damage_default.vpcf"

    let first_value = shortData.value
    let second_value = 0
    let third_value = shortData.suffix_id
    let fourth_value = shortData.length

    if (data.is_phys_crit === 1)
    {
        pfx_name = "particles/custom_message/physical_crit_damage.vpcf"
        fourth_value = fourth_value + 1
        second_value = 1
    }

    if (data.is_magic_crit === 1)
    {
        pfx_name = "particles/custom_message/magical_crit.vpcf"
        fourth_value = fourth_value + 1
        second_value = 1
    }

    let pfx = Particles.CreateParticle(pfx_name, ParticleAttachment_t.PATTACH_WORLDORIGIN, -1)
    Particles.SetParticleControl(pfx, 0, [data.x, data.y, 250])
    Particles.SetParticleControl(pfx, 1, [second_value, first_value, third_value])
    Particles.SetParticleControl(pfx, 2, [2, fourth_value, 0])

    $.Schedule(2.5, function()
    {
        if (pfx !== undefined && pfx !== -1)
        {
            Particles.DestroyParticleEffect(pfx, true)
            Particles.ReleaseParticleIndex(pfx)
        }
    })
}