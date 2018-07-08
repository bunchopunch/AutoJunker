
-------------------------------------------------------------------------------------------------
--  Initialize Default Settings  --
-------------------------------------------------------------------------------------------------
LootItPlayerDefault = {
-- Loot Window Settings --
    ["LOOTWINDOW"]        = true,
    ["SHOWLOOTWINDOW"]    = false,
    ["LOOTWINDOWOFFSETX"] = 0,
    ["LOOTWINDOWOFFSETY"] = 0,
    ["LOOTWINDOWSCALE"]   = 50,
}

FilterItPlayerDefault = {
-- Filter Settins --
    ["INVENTORYFILTERS"] = false,
}

-- Account Wide Settings --
AutoJunkerAccountDefault = {
-- Profiles --
    ["PROFILES"] = {
        ["PROFILE_NAMES"] = {},
        ["PROFILE"]       = {},
    },
    ["CHARACTER_WATCH_LISTS"] = {
        [CRAFTING_TYPE_BLACKSMITHING] = {},
        [CRAFTING_TYPE_CLOTHIER]      = {},
        [CRAFTING_TYPE_WOODWORKING]   = {},
        [CRAFTING_TYPE_PROVISIONING]  = {},
    },
    ["ADVANCED_FILTERS"] = {},
    ["ICONSIZE"]         = 32,
    ["AUTOSELLDELAY"]    = 30, -- milliseconds
}


-- Player Specific Settings --
AutoJunkerPlayerDefault = {
    ["LOOTIT_SAVEDVARIABLES"]   = LootItPlayerDefault,
    ["FILTERIT_SAVEDVARIABLES"] = FilterItPlayerDefault,

-- Debugging Window --
    ["DEBUGWIN_HIDDEN"]  = true,
    ["DEBUGWIN_OFFSETX"] = 100,
    ["DEBUGWIN_OFFSETY"] = 100,
    ["DEBUGWIN_WIDTH"]   = 400,
    ["DEBUGWIN_HEIGHT"]  = 300,

-- Debugging Options--
    ["DEBUG_JUNK_KEPT_REASONS"] = false,
    
-- Chat Messages --
    ["JUNKEDMESSAGE"]                 = true,
    ["NOTJUNKEDMESSAGE"]              = true,
    ["UNKNOWNRESEARCHMESSAGESPLAYER"] = true,
    ["UNKNOWNRESEARCHMESSAGESOTHER"]  = false,
    ["UNKNOWNRESEARCHMESSAGESNAMES"]  = false,
    ["REPAIRMESSAGES"]                = true,
    ["GOLDMESSAGES"]                  = false,
    ["DESTROYERBTNMESSAGES"]          = false,
    
-- General Settings --
    ["JUNKMODE"]          = true,
    ["LOOTMODE"]          = false,
    ["LOOTSTOLENITEMS"]   = false,
    ["JUNKDESTROYER"]     = false,
    ["INFOBUTTONOFFSETX"] = 0,
    
-- Auto Repair/Sell --
    ["AUTOREPAIRITEMS"]               = "Off",
    ["AUTOSELLJUNK"]                  = false,
    ["AUTOSELLJUNKCONFIRM"]           = false,
    ["AUTODESTROY0VALUEITEMSKEYBIND"] = false,
    ["AUTODESTROY0VALUEITEMS"]        = false,
    ["AUTODESTROY0VALUEITEMSCONFIRM"] = true,
    ["AUTOSELLFENCE"]                 = false,
    ["AUTOSELLFENCECONFIRM"]          = true,
    
-- Text Filters --
    ["WHITELIST"] = {},
    ["BLACKLIST"] = {},

-- KEEP Filter Settings --
    ["KEEPATORABOVEVALUE"] = 0,
    ["KEEPUNIQUEITEMS"]    = true,
    ["KEEPSETITEMS"]       = false,
    ["KEEPPETITEMS"]       = true,
    ["KEEPQUESTITEMS"]     = true,
    ["KEEPCRAFTEDITEMS"]   = true,
    
-- Icon Settings --
    ["ICONSRESEARCHPLAYER"] = true,
    ["ICONSRECIPEPLAYER"]   = true,
    ["ICONSRESEARCHOTHER"]  = true,
    ["ICONSRECIPEOTHER"]    = true,
    --["ICONSOTHER"]        = true,
    
-- Research Settings --
    ["RESEARCHTOOLTIPS"]                    = true,
    ["SAVEUNRESEARCHEDTRAITSBLACKSMITHING"] = false,
    ["SAVEUNRESEARCHEDTRAITSCLOTHIER"]      = false,
    ["SAVEUNRESEARCHEDTRAITSWOODWORKING"]   = false,
    ["SAVEUNKNOWNRECIPES"]                  = false,
    ["SAVEUNKNOWNSOTHER"]                   = false,
    
-- Must be included for stolen items to be handled by the addon:
    [ITEMTYPE_NONE] = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL},	-- not an item
    
