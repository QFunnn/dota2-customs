--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "framework/property_system/properties"
PropertyFunction = PropertyFunction or {}
PropertyFunction.HEALTH = 400
PropertyFunction[PropertyFunction.HEALTH] = "HEALTH"
PropertyFunction.BASE_HEALTH = 401
PropertyFunction[PropertyFunction.BASE_HEALTH] = "BASE_HEALTH"
PropertyFunction.HEALTH_AMPLIFY = 402
PropertyFunction[PropertyFunction.HEALTH_AMPLIFY] = "HEALTH_AMPLIFY"
PropertyFunction.HEAL_ROOM_START = 403
PropertyFunction[PropertyFunction.HEAL_ROOM_START] = "HEAL_ROOM_START"
PropertyFunction.HEALTH_COST_ROOM_START = 404
PropertyFunction[PropertyFunction.HEALTH_COST_ROOM_START] = "HEALTH_COST_ROOM_START"
PropertyFunction.BASE_MANA = 405
PropertyFunction[PropertyFunction.BASE_MANA] = "BASE_MANA"
PropertyFunction.MANA = 406
PropertyFunction[PropertyFunction.MANA] = "MANA"
PropertyFunction.MANA_AMPLIFY = 407
PropertyFunction[PropertyFunction.MANA_AMPLIFY] = "MANA_AMPLIFY"
PropertyFunction.BASE_ATTACK = 408
PropertyFunction[PropertyFunction.BASE_ATTACK] = "BASE_ATTACK"
PropertyFunction.ATTACK = 409
PropertyFunction[PropertyFunction.ATTACK] = "ATTACK"
PropertyFunction.ATTACK_AMPLIFY = 410
PropertyFunction[PropertyFunction.ATTACK_AMPLIFY] = "ATTACK_AMPLIFY"
PropertyFunction.ATTACKSPEED = 411
PropertyFunction[PropertyFunction.ATTACKSPEED] = "ATTACKSPEED"
PropertyFunction.ATTACKSPEED_REDUCTION = 412
PropertyFunction[PropertyFunction.ATTACKSPEED_REDUCTION] = "ATTACKSPEED_REDUCTION"
PropertyFunction.WISP_ATTACKSPEED = 413
PropertyFunction[PropertyFunction.WISP_ATTACKSPEED] = "WISP_ATTACKSPEED"
PropertyFunction.WISP_DAMAGE = 414
PropertyFunction[PropertyFunction.WISP_DAMAGE] = "WISP_DAMAGE"
PropertyFunction.COOLDOWN_REDUCTION = 415
PropertyFunction[PropertyFunction.COOLDOWN_REDUCTION] = "COOLDOWN_REDUCTION"
PropertyFunction.BOSS_GAP_AMPLIFY = 416
PropertyFunction[PropertyFunction.BOSS_GAP_AMPLIFY] = "BOSS_GAP_AMPLIFY"
PropertyFunction.ATTACK_RANGE = 417
PropertyFunction[PropertyFunction.ATTACK_RANGE] = "ATTACK_RANGE"
PropertyFunction.ATTACK_RANGE_MELEE = 418
PropertyFunction[PropertyFunction.ATTACK_RANGE_MELEE] = "ATTACK_RANGE_MELEE"
PropertyFunction.ATTACK_RANGE_RANGER = 419
PropertyFunction[PropertyFunction.ATTACK_RANGE_RANGER] = "ATTACK_RANGE_RANGER"
PropertyFunction.BULLET_RANGE = 420
PropertyFunction[PropertyFunction.BULLET_RANGE] = "BULLET_RANGE"
PropertyFunction.AOE_AMPLIFY = 421
PropertyFunction[PropertyFunction.AOE_AMPLIFY] = "AOE_AMPLIFY"
PropertyFunction.CRIT_CHANCE = 422
PropertyFunction[PropertyFunction.CRIT_CHANCE] = "CRIT_CHANCE"
PropertyFunction.ATTACK_CRIT_CHANCE = 423
PropertyFunction[PropertyFunction.ATTACK_CRIT_CHANCE] = "ATTACK_CRIT_CHANCE"
PropertyFunction.SPELL_CRIT_CHANCE = 424
PropertyFunction[PropertyFunction.SPELL_CRIT_CHANCE] = "SPELL_CRIT_CHANCE"
PropertyFunction.EXPOSE_ATTACK_CRIT_CHANCE = 425
PropertyFunction[PropertyFunction.EXPOSE_ATTACK_CRIT_CHANCE] = "EXPOSE_ATTACK_CRIT_CHANCE"
PropertyFunction.CRIT_DAMAGE = 426
PropertyFunction[PropertyFunction.CRIT_DAMAGE] = "CRIT_DAMAGE"
PropertyFunction.CRIT_DAMAGE_MULT = 427
PropertyFunction[PropertyFunction.CRIT_DAMAGE_MULT] = "CRIT_DAMAGE_MULT"
PropertyFunction.BARRIER_CRIT_DAMAGE = 428
PropertyFunction[PropertyFunction.BARRIER_CRIT_DAMAGE] = "BARRIER_CRIT_DAMAGE"
PropertyFunction.BLEED_CRIT_DAMAGE = 429
PropertyFunction[PropertyFunction.BLEED_CRIT_DAMAGE] = "BLEED_CRIT_DAMAGE"
PropertyFunction.ATTACK_CRIT_DAMAGE = 430
PropertyFunction[PropertyFunction.ATTACK_CRIT_DAMAGE] = "ATTACK_CRIT_DAMAGE"
PropertyFunction.ATTACK_CRIT_DAMAGE_BOOST = 431
PropertyFunction[PropertyFunction.ATTACK_CRIT_DAMAGE_BOOST] = "ATTACK_CRIT_DAMAGE_BOOST"
PropertyFunction.SPELL_CRIT_DAMAGE = 432
PropertyFunction[PropertyFunction.SPELL_CRIT_DAMAGE] = "SPELL_CRIT_DAMAGE"
PropertyFunction.SPELL_CRIT_DAMAGE_BOOST = 433
PropertyFunction[PropertyFunction.SPELL_CRIT_DAMAGE_BOOST] = "SPELL_CRIT_DAMAGE_BOOST"
PropertyFunction.ATTACK_DAMAGE_PROC = 434
PropertyFunction[PropertyFunction.ATTACK_DAMAGE_PROC] = "ATTACK_DAMAGE_PROC"
PropertyFunction.SPELL_DAMAGE_PROC = 435
PropertyFunction[PropertyFunction.SPELL_DAMAGE_PROC] = "SPELL_DAMAGE_PROC"
PropertyFunction.SPELL_DAMAGE_PROC_TARGET = 436
PropertyFunction[PropertyFunction.SPELL_DAMAGE_PROC_TARGET] = "SPELL_DAMAGE_PROC_TARGET"
PropertyFunction.DAMAGE_PROC_TARGET = 437
PropertyFunction[PropertyFunction.DAMAGE_PROC_TARGET] = "DAMAGE_PROC_TARGET"
PropertyFunction.DAMAGE_AMPLIFY = 438
PropertyFunction[PropertyFunction.DAMAGE_AMPLIFY] = "DAMAGE_AMPLIFY"
PropertyFunction.FINAL_DAMAGE = 439
PropertyFunction[PropertyFunction.FINAL_DAMAGE] = "FINAL_DAMAGE"
PropertyFunction.FINAL_DEFENSE = 440
PropertyFunction[PropertyFunction.FINAL_DEFENSE] = "FINAL_DEFENSE"
PropertyFunction.FINAL_DAMAGE_101 = 441
PropertyFunction[PropertyFunction.FINAL_DAMAGE_101] = "FINAL_DAMAGE_101"
PropertyFunction.FINAL_DAMAGE_102 = 442
PropertyFunction[PropertyFunction.FINAL_DAMAGE_102] = "FINAL_DAMAGE_102"
PropertyFunction.FINAL_DAMAGE_103 = 443
PropertyFunction[PropertyFunction.FINAL_DAMAGE_103] = "FINAL_DAMAGE_103"
PropertyFunction.PHYSICAL_DAMAGE_AMPLIFY = 444
PropertyFunction[PropertyFunction.PHYSICAL_DAMAGE_AMPLIFY] = "PHYSICAL_DAMAGE_AMPLIFY"
PropertyFunction.MAGICAL_DAMAGE_AMPLIFY = 445
PropertyFunction[PropertyFunction.MAGICAL_DAMAGE_AMPLIFY] = "MAGICAL_DAMAGE_AMPLIFY"
PropertyFunction.ATTACK_DAMAGE_AMPLIFY = 446
PropertyFunction[PropertyFunction.ATTACK_DAMAGE_AMPLIFY] = "ATTACK_DAMAGE_AMPLIFY"
PropertyFunction.SPELL_DAMAGE_AMPLIFY = 447
PropertyFunction[PropertyFunction.SPELL_DAMAGE_AMPLIFY] = "SPELL_DAMAGE_AMPLIFY"
PropertyFunction.BACKSTAB_DAMAGE_AMPLIFY = 448
PropertyFunction[PropertyFunction.BACKSTAB_DAMAGE_AMPLIFY] = "BACKSTAB_DAMAGE_AMPLIFY"
PropertyFunction.BACKSTAB_DAMAGE_BOOST = 449
PropertyFunction[PropertyFunction.BACKSTAB_DAMAGE_BOOST] = "BACKSTAB_DAMAGE_BOOST"
PropertyFunction.BARRIER_DAMAGE_AMPLIFY = 450
PropertyFunction[PropertyFunction.BARRIER_DAMAGE_AMPLIFY] = "BARRIER_DAMAGE_AMPLIFY"
PropertyFunction.BARRIER_DAMAGE_BOOST = 451
PropertyFunction[PropertyFunction.BARRIER_DAMAGE_BOOST] = "BARRIER_DAMAGE_BOOST"
PropertyFunction.RETALIATED_DAMAGE_AMPLIFY = 452
PropertyFunction[PropertyFunction.RETALIATED_DAMAGE_AMPLIFY] = "RETALIATED_DAMAGE_AMPLIFY"
PropertyFunction.RING_DAMAGE_AMPLIFY = 453
PropertyFunction[PropertyFunction.RING_DAMAGE_AMPLIFY] = "RING_DAMAGE_AMPLIFY"
PropertyFunction.RING_DAMAGE_BOOST = 454
PropertyFunction[PropertyFunction.RING_DAMAGE_BOOST] = "RING_DAMAGE_BOOST"
PropertyFunction.BLADE_DAMAGE_AMPLIFY = 455
PropertyFunction[PropertyFunction.BLADE_DAMAGE_AMPLIFY] = "BLADE_DAMAGE_AMPLIFY"
PropertyFunction.BLADE_SPEED_AMPLIFY = 456
PropertyFunction[PropertyFunction.BLADE_SPEED_AMPLIFY] = "BLADE_SPEED_AMPLIFY"
PropertyFunction.DAMAGE_REDUCTION = 457
PropertyFunction[PropertyFunction.DAMAGE_REDUCTION] = "DAMAGE_REDUCTION"
PropertyFunction.POISON_POOL_SHIELD_ATTENUATION_INTERVAL_AMPLIFY = 458
PropertyFunction[PropertyFunction.POISON_POOL_SHIELD_ATTENUATION_INTERVAL_AMPLIFY] =
	"POISON_POOL_SHIELD_ATTENUATION_INTERVAL_AMPLIFY"
