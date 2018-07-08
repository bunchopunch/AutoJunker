
local LN4R = LibStub:GetLibrary("LibNeed4Research")

local colorRed 			= "|cFF0000" 	-- Red
local colorYellow 		= "|cFFFF00" 	-- yellow 
local colorDrkOrange 	= "|cFFA500"	-- Dark Orange


--======================================================--
--==== Item Type Related ====--
--======================================================--
local textToItemType = {}
local itemTypeToText = {
	[ITEMTYPE_TRASH]			= "Trash",
	[ITEMTYPE_FOOD]				= "Food",
	[ITEMTYPE_DRINK]			= "Drink",
	[ITEMTYPE_LURE]				= "Lure",
	[ITEMTYPE_POTION]			= "Potion",
	[ITEMTYPE_RECIPE]			= "Recipe",
	[ITEMTYPE_TOOL]				= "Tool",
	[ITEMTYPE_TREASURE]			= "Treasure",
	[ITEMTYPE_TROPHY]			= "Trophy",
	[ITEMTYPE_FISH]				= "Fish",
	[ITEMTYPE_ARMOR]			= "Armor",
	[ITEMTYPE_WEAPON]			= "Weapon",
	[ITEMTYPE_STYLE_MATERIAL]	= "Style Material",
	[ITEMTYPE_ARMOR_TRAIT]		= "Trait Material: Armor",
	[ITEMTYPE_WEAPON_TRAIT]		= "Trait Material: Weapon",
	[ITEMTYPE_GLYPH_ARMOR]		= "Glyph: Armor",
	[ITEMTYPE_GLYPH_WEAPON]		= "Glyph: Weapon",
	[ITEMTYPE_GLYPH_JEWELRY]	= "Glyph: Jewelry",
	[ITEMTYPE_REAGENT]			= "Alchemy: Reagent",
	[ITEMTYPE_POISON_BASE]					= "Alchemy: Poison Solvent",
	[ITEMTYPE_POTION_BASE]					= "Alchemy: Potion Solvent",
	[ITEMTYPE_BLACKSMITHING_MATERIAL]		= "Blacksmithing: Materials",
	[ITEMTYPE_BLACKSMITHING_RAW_MATERIAL]	= "Blacksmithing: Raw Materials",
	[ITEMTYPE_BLACKSMITHING_BOOSTER]		= "Blacksmithing: Tempers",
	[ITEMTYPE_CLOTHIER_MATERIAL]			= "Clothier: Materials",
	[ITEMTYPE_CLOTHIER_RAW_MATERIAL]		= "Clothier: Raw Materials",
	[ITEMTYPE_CLOTHIER_BOOSTER]				= "Clothier: Resins",
	[ITEMTYPE_ENCHANTING_RUNE_ASPECT]		= "Rune: Aspect",
	[ITEMTYPE_ENCHANTING_RUNE_ESSENCE]		= "Rune: Essence",
	[ITEMTYPE_ENCHANTING_RUNE_POTENCY]		= "Rune: Potency",
	[ITEMTYPE_INGREDIENT]					= "Provisioning: Ingredient",
	[ITEMTYPE_FLAVORING]					= "Provisioning: Flavoring",
	[ITEMTYPE_SPICE]						= "Provisioning: Spice",
	[ITEMTYPE_WOODWORKING_MATERIAL]			= "Woodworking: Material",
	[ITEMTYPE_WOODWORKING_RAW_MATERIAL]		= "Woodworking: Raw Material",
	[ITEMTYPE_WOODWORKING_BOOSTER ]			= "Woodworking: Tannin",
    [ITEMTYPE_JEWELRYCRAFTING_MATERIAL]     = "Jewelrycraft: Material",
    [ITEMTYPE_JEWELRYCRAFTING_RAW_MATERIAL] = "Jewelrycraft: Raw Material",
    [ITEMTYPE_JEWELRYCRAFTING_BOOSTER]      = "Jewelrycraft: Upgrade Grains",
	[ITEMTYPE_RACIAL_STYLE_MOTIF]			= "Motif",
	[ITEMTYPE_COSTUME]			= "Costume",
	[ITEMTYPE_DISGUISE]			= "Disguise",
	[ITEMTYPE_SIEGE]			= "Siege",
	[ITEMTYPE_SOUL_GEM]			= "Soul Gem",
	[ITEMTYPE_AVA_REPAIR]		= "AvA Repair",
	[ITEMTYPE_COLLECTIBLE]		= "Collectible",
	[ITEMTYPE_CONTAINER]		= "Container",
	[ITEMTYPE_POISON]			= "Poison",
	[ITEMTYPE_RAW_MATERIAL]		= "Raw Material",
	[ITEMTYPE_TABARD]			= "Tabard",
	[ITEMTYPE_NONE]				= "None",
	["SHIELDS"]					= "Shields",
}
do
	for ITEMTYPE, itemTypeText in pairs(itemTypeToText) do
		textToItemType[itemTypeText] = ITEMTYPE
	end
