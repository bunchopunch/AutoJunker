
local LII = LibStub:GetLibrary("LibItemInfo-1.0")

-------------------------------------------------------------------------------------------------
--  Colors  --
-------------------------------------------------------------------------------------------------
local colorRed 			= "|cFF0000" 	-- Red
local colorYellow 		= "|cFFFF00" 	-- yellow 
local colorGreen 		= "|c00FF00" 	-- green
local colorMagenta		= "|cFF00FF"	-- Magenta
local colorDrkOrange 	= "|cFFA500"	-- Dark Orange


--=========================================================================--
--== These functions are where the main logic work takes place, most ======--
--== changes will be done here ====--
--=========================================================================--
function AutoJunker.FormatJunkDebugMsg(_bIsJunk, _lLink, _sMsg)
	local debugWin = AutoJunker.DebugWin
	
	if _bIsJunk then
		return colorRed.."Junking ".._lLink..": "..colorYellow.." ".._sMsg
	end
	return colorGreen.."Keeping ".._lLink..": "..colorYellow.." ".._sMsg
end

--======================================--
--========  Text Filter Checks =========--
--======================================--
local function MatchesWhiteList(_tItemInfo) 
	for k,v in pairs(AutoJunker.SavedVariables["WHITELIST"]) do
		if _tItemInfo["NAME"]:lower():find(v:lower()) then
			return true, AutoJunker.FormatJunkDebugMsg(false, _tItemInfo.LINK, "Matches text on whitelist filter.")
		end
	end
	return false
end

local function MatchesBlackList(_tItemInfo)
	for k,v in pairs(AutoJunker.SavedVariables["BLACKLIST"]) do
		if _tItemInfo["NAME"]:lower():find(v:lower()) then
			return true, AutoJunker.FormatJunkDebugMsg(true, _tItemInfo.LINK, "Matches text on blacklist filter.")
		end
	end
	return false
end

--===================================================--
--====  Matches KEEP filters (exclusion filters) ====--
--===================================================--
local function KeepForUnique(_tItemInfo)
	if AutoJunker.SavedVariables["KEEPUNIQUEITEMS"] and IsItemLinkUnique(_tItemInfo["LINK"]) then
		return true, AutoJunker.FormatJunkDebugMsg(false, _tItemInfo.LINK, "Matches KEEP Unique Items filter.")
	end
	return false
end

local function KeepForSet(_tItemInfo)
	if AutoJunker.SavedVariables["KEEPSETITEMS"] and GetItemLinkSetInfo(_tItemInfo["LINK"]) then
		return true, AutoJunker.FormatJunkDebugMsg(false, _tItemInfo.LINK, "Matches KEEP Set Items filter.")
	end
	return false
end

local function KeepCraftedItem(_tItemInfo)
	local iLink = _tItemInfo["LINK"]
	local isCraftedPotion = false
	
	if _tItemInfo["ITEMTYPE"] == ITEMTYPE_POTION and select(24, ZO_LinkHandler_ParseLink(iLink)) ~= "0" then
		isCraftedPotion = true
	end
	
	if AutoJunker.SavedVariables["KEEPCRAFTEDITEMS"] then
		if isCraftedPotion or IsItemLinkCrafted(_tItemInfo["LINK"]) then
			return true, AutoJunker.FormatJunkDebugMsg(false, _tItemInfo.LINK, "Matches KEEP Crafted Items filter.")
		end
	end
	return false
end

local function KeepPetItem(_tItemInfo)
	if AutoJunker.SavedVariables["KEEPPETITEMS"] and _tItemInfo["ICONPATH"]:lower():find("icons/pet_") then
		return true, AutoJunker.FormatJunkDebugMsg(false, _tItemInfo.LINK, "Matches Keep Pet Items filter.")
	end
	return false
end