PropertyFunction.INCOMING_DAMAGE_AMPLIFY = 459
PropertyFunction[PropertyFunction.INCOMING_DAMAGE_AMPLIFY] = "INCOMING_DAMAGE_AMPLIFY"
PropertyFunction.TRAP_INCOMING_DAMAGE_AMPLIFY = 460
PropertyFunction[PropertyFunction.TRAP_INCOMING_DAMAGE_AMPLIFY] = "TRAP_INCOMING_DAMAGE_AMPLIFY"
PropertyFunction.TRAP_DAMAGE_AMPLIFY = 461
PropertyFunction[PropertyFunction.TRAP_DAMAGE_AMPLIFY] = "TRAP_DAMAGE_AMPLIFY"
PropertyFunction.POISON_ATTENUATION_INTERVAL_AMPLIFY = 462
PropertyFunction[PropertyFunction.POISON_ATTENUATION_INTERVAL_AMPLIFY] = "POISON_ATTENUATION_INTERVAL_AMPLIFY"
PropertyFunction.POISON_POOL_INCOMING_DAMAGE_AMPLIFY = 463
PropertyFunction[PropertyFunction.POISON_POOL_INCOMING_DAMAGE_AMPLIFY] = "POISON_POOL_INCOMING_DAMAGE_AMPLIFY"
PropertyFunction.TAVERN_EFFECT_AMPLIFY = 464
PropertyFunction[PropertyFunction.TAVERN_EFFECT_AMPLIFY] = "TAVERN_EFFECT_AMPLIFY"
PropertyFunction.EVASION = 465
PropertyFunction[PropertyFunction.EVASION] = "EVASION"
PropertyFunction.AVOID_DAMAGE = 466
PropertyFunction[PropertyFunction.AVOID_DAMAGE] = "AVOID_DAMAGE"
PropertyFunction.MIN_HEALTH = 467
PropertyFunction[PropertyFunction.MIN_HEALTH] = "MIN_HEALTH"
PropertyFunction.HEAL_AMPLIFY = 468
PropertyFunction[PropertyFunction.HEAL_AMPLIFY] = "HEAL_AMPLIFY"
PropertyFunction.FURY_AMPLIFY = 469
PropertyFunction[PropertyFunction.FURY_AMPLIFY] = "FURY_AMPLIFY"
PropertyFunction.FURY_REGEN = 470
PropertyFunction[PropertyFunction.FURY_REGEN] = "FURY_REGEN"
PropertyFunction.CRIT_FURY_AMPLIFY = 471
PropertyFunction[PropertyFunction.CRIT_FURY_AMPLIFY] = "CRIT_FURY_AMPLIFY"
PropertyFunction.SKILL_FURY_AMPLIFY = 472
PropertyFunction[PropertyFunction.SKILL_FURY_AMPLIFY] = "SKILL_FURY_AMPLIFY"
PropertyFunction.RING_FURY_AMPLIFY = 473
PropertyFunction[PropertyFunction.RING_FURY_AMPLIFY] = "RING_FURY_AMPLIFY"
PropertyFunction.MOVESPEED = 474
PropertyFunction[PropertyFunction.MOVESPEED] = "MOVESPEED"
PropertyFunction.MOVESPEED_NOT_CALCULATED = 475
PropertyFunction[PropertyFunction.MOVESPEED_NOT_CALCULATED] = "MOVESPEED_NOT_CALCULATED"
PropertyFunction.MOVESPEED_AMPLIFY = 476
PropertyFunction[PropertyFunction.MOVESPEED_AMPLIFY] = "MOVESPEED_AMPLIFY"
PropertyFunction.SHOP_DISCOUNT = 477
PropertyFunction[PropertyFunction.SHOP_DISCOUNT] = "SHOP_DISCOUNT"
PropertyFunction.SHOP_REFRESH_REFUND = 478
PropertyFunction[PropertyFunction.SHOP_REFRESH_REFUND] = "SHOP_REFRESH_REFUND"
PropertyFunction.SPLIT_COUNT = 479
PropertyFunction[PropertyFunction.SPLIT_COUNT] = "SPLIT_COUNT"
PropertyFunction.ABILITY_CHARGE_ATTACK = 480
PropertyFunction[PropertyFunction.ABILITY_CHARGE_ATTACK] = "ABILITY_CHARGE_ATTACK"
PropertyFunction.ABILITY_CHARGE_SKILL = 481
PropertyFunction[PropertyFunction.ABILITY_CHARGE_SKILL] = "ABILITY_CHARGE_SKILL"
PropertyFunction.ABILITY_CHARGE_DODGE = 482
PropertyFunction[PropertyFunction.ABILITY_CHARGE_DODGE] = "ABILITY_CHARGE_DODGE"
PropertyFunction.ABILITY_CHARGE_DEFENSE = 483
PropertyFunction[PropertyFunction.ABILITY_CHARGE_DEFENSE] = "ABILITY_CHARGE_DEFENSE"
PropertyFunction.ABILITY_CHARGE_ULTIMATE = 484
PropertyFunction[PropertyFunction.ABILITY_CHARGE_ULTIMATE] = "ABILITY_CHARGE_ULTIMATE"
PropertyFunction.RING_COUNT = 485
PropertyFunction[PropertyFunction.RING_COUNT] = "RING_COUNT"
PropertyFunction.RING_SPEED_AMPLIFY = 486
PropertyFunction[PropertyFunction.RING_SPEED_AMPLIFY] = "RING_SPEED_AMPLIFY"
PropertyFunction.RING_TRACK_RADIUS = 487
PropertyFunction[PropertyFunction.RING_TRACK_RADIUS] = "RING_TRACK_RADIUS"
PropertyFunction.LIGHTNING_MULTIPLE_CHANCE = 488
PropertyFunction[PropertyFunction.LIGHTNING_MULTIPLE_CHANCE] = "LIGHTNING_MULTIPLE_CHANCE"
PropertyFunction.LIGHTNING_RADIUS = 489
PropertyFunction[PropertyFunction.LIGHTNING_RADIUS] = "LIGHTNING_RADIUS"
PropertyFunction.LIGHTNING_DAMAGE = 490
PropertyFunction[PropertyFunction.LIGHTNING_DAMAGE] = "LIGHTNING_DAMAGE"
PropertyFunction.LIGHTNING_EXPOSE_CHANCE = 491
PropertyFunction[PropertyFunction.LIGHTNING_EXPOSE_CHANCE] = "LIGHTNING_EXPOSE_CHANCE"
PropertyFunction.EXPOSE_KEEP_CHANCE = 492
PropertyFunction[PropertyFunction.EXPOSE_KEEP_CHANCE] = "EXPOSE_KEEP_CHANCE"
PropertyFunction.LIGHTNING_COUNT = 493
PropertyFunction[PropertyFunction.LIGHTNING_COUNT] = "LIGHTNING_COUNT"
PropertyFunction.POISON_NO_ATTENUATION_CHANCE = 494
PropertyFunction[PropertyFunction.POISON_NO_ATTENUATION_CHANCE] = "POISON_NO_ATTENUATION_CHANCE"
PropertyFunction.POISON_ATTENUATION_REDUCTION = 495
PropertyFunction[PropertyFunction.POISON_ATTENUATION_REDUCTION] = "POISON_ATTENUATION_REDUCTION"
PropertyFunction.FROZEN_NO_ATTENUATION_CHANCE = 496
PropertyFunction[PropertyFunction.FROZEN_NO_ATTENUATION_CHANCE] = "FROZEN_NO_ATTENUATION_CHANCE"
PropertyFunction.FROZEN_ATTENUATION_REDUCTION = 497
PropertyFunction[PropertyFunction.FROZEN_ATTENUATION_REDUCTION] = "FROZEN_ATTENUATION_REDUCTION"
PropertyFunction.FROZEN_DAMAGE_AMPLIFY = 498
PropertyFunction[PropertyFunction.FROZEN_DAMAGE_AMPLIFY] = "FROZEN_DAMAGE_AMPLIFY"
PropertyFunction.SHIELD_ATTENUATION_REDUCTION = 499
PropertyFunction[PropertyFunction.SHIELD_ATTENUATION_REDUCTION] = "SHIELD_ATTENUATION_REDUCTION"
PropertyFunction.SHIELD_ATTENUATION_INTERVAL_AMPLIFY = 500
PropertyFunction[PropertyFunction.SHIELD_ATTENUATION_INTERVAL_AMPLIFY] = "SHIELD_ATTENUATION_INTERVAL_AMPLIFY"
PropertyFunction.SHIELD_NO_ATTENUATION_CHANCE = 501
PropertyFunction[PropertyFunction.SHIELD_NO_ATTENUATION_CHANCE] = "SHIELD_NO_ATTENUATION_CHANCE"
PropertyFunction.FROZEN_BURST_STACK = 502
PropertyFunction[PropertyFunction.FROZEN_BURST_STACK] = "FROZEN_BURST_STACK"
PropertyFunction.BOUNCE_COUNT = 503
PropertyFunction[PropertyFunction.BOUNCE_COUNT] = "BOUNCE_COUNT"
PropertyFunction.LASER_BOUNCE_COUNT = 504
PropertyFunction[PropertyFunction.LASER_BOUNCE_COUNT] = "LASER_BOUNCE_COUNT"
PropertyFunction.LASER_DAMAGE_AMPLIFY = 505
PropertyFunction[PropertyFunction.LASER_DAMAGE_AMPLIFY] = "LASER_DAMAGE_AMPLIFY"
PropertyFunction.SNOWBALL_BOUNCE_COUNT = 506
PropertyFunction[PropertyFunction.SNOWBALL_BOUNCE_COUNT] = "SNOWBALL_BOUNCE_COUNT"
PropertyFunction.SNOWBALL_EXTRA_SHOT = 507
PropertyFunction[PropertyFunction.SNOWBALL_EXTRA_SHOT] = "SNOWBALL_EXTRA_SHOT"
PropertyFunction.SNOWBALL_DAMAGE = 508
PropertyFunction[PropertyFunction.SNOWBALL_DAMAGE] = "SNOWBALL_DAMAGE"
PropertyFunction.ICE_STRIKE = 509
PropertyFunction[PropertyFunction.ICE_STRIKE] = "ICE_STRIKE"
PropertyFunction.REFLECT_DAMAGE = 510
PropertyFunction[PropertyFunction.REFLECT_DAMAGE] = "REFLECT_DAMAGE"
PropertyFunction.PER_ENCOUNTER_ATTACK_BONUS = 511
PropertyFunction[PropertyFunction.PER_ENCOUNTER_ATTACK_BONUS] = "PER_ENCOUNTER_ATTACK_BONUS"
PropertyFunction.PER_ENCOUNTER_ATTACK_AMPLIFY = 512
PropertyFunction[PropertyFunction.PER_ENCOUNTER_ATTACK_AMPLIFY] = "PER_ENCOUNTER_ATTACK_AMPLIFY"
PropertyFunction.PER_ENCOUNTER_ATTACK_DAMAGE_AMPLIFY = 513
PropertyFunction[PropertyFunction.PER_ENCOUNTER_ATTACK_DAMAGE_AMPLIFY] = "PER_ENCOUNTER_ATTACK_DAMAGE_AMPLIFY"
PropertyFunction.PER_ENCOUNTER_SKILL_DAMAGE_AMPLIFY = 514
PropertyFunction[PropertyFunction.PER_ENCOUNTER_SKILL_DAMAGE_AMPLIFY] = "PER_ENCOUNTER_SKILL_DAMAGE_AMPLIFY"
PropertyFunction.PER_ENCOUNTER_ULTIMATE_DAMAGE_AMPLIFY = 515
PropertyFunction[PropertyFunction.PER_ENCOUNTER_ULTIMATE_DAMAGE_AMPLIFY] = "PER_ENCOUNTER_ULTIMATE_DAMAGE_AMPLIFY"
PropertyFunction.PER_ENCOUNTER_PHYSICAL_DAMAGE_AMPLIFY = 516
PropertyFunction[PropertyFunction.PER_ENCOUNTER_PHYSICAL_DAMAGE_AMPLIFY] = "PER_ENCOUNTER_PHYSICAL_DAMAGE_AMPLIFY"
PropertyFunction.PER_ENCOUNTER_MAGICAL_DAMAGE_AMPLIFY = 517
PropertyFunction[PropertyFunction.PER_ENCOUNTER_MAGICAL_DAMAGE_AMPLIFY] = "PER_ENCOUNTER_MAGICAL_DAMAGE_AMPLIFY"
PropertyFunction.PER_ENCOUNTER_MELEE_HERO_DAMAGE_AMPLIFY = 518
PropertyFunction[PropertyFunction.PER_ENCOUNTER_MELEE_HERO_DAMAGE_AMPLIFY] = "PER_ENCOUNTER_MELEE_HERO_DAMAGE_AMPLIFY"
PropertyFunction.PER_ENCOUNTER_RANGER_HERO_DAMAGE_AMPLIFY = 519
PropertyFunction[PropertyFunction.PER_ENCOUNTER_RANGER_HERO_DAMAGE_AMPLIFY] = "PER_ENCOUNTER_RANGER_HERO_DAMAGE_AMPLIFY"
PropertyFunction.PER_ENCOUNTER_CRIT_DAMAGE = 520
PropertyFunction[PropertyFunction.PER_ENCOUNTER_CRIT_DAMAGE] = "PER_ENCOUNTER_CRIT_DAMAGE"
PropertyFunction.BLOCK = 521
PropertyFunction[PropertyFunction.BLOCK] = "BLOCK"
PropertyFunction.POISON_STACKS_AMPLIFY = 522
PropertyFunction[PropertyFunction.POISON_STACKS_AMPLIFY] = "POISON_STACKS_AMPLIFY"
PropertyFunction.SHOCK_DAMAGE_AMPLIFY = 523
PropertyFunction[PropertyFunction.SHOCK_DAMAGE_AMPLIFY] = "SHOCK_DAMAGE_AMPLIFY"
PropertyFunction.BLEED_STACKS_AMPLIFY = 524
PropertyFunction[PropertyFunction.BLEED_STACKS_AMPLIFY] = "BLEED_STACKS_AMPLIFY"
PropertyFunction.FREEZE_STACKS_AMPLIFY = 525
PropertyFunction[PropertyFunction.FREEZE_STACKS_AMPLIFY] = "FREEZE_STACKS_AMPLIFY"
PropertyFunction.SHIELD_AMPLIFY = 526
PropertyFunction[PropertyFunction.SHIELD_AMPLIFY] = "SHIELD_AMPLIFY"
PropertyFunction.CRIT_DAMAGE_AMPLIFY = 527
PropertyFunction[PropertyFunction.CRIT_DAMAGE_AMPLIFY] = "CRIT_DAMAGE_AMPLIFY"
PropertyFunction.MELEE_HERO_DAMAGE_AMPLIFY = 528
PropertyFunction[PropertyFunction.MELEE_HERO_DAMAGE_AMPLIFY] = "MELEE_HERO_DAMAGE_AMPLIFY"
PropertyFunction.RANGER_HERO_DAMAGE_AMPLIFY = 529
PropertyFunction[PropertyFunction.RANGER_HERO_DAMAGE_AMPLIFY] = "RANGER_HERO_DAMAGE_AMPLIFY"
PropertyFunction.HEALTH_POTION_HEAL_AMPLIFY = 530
PropertyFunction[PropertyFunction.HEALTH_POTION_HEAL_AMPLIFY] = "HEALTH_POTION_HEAL_AMPLIFY"
PropertyFunction.CRIT_CHANCE_AMPLIFY = 531
PropertyFunction[PropertyFunction.CRIT_CHANCE_AMPLIFY] = "CRIT_CHANCE_AMPLIFY"
PropertyFunction.SPLASH_DAMAGE_AMPLIFY = 532
PropertyFunction[PropertyFunction.SPLASH_DAMAGE_AMPLIFY] = "SPLASH_DAMAGE_AMPLIFY"
PropertyFunction.SPLASH_DAMAGE_BOOST = 533
PropertyFunction[PropertyFunction.SPLASH_DAMAGE_BOOST] = "SPLASH_DAMAGE_BOOST"
PropertyFunction.DEBUFF_TARGET_DAMAGE_AMPLIFY = 534
PropertyFunction[PropertyFunction.DEBUFF_TARGET_DAMAGE_AMPLIFY] = "DEBUFF_TARGET_DAMAGE_AMPLIFY"
PropertyFunction.MINION_DAMAGE_BOOST = 535
PropertyFunction[PropertyFunction.MINION_DAMAGE_BOOST] = "MINION_DAMAGE_BOOST"
PropertyFunction.BOSS_DAMAGE_BOOST = 536
PropertyFunction[PropertyFunction.BOSS_DAMAGE_BOOST] = "BOSS_DAMAGE_BOOST"
PropertyFunction.ELITE_DAMAGE_BOOST = 537
PropertyFunction[PropertyFunction.ELITE_DAMAGE_BOOST] = "ELITE_DAMAGE_BOOST"
PropertyFunction.ALL_STATS_AMPLIFY = 538
PropertyFunction[PropertyFunction.ALL_STATS_AMPLIFY] = "ALL_STATS_AMPLIFY"
PropertyFunction.ULTIMATE_MANA_COST_REDUCE = 539
PropertyFunction[PropertyFunction.ULTIMATE_MANA_COST_REDUCE] = "ULTIMATE_MANA_COST_REDUCE"
PropertyFunction.BUFF_DURATION = 540
PropertyFunction[PropertyFunction.BUFF_DURATION] = "BUFF_DURATION"
PropertyFunction.DEBUFF_DURATION = 541
PropertyFunction[PropertyFunction.DEBUFF_DURATION] = "DEBUFF_DURATION"
PropertyFunction.ABILITY_CHARGE_DEFENSE_TIME = 542
PropertyFunction[PropertyFunction.ABILITY_CHARGE_DEFENSE_TIME] = "ABILITY_CHARGE_DEFENSE_TIME"
PropertyFunction.POTION_HEAL_RESTORE = 543
PropertyFunction[PropertyFunction.POTION_HEAL_RESTORE] = "POTION_HEAL_RESTORE"
PropertyFunction.BREAK_DROP_CHANCE = 544
PropertyFunction[PropertyFunction.BREAK_DROP_CHANCE] = "BREAK_DROP_CHANCE"
PropertyFunction.BREAK_DROP_PROFIT_PCT = 545
PropertyFunction[PropertyFunction.BREAK_DROP_PROFIT_PCT] = "BREAK_DROP_PROFIT_PCT"
PropertyFunction.REVIVE_COUNT = 546
PropertyFunction[PropertyFunction.REVIVE_COUNT] = "REVIVE_COUNT"
PropertyFunction.REVIVE_HEALTH_RECOVER = 547
PropertyFunction[PropertyFunction.REVIVE_HEALTH_RECOVER] = "REVIVE_HEALTH_RECOVER"
PropertyFunction.INITIAL_GOLD = 548
PropertyFunction[PropertyFunction.INITIAL_GOLD] = "INITIAL_GOLD"
PropertyFunction.EXP_GAIN_CHANCE = 549
PropertyFunction[PropertyFunction.EXP_GAIN_CHANCE] = "EXP_GAIN_CHANCE"
PropertyFunction.GOLD_ROOM_AMOUNT = 550
PropertyFunction[PropertyFunction.GOLD_ROOM_AMOUNT] = "GOLD_ROOM_AMOUNT"
PropertyFunction.SHOP_ITEM_RARITY = 551
PropertyFunction[PropertyFunction.SHOP_ITEM_RARITY] = "SHOP_ITEM_RARITY"
PropertyFunction.ARTIFACT_ITEM_RARITY = 552
PropertyFunction[PropertyFunction.ARTIFACT_ITEM_RARITY] = "ARTIFACT_ITEM_RARITY"
PropertyFunction.BLESSING_RARITY = 553
PropertyFunction[PropertyFunction.BLESSING_RARITY] = "BLESSING_RARITY"
PropertyFunction.ZEUS_BLESS_RARITY_UP = 554
PropertyFunction[PropertyFunction.ZEUS_BLESS_RARITY_UP] = "ZEUS_BLESS_RARITY_UP"
PropertyFunction.POISON_BLESS_RARITY_UP = 555
PropertyFunction[PropertyFunction.POISON_BLESS_RARITY_UP] = "POISON_BLESS_RARITY_UP"
PropertyFunction.ICE_BLESS_RARITY_UP = 556
PropertyFunction[PropertyFunction.ICE_BLESS_RARITY_UP] = "ICE_BLESS_RARITY_UP"
PropertyFunction.BLEED_BLESS_RARITY_UP = 557
PropertyFunction[PropertyFunction.BLEED_BLESS_RARITY_UP] = "BLEED_BLESS_RARITY_UP"
PropertyFunction.CRIT_BLESS_RARITY_UP = 558
PropertyFunction[PropertyFunction.CRIT_BLESS_RARITY_UP] = "CRIT_BLESS_RARITY_UP"
PropertyFunction.HOLY_BLESS_RARITY_UP = 559
PropertyFunction[PropertyFunction.HOLY_BLESS_RARITY_UP] = "HOLY_BLESS_RARITY_UP"
PropertyFunction.WIND_BLESS_RARITY_UP = 560
PropertyFunction[PropertyFunction.WIND_BLESS_RARITY_UP] = "WIND_BLESS_RARITY_UP"
PropertyFunction.BLESS_REFRESH_COUNT = 561
PropertyFunction[PropertyFunction.BLESS_REFRESH_COUNT] = "BLESS_REFRESH_COUNT"
PropertyFunction.ARTIFACT_ALLIN_COUNT = 562
PropertyFunction[PropertyFunction.ARTIFACT_ALLIN_COUNT] = "ARTIFACT_ALLIN_COUNT"
PropertyFunction.BLESS_ALLIN_COUNT = 563
PropertyFunction[PropertyFunction.BLESS_ALLIN_COUNT] = "BLESS_ALLIN_COUNT"
PropertyFunction.BLESS_UPGRADE_ALLIN_COUNT = 564
PropertyFunction[PropertyFunction.BLESS_UPGRADE_ALLIN_COUNT] = "BLESS_UPGRADE_ALLIN_COUNT"
PropertyFunction.ABILITY_UPGRADE_ALLIN_COUNT = 565
PropertyFunction[PropertyFunction.ABILITY_UPGRADE_ALLIN_COUNT] = "ABILITY_UPGRADE_ALLIN_COUNT"
PropertyFunction.ABILITY_UPGRADE_REFRESH_COUNT = 566
PropertyFunction[PropertyFunction.ABILITY_UPGRADE_REFRESH_COUNT] = "ABILITY_UPGRADE_REFRESH_COUNT"
PropertyFunction.EQUIP_EXTRA_POTENTIAL = 567
PropertyFunction[PropertyFunction.EQUIP_EXTRA_POTENTIAL] = "EQUIP_EXTRA_POTENTIAL"
PropertyFunction.EQUIP_EXTRA_DROP_BASE = 568
PropertyFunction[PropertyFunction.EQUIP_EXTRA_DROP_BASE] = "EQUIP_EXTRA_DROP_BASE"
PropertyFunction.EQUIP_DROP_PCT = 569
PropertyFunction[PropertyFunction.EQUIP_DROP_PCT] = "EQUIP_DROP_PCT"
PropertyFunction.EQUIP_DROP_NUM_PCT = 570
PropertyFunction[PropertyFunction.EQUIP_DROP_NUM_PCT] = "EQUIP_DROP_NUM_PCT"
PropertyFunction.EQUIP_RARITY_CHANCE = 571
PropertyFunction[PropertyFunction.EQUIP_RARITY_CHANCE] = "EQUIP_RARITY_CHANCE"
PropertyFunction.EQUIP_POTENTIAL_LUCKY = 572
PropertyFunction[PropertyFunction.EQUIP_POTENTIAL_LUCKY] = "EQUIP_POTENTIAL_LUCKY"
PropertyFunction.MELEE_DAMAGE_BOOST = 573
PropertyFunction[PropertyFunction.MELEE_DAMAGE_BOOST] = "MELEE_DAMAGE_BOOST"
PropertyFunction.RANGED_DAMAGE_BOOST = 574
PropertyFunction[PropertyFunction.RANGED_DAMAGE_BOOST] = "RANGED_DAMAGE_BOOST"
PropertyFunction.EXECUTE_DAMAGE = 575
PropertyFunction[PropertyFunction.EXECUTE_DAMAGE] = "EXECUTE_DAMAGE"
PropertyFunction.RAGE_CAPACITY_AMPLIFY = 576
PropertyFunction[PropertyFunction.RAGE_CAPACITY_AMPLIFY] = "RAGE_CAPACITY_AMPLIFY"
PropertyFunction.HEAVY_ATTACK = 577
PropertyFunction[PropertyFunction.HEAVY_ATTACK] = "HEAVY_ATTACK"
PropertyFunction.HP_REGENERATION = 578
PropertyFunction[PropertyFunction.HP_REGENERATION] = "HP_REGENERATION"
PropertyFunction.THORNS_DAMAGE = 579
PropertyFunction[PropertyFunction.THORNS_DAMAGE] = "THORNS_DAMAGE"
PropertyFunction.DAMAGE_VS_BLEEDING_TARGETS = 580
PropertyFunction[PropertyFunction.DAMAGE_VS_BLEEDING_TARGETS] = "DAMAGE_VS_BLEEDING_TARGETS"
PropertyFunction.DAMAGE_VS_FROZEN_TARGETS = 581
PropertyFunction[PropertyFunction.DAMAGE_VS_FROZEN_TARGETS] = "DAMAGE_VS_FROZEN_TARGETS"
PropertyFunction.DAMAGE_VS_SHOCKED_TARGETS = 582
PropertyFunction[PropertyFunction.DAMAGE_VS_SHOCKED_TARGETS] = "DAMAGE_VS_SHOCKED_TARGETS"
PropertyFunction.DAMAGE_VS_POISONED_TARGETS = 583
PropertyFunction[PropertyFunction.DAMAGE_VS_POISONED_TARGETS] = "DAMAGE_VS_POISONED_TARGETS"
PropertyFunction.FINISHER_DAMAGE = 584
PropertyFunction[PropertyFunction.FINISHER_DAMAGE] = "FINISHER_DAMAGE"
PropertyFunction.FINISHER_CRIT_CHANCE = 585
PropertyFunction[PropertyFunction.FINISHER_CRIT_CHANCE] = "FINISHER_CRIT_CHANCE"
PropertyFunction.SKILL_COOLDOWN_REDUCTION = 586
PropertyFunction[PropertyFunction.SKILL_COOLDOWN_REDUCTION] = "SKILL_COOLDOWN_REDUCTION"
PropertyFunction.EVADE_COOLDOWN_REDUCTION = 587
PropertyFunction[PropertyFunction.EVADE_COOLDOWN_REDUCTION] = "EVADE_COOLDOWN_REDUCTION"
PropertyFunction.BLOCK_COOLDOWN_REDUCTION = 588
PropertyFunction[PropertyFunction.BLOCK_COOLDOWN_REDUCTION] = "BLOCK_COOLDOWN_REDUCTION"
PropertyFunction.ULTIMATE_COOLDOWN_REDUCTION = 589
PropertyFunction[PropertyFunction.ULTIMATE_COOLDOWN_REDUCTION] = "ULTIMATE_COOLDOWN_REDUCTION"
PropertyFunction.GOLD_GAIN_AMOUNT = 590
PropertyFunction[PropertyFunction.GOLD_GAIN_AMOUNT] = "GOLD_GAIN_AMOUNT"
PropertyFunction.EXP_GAIN_AMOUNT = 591
PropertyFunction[PropertyFunction.EXP_GAIN_AMOUNT] = "EXP_GAIN_AMOUNT"
PropertyFunction.GOLD_REWARD_PER_ENCOUNTER = 592
PropertyFunction[PropertyFunction.GOLD_REWARD_PER_ENCOUNTER] = "GOLD_REWARD_PER_ENCOUNTER"
PropertyFunction.EXP_REWARD_PER_ENCOUNTER = 593
PropertyFunction[PropertyFunction.EXP_REWARD_PER_ENCOUNTER] = "EXP_REWARD_PER_ENCOUNTER"
PropertyFunction.POISON_DECAY_REDUCTION = 594
PropertyFunction[PropertyFunction.POISON_DECAY_REDUCTION] = "POISON_DECAY_REDUCTION"
PropertyFunction.BLEED_TRIGGER_INTERVAL = 595
PropertyFunction[PropertyFunction.BLEED_TRIGGER_INTERVAL] = "BLEED_TRIGGER_INTERVAL"
PropertyFunction.FREEZE_DURATION = 596
PropertyFunction[PropertyFunction.FREEZE_DURATION] = "FREEZE_DURATION"
PropertyFunction.SHOCK_NO_DECAY_RATE = 597
PropertyFunction[PropertyFunction.SHOCK_NO_DECAY_RATE] = "SHOCK_NO_DECAY_RATE"
PropertyFunction.RAGE_GAIN_PERCENT_PER_ATTACK = 598
PropertyFunction[PropertyFunction.RAGE_GAIN_PERCENT_PER_ATTACK] = "RAGE_GAIN_PERCENT_PER_ATTACK"
PropertyFunction.RAGE_GAIN_PERCENT_PER_BLOCK = 599
PropertyFunction[PropertyFunction.RAGE_GAIN_PERCENT_PER_BLOCK] = "RAGE_GAIN_PERCENT_PER_BLOCK"
PropertyFunction.RAGE_GAIN_PERCENT_PER_EVADE = 600
PropertyFunction[PropertyFunction.RAGE_GAIN_PERCENT_PER_EVADE] = "RAGE_GAIN_PERCENT_PER_EVADE"
PropertyFunction.RAGE_GAIN_PERCENT_PER_ULTIMATE = 601
PropertyFunction[PropertyFunction.RAGE_GAIN_PERCENT_PER_ULTIMATE] = "RAGE_GAIN_PERCENT_PER_ULTIMATE"
PropertyFunction.POISON_DAMAGE_AMPLIFY = 602
PropertyFunction[PropertyFunction.POISON_DAMAGE_AMPLIFY] = "POISON_DAMAGE_AMPLIFY"
PropertyFunction.POISON_DAMAGE_BOOST = 603
PropertyFunction[PropertyFunction.POISON_DAMAGE_BOOST] = "POISON_DAMAGE_BOOST"
PropertyFunction.LIGHTNING_DAMAGE_AMPLIFY = 604
PropertyFunction[PropertyFunction.LIGHTNING_DAMAGE_AMPLIFY] = "LIGHTNING_DAMAGE_AMPLIFY"
PropertyFunction.LIGHTNING_DAMAGE_BOOST = 605
PropertyFunction[PropertyFunction.LIGHTNING_DAMAGE_BOOST] = "LIGHTNING_DAMAGE_BOOST"
PropertyFunction.HOLY_SHIELD_DAMAGE_BOOST = 606
PropertyFunction[PropertyFunction.HOLY_SHIELD_DAMAGE_BOOST] = "HOLY_SHIELD_DAMAGE_BOOST"
PropertyFunction.BLEED_DAMAGE_AMPLIFY = 607
PropertyFunction[PropertyFunction.BLEED_DAMAGE_AMPLIFY] = "BLEED_DAMAGE_AMPLIFY"
PropertyFunction.BLEED_DAMAGE_BOOST = 608
PropertyFunction[PropertyFunction.BLEED_DAMAGE_BOOST] = "BLEED_DAMAGE_BOOST"
PropertyFunction.BLADE_DAMAGE_BOOST = 609
PropertyFunction[PropertyFunction.BLADE_DAMAGE_BOOST] = "BLADE_DAMAGE_BOOST"
PropertyFunction.FREEZE_DAMAGE_AMPLIFY = 610
PropertyFunction[PropertyFunction.FREEZE_DAMAGE_AMPLIFY] = "FREEZE_DAMAGE_AMPLIFY"
PropertyFunction.FREEZE_DAMAGE_BOOST = 611
PropertyFunction[PropertyFunction.FREEZE_DAMAGE_BOOST] = "FREEZE_DAMAGE_BOOST"
PropertyFunction.SHIELD_DAMAGE_AMPLIFY = 612
PropertyFunction[PropertyFunction.SHIELD_DAMAGE_AMPLIFY] = "SHIELD_DAMAGE_AMPLIFY"
PropertyFunction.EXECUTE_DAMAGE_AMPLIFY = 613
PropertyFunction[PropertyFunction.EXECUTE_DAMAGE_AMPLIFY] = "EXECUTE_DAMAGE_AMPLIFY"
PropertyFunction.CONDITIONAL_DAMAGE_AMPLIFY = 614
PropertyFunction[PropertyFunction.CONDITIONAL_DAMAGE_AMPLIFY] = "CONDITIONAL_DAMAGE_AMPLIFY"
PropertyFunction.ATTACK_DAMAGE_BOOST = 615
PropertyFunction[PropertyFunction.ATTACK_DAMAGE_BOOST] = "ATTACK_DAMAGE_BOOST"
PropertyFunction.SPELL_DAMAGE_BOOST = 616
PropertyFunction[PropertyFunction.SPELL_DAMAGE_BOOST] = "SPELL_DAMAGE_BOOST"
PropertyFunction.SKILL_DAMAGE_AMPLIFY = 617
PropertyFunction[PropertyFunction.SKILL_DAMAGE_AMPLIFY] = "SKILL_DAMAGE_AMPLIFY"
PropertyFunction.SKILL_DAMAGE_BOOST = 618
PropertyFunction[PropertyFunction.SKILL_DAMAGE_BOOST] = "SKILL_DAMAGE_BOOST"
PropertyFunction.ULTIMATE_DAMAGE_AMPLIFY = 619
PropertyFunction[PropertyFunction.ULTIMATE_DAMAGE_AMPLIFY] = "ULTIMATE_DAMAGE_AMPLIFY"
PropertyFunction.ULTIMATE_DAMAGE_BOOST = 620
PropertyFunction[PropertyFunction.ULTIMATE_DAMAGE_BOOST] = "ULTIMATE_DAMAGE_BOOST"
PropertyFunction.DODGE_DAMAGE_AMPLIFY = 621
PropertyFunction[PropertyFunction.DODGE_DAMAGE_AMPLIFY] = "DODGE_DAMAGE_AMPLIFY"
PropertyFunction.DODGE_DAMAGE_BOOST = 622
PropertyFunction[PropertyFunction.DODGE_DAMAGE_BOOST] = "DODGE_DAMAGE_BOOST"
PropertyFunction.DEFENSE_DAMAGE_AMPLIFY = 623
PropertyFunction[PropertyFunction.DEFENSE_DAMAGE_AMPLIFY] = "DEFENSE_DAMAGE_AMPLIFY"
PropertyFunction.DEFENSE_DAMAGE_BOOST = 624
PropertyFunction[PropertyFunction.DEFENSE_DAMAGE_BOOST] = "DEFENSE_DAMAGE_BOOST"
PropertyFunction.MELEE_HERO_DAMAGE_BOOST = 625
PropertyFunction[PropertyFunction.MELEE_HERO_DAMAGE_BOOST] = "MELEE_HERO_DAMAGE_BOOST"
PropertyFunction.RANGER_HERO_DAMAGE_BOOST = 626
PropertyFunction[PropertyFunction.RANGER_HERO_DAMAGE_BOOST] = "RANGER_HERO_DAMAGE_BOOST"
PropertyFunction.DAMAGE_BOOST = 627
PropertyFunction[PropertyFunction.DAMAGE_BOOST] = "DAMAGE_BOOST"
PropertyFunction.MAGICAL_DAMAGE_BOOST = 628
PropertyFunction[PropertyFunction.MAGICAL_DAMAGE_BOOST] = "MAGICAL_DAMAGE_BOOST"
PropertyFunction.PHYSICAL_DAMAGE_BOOST = 629
PropertyFunction[PropertyFunction.PHYSICAL_DAMAGE_BOOST] = "PHYSICAL_DAMAGE_BOOST"
PropertyFunction.DAMAGE_BOOST_PER_LEVEL = 630
PropertyFunction[PropertyFunction.DAMAGE_BOOST_PER_LEVEL] = "DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.PHYSICAL_DAMAGE_BOOST_PER_LEVEL = 631
PropertyFunction[PropertyFunction.PHYSICAL_DAMAGE_BOOST_PER_LEVEL] = "PHYSICAL_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.MAGICAL_DAMAGE_BOOST_PER_LEVEL = 632
PropertyFunction[PropertyFunction.MAGICAL_DAMAGE_BOOST_PER_LEVEL] = "MAGICAL_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.RAGE_GAIN_PERCENT_PER_SKILL = 633
PropertyFunction[PropertyFunction.RAGE_GAIN_PERCENT_PER_SKILL] = "RAGE_GAIN_PERCENT_PER_SKILL"
PropertyFunction.BONUS_FROST_DAMAGE = 634
PropertyFunction[PropertyFunction.BONUS_FROST_DAMAGE] = "BONUS_FROST_DAMAGE"
PropertyFunction.BONUS_POISON_DAMAGE = 635
PropertyFunction[PropertyFunction.BONUS_POISON_DAMAGE] = "BONUS_POISON_DAMAGE"
PropertyFunction.BONUS_LIGHTNING_DAMAGE = 636
PropertyFunction[PropertyFunction.BONUS_LIGHTNING_DAMAGE] = "BONUS_LIGHTNING_DAMAGE"
PropertyFunction.BONUS_BLEED_DAMAGE = 637
PropertyFunction[PropertyFunction.BONUS_BLEED_DAMAGE] = "BONUS_BLEED_DAMAGE"
PropertyFunction.HP_REGEN_PER_ENCOUNTER = 638
PropertyFunction[PropertyFunction.HP_REGEN_PER_ENCOUNTER] = "HP_REGEN_PER_ENCOUNTER"
PropertyFunction.MANA_REGEN_PER_ENCOUNTER = 639
PropertyFunction[PropertyFunction.MANA_REGEN_PER_ENCOUNTER] = "MANA_REGEN_PER_ENCOUNTER"
PropertyFunction.ELEMENTAL_DAMAGE = 640
PropertyFunction[PropertyFunction.ELEMENTAL_DAMAGE] = "ELEMENTAL_DAMAGE"
PropertyFunction.PHYSICAL_ARMOR = 641
PropertyFunction[PropertyFunction.PHYSICAL_ARMOR] = "PHYSICAL_ARMOR"
PropertyFunction.HP_REGEN_ON_KILL = 642
PropertyFunction[PropertyFunction.HP_REGEN_ON_KILL] = "HP_REGEN_ON_KILL"
PropertyFunction.ATTACK_SPEED_BOOST = 643
PropertyFunction[PropertyFunction.ATTACK_SPEED_BOOST] = "ATTACK_SPEED_BOOST"
PropertyFunction.DAMAGE_INTENSITY = 644
PropertyFunction[PropertyFunction.DAMAGE_INTENSITY] = "DAMAGE_INTENSITY"
PropertyFunction.DAMAGE_INTENSITY_BOOST = 645
PropertyFunction[PropertyFunction.DAMAGE_INTENSITY_BOOST] = "DAMAGE_INTENSITY_BOOST"
PropertyFunction.DEFENSE_INTENSITY = 646
PropertyFunction[PropertyFunction.DEFENSE_INTENSITY] = "DEFENSE_INTENSITY"
PropertyFunction.DEFENSE_INTENSITY_BOOST = 647
PropertyFunction[PropertyFunction.DEFENSE_INTENSITY_BOOST] = "DEFENSE_INTENSITY_BOOST"
PropertyFunction.HERO_DAMAGE_BOOST = 648
PropertyFunction[PropertyFunction.HERO_DAMAGE_BOOST] = "HERO_DAMAGE_BOOST"
PropertyFunction.HERO_DEFENSE_BOOST = 649
PropertyFunction[PropertyFunction.HERO_DEFENSE_BOOST] = "HERO_DEFENSE_BOOST"
PropertyFunction.DAMAGE_BOOST_MULT = 650
PropertyFunction[PropertyFunction.DAMAGE_BOOST_MULT] = "DAMAGE_BOOST_MULT"
PropertyFunction.LIGHTNING_CLOUD_DAMAGE = 651
PropertyFunction[PropertyFunction.LIGHTNING_CLOUD_DAMAGE] = "LIGHTNING_CLOUD_DAMAGE"
PropertyFunction.LIGHTNING_CLOUD_DURATION = 652
PropertyFunction[PropertyFunction.LIGHTNING_CLOUD_DURATION] = "LIGHTNING_CLOUD_DURATION"
PropertyFunction.LIGHTNING_CLOUD_HIT_COUNT = 653
PropertyFunction[PropertyFunction.LIGHTNING_CLOUD_HIT_COUNT] = "LIGHTNING_CLOUD_HIT_COUNT"
PropertyFunction.IDLE_POWER_RECOVER = 654
PropertyFunction[PropertyFunction.IDLE_POWER_RECOVER] = "IDLE_POWER_RECOVER"
PropertyFunction.IDLE_MAX_POWER = 655
PropertyFunction[PropertyFunction.IDLE_MAX_POWER] = "IDLE_MAX_POWER"
PropertyFunction.IDLE_MAX_POWER_PCT = 656
PropertyFunction[PropertyFunction.IDLE_MAX_POWER_PCT] = "IDLE_MAX_POWER_PCT"
PropertyFunction.IDLE_POWER_COST_INC_PCT = 657
PropertyFunction[PropertyFunction.IDLE_POWER_COST_INC_PCT] = "IDLE_POWER_COST_INC_PCT"
PropertyFunction.IDLE_POWER_COST_REDUCE_PCT = 658
PropertyFunction[PropertyFunction.IDLE_POWER_COST_REDUCE_PCT] = "IDLE_POWER_COST_REDUCE_PCT"
PropertyFunction.IDLE_FISH_TOTAL_PROFIT = 659
PropertyFunction[PropertyFunction.IDLE_FISH_TOTAL_PROFIT] = "IDLE_FISH_TOTAL_PROFIT"
PropertyFunction.IDLE_FISH_TOTAL_PROFIT_PCT = 660
PropertyFunction[PropertyFunction.IDLE_FISH_TOTAL_PROFIT_PCT] = "IDLE_FISH_TOTAL_PROFIT_PCT"
PropertyFunction.IDLE_FISH_NORMALBOX_CHANCE = 661
PropertyFunction[PropertyFunction.IDLE_FISH_NORMALBOX_CHANCE] = "IDLE_FISH_NORMALBOX_CHANCE"
PropertyFunction.IDLE_FISH_GOLDBOX_CHANCE = 662
PropertyFunction[PropertyFunction.IDLE_FISH_GOLDBOX_CHANCE] = "IDLE_FISH_GOLDBOX_CHANCE"
PropertyFunction.IDLE_FISH_BOX_PROFIT_PCT = 663
PropertyFunction[PropertyFunction.IDLE_FISH_BOX_PROFIT_PCT] = "IDLE_FISH_BOX_PROFIT_PCT"
PropertyFunction.ABILITY_UPGRADE_COUNT = 664
PropertyFunction[PropertyFunction.ABILITY_UPGRADE_COUNT] = "ABILITY_UPGRADE_COUNT"
PropertyFunction.IDLE_FISH_RAINBOW_CHANCE = 665
PropertyFunction[PropertyFunction.IDLE_FISH_RAINBOW_CHANCE] = "IDLE_FISH_RAINBOW_CHANCE"
PropertyFunction.IDLE_FISH_RAINBOW1_CHANCE = 666
PropertyFunction[PropertyFunction.IDLE_FISH_RAINBOW1_CHANCE] = "IDLE_FISH_RAINBOW1_CHANCE"
PropertyFunction.IDLE_FISH_RAINBOW2_CHANCE = 667
PropertyFunction[PropertyFunction.IDLE_FISH_RAINBOW2_CHANCE] = "IDLE_FISH_RAINBOW2_CHANCE"
PropertyFunction.IDLE_FISH_RAINBOW3_CHANCE = 668
PropertyFunction[PropertyFunction.IDLE_FISH_RAINBOW3_CHANCE] = "IDLE_FISH_RAINBOW3_CHANCE"
PropertyFunction.IDLE_FISH_RAINBOW4_CHANCE = 669
PropertyFunction[PropertyFunction.IDLE_FISH_RAINBOW4_CHANCE] = "IDLE_FISH_RAINBOW4_CHANCE"
PropertyFunction.IDLE_FISH_RAINBOW5_CHANCE = 670
PropertyFunction[PropertyFunction.IDLE_FISH_RAINBOW5_CHANCE] = "IDLE_FISH_RAINBOW5_CHANCE"
PropertyFunction.IDLE_FISH_CHANCE = 671
PropertyFunction[PropertyFunction.IDLE_FISH_CHANCE] = "IDLE_FISH_CHANCE"
PropertyFunction.IDLE_FISH_NUM = 672
PropertyFunction[PropertyFunction.IDLE_FISH_NUM] = "IDLE_FISH_NUM"
PropertyFunction.IDLE_FISH_NUM_PCT = 673
PropertyFunction[PropertyFunction.IDLE_FISH_NUM_PCT] = "IDLE_FISH_NUM_PCT"
PropertyFunction.IDLE_FISH_CRIT_CHANCE = 674
PropertyFunction[PropertyFunction.IDLE_FISH_CRIT_CHANCE] = "IDLE_FISH_CRIT_CHANCE"
PropertyFunction.IDLE_FISH_CRIT_NUM = 675
PropertyFunction[PropertyFunction.IDLE_FISH_CRIT_NUM] = "IDLE_FISH_CRIT_NUM"
PropertyFunction.IDLE_FISH_LUCKY_NUM = 676
PropertyFunction[PropertyFunction.IDLE_FISH_LUCKY_NUM] = "IDLE_FISH_LUCKY_NUM"
PropertyFunction.IDLE_FISH_EFFICIENCY = 677
PropertyFunction[PropertyFunction.IDLE_FISH_EFFICIENCY] = "IDLE_FISH_EFFICIENCY"
PropertyFunction.IDLE_FISH_INTERACTION_PCT = 678
PropertyFunction[PropertyFunction.IDLE_FISH_INTERACTION_PCT] = "IDLE_FISH_INTERACTION_PCT"
PropertyFunction.IDLE_FISH_ESCAPE_SPEED_PCT = 679
PropertyFunction[PropertyFunction.IDLE_FISH_ESCAPE_SPEED_PCT] = "IDLE_FISH_ESCAPE_SPEED_PCT"
PropertyFunction.IDLE_FISH_WAIT_TIME_REDUCE_PCT = 680
PropertyFunction[PropertyFunction.IDLE_FISH_WAIT_TIME_REDUCE_PCT] = "IDLE_FISH_WAIT_TIME_REDUCE_PCT"
PropertyFunction.IDLE_FISH_COURIER_SLOT = 681
PropertyFunction[PropertyFunction.IDLE_FISH_COURIER_SLOT] = "IDLE_FISH_COURIER_SLOT"
PropertyFunction.AQUARIUM_SLOT = 682
PropertyFunction[PropertyFunction.AQUARIUM_SLOT] = "AQUARIUM_SLOT"
PropertyFunction.HOLY_SHIELD_DAMAGE_BOOST2 = 683
PropertyFunction[PropertyFunction.HOLY_SHIELD_DAMAGE_BOOST2] = "HOLY_SHIELD_DAMAGE_BOOST2"
PropertyFunction.BLADE_SWORD_BOOST2 = 684
PropertyFunction[PropertyFunction.BLADE_SWORD_BOOST2] = "BLADE_SWORD_BOOST2"
PropertyFunction.DASH_DISTANCE = 685
PropertyFunction[PropertyFunction.DASH_DISTANCE] = "DASH_DISTANCE"
PropertyFunction.MOVE_DISTANCE_EFFICIENCY = 686
PropertyFunction[PropertyFunction.MOVE_DISTANCE_EFFICIENCY] = "MOVE_DISTANCE_EFFICIENCY"
PropertyFunction.EXPLORE_PROFIT_110005_PCT = 687
PropertyFunction[PropertyFunction.EXPLORE_PROFIT_110005_PCT] = "EXPLORE_PROFIT_110005_PCT"
PropertyFunction.RESOURCE_PROFIT_STONE_PCT = 688
PropertyFunction[PropertyFunction.RESOURCE_PROFIT_STONE_PCT] = "RESOURCE_PROFIT_STONE_PCT"
PropertyFunction.RESOURCE_PROFIT_FORGE_PCT = 689
PropertyFunction[PropertyFunction.RESOURCE_PROFIT_FORGE_PCT] = "RESOURCE_PROFIT_FORGE_PCT"
PropertyFunction.RESOURCE_PROFIT_TALENT_PCT = 690
PropertyFunction[PropertyFunction.RESOURCE_PROFIT_TALENT_PCT] = "RESOURCE_PROFIT_TALENT_PCT"
PropertyFunction.RESOURCE_PROFIT_210001_PCT = 691
PropertyFunction[PropertyFunction.RESOURCE_PROFIT_210001_PCT] = "RESOURCE_PROFIT_210001_PCT"
PropertyFunction.LIGHTNING_DAMAGE_BOOST2 = 692
PropertyFunction[PropertyFunction.LIGHTNING_DAMAGE_BOOST2] = "LIGHTNING_DAMAGE_BOOST2"
PropertyFunction.POISON_DAMAGE_BOOST2 = 693
PropertyFunction[PropertyFunction.POISON_DAMAGE_BOOST2] = "POISON_DAMAGE_BOOST2"
PropertyFunction.FREEZE_DAMAGE_BOOST2 = 694
PropertyFunction[PropertyFunction.FREEZE_DAMAGE_BOOST2] = "FREEZE_DAMAGE_BOOST2"
PropertyFunction.BLEED_DAMAGE_BOOST2 = 695
PropertyFunction[PropertyFunction.BLEED_DAMAGE_BOOST2] = "BLEED_DAMAGE_BOOST2"
PropertyFunction.HOLY_SUIT_EFFECT_BOOST = 696
PropertyFunction[PropertyFunction.HOLY_SUIT_EFFECT_BOOST] = "HOLY_SUIT_EFFECT_BOOST"
PropertyFunction.ZEUS_SUIT_EFFECT_BOOST = 697
PropertyFunction[PropertyFunction.ZEUS_SUIT_EFFECT_BOOST] = "ZEUS_SUIT_EFFECT_BOOST"
PropertyFunction.ICE_SUIT_EFFECT_BOOST = 698
PropertyFunction[PropertyFunction.ICE_SUIT_EFFECT_BOOST] = "ICE_SUIT_EFFECT_BOOST"
PropertyFunction.POISON_SUIT_EFFECT_BOOST = 699
PropertyFunction[PropertyFunction.POISON_SUIT_EFFECT_BOOST] = "POISON_SUIT_EFFECT_BOOST"
PropertyFunction.BLEED_SUIT_EFFECT_BOOST = 700
PropertyFunction[PropertyFunction.BLEED_SUIT_EFFECT_BOOST] = "BLEED_SUIT_EFFECT_BOOST"
PropertyFunction.CRIT_SUIT_EFFECT_BOOST = 701
PropertyFunction[PropertyFunction.CRIT_SUIT_EFFECT_BOOST] = "CRIT_SUIT_EFFECT_BOOST"
PropertyFunction.WIND_SUIT_EFFECT_BOOST = 702
PropertyFunction[PropertyFunction.WIND_SUIT_EFFECT_BOOST] = "WIND_SUIT_EFFECT_BOOST"
PropertyFunction.REVIVE_MAX = 703
PropertyFunction[PropertyFunction.REVIVE_MAX] = "REVIVE_MAX"
PropertyFunction.IN_GAME_BLESS_REFRESH_MAX = 704
PropertyFunction[PropertyFunction.IN_GAME_BLESS_REFRESH_MAX] = "IN_GAME_BLESS_REFRESH_MAX"
PropertyFunction.IN_GAME_ABILITY_UPGRADE_MAX = 705
PropertyFunction[PropertyFunction.IN_GAME_ABILITY_UPGRADE_MAX] = "IN_GAME_ABILITY_UPGRADE_MAX"
PropertyFunction.GEM_DROP_PCT = 706
PropertyFunction[PropertyFunction.GEM_DROP_PCT] = "GEM_DROP_PCT"
PropertyFunction.GEM_DROP_NUM_PCT = 707
PropertyFunction[PropertyFunction.GEM_DROP_NUM_PCT] = "GEM_DROP_NUM_PCT"
PropertyFunction.GEM_EXTRA_DROP_BASE = 708
PropertyFunction[PropertyFunction.GEM_EXTRA_DROP_BASE] = "GEM_EXTRA_DROP_BASE"
PropertyFunction.TOTAL_DROP_NUM_PCT = 709
PropertyFunction[PropertyFunction.TOTAL_DROP_NUM_PCT] = "TOTAL_DROP_NUM_PCT"
PropertyFunction.REFINE_INC_PCT = 710
PropertyFunction[PropertyFunction.REFINE_INC_PCT] = "REFINE_INC_PCT"
PropertyFunction.ABYSSAL_FREE = 711
PropertyFunction[PropertyFunction.ABYSSAL_FREE] = "ABYSSAL_FREE"
PropertyFunction.DRAWING_DROP_CHANCE = 712
PropertyFunction[PropertyFunction.DRAWING_DROP_CHANCE] = "DRAWING_DROP_CHANCE"
PropertyFunction.GEM_ROLL_CHANCE = 713
PropertyFunction[PropertyFunction.GEM_ROLL_CHANCE] = "GEM_ROLL_CHANCE"
PropertyFunction.EXPLORE_EXTRA_CHANCE = 714
PropertyFunction[PropertyFunction.EXPLORE_EXTRA_CHANCE] = "EXPLORE_EXTRA_CHANCE"
PropertyFunction.EXPLORE_EXTRA_PROFIT_PCT = 715
PropertyFunction[PropertyFunction.EXPLORE_EXTRA_PROFIT_PCT] = "EXPLORE_EXTRA_PROFIT_PCT"
PropertyFunction.RUNE_RARITY_CHANCE = 716
PropertyFunction[PropertyFunction.RUNE_RARITY_CHANCE] = "RUNE_RARITY_CHANCE"
PropertyFunction.RUNE_DEVOUR_LOCK = 717
PropertyFunction[PropertyFunction.RUNE_DEVOUR_LOCK] = "RUNE_DEVOUR_LOCK"
PropertyFunction.EXPLORE_LIMIT = 718
PropertyFunction[PropertyFunction.EXPLORE_LIMIT] = "EXPLORE_LIMIT"
PropertyFunction.ATTACK_DAMAGE_BOOST_PER_LEVEL = 719
PropertyFunction[PropertyFunction.ATTACK_DAMAGE_BOOST_PER_LEVEL] = "ATTACK_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.SPELL_DAMAGE_BOOST_PER_LEVEL = 720
PropertyFunction[PropertyFunction.SPELL_DAMAGE_BOOST_PER_LEVEL] = "SPELL_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.SKILL_DAMAGE_BOOST_PER_LEVEL = 721
PropertyFunction[PropertyFunction.SKILL_DAMAGE_BOOST_PER_LEVEL] = "SKILL_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.DODGE_DAMAGE_BOOST_PER_LEVEL = 722
PropertyFunction[PropertyFunction.DODGE_DAMAGE_BOOST_PER_LEVEL] = "DODGE_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.DEFENSE_DAMAGE_BOOST_PER_LEVEL = 723
PropertyFunction[PropertyFunction.DEFENSE_DAMAGE_BOOST_PER_LEVEL] = "DEFENSE_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.ULTIMATE_DAMAGE_BOOST_PER_LEVEL = 724
PropertyFunction[PropertyFunction.ULTIMATE_DAMAGE_BOOST_PER_LEVEL] = "ULTIMATE_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.LIGHTNING_DAMAGE_BOOST_PER_LEVEL = 725
PropertyFunction[PropertyFunction.LIGHTNING_DAMAGE_BOOST_PER_LEVEL] = "LIGHTNING_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.FREEZE_DAMAGE_BOOST_PER_LEVEL = 726
PropertyFunction[PropertyFunction.FREEZE_DAMAGE_BOOST_PER_LEVEL] = "FREEZE_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.POISON_DAMAGE_BOOST_PER_LEVEL = 727
PropertyFunction[PropertyFunction.POISON_DAMAGE_BOOST_PER_LEVEL] = "POISON_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.BLEED_DAMAGE_BOOST_PER_LEVEL = 728
PropertyFunction[PropertyFunction.BLEED_DAMAGE_BOOST_PER_LEVEL] = "BLEED_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.BLADE_DAMAGE_BOOST_PER_LEVEL = 729
PropertyFunction[PropertyFunction.BLADE_DAMAGE_BOOST_PER_LEVEL] = "BLADE_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.HOLY_SHIELD_DAMAGE_BOOST_PER_LEVEL = 730
PropertyFunction[PropertyFunction.HOLY_SHIELD_DAMAGE_BOOST_PER_LEVEL] = "HOLY_SHIELD_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.RING_DAMAGE_BOOST_PER_LEVEL = 731
PropertyFunction[PropertyFunction.RING_DAMAGE_BOOST_PER_LEVEL] = "RING_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.SPLASH_DAMAGE_BOOST_PER_LEVEL = 732
PropertyFunction[PropertyFunction.SPLASH_DAMAGE_BOOST_PER_LEVEL] = "SPLASH_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.MELEE_DAMAGE_BOOST_PER_LEVEL = 733
PropertyFunction[PropertyFunction.MELEE_DAMAGE_BOOST_PER_LEVEL] = "MELEE_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.RANGED_DAMAGE_BOOST_PER_LEVEL = 734
PropertyFunction[PropertyFunction.RANGED_DAMAGE_BOOST_PER_LEVEL] = "RANGED_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.ELITE_DAMAGE_BOOST_PER_LEVEL = 735
PropertyFunction[PropertyFunction.ELITE_DAMAGE_BOOST_PER_LEVEL] = "ELITE_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.BOSS_DAMAGE_BOOST_PER_LEVEL = 736
PropertyFunction[PropertyFunction.BOSS_DAMAGE_BOOST_PER_LEVEL] = "BOSS_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.BARRIER_DAMAGE_BOOST_PER_LEVEL = 737
PropertyFunction[PropertyFunction.BARRIER_DAMAGE_BOOST_PER_LEVEL] = "BARRIER_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.BACKSTAB_DAMAGE_BOOST_PER_LEVEL = 738
PropertyFunction[PropertyFunction.BACKSTAB_DAMAGE_BOOST_PER_LEVEL] = "BACKSTAB_DAMAGE_BOOST_PER_LEVEL"
PropertyFunction.IDLE_FISH_MYTH_FISH_CHANCE = 739
PropertyFunction[PropertyFunction.IDLE_FISH_MYTH_FISH_CHANCE] = "IDLE_FISH_MYTH_FISH_CHANCE"
PropertyFunction.ENGRAVING_1_TRANSFER = 740
PropertyFunction[PropertyFunction.ENGRAVING_1_TRANSFER] = "ENGRAVING_1_TRANSFER"
PropertyFunction.ENGRAVING_2_TRANSFER = 741
PropertyFunction[PropertyFunction.ENGRAVING_2_TRANSFER] = "ENGRAVING_2_TRANSFER"
PropertyFunction.ENGRAVING_3_TRANSFER = 742
PropertyFunction[PropertyFunction.ENGRAVING_3_TRANSFER] = "ENGRAVING_3_TRANSFER"
PropertyFunction.ENGRAVING_4_TRANSFER = 743
PropertyFunction[PropertyFunction.ENGRAVING_4_TRANSFER] = "ENGRAVING_4_TRANSFER"
PropertyFunction.ENGRAVING_5_TRANSFER = 744
PropertyFunction[PropertyFunction.ENGRAVING_5_TRANSFER] = "ENGRAVING_5_TRANSFER"
PropertyFunction.ENGRAVING_1_STRENGTHEN = 745
PropertyFunction[PropertyFunction.ENGRAVING_1_STRENGTHEN] = "ENGRAVING_1_STRENGTHEN"
PropertyFunction.ENGRAVING_2_STRENGTHEN = 746
PropertyFunction[PropertyFunction.ENGRAVING_2_STRENGTHEN] = "ENGRAVING_2_STRENGTHEN"
PropertyFunction.ENGRAVING_3_STRENGTHEN = 747
PropertyFunction[PropertyFunction.ENGRAVING_3_STRENGTHEN] = "ENGRAVING_3_STRENGTHEN"
PropertyFunction.ENGRAVING_4_STRENGTHEN = 748
PropertyFunction[PropertyFunction.ENGRAVING_4_STRENGTHEN] = "ENGRAVING_4_STRENGTHEN"
PropertyFunction.ENGRAVING_5_STRENGTHEN = 749
PropertyFunction[PropertyFunction.ENGRAVING_5_STRENGTHEN] = "ENGRAVING_5_STRENGTHEN"
PropertyFunction.LAST = 750
PropertyFunction[PropertyFunction.LAST] = "LAST"
PROPERTY_MAP = {
	health = PropertyFunction.HEALTH,
	base_health = PropertyFunction.BASE_HEALTH,
	health_amplify = PropertyFunction.HEALTH_AMPLIFY,
	heal_room_start = PropertyFunction.HEAL_ROOM_START,
	health_cost_room_start = PropertyFunction.HEALTH_COST_ROOM_START,
	base_mana = PropertyFunction.BASE_MANA,
	mana = PropertyFunction.MANA,
	mana_amplify = PropertyFunction.MANA_AMPLIFY,
	base_attack = PropertyFunction.BASE_ATTACK,
	attack = PropertyFunction.ATTACK,
	attack_amplify = PropertyFunction.ATTACK_AMPLIFY,
	attackspeed = PropertyFunction.ATTACKSPEED,
	attackspeed_reduction = PropertyFunction.ATTACKSPEED_REDUCTION,
	wisp_attackspeed = PropertyFunction.WISP_ATTACKSPEED,
	wisp_damage = PropertyFunction.WISP_DAMAGE,
	cooldown_reduction = PropertyFunction.COOLDOWN_REDUCTION,
	boss_gap_amplify = PropertyFunction.BOSS_GAP_AMPLIFY,
	attack_range = PropertyFunction.ATTACK_RANGE,
	attack_range_melee = PropertyFunction.ATTACK_RANGE_MELEE,
	attack_range_ranger = PropertyFunction.ATTACK_RANGE_RANGER,
	bullet_range = PropertyFunction.BULLET_RANGE,
	aoe_amplify = PropertyFunction.AOE_AMPLIFY,
	crit_chance = PropertyFunction.CRIT_CHANCE,
	attack_crit_chance = PropertyFunction.ATTACK_CRIT_CHANCE,
	spell_crit_chance = PropertyFunction.SPELL_CRIT_CHANCE,
	expose_attack_crit_chance = PropertyFunction.EXPOSE_ATTACK_CRIT_CHANCE,
	crit_damage = PropertyFunction.CRIT_DAMAGE,
	crit_damage_mult = PropertyFunction.CRIT_DAMAGE_MULT,
	barrier_crit_damage = PropertyFunction.BARRIER_CRIT_DAMAGE,
	bleed_crit_damage = PropertyFunction.BLEED_CRIT_DAMAGE,
	attack_crit_damage = PropertyFunction.ATTACK_CRIT_DAMAGE,
	attack_crit_damage_boost = PropertyFunction.ATTACK_CRIT_DAMAGE_BOOST,
	spell_crit_damage = PropertyFunction.SPELL_CRIT_DAMAGE,
	spell_crit_damage_boost = PropertyFunction.SPELL_CRIT_DAMAGE_BOOST,
	attack_damage_proc = PropertyFunction.ATTACK_DAMAGE_PROC,
	spell_damage_proc = PropertyFunction.SPELL_DAMAGE_PROC,
	spell_damage_proc_target = PropertyFunction.SPELL_DAMAGE_PROC_TARGET,
	damage_proc_target = PropertyFunction.DAMAGE_PROC_TARGET,
	damage_amplify = PropertyFunction.DAMAGE_AMPLIFY,
	final_damage = PropertyFunction.FINAL_DAMAGE,
	final_defense = PropertyFunction.FINAL_DEFENSE,
	final_damage_101 = PropertyFunction.FINAL_DAMAGE_101,
	final_damage_102 = PropertyFunction.FINAL_DAMAGE_102,
	final_damage_103 = PropertyFunction.FINAL_DAMAGE_103,
	physical_damage_amplify = PropertyFunction.PHYSICAL_DAMAGE_AMPLIFY,
	magical_damage_amplify = PropertyFunction.MAGICAL_DAMAGE_AMPLIFY,
	attack_damage_amplify = PropertyFunction.ATTACK_DAMAGE_AMPLIFY,
	spell_damage_amplify = PropertyFunction.SPELL_DAMAGE_AMPLIFY,
	backstab_damage_amplify = PropertyFunction.BACKSTAB_DAMAGE_AMPLIFY,
	backstab_damage_boost = PropertyFunction.BACKSTAB_DAMAGE_BOOST,
	barrier_damage_amplify = PropertyFunction.BARRIER_DAMAGE_AMPLIFY,
	barrier_damage_boost = PropertyFunction.BARRIER_DAMAGE_BOOST,
	retaliated_damage_amplify = PropertyFunction.RETALIATED_DAMAGE_AMPLIFY,
	ring_damage_amplify = PropertyFunction.RING_DAMAGE_AMPLIFY,
	ring_damage_boost = PropertyFunction.RING_DAMAGE_BOOST,
	blade_damage_amplify = PropertyFunction.BLADE_DAMAGE_AMPLIFY,
	blade_speed_amplify = PropertyFunction.BLADE_SPEED_AMPLIFY,
	damage_reduction = PropertyFunction.DAMAGE_REDUCTION,
	poison_pool_shield_attenuation_interval_amplify = PropertyFunction.POISON_POOL_SHIELD_ATTENUATION_INTERVAL_AMPLIFY,
	incoming_damage_amplify = PropertyFunction.INCOMING_DAMAGE_AMPLIFY,
	trap_incoming_damage_amplify = PropertyFunction.TRAP_INCOMING_DAMAGE_AMPLIFY,
	trap_damage_amplify = PropertyFunction.TRAP_DAMAGE_AMPLIFY,
	poison_attenuation_interval_amplify = PropertyFunction.POISON_ATTENUATION_INTERVAL_AMPLIFY,
	poison_pool_incoming_damage_amplify = PropertyFunction.POISON_POOL_INCOMING_DAMAGE_AMPLIFY,
	tavern_effect_amplify = PropertyFunction.TAVERN_EFFECT_AMPLIFY,
	evasion = PropertyFunction.EVASION,
	avoid_damage = PropertyFunction.AVOID_DAMAGE,
	min_health = PropertyFunction.MIN_HEALTH,
	heal_amplify = PropertyFunction.HEAL_AMPLIFY,
	fury_amplify = PropertyFunction.FURY_AMPLIFY,
	fury_regen = PropertyFunction.FURY_REGEN,
	crit_fury_amplify = PropertyFunction.CRIT_FURY_AMPLIFY,
	skill_fury_amplify = PropertyFunction.SKILL_FURY_AMPLIFY,
	ring_fury_amplify = PropertyFunction.RING_FURY_AMPLIFY,
	movespeed = PropertyFunction.MOVESPEED,
	movespeed_not_calculated = PropertyFunction.MOVESPEED_NOT_CALCULATED,
	movespeed_amplify = PropertyFunction.MOVESPEED_AMPLIFY,
	shop_discount = PropertyFunction.SHOP_DISCOUNT,
	shop_refresh_refund = PropertyFunction.SHOP_REFRESH_REFUND,
	split_count = PropertyFunction.SPLIT_COUNT,
	ability_charge_attack = PropertyFunction.ABILITY_CHARGE_ATTACK,
	ability_charge_skill = PropertyFunction.ABILITY_CHARGE_SKILL,
	ability_charge_dodge = PropertyFunction.ABILITY_CHARGE_DODGE,
	ability_charge_defense = PropertyFunction.ABILITY_CHARGE_DEFENSE,
	ability_charge_ultimate = PropertyFunction.ABILITY_CHARGE_ULTIMATE,
	ring_count = PropertyFunction.RING_COUNT,
	ring_speed_amplify = PropertyFunction.RING_SPEED_AMPLIFY,
	ring_track_radius = PropertyFunction.RING_TRACK_RADIUS,
	lightning_multiple_chance = PropertyFunction.LIGHTNING_MULTIPLE_CHANCE,
	lightning_radius = PropertyFunction.LIGHTNING_RADIUS,
	lightning_damage = PropertyFunction.LIGHTNING_DAMAGE,
	lightning_expose_chance = PropertyFunction.LIGHTNING_EXPOSE_CHANCE,
	expose_keep_chance = PropertyFunction.EXPOSE_KEEP_CHANCE,
	lightning_count = PropertyFunction.LIGHTNING_COUNT,
	poison_no_attenuation_chance = PropertyFunction.POISON_NO_ATTENUATION_CHANCE,
	poison_attenuation_reduction = PropertyFunction.POISON_ATTENUATION_REDUCTION,
	frozen_no_attenuation_chance = PropertyFunction.FROZEN_NO_ATTENUATION_CHANCE,
	frozen_attenuation_reduction = PropertyFunction.FROZEN_ATTENUATION_REDUCTION,
	frozen_damage_amplify = PropertyFunction.FROZEN_DAMAGE_AMPLIFY,
	shield_attenuation_reduction = PropertyFunction.SHIELD_ATTENUATION_REDUCTION,
	shield_attenuation_interval_amplify = PropertyFunction.SHIELD_ATTENUATION_INTERVAL_AMPLIFY,
	shield_no_attenuation_chance = PropertyFunction.SHIELD_NO_ATTENUATION_CHANCE,
	frozen_burst_stack = PropertyFunction.FROZEN_BURST_STACK,
	bounce_count = PropertyFunction.BOUNCE_COUNT,
	laser_bounce_count = PropertyFunction.LASER_BOUNCE_COUNT,
	laser_damage_amplify = PropertyFunction.LASER_DAMAGE_AMPLIFY,
	snowball_bounce_count = PropertyFunction.SNOWBALL_BOUNCE_COUNT,
	snowball_extra_shot = PropertyFunction.SNOWBALL_EXTRA_SHOT,
	snowball_damage = PropertyFunction.SNOWBALL_DAMAGE,
	ice_strike = PropertyFunction.ICE_STRIKE,
	reflect_damage = PropertyFunction.REFLECT_DAMAGE,
	per_encounter_attack_bonus = PropertyFunction.PER_ENCOUNTER_ATTACK_BONUS,
	per_encounter_attack_amplify = PropertyFunction.PER_ENCOUNTER_ATTACK_AMPLIFY,
	per_encounter_attack_damage_amplify = PropertyFunction.PER_ENCOUNTER_ATTACK_DAMAGE_AMPLIFY,
	per_encounter_skill_damage_amplify = PropertyFunction.PER_ENCOUNTER_SKILL_DAMAGE_AMPLIFY,
	per_encounter_ultimate_damage_amplify = PropertyFunction.PER_ENCOUNTER_ULTIMATE_DAMAGE_AMPLIFY,
	per_encounter_physical_damage_amplify = PropertyFunction.PER_ENCOUNTER_PHYSICAL_DAMAGE_AMPLIFY,
	per_encounter_magical_damage_amplify = PropertyFunction.PER_ENCOUNTER_MAGICAL_DAMAGE_AMPLIFY,
	per_encounter_melee_hero_damage_amplify = PropertyFunction.PER_ENCOUNTER_MELEE_HERO_DAMAGE_AMPLIFY,
	per_encounter_ranger_hero_damage_amplify = PropertyFunction.PER_ENCOUNTER_RANGER_HERO_DAMAGE_AMPLIFY,
	per_encounter_crit_damage = PropertyFunction.PER_ENCOUNTER_CRIT_DAMAGE,
	block = PropertyFunction.BLOCK,
	poison_stacks_amplify = PropertyFunction.POISON_STACKS_AMPLIFY,
	shock_damage_amplify = PropertyFunction.SHOCK_DAMAGE_AMPLIFY,
	bleed_stacks_amplify = PropertyFunction.BLEED_STACKS_AMPLIFY,
	freeze_stacks_amplify = PropertyFunction.FREEZE_STACKS_AMPLIFY,
	shield_amplify = PropertyFunction.SHIELD_AMPLIFY,
	crit_damage_amplify = PropertyFunction.CRIT_DAMAGE_AMPLIFY,
	melee_hero_damage_amplify = PropertyFunction.MELEE_HERO_DAMAGE_AMPLIFY,
	ranger_hero_damage_amplify = PropertyFunction.RANGER_HERO_DAMAGE_AMPLIFY,
	health_potion_heal_amplify = PropertyFunction.HEALTH_POTION_HEAL_AMPLIFY,
	crit_chance_amplify = PropertyFunction.CRIT_CHANCE_AMPLIFY,
	splash_damage_amplify = PropertyFunction.SPLASH_DAMAGE_AMPLIFY,
	splash_damage_boost = PropertyFunction.SPLASH_DAMAGE_BOOST,
	debuff_target_damage_amplify = PropertyFunction.DEBUFF_TARGET_DAMAGE_AMPLIFY,
	minion_damage_boost = PropertyFunction.MINION_DAMAGE_BOOST,
	boss_damage_boost = PropertyFunction.BOSS_DAMAGE_BOOST,
	elite_damage_boost = PropertyFunction.ELITE_DAMAGE_BOOST,
	all_stats_amplify = PropertyFunction.ALL_STATS_AMPLIFY,
	ultimate_mana_cost_reduce = PropertyFunction.ULTIMATE_MANA_COST_REDUCE,
	buff_duration = PropertyFunction.BUFF_DURATION,
	debuff_duration = PropertyFunction.DEBUFF_DURATION,
	ability_charge_defense_time = PropertyFunction.ABILITY_CHARGE_DEFENSE_TIME,
	potion_heal_restore = PropertyFunction.POTION_HEAL_RESTORE,
	break_drop_chance = PropertyFunction.BREAK_DROP_CHANCE,
	break_drop_profit_pct = PropertyFunction.BREAK_DROP_PROFIT_PCT,
	revive_count = PropertyFunction.REVIVE_COUNT,
	revive_health_recover = PropertyFunction.REVIVE_HEALTH_RECOVER,
	initial_gold = PropertyFunction.INITIAL_GOLD,
	exp_gain_chance = PropertyFunction.EXP_GAIN_CHANCE,
	gold_room_amount = PropertyFunction.GOLD_ROOM_AMOUNT,
	shop_item_rarity = PropertyFunction.SHOP_ITEM_RARITY,
	artifact_item_rarity = PropertyFunction.ARTIFACT_ITEM_RARITY,
	blessing_rarity = PropertyFunction.BLESSING_RARITY,
	zeus_bless_rarity_up = PropertyFunction.ZEUS_BLESS_RARITY_UP,
	poison_bless_rarity_up = PropertyFunction.POISON_BLESS_RARITY_UP,
	ice_bless_rarity_up = PropertyFunction.ICE_BLESS_RARITY_UP,
	bleed_bless_rarity_up = PropertyFunction.BLEED_BLESS_RARITY_UP,
	crit_bless_rarity_up = PropertyFunction.CRIT_BLESS_RARITY_UP,
	holy_bless_rarity_up = PropertyFunction.HOLY_BLESS_RARITY_UP,
	wind_bless_rarity_up = PropertyFunction.WIND_BLESS_RARITY_UP,
	bless_refresh_count = PropertyFunction.BLESS_REFRESH_COUNT,
	artifact_allin_count = PropertyFunction.ARTIFACT_ALLIN_COUNT,
	bless_allin_count = PropertyFunction.BLESS_ALLIN_COUNT,
	bless_upgrade_allin_count = PropertyFunction.BLESS_UPGRADE_ALLIN_COUNT,
	ability_upgrade_allin_count = PropertyFunction.ABILITY_UPGRADE_ALLIN_COUNT,
	ability_upgrade_refresh_count = PropertyFunction.ABILITY_UPGRADE_REFRESH_COUNT,
	equip_extra_potential = PropertyFunction.EQUIP_EXTRA_POTENTIAL,
	equip_extra_drop_base = PropertyFunction.EQUIP_EXTRA_DROP_BASE,
	equip_drop_pct = PropertyFunction.EQUIP_DROP_PCT,
	equip_drop_num_pct = PropertyFunction.EQUIP_DROP_NUM_PCT,
	equip_rarity_chance = PropertyFunction.EQUIP_RARITY_CHANCE,
	equip_potential_lucky = PropertyFunction.EQUIP_POTENTIAL_LUCKY,
	melee_damage_boost = PropertyFunction.MELEE_DAMAGE_BOOST,
	ranged_damage_boost = PropertyFunction.RANGED_DAMAGE_BOOST,
	execute_damage = PropertyFunction.EXECUTE_DAMAGE,
	rage_capacity_amplify = PropertyFunction.RAGE_CAPACITY_AMPLIFY,
	heavy_attack = PropertyFunction.HEAVY_ATTACK,
	hp_regeneration = PropertyFunction.HP_REGENERATION,
	thorns_damage = PropertyFunction.THORNS_DAMAGE,
	damage_vs_bleeding_targets = PropertyFunction.DAMAGE_VS_BLEEDING_TARGETS,
	damage_vs_frozen_targets = PropertyFunction.DAMAGE_VS_FROZEN_TARGETS,
	damage_vs_shocked_targets = PropertyFunction.DAMAGE_VS_SHOCKED_TARGETS,
	damage_vs_poisoned_targets = PropertyFunction.DAMAGE_VS_POISONED_TARGETS,
	finisher_damage = PropertyFunction.FINISHER_DAMAGE,
	finisher_crit_chance = PropertyFunction.FINISHER_CRIT_CHANCE,
	skill_cooldown_reduction = PropertyFunction.SKILL_COOLDOWN_REDUCTION,
	evade_cooldown_reduction = PropertyFunction.EVADE_COOLDOWN_REDUCTION,
	block_cooldown_reduction = PropertyFunction.BLOCK_COOLDOWN_REDUCTION,
	ultimate_cooldown_reduction = PropertyFunction.ULTIMATE_COOLDOWN_REDUCTION,
	gold_gain_amount = PropertyFunction.GOLD_GAIN_AMOUNT,
	exp_gain_amount = PropertyFunction.EXP_GAIN_AMOUNT,
	gold_reward_per_encounter = PropertyFunction.GOLD_REWARD_PER_ENCOUNTER,
	exp_reward_per_encounter = PropertyFunction.EXP_REWARD_PER_ENCOUNTER,
	poison_decay_reduction = PropertyFunction.POISON_DECAY_REDUCTION,
	bleed_trigger_interval = PropertyFunction.BLEED_TRIGGER_INTERVAL,
	freeze_duration = PropertyFunction.FREEZE_DURATION,
	shock_no_decay_rate = PropertyFunction.SHOCK_NO_DECAY_RATE,
	rage_gain_percent_per_attack = PropertyFunction.RAGE_GAIN_PERCENT_PER_ATTACK,
	rage_gain_percent_per_block = PropertyFunction.RAGE_GAIN_PERCENT_PER_BLOCK,
	rage_gain_percent_per_evade = PropertyFunction.RAGE_GAIN_PERCENT_PER_EVADE,
	rage_gain_percent_per_ultimate = PropertyFunction.RAGE_GAIN_PERCENT_PER_ULTIMATE,
	poison_damage_amplify = PropertyFunction.POISON_DAMAGE_AMPLIFY,
	poison_damage_boost = PropertyFunction.POISON_DAMAGE_BOOST,
	lightning_damage_amplify = PropertyFunction.LIGHTNING_DAMAGE_AMPLIFY,
	lightning_damage_boost = PropertyFunction.LIGHTNING_DAMAGE_BOOST,
	holy_shield_damage_boost = PropertyFunction.HOLY_SHIELD_DAMAGE_BOOST,
	bleed_damage_amplify = PropertyFunction.BLEED_DAMAGE_AMPLIFY,
	bleed_damage_boost = PropertyFunction.BLEED_DAMAGE_BOOST,
	blade_damage_boost = PropertyFunction.BLADE_DAMAGE_BOOST,
	freeze_damage_amplify = PropertyFunction.FREEZE_DAMAGE_AMPLIFY,
	freeze_damage_boost = PropertyFunction.FREEZE_DAMAGE_BOOST,
	shield_damage_amplify = PropertyFunction.SHIELD_DAMAGE_AMPLIFY,
	execute_damage_amplify = PropertyFunction.EXECUTE_DAMAGE_AMPLIFY,
	conditional_damage_amplify = PropertyFunction.CONDITIONAL_DAMAGE_AMPLIFY,
	attack_damage_boost = PropertyFunction.ATTACK_DAMAGE_BOOST,
	spell_damage_boost = PropertyFunction.SPELL_DAMAGE_BOOST,
	skill_damage_amplify = PropertyFunction.SKILL_DAMAGE_AMPLIFY,
	skill_damage_boost = PropertyFunction.SKILL_DAMAGE_BOOST,
	ultimate_damage_amplify = PropertyFunction.ULTIMATE_DAMAGE_AMPLIFY,
	ultimate_damage_boost = PropertyFunction.ULTIMATE_DAMAGE_BOOST,
	dodge_damage_amplify = PropertyFunction.DODGE_DAMAGE_AMPLIFY,
	dodge_damage_boost = PropertyFunction.DODGE_DAMAGE_BOOST,
	defense_damage_amplify = PropertyFunction.DEFENSE_DAMAGE_AMPLIFY,
	defense_damage_boost = PropertyFunction.DEFENSE_DAMAGE_BOOST,
	melee_hero_damage_boost = PropertyFunction.MELEE_HERO_DAMAGE_BOOST,
	ranger_hero_damage_boost = PropertyFunction.RANGER_HERO_DAMAGE_BOOST,
	damage_boost = PropertyFunction.DAMAGE_BOOST,
	magical_damage_boost = PropertyFunction.MAGICAL_DAMAGE_BOOST,
	physical_damage_boost = PropertyFunction.PHYSICAL_DAMAGE_BOOST,
	damage_boost_per_level = PropertyFunction.DAMAGE_BOOST_PER_LEVEL,
	physical_damage_boost_per_level = PropertyFunction.PHYSICAL_DAMAGE_BOOST_PER_LEVEL,
	magical_damage_boost_per_level = PropertyFunction.MAGICAL_DAMAGE_BOOST_PER_LEVEL,
	rage_gain_percent_per_skill = PropertyFunction.RAGE_GAIN_PERCENT_PER_SKILL,
	bonus_frost_damage = PropertyFunction.BONUS_FROST_DAMAGE,
	bonus_poison_damage = PropertyFunction.BONUS_POISON_DAMAGE,
	bonus_lightning_damage = PropertyFunction.BONUS_LIGHTNING_DAMAGE,
	bonus_bleed_damage = PropertyFunction.BONUS_BLEED_DAMAGE,
	hp_regen_per_encounter = PropertyFunction.HP_REGEN_PER_ENCOUNTER,
	mana_regen_per_encounter = PropertyFunction.MANA_REGEN_PER_ENCOUNTER,
	elemental_damage = PropertyFunction.ELEMENTAL_DAMAGE,
	physical_armor = PropertyFunction.PHYSICAL_ARMOR,
	hp_regen_on_kill = PropertyFunction.HP_REGEN_ON_KILL,
	attack_speed_boost = PropertyFunction.ATTACK_SPEED_BOOST,
	damage_intensity = PropertyFunction.DAMAGE_INTENSITY,
	damage_intensity_boost = PropertyFunction.DAMAGE_INTENSITY_BOOST,
	defense_intensity = PropertyFunction.DEFENSE_INTENSITY,
	defense_intensity_boost = PropertyFunction.DEFENSE_INTENSITY_BOOST,
	hero_damage_boost = PropertyFunction.HERO_DAMAGE_BOOST,
	hero_defense_boost = PropertyFunction.HERO_DEFENSE_BOOST,
	damage_boost_mult = PropertyFunction.DAMAGE_BOOST_MULT,
	lightning_cloud_damage = PropertyFunction.LIGHTNING_CLOUD_DAMAGE,
	lightning_cloud_duration = PropertyFunction.LIGHTNING_CLOUD_DURATION,
	lightning_cloud_hit_count = PropertyFunction.LIGHTNING_CLOUD_HIT_COUNT,
	idle_power_recover = PropertyFunction.IDLE_POWER_RECOVER,
	idle_max_power = PropertyFunction.IDLE_MAX_POWER,
	idle_max_power_pct = PropertyFunction.IDLE_MAX_POWER_PCT,
	idle_power_cost_inc_pct = PropertyFunction.IDLE_POWER_COST_INC_PCT,
	idle_power_cost_reduce_pct = PropertyFunction.IDLE_POWER_COST_REDUCE_PCT,
	idle_fish_total_profit = PropertyFunction.IDLE_FISH_TOTAL_PROFIT,
	idle_fish_total_profit_pct = PropertyFunction.IDLE_FISH_TOTAL_PROFIT_PCT,
	idle_fish_normalbox_chance = PropertyFunction.IDLE_FISH_NORMALBOX_CHANCE,
	idle_fish_goldbox_chance = PropertyFunction.IDLE_FISH_GOLDBOX_CHANCE,
	idle_fish_box_profit_pct = PropertyFunction.IDLE_FISH_BOX_PROFIT_PCT,
	ability_upgrade_count = PropertyFunction.ABILITY_UPGRADE_COUNT,
	idle_fish_rainbow_chance = PropertyFunction.IDLE_FISH_RAINBOW_CHANCE,
	idle_fish_rainbow1_chance = PropertyFunction.IDLE_FISH_RAINBOW1_CHANCE,
	idle_fish_rainbow2_chance = PropertyFunction.IDLE_FISH_RAINBOW2_CHANCE,
	idle_fish_rainbow3_chance = PropertyFunction.IDLE_FISH_RAINBOW3_CHANCE,
	idle_fish_rainbow4_chance = PropertyFunction.IDLE_FISH_RAINBOW4_CHANCE,
	idle_fish_rainbow5_chance = PropertyFunction.IDLE_FISH_RAINBOW5_CHANCE,
	idle_fish_chance = PropertyFunction.IDLE_FISH_CHANCE,
	idle_fish_num = PropertyFunction.IDLE_FISH_NUM,
	idle_fish_num_pct = PropertyFunction.IDLE_FISH_NUM_PCT,
	idle_fish_crit_chance = PropertyFunction.IDLE_FISH_CRIT_CHANCE,
	idle_fish_crit_num = PropertyFunction.IDLE_FISH_CRIT_NUM,
	idle_fish_lucky_num = PropertyFunction.IDLE_FISH_LUCKY_NUM,
	idle_fish_efficiency = PropertyFunction.IDLE_FISH_EFFICIENCY,
	idle_fish_interaction_pct = PropertyFunction.IDLE_FISH_INTERACTION_PCT,
	idle_fish_escape_speed_pct = PropertyFunction.IDLE_FISH_ESCAPE_SPEED_PCT,
	idle_fish_wait_time_reduce_pct = PropertyFunction.IDLE_FISH_WAIT_TIME_REDUCE_PCT,
	idle_fish_courier_slot = PropertyFunction.IDLE_FISH_COURIER_SLOT,
	aquarium_slot = PropertyFunction.AQUARIUM_SLOT,
	holy_shield_damage_boost2 = PropertyFunction.HOLY_SHIELD_DAMAGE_BOOST2,
	blade_sword_boost2 = PropertyFunction.BLADE_SWORD_BOOST2,
	dash_distance = PropertyFunction.DASH_DISTANCE,
	move_distance_efficiency = PropertyFunction.MOVE_DISTANCE_EFFICIENCY,
	explore_profit_110005_pct = PropertyFunction.EXPLORE_PROFIT_110005_PCT,
	resource_profit_stone_pct = PropertyFunction.RESOURCE_PROFIT_STONE_PCT,
	resource_profit_forge_pct = PropertyFunction.RESOURCE_PROFIT_FORGE_PCT,
	resource_profit_talent_pct = PropertyFunction.RESOURCE_PROFIT_TALENT_PCT,
	resource_profit_210001_pct = PropertyFunction.RESOURCE_PROFIT_210001_PCT,
	lightning_damage_boost2 = PropertyFunction.LIGHTNING_DAMAGE_BOOST2,
	poison_damage_boost2 = PropertyFunction.POISON_DAMAGE_BOOST2,
	freeze_damage_boost2 = PropertyFunction.FREEZE_DAMAGE_BOOST2,
	bleed_damage_boost2 = PropertyFunction.BLEED_DAMAGE_BOOST2,
	holy_suit_effect_boost = PropertyFunction.HOLY_SUIT_EFFECT_BOOST,
	zeus_suit_effect_boost = PropertyFunction.ZEUS_SUIT_EFFECT_BOOST,
	ice_suit_effect_boost = PropertyFunction.ICE_SUIT_EFFECT_BOOST,
	poison_suit_effect_boost = PropertyFunction.POISON_SUIT_EFFECT_BOOST,
	bleed_suit_effect_boost = PropertyFunction.BLEED_SUIT_EFFECT_BOOST,
	crit_suit_effect_boost = PropertyFunction.CRIT_SUIT_EFFECT_BOOST,
	wind_suit_effect_boost = PropertyFunction.WIND_SUIT_EFFECT_BOOST,
	revive_max = PropertyFunction.REVIVE_MAX,
	in_game_bless_refresh_max = PropertyFunction.IN_GAME_BLESS_REFRESH_MAX,
	in_game_ability_upgrade_max = PropertyFunction.IN_GAME_ABILITY_UPGRADE_MAX,
	gem_drop_pct = PropertyFunction.GEM_DROP_PCT,
	gem_drop_num_pct = PropertyFunction.GEM_DROP_NUM_PCT,
	gem_extra_drop_base = PropertyFunction.GEM_EXTRA_DROP_BASE,
	total_drop_num_pct = PropertyFunction.TOTAL_DROP_NUM_PCT,
	refine_inc_pct = PropertyFunction.REFINE_INC_PCT,
	abyssal_free = PropertyFunction.ABYSSAL_FREE,
	drawing_drop_chance = PropertyFunction.DRAWING_DROP_CHANCE,
	gem_roll_change = PropertyFunction.GEM_ROLL_CHANCE,
	explore_extra_chance = PropertyFunction.EXPLORE_EXTRA_CHANCE,
	explore_extra_profit_pct = PropertyFunction.EXPLORE_EXTRA_PROFIT_PCT,
	rune_rarity_chance = PropertyFunction.RUNE_RARITY_CHANCE,
	rune_devour_lock = PropertyFunction.RUNE_DEVOUR_LOCK,
	explore_limit = PropertyFunction.EXPLORE_LIMIT,
	attack_damage_boost_per_level = PropertyFunction.ATTACK_DAMAGE_BOOST_PER_LEVEL,
	spell_damage_boost_per_level = PropertyFunction.SPELL_DAMAGE_BOOST_PER_LEVEL,
	skill_damage_boost_per_level = PropertyFunction.SKILL_DAMAGE_BOOST_PER_LEVEL,
	dodge_damage_boost_per_level = PropertyFunction.DODGE_DAMAGE_BOOST_PER_LEVEL,
	defense_damage_boost_per_level = PropertyFunction.DEFENSE_DAMAGE_BOOST_PER_LEVEL,
	ultimate_damage_boost_per_level = PropertyFunction.ULTIMATE_DAMAGE_BOOST_PER_LEVEL,
	lightning_damage_boost_per_level = PropertyFunction.LIGHTNING_DAMAGE_BOOST_PER_LEVEL,
	freeze_damage_boost_per_level = PropertyFunction.FREEZE_DAMAGE_BOOST_PER_LEVEL,
	poison_damage_boost_per_level = PropertyFunction.POISON_DAMAGE_BOOST_PER_LEVEL,
	bleed_damage_boost_per_level = PropertyFunction.BLEED_DAMAGE_BOOST_PER_LEVEL,
	blade_damage_boost_per_level = PropertyFunction.BLADE_DAMAGE_BOOST_PER_LEVEL,
	holy_shield_damage_boost_per_level = PropertyFunction.HOLY_SHIELD_DAMAGE_BOOST_PER_LEVEL,
	ring_damage_boost_per_level = PropertyFunction.RING_DAMAGE_BOOST_PER_LEVEL,
	splash_damage_boost_per_level = PropertyFunction.SPLASH_DAMAGE_BOOST_PER_LEVEL,
	melee_damage_boost_per_level = PropertyFunction.MELEE_DAMAGE_BOOST_PER_LEVEL,
	ranged_damage_boost_per_level = PropertyFunction.RANGED_DAMAGE_BOOST_PER_LEVEL,
	elite_damage_boost_per_level = PropertyFunction.ELITE_DAMAGE_BOOST_PER_LEVEL,
	boss_damage_boost_per_level = PropertyFunction.BOSS_DAMAGE_BOOST_PER_LEVEL,
	barrier_damage_boost_per_level = PropertyFunction.BARRIER_DAMAGE_BOOST_PER_LEVEL,
	backstab_damage_boost_per_level = PropertyFunction.BACKSTAB_DAMAGE_BOOST_PER_LEVEL,
	idle_fish_myth_fish_chance = PropertyFunction.IDLE_FISH_MYTH_FISH_CHANCE,
	engraving_1_transfer = PropertyFunction.ENGRAVING_1_TRANSFER,
	engraving_2_transfer = PropertyFunction.ENGRAVING_2_TRANSFER,
	engraving_3_transfer = PropertyFunction.ENGRAVING_3_TRANSFER,
	engraving_4_transfer = PropertyFunction.ENGRAVING_4_TRANSFER,
	engraving_5_transfer = PropertyFunction.ENGRAVING_5_TRANSFER,
	engraving_1_strengthen = PropertyFunction.ENGRAVING_1_STRENGTHEN,
	engraving_2_strengthen = PropertyFunction.ENGRAVING_2_STRENGTHEN,
	engraving_3_strengthen = PropertyFunction.ENGRAVING_3_STRENGTHEN,
	engraving_4_strengthen = PropertyFunction.ENGRAVING_4_STRENGTHEN,
	engraving_5_strengthen = PropertyFunction.ENGRAVING_5_STRENGTHEN,
}
PROPERTY_MAP_REVERSE = {}
for b, c in pairs(PROPERTY_MAP) do
	PROPERTY_MAP_REVERSE[c] = b