end
function AutoJunker.GetAvailableItemTypes()
	local availableItemTypes = {}
	for k,v in pairs(itemTypeToText) do
		table.insert(availableItemTypes, v)
	end
	table.sort(availableItemTypes)
	table.insert(availableItemTypes, 1, "Off")
	
	return availableItemTypes
end
function AutoJunker.GetItemTypeFromString(itemTypeText)
	return textToItemType[itemTypeText] or "Off"
end
function AutoJunker.GetStringFromItemType(itemType)
	return itemTypeToText[itemType] or "Off"
end



--======================================================--
--==== Style Related ====--
--======================================================--
local textToItemStyle = {}
local itemStyleToText = {
	[ITEMSTYLE_RACIAL_ARGONIAN] 	= GetString("SI_ITEMSTYLE", ITEMSTYLE_RACIAL_ARGONIAN),
	[ITEMSTYLE_RACIAL_HIGH_ELF] 	= GetString("SI_ITEMSTYLE", ITEMSTYLE_RACIAL_HIGH_ELF),
	[ITEMSTYLE_AREA_ANCIENT_ELF] 	= GetString("SI_ITEMSTYLE", ITEMSTYLE_AREA_ANCIENT_ELF),
	[ITEMSTYLE_AREA_REACH] 			= GetString("SI_ITEMSTYLE", ITEMSTYLE_AREA_REACH),
	[ITEMSTYLE_RACIAL_WOOD_ELF] 	= GetString("SI_ITEMSTYLE", ITEMSTYLE_RACIAL_WOOD_ELF),
	[ITEMSTYLE_RACIAL_BRETON] 		= GetString("SI_ITEMSTYLE", ITEMSTYLE_RACIAL_BRETON),
	[ITEMSTYLE_ENEMY_DAEDRIC] 		= GetString("SI_ITEMSTYLE", ITEMSTYLE_ENEMY_DAEDRIC),
	[ITEMSTYLE_RACIAL_DARK_ELF] 	= GetString("SI_ITEMSTYLE", ITEMSTYLE_RACIAL_DARK_ELF),
	[ITEMSTYLE_AREA_DWEMER]	 		= GetString("SI_ITEMSTYLE", ITEMSTYLE_AREA_DWEMER),
	[ITEMSTYLE_RACIAL_IMPERIAL] 	= GetString("SI_ITEMSTYLE", ITEMSTYLE_RACIAL_IMPERIAL),
	[ITEMSTYLE_RACIAL_KHAJIIT] 		= GetString("SI_ITEMSTYLE", ITEMSTYLE_RACIAL_KHAJIIT),
	[ITEMSTYLE_RACIAL_NORD] 		= GetString("SI_ITEMSTYLE", ITEMSTYLE_RACIAL_NORD),
	[ITEMSTYLE_RACIAL_ORC] 			= GetString("SI_ITEMSTYLE", ITEMSTYLE_RACIAL_ORC),
	[ITEMSTYLE_ENEMY_PRIMITIVE] 	= GetString("SI_ITEMSTYLE", ITEMSTYLE_ENEMY_PRIMITIVE),
	[ITEMSTYLE_RACIAL_REDGUARD] 	= GetString("SI_ITEMSTYLE", ITEMSTYLE_RACIAL_REDGUARD),
	
	[ITEMSTYLE_GLASS] 				= GetString("SI_ITEMSTYLE", ITEMSTYLE_GLASS),
	[ITEMSTYLE_AREA_XIVKYN]			= GetString("SI_ITEMSTYLE", ITEMSTYLE_AREA_XIVKYN),
	[ITEMSTYLE_AREA_ANCIENT_ORC]	= GetString("SI_ITEMSTYLE", ITEMSTYLE_AREA_ANCIENT_ORC),
	[ITEMSTYLE_UNDAUNTED]			= GetString("SI_ITEMSTYLE", ITEMSTYLE_UNDAUNTED),
	[ITEMSTYLE_AREA_AKAVIRI]		= GetString("SI_ITEMSTYLE", ITEMSTYLE_AREA_AKAVIRI),
}
--zo_strformat("<<m:1>>", GetString("SI_ITEMSTYLE", ITEMSTYLE_RACIAL_REDGUARD)),
do
	for ITEMSTYLE,itemStyleText in pairs(itemStyleToText) do
		textToItemStyle[itemStyleText] = ITEMSTYLE
	end