--===================================================--
--== Functions for determining if an item should be ==--
--== junked for 0 sell price ==--
--===================================================--
local function JunkFor0SellPrice(_tItemInfo)
	if _tItemInfo["SELLPRICE"] ~= 0 then return false end
	
	if AutoJunker.SavedVariables["SELLZEROVALUEITEMS"] then
		return true, AutoJunker.FormatJunkDebugMsg(true, _tItemInfo.LINK, "Matches Zero Value Items filter, in the Other Items submenu.")
	elseif (_tItemInfo["ITEMTYPE"] == ITEMTYPE_WEAPON) and AutoJunker.SavedVariables["ZEROVALUEWEAPONS"] then
		return true, AutoJunker.FormatJunkDebugMsg(true, _tItemInfo.LINK, "Matches Zero Value Weapons filter, in the Weapons submenu.")
	elseif (_tItemInfo["ITEMTYPE"] == ITEMTYPE_ARMOR) and AutoJunker.SavedVariables["ZEROVALUEARMOR"] then
		return true, AutoJunker.FormatJunkDebugMsg(true, _tItemInfo.LINK, "Matches Zero Value Armor filter, in the Armor submenu.")
	end
	return false
end

--===================================================--
--========  Other Junk Filters  ========--
--===================================================--
local function IsToolJunk(_tItemInfo)
	-- Only used for tools, if not one of those return false
	if _tItemInfo["ITEMTYPE"] ~= ITEMTYPE_TOOL then return false end
	local toolSubTable
	
	-- there is no normal quality check for these, they are either junk or not
	-- quality is used to determine the type of tool
	-- if its white or lower its a lockpick
	-- I don't have to worry about the debug msg printing in this function because
	-- the I'm passing in ITEM_QUALITY_NORMAL, which is a guranteed number
	if AutoJunker.MeetsQualityCheck(_tItemInfo["QUALITY"], ITEM_QUALITY_NORMAL, "IsToolJunk") then
		toolSubTable = "lockpicks"
	else
		toolSubTable = "repairKits"
	end
	
	-- If not set to junk, return false
	local bIsItemTypeJunk = AutoJunker.SavedVariables[ITEMTYPE_TOOL][toolSubTable]["JUNK"]
	if not bIsItemTypeJunk then return false end
	
	local filterName = AutoJunker.SavedVariables[ITEMTYPE_TOOL][toolSubTable]["FILTERNAME"]
	
	-- Else return true & the reason message
	if bIsItemTypeJunk then
		return true, AutoJunker.FormatJunkDebugMsg(true, _tItemInfo.LINK, "Matches the "..filterName.." filter.")
	end
	return false
end
local function IsItemTypeJunk(_tItemInfo)
	-- special exception for tools, spliting into lockpicks & repair kits
	if _tItemInfo["ITEMTYPE"] == ITEMTYPE_TOOL then
		return IsToolJunk(_tItemInfo) 
	end
	
	-- If not set to junk, return false
	local bIsItemTypeJunk = AutoJunker.SavedVariables[_tItemInfo["ITEMTYPE"]]["JUNK"]
	if not bIsItemTypeJunk then return false end
	
	-- If it doesn't meet the required quality level, return false
	local bMeetsQualityCheck = AutoJunker.MeetsQualityCheck(_tItemInfo["QUALITY"], AutoJunker.SavedVariables[_tItemInfo["ITEMTYPE"]]["QUALITY"], "IsItemTypeJunk", _tItemInfo["NAME"], _tItemInfo["ITEMTYPE"])
	if not bMeetsQualityCheck then return false end
	
	-- Else return true & the reason message
	return true, AutoJunker.FormatJunkDebugMsg(true, _tItemInfo.LINK, "Matches the "..AutoJunker.SavedVariables[_tItemInfo["ITEMTYPE"]]["FILTERNAME"].." filter.")
end