end
PropertySystem:RegisterProperty({
	id = "health",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "base_health",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "health_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "heal_room_start",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "health_cost_room_start",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "base_mana",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "mana",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "mana_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "base_attack",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "attack",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "attack_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "attackspeed",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "attackspeed_reduction",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "wisp_attackspeed",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "wisp_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "cooldown_reduction",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.DECMUL,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "boss_gap_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "attack_range",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "attack_range_melee",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "attack_range_ranger",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "bullet_range",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "aoe_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "crit_chance",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "attack_crit_chance",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "spell_crit_chance",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "expose_attack_crit_chance",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "crit_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "crit_damage_mult",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.MULTIPLY,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "barrier_crit_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "bleed_crit_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "attack_crit_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "attack_crit_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "spell_crit_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "spell_crit_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "attack_damage_proc",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "spell_damage_proc",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "spell_damage_proc_target",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "damage_proc_target",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "final_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "final_defense",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "final_damage_101",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "final_damage_102",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "final_damage_103",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "physical_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "magical_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "attack_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "spell_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "backstab_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "backstab_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "barrier_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "barrier_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "retaliated_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ring_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ring_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "blade_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "blade_speed_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "damage_reduction",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.DECMUL,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "poison_pool_shield_attenuation_interval_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "incoming_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "trap_incoming_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "trap_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "poison_attenuation_interval_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "poison_pool_incoming_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "tavern_effect_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "evasion",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.DECMUL,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "avoid_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.FIRST,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "min_health",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.MAX,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "heal_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "fury_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "fury_regen",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "crit_fury_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "skill_fury_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ring_fury_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "movespeed",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "movespeed_not_calculated",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "movespeed_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "shop_discount",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.MAX,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "shop_refresh_refund",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.MAX,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "split_count",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ability_charge_attack",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ability_charge_skill",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ability_charge_dodge",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ability_charge_defense",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ability_charge_ultimate",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ring_count",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ring_speed_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ring_track_radius",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "lightning_multiple_chance",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "lightning_radius",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "lightning_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "lightning_expose_chance",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "expose_keep_chance",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "lightning_count",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "poison_no_attenuation_chance",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "poison_attenuation_reduction",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "frozen_no_attenuation_chance",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "frozen_attenuation_reduction",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "frozen_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "shield_attenuation_reduction",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "shield_attenuation_interval_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "shield_no_attenuation_chance",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "frozen_burst_stack",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "bounce_count",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "laser_bounce_count",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "laser_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "snowball_bounce_count",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "snowball_extra_shot",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "snowball_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ice_strike",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "reflect_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "per_encounter_attack_bonus",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "dungeon_room_complete",
	event_link_id = "attack",
})
PropertySystem:RegisterProperty({
	id = "per_encounter_attack_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "dungeon_room_complete",
	event_link_id = "attack_amplify",
})
PropertySystem:RegisterProperty({
	id = "per_encounter_attack_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "dungeon_room_complete",
	event_link_id = "attack_damage_amplify",
})
PropertySystem:RegisterProperty({
	id = "per_encounter_skill_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "dungeon_room_complete",
	event_link_id = "skill_damage_amplify",
})
PropertySystem:RegisterProperty({
	id = "per_encounter_ultimate_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "dungeon_room_complete",
	event_link_id = "ultimate_damage_amplify",
})
PropertySystem:RegisterProperty({
	id = "per_encounter_physical_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "dungeon_room_complete",
	event_link_id = "physical_damage_amplify",
})
PropertySystem:RegisterProperty({
	id = "per_encounter_magical_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "dungeon_room_complete",
	event_link_id = "magical_damage_amplify",
})
PropertySystem:RegisterProperty({
	id = "per_encounter_melee_hero_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "dungeon_room_complete",
	event_link_id = "melee_hero_damage_amplify",
})
PropertySystem:RegisterProperty({
	id = "per_encounter_ranger_hero_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "dungeon_room_complete",
	event_link_id = "ranger_hero_damage_amplify",
})
PropertySystem:RegisterProperty({
	id = "per_encounter_crit_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "dungeon_room_complete",
	event_link_id = "crit_damage",
})
PropertySystem:RegisterProperty({
	id = "block",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "poison_stacks_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "shock_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "bleed_stacks_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "freeze_stacks_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "shield_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "crit_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "melee_hero_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ranger_hero_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "health_potion_heal_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "crit_chance_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "splash_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "splash_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "debuff_target_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "minion_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "boss_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "elite_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "all_stats_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ultimate_mana_cost_reduce",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "buff_duration",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "debuff_duration",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ability_charge_defense_time",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "potion_heal_restore",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "break_drop_chance",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "break_drop_profit_pct",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "revive_count",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "revive_health_recover",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	defaultValue = 30,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "initial_gold",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "exp_gain_chance",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "gold_room_amount",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "shop_item_rarity",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "artifact_item_rarity",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "blessing_rarity",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "zeus_bless_rarity_up",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "poison_bless_rarity_up",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ice_bless_rarity_up",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "bleed_bless_rarity_up",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "crit_bless_rarity_up",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "holy_bless_rarity_up",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "wind_bless_rarity_up",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "bless_refresh_count",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "artifact_allin_count",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "bless_allin_count",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "bless_upgrade_allin_count",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ability_upgrade_allin_count",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ability_upgrade_refresh_count",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "equip_extra_potential",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "equip_extra_drop_base",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "equip_drop_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "equip_drop_num_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "equip_rarity_chance",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "equip_potential_lucky",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "melee_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ranged_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "execute_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "rage_capacity_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "heavy_attack",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "hp_regeneration",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "thorns_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "damage_vs_bleeding_targets",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "damage_vs_frozen_targets",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "damage_vs_shocked_targets",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "damage_vs_poisoned_targets",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "finisher_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "finisher_crit_chance",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "skill_cooldown_reduction",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "evade_cooldown_reduction",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "block_cooldown_reduction",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ultimate_cooldown_reduction",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "gold_gain_amount",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "exp_gain_amount",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "gold_reward_per_encounter",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "exp_reward_per_encounter",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "poison_decay_reduction",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "bleed_trigger_interval",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "freeze_duration",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "shock_no_decay_rate",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "rage_gain_percent_per_attack",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "rage_gain_percent_per_block",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "rage_gain_percent_per_evade",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "rage_gain_percent_per_ultimate",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "poison_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "poison_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "lightning_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "lightning_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "holy_shield_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "bleed_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "bleed_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "blade_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "freeze_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "freeze_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "shield_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "execute_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "conditional_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "attack_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "spell_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "skill_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "skill_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ultimate_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ultimate_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "dodge_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "dodge_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "defense_damage_amplify",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "defense_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "melee_hero_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ranger_hero_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "magical_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "physical_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "damage_boost",
})
PropertySystem:RegisterProperty({
	id = "physical_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "physical_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "magical_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "magical_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "rage_gain_percent_per_skill",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "bonus_frost_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "bonus_poison_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "bonus_lightning_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "bonus_bleed_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "hp_regen_per_encounter",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "mana_regen_per_encounter",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "elemental_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "physical_armor",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "hp_regen_on_kill",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "attack_speed_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "damage_intensity",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "damage_intensity_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "defense_intensity",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "defense_intensity_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "hero_damage_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "hero_defense_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "damage_boost_mult",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.MULTIPLY,
	notify = true,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "lightning_cloud_damage",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "lightning_cloud_duration",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "lightning_cloud_hit_count",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_power_recover",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_max_power",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_max_power_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_power_cost_inc_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_power_cost_reduce_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_total_profit",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_total_profit_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_normalbox_chance",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_goldbox_chance",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_box_profit_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ability_upgrade_count",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_rainbow_chance",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_rainbow1_chance",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_rainbow2_chance",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_rainbow3_chance",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_rainbow4_chance",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_rainbow5_chance",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_chance",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_num",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_num_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_crit_chance",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_crit_num",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_lucky_num",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_efficiency",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_interaction_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_escape_speed_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_wait_time_reduce_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "idle_fish_courier_slot",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "aquarium_slot",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "holy_shield_damage_boost2",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "blade_sword_boost2",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "dash_distance",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "move_distance_efficiency",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "explore_profit_110005_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "resource_profit_stone_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "resource_profit_forge_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "resource_profit_talent_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "resource_profit_210001_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "lightning_damage_boost2",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "poison_damage_boost2",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "freeze_damage_boost2",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "bleed_damage_boost2",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "holy_suit_effect_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "zeus_suit_effect_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "ice_suit_effect_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "poison_suit_effect_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "bleed_suit_effect_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "crit_suit_effect_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "wind_suit_effect_boost",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "revive_max",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "in_game_bless_refresh_max",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "in_game_ability_upgrade_max",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "gem_drop_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "gem_drop_num_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "gem_extra_drop_base",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "total_drop_num_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "refine_inc_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "abyssal_free",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "drawing_drop_chance",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "gem_roll_change",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "explore_extra_chance",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "explore_extra_profit_pct",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "rune_rarity_chance",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.PERCENTAGE,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "rune_devour_lock",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "explore_limit",
	scope = PropertyScope.PLAYER,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "attack_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "attack_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "spell_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "spell_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "skill_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "skill_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "dodge_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "dodge_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "defense_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "defense_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "ultimate_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "ultimate_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "lightning_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "lightning_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "freeze_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "freeze_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "poison_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "poison_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "bleed_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "bleed_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "blade_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "blade_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "holy_shield_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "holy_shield_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "ring_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "ring_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "splash_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "splash_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "melee_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "melee_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "ranged_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "ranged_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "elite_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "elite_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "boss_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "boss_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "barrier_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "barrier_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "backstab_damage_boost_per_level",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
	event_name = "hero_level_up",
	event_link_id = "backstab_damage_boost",
})
PropertySystem:RegisterProperty({
	id = "idle_fish_myth_fish_chance",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "engraving_1_transfer",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "engraving_2_transfer",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "engraving_3_transfer",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "engraving_4_transfer",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "engraving_5_transfer",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "engraving_1_strengthen",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "engraving_2_strengthen",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "engraving_3_strengthen",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "engraving_4_strengthen",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
PropertySystem:RegisterProperty({
	id = "engraving_5_strengthen",
	scope = PropertyScope.UNIT,
	valueType = PropertyValueType.NUMBER,
	aggregation = AggregationStrategy.SUM,
	enableCache = false,
})
function GetHealth(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "health", e)
end
function GetBaseHealth(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "base_health", e)
end
function GetHealthAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "health_amplify", e)
end
function GetHealRoomStart(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "heal_room_start", e)
end
function GetHealthCostRoomStart(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "health_cost_room_start", e)
end
function GetBaseMana(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "base_mana", e)
end
function GetMana(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "mana", e)
end
function GetManaAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "mana_amplify", e)
end
function GetBaseAttack(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "base_attack", e)
end
function GetAttack(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "attack", e)
end
function GetAttackAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "attack_amplify", e)
end
function GetAttackspeed(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "attackspeed", e)
end
function GetAttackspeedReduction(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "attackspeed_reduction", e)
end
function GetWispAttackspeed(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "wisp_attackspeed", e)
end
function GetWispDamage(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "wisp_damage", e)
end
function GetCooldownReduction(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "cooldown_reduction", e)
end
function GetBossGapAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "boss_gap_amplify", e)
end
function GetAttackRange(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "attack_range", e)
end
function GetAttackRangeMelee(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "attack_range_melee", e)
end
function GetAttackRangeRanger(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "attack_range_ranger", e)
end
function GetBulletRange(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "bullet_range", e)
end
function GetAoeAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "aoe_amplify", e)
end
function GetCritChance(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "crit_chance", e)
end
function GetAttackCritChance(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "attack_crit_chance", e)
end
function GetSpellCritChance(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "spell_crit_chance", e)
end
function GetExposeAttackCritChance(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "expose_attack_crit_chance", e)
end
function GetCritDamage(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "crit_damage", e)
end
function GetCritDamageMult(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "crit_damage_mult", e)
end
function GetBarrierCritDamage(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "barrier_crit_damage", e)
end
function GetBleedCritDamage(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "bleed_crit_damage", e)
end
function GetAttackCritDamage(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "attack_crit_damage", e)
end
function GetAttackCritDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "attack_crit_damage_boost", e)
end
function GetSpellCritDamage(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "spell_crit_damage", e)
end
function GetSpellCritDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "spell_crit_damage_boost", e)
end
function GetAttackDamageProc(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "attack_damage_proc", e)
end
function GetSpellDamageProc(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "spell_damage_proc", e)
end
function GetSpellDamageProcTarget(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "spell_damage_proc_target", e)
end
function GetDamageProcTarget(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "damage_proc_target", e)
end
function GetDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "damage_amplify", e)
end
function GetFinalDamage(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "final_damage", e)
end
function GetFinalDefense(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "final_defense", e)
end
function GetFinalDamage101(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "final_damage_101", e)
end
function GetFinalDamage102(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "final_damage_102", e)
end
function GetFinalDamage103(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "final_damage_103", e)
end
function GetPhysicalDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "physical_damage_amplify", e)
end
function GetMagicalDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "magical_damage_amplify", e)
end
function GetAttackDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "attack_damage_amplify", e)
end
function GetSpellDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "spell_damage_amplify", e)
end
function GetBackstabDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "backstab_damage_amplify", e)
end
function GetBackstabDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "backstab_damage_boost", e)
end
function GetBarrierDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "barrier_damage_amplify", e)
end
function GetBarrierDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "barrier_damage_boost", e)
end
function GetRetaliatedDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "retaliated_damage_amplify", e)
end
function GetRingDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ring_damage_amplify", e)
end
function GetRingDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ring_damage_boost", e)
end
function GetBladeDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "blade_damage_amplify", e)
end
function GetBladeSpeedAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "blade_speed_amplify", e)
end
function GetDamageReduction(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "damage_reduction", e)
end
function GetPoisonPoolShieldAttenuationIntervalAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "poison_pool_shield_attenuation_interval_amplify", e)
end
function GetIncomingDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "incoming_damage_amplify", e)
end
function GetTrapIncomingDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "trap_incoming_damage_amplify", e)
end
function GetTrapDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "trap_damage_amplify", e)
end
function GetPoisonAttenuationIntervalAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "poison_attenuation_interval_amplify", e)
end
function GetPoisonPoolIncomingDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "poison_pool_incoming_damage_amplify", e)
end
function GetTavernEffectAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "tavern_effect_amplify", e)
end
function GetEvasion(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "evasion", e)
end
function GetAvoidDamage(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "avoid_damage", e)
end
function GetMinHealth(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "min_health", e)
end
function GetHealAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "heal_amplify", e)
end
function GetFuryAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "fury_amplify", e)
end
function GetFuryRegen(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "fury_regen", e)
end
function GetCritFuryAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "crit_fury_amplify", e)
end
function GetSkillFuryAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "skill_fury_amplify", e)
end
function GetRingFuryAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ring_fury_amplify", e)
end
function GetMovespeed(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "movespeed", e)
end
function GetMovespeedNotCalculated(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "movespeed_not_calculated", e)
end
function GetMovespeedAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "movespeed_amplify", e)
end
function GetShopDiscount(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "shop_discount", e)
end
function GetShopRefreshRefund(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "shop_refresh_refund", e)
end
function GetSplitCount(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "split_count", e)
end
function GetAbilityChargeAttack(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ability_charge_attack", e)
end
function GetAbilityChargeSkill(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ability_charge_skill", e)
end
function GetAbilityChargeDodge(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ability_charge_dodge", e)
end
function GetAbilityChargeDefense(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ability_charge_defense", e)
end
function GetAbilityChargeUltimate(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ability_charge_ultimate", e)
end
function GetRingCount(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ring_count", e)
end
function GetRingSpeedAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ring_speed_amplify", e)
end
function GetRingTrackRadius(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ring_track_radius", e)
end
function GetLightningMultipleChance(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "lightning_multiple_chance", e)
end
function GetLightningRadius(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "lightning_radius", e)
end
function GetLightningDamage(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "lightning_damage", e)
end
function GetLightningExposeChance(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "lightning_expose_chance", e)
end
function GetExposeKeepChance(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "expose_keep_chance", e)
end
function GetLightningCount(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "lightning_count", e)
end
function GetPoisonNoAttenuationChance(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "poison_no_attenuation_chance", e)
end
function GetPoisonAttenuationReduction(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "poison_attenuation_reduction", e)
end
function GetFrozenNoAttenuationChance(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "frozen_no_attenuation_chance", e)
end
function GetFrozenAttenuationReduction(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "frozen_attenuation_reduction", e)
end
function GetFrozenDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "frozen_damage_amplify", e)
end
function GetShieldAttenuationReduction(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "shield_attenuation_reduction", e)
end
function GetShieldAttenuationIntervalAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "shield_attenuation_interval_amplify", e)
end
function GetShieldNoAttenuationChance(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "shield_no_attenuation_chance", e)
end
function GetFrozenBurstStack(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "frozen_burst_stack", e)
end
function GetBounceCount(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "bounce_count", e)
end
function GetLaserBounceCount(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "laser_bounce_count", e)
end
function GetLaserDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "laser_damage_amplify", e)
end
function GetSnowballBounceCount(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "snowball_bounce_count", e)
end
function GetSnowballExtraShot(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "snowball_extra_shot", e)
end
function GetSnowballDamage(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "snowball_damage", e)
end
function GetIceStrike(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ice_strike", e)
end
function GetReflectDamage(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "reflect_damage", e)
end
function GetPerEncounterAttackBonus(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "per_encounter_attack_bonus", e)
end
function GetPerEncounterAttackAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "per_encounter_attack_amplify", e)
end
function GetPerEncounterAttackDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "per_encounter_attack_damage_amplify", e)
end
function GetPerEncounterSkillDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "per_encounter_skill_damage_amplify", e)
end
function GetPerEncounterUltimateDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "per_encounter_ultimate_damage_amplify", e)
end
function GetPerEncounterPhysicalDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "per_encounter_physical_damage_amplify", e)
end
function GetPerEncounterMagicalDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "per_encounter_magical_damage_amplify", e)
end
function GetPerEncounterMeleeHeroDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "per_encounter_melee_hero_damage_amplify", e)
end
function GetPerEncounterRangerHeroDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "per_encounter_ranger_hero_damage_amplify", e)
end
function GetPerEncounterCritDamage(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "per_encounter_crit_damage", e)
end
function GetBlock(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "block", e)
end
function GetPoisonStacksAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "poison_stacks_amplify", e)
end
function GetShockDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "shock_damage_amplify", e)
end
function GetBleedStacksAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "bleed_stacks_amplify", e)
end
function GetFreezeStacksAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "freeze_stacks_amplify", e)
end
function GetShieldAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "shield_amplify", e)
end
function GetCritDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "crit_damage_amplify", e)
end
function GetMeleeHeroDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "melee_hero_damage_amplify", e)
end
function GetRangerHeroDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ranger_hero_damage_amplify", e)
end
function GetHealthPotionHealAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "health_potion_heal_amplify", e)
end
function GetCritChanceAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "crit_chance_amplify", e)
end
function GetSplashDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "splash_damage_amplify", e)
end
function GetSplashDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "splash_damage_boost", e)
end
function GetDebuffTargetDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "debuff_target_damage_amplify", e)
end
function GetMinionDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "minion_damage_boost", e)
end
function GetBossDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "boss_damage_boost", e)
end
function GetEliteDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "elite_damage_boost", e)
end
function GetUltimateManaCostReduce(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ultimate_mana_cost_reduce", e)
end
function GetBuffDuration(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "buff_duration", e)
end
function GetDebuffDuration(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "debuff_duration", e)
end
function GetAbilityChargeDefenseTime(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ability_charge_defense_time", e)
end
function GetPotionHealRestore(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "potion_heal_restore", e)
end
function GetBreakDropChance(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "break_drop_chance", e)
end
function GetBreakDropProfitPct(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "break_drop_profit_pct", e)
end
function GetReviveCount(f, e)
	return PropertySystem:GetPropertyValue(f, "revive_count", e)
end
function GetReviveHealthRecover(f, e)
	return PropertySystem:GetPropertyValue(f, "revive_health_recover", e)
end
function GetInitialGold(f, e)
	return PropertySystem:GetPropertyValue(f, "initial_gold", e)
end
function GetExpGainChance(f, e)
	return PropertySystem:GetPropertyValue(f, "exp_gain_chance", e)
end
function GetGoldRoomAmount(f, e)
	return PropertySystem:GetPropertyValue(f, "gold_room_amount", e)
end
function GetShopItemRarity(f, e)
	return PropertySystem:GetPropertyValue(f, "shop_item_rarity", e)
end
function GetArtifactItemRarity(f, e)
	return PropertySystem:GetPropertyValue(f, "artifact_item_rarity", e)
end
function GetBlessingRarity(f, e)
	return PropertySystem:GetPropertyValue(f, "blessing_rarity", e)
end
function GetBlessRefreshCount(f, e)
	return PropertySystem:GetPropertyValue(f, "bless_refresh_count", e)
end
function GetArtifactAllinCount(f, e)
	return PropertySystem:GetPropertyValue(f, "artifact_allin_count", e)
end
function GetBlessAllinCount(f, e)
	return PropertySystem:GetPropertyValue(f, "bless_allin_count", e)
end
function GetBlessUpgradeAllinCount(f, e)
	return PropertySystem:GetPropertyValue(f, "bless_upgrade_allin_count", e)
end
function GetAbilityUpgradeAllinCount(f, e)
	return PropertySystem:GetPropertyValue(f, "ability_upgrade_allin_count", e)
end
function GetAbilityUpgradeRefreshCount(f, e)
	return PropertySystem:GetPropertyValue(f, "ability_upgrade_refresh_count", e)
end
function GetMeleeDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "melee_damage_boost", e)
end
function GetRangedDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ranged_damage_boost", e)
end
function GetExecuteDamage(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "execute_damage", e)
end
function GetRageCapacityAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "rage_capacity_amplify", e)
end
function GetHeavyAttack(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "heavy_attack", e)
end
function GetHpRegeneration(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "hp_regeneration", e)
end
function GetThornsDamage(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "thorns_damage", e)
end
function GetDamageVsBleedingTargets(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "damage_vs_bleeding_targets", e)
end
function GetDamageVsFrozenTargets(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "damage_vs_frozen_targets", e)
end
function GetDamageVsShockedTargets(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "damage_vs_shocked_targets", e)
end
function GetDamageVsPoisonedTargets(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "damage_vs_poisoned_targets", e)
end
function GetFinisherDamage(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "finisher_damage", e)
end
function GetFinisherCritChance(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "finisher_crit_chance", e)
end
function GetSkillCooldownReduction(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "skill_cooldown_reduction", e)
end
function GetEvadeCooldownReduction(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "evade_cooldown_reduction", e)
end
function GetBlockCooldownReduction(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "block_cooldown_reduction", e)
end
function GetUltimateCooldownReduction(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ultimate_cooldown_reduction", e)
end
function GetGoldGainAmount(f, e)
	return PropertySystem:GetPropertyValue(f, "gold_gain_amount", e)
end
function GetExpGainAmount(f, e)
	return PropertySystem:GetPropertyValue(f, "exp_gain_amount", e)
end
function GetGoldRewardPerEncounter(f, e)
	return PropertySystem:GetPropertyValue(f, "gold_reward_per_encounter", e)
end
function GetExpRewardPerEncounter(f, e)
	return PropertySystem:GetPropertyValue(f, "exp_reward_per_encounter", e)
end
function GetPoisonDecayReduction(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "poison_decay_reduction", e)
end
function GetBleedTriggerInterval(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "bleed_trigger_interval", e)
end
function GetFreezeDuration(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "freeze_duration", e)
end
function GetShockNoDecayRate(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "shock_no_decay_rate", e)
end
function GetRageGainPercentPerAttack(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "rage_gain_percent_per_attack", e)
end
function GetRageGainPercentPerBlock(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "rage_gain_percent_per_block", e)
end
function GetRageGainPercentPerEvade(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "rage_gain_percent_per_evade", e)
end
function GetRageGainPercentPerUltimate(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "rage_gain_percent_per_ultimate", e)
end
function GetPoisonDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "poison_damage_amplify", e)
end
function GetPoisonDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "poison_damage_boost", e)
end
function GetLightningDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "lightning_damage_amplify", e)
end
function GetLightningDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "lightning_damage_boost", e)
end
function GetHolyShieldDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "holy_shield_damage_boost", e)
end
function GetBleedDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "bleed_damage_amplify", e)
end
function GetBleedDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "bleed_damage_boost", e)
end
function GetBladeDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "blade_damage_boost", e)
end
function GetFreezeDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "freeze_damage_amplify", e)
end
function GetFreezeDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "freeze_damage_boost", e)
end
function GetShieldDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "shield_damage_amplify", e)
end
function GetExecuteDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "execute_damage_amplify", e)
end
function GetConditionalDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "conditional_damage_amplify", e)
end
function GetAttackDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "attack_damage_boost", e)
end
function GetSpellDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "spell_damage_boost", e)
end
function GetSkillDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "skill_damage_amplify", e)
end
function GetSkillDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "skill_damage_boost", e)
end
function GetUltimateDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ultimate_damage_amplify", e)
end
function GetUltimateDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ultimate_damage_boost", e)
end
function GetDodgeDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "dodge_damage_amplify", e)
end
function GetDodgeDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "dodge_damage_boost", e)
end
function GetDefenseDamageAmplify(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "defense_damage_amplify", e)
end
function GetDefenseDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "defense_damage_boost", e)
end
function GetMeleeHeroDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "melee_hero_damage_boost", e)
end
function GetRangerHeroDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ranger_hero_damage_boost", e)
end
function GetDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "damage_boost", e)
end
function GetMagicalDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "magical_damage_boost", e)
end
function GetPhysicalDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "physical_damage_boost", e)
end
function GetDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "damage_boost_per_level", e)
end
function GetPhysicalDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "physical_damage_boost_per_level", e)
end
function GetMagicalDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "magical_damage_boost_per_level", e)
end
function GetHpRegenPerEncounter(f, e)
	return PropertySystem:GetPropertyValue(f, "hp_regen_per_encounter", e)