end
	--zo_strformat("<<m:1>>", GetString("SI_ITEMSTYLE", style))
function AutoJunker.GetAvailableStyles()
	local availableStyles = {}
	for k,v in pairs(itemStyleToText) do
		table.insert(availableStyles, v)
	end
	table.sort(availableStyles)
	table.insert(availableStyles, 1, "Off")
	return availableStyles
end
function AutoJunker.GetStyleFromStyleText(itemStyleText)
	return textToItemStyle[itemStyleText] or "Off"
end
function AutoJunker.GetTextFromStyle(itemStyle)
	return itemStyleToText[itemStyle] or "Off"
end

--======================================================--
--==== Armor Equip Type Related ====--
--======================================================--
local textToArmorEquipType = {}
local armorEquipTypeToText = {
	[EQUIP_TYPE_CHEST]		= "Chest",
	[EQUIP_TYPE_COSTUME]	= "Costume",
	[EQUIP_TYPE_FEET]		= "Feet",
	[EQUIP_TYPE_HAND]		= "Hand",
	[EQUIP_TYPE_HEAD]		= "Head",
	[EQUIP_TYPE_LEGS]		= "Legs",
	[EQUIP_TYPE_NECK]		= "Neck",
	[EQUIP_TYPE_RING]		= "Ring",
	[EQUIP_TYPE_SHOULDERS]	= "Shoulders",
	[EQUIP_TYPE_WAIST]		= "Waist",
}
do
	for EQUIPTYPE,equipTypeText in pairs(armorEquipTypeToText) do
		textToArmorEquipType[equipTypeText] = EQUIPTYPE
	end
end


--======================================================--
--==== Weapon Equip Type Related ====--
--======================================================--
local textToWeaponEquipType = {}
local weaponEquipTypeToText = {
	[EQUIP_TYPE_MAIN_HAND]	= "Main Hand",
	[EQUIP_TYPE_TWO_HAND]	= "Two Handed",
	[EQUIP_TYPE_OFF_HAND]	= "Off Hand", 
	[EQUIP_TYPE_ONE_HAND]	= "One Hand",
}
do
	for EQUIPTYPE,equipTypeText in pairs(weaponEquipTypeToText) do
		textToWeaponEquipType[equipTypeText] = EQUIPTYPE
	end
end

--======================================================--
--====  Equip Type Shared  ====--
--======================================================--
function AutoJunker.GetAvailableEquipTypes(itemType)
	local availableEquipTypes= {}
	local source
	
	if itemType == ITEMTYPE_ARMOR then
		source = armorEquipTypeToText
	elseif itemType == ITEMTYPE_WEAPON then
		source = weaponEquipTypeToText
	end
	if source then 
		for k,v in pairs(source) do
			table.insert(availableEquipTypes, v)
		end
		table.sort(availableEquipTypes)
	end
	table.insert(availableEquipTypes, 1, "Off")
	
	return availableEquipTypes
