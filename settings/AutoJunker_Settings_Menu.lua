-------------------------------------------------------------------------------------------------
--  This file is used to create the settings menu panel --
-------------------------------------------------------------------------------------------------
--local LAM = LibStub:GetLibrary("LibAddonMenu-2.0")
local LAM2 = LibStub("LibAddonMenu-2.0")
local LII = LibStub:GetLibrary("LibItemInfo-1.0")


function testStuff(bagId, slotId)
    d(tostring(LII:GetItemCraftingSkillType(bagId, slotId)))
end
-------------------------------------------------------------------------------------------------
--  Colors  --
-------------------------------------------------------------------------------------------------
local colorYellow 	= "|cFFFF00" 	-- Yellow
local colorRed 		= "|cFF0000" 	-- Red
local colorGreen 	= "|c00FF00" 	-- green
local colorWhite 	= "|cFFFFFF" 	-- white
local colorMagenta	= "|cFF00FF"	-- Magenta


-------------------------------------------------------------------------------------------------
--  Localized crafting type names  --
-------------------------------------------------------------------------------------------------
local sBlacksmithing 	= LII:GetCraftingSkillTypeLabelName(CRAFTING_TYPE_BLACKSMITHING)
local sClothier 		= LII:GetCraftingSkillTypeLabelName(CRAFTING_TYPE_CLOTHIER)
local sWoodworking 		= LII:GetCraftingSkillTypeLabelName(CRAFTING_TYPE_WOODWORKING)
local sProvisioning 	= LII:GetCraftingSkillTypeLabelName(CRAFTING_TYPE_PROVISIONING)
local sAlchemy			= LII:GetCraftingSkillTypeLabelName(CRAFTING_TYPE_ALCHEMY)
local sEnchanting		= LII:GetCraftingSkillTypeLabelName(CRAFTING_TYPE_ENCHANTING)
-------------------------------------------------------------------------------------------------
--  Get the settings MENU Name of an Item Quality  --
-------------------------------------------------------------------------------------------------
--[[
    "[eng] Normal", -- SI_TRADING_HOUSE_BROWSE_QUALITY_NORMAL
    "[eng] Magic", -- SI_TRADING_HOUSE_BROWSE_QUALITY_MAGIC
    "[eng] Arcane", -- SI_TRADING_HOUSE_BROWSE_QUALITY_ARCANE
    "[eng] Artifact", -- SI_TRADING_HOUSE_BROWSE_QUALITY_ARTIFACT
    "[eng] Legendary", -- SI_TRADING_HOUSE_BROWSE_QUALITY_LEGENDARY
    local tQualityColor = GetItemQualityColor(iItemQuality)
        sQualityName = tQualityColor:Colorize(tItemQualityNames[iItemQuality])
-- GetItemQualityColor(ITEM_QUALITY_MAGIC):Colorize(GetString(SI_TRADING_HOUSE_BROWSE_QUALITY_MAGIC))


    local test = GetItemQualityColor(ITEM_QUALITY_MAGIC):Colorize(GetString(SI_TRADING_HOUSE_BROWSE_QUALITY_MAGIC))
    GetString(SI_TRADING_HOUSE_BROWSE_QUALITY_NORMAL),		-- "Normal", 	-- SI_ITEMQUALITY1
    GetString(SI_TRADING_HOUSE_BROWSE_QUALITY_MAGIC), 		-- "Fine", 		-- SI_ITEMQUALITY2
    GetString(SI_TRADING_HOUSE_BROWSE_QUALITY_ARCANE),		-- "Superior", 	-- SI_ITEMQUALITY3
    GetString(SI_TRADING_HOUSE_BROWSE_QUALITY_ARTIFACT),	-- "Epic", 		-- SI_ITEMQUALITY4
    GetString(SI_TRADING_HOUSE_BROWSE_QUALITY_LEGENDARY),	-- "Legendary", -- SI_ITEMQUALITY5
    --]]
local tQualities = {
    [1] = "Off",
    -- This should not have said "Any Quality" It should have said Trash
    --[2] = GetItemQualityColor(ITEM_QUALITY_TRASH):Colorize(GetString(SI_TRADING_HOUSE_BROWSE_QUALITY_ANY)),
    [2] = GetItemQualityColor(ITEM_QUALITY_TRASH):Colorize(GetString(SI_ITEM_FORMAT_STR_TRASH)),
    [3] = GetItemQualityColor(ITEM_QUALITY_NORMAL):Colorize(GetString(SI_TRADING_HOUSE_BROWSE_QUALITY_NORMAL)),
    [4] = GetItemQualityColor(ITEM_QUALITY_MAGIC):Colorize(GetString(SI_TRADING_HOUSE_BROWSE_QUALITY_MAGIC)),
    [5] = GetItemQualityColor(ITEM_QUALITY_ARCANE):Colorize(GetString(SI_TRADING_HOUSE_BROWSE_QUALITY_ARCANE)),
    [6] = GetItemQualityColor(ITEM_QUALITY_ARTIFACT):Colorize(GetString(SI_TRADING_HOUSE_BROWSE_QUALITY_ARTIFACT)),
    [7] = GetItemQualityColor(ITEM_QUALITY_LEGENDARY):Colorize(GetString(SI_TRADING_HOUSE_BROWSE_QUALITY_LEGENDARY)),
}

local function GetMenuQualityName(_bIsJunk, _iItemQuality)
    --local sMenuQualityName = "Unknown"
    
    if not _bIsJunk 								then return tQualities[1]
    elseif _iItemQuality == ITEM_QUALITY_TRASH		then return tQualities[2]
    elseif _iItemQuality == ITEM_QUALITY_NORMAL		then return tQualities[3]
    elseif _iItemQuality == ITEM_QUALITY_MAGIC 		then return tQualities[4]
    elseif _iItemQuality == ITEM_QUALITY_ARCANE		then return tQualities[5]
    elseif _iItemQuality == ITEM_QUALITY_ARTIFACT	then return tQualities[6]
    elseif _iItemQuality == ITEM_QUALITY_LEGENDARY	then return tQualities[7]
    end
    return sMenuQualityName
end

-------------------------------------------------------------------------------------------------
--  Get the settings MENU VALUE of an Item for a given MENU Name --
-------------------------------------------------------------------------------------------------
local function GetJunkQualityFromMenuSetting(_sMenuQualityName)
    --local iMenuQualityValue = "Unknown"
    
    if 	   _sMenuQualityName == tQualities[1] 	then return false, "Off"	
    elseif _sMenuQualityName == tQualities[2]	then return true, ITEM_QUALITY_TRASH	
    elseif _sMenuQualityName == tQualities[3]	then return true, ITEM_QUALITY_NORMAL	
    elseif _sMenuQualityName == tQualities[4] 	then return true, ITEM_QUALITY_MAGIC 
    elseif _sMenuQualityName == tQualities[5]	then return true, ITEM_QUALITY_ARCANE	
    elseif _sMenuQualityName == tQualities[6] 	then return true, ITEM_QUALITY_ARTIFACT
    elseif _sMenuQualityName == tQualities[7] 	then return true, ITEM_QUALITY_LEGENDARY	
    end
    return false, iMenuQualityValue
end


-------------------------------------------------------------------------------------------------
--  Text Filter Exceptions --
-------------------------------------------------------------------------------------------------
local function TrimToLower(_sText)
    return AutoJunker.Trim(_sText):lower()
end

local function DoesWhitelistTextExist(_sWhitelistText)
    if _sWhitelistText == "" then return end
    local bWhitelistTextFound = false
    
    for k,v in pairs(AutoJunker.SavedVariables["WHITELIST"]) do
        if v == _sWhitelistText then
            bWhitelistTextFound = true
        end
    end
    return bWhitelistTextFound
end

local function DoesBlacklistTextExist(_sBlacklistText)
    if _sBlacklistText == "" then return end
    local bBlacklistTextFound = false
    
    for k,v in pairs(AutoJunker.SavedVariables["BLACKLIST"]) do
        if v == _sBlacklistText then
            bBlacklistTextFound = true
        end
    end
    return bBlacklistTextFound
end

local function AddToWhiteList(_sText)
    if _sText == "" then AutoJunker.ShowErrorDialog("Whitelist", "You must enter text to be added in the text box.") return end
    if DoesWhitelistTextExist(_sText) then AutoJunker.ShowErrorDialog("Whitelist", "Text already exists.") return end
    if DoesBlacklistTextExist(_sText) then AutoJunker.ShowErrorDialog("Whitelist", "Remove the text from the Blacklist and try again.") return end
    
    table.insert(AutoJunker.SavedVariables["WHITELIST"], _sText)
    AutoJunker_WHITELIST_DROPDOWN:UpdateChoices(AutoJunker.SavedVariables["WHITELIST"])
end

local function RemoveFromWhiteList(_sText)
    if _sText == "" then AutoJunker.ShowErrorDialog("Whitelist", "You must select text to be deleted.") return end
    if not DoesWhitelistTextExist(_sText) then return end
    
    for k,v in pairs(AutoJunker.SavedVariables["WHITELIST"]) do
        if v == _sText then
            table.remove(AutoJunker.SavedVariables["WHITELIST"], k)
            AutoJunker_WHITELIST_DROPDOWN:UpdateChoices(AutoJunker.SavedVariables["WHITELIST"])
        end
    end
end

local function AddToBlackList(_sText)
    if _sText == "" then AutoJunker.ShowErrorDialog("Blacklist", "You must enter text to be added in the text box.") return end
    if DoesBlacklistTextExist(_sText) then AutoJunker.ShowErrorDialog("Blacklist", "Text already exists.") return end
    if DoesWhitelistTextExist(_sText) then AutoJunker.ShowErrorDialog("Blacklist", "Remove the text from the Whitelist and try again.") return end
    
    table.insert(AutoJunker.SavedVariables["BLACKLIST"], _sText)
    AutoJunker_BLACKLIST_DROPDOWN:UpdateChoices(AutoJunker.SavedVariables["BLACKLIST"])
end

local function RemoveFromBlackList(_sText)
    if _sText == "" then AutoJunker.ShowErrorDialog("Blacklist", "You must select text to be deleted.") return end
    if not DoesBlacklistTextExist(_sText) then return end
    
    for k,v in pairs(AutoJunker.SavedVariables["BLACKLIST"]) do
        if v == _sText then
            table.remove(AutoJunker.SavedVariables["BLACKLIST"], k)
            AutoJunker_BLACKLIST_DROPDOWN:UpdateChoices(AutoJunker.SavedVariables["BLACKLIST"])
        end
    end
end