end
function GetManaRegenPerEncounter(f, e)
	return PropertySystem:GetPropertyValue(f, "mana_regen_per_encounter", e)
end
function GetDamageIntensity(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "damage_intensity", e)
end
function GetDamageIntensityBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "damage_intensity_boost", e)
end
function GetDefenseIntensity(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "defense_intensity", e)
end
function GetDefenseIntensityBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "defense_intensity_boost", e)
end
function GetHeroDamageBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "hero_damage_boost", e)
end
function GetHeroDefenseBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "hero_defense_boost", e)
end
function GetDamageBoostMult(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "damage_boost_mult", e)
end
function GetLightningCloudDamage(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "lightning_cloud_damage", e)
end
function GetLightningCloudDuration(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "lightning_cloud_duration", e)
end
function GetLightningCloudHitCount(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "lightning_cloud_hit_count", e)
end
function GetAbilityUpgradeCount(f, e)
	return PropertySystem:GetPropertyValue(f, "ability_upgrade_count", e)
end
function GetAquariumSlot(f, e)
	return PropertySystem:GetPropertyValue(f, "aquarium_slot", e)
end
function GetHolyShieldDamageBoost2(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "holy_shield_damage_boost2", e)
end
function GetBladeSwordBoost2(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "blade_sword_boost2", e)
end
function GetDashDistance(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "dash_distance", e)
end
function GetMoveDistanceEfficiency(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "move_distance_efficiency", e)
end
function GetLightningDamageBoost2(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "lightning_damage_boost2", e)
end
function GetPoisonDamageBoost2(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "poison_damage_boost2", e)
end
function GetFreezeDamageBoost2(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "freeze_damage_boost2", e)
end
function GetBleedDamageBoost2(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "bleed_damage_boost2", e)
end
function GetHolySuitEffectBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "holy_suit_effect_boost", e)
end
function GetZeusSuitEffectBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "zeus_suit_effect_boost", e)
end
function GetIceSuitEffectBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ice_suit_effect_boost", e)
end
function GetPoisonSuitEffectBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "poison_suit_effect_boost", e)
end
function GetBleedSuitEffectBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "bleed_suit_effect_boost", e)
end
function GetCritSuitEffectBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "crit_suit_effect_boost", e)
end
function GetWindSuitEffectBoost(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "wind_suit_effect_boost", e)
end
function GetReviveMax(f, e)
	return PropertySystem:GetPropertyValue(f, "revive_max", e)