end
function AutoJunker.GetEquipTypeFromText(itemType, equipTypeText)
	if itemType == ITEMTYPE_ARMOR then
		return textToArmorEquipType[equipTypeText] or "Off"
	elseif itemType == ITEMTYPE_WEAPON then
		return textToWeaponEquipType[equipTypeText] or "Off"
	end
	return "Off"
end
function AutoJunker.GetTextFromEquipType(itemType, equipType)
	if itemType == ITEMTYPE_ARMOR then
		return armorEquipTypeToText[equipType] or "Off"
	elseif itemType == ITEMTYPE_WEAPON then
		return weaponEquipTypeToText[equipType] or "Off"
	end
	return "Off"
end


--======================================================--
--==== Armor Type Related ====--
--======================================================--
local textToArmorType = {}
local armorTypeToText = {
    [ARMORTYPE_HEAVY]	= "Heavy",
    [ARMORTYPE_LIGHT]	= "Light",
    [ARMORTYPE_MEDIUM]	= "Medium",
    [ARMORTYPE_NONE] 	= "None (Jewelry & Cosmetic Items)",
}
do
	for ARMORTYPE,armorTypeText in pairs(armorTypeToText) do
		textToArmorType[armorTypeText] = ARMORTYPE
	end
end

--======================================================--
--==== Weapon Type Related ====--
--======================================================--
local textToWeaponType = {}
local weaponTypeToText = {
    [WEAPONTYPE_AXE]				= "Axe",
    [WEAPONTYPE_BOW]				= "Bow",
    [WEAPONTYPE_DAGGER]				= "Dagger",
    [WEAPONTYPE_FIRE_STAFF]			= "Fire Staff",
    [WEAPONTYPE_FROST_STAFF]		= "Frost Staff",
    [WEAPONTYPE_HAMMER]				= "Hammer",
    [WEAPONTYPE_HEALING_STAFF]		= "Healing Staff",
    [WEAPONTYPE_LIGHTNING_STAFF]	= "Lightning Staff",
    [WEAPONTYPE_SHIELD]				= "Shield",
    [WEAPONTYPE_SWORD]				= "Sword",
    [WEAPONTYPE_TWO_HANDED_AXE]		= "Two Handed Axe",
    [WEAPONTYPE_TWO_HANDED_HAMMER]	= "Two Handed Hammer",
    [WEAPONTYPE_TWO_HANDED_SWORD] 	= "Two Handed Sword",
}
do
	for WEAPONTYPE, weaponTypeText in pairs(weaponTypeToText) do
		textToWeaponType[weaponTypeText] = WEAPONTYPE
	end
end
--======================================================--
--==== Sub Type Shared ====--
--======================================================--
function AutoJunker.GetAvailableSubTypes(itemType)
	local availableSubTypes= {}
	local source
	
	if itemType == ITEMTYPE_ARMOR then
		source = armorTypeToText
	elseif itemType == ITEMTYPE_WEAPON then
		source = weaponTypeToText
	end
	if source then
		for k,v in pairs(source) do
			table.insert(availableSubTypes, v)
		end
		table.sort(availableSubTypes) 
	end
	table.insert(availableSubTypes, 1, "Off")
	
	return availableSubTypes
end
function AutoJunker.GetSubTypeFromText(itemType, subTypeText)
	if itemType == ITEMTYPE_ARMOR then
		return textToArmorType[subTypeText] or "Off"
	elseif itemType == ITEMTYPE_WEAPON then
		return textToWeaponType[subTypeText] or "Off"
	end
	return "Off"
end
function AutoJunker.GetTextFromSubType(itemType, subType)
	if itemType == ITEMTYPE_ARMOR then
		return armorTypeToText[subType] or "Off"
	elseif itemType == ITEMTYPE_WEAPON then
		return weaponTypeToText[subType] or "Off"
	end
	return "Off"
end