local function IsStolenItemJunk(_tItemInfo)
	if not _tItemInfo["STOLEN"] then return false end
	
	-- If not set to junk, return false
	if not AutoJunker.SavedVariables["STOLEN_ITEMS"]["JUNK"] then return false end
	
	-- If were excluding equipable items & its equippable, return false
	if GetItemLinkEquipType(_tItemInfo["LINK"]) ~= EQUIP_TYPE_INVALID then
		if AutoJunker.SavedVariables["EXCLUDE_EQUIPABLE_STOLEN"] then
			return false
		end
	end
	
	-- If it doesn't meet the required quality level, return false
	local bMeetsQualityCheck = AutoJunker.MeetsQualityCheck(_tItemInfo["QUALITY"], AutoJunker.SavedVariables["STOLEN_ITEMS"]["QUALITY"], "IsStolenItemJunk")
	if not bMeetsQualityCheck then return false end
	
	-- Else return true & the reason message
	return true, AutoJunker.FormatJunkDebugMsg(true, _tItemInfo.LINK, "Matches the "..AutoJunker.SavedVariables["STOLEN_ITEMS"]["FILTERNAME"].." filter.")
end

local function AreAllCraftingMatsJunk(_tItemInfo)
	local bIsItemTypeJunk = AutoJunker.SavedVariables["ITEMTYPE_ALL_CRAFTING_MATERIALS"]["JUNK"]
	
	if bIsItemTypeJunk and (GetItemLinkCraftingSkillType(_tItemInfo["LINK"]) ~= CRAFTING_TYPE_INVALID) then
		return true, AutoJunker.FormatJunkDebugMsg(true, _tItemInfo.LINK, "Matches All Crafting Materials junk filter.")
	end
	return false
end

local function IsSubTypeJunk(_tItemInfo)
	-- Only used for armor & weapons, if not one of those return false
	if ((_tItemInfo["ITEMTYPE"] ~= ITEMTYPE_ARMOR) 
	and (_tItemInfo["ITEMTYPE"] ~= ITEMTYPE_WEAPON)) then return false end
	
	-- If not set to junk, return false
	local bIsItemTypeJunk = AutoJunker.SavedVariables[_tItemInfo["ITEMTYPE"]][_tItemInfo["SUBTYPE"]]["JUNK"]
	if not bIsItemTypeJunk then return end
	
	-- If it doesn't meet the required quality level, return false
	local bMeetsQualityCheck = AutoJunker.MeetsQualityCheck(_tItemInfo["QUALITY"], AutoJunker.SavedVariables[_tItemInfo["ITEMTYPE"]][_tItemInfo["SUBTYPE"]]["QUALITY"], "IsSubTypeJunk")
	if not bMeetsQualityCheck then return false end

	-- Else return true & the reason message
	return true, AutoJunker.FormatJunkDebugMsg(true, _tItemInfo.LINK, AutoJunker.SavedVariables[_tItemInfo["ITEMTYPE"]][_tItemInfo["SUBTYPE"]]["FILTERNAME"])
end

local function JunkOrnateItem(_tItemInfo)
	if not AutoJunker.SavedVariables["ORNATETRAITITEMS"] then return false end
	local iItemTrait = GetItemLinkTraitInfo(_tItemInfo["LINK"])
	
	if ((iItemTrait == ITEM_TRAIT_TYPE_ARMOR_ORNATE) or (iItemTrait == ITEM_TRAIT_TYPE_JEWELRY_ORNATE)
	or (iItemTrait == ITEM_TRAIT_TYPE_WEAPON_ORNATE)) then
		return true, AutoJunker.FormatJunkDebugMsg(true, _tItemInfo.LINK, "Matches the Ornate Items junk filter.")
	end
	return false
end

local function IsStyleJunk(_tItemInfo)
	if _tItemInfo["ITEMTYPE"] ~= ITEMTYPE_STYLE_MATERIAL then return false end
	
	-- or if this particular style of style material is junk
	if AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][_tItemInfo["STYLE"]] and AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][_tItemInfo["STYLE"]]["JUNK"] then
		return true, AutoJunker.FormatJunkDebugMsg(true, _tItemInfo.LINK, AutoJunker.SavedVariables[ITEMTYPE_STYLE_MATERIAL][_tItemInfo["STYLE"]]["FILTERNAME"])
	end
	return false