end
function GetInGameBlessRefreshMax(f, e)
	return PropertySystem:GetPropertyValue(f, "in_game_bless_refresh_max", e)
end
function GetInGameAbilityUpgradeMax(f, e)
	return PropertySystem:GetPropertyValue(f, "in_game_ability_upgrade_max", e)
end
function GetGemDropPct(f, e)
	return PropertySystem:GetPropertyValue(f, "gem_drop_pct", e)
end
function GetGemDropNumPct(f, e)
	return PropertySystem:GetPropertyValue(f, "gem_drop_num_pct", e)
end
function GetGemExtraDropBase(f, e)
	return PropertySystem:GetPropertyValue(f, "gem_extra_drop_base", e)
end
function GetTotalDropNumPct(f, e)
	return PropertySystem:GetPropertyValue(f, "total_drop_num_pct", e)
end
function GetRefineIncPct(f, e)
	return PropertySystem:GetPropertyValue(f, "refine_inc_pct", e)
end
function GetAbyssalFree(f, e)
	return PropertySystem:GetPropertyValue(f, "abyssal_free", e)
end
function GetDrawingDropChance(f, e)
	return PropertySystem:GetPropertyValue(f, "drawing_drop_chance", e)
end
function GetGemRollChance(f, e)
	return PropertySystem:GetPropertyValue(f, "gem_roll_change", e)