--======================================================--
--==== Armor Trait Type Related ====--
--======================================================--
local textToArmorTraitType = {}
local armorTraitTypeToText = {
	[ITEM_TRAIT_TYPE_NONE]					= colorRed.."No Trait|r",
	[ITEM_TRAIT_TYPE_ARMOR_TRAINING] 		= GetItemQualityColor(ITEM_QUALITY_ARCANE):Colorize("Armor: Training"),
	[ITEM_TRAIT_TYPE_ARMOR_STURDY] 			= GetItemQualityColor(ITEM_QUALITY_ARCANE):Colorize("Armor: Sturdy"),
	[ITEM_TRAIT_TYPE_ARMOR_EXPLORATION] 	= GetItemQualityColor(ITEM_QUALITY_ARCANE):Colorize("Armor: Exploration"),
	[ITEM_TRAIT_TYPE_ARMOR_DIVINES] 		= GetItemQualityColor(ITEM_QUALITY_ARCANE):Colorize("Armor: Divine"),
	[ITEM_TRAIT_TYPE_ARMOR_IMPENETRABLE]	= GetItemQualityColor(ITEM_QUALITY_ARCANE):Colorize("Armor: Impenetrable"),
	[ITEM_TRAIT_TYPE_ARMOR_WELL_FITTED] 	= GetItemQualityColor(ITEM_QUALITY_ARCANE):Colorize("Armor: Well-Fitted"),
	[ITEM_TRAIT_TYPE_ARMOR_INFUSED] 		= GetItemQualityColor(ITEM_QUALITY_ARCANE):Colorize("Armor: Infused"),
	[ITEM_TRAIT_TYPE_ARMOR_REINFORCED] 		= GetItemQualityColor(ITEM_QUALITY_ARCANE):Colorize("Armor: Reinforced"),
	[ITEM_TRAIT_TYPE_ARMOR_NIRNHONED] 		= GetItemQualityColor(ITEM_QUALITY_ARCANE):Colorize("Armor: Nirnhoned"),
    [ITEM_TRAIT_TYPE_ARMOR_INTRICATE]		= GetItemQualityColor(ITEM_QUALITY_ARCANE):Colorize("Armor: Intricate"),
    [ITEM_TRAIT_TYPE_ARMOR_ORNATE]			= GetItemQualityColor(ITEM_QUALITY_ARCANE):Colorize("Armor: Ornate"),
	[ITEM_TRAIT_TYPE_JEWELRY_ARCANE]	= GetItemQualityColor(ITEM_QUALITY_LEGENDARY):Colorize("Jewelry: Arcane"),
	[ITEM_TRAIT_TYPE_JEWELRY_HEALTHY]	= GetItemQualityColor(ITEM_QUALITY_LEGENDARY):Colorize("Jewelry: Healthy"),
	[ITEM_TRAIT_TYPE_JEWELRY_ORNATE]	= GetItemQualityColor(ITEM_QUALITY_LEGENDARY):Colorize("Jewelry: Ornate"),
	[ITEM_TRAIT_TYPE_JEWELRY_ROBUST]	= GetItemQualityColor(ITEM_QUALITY_LEGENDARY):Colorize("Jewelry: Robust"),
}
do
	for TRAITTYPE, traitTypeText in pairs(armorTraitTypeToText) do
		textToArmorTraitType[traitTypeText] = TRAITTYPE
	end
end

