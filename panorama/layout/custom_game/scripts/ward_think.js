--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var vectorTargetParticle;
var vectorTargetParticleDB;
var lastAbility = -1;
var cachedLocalPlayer = -1;
function Think()
{
    // Планируем следующий кадр
    $.Schedule(1/144, Think);
    
    // Кэшируем часто используемые элементы
    cachedLocalPlayer = Players.GetLocalPlayerPortraitUnit();
    let cachedAbility = Abilities.GetLocalPlayerActiveAbility();
    let abilityName = cachedAbility !== 1 ? Abilities.GetAbilityName(cachedAbility) : "";

    // Обработка смены способности
    if (cachedAbility != lastAbility) {
        lastAbility = cachedAbility;
        
        // Уничтожаем старую частицу, если есть
        if (vectorTargetParticle) 
        {
            Particles.DestroyParticleEffect(vectorTargetParticle, true);
            vectorTargetParticle = undefined;
        }

        if (vectorTargetParticleDB) 
        {
            Particles.DestroyParticleEffect(vectorTargetParticleDB, true);
            vectorTargetParticleDB = undefined;
        }
        
        // Создаем новую частицу в зависимости от способности
        switch (abilityName) {
            case "item_ward_dispenser_custom":
                vectorTargetParticle = Particles.CreateParticle(
                    "particles/ui_mouseactions/range_finder_ward_aoe.vpcf", 
                    ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, 
                    cachedLocalPlayer
                );
                break;
                
            case "muerta_the_calling_custom":
                vectorTargetParticle = Particles.CreateParticle(
                    "particles/units/heroes/hero_muerta/muerta_calling_reticule_2.vpcf", 
                    ParticleAttachment_t.PATTACH_WORLDORIGIN, 
                    cachedLocalPlayer
                );
                break;

            case "sniper_headshot_custom":
                vectorTargetParticle = Particles.CreateParticle(
                    "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_range_finder_aoe.vpcf", 
                    ParticleAttachment_t.PATTACH_WORLDORIGIN, 
                    cachedLocalPlayer
                );
                break;

            case "dawnbreaker_fire_wreath_custom":
                vectorTargetParticle = Particles.CreateParticle(
                    "particles/units/heroes/hero_dawnbreaker/hero_dawnbreaker_combo_strike_range_finder_aoe.vpcf", 
                    ParticleAttachment_t.PATTACH_WORLDORIGIN, 
                    cachedLocalPlayer
                );
                break;

            case "dawnbreaker_solar_guardian_custom":
                if (!HasModifier(cachedLocalPlayer, "modifier_dawnbreaker_14") )
                {
                    vectorTargetParticle = Particles.CreateParticle(
                        "particles/ui_mouseactions/range_finder_generic_aoe.vpcf", 
                        ParticleAttachment_t.PATTACH_WORLDORIGIN, 
                        cachedLocalPlayer
                    );
                    vectorTargetParticleDB = Particles.CreateParticle(
                        "particles/ui_mouseactions/range_finder_tp_dest.vpcf", 
                        ParticleAttachment_t.PATTACH_WORLDORIGIN, 
                        cachedLocalPlayer
                    );
                }
                break;
        }
    }

    // Обновление частицы, если она существует
    if (vectorTargetParticle) {
        const cursor = GameUI.GetCursorPosition();
        const worldPosition = GameUI.GetScreenWorldPosition(cursor);
        if (worldPosition != null)
        {
            switch (abilityName) {
                case "item_ward_dispenser_custom":
                    updateWardDispenserParticle(worldPosition);
                    break;
                    
                case "muerta_the_calling_custom":
                    updateMuertaCallingParticle(worldPosition);
                    break;

                case "sniper_headshot_custom":
                    UpdateHeadshotParticle(worldPosition);
                    break;

                case "dawnbreaker_fire_wreath_custom":
                    UpdateDawnBreakerFireWreath(worldPosition);
                    break;

                case "dawnbreaker_solar_guardian_custom":
                    if (!HasModifier(cachedLocalPlayer, "modifier_dawnbreaker_14") )
                    {
                        UpdateSolarGuardian(worldPosition);
                    }
                    break;
            }
        }
    }

    // Обновление интерфейса телепорта
    updateTeleportUI();
}