end
function GetExploreExtraChance(f, e)
	return PropertySystem:GetPropertyValue(f, "explore_extra_chance", e)
end
function GetExploreExtraProfitPct(f, e)
	return PropertySystem:GetPropertyValue(f, "explore_extra_profit_pct", e)
end
function GetRuneRarityChance(f, e)
	return PropertySystem:GetPropertyValue(f, "rune_rarity_chance", e)
end
function GetRuneDevourLock(f, e)
	return PropertySystem:GetPropertyValue(f, "rune_devour_lock", e)
end
function GetExploreLimit(f, e)
	return PropertySystem:GetPropertyValue(f, "explore_limit", e)
end
function GetAttackDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "attack_damage_boost_per_level", e)
end
function GetSpellDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "spell_damage_boost_per_level", e)
end
function GetSkillDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "skill_damage_boost_per_level", e)
end
function GetDodgeDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "dodge_damage_boost_per_level", e)
end
function GetDefenseDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "defense_damage_boost_per_level", e)
end
function GetUltimateDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ultimate_damage_boost_per_level", e)
end
function GetLightningDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "lightning_damage_boost_per_level", e)
end
function GetFreezeDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "freeze_damage_boost_per_level", e)
end
function GetPoisonDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "poison_damage_boost_per_level", e)
end
function GetBleedDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "bleed_damage_boost_per_level", e)
end
function GetBladeDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "blade_damage_boost_per_level", e)
end
function GetHolyShieldDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "holy_shield_damage_boost_per_level", e)
end
function GetRingDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ring_damage_boost_per_level", e)
end
function GetSplashDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "splash_damage_boost_per_level", e)
end
function GetMeleeDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "melee_damage_boost_per_level", e)
end
function GetRangedDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "ranged_damage_boost_per_level", e)
end
function GetEliteDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "elite_damage_boost_per_level", e)
end
function GetBossDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "boss_damage_boost_per_level", e)
end
function GetBarrierDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "barrier_damage_boost_per_level", e)
end
function GetBackstabDamageBoostPerLevel(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "backstab_damage_boost_per_level", e)
end
function GetIdleFishMythFishChance(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "idle_fish_myth_fish_chance", e)
end
function GetEngraving1Transfer(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "engraving_1_transfer", e)
end
function GetEngraving2Transfer(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "engraving_2_transfer", e)
end
function GetEngraving3Transfer(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "engraving_3_transfer", e)
end
function GetEngraving4Transfer(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "engraving_4_transfer", e)
end
function GetEngraving5Transfer(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "engraving_5_transfer", e)
end
function GetEngraving1Strengthen(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "engraving_1_strengthen", e)
end
function GetEngraving2Strengthen(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "engraving_2_strengthen", e)
end
function GetEngraving3Strengthen(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "engraving_3_strengthen", e)
end
function GetEngraving4Strengthen(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "engraving_4_strengthen", e)
end
function GetEngraving5Strengthen(d, e)
	return PropertySystem:GetPropertyValue(d:entindex(), "engraving_5_strengthen", e)