--======================================================--
--==== Weapon Trait Type Related ====--
--======================================================--
local textToWeaponTraitType = {}
local weaponTraitTypeToText = {
	[ITEM_TRAIT_TYPE_NONE]					= colorRed.."No Trait|r",
	[ITEM_TRAIT_TYPE_WEAPON_INFUSED] 		= GetItemQualityColor(ITEM_QUALITY_ARTIFACT):Colorize("Weapon: Infused"),
	[ITEM_TRAIT_TYPE_WEAPON_DEFENDING] 		= GetItemQualityColor(ITEM_QUALITY_ARTIFACT):Colorize("Weapon: Defending"),
	[ITEM_TRAIT_TYPE_WEAPON_PRECISE] 		= GetItemQualityColor(ITEM_QUALITY_ARTIFACT):Colorize("Weapon: Precise"),
	[ITEM_TRAIT_TYPE_WEAPON_WEIGHTED] 		= GetItemQualityColor(ITEM_QUALITY_ARTIFACT):Colorize("Weapon: Weighted"),
	[ITEM_TRAIT_TYPE_WEAPON_SHARPENED] 		= GetItemQualityColor(ITEM_QUALITY_ARTIFACT):Colorize("Weapon: Sharpened"),
	[ITEM_TRAIT_TYPE_WEAPON_TRAINING] 		= GetItemQualityColor(ITEM_QUALITY_ARTIFACT):Colorize("Weapon: Training"),
	[ITEM_TRAIT_TYPE_WEAPON_POWERED] 		= GetItemQualityColor(ITEM_QUALITY_ARTIFACT):Colorize("Weapon: Powered"),
	[ITEM_TRAIT_TYPE_WEAPON_CHARGED] 		= GetItemQualityColor(ITEM_QUALITY_ARTIFACT):Colorize("Weapon: Charged"),
	[ITEM_TRAIT_TYPE_WEAPON_NIRNHONED] 		= GetItemQualityColor(ITEM_QUALITY_ARTIFACT):Colorize("Weapon: Nirnhoned"),
	[ITEM_TRAIT_TYPE_WEAPON_INTRICATE]		= GetItemQualityColor(ITEM_QUALITY_ARTIFACT):Colorize("Weapon: Intricate"),
	[ITEM_TRAIT_TYPE_WEAPON_ORNATE]			= GetItemQualityColor(ITEM_QUALITY_ARTIFACT):Colorize("Weapon: Ornate"),
}
do
	for TRAITTYPE, traitTypeText in pairs(weaponTraitTypeToText) do
		textToWeaponTraitType[traitTypeText] = TRAITTYPE
	end
end

--======================================================--
--==== Shared Trait Type Related ====--
--======================================================--
function AutoJunker.GetAvailableTraitTypes(itemType)
	local availableSubTypes = {}
	local source
	
	if itemType == ITEMTYPE_ARMOR or itemType == "SHIELDS" then
		source = armorTraitTypeToText
	elseif itemType == ITEMTYPE_WEAPON then
		source = weaponTraitTypeToText
	end
	if source then 
		for k,v in pairs(source) do
			table.insert(availableSubTypes, v)
		end
		table.sort(availableSubTypes)
	end
	table.insert(availableSubTypes, 1, "Off")
	
	return availableSubTypes
end
function AutoJunker.GetTraitTypeFromText(itemType, traitTypeText)
	if itemType == ITEMTYPE_ARMOR or itemType == "SHIELDS" then
		return textToArmorTraitType[traitTypeText] or "Off"
	elseif itemType == ITEMTYPE_WEAPON then
		return textToWeaponTraitType[traitTypeText] or "Off"
	end
	return "Off"
end
function AutoJunker.GetTextFromTraitType(itemType, traitType)
	if itemType == ITEMTYPE_ARMOR or itemType == "SHIELDS" then
		return armorTraitTypeToText[traitType] or "Off"
	elseif itemType == ITEMTYPE_WEAPON then
		return weaponTraitTypeToText[traitType] or "Off"
	end
	return "Off"
end

--======================================================--
--==== Potion Crafted Type Related ====--
--======================================================--


--=========================================================--
--===============  Is Junk Filters  ======================--
--=========================================================--

local function MatchesText(tItemInfo, advancedFilter)
	local textToMatch 	= advancedFilter.textMatch

	if textToMatch and textToMatch ~= "" then
		local lowerItemName 	= string.lower(tItemInfo.NAME)
		local lowerFilterName 	= string.lower(textToMatch)
		if not lowerItemName:find(lowerFilterName) then
			return false
		end
	end
	return true
end
local function MatchesSellPrices(tItemInfo, advancedFilter)
	local minSellPrice 	= advancedFilter.minValue
	local maxSellPrice	= advancedFilter.maxValue
	local sellPrice = tItemInfo.SELLPRICE
	
	if minSellPrice ~= -1 and sellPrice < minSellPrice then
		return false
	end
	if maxSellPrice ~= -1 and sellPrice > maxSellPrice then
		return false
	end
	return true
end
local function MatchesQualities(tItemInfo, advancedFilter)
	local minQuality	= advancedFilter.minQuality
	local maxQuality	= advancedFilter.maxQuality
	local quality 		= tItemInfo.QUALITY
	
	if minQuality  ~= "Off" and quality < minQuality then
		return false
	end
	if maxQuality  ~= "Off" and quality > maxQuality then
		return false
	end
	return true