-- Random Submenu Options (in order) --
    ["SELLZEROVALUEITEMS"] = false,
    ["ORNATETRAITITEMS"]   = false,
    [ITEMTYPE_TRASH]       = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Trash Items"},
    [ITEMTYPE_FOOD]        = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Food"},
    [ITEMTYPE_DRINK]       = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Drinks"},
    [ITEMTYPE_LURE]        = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Lures"},
    [ITEMTYPE_POTION]      = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Potions"},
    [ITEMTYPE_RECIPE]      = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Recipes"},
    
    [ITEMTYPE_TOOL] = {["lockpicks"] = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Lockpicks"}, ["repairKits"] = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Repair Kits"}},
    
    [ITEMTYPE_TREASURE] = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Treasure"}, 
    [ITEMTYPE_TROPHY]   = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Trophies"}, -- includes Treasure Maps ? Does it still since they added ITEMTYPE_TREASURE?
    [ITEMTYPE_FISH]     = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Fish"},
    ["STOLEN_ITEMS"]    = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Stolen Items"},
    ["EXCLUDE_EQUIPABLE_STOLEN"] = false,
    [ITEMTYPE_SOUL_GEM] = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Soul Gems"},
    --[[
    [ITEMTYPE_COLLECTIBLE] = false,
    --]]
    [ITEMTYPE_COLLECTIBLE]        = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Collectibles"},
    [ITEMTYPE_CONTAINER]          = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Containers"},
    [ITEMTYPE_RACIAL_STYLE_MOTIF] = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Motifs"},
     
-- Armor Submenu Options --
    ["ZEROVALUEARMOR"] = false,
    [ITEMTYPE_ARMOR] = {
        ["JUNK"]            = false,
        ["QUALITY"]         = ITEM_QUALITY_NORMAL,
        ["FILTERNAME"]      = "Junk All Armor",
        [ARMORTYPE_NONE]    = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Jewelry"},
        [ARMORTYPE_LIGHT]   = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Light Armor"},
        [ARMORTYPE_MEDIUM]  = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Medium Armor"},
        [ARMORTYPE_HEAVY]   = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Heavy Armor"},
    },

-- Weapons Submenu Options --
    ["ZEROVALUEWEAPONS"] = false,
-- IsJunk, Quality limit for junk, Research Line Index --
    [ITEMTYPE_WEAPON] = {
        ["JUNK"] = false,
        ["QUALITY"] = ITEM_QUALITY_NORMAL,
        ["FILTERNAME"] = "Junk All Weapons",
        [WEAPONTYPE_SHIELD]            = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Shields"},
        [WEAPONTYPE_AXE]               = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk One-Handed Axes"},
        [WEAPONTYPE_DAGGER]            = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Daggers"},
        [WEAPONTYPE_HAMMER]            = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk One-Handed Hammers"},
        [WEAPONTYPE_SWORD]             = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk One-Handed Swords"},
        [WEAPONTYPE_TWO_HANDED_AXE]    = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Two-Handed Axes"},
        [WEAPONTYPE_TWO_HANDED_HAMMER] = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Two-Handed Hammers"},
        [WEAPONTYPE_TWO_HANDED_SWORD]  = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Two-Handed Swords"},
        [WEAPONTYPE_BOW]               = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Bows"},
        [WEAPONTYPE_FIRE_STAFF]        = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Flame Staves"},
        [WEAPONTYPE_FROST_STAFF]       = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Frost Staves"},
        [WEAPONTYPE_LIGHTNING_STAFF]   = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Lightning Staves"},
        [WEAPONTYPE_HEALING_STAFF]     = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Healing Staves"},
        [WEAPONTYPE_NONE]              = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk No Filter Exists"},
        [WEAPONTYPE_RUNE]              = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk No Filter Exists"},
        [WEAPONTYPE_PROP]              = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk No Filter Exists"},
    },
      