-------------------------------------------------------------------------------------------------
--  Profiles --
-------------------------------------------------------------------------------------------------
-- Used in the rare chance that a profile name might disappear from the profile names table, but the profile stays in the profile table, or vice-versa --
local function CleanProfileNamesTable()
    for k,v in pairs(AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE_NAMES"]) do
        local bMatchFound = false 
        for s,t in pairs(AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE"]) do
            if v == t[1] then
                bMatchFound = true
            end
        end
        if not bMatchFound then
            table.remove(AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE_NAMES"], k)
        end
    end
end

local function CleanProfileTable()
    for k,v in pairs(AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE"]) do
        local bMatchFound = false 
        for s,t in pairs(AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE_NAMES"]) do
            if v[1] == t then
                bMatchFound = true
            end
        end
        if not bMatchFound then
            table.remove(AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE"], k)
        end
    end
end

-- This will delete any profile name that does not have a matching profile, or vice-versa --
local function CleanUpProfiles()
    CleanProfileNamesTable()
    CleanProfileTable()
    AutoJunker_PROFILE_DROPDOWN:UpdateChoices(AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE_NAMES"])
end

local function DoesProfileExist(_sProfileName)
    if _sProfileName == "" then return end
    local bProfileNameFound = false
    local bProfileFound = false
    
    for k,v in pairs(AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE_NAMES"]) do
        if v == _sProfileName then
            bProfileNameFound = true
        end
    end
    for k,v in pairs(AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE"]) do
        if v[1] == _sProfileName then
            bProfileFound = true
        end
    end
    if (bProfileFound and (not bProfileNameFound)) or ((not bProfileFound) and bProfileNameFound) then
        AutoJunker.ShowErrorDialog("PROFILE", "Matching profile for selected profile name cannot be found. This profile must have been corrupted. Automated profile clean-up will commence.")
        CleanUpProfiles()
    end
    return bProfileFound
end

local function SaveProfile(_sProfileName)
    local iMaxProfiles = 7
    if _sProfileName == "" then AutoJunker.ShowErrorDialog("Profile", "You must enter a name for your profile.") return end
    if DoesProfileExist(_sProfileName) then AutoJunker.ShowErrorDialog("Profile", "That profile name already exists, choose another name for your profile.") return end
    if #AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE_NAMES"] >= iMaxProfiles then AutoJunker.ShowErrorDialog("Profile", "Maximum number of profiles is"..iMaxProfiles) return end
    local sDisplayName = GetDisplayName()
    local sUnitName = GetUnitName("player")
    
    local tSavedVars = ZO_DeepTableCopy(_G["AutoJunkerSavedVars"]["Default"][sDisplayName][sUnitName])
    
    -- Since the dropdown list box can only take a table with ONLY items in it (cant use tables) I must --
    -- create two tables. One holds the profile names only, the other holds the profile name & the settings --
    
    -- Save Profile names ONLY in table for drop down list box --
    table.insert(AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE_NAMES"], _sProfileName)
    
    -- Save Profile names, with character settings --
    table.insert(AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE"], {_sProfileName, tSavedVars})
    AutoJunker_PROFILE_DROPDOWN:UpdateChoices(AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE_NAMES"])
end

local function LoadProfile(_sProfileName)
    if _sProfileName == "" then AutoJunker.ShowErrorDialog("Profile", "You must select a profile to be loaded.") return end
    if not DoesProfileExist(_sProfileName) then AutoJunker.ShowErrorDialog("Profile", "Profile name not found.") return end
    
    for k,v in pairs(AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE"]) do
        if v[1] == _sProfileName then
            bMatchFound = true
            local sDisplayName = GetDisplayName()
            local sUnitName = GetUnitName("player")
            ZO_DeepTableCopy(v[2], _G["AutoJunkerSavedVars"]["Default"][sDisplayName][sUnitName])
        end
    end
    AutoJunker_WHITELIST_DROPDOWN:UpdateChoices(AutoJunker.SavedVariables["WHITELIST"])
    AutoJunker_BLACKLIST_DROPDOWN:UpdateChoices(AutoJunker.SavedVariables["BLACKLIST"])

    local bShouldBeOnBlacksmithingList 	= AutoJunker.SavedVariables["SAVEUNRESEARCHEDTRAITSBLACKSMITHING"]
    local bShouldBeOnClothierList 		= AutoJunker.SavedVariables["SAVEUNRESEARCHEDTRAITSCLOTHIER"]
    local bShouldBeOnWoodworkingList 	= AutoJunker.SavedVariables["SAVEUNRESEARCHEDTRAITSWOODWORKING"]
    local bShouldBeOnProvisioningList 	= AutoJunker.SavedVariables["SAVEUNKNOWNRECIPES"]
    
    AutoJunker.UpdateWatchlist(CRAFTING_TYPE_BLACKSMITHING, bShouldBeOnBlacksmithingList)
    AutoJunker.UpdateWatchlist(CRAFTING_TYPE_CLOTHIER, bShouldBeOnClothierList)
    AutoJunker.UpdateWatchlist(CRAFTING_TYPE_WOODWORKING, bShouldBeOnWoodworkingList)
    AutoJunker.UpdateWatchlist(CRAFTING_TYPE_PROVISIONING, bShouldBeOnProvisioningList)

    ReloadUI("ingame")
end


local function DeleteProfile(_sProfileName)
    if _sProfileName == "" then AutoJunker.ShowErrorDialog("Profile", "You must select a profile to be deleted.") return end
    if not DoesProfileExist(_sProfileName) then AutoJunker.ShowErrorDialog("Profile", "Profile name not found.") return end
    
    -- Remove Profile from drop down list table --
    for k,v in pairs(AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE_NAMES"]) do
        if v == _sProfileName then
            table.remove(AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE_NAMES"], k)
        end
    end
    
    -- Remove profile from profile table --
    for k,v in pairs(AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE"]) do
        if v[1] == _sProfileName then
            table.remove(AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE"], k)
        end
    end
    AutoJunker_PROFILE_DROPDOWN:UpdateChoices(AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE_NAMES"])
end

local function RefreshAllInventories()
    ZO_ScrollList_RefreshVisible(ZO_PlayerInventoryBackpack)
    ZO_ScrollList_RefreshVisible(ZO_PlayerBankBackpack)
    ZO_ScrollList_RefreshVisible(ZO_GuildBankBackpack)
end


--*************************************************************************--
-----------------------------------------------------------------------------
--  Advanced Filter Stuff --
-----------------------------------------------------------------------------
--*************************************************************************--
local function GetDefaultCAF()
    return {
        type = "JUNK",
        name = "",
        textMatch = "",
        minValue = -1,
        maxValue = -1,
        minLevel = -1,
        maxLevel = -1,
        minQuality = "Off",
        maxQuality = "Off",
        itemType	= "Off",
        subType		= "Off",
        equipType	= "Off",
        style		= "Off",
        traitType	= "Off",
        research	= "Off",
        unique		= "Off",
        stolen		= "Off",
        potions		= "Off",
        setItem		= "Off",
    }
end
-- currentAdvancedFilter 
local caf = GetDefaultCAF()

local selectedDDAF


local function OnItemTypeSelection()
    ADVANCED_FILTER_SUBTYPE:UpdateChoices(AutoJunker.GetAvailableSubTypes(caf.itemType))
    ADVANCED_FILTER_TRAIT_TYPE:UpdateChoices(AutoJunker.GetAvailableTraitTypes(caf.itemType))
    ADVANCED_FILTER_EQUIPTYPE:UpdateChoices(AutoJunker.GetAvailableEquipTypes(caf.itemType))
    ADVANCED_FILTER_SUBTYPE:UpdateValue(false, AutoJunker.GetTextFromSubType(caf.itemType, caf.subType))
    ADVANCED_FILTER_TRAIT_TYPE:UpdateValue(false, AutoJunker.GetTextFromTraitType(caf.itemType, caf.traitType))
    local equipType = 
    ADVANCED_FILTER_EQUIPTYPE:UpdateValue(false, AutoJunker.GetTextFromEquipType(caf.itemType, caf.equipType))
end

local function LoadAdvancedFilters(afName)
    selectedDDAF = afName
    local savedAF = AutoJunker.AccountSavedVariables["ADVANCED_FILTERS"][afName]
    ZO_DeepTableCopy(savedAF, caf)
    
    CALLBACK_MANAGER:FireCallbacks("LAM-RefreshPanel", AutoJunker_Addon_Options)
    -- Choices don't update on a panel refresh, have to do it manually
    OnItemTypeSelection()
end
local function GetAvailableAdvancedFilters()
    local afs = {}
    for k,v in pairs(AutoJunker.AccountSavedVariables["ADVANCED_FILTERS"]) do
        table.insert(afs, v.name)
    end
    return afs
end

local function WasSomethingSet()
    local sText = caf.textMatch
    if sText and sText ~= "" and sText:len(sText) > 2 then return true end
    if caf.minValue 	~= -1 then return true end
    if caf.maxValue 	~= -1 then return true end
    if caf.minLevel	 	~= -1 then return true end
    if caf.maxLevel 	~= -1 then return true end
    if caf.minQuality 	~= "Off" then return true end
    if caf.maxQuality 	~= "Off" then return true end
    if caf.itemType		~= "Off" then return true end
    if caf.subType		~= "Off" then return true end
    if caf.equipType	~= "Off" then return true end
    if caf.style		~= "Off" then return true end
    if caf.traitType	~= "Off" then return true end
    if caf.research		~= "Off" then return true end
    if caf.unique		~= "Off" then return true end
    if caf.stolen		~= "Off" then return true end
    if caf.potions		~= "Off" then return true end
    
    return false
end
local function PassesAFSaveChecks()
    if not caf.name or caf.name == "" or type(caf.name) ~= "string" then
        AutoJunker.ShowErrorDialog("Invalid Name", "You must supply a name for your advanced filter.")
        return false
    end
    if caf.textMatch and caf.textMatch ~= "" and type(caf.textMatch) ~= "string" then
        AutoJunker.ShowErrorDialog("Invalid Text Match", "The text match must be a string.")
        return false
    end
    if caf.maxValue ~= -1 and caf.minValue > caf.maxValue then
        AutoJunker.ShowErrorDialog("Invalid Value Filters", "You have both the minimum & maximum value filters turned on. When both filters are turned on the minimum value setting must be less than or equal to the maximum value setting.")
        return false
    end
    if caf.maxLevel ~= -1 and caf.minLevel > caf.maxLevel then
        AutoJunker.ShowErrorDialog("Invalid Level Filters", "You have both the minimum & maximum level filters turned on. When both filters are turned on the minimum level setting must be less than or equal to the maximum level setting.")
        return false
    end
    if caf.maxQuality ~= "Off" and caf.minQuality ~= "Off" and caf.minQuality > caf.maxQuality then
        AutoJunker.ShowErrorDialog("Invalid Quality Filters", "You have both the minimum & maximum quality filters turned on. When both filters are turned on the minimum quality setting must be less than or equal to the maximum quality setting.")
        return false
    end
    -- Check textMatching string separately so we can display a different error message
    local sText = caf.textMatch
    if sText and sText ~= "" and sText:len(sText) <= 2 then
        AutoJunker.ShowErrorDialog("Invalid Filters", "Text Match filter must have at least 3 letters.")
        return false
    end
    if not WasSomethingSet() then
        AutoJunker.ShowErrorDialog("Invalid Filters", "You did not turn on any filters. You must turn on at least one filter.")
        return false
    end
    return true
end

local function SaveAdvancedFilter()
    if not PassesAFSaveChecks() then return end

    AutoJunker.AccountSavedVariables["ADVANCED_FILTERS"][caf.name] = {}
    local dest = AutoJunker.AccountSavedVariables["ADVANCED_FILTERS"][caf.name]
    ZO_DeepTableCopy(caf, dest)
    
    SELECTED_ADVANCED_FILTER_DD:UpdateChoices(GetAvailableAdvancedFilters())
    SELECTED_ADVANCED_FILTER_DD:UpdateValue(false, caf.name)
    
    selectedDDAF = caf.name
end
local function DeleteSelectedAF() 
    if not selectedDDAF or selectedDDAF == "" then return end
    
    AutoJunker.AccountSavedVariables["ADVANCED_FILTERS"][selectedDDAF] = nil 
    SELECTED_ADVANCED_FILTER_DD:UpdateChoices(GetAvailableAdvancedFilters())
    caf = GetDefaultCAF()
    
    selectedDDAF = nil
end
--*********************************************************************************************--
-------------------------------------------------------------------------------------------------
--  Create Menu --
-------------------------------------------------------------------------------------------------
--*********************************************************************************************--
function AutoJunker.CreateSettingsMenu()
    local panelData = {
        type = "panel",
        name = "AutoJunker",
        displayName = "AutoJunker |cCCCCCC (Previously JunkIt)",
        author = "Circonian, Bunchopunch, @AtomicFiredoll",
        version = AutoJunker.SettingVersion,
        slashCommand = "/AutoJunker",
        registerForRefresh = true,
        registerForDefaults = true,
    }
    local cntrlOptionsPanel = LAM2:RegisterAddonPanel("AutoJunker_Addon_Options", panelData)
    
    local optionsData = {
        [1] = {
            type = "description",
            text = colorRed.."Open the games \"CONTROLS -> Keybindings\" window and bind a key to AutoJunkers Debug Messages Window. It will allow you to open a window telling you exactly why every item was junked or kept.",
        },
                
        [2] = {
            type = "header",
            name = colorYellow.."General Settings",
        },
        
        [3] = {
            type = "description",
            --type = "header",
            text = "This section contains all of the general settigs for AutoJunker.",
        },
        
        [4] = {
            type = "submenu",
            name = "General",
            controls = {	
                [1] = {
                    type = "checkbox",
                    name = "Turn Junk Filtering ON/OFF",
                    tooltip = "Allows you to temporarily turn off item junking.",
                    default = true,
                    getFunc = function() return AutoJunker.SavedVariables["JUNKMODE"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["JUNKMODE"] = bValue end,
                },
                
                [2] = {
                    type = "description",
                    text = colorRed.."You MUST turn off the games auto-loot option for AutoJunkers Auto-Loot to work properly.",
                },
                
-- Turns on autoloot
                [3] = {
                    type = "checkbox",
                    name = "Turn Auto-Loot ON/OFF",
                    tooltip = "When ON AutoJunker will loot for you based on your set junk filters. It will only loot items that are not junk. You must turn off the games auto-loot option for this to work properly.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables["LOOTMODE"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["LOOTMODE"] = bValue end,
                },
                
                [4] = {
                    type = "checkbox",
                    name = "Auto-Loot Stolen Items",
                    tooltip = "When ON stolen items will be auto-looted based on your junk filters. Auto-Loot must also be turned ON. \nWhen OFF stolen items will NOT be auto-looted.",
                    default = false,
                    disabled = function() return not AutoJunker.SavedVariables["LOOTMODE"] end,
                    getFunc = function() return AutoJunker.SavedVariables["LOOTSTOLENITEMS"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["LOOTSTOLENITEMS"] = bValue end,
                },
                
                [5] = {
                    type = "dropdown",
                    name = "Auto-Repair",
                    tooltip = "AutoJunker will automatically repair your equipped items (or all items based on your selection) when you visit a merchant.",
                    choices = {"Off", "Equipped", "All"},
                    default = "Off",
                    getFunc = function() return AutoJunker.SavedVariables["AUTOREPAIRITEMS"] end,
                    setFunc = function(sValue) AutoJunker.SavedVariables["AUTOREPAIRITEMS"] = sValue end,
                },
        
                [6] = {
                    type = "checkbox",
                    name = "Auto-Sell Junk",
                    tooltip = "When ON AutoJunker will automatically sell all of your junk for you when you visit a merchant.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables["AUTOSELLJUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["AUTOSELLJUNK"] = bValue end,
                },
                [7] = {
                    type = "slider",
                    name = "Auto-Sell Delay",
                    tooltip = "This value determines how long of a delay, in milliseconds, occurs between selling individual items. If the game crashes or freezes while selling a lot of items try increasing this value.",
                    min = 30,
                    max = 80,
                    step = 10,
                    default = 30,
                    getFunc = function() return AutoJunker.SavedVariables["AUTOSELLDELAY"] end,
                    setFunc = function(iValue) AutoJunker.SavedVariables["AUTOSELLDELAY"] = iValue 
                        end,
                },
                
                [8] = {
                    type = "checkbox",
                    name = "Auto-Sell Junk Confirmation",
                    tooltip = "When ON a dialog box will pop up asking you to confirm if you want to sell your junk when you visit a merchant (Auto-Sell junk must also be ON).",
                    default = false,
                    disabled = function() return not AutoJunker.SavedVariables["AUTOSELLJUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables["AUTOSELLJUNKCONFIRM"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["AUTOSELLJUNKCONFIRM"] = bValue end,
                },

                
                [9] = {
                    type = "checkbox",
                    name = "Auto-Sell Stolen Items",
                    tooltip = "When ON AutoJunker will automatically sell stolen items for you when you visit a fence.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables["AUTOSELLFENCE"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["AUTOSELLFENCE"] = bValue end,
                },
                
                [10] = {
                    type = "checkbox",
                    name = "Auto-Sell Stolen Items Confirmation",
                    tooltip = "When ON a dialog box will pop up asking you to confirm if you want to sell your stolen items when you visit a fence (Auto-Sell Stolen Items must also be ON).",
                    default = false,
                    disabled = function() return not AutoJunker.SavedVariables["AUTOSELLFENCE"] end,
                    getFunc = function() return AutoJunker.SavedVariables["AUTOSELLFENCECONFIRM"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["AUTOSELLFENCECONFIRM"] = bValue end,
                },
                
                [11] = {
                    type = "checkbox",
                    name = "Enable Destroyer Buttons",
                    name = "AutoJunker Destroyer Buttons",
                    tooltip = "Creates clickable buttons for items in the junk area of your inventory allowing you to quickly & easily delete junk items.",
                    warning, "There is NO confirmation request when clicking one of the destruction icons, be careful.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables["JUNKDESTROYER"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["JUNKDESTROYER"] = bValue
                        ZO_ScrollList_RefreshVisible(ZO_PlayerInventoryBackpack)
                        end,
                },
                [12] = {
                    type = "slider",
                    name = "Change Destroyer Button Position",
                    tooltip = "WILL FORCE A RELOADUI. Lowering the value moves the buttons left, raising the value moves the buttons right. Best values between 0 and 120. Lower than 0 may overlap item names, to high of a value and it may overlap other column information (sell price value).",
                    min = -90,
                    max = 150,
                    step = 1,
                    default = 0,
                    getFunc = function() return AutoJunker.SavedVariables["INFOBUTTONOFFSETX"] end,
                    setFunc = function(iValue) AutoJunker.SavedVariables["INFOBUTTONOFFSETX"] = iValue 
                        ReloadUI("ingame") 
                        end,
                },
            },
            reference = "AutoJunker_General_Submenu",
        },
        
        [5] = {
            type = "submenu",
            name = "Chat Messages",
            controls = {	
                [1] = {
                    type = "description",
                    text = colorYellow.."Toggle chat messages ON & OFF.",
                },
                
                [2] = {
                    type = "checkbox",
                    name = "Recipe & Research Messages",
                    tooltip = "Displays a chat message when you find an unknown recipe or unknown researchable trait item useable by your current character.",
                    default = true,
                    width = "full",
                    getFunc = function() return AutoJunker.SavedVariables["UNKNOWNRESEARCHMESSAGESPLAYER"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["UNKNOWNRESEARCHMESSAGESPLAYER"] = bValue end,
                },
                
                [3] = {
                    type = "checkbox",
                    name = "Research Messages For Other Characters",
                    tooltip = "Displays a chat message when you find an unknown researchable trait item usable by one of your other characters.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables["UNKNOWNRESEARCHMESSAGESOTHER"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["UNKNOWNRESEARCHMESSAGESOTHER"] = bValue end,
                },
                
                [4] = {
                    type = "checkbox",
                    name = "Research Message Character Names",
                    tooltip = "When an unknown recipe/researchable trait item is found this will display the names of all characters who need the item for research.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables["UNKNOWNRESEARCHMESSAGESNAMES"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["UNKNOWNRESEARCHMESSAGESNAMES"] = bValue end,
                },
                
                [5] = {
                    type = "checkbox",
                    name = "Junk Messages",
                    tooltip = "Display a chat message every time AutoJunker junks an item.",
                    default = true,
                    getFunc = function() return AutoJunker.SavedVariables["JUNKEDMESSAGE"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["JUNKEDMESSAGE"] = bValue end,
                    },
                    
                [6] = {
                    type = "checkbox",
                    name = "Kept Messages",
                    tooltip = "Display a chat message every time AutoJunker keeps an item.",
                    default = true,
                    getFunc = function() return AutoJunker.SavedVariables["NOTJUNKEDMESSAGE"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["NOTJUNKEDMESSAGE"] = bValue end,
                },
                
                [7] = {
                    type = "checkbox",
                    name = "Display Repair Messages",
                    tooltip = "Display a chat message, with cost, when AutoJunker automatically repairs your equipment.",
                    default = true,
                    getFunc = function() return AutoJunker.SavedVariables["REPAIRMESSAGES"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["REPAIRMESSAGES"] = bValue end,
                },

                [8] = {
                    type = "checkbox",
                    name = "Gold Gains/Losses Messages",
                    tooltip = "Displays a chat message whenever you gain/loose gold.",
                    default = true,
                    getFunc = function() return AutoJunker.SavedVariables["GOLDMESSAGES"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["GOLDMESSAGES"] = bValue end,
                },

                [9] = {
                    type = "checkbox",
                    name = "Destroyer Button Messages",
                    tooltip = "Display a chat message each time you use the destroyer buttons in the junk area of your inventory to destroy an item.",
                    default = true,
                    getFunc = function() return AutoJunker.SavedVariables["DESTROYERBTNMESSAGES"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["DESTROYERBTNMESSAGES"] = bValue end,
                },
            },
        },
        
        [6] = {
            type = "submenu",
            name = "Icons & ToolTips",
            controls = {	
                [1] = {
                    type = "description",
                    text = colorRed.."Icons will only be visible for characters that have the corresponding KEEP Unknown recipes/research filters turned on. This is because if you do not care about keeping blacksmithing items for a character you probably don't want to see blacksmithing icons for him either.",
                }, 
                
                [2] = {
                    type = "description",
                    text = colorYellow.."ICON COLORS: Icons will be Red if the item is needed only by your current character, Orange if it is needed by your current character & other characters, Yellow if it is only needed by other characters.",
                },
                [3] = {
                    type = "slider",
                    name = "Marked Icon Size",
                    tooltip = "Sets the icon size for marked icons.",
                    min = 16,
                    max = 32,
                    step = 1,
                    default = 32,
                    getFunc = function() return AutoJunker.AccountSavedVariables["ICONSIZE"] end,
                    setFunc = function(iValue) AutoJunker.AccountSavedVariables["ICONSIZE"] = iValue 
                        RefreshAllInventories()
                    end,
                },
                [4] = {
                    type = "checkbox",
                    name = "Show Recipe Icons: Player",
                    tooltip = "When ON Recipe Icons will be displayed on recipes unknown by your current character. ",
                    default = true,
                    getFunc = function() return AutoJunker.SavedVariables["ICONSRECIPEPLAYER"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["ICONSRECIPEPLAYER"] = bValue
                        ZO_ScrollList_RefreshVisible(ZO_PlayerInventoryBackpack)
                    end,
                },
                
                [5] = {
                    type = "checkbox",
                    name = "Show Research Icons: Player",
                    tooltip = "When ON Research Icons will be displayed on items with researchable traits unknown by your current character.",
                    default = true,
                    getFunc = function() return AutoJunker.SavedVariables["ICONSRESEARCHPLAYER"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["ICONSRESEARCHPLAYER"] = bValue
                        ZO_ScrollList_RefreshVisible(ZO_PlayerInventoryBackpack)
                    end,
                },
                [6] = {
                    type = "checkbox",
                    name = "Show Recipe Icons: Other Chars",
                    tooltip = "When ON Recipe Icons will be displayed on recipes unknown by other characters. ",
                    default = true,
                    getFunc = function() return AutoJunker.SavedVariables["ICONSRECIPEOTHER"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["ICONSRECIPEOTHER"] = bValue
                        ZO_ScrollList_RefreshVisible(ZO_PlayerInventoryBackpack)
                    end,
                },
                [7] = {
                    type = "checkbox",
                    name = "Show Research Icons: Other Chars",
                    tooltip = "When ON Research Icons will be displayed on items with researchable traits unknown by other characters.",
                    default = true,
                    getFunc = function() return AutoJunker.SavedVariables["ICONSRESEARCHOTHER"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["ICONSRESEARCHOTHER"] = bValue
                        ZO_ScrollList_RefreshVisible(ZO_PlayerInventoryBackpack)
                    end,
                },
                --[[
                [5] = {
                    type = "checkbox",
                    name = "Show Icons For Other Characters",
                    tooltip = "When ON Recipe & Research Icons will be displayed on items that are unknown by your other characters.",
                    default = true,
                    getFunc = function() return AutoJunker.SavedVariables["ICONSOTHER"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["ICONSOTHER"] = bValue
                        ZO_ScrollList_RefreshVisible(ZO_PlayerInventoryBackpack)
                    end,
                },
                --]]
                [8] = {
                    type = "checkbox",
                    name = "Show Research ToolTips",
                    tooltip = "When ON AutoJunker will display a list of character names in item tooltips to show you which characters need the unknown recipe or research item.",
                    default = true,
                    getFunc = function() return AutoJunker.SavedVariables["RESEARCHTOOLTIPS"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["RESEARCHTOOLTIPS"] = bValue
                        ZO_ScrollList_RefreshVisible(ZO_PlayerInventoryBackpack)
                    end,
                },
            },
        },
        
        [7] = {
            type = "submenu",
            name = "Profiles",
            controls = {
                [1] = {
                    type = "description",
                    text = colorYellow.."Saving a Profile will save your current AutoJunker settings. This allows you to save multiple profiles (settings) and swap between them quickly.",
                },
                
                [2] = {
                    type = "description",
                    text = colorYellow.."To save a profile type a name in the Profile Name box and click Save Profile.",
                },
                
                [2] = {
                    type = "editbox",
                    name = "Profile Name",
                    tooltip = "Type the name you wish to use for the profile and click Save Profile.",
                    width = "half",
                    default = false,
                    getFunc = function() return  end,
                    setFunc = function()  end,
                    reference = "AutoJunker_PROFILE_EDITBOX",
                },
                
                [3] = {
                    type = "button",
                    name = "Save Profile",
                    width = "half",
                    func = function() SaveProfile(TrimToLower(AutoJunker_PROFILE_EDITBOX.editbox:GetText())) end,
                },
                
                [4] = {
                    type = "description",
                    text = colorYellow.."To Delete or Load a profile select the profile from the dropdown box below & click the appropriate button.",
                },
        
                [5] = {
                    type = "dropdown",
                    name = "Select Profile",
                    tooltip = "Select a profile to be Loaded/Deleted and press the appropriate button.",
                    choices = AutoJunker.AccountSavedVariables["PROFILES"]["PROFILE_NAMES"],
                    sort = "name-up",
                    getFunc = function() return  end,
                    setFunc = function(iValue) return  end,
                    reference = "AutoJunker_PROFILE_DROPDOWN",
                },
                
                [6] = {
                    type = "button",
                    name = "Delete Profile",
                    width = "half",
                    func = function() DeleteProfile(TrimToLower(AutoJunker_PROFILE_DROPDOWN.dropdown:GetSelectedItem())) end,
                },
                
                [7] = {
                    type = "button",
                    name = "Load Profile",
                    width = "half",
                    func = function() LoadProfile(TrimToLower(AutoJunker_PROFILE_DROPDOWN.dropdown:GetSelectedItem())) end,
                },
            }
        },
        
        [8] = {
            type = "description",
        },
                
        [9] = {
            type = "header",
            name = colorYellow.."Text Filters",
        },
        
        [10] = {
            type = "description",
            --type = "header",
            text = "Text filters allow you to specify text for junking or keeping items by name.",
        },
                
        [11] = {
            type = "submenu",
            name = "Text Filters",
            controls = {
                [1] = {
                    type = "description",
                    text = colorRed.."Text filters are NOT case sensitive. Leading or Trailing white (blank) spaces are not permitted & will be stripped from the text.",
                },
                
                [2] = {
                    type = "header",
                    name = colorYellow.."Whitelist",
                },
                
                [3] = {
                    type = "description",
                    text = colorYellow.."If any items name contains text in the Whitelist that item will NOT be filtered by AutoJunker. "..colorRed.."It will NOT be marked as junk regardless of any other settings.",
                },
                
                [4] = {
                    type = "editbox",
                    name = "Enter Whitelist Text",
                    tooltip = "Enter the text you wish to add to the whitelist and press the Add Text button.",
                    width = "half",
                    default = false,
                    getFunc = function() return  end,
                    setFunc = function()  end,
                    reference = "AutoJunker_WHITELIST_EDITBOX",
                },
                
                [5] = {
                    type = "button",
                    name = "Add Text",
                    width = "half",
                    func = function() AddToWhiteList(TrimToLower(AutoJunker_WHITELIST_EDITBOX.editbox:GetText())) end,
                },
        
                [6] = {
                    type = "dropdown",
                    name = "Select Whitelist Text",
                    tooltip = "Select the text you wish to remove from the Whitelist and press the Remove Text button.",
                    width = "half",
                    choices = AutoJunker.SavedVariables["WHITELIST"],
                    sort = "name-up",
                    getFunc = function() return  end,
                    setFunc = function(iValue) return  end,
                    reference = "AutoJunker_WHITELIST_DROPDOWN",
                },
                
                [7] = {
                    type = "button",
                    name = "Remove Text",
                    width = "half",
                    func = function() RemoveFromWhiteList(TrimToLower(AutoJunker_WHITELIST_DROPDOWN.dropdown:GetSelectedItem())) end,
                },
                
                [8] = {
                    type = "header",
                    name = colorYellow.."Blacklist",
                },
        
                
                [9] = {
                    type = "description",
                    text = colorYellow.."If any items name contains text in the blacklist it will be junked regardless of any junk filters.",
                },
                
                [10] = {
                    type = "description",
                    text = colorRed.."THIS OVERRIDES ALL OTHER SETTINGS INCLUDING THE KEEP FILTERS. IF ANY TEXT BELOW IS FOUND IN AN ITEMS NAME IT WILL BE JUNKED EVEN IF A MATCHING KEEP FILTER IS MARKED TO KEEP THAT ITEM.",
                },
        
                [11] = {
                    type = "editbox",
                    name = "Enter Blacklist Text",
                    tooltip = "Enter the text you wish to add to the Blacklist and press the Add Text button.",
                    width = "half",
                    default = false,
                    getFunc = function() return  end,
                    setFunc = function()  end,
                    reference = "AutoJunker_BLACKLIST_EDITBOX",
                },
                
                [12] = {
                    type = "button",
                    name = "Add Text",
                    width = "half",
                    func = function() AddToBlackList(TrimToLower(AutoJunker_BLACKLIST_EDITBOX.editbox:GetText())) end,
                },
        
                [13] = {
                    type = "dropdown",
                    name = "Select Text",
                    tooltip = "Select the text you wish to remove from the Blacklist and press the Remove Text button.",
                    width = "half",
                    choices = AutoJunker.SavedVariables["BLACKLIST"],
                    sort = "name-up",
                    getFunc = function() return  end,
                    setFunc = function(iValue) return  end,
                    reference = "AutoJunker_BLACKLIST_DROPDOWN",
                },
                
                [14] = {
                    type = "button",
                    name = "Remove Text",
                    width = "half",
                    func = function() RemoveFromBlackList(TrimToLower(AutoJunker_BLACKLIST_DROPDOWN.dropdown:GetSelectedItem())) end,
                },
            }
        },
        
        [12] = {
            type = "description",
        },
                
        [13] = {
            type = "header",
            name = colorYellow.."KEEP Filters",
        },
        [14] = {
            type = "description",
            --type = "header",
            text = "KEEP Filters are used to override junk filters in order to keep items that have special properties like Unknown Traits, Set Items, Unique Items, ect...",
        },
        
        [15] = {
            type = "submenu",
            name = "KEEP Special Types of Items",
            controls = {
                [1] = {
                    type = "description",
                    text = colorYellow.."Items matching these filters will be KEPT, regardless of any Junk filter settings (the blacklist overrides these filters)",
                },
                
                [2] = {
                    type = "checkbox",
                    name = "KEEP Crafted Items",
                    tooltip = "When ON Crafted items will not be junked. This can only be overridden by the blacklist.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables["KEEPCRAFTEDITEMS"] end,
                    setFunc = function(iValue) AutoJunker.SavedVariables["KEEPCRAFTEDITEMS"] = iValue end,
                },
                
                
                [3] = {
                    type = "checkbox",
                    name = "KEEP Pet Items",
                    tooltip = "When ON Pet items will not be junked. This can only be overridden by the blacklist.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables["KEEPPETITEMS"] end,
                    setFunc = function(iValue) AutoJunker.SavedVariables["KEEPPETITEMS"] = iValue end,
                },
                
                [4] = {
                    type = "checkbox",
                    name = "KEEP Set Items",
                    tooltip = "When ON Set Items will not be junked. This can only be overridden by the blacklist.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables["KEEPSETITEMS"] end,
                    setFunc = function(iValue) AutoJunker.SavedVariables["KEEPSETITEMS"] = iValue end,
                },
                
                [5] = {
                    type = "checkbox",
                    name = "KEEP Unique Items",
                    tooltip = "When ON Unique Items will not be junked. This can only be overridden by the blacklist.",
                    default = true,
                    getFunc = function() return AutoJunker.SavedVariables["KEEPUNIQUEITEMS"] end,
                    setFunc = function(iValue) AutoJunker.SavedVariables["KEEPUNIQUEITEMS"] = iValue end,
                },
                
                [6] = {
                    type = "slider",
                    name = "KEEP Items At or Above This Value",
                    tooltip = "When (ON) a value is selected items with a sell price at or above the selected value will not be junked. A value of 0 turns this filter OFF. This can only be overridden by the blacklist.",
                    min = 0,
                    max = 250,
                    step = 1,
                    default = 0,
                    getFunc = function() return AutoJunker.SavedVariables["KEEPATORABOVEVALUE"] end,
                    setFunc = function(iValue) AutoJunker.SavedVariables["KEEPATORABOVEVALUE"] = iValue end,
                },
            },
        },
        
        [16] = {
            type = "submenu",
            name = "KEEP Recipes & Researchable Trait Filters",
            controls = {
                [1] = {
                    type = "header",
                    name = colorYellow.."Current Character Filters",
                },
                
                [2] = {
                    type = "description",
                    text = colorRed.."These settings are for the character you are currently playing. To adjust settings for other characters you must log them in.",
                },
                
                [3] = {
                    type = "checkbox",
                    name = "KEEP Unknown Blacksmithing Trait Items",
                    tooltip = "When ON AutoJunker will keep items that have Blacksmithing Traits unknown by your current character.",
                    default = true,
                    getFunc = function() return AutoJunker.SavedVariables["SAVEUNRESEARCHEDTRAITSBLACKSMITHING"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["SAVEUNRESEARCHEDTRAITSBLACKSMITHING"] = bValue
                        AutoJunker.UpdateWatchlist(CRAFTING_TYPE_BLACKSMITHING, bValue)
                        ZO_ScrollList_RefreshVisible(ZO_PlayerInventoryBackpack)
                        AutoJunker_BLACKSMITHING_WATCHLIST.data.text = colorGreen.."KEEPING Researchable Blacksmithing Trait Items Unknown By: "..AutoJunker.GetCraftingTypeWatchList(CRAFTING_TYPE_BLACKSMITHING)
                        end,
                },
                
                [4] = {
                    type = "checkbox",
                    name = "KEEP Unknown Clothier Trait Items",
                    tooltip = "When ON AutoJunker will keep items that have Clothier Traits unknown by your current character.",
                    default = true,
                    getFunc = function() return AutoJunker.SavedVariables["SAVEUNRESEARCHEDTRAITSCLOTHIER"] end,
                    setFunc = function(bValue) 
                        AutoJunker.SavedVariables["SAVEUNRESEARCHEDTRAITSCLOTHIER"] = bValue
                        AutoJunker.UpdateWatchlist(CRAFTING_TYPE_CLOTHIER, bValue)
                        ZO_ScrollList_RefreshVisible(ZO_PlayerInventoryBackpack)
                        AutoJunker_CLOTHIER_WATCHLIST.data.text = colorGreen.."KEEPING Researchable Clothier Trait Items Unknown By: "..AutoJunker.GetCraftingTypeWatchList(CRAFTING_TYPE_CLOTHIER)
                        end,
                },
                
                [5] = {
                    type = "checkbox",
                    name = "KEEP Unknown Woodworking Trait Items",
                    tooltip = "When ON AutoJunker will keep items that have Woodworking Traits unknown by your current character.",
                    default = true,
                    getFunc = function() return AutoJunker.SavedVariables["SAVEUNRESEARCHEDTRAITSWOODWORKING"] end,
                    setFunc = function(bValue) 
                        AutoJunker.SavedVariables["SAVEUNRESEARCHEDTRAITSWOODWORKING"] = bValue
                        AutoJunker.UpdateWatchlist(CRAFTING_TYPE_WOODWORKING, bValue)
                        ZO_ScrollList_RefreshVisible(ZO_PlayerInventoryBackpack)
                        AutoJunker_WOODWORKING_WATCHLIST.data.text = colorGreen.."KEEPING Researchable Woodworking Trait Items Unknown By: "..AutoJunker.GetCraftingTypeWatchList(CRAFTING_TYPE_WOODWORKING)
                        end,
                },
                
                [6] = {
                    type = "checkbox",
                    name = "KEEP Unknown Recipes",
                    tooltip = "When ON AutoJunker will keep Recipes unknown by your current character.",
                    default = true,
                    getFunc = function() return AutoJunker.SavedVariables["SAVEUNKNOWNRECIPES"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["SAVEUNKNOWNRECIPES"] = bValue
                        AutoJunker.UpdateWatchlist(CRAFTING_TYPE_PROVISIONING, bValue)
                        ZO_ScrollList_RefreshVisible(ZO_PlayerInventoryBackpack)
                        AutoJunker_PROVISIONING_WATCHLIST.data.text = colorGreen.."KEEPING Recipes Unknown By: "..AutoJunker.GetCraftingTypeWatchList(CRAFTING_TYPE_PROVISIONING)
                        end,
                },
                
                [7] = {
                    type = "header",
                    name = colorYellow.."Other Characters Filters",
                },
                
                [8] = {
                    type = "description",
                    text = colorRed.."Do you wish to keep unknown recipes & unknown researchable trait items for other characters?",
                },
            
                [9] = {
                    type = "checkbox",
                    name = "KEEP Unknowns For Other Characters",
                    tooltip = "When ON AutoJunker will keep unknown recipes and items with unknown researchable traits for your other characters also. Those characters must have the corresponding KEEP Unknown xxx filter turned on.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables["SAVEUNKNOWNSOTHER"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["SAVEUNKNOWNSOTHER"] = bValue end,
                },
                [10] = {
                    type = "description",
                    text = colorRed.."The lists below show which types of unknowns this setting will keep for which characters. To change the types of unknowns you wish to keep for a different character you must log them in.",
                },
                
                [11] = {
                    type = "description",
                    text = colorGreen.."Researchable Blacksmithing Trait Items Unknown By: "..AutoJunker.GetCraftingTypeWatchList(CRAFTING_TYPE_BLACKSMITHING),
                    reference = "AutoJunker_BLACKSMITHING_WATCHLIST",
                },
                
                [12] = {
                    type = "description",
                    text = colorGreen.."Researchable Clothier Trait Items Unknown By: "..AutoJunker.GetCraftingTypeWatchList(CRAFTING_TYPE_CLOTHIER),
                    reference = "AutoJunker_CLOTHIER_WATCHLIST",
                },
                
                [13] = {
                    type = "description",
                    text = colorGreen.."Researchable Woodworking Trait Items Unknown By: "..AutoJunker.GetCraftingTypeWatchList(CRAFTING_TYPE_WOODWORKING),
                    reference = "AutoJunker_WOODWORKING_WATCHLIST",
                },
                [14] = {
                    type = "description",
                    text = colorGreen.."Recipes Unknown By: "..AutoJunker.GetCraftingTypeWatchList(CRAFTING_TYPE_PROVISIONING),
                    reference = "AutoJunker_PROVISIONING_WATCHLIST",
                },
            },
        },
        
        [17] = {
            type = "description",
        },
                
        [18] = {
            type = "header",
            name = colorYellow.."JUNK Filters",
        },
        
        [19] = {
            type = "description",
            --type = "header",
            text = "This section contains all of the JUNK filters. If a filter is turned ON it will be junked. If a filter has a quality selector Items AT OR BELOW the selected quality will be junked.",
        },
        
        [20] = {
            type = "submenu",
            name = "Advanced Filters",
            tooltip = "Advanced Filters",
            controls = {	
                [1] = {
                    type = "description",
                    --type = "header",
                    text = colorYellow.."The other filters are good enough to cover most players needs. These advanced filters are for those who wish to create a more complex filtering system.",
                },
                [2] = {
                    type = "description",
                    --type = "header",
                    text = colorYellow.."Select an Advanced Filter to edit or delete.",
                },
                [3] = {
                    type = "dropdown",
                    name = "Advanced Filters",
                    tooltip = "Select an Advanced Filter to Edit or Delete it.",
                    width = "half",
                    choices = GetAvailableAdvancedFilters(),
                    default = caf.name,
                    getFunc = function() return selectedDDAF end,
                    setFunc = function(value)
                        LoadAdvancedFilters(value)
                    end,
                    reference = "SELECTED_ADVANCED_FILTER_DD",
                },
                [4] = {
                    type = "button",
                    name = "Delete",
                    tooltip = "Delete selcted advanced filter.",
                    width = "half",
                    func  = function() DeleteSelectedAF() end,
                },
                [5] = {
                    type = "description",
                    --type = "header",
                    text = colorYellow.."Or Create a new advanced filter.",
                },
                [6] = {
                    type = "editbox",
                    name = "Advanced Filter Name",
                    tooltip = "Give your advanced filter a name.",
                    width = "half",
                    default = false,
                    getFunc = function() return caf.name end,
                    setFunc = function(value) 
                        local trimmedValue = AutoJunker.Trim(value)
                        -- No longer using the selected AF, nil it out
                        if selectedDDAF ~= trimmedValue then
                            selectedDDAF = nil
                        end
                        caf.name = trimmedValue
                    end,
                    reference = "ADVANCED_FILTER_NAME",
                },
                [7] = {
                    type = "button",
                    name = "Save",
                    tooltip = "Save your advanced filter.",
                    width = "half",
                    func  = function() SaveAdvancedFilter() end,
                },
                [8] = {
                    type = "dropdown",
                    name = "JUNK, KEEP",
                    tooltip = "Do you want this to be a Junk, Keep, or Destroy filter?",
                    width = "half",
                    --choices = {"JUNK", "KEEP", "DESTROY"},
                    choices = {"JUNK", "KEEP"},
                    default = "JUNK",
                    getFunc = function() return caf.type end,
                    setFunc = function(value) caf.type = value end,
                    reference = "ADVANCED_FILTER_TYPE",
                },
                [9] = {
                    type = "editbox",
                    name = "Text Match",
                    tooltip = "In order for an item to match this filter it must have this text in its name.",
                    width = "half",
                    default = false,
                    getFunc = function() return caf.textMatch end,
                    setFunc = function(value) caf.textMatch = AutoJunker.Trim(value)  end,
                    reference = "ADVANCED_FILTER_TEXTMATCH",
                },
                [10] = {
                    type = "slider",
                    name = "Minimum Value",
                    tooltip = "In order for an item to match this filter it must have a minimum of this value.\n"..colorRed.."A value of -1 turns this filter off.",
                    width = "half",
                    min = -1,
                    max = 150,
                    step = 1,
                    default = 0,
                    getFunc = function() return caf.minValue end,
                    setFunc = function(iValue) caf.minValue = iValue end,
                    reference = "ADVANCED_FILTER_MINVALUE",
                },
                [11] = {
                    type = "slider",
                    name = "Maximum Value",
                    tooltip = "In order for an item to match this filter it must have a maximum of this value.\n"..colorRed.."A value of -1 turns this filter off.",
                    width = "half",
                    min = -1,
                    max = 200,
                    step = 1,
                    default = 0,
                    getFunc = function() return caf.maxValue end,
                    setFunc = function(iValue) caf.maxValue = iValue end,
                    reference = "ADVANCED_FILTER_MAXVALUE",
                },
                [12] = {
                    type = "slider",
                    name = "Minimum Level",
                    tooltip = "In order for an item to match this filter it must have a minimum of this level.\n"..colorYellow.."VR levels are counted upwards from 50. I.E. VR Rank 1 is level 51, VR Rank 14 is level 64.\n"..colorRed.."A value of -1 turns this filter off.",
                    width = "half",
                    min = -1,
                    max = 66,
                    step = 1,
                    default = 0,
                    getFunc = function() return caf.minLevel end,
                    setFunc = function(iValue) caf.minLevel = iValue end,
                    reference = "ADVANCED_FILTER_MINLEVEL",
                },
                [13] = {
                    type = "slider",
                    name = "Maximum Level",
                    tooltip = "In order for an item to match this filter it must have a maximum of this level.\n"..colorYellow.."VR levels are counted upwards from 50. I.E. VR Rank 1 is level 51, VR Rank 16 is level 66.\n"..colorRed.."A value of -1 turns this filter off.",
                    width = "half",
                    min = -1,
                    max = 66,
                    step = 1,
                    default = 0,
                    getFunc = function() return caf.maxLevel end,
                    setFunc = function(iValue) caf.maxLevel = iValue end,
                    reference = "ADVANCED_FILTER_MAXLEVEL",
                },
                [14] = {
                    type = "dropdown",
                    name = "Minimum Quality",
                    tooltip = "In order for an item to match this filter it must have a minimum of this quality.",
                    width = "half",
                    choices = tQualities,
                    default = GetMenuQualityName(true, caf.minQuality) or "Off",
                    getFunc = function() 
                        return GetMenuQualityName(true, caf.minQuality) or "Off"
                    end,
                    setFunc = function(sValue) 
                        local _
                        _, caf.minQuality = GetJunkQualityFromMenuSetting(sValue)
                    end,
                    reference = "ADVANCED_FILTER_MINQUALITY",
                },
                [15] = {
                    type = "dropdown",
                    name = "Maximum Quality",
                    tooltip = "In order for an item to match this filter it must have a maximum of this quality.",
                    width = "half",
                    choices = tQualities,
                    default = GetMenuQualityName(true, caf.maxQuality) or "Off",
                    getFunc = function() 
                        return GetMenuQualityName(true, caf.maxQuality) or "Off"
                    end,
                    setFunc = function(sValue) 
                        local _
                        _, caf.maxQuality = GetJunkQualityFromMenuSetting(sValue)
                    end,
                    reference = "ADVANCED_FILTER_MAXQUALITY",
                },
                [16] = {
                    type = "dropdown",
                    name = "Item Type",
                    tooltip = "In order for an item to match this filter it must be of this item type.",
                    width = "half",
                    choices = AutoJunker.GetAvailableItemTypes(),
                    default = "Off",
                    getFunc = function() return AutoJunker.GetStringFromItemType(caf.itemType) end,
                    setFunc = function(itemTypeText)
                        local itemType = AutoJunker.GetItemTypeFromString(itemTypeText)
                        if itemType ~= caf.itemType then
                            caf.equipType 	= "Off"
                            caf.subType 	= "Off"
                            caf.traitType	= "Off"
                        end
                        caf.itemType 	= itemType
                        OnItemTypeSelection()
                    end,
                    reference = "ADVANCED_FILTER_ITEMTYPE",
                },
                [17] = {
                    type = "dropdown",
                    name = "Equip Type",
                    tooltip = "In order for an item to match this filter it must be of this equip type.\n"..colorYellow.."Only usable when using item Type Armor or Weapon.",
                    width = "half",
                    choices = AutoJunker.GetAvailableEquipTypes(caf.itemType),
                    default = AutoJunker.GetTextFromEquipType(caf.itemType, caf.equipType),
                    disabled = function() 
                        if caf.itemType ~= ITEMTYPE_ARMOR and caf.itemType ~= ITEMTYPE_WEAPON then
                        caf.equipType = "Off"
                            return true
                        end
                    end,
                    getFunc = function() return AutoJunker.GetTextFromEquipType(caf.itemType, caf.equipType) end,
                    setFunc = function(equipTypeText) 
                        caf.equipType = AutoJunker.GetEquipTypeFromText(caf.itemType, equipTypeText)
                    end,
                    reference = "ADVANCED_FILTER_EQUIPTYPE",
                },
                [18] = {
                    type = "dropdown",
                    name = "Sub Type",
                    tooltip = "In order for an item to match this filter it must be of this sub type.\n"..colorYellow.."Only usable when using item Type Armor or Weapon.",
                    width = "half",
                    choices = AutoJunker.GetAvailableSubTypes(caf.itemType),
                    --default = "Medium",
                    default = AutoJunker.GetTextFromSubType(caf.itemType, caf.subType),
                    disabled = function() 
                        if caf.itemType ~= ITEMTYPE_ARMOR and caf.itemType ~= ITEMTYPE_WEAPON then
                        caf.subType = "Off"
                            return true
                        end
                    end,
                    getFunc = function()  
                        return AutoJunker.GetTextFromSubType(caf.itemType, caf.subType)
                    end,
                    setFunc = function(subTypeText) 
                        caf.subType = AutoJunker.GetSubTypeFromText(caf.itemType, subTypeText)
                    end,
                    reference = "ADVANCED_FILTER_SUBTYPE",
                },
                [19] = {
                    type = "dropdown",
                    name = "Trait",
                    tooltip = "In order for an item to match this filter it must have this armor/weapon trait.\n"..colorYellow.."Only usable when using item Type Armor or Weapon.",
                    width = "half",
                    choices = AutoJunker.GetAvailableTraitTypes(caf.itemType),
                    default = "Off",
                    disabled = function() 
                        if caf.itemType ~= ITEMTYPE_ARMOR and caf.itemType ~= ITEMTYPE_WEAPON and caf.itemType ~= "SHIELDS" then
                        caf.traitType = "Off"
                            return true
                        end
                    end,
                    getFunc = function() return AutoJunker.GetTextFromTraitType(caf.itemType, caf.traitType) end,
                    setFunc = function(traitTypeText) 
                        caf.traitType = AutoJunker.GetTraitTypeFromText(caf.itemType, traitTypeText)
                    end,
                    reference = "ADVANCED_FILTER_TRAIT_TYPE",
                },
                [20] = {
                    type = "dropdown",
                    name = "Style",
                    tooltip = "In order for an item to match this filter it must be of this style.",
                    width = "half",
                    choices = AutoJunker.GetAvailableStyles(),
                    default = "Off",
                    getFunc = function() return AutoJunker.GetTextFromStyle(caf.style) end,
                    setFunc = function(itemStyleText) 
                        caf.style = AutoJunker.GetStyleFromStyleText(itemStyleText) or "Off"
                    end,
                    reference = "ADVANCED_FILTER_STYLE",
                },
                [21] = {
                    type = "dropdown",
                    name = "Research",
                    tooltip = "The crafting watchlist is used to determine if an item is needed for research, just like the basic KEEP for research filters. A character must be on the crafting watchlist in order to need an item for research.",
                    width = "half",
                    choices = {"Off", "Needed For Research", "Not Needed For Research"},
                    default = "Off",
                    getFunc = function() return caf.research end,
                    setFunc = function(sValue) caf.research = sValue end,
                    reference = "ADVANCED_FILTER_RESEARCH",
                },
                [22] = {
                    type = "dropdown",
                    name = "Unique",
                    tooltip = "In order to match this filter the item must be:",
                    width = "half",
                    choices = {"Off", "Unique", "Not Unique"},
                    default = "Off",
                    getFunc = function() return caf.unique end,
                    setFunc = function(sValue) caf.unique = sValue end,
                    reference = "ADVANCED_FILTER_UNIQUE",
                },
                [23] = {
                    type = "dropdown",
                    name = "Stolen",
                    tooltip = "In order to match this filter the item must be:",
                    width = "half",
                    choices = {"Off", "Stolen", "Not Stolen"},
                    default = "Off",
                    getFunc = function() return caf.stolen end,
                    setFunc = function(sValue) caf.stolen = sValue end,
                    reference = "ADVANCED_FILTER_STOLEN",
                },
                [24] = {
                    type = "dropdown",
                    name = "Potions",
                    tooltip = "In order to match this filter the item must be:",
                    width = "half",
                    choices = {"Off", "All Potions", "Crafted Potions", "Non-Crafted Potions"},
                    default = "Off",
                    getFunc = function() return caf.potions end,
                    setFunc = function(sValue) caf.potions = sValue end,
                    reference = "ADVANCED_FILTER_POTIONS",
                },
                [25] = {
                    type = "dropdown",
                    name = "Set Items",
                    tooltip = "In order to match this filter the item must be a:",
                    width = "half",
                    choices = {"Off", "Set Item", "Not a Set Item"},
                    default = "Off",
                    getFunc = function() return caf.setItem end,
                    setFunc = function(sValue) caf.setItem = sValue end,
                    reference = "ADVANCED_FILTER_SET_ITEM",
                },
            },
        },
        [21] = {
            type = "submenu",
            name = "Other Junk Filters",
            tooltip = "Random Item Junk Filters",
            controls = {	
                [1] = {
                    type = "checkbox",
                    name = "Junk Items With 0 Sell Price",
                    tooltip = "When ON ALL items with 0 sell price will be junked. WARNING: Some crafting materials have 0 sell price.",
                    warning = "WARNING: Some crafting materials have 0 sell price.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables["SELLZEROVALUEITEMS"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["SELLZEROVALUEITEMS"] = bValue end,
                },
                
                [2] = {
                    type = "checkbox",
                    name = "Junk Ornate Items",
                    tooltip = "When ON ALL Items with the Ornate trait will be junked.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables["ORNATETRAITITEMS"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["ORNATETRAITITEMS"] = bValue end,
                },
                
    
                [3] = {
                    type = "checkbox",
                    name = "Junk Trash Items",
                    tooltip = "When ON All Trash Items will be junked.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_TRASH]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_TRASH]["JUNK"] = bValue end,
                },
                
                [4] = {
                    type = "dropdown",
                    name = "Junk Food",
                    tooltip = "When a quality is selected all Food items at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_FOOD]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_FOOD]["QUALITY"]) end,
                    setFunc = function(sValue)
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_FOOD]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_FOOD]["QUALITY"] = iQuality 
                        end,
                },
                
    
                [5] = {
                    type = "dropdown",
                    name = "Junk Drinks",
                    tooltip = "When a quality is selected all Drinks items at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_DRINK]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_DRINK]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_DRINK]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_DRINK]["QUALITY"] = iQuality 
                        end,
                },
                
                [6] = {
                    type = "checkbox",
                    name = "Junk Lures",
                    tooltip = "When ON Lures will be junked. NOTE: This does not include used bait. Used bait is a trash item & is junked by the \"Trash Items\" junk filter.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_LURE]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_LURE]["JUNK"] = bValue end,
                },

                
                [7] = {
                    type = "checkbox",
                    name = "Junk Potions",
                    tooltip = "When ON Potions will be junked.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_POTION]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_POTION]["JUNK"] = bValue end,
                },
                --[[
                [7] = {
                    type = "dropdown",
                    name = "Junk Potions",
                    tooltip = "When a quality is selected all Potions at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_POTION]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_POTION]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_POTION]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_POTION]["QUALITY"] = iQuality 
                        end,
                },
                --]]
                [8] = {
                    type = "dropdown",
                    name = "Junk Recipes",
                    tooltip = "When a quality is selected all Recipes at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_RECIPE]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_RECIPE]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_RECIPE]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_RECIPE]["QUALITY"] = iQuality 
                        end,
                },
                --[[
                [9] = {
                    type = "checkbox",
                    name = "Junk Tools",
                    tooltip = "When ON All Tools will be junked. WARNING: This includes lockpicks, repair kits, & other tools.",
                    warning = "WARNING: This Includes lockpicks & repair kits.",
                    default = false,
                    -- is ITEMTYPE_LOCKPICK deprecated? Lockpicks are actually this: --
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_TOOL]["JUNK"]  end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_TOOL]["JUNK"]  = bValue end,
                },
                --]]
                [9] = {
                    type = "checkbox",
                    name = "Junk Lockpicks",
                    default = false,
                    -- is ITEMTYPE_LOCKPICK deprecated? Lockpicks are actually this: --
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_TOOL]["lockpicks"]["JUNK"]  end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_TOOL]["lockpicks"]["JUNK"]  = bValue end,
                },
                
                [10] = {
                    type = "checkbox",
                    name = "Junk Repair Kits",
                    default = false,
                    -- is ITEMTYPE_LOCKPICK deprecated? Lockpicks are actually this: --
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_TOOL]["repairKits"]["JUNK"]  end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_TOOL]["repairKits"]["JUNK"]  = bValue end,
                },
                
                [11] = {
                    type = "checkbox",
                    name = "Junk Soul Gems",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_SOUL_GEM]["JUNK"]  end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_SOUL_GEM]["JUNK"]  = bValue end,
                },
                
                [12] = {
                    type = "dropdown",
                    name = "Junk Treasures",
                    tooltip = "When a quality is selected all Treasures at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_TREASURE]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_TREASURE]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_TREASURE]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_TREASURE]["QUALITY"] = iQuality 
                        end,
                },
                
                [13] = {
                    type = "dropdown",
                    name = "Junk Trophies",
                    tooltip = "When a quality is selected all Trophies at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_TROPHY]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_TROPHY]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_TROPHY]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_TROPHY]["QUALITY"] = iQuality 
                        end,
                },
                
                [14] = {
                    type = "checkbox",
                    name = "Junk Fish",
                    tooltip = "Some items that \"look\" like fish, may actually be trophies/collectibles. This setting handles the normal, non-trophy, non-collectible fish.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_FISH]["JUNK"]  end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_FISH]["JUNK"]  = bValue end,
                },
                
                [15] = {
                    type = "description",
                    --type = "header",
                    text = colorRed.."Be Aware, the Stolen Items filter overlaps with other filters. As an example: If you pick up stolen provisioning ingredients and do not have the provisioning ingredients junk filter turned on, but have the stolen filter turned on the provisioning ingredients may get junked (depending upon the quality setting).",
                },
        
                [16] = {
                    type = "dropdown",
                    name = "Stolen Items",
                    tooltip = "When a quality is selected all Stolen items at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables["STOLEN_ITEMS"]["JUNK"], AutoJunker.SavedVariables["STOLEN_ITEMS"]["QUALITY"]) end,
                    setFunc = function(sValue)
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables["STOLEN_ITEMS"]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables["STOLEN_ITEMS"]["QUALITY"] = iQuality 
                        end,
                },
                [17] = {
                    type = "checkbox",
                    name = "Exclude Equipable Stolen Items",
                    tooltip = "Excludes items that can be equipped from the stolen items filter. Do note if its equipable it could still possibly match another filter.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables["EXCLUDE_EQUIPABLE_STOLEN"]  end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["EXCLUDE_EQUIPABLE_STOLEN"]  = bValue end,
                },
            },

            reference = "AutoJunker_Random_SubMenu",
        },
        
        [22] = {	-- Armor SubMenu
            type = "submenu",
            name = "Armor Junk Filters",
            controls = {
                [1] = {
                    type = "dropdown",
                    name = "Junk All Armor",
                    tooltip = "When a quality is selected All Armor at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_ARMOR]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_ARMOR]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_ARMOR]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_ARMOR]["QUALITY"] = iQuality 
                        end,
                },
                [2] = {
                    type = "description",
                    text = colorYellow.."The All Armor junk filter must be OFF to use any of the junk filters below.",
                },
                
                [3] = {	
                    type = "checkbox",
                    name = "Junk All Armor With 0 Sell Price",
                    tooltip = "Junk ALL armor with 0 sell price? This overrides any settings for Jewelry, heavy, medium, light armor.",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables["ZEROVALUEARMOR"]  end,
                    setFunc = function(bValue) 
                        AutoJunker.SavedVariables["ZEROVALUEARMOR"]  = bValue
                        end,
                    reference = "AutoJunker_ZEROVALUEARMOR",
                },

                [4] = {
                    type = "dropdown",
                    name = "Junk Jewelry",
                    tooltip = "When a quality is selected All Jewelry at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR]["JUNK"] end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_ARMOR][ARMORTYPE_NONE]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_ARMOR][ARMORTYPE_NONE]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_ARMOR][ARMORTYPE_NONE]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_ARMOR][ARMORTYPE_NONE]["QUALITY"] = iQuality 
                        end,
                },

                [5] = {	
                    type = "dropdown",
                    name = "Junk Heavy Armor",
                    tooltip = "When a quality is selected All Heavy Armor at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR]["JUNK"] end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_ARMOR][ARMORTYPE_HEAVY]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_ARMOR][ARMORTYPE_HEAVY]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_ARMOR][ARMORTYPE_HEAVY]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_ARMOR][ARMORTYPE_HEAVY]["QUALITY"] = iQuality 
                        end,
                    reference = "CIRCONIANS_AutoJunker_HEAVY_ARMOR_QUALITY",
                },

                [6] = {
                    type = "dropdown",
                    name = "Junk Medium Armor",
                    tooltip = "When a quality is selected All Medium Armor at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR]["JUNK"] end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_ARMOR][ARMORTYPE_MEDIUM]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_ARMOR][ARMORTYPE_MEDIUM]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_ARMOR][ARMORTYPE_MEDIUM]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_ARMOR][ARMORTYPE_MEDIUM]["QUALITY"] = iQuality 
                        end,
                },

                [7] = {	
                    type = "dropdown",
                    name = "Junk Light Armor",
                    tooltip = "When a quality is selected All Light Armor at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR]["JUNK"] end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_ARMOR][ARMORTYPE_LIGHT]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_ARMOR][ARMORTYPE_LIGHT]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_ARMOR][ARMORTYPE_LIGHT]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_ARMOR][ARMORTYPE_LIGHT]["QUALITY"] = iQuality 
                        end,
                },
            },

            reference = "AutoJunker_Armor_SubMenu",
        },
        
        [23] = {
            type = "submenu",
            name = "Weapons Junk Filters",
            controls = {
                [1] = {	
                    type = "dropdown",
                    name = "Junk All Weapons",
                    tooltip = "When a quality is selected All Weapons at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_WEAPON]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_WEAPON]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON]["QUALITY"] = iQuality 
                        end,
                },
                
                [2] = {
                    type = "description",
                    text = colorYellow.."The All Weapons junk filter must be OFF to use any of the junk filters below.",
                },
                
                [3] = {
                    type = "checkbox",
                    name = "Junk All Weapons With 0 Sell Price",
                    tooltip = "Junk ALL Weapons with 0 sell price? This overrides all other weapons filters.",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON]["JUNK"]  end,
                    getFunc = function() return AutoJunker.SavedVariables["ZEROVALUEWEAPONS"]  end,
                    setFunc = function(bValue) 
                        AutoJunker.SavedVariables["ZEROVALUEWEAPONS"]  = bValue
                        end,
                    reference = "AutoJunker_ZEROVALUEWEAPONS",
                },

                [4] = {
                    type = "dropdown",
                    name = "Junk Shields",
                    tooltip = "When a quality is selected All Shields at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON]["JUNK"]  end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_SHIELD]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_SHIELD]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_SHIELD]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_SHIELD]["QUALITY"] = iQuality 
                        end,
                },

                [5] = {	
                    type = "dropdown",
                    name = "Junk One-Handed Axes",
                    tooltip = "When a quality is selected All One-Handed Axes at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON]["JUNK"]  end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_AXE]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_AXE]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_AXE]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_AXE]["QUALITY"] = iQuality 
                        end,
                },

                [6] = {
                    type = "dropdown",	
                    name = "Junk Daggers",
                    tooltip = "When a quality is selected All Daggers at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON]["JUNK"]  end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_DAGGER]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_DAGGER]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_DAGGER]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_DAGGER]["QUALITY"] = iQuality 
                        end,
                },

                [7] = {	
                    type = "dropdown",	
                    name = "Junk One-Handed Hammers",
                    tooltip = "When a quality is selected All One-Handed Hammers at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON]["JUNK"]  end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_HAMMER]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_HAMMER]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_HAMMER]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_HAMMER]["QUALITY"] = iQuality 
                        end,
                },

                [8] = {
                    type = "dropdown",	
                    name = "Junk One-Handed Swords",
                    tooltip = "When a quality is selected All One-Handed Swords at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON]["JUNK"]  end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_SWORD]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_SWORD]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_SWORD]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_SWORD]["QUALITY"] = iQuality 
                        end,
                },

                [9] = {	
                    type = "dropdown",	
                    name = "Junk Two-Handed Axes",
                    tooltip = "When a quality is selected All Two-Handed Axes at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON]["JUNK"]  end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_TWO_HANDED_AXE]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_TWO_HANDED_AXE]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_TWO_HANDED_AXE]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_TWO_HANDED_AXE]["QUALITY"] = iQuality 
                        end,
                },

                [10] = {
                    type = "dropdown",
                    name = "Junk Two-Handed Hammers",
                    tooltip = "When a quality is selected All Two-Handed Hammers at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON]["JUNK"]  end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_TWO_HANDED_HAMMER]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_TWO_HANDED_HAMMER]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_TWO_HANDED_HAMMER]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_TWO_HANDED_HAMMER]["QUALITY"] = iQuality 
                        end,
                },

                [11] = {
                    type = "dropdown",
                    name = "Junk Two-Handed Swords",
                    tooltip = "When a quality is selected All Two-Handed Swords at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON]["JUNK"]  end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_TWO_HANDED_SWORD]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_TWO_HANDED_SWORD]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_TWO_HANDED_SWORD]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_TWO_HANDED_SWORD]["QUALITY"] = iQuality 
                        end,
                },

                [12] = {
                    type = "dropdown",
                    name = "Junk Bows",
                    tooltip = "When a quality is selected All Bows at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON]["JUNK"]  end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_BOW]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_BOW]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_BOW]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_BOW]["QUALITY"] = iQuality 
                        end,
                },

                [13] = {
                    type = "dropdown",
                    name = "Junk Flame Staves",
                    tooltip = "When a quality is selected All Flame Staves at or below the selected quality level will be junked.",
                    choices = tQualities,
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON]["JUNK"]  end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_FIRE_STAFF]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_FIRE_STAFF]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_FIRE_STAFF]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_FIRE_STAFF]["QUALITY"] = iQuality 
                        end,
                },

                [14] = {
                    type = "dropdown",	
                    name = "Junk Frost Staves",
                    tooltip = "When a quality is selected All Frost Staves at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON]["JUNK"]  end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_FROST_STAFF]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_FROST_STAFF]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_FROST_STAFF]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_FROST_STAFF]["QUALITY"] = iQuality 
                        end,
                },

                [15] = {
                    type = "dropdown",
                    name = "Junk Lightning Staves",
                    tooltip = "When a quality is selected All Lightning Staves at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON]["JUNK"]  end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_LIGHTNING_STAFF]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_LIGHTNING_STAFF]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_LIGHTNING_STAFF]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_LIGHTNING_STAFF]["QUALITY"] = iQuality 
                        end,
                },

                [16] = {
                    type = "dropdown",	
                    name = "Junk Healing Staves",
                    tooltip = "When a quality is selected All Healing Staves at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON]["JUNK"]  end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_HEALING_STAFF]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_HEALING_STAFF]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_HEALING_STAFF]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_WEAPON][WEAPONTYPE_HEALING_STAFF]["QUALITY"] = iQuality 
                        end,
                },
            },

        reference = "AutoJunker_Weapons_SubMenu",
        },
        --[[
        [24] = {
            type = "submenu",
            name = "Raw Material Junk Filters",
            controls = {
                [1] = {
                    type = "checkbox",
                    name = "Junk All Style Materials",
                    tooltip = "When ON All Style Materials will be junked.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] = bValue end,
                    reference = "AutoJunker_STYLE_MATERIAL",
                },
                
                [2] = {
                    type = "description",
                    text = colorYellow.."The All Style Materials junk filter must be off to use any of the junk filters below.",
                },
                
                [3] = {	
                    type = "checkbox",
                    name = "Junk Adamantite (Altmer)",
                    tooltip = "When ON All Adamantite will be junked. These are for the Altmer style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_HIGH_ELF]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_HIGH_ELF]["JUNK"] = bValue end,
                },
                
                [4] = {
                    type = "checkbox",
                    name = "Junk Palladium (Ancient Elf)",
                    tooltip = "When ON All Palladium will be junked. These are for the Ancient Elf style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_ANCIENT_ELF]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_ANCIENT_ELF]["JUNK"] = bValue end,
                },
                
                [5] = {
                    type = "checkbox",
                    name = "Junk Flint (Argonian)",
                    tooltip = "When ON All Flint will be junked. These are for the Argonian style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_ARGONIAN]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_ARGONIAN]["JUNK"] = bValue end,
                },
                
                [6] = {
                    type = "checkbox",
                    name = "Junk Copper (Barbaric)",
                    tooltip = "When ON All Copper will be junked. These are for the Barbaric style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_REACH]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_REACH]["JUNK"] = bValue end,
                },
                
                [7] = {
                    type = "checkbox",
                    name = "Junk Bone (Bosmer)",
                    tooltip = "When ON All Bone will be junked. These are for the Bosmer style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_WOOD_ELF]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_WOOD_ELF]["JUNK"] = bValue end,
                },
                
                [8] = {
                    type = "checkbox",
                    name = "Junk Molybdenum (Breton)",
                    tooltip = "When ON All Molybdenum will be junked. These are for the Breton style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_BRETON]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_BRETON]["JUNK"] = bValue end,
                },
                
                [9] = {
                    type = "checkbox",
                    name = "Junk Daedra Heart (Daedric)",
                    tooltip = "When ON All Daedra Hearts will be junked. These are for the Daedric style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_ENEMY_DAEDRIC]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_ENEMY_DAEDRIC]["JUNK"] = bValue end,
                },
                
                [10] = {
                    type = "checkbox",
                    name = "Junk Obsidian (Dunmer)",
                    tooltip = "When ON All Obsidian will be junked. These are for the Dunmer style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_DARK_ELF]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_DARK_ELF]["JUNK"] = bValue end,
                },
                
                [11] = {
                    type = "checkbox",
                    name = "Junk Dwemer Frame (Dwemer)",
                    tooltip = "When ON All Dwemer Frames will be junked. These are for the Dwemer style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_DWEMER]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_DWEMER]["JUNK"] = bValue end,
                },
                
                [12] = {
                    type = "checkbox",
                    name = "Junk Nickel (Imperial)",
                    tooltip = "When ON All Nickel will be junked. These are for the Imperial style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_IMPERIAL]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_IMPERIAL]["JUNK"] = bValue end,
                },
                
                [13] = {
                    type = "checkbox",
                    name = "Junk Moonstone (Khajit)",
                    tooltip = "When ON All Moonstone will be junked. These are for the Khajit style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_KHAJIIT]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_KHAJIIT]["JUNK"] = bValue end,
                },
                
                [14] = {
                    type = "checkbox",
                    name = "Junk Corundum (Nord)",
                    tooltip = "When ON All Corundum will be junked. These are for the Nord style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_NORD]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_NORD]["JUNK"] = bValue end,
                },
                
                [15] = {
                    type = "checkbox",
                    name = "Junk Manganese (Orc)",
                    tooltip = "When ON All Manganese will be junked. These are for the Orc style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_ORC]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_ORC]["JUNK"] = bValue end,
                },
                
                [16] = {
                    type = "checkbox",
                    name = "Junk Argentum (Primal)",
                    tooltip = "When ON All Argentum will be junked. These are for the Primal style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_ENEMY_PRIMITIVE]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_ENEMY_PRIMITIVE]["JUNK"] = bValue end,
                },
                
                [17] = {
                    type = "checkbox",
                    name = "Junk Starmetal (Redguard)",
                    tooltip = "When ON All Starmetal will be junked. These are for the Redguard style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_REDGUARD]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_REDGUARD]["JUNK"] = bValue end,
                },
                
                [18] = {
                    type = "checkbox",
                    name = zo_strformat("<<1>> (<<2>>)", "Junk Malachite", GetString("SI_ITEMSTYLE", ITEMSTYLE_GLASS)),
                    tooltip = "When ON All Goldscale will be junked. These are for the Glass style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_GLASS]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_GLASS]["JUNK"] = bValue end,
                },
                [19] = {
                    type = "checkbox",
                    name = zo_strformat("<<1>> (<<2>>)", "Junk Charcole of Remorse", GetString("SI_ITEMSTYLE", ITEMSTYLE_AREA_XIVKYN)),
                    tooltip = "When ON All Charcole of Remorse will be junked. These are for the Xivkyn style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_XIVKYN]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_XIVKYN]["JUNK"] = bValue end,
                },
                [20] = {
                    type = "checkbox",
                    name = zo_strformat("<<1>> (<<2>>)", "Junk Cassiterite", GetString("SI_ITEMSTYLE", ITEMSTYLE_AREA_ANCIENT_ORC)),
                    tooltip = "When ON All Cassiterite will be junked. These are for the Anchient Orc style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_ANCIENT_ORC]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_ANCIENT_ORC]["JUNK"] = bValue end,
                },
                [21] = {
                    type = "checkbox",
                    name = zo_strformat("<<1>> (<<2>>)", "Junk Laurel", GetString("SI_ITEMSTYLE", ITEMSTYLE_UNDAUNTED)),
                    tooltip = "When ON All Laurel will be junked. These are for the Mercenary style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_UNDAUNTED]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_UNDAUNTED]["JUNK"] = bValue end,
                },
                [22] = {
                    type = "checkbox",
                    name = zo_strformat("<<1>> (<<2>>)", "Junk Goldscale", GetString("SI_ITEMSTYLE", ITEMSTYLE_AREA_AKAVIRI)),
                    tooltip = "When ON All Goldscale will be junked. These are for the Akaviri style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_AKAVIRI]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_AKAVIRI]["JUNK"] = bValue end,
                },
            },
        },	
        
local rlink = GetItemLinkRefinedMaterialItemLink("|H0:item:57665:30:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h")
local rlinkCT = GetItemLinkItemStyle(rlink)
d("rlink: "..rlink)
d("rlinkCT: "..rlinkCT)
        --]]
        [24] = {
            type = "submenu",
            name = "Style Material Junk Filters",
            controls = {
                [1] = {
                    type = "checkbox",
                    name = "Junk All Style Materials",
                    tooltip = "When ON All Style Materials will be junked.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] = bValue end,
                    reference = "AutoJunker_STYLE_MATERIAL",
                },
                
                [2] = {
                    type = "description",
                    text = colorYellow.."The All Style Materials junk filter must be off to use any of the junk filters below.",
                },
                
                [3] = {	
                    type = "checkbox",
                    name = "Junk Adamantite (Altmer)",
                    tooltip = "When ON All Adamantite will be junked. These are for the Altmer style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_HIGH_ELF]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_HIGH_ELF]["JUNK"] = bValue end,
                },
                
                [4] = {
                    type = "checkbox",
                    name = "Junk Palladium (Ancient Elf)",
                    tooltip = "When ON All Palladium will be junked. These are for the Ancient Elf style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_ANCIENT_ELF]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_ANCIENT_ELF]["JUNK"] = bValue end,
                },
                
                [5] = {
                    type = "checkbox",
                    name = "Junk Flint (Argonian)",
                    tooltip = "When ON All Flint will be junked. These are for the Argonian style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_ARGONIAN]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_ARGONIAN]["JUNK"] = bValue end,
                },
                
                [6] = {
                    type = "checkbox",
                    name = "Junk Copper (Barbaric)",
                    tooltip = "When ON All Copper will be junked. These are for the Barbaric style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_REACH]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_REACH]["JUNK"] = bValue end,
                },
                
                [7] = {
                    type = "checkbox",
                    name = "Junk Bone (Bosmer)",
                    tooltip = "When ON All Bone will be junked. These are for the Bosmer style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_WOOD_ELF]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_WOOD_ELF]["JUNK"] = bValue end,
                },
                
                [8] = {
                    type = "checkbox",
                    name = "Junk Molybdenum (Breton)",
                    tooltip = "When ON All Molybdenum will be junked. These are for the Breton style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_BRETON]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_BRETON]["JUNK"] = bValue end,
                },
                
                [9] = {
                    type = "checkbox",
                    name = "Junk Daedra Heart (Daedric)",
                    tooltip = "When ON All Daedra Hearts will be junked. These are for the Daedric style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_ENEMY_DAEDRIC]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_ENEMY_DAEDRIC]["JUNK"] = bValue end,
                },
                
                [10] = {
                    type = "checkbox",
                    name = "Junk Obsidian (Dunmer)",
                    tooltip = "When ON All Obsidian will be junked. These are for the Dunmer style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_DARK_ELF]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_DARK_ELF]["JUNK"] = bValue end,
                },
                
                [11] = {
                    type = "checkbox",
                    name = "Junk Dwemer Frame (Dwemer)",
                    tooltip = "When ON All Dwemer Frames will be junked. These are for the Dwemer style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_DWEMER]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_DWEMER]["JUNK"] = bValue end,
                },
                
                [12] = {
                    type = "checkbox",
                    name = "Junk Nickel (Imperial)",
                    tooltip = "When ON All Nickel will be junked. These are for the Imperial style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_IMPERIAL]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_IMPERIAL]["JUNK"] = bValue end,
                },
                
                [13] = {
                    type = "checkbox",
                    name = "Junk Moonstone (Khajit)",
                    tooltip = "When ON All Moonstone will be junked. These are for the Khajit style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_KHAJIIT]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_KHAJIIT]["JUNK"] = bValue end,
                },
                
                [14] = {
                    type = "checkbox",
                    name = "Junk Corundum (Nord)",
                    tooltip = "When ON All Corundum will be junked. These are for the Nord style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_NORD]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_NORD]["JUNK"] = bValue end,
                },
                
                [15] = {
                    type = "checkbox",
                    name = "Junk Manganese (Orc)",
                    tooltip = "When ON All Manganese will be junked. These are for the Orc style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_ORC]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_ORC]["JUNK"] = bValue end,
                },
                
                [16] = {
                    type = "checkbox",
                    name = "Junk Argentum (Primal)",
                    tooltip = "When ON All Argentum will be junked. These are for the Primal style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_ENEMY_PRIMITIVE]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_ENEMY_PRIMITIVE]["JUNK"] = bValue end,
                },
                
                [17] = {
                    type = "checkbox",
                    name = "Junk Starmetal (Redguard)",
                    tooltip = "When ON All Starmetal will be junked. These are for the Redguard style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_REDGUARD]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_RACIAL_REDGUARD]["JUNK"] = bValue end,
                },
                
                [18] = {
                    type = "checkbox",
                    name = zo_strformat("<<1>> (<<2>>)", "Junk Malachite", GetString("SI_ITEMSTYLE", ITEMSTYLE_GLASS)),
                    tooltip = "When ON All Goldscale will be junked. These are for the Glass style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_GLASS]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_GLASS]["JUNK"] = bValue end,
                },
                [19] = {
                    type = "checkbox",
                    name = zo_strformat("<<1>> (<<2>>)", "Junk Charcole of Remorse", GetString("SI_ITEMSTYLE", ITEMSTYLE_AREA_XIVKYN)),
                    tooltip = "When ON All Charcole of Remorse will be junked. These are for the Xivkyn style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_XIVKYN]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_XIVKYN]["JUNK"] = bValue end,
                },
                [20] = {
                    type = "checkbox",
                    name = zo_strformat("<<1>> (<<2>>)", "Junk Cassiterite", GetString("SI_ITEMSTYLE", ITEMSTYLE_AREA_ANCIENT_ORC)),
                    tooltip = "When ON All Cassiterite will be junked. These are for the Anchient Orc style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_ANCIENT_ORC]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_ANCIENT_ORC]["JUNK"] = bValue end,
                },
                [21] = {
                    type = "checkbox",
                    name = zo_strformat("<<1>> (<<2>>)", "Junk Laurel", GetString("SI_ITEMSTYLE", ITEMSTYLE_UNDAUNTED)),
                    tooltip = "When ON All Laurel will be junked. These are for the Mercenary style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_UNDAUNTED]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_UNDAUNTED]["JUNK"] = bValue end,
                },
                [22] = {
                    type = "checkbox",
                    name = zo_strformat("<<1>> (<<2>>)", "Junk Goldscale", GetString("SI_ITEMSTYLE", ITEMSTYLE_AREA_AKAVIRI)),
                    tooltip = "When ON All Goldscale will be junked. These are for the Akaviri style.",
                    default = false,
                    width 	= "half",
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_AKAVIRI]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][ITEMSTYLE_AREA_AKAVIRI]["JUNK"] = bValue end,
                },
            },
        },	
        
        [25] = {
            type = "submenu",
            name = "Armor Trait Material Junk Filters",
            controls = {
                [1] = {
                    type = "checkbox",
                    name = "Junk All Armor Trait Materials",
                    tooltip = "When ON All Armor Trait Materials will be junked.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT]["JUNK"]  end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT]["JUNK"]  = bValue end,
                    reference = "AutoJunker_ARMOR_TRAITS",
                },
                
                [2] = {
                    type = "description",
                    text = colorYellow.."The All Armor Traits junk filter must be off to use any of the junk filters below.",
                },
                
                [3] = {
                    type = "checkbox",
                    name = "Junk Sapphires (Divine)",
                    tooltip = "When ON All Sapphires will be junked. These are for the Divine trait.",
                    width = "half",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][ITEM_TRAIT_TYPE_ARMOR_DIVINES]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][ITEM_TRAIT_TYPE_ARMOR_DIVINES]["JUNK"] = bValue end,
                },
                [4] = {
                    type = "checkbox",
                    name = "Junk Garnets (Exploration)",
                    tooltip = "When ON All Garnets will be junked. These are for the Exploration trait.",
                    width = "half",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][ITEM_TRAIT_TYPE_ARMOR_EXPLORATION]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][ITEM_TRAIT_TYPE_ARMOR_EXPLORATION]["JUNK"] = bValue end,
                },
                [5] = {
                    type = "checkbox",
                    name = "Junk Diamonds (Impenetrable)",
                    tooltip = "When ON All Diamonds will be junked. These are for the Impenetrable trait.",
                    width = "half",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][ITEM_TRAIT_TYPE_ARMOR_IMPENETRABLE]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][ITEM_TRAIT_TYPE_ARMOR_IMPENETRABLE]["JUNK"] = bValue end,
                },
                [6] = {
                    type = "checkbox",
                    name = "Junk Bloodstones (Infused)",
                    tooltip = "When ON All Bloodstones will be junked. These are for the Infused trait.",
                    width = "half",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][ITEM_TRAIT_TYPE_ARMOR_INFUSED]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][ITEM_TRAIT_TYPE_ARMOR_INFUSED]["JUNK"] = bValue end,
                },
                [7] = {
                    type = "checkbox",
                    name = "Junk Fortified Nirncrux (Nirnhoned)",
                    tooltip = "When ON All Fortified Nirncrux will be junked. These are for the Nirnhoned trait.",
                    width = "half",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][ITEM_TRAIT_TYPE_ARMOR_NIRNHONED]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][ITEM_TRAIT_TYPE_ARMOR_NIRNHONED]["JUNK"] = bValue end,
                },
                [8] = {
                    type = "checkbox",
                    name = "Junk Sardonyx (Reinforced)",
                    tooltip = "When ON All Sardonyx will be junked. These are for the Reinforced trait.",
                    width = "half",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][ITEM_TRAIT_TYPE_ARMOR_REINFORCED]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][ITEM_TRAIT_TYPE_ARMOR_REINFORCED]["JUNK"] = bValue end,
                },
                [9] = {
                    type = "checkbox",
                    name = "Junk Quartz (Sturdy)",
                    tooltip = "When ON All Quartz will be junked. These are for the Sturdy trait.",
                    width = "half",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][ITEM_TRAIT_TYPE_ARMOR_STURDY]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][ITEM_TRAIT_TYPE_ARMOR_STURDY]["JUNK"] = bValue end,
                },
                [10] = {
                    type = "checkbox",
                    name = "Junk Emeralds (Training)",
                    tooltip = "When ON All Emeralds will be junked. These are for the Training trait.",
                    width = "half",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][ITEM_TRAIT_TYPE_ARMOR_TRAINING]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][ITEM_TRAIT_TYPE_ARMOR_TRAINING]["JUNK"] = bValue end,
                },
                [11] = {
                    type = "checkbox",
                    name = "Junk Almandine (Well-Fitted)",
                    tooltip = "When ON All Almandine will be junked. These are for the Well-Fitted trait.",
                    width = "half",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][ITEM_TRAIT_TYPE_ARMOR_WELL_FITTED]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][ITEM_TRAIT_TYPE_ARMOR_WELL_FITTED]["JUNK"] = bValue end,
                },
            },
        },
        
        [26] = {
            type = "submenu",
            name = "Weapon Trait Junk Filters",
            controls = {
                [1] = {
                    type = "checkbox",
                    name = "Junk All Weapon Trait Materials",
                    tooltip = "When ON All Weapon Trait Materials will be junked.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT]["JUNK"]  end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT]["JUNK"]  = bValue end,
                    reference = "AutoJunker_WEAPON_TRAITS",
                },
                
                [2] = {
                    type = "description",
                    text = colorYellow.."The All Weapon Traits junk filter must be off to use any of the junk filters below.",
                },
                
                [3] = {
                    type = "checkbox",
                    name = "Junk Amethysts (Charged)",
                    tooltip = "When ON All Amethysts will be junked. These are for the Charged trait.",
                    width = "half",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][ITEM_TRAIT_TYPE_WEAPON_CHARGED]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][ITEM_TRAIT_TYPE_WEAPON_CHARGED]["JUNK"] = bValue end,
                },
                [4] = {
                    type = "checkbox",
                    name = "Junk Turquoise (Defending)",
                    tooltip = "When ON All Turquoise will be junked. These are for the Defending trait.",
                    width = "half",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][ITEM_TRAIT_TYPE_WEAPON_DEFENDING]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][ITEM_TRAIT_TYPE_WEAPON_DEFENDING]["JUNK"] = bValue end,
                },
                [5] = {
                    type = "checkbox",
                    name = "Junk Jade (Infused)",
                    tooltip = "When ON All Jade will be junked. These are for the Infused trait.",
                    width = "half",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][ITEM_TRAIT_TYPE_WEAPON_INFUSED]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][ITEM_TRAIT_TYPE_WEAPON_INFUSED]["JUNK"] = bValue end,
                },
                [6] = {
                    type = "checkbox",
                    name = "Junk Potent Nirncrux (Nirnhoned)",
                    tooltip = "When ON All Potent Nirncrux will be junked. These are for the Nirnhoned trait.",
                    width = "half",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][ITEM_TRAIT_TYPE_WEAPON_NIRNHONED]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][ITEM_TRAIT_TYPE_WEAPON_NIRNHONED]["JUNK"] = bValue end,
                },
                [7] = {
                    type = "checkbox",
                    name = "Junk Chysolite (Powered)",
                    tooltip = "When ON All Chysolite will be junked. These are for the Powered trait.",
                    width = "half",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][ITEM_TRAIT_TYPE_WEAPON_POWERED]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][ITEM_TRAIT_TYPE_WEAPON_POWERED]["JUNK"] = bValue end,
                },
                [8] = {
                    type = "checkbox",
                    name = "Junk Rubies (Precise)",
                    tooltip = "When ON All Rubies will be junked. These are for the Precise trait.",
                    width = "half",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][ITEM_TRAIT_TYPE_WEAPON_PRECISE]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][ITEM_TRAIT_TYPE_WEAPON_PRECISE]["JUNK"] = bValue end,
                },
                [9] = {
                    type = "checkbox",
                    name = "Junk Fire Opals (Sharpened)",
                    tooltip = "When ON All Fire Opals will be junked. These are for the Sharpened trait.",
                    width = "half",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][ITEM_TRAIT_TYPE_WEAPON_SHARPENED]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][ITEM_TRAIT_TYPE_WEAPON_SHARPENED]["JUNK"] = bValue end,
                },
                [10] = {
                    type = "checkbox",
                    name = "Junk Carnelian (Training)",
                    tooltip = "When ON All Carnelian will be junked. These are for the Training trait.",
                    width = "half",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][ITEM_TRAIT_TYPE_WEAPON_TRAINING]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][ITEM_TRAIT_TYPE_WEAPON_TRAINING]["JUNK"] = bValue end,
                },
                [11] = {
                    type = "checkbox",
                    name = "Junk Citrine (Weighted)",
                    tooltip = "When ON All Citrine will be junked. These are for the Weighted trait.",
                    width = "half",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][ITEM_TRAIT_TYPE_WEAPON_WEIGHTED]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][ITEM_TRAIT_TYPE_WEAPON_WEIGHTED]["JUNK"] = bValue end,
                },
            },
        },
                
        [27] = {
            type = "submenu",
            name = "All Crafting Materials Junk Filter",
            controls = {
                [1] = {
                    type = "description",
                    text = colorRed.."Style Materials, Armor Traits, & Weapon Traits are separate filters independent of (not covered by) the All Crafting Materials filter.",
                },
                
                [2] = {
                    type = "description",
                    text = colorYellow.."All Crafting Materials must be OFF to use ANY of the other crafting material filters including: Glyphs, Alchemy, Blacksmithing, Clothier, Enchanting, Provisioning, or Woodworking filters.",
                },
                
                [3] = {
                    type = "checkbox",	
                    name = "Junk All Crafting Materials",
                    tooltip = "When ON All Crafting Materials will be junked.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] = bValue end,
                },
            },
            reference = "AutoJunker_Crafting_General_SubMenu",
        },	
        
        [28] = {
            type = "submenu",
            name = "Glyph Junk Filters",
            controls = {
                [1] = {
                    type = "description",
                    text = colorYellow.."You must turn off the All Crafting Materials junk filter to use these filters.",
                },

                [2] = {
                type = "dropdown",
                    name = "Junk Armor Glyphs",
                    tooltip = "When a quality is selected All Armor Glyphs at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_GLYPH_ARMOR]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_GLYPH_ARMOR]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_GLYPH_ARMOR]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_GLYPH_ARMOR]["QUALITY"] = iQuality 
                        end,
                },

                [3] = {
                    type = "dropdown",
                    name = "Junk Weapon Glyphs",
                    tooltip = "When a quality is selected All Weapon Glyphs at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_GLYPH_WEAPON]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_GLYPH_WEAPON]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_GLYPH_WEAPON]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_GLYPH_WEAPON]["QUALITY"] = iQuality 
                        end,
                },

                [4] = {
                    type = "dropdown",
                    name = "Junk Jewelry Glyphs",
                    tooltip = "When a quality is selected All Jewelry Glyphs at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_GLYPH_JEWELRY]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_GLYPH_JEWELRY]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_GLYPH_JEWELRY]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_GLYPH_JEWELRY]["QUALITY"] = iQuality 
                        end,
                },
            },

        reference = "AutoJunker_Glyphs_SubMenu",
        },
        
        [29] = {
            type = "submenu",	-- 
            name = "Alchemy Junk Filters",
            controls = {
                [1] = {
                    type = "description",
                    text = colorYellow.."You must turn off the All Crafting Materials junk filter to use these filters.",
                },
                
                [2] = {
                    type = "checkbox",
                    name = "Junk Reagents",
                    tooltip = "When ON All Reagents will be junked.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_REAGENT]["JUNK"] end,
                    setFunc = function(iValue) AutoJunker.SavedVariables[ITEMTYPE_REAGENT]["JUNK"] = iValue end,
                },
                
                [3] = {
                    type = "checkbox",
                    name = "Junk Solvents",
                    tooltip = "When ON All Solvents will be junked.",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_ALCHEMY_BASE]["JUNK"] end,
                    setFunc = function(iValue) AutoJunker.SavedVariables[ITEMTYPE_ALCHEMY_BASE]["JUNK"] = iValue end,
                },
            },
            reference = "AutoJunker_Alchemy_SubMenu",
        },
            
        [30] = {
            type = "submenu",
            name = "Blacksmithing Junk Filters",
            controls = {
                [1] = {
                    type = "description",
                    text = colorYellow.."You must turn off the All Crafting Materials junk filter to use these filters.",
                },
                
                [2] = {
                    type = "checkbox",
                    name = "Junk Blacksmithing Materials",
                    tooltip = "When ON All Blacksmithing Materials will be junked.",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_BLACKSMITHING_MATERIAL]["JUNK"] end,
                    setFunc = function(sValue) AutoJunker.SavedVariables[ITEMTYPE_BLACKSMITHING_MATERIAL]["JUNK"] = sValue
                        end,
                },
                
                [3] = {
                    type = "checkbox",
                    name = "Junk Blacksmithing Raw Materials",
                    tooltip = "When ON All Blacksmithing Raw Materials will be junked.",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_BLACKSMITHING_RAW_MATERIAL]["JUNK"] end,
                    setFunc = function(sValue) AutoJunker.SavedVariables[ITEMTYPE_BLACKSMITHING_RAW_MATERIAL]["JUNK"] = sValue
                        end,
                },

                [4] = {
                    type = "dropdown",
                    name = "Junk Blacksmithing Tempers",
                    tooltip = "When a quality is selected All Blacksmithing Tempers at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_BLACKSMITHING_BOOSTER]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_BLACKSMITHING_BOOSTER]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_BLACKSMITHING_BOOSTER]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_BLACKSMITHING_BOOSTER]["QUALITY"] = iQuality 
                        end,
                },
            },
            reference = "AutoJunker_Blacksmithing_SubMenu",
        },
                
        [31] = {
            type = "submenu",
            name = "Clothier Junk Filters",
            controls = {
                [1] = {	
                    type = "description",
                    text = colorYellow.."You must turn off the All Crafting Materials junk filter to use these filters.",
                },
                
                [2] = {
                    type = "checkbox",
                    name = "Junk Clothier Materials",
                    tooltip = "When ON All Clothier Materials will be junked.",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_CLOTHIER_MATERIAL]["JUNK"] end,
                    setFunc = function(sValue) AutoJunker.SavedVariables[ITEMTYPE_CLOTHIER_MATERIAL]["JUNK"] = sValue
                        end,
                },
                
                [3] = {
                    type = "checkbox",
                    name = "Junk Clothier Raw Materials",
                    tooltip = "When ON All Clothier Raw Materials will be junked.",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_CLOTHIER_RAW_MATERIAL]["JUNK"] end,
                    setFunc = function(sValue) AutoJunker.SavedVariables[ITEMTYPE_CLOTHIER_RAW_MATERIAL]["JUNK"] = sValue
                        end,
                },

                [4] = {
                    type = "dropdown",
                    name = "Junk Clothier Resins",
                    tooltip = "When a quality is selected All Clothier Resins at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_CLOTHIER_BOOSTER]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_CLOTHIER_BOOSTER]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_CLOTHIER_BOOSTER]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_CLOTHIER_BOOSTER]["QUALITY"] = iQuality 
                        end,
                },
            },
            reference = "AutoJunker_Clothier_SubMenu",
        },
                
        [32] = {
            type = "submenu",
            name = "Enchanting Junk Filters",
            controls = {
                [1] = {
                    type = "description",
                    text = colorYellow.."You must turn off the All Crafting Materials junk filter to use these filters.",
                },
                
                [2] = {
                    type = "dropdown",
                    name = "Junk Aspect Runestones",
                    tooltip = "When a quality is selected All Aspect Runestones at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_ENCHANTING_RUNE_ASPECT]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_ENCHANTING_RUNE_ASPECT]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_ENCHANTING_RUNE_ASPECT]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_ENCHANTING_RUNE_ASPECT]["QUALITY"] = iQuality 
                        end,
                },
                
                [3] = {
                    type = "checkbox",
                    name = "Junk Essence Runestones",
                    tooltip = "When ON All Essence Runestones will be junked.",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_ENCHANTING_RUNE_ESSENCE]["JUNK"] end,
                    setFunc = function(sValue) AutoJunker.SavedVariables[ITEMTYPE_ENCHANTING_RUNE_ESSENCE]["JUNK"] = sValue
                        end,
                },
                
                [4] = {
                    type = "checkbox",
                    name = "Junk Potency Runestones",
                    tooltip = "When ON All Potency Runestones will be junked.",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_ENCHANTING_RUNE_POTENCY]["JUNK"] end,
                    setFunc = function(sValue) AutoJunker.SavedVariables[ITEMTYPE_ENCHANTING_RUNE_POTENCY]["JUNK"] = sValue
                        end,
                },
            },
            reference = "AutoJunker_Enchanting_SubMenu",
        },	
                
        [33] = {
            type = "submenu",
            name = "Provisioning Junk Filters",
            controls = {
                [1] = {
                    type = "description",
                    text = colorYellow.."You must turn off the All Crafting Materials junk filter to use these filters.",
                },
                
                [2] = {
                    type = "dropdown",
                    name = "Junk Ingredients",
                    tooltip = "When a quality is selected All Ingredients at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_INGREDIENT]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_INGREDIENT]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_INGREDIENT]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_INGREDIENT]["QUALITY"] = iQuality 
                        end,
                },
                [3] = {
                    type = "dropdown",
                    name = "Junk Flavouring",
                    tooltip = "When a quality is selected All Flavouring at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_FLAVORING]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_FLAVORING]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_FLAVORING]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_FLAVORING]["QUALITY"] = iQuality 
                        end,
                },
                [4] = {
                    type = "dropdown",
                    name = "Junk Spices",
                    tooltip = "When a quality is selected All Spices at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_SPICE]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_SPICE]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_SPICE]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_SPICE]["QUALITY"] = iQuality 
                        end,
                },
                --[[
                [2] = {
                    type = "checkbox",
                    name = "Junk Ingredients",
                    tooltip = "When ON All Provisioning Ingredients will be junked.",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_INGREDIENT]["JUNK"] end,
                    setFunc = function(sValue) AutoJunker.SavedVariables[ITEMTYPE_INGREDIENT]["JUNK"] = sValue
                        end,
                },
                [3] = {
                    type = "checkbox",
                    name = "Junk Flavouring",
                    tooltip = "When ON All Provisioning Flavouring will be junked.",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_FLAVORING]["JUNK"] end,
                    setFunc = function(sValue) AutoJunker.SavedVariables[ITEMTYPE_FLAVORING]["JUNK"] = sValue
                        end,
                },
                
                [4] = {
                    type = "checkbox",
                    name = "Junk Spices",
                    tooltip = "When ON All Provisioning Spices will be junked.",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_SPICE]["JUNK"] end,
                    setFunc = function(sValue) AutoJunker.SavedVariables[ITEMTYPE_SPICE]["JUNK"] = sValue
                        end,
                },
                --]]
            },
            reference = "AutoJunker_Provisioning_SubMenu",
        },	
                
        [34] = {
            type = "submenu",
            name = "Woodworking Junk Filters",
            controls = {
                [1] = {
                    type = "description",
                    text = colorYellow.."You must turn off the All Crafting Materials junk filter to use these filters.",
                },
                
                [2] = {
                    type = "checkbox",
                    name = "Junk Woodworking Materials",
                    tooltip = "When ON All Woodworking Materials will be junked.",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_WOODWORKING_MATERIAL]["JUNK"] end,
                    setFunc = function(sValue) AutoJunker.SavedVariables[ITEMTYPE_WOODWORKING_MATERIAL]["JUNK"] = sValue
                        end,
                },
                
                [3] = {
                    type = "checkbox",
                    name = "Junk Woodworking Raw Materials",
                    tooltip = "When ON All Woodworking Raw Materials will be junked.",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_WOODWORKING_RAW_MATERIAL]["JUNK"] end,
                    setFunc = function(sValue) AutoJunker.SavedVariables[ITEMTYPE_WOODWORKING_RAW_MATERIAL]["JUNK"] = sValue
                        end,
                },

                [4] = {
                    type = "dropdown",
                    name = "Junk Woodworking Tannins",
                    tooltip = "When a quality is selected All Woodworking Tannins at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_WOODWORKING_BOOSTER]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_WOODWORKING_BOOSTER]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_WOODWORKING_BOOSTER]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_WOODWORKING_BOOSTER]["QUALITY"] = iQuality 
                        end,
                },
            },
            reference = "AutoJunker_Woodworking_SubMenu",
        },	

        [35] = {
            type = "submenu",
            name = "Jewelrycraft Junk Filters",
            controls = {
                [1] = {
                    type = "description",
                    text = colorYellow.."You must turn off the All Crafting Materials junk filter to use these filters.",
                },
                
                [2] = {
                    type = "checkbox",
                    name = "Junk Jewelrycraft Materials",
                    tooltip = "When ON All Jewelrycraft Materials will be junked.",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_JEWELRYCRAFTING_MATERIAL]["JUNK"] end,
                    setFunc = function(sValue) AutoJunker.SavedVariables[ITEMTYPE_JEWELRYCRAFTING_MATERIAL]["JUNK"] = sValue
                        end,
                },
                
                [3] = {
                    type = "checkbox",
                    name = "Junk Jewelrycraft Raw Materials",
                    tooltip = "When ON All Jewelrycraft Raw Materials will be junked.",
                    default = false,
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return AutoJunker.SavedVariables[ITEMTYPE_JEWELRYCRAFTING_RAW_MATERIAL]["JUNK"] end,
                    setFunc = function(sValue) AutoJunker.SavedVariables[ITEMTYPE_JEWELRYCRAFTING_RAW_MATERIAL]["JUNK"] = sValue
                        end,
                },

                [4] = {
                    type = "dropdown",
                    name = "Junk Jewelrycraft Tannins",
                    tooltip = "When a quality is selected All Jewelrycraft Upgrade Grains at or below the selected quality level will be junked.",
                    choices = tQualities,
                    default = tQualities[1],
                    disabled = function() return AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"] end,
                    getFunc = function() return GetMenuQualityName(AutoJunker.SavedVariables[ITEMTYPE_JEWELRYCRAFTING_BOOSTER]["JUNK"], AutoJunker.SavedVariables[ITEMTYPE_JEWELRYCRAFTING_BOOSTER]["QUALITY"]) end,
                    setFunc = function(sValue) 
                        local bIsJunk, iQuality = GetJunkQualityFromMenuSetting(sValue)
                        AutoJunker.SavedVariables[ITEMTYPE_JEWELRYCRAFTING_BOOSTER]["JUNK"] = bIsJunk
                        AutoJunker.SavedVariables[ITEMTYPE_JEWELRYCRAFTING_BOOSTER]["QUALITY"] = iQuality 
                        end,
                },
            },
            reference = "AutoJunker_Jewelrycraft_SubMenu",
        },	

        [36] = {
            type = "description",
        },
                
        [37] = {
            type = "header",
            name = colorYellow.."Destruction",
        },
        
        [38] = {
            type = "description",
            --type = "header",
            text = "This section contains settings for destroying junk with 0 sell price.",
        },

        [39] = {	-- AUTO-DESTROY
            type = "submenu",
            name = "Destruction",
            controls = {
                [1] = {
                    type = "header",
                    name = colorMagenta.."HotKey",
                },
                [2] = {
                    type = "description",
                    text = colorYellow.."Destroy 0 Sell Price Items. When turned off it will prevent the keybind from working. When turned on the keybind will destroy all junk with 0 sell price in the currently open backpack or bank junk window. Does not work in the guild bank and the junk window MUST be open for it to work for added protection.",
                },
                [3] = {
                    type = "description",
                    text = colorYellow.."To bind a key for it open your keybindings window and scroll down to AutoJunker.",
                },
                
                [4] = {	
                    type = "checkbox",
                    name = "Destroy 0 Sell Price Items Keybind",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables["AUTODESTROY0VALUEITEMSKEYBIND"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["AUTODESTROY0VALUEITEMSKEYBIND"] = bValue end,
                },
                [5] = {
                    type = "header",
                    name = colorMagenta.."Auto-Destroy",
                },
                [6] = {
                    type = "description",
                    text = colorYellow.."When \"Auto-Destroy 0 Sell Price Items\" option is turned on AutoJunker will automatically destroy items you pick up that have 0 sell price.",
                },
                
                [7] = {
                    type = "description",
                    text = colorRed.."WARNING: "..colorYellow.."Some crafting materials have 0 sell price. There may be some quest items that have 0 sell price to. You may pick up some item that you want, but don't realize it has 0 sell price and it will end up getting destroyed.",
                },
                
                [8] = {	-- Auto-Destroy 0 value junk
                    type = "checkbox",
                    name = "Auto-Destroy 0 Sell Price Items",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables["AUTODESTROY0VALUEITEMS"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["AUTODESTROY0VALUEITEMS"] = bValue end,
                },
                
                [9] = {
                    type = "description",
                    text = colorYellow.."Adds a popup dialog box asking you to confirm if you want AutoJunker to destroy the 0 Sell Price Junk item you picked up. \"Destroy 0 Sell Price Junk\" must be turned on for this to work.",
                },
                [10] = {	-- Auto-Destroy 0 value junk
                    type = "checkbox",
                    name = "Auto-Destroy Confirmation",
                    default = false,
                    getFunc = function() return AutoJunker.SavedVariables["AUTODESTROY0VALUEITEMSCONFIRM"] end,
                    setFunc = function(bValue) AutoJunker.SavedVariables["AUTODESTROY0VALUEITEMSCONFIRM"] = bValue end,
                },
            },
        },	
        
        [40] = {
            type = "description",
        },
    }

    LAM2:RegisterOptionControls("AutoJunker_Addon_Options", optionsData)
end