end
local function MatchesLevels(tItemInfo, advancedFilter)
	local minLevel	= advancedFilter.minLevel
	local maxLevel	= advancedFilter.maxLevel
	local level 	= tItemInfo.LEVEL
	local vetRank 	= tItemInfo.VETRANK
	
	-- If the minimum level filter is turned on:
	if minLevel ~= -1 then
		if vetRank > 0 then
			-- If its a vet item
			if vetRank < (minLevel - 50) then return false end
		else
			-- If its not a vet item
			if level < minLevel then return false end
		end
	end
	
	-- If the maximum level filter is turned on:
	if maxLevel ~= -1 then
		if vetRank > 0 then
			-- If its a vet item
			if vetRank > (maxLevel - 50) then return false end
		else
			-- If its not a vet item
			if level > maxLevel then return false end
		end
	end
	return true
end
local function MatchesItemType(tItemInfo, advancedFilter)
	local itemType 	= advancedFilter.itemType
	if itemType == "Off" then return true end
	
	-- special exception for shields
	-- I want ALL shield checks to occur in this first check
	-- This will prevent any shield from skipping the first check & going
	-- into the second check and matching an itemType filter of type "weapons"
	if tItemInfo.SUBTYPE == WEAPONTYPE_SHIELD then
		-- Only allow the "Shields" filter to match here
		-- Excludes matching the "weapons" filter
		if itemType ~= "SHIELDS" then return false end
		if tItemInfo.ITEMTYPE ~= ITEMTYPE_WEAPON then
			return false
		end
		return true
	end
	
	-- check all the other item types:
	-- Shields should never make it here
	if itemType ~= tItemInfo.ITEMTYPE then
		return false
	end
	return true
end
local function MatchesSetItem(tItemInfo, advancedFilter)
	local setItem 	= advancedFilter.setItem
	if setItem == "Off" then return true end
	
	local isSetItem = GetItemLinkSetInfo(tItemInfo["LINK"])
	
	if setItem == "Set Item" and not isSetItem then return false end
	if setItem == "Not a Set Item" and isSetItem then return false end
	
	return true
end
local function MatchesCraftedPotion(tItemInfo, advancedFilter)
	local potionType = advancedFilter.potions
	local iLink = tItemInfo["LINK"]
	
	if potionType == "Off" then return true end
	if tItemInfo.ITEMTYPE ~= ITEMTYPE_POTION then return false end
	
	local isCraftedPotion = select(24, ZO_LinkHandler_ParseLink(iLink)) ~= "0"
	
	if potionType == "All Potions" then return true end
	if potionType == "Crafted Potions" and isCraftedPotion then return true end
	if potionType == "Non-Crafted Potions" and not isCraftedPotion then return true end
	
	return false
end
local function MatchesSubType(tItemInfo, advancedFilter)
	local subType = advancedFilter.subType
	
	if subType ~= "Off" and subType ~= tItemInfo.SUBTYPE then
		return false
	end
	return true
end
local function MatchesEquipType(tItemInfo, advancedFilter)
	local equipType = advancedFilter.equipType
	
	if equipType ~= "Off" and equipType ~= tItemInfo.EQUIPTYPE then
		return false
	end
	return true
end
local function MatchesStyle(tItemInfo, advancedFilter)
	local style = advancedFilter.style
	
	if style ~= "Off" and style ~= tItemInfo.STYLE then
		return false
	end
	return true
end
local function MatchesTrait(tItemInfo, advancedFilter)
	local trait = advancedFilter.traitType
	if trait == "Off" then return true end
	
	local itemTrait = GetItemLinkTraitInfo(tItemInfo["LINK"])
	
	if trait ~= itemTrait then
		return false
	end
	return true
end
local function MatchesResearch(tItemInfo, advancedFilter)
	local research = advancedFilter.research
	
	if research ~= "Off" then
		local tNeedInfo = AutoJunker.KeepForResearch(tItemInfo["LINK"])
		if research == "Needed For Research" and not tNeedInfo then return false end
		if research == "Not Needed For Research" and tNeedInfo then return false end
	end
	return true