-- Style Material Filters
    [ITEMTYPE_STYLE_MATERIAL] = {
        ["JUNK"] = false, 
        ["QUALITY"] = ITEM_QUALITY_LEGENDARY,
        ["FILTERNAME"] = "Junk All Style Material",
        [ITEMSTYLE_NONE] 				= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk No Filter Exists for ItemStyle None"},
        [ITEMSTYLE_RACIAL_ARGONIAN] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Flint (Argonian)"},
        [ITEMSTYLE_RACIAL_BRETON] 		= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Molybdenum (Breton)"},
        [ITEMSTYLE_RACIAL_DARK_ELF] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Obsidian (Dunmer)"},
        [ITEMSTYLE_RACIAL_HIGH_ELF] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Adamantite (Altmer)"},
        [ITEMSTYLE_RACIAL_KHAJIIT] 		= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Moonstone (Khajit)"},
        [ITEMSTYLE_RACIAL_NORD] 		= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Corundum (Nord)"},
        [ITEMSTYLE_RACIAL_ORC] 			= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Manganese (Orc)"},
        [ITEMSTYLE_RACIAL_REDGUARD] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Starmetal (Redguard)"},
        [ITEMSTYLE_RACIAL_WOOD_ELF] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Bone (Bosmer)"},
        [ITEMSTYLE_AREA_ANCIENT_ELF] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Palladium (Ancient Elf)"},
        [ITEMSTYLE_AREA_REACH] 			= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Copper (Barbaric)"},
        [ITEMSTYLE_ENEMY_PRIMITIVE] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Argentum (Primal)"},
        [ITEMSTYLE_ENEMY_DAEDRIC] 		= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Daedra Heart (Daedric)"},
        [ITEMSTYLE_RACIAL_IMPERIAL] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Nickel (Imperial)"},
        [ITEMSTYLE_AREA_DWEMER]	 		= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Dwemer Frame (Dwemer)"},
        
        
        [ITEMSTYLE_GLASS] 				= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Malachite (Glass)"},
        [ITEMSTYLE_AREA_XIVKYN]			= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Charcole of Remorse (Xivkyn)"},
        [ITEMSTYLE_AREA_ANCIENT_ORC]	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Cassiterite (Anchient Orc)"},
        [ITEMSTYLE_UNDAUNTED]			= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Laurel (Mercenary)"},
        [ITEMSTYLE_AREA_AKAVIRI]		= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Goldscale (Akaviri)"},
    },
    
-- Armor Trait Filters
    [ITEMTYPE_ARMOR_TRAIT] = {
        ["JUNK"] = false, 
        ["QUALITY"] = ITEM_QUALITY_LEGENDARY,
        ["FILTERNAME"] = "Junk All Armor Traits",
        [ITEM_TRAIT_TYPE_ARMOR_TRAINING] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Emeralds (Training)"},
        [ITEM_TRAIT_TYPE_ARMOR_STURDY] 		= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Quartz (Sturdy)"},
        [ITEM_TRAIT_TYPE_ARMOR_EXPLORATION] = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Garnets (Exploration)"},
        [ITEM_TRAIT_TYPE_ARMOR_DIVINES] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Sapphires (Divine)"},
        [ITEM_TRAIT_TYPE_ARMOR_IMPENETRABLE] = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Diamonds (Impenetrable)"},
        [ITEM_TRAIT_TYPE_ARMOR_WELL_FITTED] = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Almandine (Well-Fitted)"},
        [ITEM_TRAIT_TYPE_ARMOR_INFUSED] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Bloodstones (Infused)"},
        [ITEM_TRAIT_TYPE_ARMOR_REINFORCED] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Sardonyx (Reinforced)"},
        [ITEM_TRAIT_TYPE_ARMOR_NIRNHONED] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Fortified Nirncrux (Nirnhoned)"},
    },
    
