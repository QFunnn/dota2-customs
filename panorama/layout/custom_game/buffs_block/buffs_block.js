--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");
if (parentHUDElements)
{
    var center_block = parentHUDElements.FindChildTraverse("center_block");
    $.GetContextPanel().SetParent(center_block);
}

var hero = Players.GetLocalPlayerPortraitUnit()

UpdateHeroHudBuffs();

function UpdateHeroHudBuffs()
{
    if (hero != Players.GetLocalPlayerPortraitUnit())
    {
        $("#SkillsPlayer").RemoveAndDeleteChildren()
    }

    hero = Players.GetLocalPlayerPortraitUnit()

    if (HasModifier(hero, "modifier_item_essence_of_speed"))
    {
        CreateSkill("modifier_item_essence_of_speed", 1)
    }

    if (HasModifier(hero, "modifier_item_gem_shard"))
    {
        CreateSkill("modifier_item_gem_shard", 2, 500)
    }

    if (HasModifier(hero, "modifier_item_gem_shard_2"))
    {
        CreateSkill("modifier_item_gem_shard_2", 3, 1000)
    }

    if (HasModifier(hero, "modifier_item_moon_shard_buff_custom"))
    {
        CreateSkill("modifier_item_moon_shard_buff_custom", 4)
    }

    if (HasModifier(hero, "modifier_item_dark_moon_shard"))
    {
        CreateSkill("modifier_item_dark_moon_shard", 5)
    }

    $.Schedule(0.1, UpdateHeroHudBuffs)
}

function HasModifier(unit, modifier) 
{
    for (var i = 0; i < Entities.GetNumBuffs(unit); i++) 
    {
        if (Buffs.GetName(unit, Entities.GetBuff(unit, i)) == modifier)
        {
            return Entities.GetBuff(unit, i)
        }
    }
   return false
}

function CreateSkill(modifier, tier, radius)
{
    let this_skill = $("#SkillsPlayer").FindChildTraverse(modifier)

    if (this_skill)
    {
        return
    }

    var Skill = $.CreatePanel("Panel", $("#SkillsPlayer"), modifier);
    Skill.AddClass("SkillPanel"+tier);
    Skill.AddClass("Skill")
    Skill.style.backgroundImage = 'url("file://{images}/custom_game/buffs/' + modifier + '.png")';
    Skill.style.backgroundSize = "contain"
    Skill.style.backgroundPosition = "center"
    Skill.style.backgroundRepeat = "no-repeat"

    SetShowText(Skill, modifier, radius)
}

function SetShowText(panel, text, radius)
{
    panel.SetPanelEvent('onmouseover', function() {
        var unit = Players.GetLocalPlayerPortraitUnit();
        $.DispatchEvent( "DOTAShowBuffTooltip", panel, unit, HasModifier(unit, text) , Entities.IsEnemy( unit ) );
        if (radius) {
            var particleId = Particles.CreateParticle("particles/ui_mouseactions/range_display.vpcf", ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, unit);
            Particles.SetParticleControl(particleId, 1, [radius, 0, 0]);
            panel._radiusParticle = particleId;
        }
    })
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent( "DOTAHideBuffTooltip", panel );
        if (panel._radiusParticle != undefined) {
            Particles.DestroyParticleEffect(panel._radiusParticle, true);
            panel._radiusParticle = undefined;
        }
    });
}