end
local function MatchesStolen(tItemInfo, advancedFilter)
	local stolenFilter = advancedFilter.stolen
	local itemIsStolen = tItemInfo.STOLEN
	
	if stolenFilter == "Stolen" and not itemIsStolen then
		return false
	elseif stolenFilter == "Not Stolen" and itemIsStolen then
		return false
	end
	return true
end

local function MatchesUnique(tItemInfo, advancedFilter)
	local uniqueFilter = advancedFilter.unique
	local isItemUnique = IsItemLinkUnique(tItemInfo["LINK"])
	
	if uniqueFilter == "Unique" and not isItemUnique then
		return false
	elseif uniqueFilter== "Not Unique" and isItemUnique then
		return false
	end
	return true
end

local function ItemInfoMatchesAdvancedFilter(tItemInfo, advancedFilter)
	if not MatchesCraftedPotion(tItemInfo, advancedFilter) then return false end
	if not MatchesSetItem(tItemInfo, advancedFilter) 	then return false end
	if not MatchesResearch(tItemInfo, advancedFilter) 	then return false end
	if not MatchesStyle(tItemInfo, advancedFilter) 		then return false end
	if not MatchesText(tItemInfo, advancedFilter) 		then return false end
	if not MatchesSellPrices(tItemInfo, advancedFilter) then return false end
	if not MatchesQualities(tItemInfo, advancedFilter) 	then return false end
	if not MatchesLevels(tItemInfo, advancedFilter) 	then return false end
	if not MatchesItemType(tItemInfo, advancedFilter) 	then return false end
	if not MatchesSubType(tItemInfo, advancedFilter) 	then return false end
	if not MatchesEquipType(tItemInfo, advancedFilter) 	then return false end
	if not MatchesTrait(tItemInfo, advancedFilter)		then return false end
	if not MatchesStolen(tItemInfo, advancedFilter) 	then return false end
	if not MatchesUnique(tItemInfo, advancedFilter) 	then return false end
	
	return true
end

function AutoJunker.CheckAdvancedFilters(tItemInfo)
	local advancedFilters = AutoJunker.AccountSavedVariables["ADVANCED_FILTERS"]
	
	-- Ugly hack: I did not think ahead & no one ever mentioned it
	-- The KEEP filters should be checked first in case some filters overlap
	-- It will give the KEEP filters priority..The filters have worked fine for months &
	-- I don't want to change all of the code & table structure, so instead
	-- we'll just loop through twice & do the KEEP filters first
	--[[ Original Code:
	for key, filterTable in pairs(advancedFilters) do
		if ItemInfoMatchesAdvancedFilter(tItemInfo, filterTable) then
			local isJunk
			if filterTable.type == "JUNK" then isJunk = true 
			elseif filterTable.type == "KEEP" then isJunk = false 
			end
			local reason = "Matches the "..colorRed.."Advanced "..filterTable.type.." Filter:|r "..colorYellow..filterTable.name
			return filterTable.type, AutoJunker.FormatJunkDebugMsg(isJunk, tItemInfo.LINK, reason)
		end
	end
	--]]
	-- Check KEEP AF filters first
	for key, filterTable in pairs(advancedFilters) do
		if filterTable.type == "KEEP" then
			if ItemInfoMatchesAdvancedFilter(tItemInfo, filterTable) then
				local reason = "Matches the "..colorRed.."Advanced "..filterTable.type.." Filter:|r "..colorYellow..filterTable.name
				
				return filterTable.type, AutoJunker.FormatJunkDebugMsg(false, tItemInfo.LINK, reason)
			end
		end
	end
	-- Then Check JUNK AF filters
	for key, filterTable in pairs(advancedFilters) do
		if filterTable.type == "JUNK" then
			if ItemInfoMatchesAdvancedFilter(tItemInfo, filterTable) then
				local reason = "Matches the "..colorRed.."Advanced "..filterTable.type.." Filter:|r "..colorYellow..filterTable.name
				
				return filterTable.type, AutoJunker.FormatJunkDebugMsg(true, tItemInfo.LINK, reason)
			end
		end
	end
	return nil
end