end
PROPERTY_FUNCTION_MAP = {
	health = GetHealth,
	base_health = GetBaseHealth,
	health_amplify = GetHealthAmplify,
	heal_room_start = GetHealRoomStart,
	health_cost_room_start = GetHealthCostRoomStart,
	base_mana = GetBaseMana,
	mana = GetMana,
	mana_amplify = GetManaAmplify,
	base_attack = GetBaseAttack,
	attack = GetAttack,
	attack_amplify = GetAttackAmplify,
	attackspeed = GetAttackspeed,
	attackspeed_reduction = GetAttackspeedReduction,
	wisp_attackspeed = GetWispAttackspeed,
	wisp_damage = GetWispDamage,
	cooldown_reduction = GetCooldownReduction,
	boss_gap_amplify = GetBossGapAmplify,
	attack_range = GetAttackRange,
	attack_range_melee = GetAttackRangeMelee,
	attack_range_ranger = GetAttackRangeRanger,
	bullet_range = GetBulletRange,
	aoe_amplify = GetAoeAmplify,
	crit_chance = GetCritChance,
	attack_crit_chance = GetAttackCritChance,
	spell_crit_chance = GetSpellCritChance,
	expose_attack_crit_chance = GetExposeAttackCritChance,
	crit_damage = GetCritDamage,
	crit_damage_mult = GetCritDamageMult,
	barrier_crit_damage = GetBarrierCritDamage,
	bleed_crit_damage = GetBleedCritDamage,
	attack_crit_damage = GetAttackCritDamage,
	attack_crit_damage_boost = GetAttackCritDamageBoost,
	spell_crit_damage = GetSpellCritDamage,
	spell_crit_damage_boost = GetSpellCritDamageBoost,
	attack_damage_proc = GetAttackDamageProc,
	spell_damage_proc = GetSpellDamageProc,
	spell_damage_proc_target = GetSpellDamageProcTarget,
	damage_proc_target = GetDamageProcTarget,
	damage_amplify = GetDamageAmplify,
	final_damage = GetFinalDamage,
	final_defense = GetFinalDefense,
	final_damage_101 = GetFinalDamage101,
	final_damage_102 = GetFinalDamage102,
	final_damage_103 = GetFinalDamage103,
	physical_damage_amplify = GetPhysicalDamageAmplify,
	magical_damage_amplify = GetMagicalDamageAmplify,
	attack_damage_amplify = GetAttackDamageAmplify,
	spell_damage_amplify = GetSpellDamageAmplify,
	backstab_damage_amplify = GetBackstabDamageAmplify,
	backstab_damage_boost = GetBackstabDamageBoost,
	barrier_damage_amplify = GetBarrierDamageAmplify,
	barrier_damage_boost = GetBarrierDamageBoost,
	retaliated_damage_amplify = GetRetaliatedDamageAmplify,
	ring_damage_amplify = GetRingDamageAmplify,
	ring_damage_boost = GetRingDamageBoost,
	blade_damage_amplify = GetBladeDamageAmplify,
	blade_speed_amplify = GetBladeSpeedAmplify,
	damage_reduction = GetDamageReduction,
	poison_pool_shield_attenuation_interval_amplify = GetPoisonPoolShieldAttenuationIntervalAmplify,
	incoming_damage_amplify = GetIncomingDamageAmplify,
	trap_incoming_damage_amplify = GetTrapIncomingDamageAmplify,
	trap_damage_amplify = GetTrapDamageAmplify,
	poison_attenuation_interval_amplify = GetPoisonAttenuationIntervalAmplify,
	poison_pool_incoming_damage_amplify = GetPoisonPoolIncomingDamageAmplify,
	tavern_effect_amplify = GetTavernEffectAmplify,
	evasion = GetEvasion,
	avoid_damage = GetAvoidDamage,
	min_health = GetMinHealth,
	heal_amplify = GetHealAmplify,
	fury_amplify = GetFuryAmplify,
	fury_regen = GetFuryRegen,
	crit_fury_amplify = GetCritFuryAmplify,
	skill_fury_amplify = GetSkillFuryAmplify,
	ring_fury_amplify = GetRingFuryAmplify,
	movespeed = GetMovespeed,
	movespeed_not_calculated = GetMovespeedNotCalculated,
	movespeed_amplify = GetMovespeedAmplify,
	shop_discount = GetShopDiscount,
	shop_refresh_refund = GetShopRefreshRefund,
	split_count = GetSplitCount,
	ability_charge_attack = GetAbilityChargeAttack,
	ability_charge_skill = GetAbilityChargeSkill,
	ability_charge_dodge = GetAbilityChargeDodge,
	ability_charge_defense = GetAbilityChargeDefense,
	ability_charge_ultimate = GetAbilityChargeUltimate,
	ring_count = GetRingCount,
	ring_speed_amplify = GetRingSpeedAmplify,
	ring_track_radius = GetRingTrackRadius,
	lightning_multiple_chance = GetLightningMultipleChance,
	lightning_radius = GetLightningRadius,
	lightning_damage = GetLightningDamage,
	lightning_expose_chance = GetLightningExposeChance,
	expose_keep_chance = GetExposeKeepChance,
	lightning_count = GetLightningCount,
	poison_no_attenuation_chance = GetPoisonNoAttenuationChance,
	poison_attenuation_reduction = GetPoisonAttenuationReduction,
	frozen_no_attenuation_chance = GetFrozenNoAttenuationChance,
	frozen_attenuation_reduction = GetFrozenAttenuationReduction,
	frozen_damage_amplify = GetFrozenDamageAmplify,
	shield_attenuation_reduction = GetShieldAttenuationReduction,
	shield_attenuation_interval_amplify = GetShieldAttenuationIntervalAmplify,
	shield_no_attenuation_chance = GetShieldNoAttenuationChance,
	frozen_burst_stack = GetFrozenBurstStack,
	bounce_count = GetBounceCount,
	laser_bounce_count = GetLaserBounceCount,
	laser_damage_amplify = GetLaserDamageAmplify,
	snowball_bounce_count = GetSnowballBounceCount,
	snowball_extra_shot = GetSnowballExtraShot,
	snowball_damage = GetSnowballDamage,
	ice_strike = GetIceStrike,
	reflect_damage = GetReflectDamage,
	per_encounter_attack_bonus = GetPerEncounterAttackBonus,
	per_encounter_attack_amplify = GetPerEncounterAttackAmplify,
	per_encounter_attack_damage_amplify = GetPerEncounterAttackDamageAmplify,
	per_encounter_skill_damage_amplify = GetPerEncounterSkillDamageAmplify,
	per_encounter_ultimate_damage_amplify = GetPerEncounterUltimateDamageAmplify,
	per_encounter_physical_damage_amplify = GetPerEncounterPhysicalDamageAmplify,
	per_encounter_magical_damage_amplify = GetPerEncounterMagicalDamageAmplify,
	per_encounter_melee_hero_damage_amplify = GetPerEncounterMeleeHeroDamageAmplify,
	per_encounter_ranger_hero_damage_amplify = GetPerEncounterRangerHeroDamageAmplify,
	per_encounter_crit_damage = GetPerEncounterCritDamage,
	block = GetBlock,
	poison_stacks_amplify = GetPoisonStacksAmplify,
	shock_damage_amplify = GetShockDamageAmplify,
	bleed_stacks_amplify = GetBleedStacksAmplify,
	freeze_stacks_amplify = GetFreezeStacksAmplify,
	shield_amplify = GetShieldAmplify,
	crit_damage_amplify = GetCritDamageAmplify,
	melee_hero_damage_amplify = GetMeleeHeroDamageAmplify,
	ranger_hero_damage_amplify = GetRangerHeroDamageAmplify,
	health_potion_heal_amplify = GetHealthPotionHealAmplify,
	crit_chance_amplify = GetCritChanceAmplify,
	splash_damage_amplify = GetSplashDamageAmplify,
	splash_damage_boost = GetSplashDamageBoost,
	debuff_target_damage_amplify = GetDebuffTargetDamageAmplify,
	minion_damage_boost = GetMinionDamageBoost,
	boss_damage_boost = GetBossDamageBoost,
	elite_damage_boost = GetEliteDamageBoost,
	ultimate_mana_cost_reduce = GetUltimateManaCostReduce,
	buff_duration = GetBuffDuration,
	debuff_duration = GetDebuffDuration,
	ability_charge_defense_time = GetAbilityChargeDefenseTime,
	potion_heal_restore = GetPotionHealRestore,
	break_drop_chance = GetBreakDropChance,
	break_drop_profit_pct = GetBreakDropProfitPct,
	revive_count = GetReviveCount,
	revive_health_recover = GetReviveHealthRecover,
	initial_gold = GetInitialGold,
	exp_gain_chance = GetExpGainChance,
	gold_room_amount = GetGoldRoomAmount,
	shop_item_rarity = GetShopItemRarity,
	artifact_item_rarity = GetArtifactItemRarity,
	blessing_rarity = GetBlessingRarity,
	bless_refresh_count = GetBlessRefreshCount,
	artifact_allin_count = GetArtifactAllinCount,
	bless_allin_count = GetBlessAllinCount,
	bless_upgrade_allin_count = GetBlessUpgradeAllinCount,
	ability_upgrade_allin_count = GetAbilityUpgradeAllinCount,
	ability_upgrade_refresh_count = GetAbilityUpgradeRefreshCount,
	melee_damage_boost = GetMeleeDamageBoost,
	ranged_damage_boost = GetRangedDamageBoost,
	execute_damage = GetExecuteDamage,
	rage_capacity_amplify = GetRageCapacityAmplify,
	heavy_attack = GetHeavyAttack,
	hp_regeneration = GetHpRegeneration,
	thorns_damage = GetThornsDamage,
	damage_vs_bleeding_targets = GetDamageVsBleedingTargets,
	damage_vs_frozen_targets = GetDamageVsFrozenTargets,
	damage_vs_shocked_targets = GetDamageVsShockedTargets,
	damage_vs_poisoned_targets = GetDamageVsPoisonedTargets,
	finisher_damage = GetFinisherDamage,
	finisher_crit_chance = GetFinisherCritChance,
	skill_cooldown_reduction = GetSkillCooldownReduction,
	evade_cooldown_reduction = GetEvadeCooldownReduction,
	block_cooldown_reduction = GetBlockCooldownReduction,
	ultimate_cooldown_reduction = GetUltimateCooldownReduction,
	gold_gain_amount = GetGoldGainAmount,
	exp_gain_amount = GetExpGainAmount,
	gold_reward_per_encounter = GetGoldRewardPerEncounter,
	exp_reward_per_encounter = GetExpRewardPerEncounter,
	poison_decay_reduction = GetPoisonDecayReduction,
	bleed_trigger_interval = GetBleedTriggerInterval,
	freeze_duration = GetFreezeDuration,
	shock_no_decay_rate = GetShockNoDecayRate,
	rage_gain_percent_per_attack = GetRageGainPercentPerAttack,
	rage_gain_percent_per_block = GetRageGainPercentPerBlock,
	rage_gain_percent_per_evade = GetRageGainPercentPerEvade,
	rage_gain_percent_per_ultimate = GetRageGainPercentPerUltimate,
	poison_damage_amplify = GetPoisonDamageAmplify,
	poison_damage_boost = GetPoisonDamageBoost,
	lightning_damage_amplify = GetLightningDamageAmplify,
	lightning_damage_boost = GetLightningDamageBoost,
	holy_shield_damage_boost = GetHolyShieldDamageBoost,
	bleed_damage_amplify = GetBleedDamageAmplify,
	bleed_damage_boost = GetBleedDamageBoost,
	blade_damage_boost = GetBladeDamageBoost,
	freeze_damage_amplify = GetFreezeDamageAmplify,
	freeze_damage_boost = GetFreezeDamageBoost,
	shield_damage_amplify = GetShieldDamageAmplify,
	execute_damage_amplify = GetExecuteDamageAmplify,
	conditional_damage_amplify = GetConditionalDamageAmplify,
	attack_damage_boost = GetAttackDamageBoost,
	spell_damage_boost = GetSpellDamageBoost,
	skill_damage_amplify = GetSkillDamageAmplify,
	skill_damage_boost = GetSkillDamageBoost,
	ultimate_damage_amplify = GetUltimateDamageAmplify,
	ultimate_damage_boost = GetUltimateDamageBoost,
	dodge_damage_amplify = GetDodgeDamageAmplify,
	dodge_damage_boost = GetDodgeDamageBoost,
	defense_damage_amplify = GetDefenseDamageAmplify,
	defense_damage_boost = GetDefenseDamageBoost,
	melee_hero_damage_boost = GetMeleeHeroDamageBoost,
	ranger_hero_damage_boost = GetRangerHeroDamageBoost,
	damage_boost = GetDamageBoost,
	magical_damage_boost = GetMagicalDamageBoost,
	physical_damage_boost = GetPhysicalDamageBoost,
	damage_boost_per_level = GetDamageBoostPerLevel,
	physical_damage_boost_per_level = GetPhysicalDamageBoostPerLevel,
	magical_damage_boost_per_level = GetMagicalDamageBoostPerLevel,
	hp_regen_per_encounter = GetHpRegenPerEncounter,
	mana_regen_per_encounter = GetManaRegenPerEncounter,
	damage_intensity = GetDamageIntensity,
	damage_intensity_boost = GetDamageIntensityBoost,
	defense_intensity = GetDefenseIntensity,
	defense_intensity_boost = GetDefenseIntensityBoost,
	hero_damage_boost = GetHeroDamageBoost,
	hero_defense_boost = GetHeroDefenseBoost,
	damage_boost_mult = GetDamageBoostMult,
	lightning_cloud_damage = GetLightningCloudDamage,
	lightning_cloud_duration = GetLightningCloudDuration,
	lightning_cloud_hit_count = GetLightningCloudHitCount,
	ability_upgrade_count = GetAbilityUpgradeCount,
	aquarium_slot = GetAquariumSlot,
	holy_shield_damage_boost2 = GetHolyShieldDamageBoost2,
	blade_sword_boost2 = GetBladeSwordBoost2,
	dash_distance = GetDashDistance,
	move_distance_efficiency = GetMoveDistanceEfficiency,
	lightning_damage_boost2 = GetLightningDamageBoost2,
	poison_damage_boost2 = GetPoisonDamageBoost2,
	freeze_damage_boost2 = GetFreezeDamageBoost2,
	bleed_damage_boost2 = GetBleedDamageBoost2,
	holy_suit_effect_boost = GetHolySuitEffectBoost,
	zeus_suit_effect_boost = GetZeusSuitEffectBoost,
	ice_suit_effect_boost = GetIceSuitEffectBoost,
	poison_suit_effect_boost = GetPoisonSuitEffectBoost,
	bleed_suit_effect_boost = GetBleedSuitEffectBoost,
	crit_suit_effect_boost = GetCritSuitEffectBoost,
	wind_suit_effect_boost = GetWindSuitEffectBoost,
	revive_max = GetReviveMax,
	in_game_bless_refresh_max = GetInGameBlessRefreshMax,
	in_game_ability_upgrade_max = GetInGameAbilityUpgradeMax,
	gem_drop_pct = GetGemDropPct,
	gem_drop_num_pct = GetGemDropNumPct,
	gem_extra_drop_base = GetGemExtraDropBase,
	total_drop_num_pct = GetTotalDropNumPct,
	refine_inc_pct = GetRefineIncPct,
	abyssal_free = GetAbyssalFree,
	drawing_drop_chance = GetDrawingDropChance,
	gem_roll_change = GetGemRollChance,
	explore_extra_chance = GetExploreExtraChance,
	explore_extra_profit_pct = GetExploreExtraProfitPct,
	rune_rarity_chance = GetRuneRarityChance,
	rune_devour_lock = GetRuneDevourLock,
	explore_limit = GetExploreLimit,
	attack_damage_boost_per_level = GetAttackDamageBoostPerLevel,
	spell_damage_boost_per_level = GetSpellDamageBoostPerLevel,
	skill_damage_boost_per_level = GetSkillDamageBoostPerLevel,
	dodge_damage_boost_per_level = GetDodgeDamageBoostPerLevel,
	defense_damage_boost_per_level = GetDefenseDamageBoostPerLevel,
	ultimate_damage_boost_per_level = GetUltimateDamageBoostPerLevel,
	lightning_damage_boost_per_level = GetLightningDamageBoostPerLevel,
	freeze_damage_boost_per_level = GetFreezeDamageBoostPerLevel,
	poison_damage_boost_per_level = GetPoisonDamageBoostPerLevel,
	bleed_damage_boost_per_level = GetBleedDamageBoostPerLevel,
	blade_damage_boost_per_level = GetBladeDamageBoostPerLevel,
	holy_shield_damage_boost_per_level = GetHolyShieldDamageBoostPerLevel,
	ring_damage_boost_per_level = GetRingDamageBoostPerLevel,
	splash_damage_boost_per_level = GetSplashDamageBoostPerLevel,
	melee_damage_boost_per_level = GetMeleeDamageBoostPerLevel,
	ranged_damage_boost_per_level = GetRangedDamageBoostPerLevel,
	elite_damage_boost_per_level = GetEliteDamageBoostPerLevel,
	boss_damage_boost_per_level = GetBossDamageBoostPerLevel,
	barrier_damage_boost_per_level = GetBarrierDamageBoostPerLevel,
	backstab_damage_boost_per_level = GetBackstabDamageBoostPerLevel,
	idle_fish_myth_fish_chance = GetIdleFishMythFishChance,
	engraving_1_transfer = GetEngraving1Transfer,
	engraving_2_transfer = GetEngraving2Transfer,
	engraving_3_transfer = GetEngraving3Transfer,
	engraving_4_transfer = GetEngraving4Transfer,
	engraving_5_transfer = GetEngraving5Transfer,
	engraving_1_strengthen = GetEngraving1Strengthen,
	engraving_2_strengthen = GetEngraving2Strengthen,
	engraving_3_strengthen = GetEngraving3Strengthen,
	engraving_4_strengthen = GetEngraving4Strengthen,
	engraving_5_strengthen = GetEngraving5Strengthen,
}