-- Weapon Trait Filters
    [ITEMTYPE_WEAPON_TRAIT] = {
        ["JUNK"] = false, 
        ["QUALITY"] = ITEM_QUALITY_LEGENDARY,
        ["FILTERNAME"] = "Junk Weapon Traits",
        [ITEM_TRAIT_TYPE_WEAPON_INFUSED] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Jade (Infused)"},
        [ITEM_TRAIT_TYPE_WEAPON_DEFENDING] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Turquoise (Defending)"},
        [ITEM_TRAIT_TYPE_WEAPON_PRECISE] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Rubies (Precise)"},
        [ITEM_TRAIT_TYPE_WEAPON_WEIGHTED] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Citrine (Weighted)"},
        [ITEM_TRAIT_TYPE_WEAPON_SHARPENED] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Fire Opals (Sharpened)"},
        [ITEM_TRAIT_TYPE_WEAPON_TRAINING] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Carnelian (Training)"},
        [ITEM_TRAIT_TYPE_WEAPON_POWERED] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Chysolite (Powered)"},
        [ITEM_TRAIT_TYPE_WEAPON_CHARGED] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Amethysts (Charged)"},
        [ITEM_TRAIT_TYPE_WEAPON_NIRNHONED] 	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Potent Nirncrux (Nirnhoned)"},
    },
    
-- Crafting Submenu Options --
    ["ITEMTYPE_ALL_CRAFTING_MATERIALS"]		= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk All Crafting Materials"},
    
-- Glphys Submenu Options --
    [ITEMTYPE_GLYPH_ARMOR]		= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Armor Glyphs"},
    [ITEMTYPE_GLYPH_WEAPON]		= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Weapon Glyphs"},
    [ITEMTYPE_GLYPH_JEWELRY]	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Jewelry Glyphs"},

-- Alchemy SubMenu
    [ITEMTYPE_REAGENT]     = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Reagents"},
    [ITEMTYPE_POTION_BASE] = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Potion Solvents"},
    [ITEMTYPE_POISON_BASE] = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_LEGENDARY, ["FILTERNAME"] = "Junk Poison Solvents"},

-- Alchemy SubMenu
    [ITEMTYPE_BLACKSMITHING_MATERIAL]		= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Blacksmithing Materials"},
    [ITEMTYPE_BLACKSMITHING_RAW_MATERIAL]	= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Blacksmithing Raw Materials"},
    [ITEMTYPE_BLACKSMITHING_BOOSTER]		= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Blacksmithing Tempers"},
    
-- Alchemy SubMenu
    [ITEMTYPE_CLOTHIER_MATERIAL]			= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Clothier Materials"},
    [ITEMTYPE_CLOTHIER_RAW_MATERIAL]		= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Clothier Raw Materials"},
    [ITEMTYPE_CLOTHIER_BOOSTER]				= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Clothier Resins"},
    
-- Alchemy SubMenu
    [ITEMTYPE_ENCHANTING_RUNE_ASPECT]		= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Aspect Runestones"},
    [ITEMTYPE_ENCHANTING_RUNE_ESSENCE]		= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Essence Runestones"},
    [ITEMTYPE_ENCHANTING_RUNE_POTENCY]		= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Potency Runestones"},
    [ITEMTYPE_ENCHANTMENT_BOOSTER]			= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk enchantment booster filter does not exist"},	-- Stuff used to upgrade items..you can't upgrade runes..whats this for ???
    
-- Provisioning SubMenu
    [ITEMTYPE_INGREDIENT] 			 		= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Ingredients"},
    [ITEMTYPE_FLAVORING]					= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Flavouring"},
    [ITEMTYPE_SPICE]						= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Spices"},
    