// Вспомогательные функции
function updateWardDispenserParticle(worldPosition) {
    const unitOrigin = Entities.GetAbsOrigin(cachedLocalPlayer);
    
    Particles.SetParticleControl(vectorTargetParticle, 0, unitOrigin);
    Particles.SetParticleControl(vectorTargetParticle, 1, [255, 255, 255]);
    Particles.SetParticleControl(vectorTargetParticle, 6, [255, 255, 255]);
    Particles.SetParticleControl(vectorTargetParticle, 2, worldPosition);
    
    const modifier = FindModifier(cachedLocalPlayer, "modifier_item_ward_dispenser_custom_ward");
    if (modifier !== "none") {
        const ability = Buffs.GetAbility(cachedLocalPlayer, modifier);
        const wardTable = CustomNetTables.GetTableValue('ward_type', String(ability));
        
        if (wardTable?.type) {
            if (wardTable.type === "observer") {
                Particles.SetParticleControl(vectorTargetParticle, 11, [0, 0, 0]);
                Particles.SetParticleControl(vectorTargetParticle, 3, [1600, 1600, 1600]);
            } else if (wardTable.type === "sentry") {
                Particles.SetParticleControl(vectorTargetParticle, 11, [1, 0, 0]);
                Particles.SetParticleControl(vectorTargetParticle, 3, [800, 800, 800]);
            }
        }
    }
}

function updateMuertaCallingParticle(worldPosition) {
    let radius = 580
    let origin = Entities.GetAbsOrigin( Players.GetLocalPlayerPortraitUnit() )

    Particles.SetParticleControl(vectorTargetParticle, 1, [radius, radius, radius] );

    let c = Math.sqrt( 2 ) * 0.5 * radius 
    let x_offset = [ -radius+120, -c, 0.0, c, radius-120, c, 0.0, -c ]
    let y_offset = [ 0.0, c, radius-120, c, 0.0, -c, -radius+120, -c ]

    Particles.SetParticleControl(vectorTargetParticle, 0, worldPosition );
    Particles.SetParticleControl(vectorTargetParticle, 2, Vector_add2(worldPosition,[x_offset[0], y_offset[0], 0]) );
    Particles.SetParticleControl(vectorTargetParticle, 3, Vector_add2(worldPosition,[x_offset[0], y_offset[0], 0]) );
    Particles.SetParticleControl(vectorTargetParticle, 4, Vector_add2(worldPosition,[x_offset[2], y_offset[2], 0]) );
    Particles.SetParticleControl(vectorTargetParticle, 5, Vector_add2(worldPosition,[x_offset[2], y_offset[2], 0]) );
    Particles.SetParticleControl(vectorTargetParticle, 6, Vector_add2(worldPosition,[x_offset[4], y_offset[4], 0]) );
    Particles.SetParticleControl(vectorTargetParticle, 7, Vector_add2(worldPosition,[x_offset[4], y_offset[4], 0]) );
    Particles.SetParticleControl(vectorTargetParticle, 8, Vector_add2(worldPosition,[x_offset[6], y_offset[6], 0]) );
    Particles.SetParticleControl(vectorTargetParticle, 9, Vector_add2(worldPosition,[x_offset[6], y_offset[6], 0]) );
}

function UpdateHeadshotParticle(worldPosition) 
{
    let point_blank = 0;
    let distance = 450;
    let blast_width_end = 400;
    let origin = Entities.GetAbsOrigin( Players.GetLocalPlayerPortraitUnit() )
    let width_start = 225;
    let k = (point_blank/distance)
    if (worldPosition == null) { return } 
    let direction = Vector_normalize(Vector_sub(origin, worldPosition));
    let cast_range = distance
    Particles.SetParticleControl(vectorTargetParticle, 0, origin );
    Particles.SetParticleControl(vectorTargetParticle, 1, Vector_sub(origin, Vector_mult(direction, (cast_range + (blast_width_end*0.7) ))) );
    Particles.SetParticleControl(vectorTargetParticle, 2, [width_start/2, blast_width_end/2, 0] );
    Particles.SetParticleControl(vectorTargetParticle, 3, [width_start/2, (blast_width_end*0.7)/2, 0] );
    Particles.SetParticleControl(vectorTargetParticle, 6, Vector_sub(origin, Vector_mult(direction, point_blank)) );
}

function UpdateDawnBreakerFireWreath(worldPosition) 
{
    let hero_index = Players.GetLocalPlayerPortraitUnit();
    let ability = Abilities.GetLocalPlayerActiveAbility();
    let smash_distance = 360
    let origin = Entities.GetAbsOrigin( Players.GetLocalPlayerPortraitUnit() )
    let smash_radius = 300
    if (worldPosition == null) { return } 
    let direction = Vector_normalize(Vector_sub(origin, worldPosition));
    Particles.SetParticleControl(vectorTargetParticle, 0, origin );
    Particles.SetParticleControl(vectorTargetParticle, 1, Vector_sub(origin, Vector_mult(direction, smash_distance)) );
    Particles.SetParticleControl(vectorTargetParticle, 6, [smash_radius, smash_radius, 0] );
}