end

local function IsArmorTraitJunk(_tItemInfo)
	if _tItemInfo["ITEMTYPE"] ~= ITEMTYPE_ARMOR_TRAIT then return false end
	
	local traitType = GetItemLinkTraitInfo(_tItemInfo["LINK"])
	-- if this particular trait is junk
	if AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][traitType]["JUNK"] then
		return true, AutoJunker.FormatJunkDebugMsg(true, _tItemInfo.LINK, AutoJunker.SavedVariables[ITEMTYPE_ARMOR_TRAIT][traitType]["FILTERNAME"])
	end
	return false
end

local function IsWeaponTraitJunk(_tItemInfo)
	if _tItemInfo["ITEMTYPE"] ~= ITEMTYPE_WEAPON_TRAIT then return false end
	
	local traitType = GetItemLinkTraitInfo(_tItemInfo["LINK"])
	-- if this particular trait is junk
	if AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][traitType]["JUNK"] then
		return true, AutoJunker.FormatJunkDebugMsg(true, _tItemInfo.LINK, AutoJunker.SavedVariables[ITEMTYPE_WEAPON_TRAIT][traitType]["FILTERNAME"])
	end
	return false
end

local function HasSaveMark(_tItemInfo)
	local bagId 	= _tItemInfo["BAGIDORLINK"]
	local slotId 	= _tItemInfo["SLOTID"]
	-- Can not and dont need to check links, those could only be
	-- loot items & cant have marks
	if not slotId then return false end
	
    local slotData = SHARED_INVENTORY:GenerateSingleSlotData(bagId, slotId)
	
    if ((slotData == nil) or (slotData.stackCount < 1)) then
		return false
	end
	-- First return will be nil if there is no filter
	return slotData.FilterIt_CurrentFilter, AutoJunker.FormatJunkDebugMsg(false, _tItemInfo.LINK, "Item has a FilterIt Save Mark on it.")
end

local function GetInfo(_BagIdOrLink, _iSlotId)
	local lLink = LII:GetFormattedItemLink(_BagIdOrLink, _iSlotId)
	local sName = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName(lLink))
	local sIcon, iSellPrice, bMeetsUsageRequirement, iEquipType, iItemStyle = GetItemLinkInfo(lLink)
	local iQuality = GetItemLinkQuality(lLink)
	local iItemType = GetItemLinkItemType(lLink)
	local iSubType 	= LII:GetSubType(_BagIdOrLink, _iSlotId)
	local iEquipType = GetItemLinkEquipType(lLink)
	local bIsStolen = IsItemLinkStolen(lLink)
	local iLevel	= GetItemLinkRequiredLevel(lLink)
	local iVetRank	= GetItemLinkRequiredVeteranRank(lLink)
	
	local tItemInfo = {
		["BAGIDORLINK"] 	= _BagIdOrLink,
		["SLOTID"] 			= _iSlotId,
		["LINK"]			= lLink,
		["NAME"]			= sName,
		["ICONPATH"]		= sIcon,
		["SELLPRICE"]		= iSellPrice,
		["QUALITY"]			= iQuality,
		["ITEMTYPE"]		= iItemType,
		["SUBTYPE"]			= iSubType,
		["EQUIPTYPE"]		= iEquipType,
		["STYLE"]			= iItemStyle,
		["STOLEN"]			= bIsStolen,
		["LEVEL"]			= iLevel,
		["VETRANK"]			= iVetRank,
	}
	return tItemInfo
end
AutoJunker.testGetInfo = GetInfo