-- Alchemy SubMenu
    [ITEMTYPE_WOODWORKING_MATERIAL]			= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Woodworking Materials"},
    [ITEMTYPE_WOODWORKING_RAW_MATERIAL]		= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Woodworking Raw Materials"},
    [ITEMTYPE_WOODWORKING_BOOSTER]			= {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Woodworking Tannins"},	-- Stuff used to upgrade items

-- Jewelrycraft SubMenu
    [ITEMTYPE_JEWELRYCRAFTING_MATERIAL]     = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Jewlery Materials"},
    [ITEMTYPE_JEWELRYCRAFTING_RAW_MATERIAL] = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Jewlery Raw Materials"},
    [ITEMTYPE_JEWELRYCRAFTING_BOOSTER]      = {["JUNK"] = false, ["QUALITY"] = ITEM_QUALITY_NORMAL, ["FILTERNAME"] = "Junk Jewlery Upgrade Grains"},	-- Stuff used to upgrade items

   --[[ 
   
   tyle Name 	Stone Icon 	Stone
Altmer			Adamantite
Ancient Elf		Palladium
Argonian		Flint
Barbaric		Copper
Bosmer			Bone
Breton			Molybdenum
Daedric			Daedra Heart
Dunmer			Obsidian
Imperial		Nickel
   
Khajit			Moonstone
Nord			Corundum
Orc				Manganese
Primal			Argentum
Redguard		Starmetal
   
   
      ["tItemStyleNames"] = table [#35,36]
    [0] = "ITEMSTYLE_NONE"
    [1] = "ITEMSTYLE_RACIAL_BRETON"
    [2] = "ITEMSTYLE_RACIAL_REDGUARD"
    [3] = "ITEMSTYLE_RACIAL_ORC"
    [4] = "ITEMSTYLE_RACIAL_DARK_ELF"	-- Dunmers
    [5] = "ITEMSTYLE_RACIAL_NORD"
    [6] = "ITEMSTYLE_RACIAL_ARGONIAN"
    [7] = "ITEMSTYLE_RACIAL_HIGH_ELF"	-- altimers
    [8] = "ITEMSTYLE_RACIAL_WOOD_ELF"	-- Bosmers
    [9] = "ITEMSTYLE_RACIAL_KHAJIIT"	-- Khajiit
    [15] = "ITEMSTYLE_AREA_ANCIENT_ELF"
    [17] = "ITEMSTYLE_AREA_REACH"		-- Barbarics
    [19] = "ITEMSTYLE_ENEMY_PRIMITIVE"	-- Primals
    [20] = "ITEMSTYLE_ENEMY_DAEDRIC"	-- Daedrics
    [16] = "ITEMSTYLE_AREA_IMPERIAL"	-- Imperials
    
    [11] = "ITEMSTYLE_ORG_THIEVES_GUILD"
    [12] = "ITEMSTYLE_ORG_DARK_BROTHERHOOD"
    [14] = "ITEMSTYLE_AREA_DWEMER"		-- Dwemers
    [18] = "ITEMSTYLE_ENEMY_BANDIT"		-- Bandits
    [27] = "ITEMSTYLE_RAIDS_CRAGLORN"
    [31] = "ITEMSTYLE_ENEMY_DRAUGR"
    [32] = "ITEMSTYLE_ENEMY_MAORMER"
    [33] = "ITEMSTYLE_AREA_AKAVIRI"
    [34] = "ITEMSTYLE_RACIAL_IMPERIAL"
    [35] = "ITEMSTYLE_AREA_YOKUDAN"
--]]
    
     --[[
Altmer			Adamantite
Ancient Elf		Palladium
Argonian		Flint
Barbaric		Copper
Bosmer			Bone
Breton			Molybdenum
Daedric			Daedra Heart
Dunmer			Obsidian
Dwemers			Dwemer Frame
Imperial		Nickel
   
Khajit			Moonstone
Nord			Corundum
Orc				Manganese
Primal			Argentum
Redguard		Starmetal
--]]
    
}