function UpdateSolarGuardian(worldPosition) 
{
    if (!worldPosition) return;

    let hero_index = Players.GetLocalPlayerPortraitUnit();
    let ability = Abilities.GetLocalPlayerActiveAbility();
    let nearest_teammate = FindClosestFriendly(worldPosition);
    let origin = Entities.GetAbsOrigin(hero_index);

    // позиция тиммейта
    let teammate_pos = Entities.GetAbsOrigin(nearest_teammate);
    let radius_max = 350
    let stacks_count = HowStacks("modifier_dawnbreaker_8")
    if (stacks_count > 0)
    {
        radius_max = radius_max + (stacks_count * 150)
    }

    // 🔒 ограничиваем worldPosition радиусом 350 от тиммейта
    worldPosition = ClampToRadius(teammate_pos, worldPosition, radius_max);

    let direction = Vector_normalize(Vector_sub(origin, worldPosition));

    Particles.SetParticleControl(vectorTargetParticle, 0, origin);
    Particles.SetParticleControl(vectorTargetParticle, 2, worldPosition);
    Particles.SetParticleControl(vectorTargetParticle, 3, [500, 500, 500]);
    Particles.SetParticleControl(vectorTargetParticle, 4, worldPosition);

    Particles.SetParticleControl(vectorTargetParticleDB, 2, teammate_pos);
    Particles.SetParticleControl(vectorTargetParticleDB, 3, [radius_max, radius_max, radius_max]);
    Particles.SetParticleControl(vectorTargetParticleDB, 4, [255, 255, 0]);
    Particles.SetParticleControl(vectorTargetParticleDB, 7, worldPosition);
}

function ClampToRadius(center, point, maxRadius) {
    // center и point — это [x, y, z]
    var dx = point[0] - center[0];
    var dy = point[1] - center[1];
    var dz = point[2] - center[2];

    var dist = Math.sqrt(dx*dx + dy*dy + dz*dz);
    if (dist === 0 || dist <= maxRadius) {
        return point;
    }

    var k = maxRadius / dist;

    return [
        center[0] + dx * k,
        center[1] + dy * k,
        center[2] + dz * k,
    ];
}

function FindClosestFriendly(world_position) 
{
	let min_distance = Infinity;
    let all_heroes = Entities.GetAllHeroEntities();
	for (const range_source of all_heroes) 
    {
		if (Entities.GetTeamNumber(range_source) == Players.GetTeam( Players.GetLocalPlayer() )) 
        {
			let building_location = Entities.GetAbsOrigin(range_source);
			if (VectorLengths(building_location) > 1) 
            {
				let current_distance = VectorLengths(Vector_sub(world_position, building_location));
				if (current_distance < min_distance) 
                {
				    min_distance = current_distance
				    closest_tp_target = range_source
				}
			}
		}
	}
	return closest_tp_target
}

function Vector_normalize(vec)
{
	const val = 1 / Math.sqrt(Math.pow(vec[0], 2) + Math.pow(vec[1], 2) + Math.pow(vec[2], 2));
	return [vec[0] * val, vec[1] * val, vec[2] * val];
}

function updateTeleportUI() {
    const panel = FindDotaHudElement("inventory_tpscroll_container");
    
    if (!panel) return;
    
    const panelCharges = panel.FindChildTraverse("tpCharges");
    if (panelCharges) {
        panelCharges.visible = true;
        
        const modifier = FindModifier(cachedLocalPlayer, "modifier_item_ward_dispenser_custom_ward");
        if (modifier !== "none") {
            const ability = Buffs.GetAbility(cachedLocalPlayer, modifier);
            panelCharges.text = 
                Items.GetSecondaryCharges(ability) + "/" + 
                Items.GetCurrentCharges(ability);
        } else {
            panelCharges.text = "0/0";
        }
    }
    
    const panelHotkey = panel.FindChildTraverse("inventory_tpscroll_HotkeyContainer")?.FindChildTraverse("Hotkey");
    if (panelHotkey) 
    {
        panelHotkey.visible = true;
    }
}

VectorLengths = (vec_array) => {
    return Math.sqrt(vec_array[0] * vec_array[0] + vec_array[1] * vec_array[1] + vec_array[2] * vec_array[2]);
};
 
function Vector_add2(vec1, vec2)
{
	if (vec1)
	{
		return [vec1[0] + vec2[0], vec1[1] + vec2[1], vec1[2] + vec2[2]];
	}
}


Think()