function AutoJunker.IsItemJunk(_BagIdOrLink, _iSlotId)
--[[
Hold off on this until addon loaded library support is added
	-- If the item comes in as a link, its a looted item & can't possibly be marked yet
	-- So only need to check if its already in a bag/slot
	if _iSlotId then
		local instanceId = GetItemInstanceId(_BagIdOrLink, _iSlotId)
		local isFCOMarked = FCOIsMarked(instanceId, -1)
		if isFCOMarked then return false end
	end
--]]
	local tItemInfo = GetInfo(_BagIdOrLink, _iSlotId)
	local debugReasonMsg = AutoJunker.FormatJunkDebugMsg(false, tItemInfo.LINK, "Does not match any junk or keep filters.")
	local bIsJunk, bNotJunk, sReason, tNeedInfo
	
	--====  Check for Unknown ItemTypes ====--
	local shouldProcess, sReason = AutoJunker.IsAHandledItemType(_BagIdOrLink, _iSlotId)
	if not shouldProcess then
		return false, sReason
	end
	
	--==== Check for FilterIt Marks ====--
	bNotJunk, sReason = HasSaveMark(tItemInfo)
	if bNotJunk then
		return false, sReason
	end
	
	-- Must be first, overrides all other filters
	bNotJunk, sReason = MatchesWhiteList(tItemInfo)
	if bNotJunk then
		return false, sReason
	end
	
	-- Must be second, overrides all other filters (except whitelist)
	bIsJunk, sReason = MatchesBlackList(tItemInfo)
	if bIsJunk then
		return true, sReason
	end
			
	local matchType, sReason = AutoJunker.CheckAdvancedFilters(tItemInfo)
	if matchType then
		if matchType == "JUNK" then
			return true, sReason
		elseif matchType == "KEEP" then
			return false, sReason
		end
	end
	bNotJunk, sReason = KeepCraftedItem(tItemInfo)
	if bNotJunk then
		return false, sReason
	end
	
	-- Must be third, overrides all filters except whitelist,blacklist, & Advanced filters
	tNeedInfo, sReason = AutoJunker.KeepForResearch(_BagIdOrLink, _iSlotId)
	if tNeedInfo then
		return false, sReason
	end

	bNotJunk, sReason = KeepForUnique(tItemInfo)
	if bNotJunk then
		return false, sReason
	end
	
	bNotJunk, sReason = KeepForSet(tItemInfo)
	if bNotJunk then
		return false, sReason
	end
		
	bNotJunk, sReason = KeepPetItem(tItemInfo)
	if bNotJunk then
		return false, sReason
	end
		
	bNotJunk, sReason = AutoJunker.KeepForValue(tItemInfo)
	if bNotJunk then
		return false, sReason
	end
	
	bIsJunk, sReason = IsStolenItemJunk(tItemInfo)
	if bIsJunk then
		return true, sReason
	end
	
	bIsJunk, sReason = JunkFor0SellPrice(tItemInfo)
	if bIsJunk then
		return true, sReason
	end
		
	bIsJunk, sReason = JunkOrnateItem(tItemInfo)
	if bIsJunk then
		return true, sReason
	end
		
	bIsJunk, sReason = AreAllCraftingMatsJunk(tItemInfo)
	if bIsJunk then
		return true, sReason
	end
	
	bIsJunk, sReason = IsItemTypeJunk(tItemInfo)
	if bIsJunk then
		return true, sReason
	end
	--***********************************************************************************--
	-- Check these AFTER IsItemType junk, that way IsItemType checks to see if corresponding
	-- ALL filter (like all weapons, all armor, all styles, all armor traits, all weapon traits, ect..
	-- are junk before the subfilters. Because if they turn the..all armor filter on, it should not
	-- match the subfilter it should match the All Armor filter...so the All filters are checked first.
	--***********************************************************************************--
	
	bIsJunk, sReason = IsSubTypeJunk(tItemInfo)
	if bIsJunk then
		return true, sReason
	end
	
	bIsJunk, sReason = IsStyleJunk(tItemInfo)
	if bIsJunk then
		return true, sReason
	end
	
	bIsJunk, sReason = IsArmorTraitJunk(tItemInfo)
	if bIsJunk then
		return true, sReason
	end
	
	bIsJunk, sReason = IsWeaponTraitJunk(tItemInfo)
	if bIsJunk then
		return true, sReason
	end
	
	
	return false, debugReasonMsg
end


	
