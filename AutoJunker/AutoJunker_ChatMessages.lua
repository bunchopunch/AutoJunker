
local LII = LibStub:GetLibrary("LibItemInfo-1.0")

-------------------------------------------------------------------------------------------------
--  Colors  --
-------------------------------------------------------------------------------------------------
local colorYellow 		= "|cFFFF00" 	-- yellow 
local colorLightYellow 	= "|cFFFFCC" 	-- light yellow 
local colorGreen	 	= "|c996633" 	-- colorGreen
local colorGreen2	 	= "|cFFFF00" 	-- colorGreen
local colorMagenta		= "|cFF00FF"	-- Magenta
local colorRed 			= "|cFF0000" 	-- Red
local colorDrkOrange 	= "|cFFA500"	-- Dark Orange
local iconYellow		= "|cFFFF33"	-- icon yellow converted to hex: 1, 1, .2
local iconOrange		= "|cFF6600"	-- icon orange converted to hex: 1, .4, 0

function AutoJunker.PrintApplyJunkFiltersMsg(_iNumItemsJunked, _iNumItemsUnJunked)
	d(colorRed.."AutoJunker: "..colorMagenta.."Number of items junked: ".._iNumItemsJunked)
	d(colorRed.."AutoJunker: "..colorDrkOrange.."Number of items unjunked: ".._iNumItemsUnJunked)
	
end
function AutoJunker.AddDebugMsg(_bIsJunk, _lLink, _sMsg)
	local debugWin = AutoJunker.DebugWin
	
	if _bKeep then
		AutoJunker.DebugWin:AddText(colorGreen.."Keeping ".._lLink..": "..colorYellow.." ".._sMsg)
		return
	end
	AutoJunker.DebugWin:AddText(colorRed.."Junking ".._lLink..": "..colorYellow.." ".._sMsg)
end

function AutoJunker.PrintGoldMessage(_Reason, _bGain)
	if AutoJunker.SavedVariables["GOLDMESSAGES"] then
		if _bGain then
			d(colorRed.."AutoJunker: "..colorYellow.."You gained: "..zo_strformat(SI_MONEY_FORMAT, AutoJunker.GoldGainHold)..".")
		else
			d(colorRed.."AutoJunker: "..colorYellow.."You spent: "..zo_strformat(SI_MONEY_FORMAT, math.abs(AutoJunker.GoldLostHold))..".")
		
		end
	end
end

function AutoJunker.PrintRepairMessage(_bAllItems, _iRepairCost)
	if (AutoJunker.SavedVariables["REPAIRMESSAGES"] and (_iRepairCost > 0)) then
		if _bAllItems then
			d(colorRed.."AutoJunker: "..colorYellow.."All Items Repaired, cost: ".._iRepairCost.." gold.")
		else
			d(colorRed.."AutoJunker: "..colorYellow.."Equipped Items Repaired, cost: ".._iRepairCost.." gold.")
		end
	end
end
--------------------------------------------------------------------------------------
--  Function for printing chat msg when Recipes/Researchable items are found --
--------------------------------------------------------------------------------------
function AutoJunker.PrintChatMessages(_BagIdOrLink,  _iSlotId, _bIsJunk)
	local lItemLink = LII:GetItemLink(_BagIdOrLink, _iSlotId)
	local iItemType = GetItemLinkItemType(lItemLink)

	
	-- Looted Junk / Not Junk Item --
	if (AutoJunker.SavedVariables["NOTJUNKEDMESSAGE"] and (not _bIsJunk)) then
		d(colorRed.."AutoJunker: "..colorDrkOrange.."Looted Item: "..zo_strformat(SI_TOOLTIP_ITEM_NAME, lItemLink))
	elseif (AutoJunker.SavedVariables["JUNKEDMESSAGE"] and _bIsJunk) then
		d(colorRed.."AutoJunker: "..colorMagenta.."Looted Junk: "..zo_strformat(SI_TOOLTIP_ITEM_NAME, lItemLink))
	end
	
	----------------------------------------
	-- Unknown Research / Recipe Messages --
	----------------------------------------
	local tNeedInfo = AutoJunker.KeepForResearch(_BagIdOrLink, _iSlotId)
	
	if not tNeedInfo then return end
	local bAreOthersWhoNeedOnWatchList = AutoJunker.AreOtherCharsOnWatchlist(tNeedInfo)
	
	local bShowPlayerResearchMsgs = AutoJunker.SavedVariables["UNKNOWNRESEARCHMESSAGESPLAYER"]
	local bShowOtherResearchMsgs = AutoJunker.SavedVariables["UNKNOWNRESEARCHMESSAGESOTHER"]
	
	if bShowPlayerResearchMsgs and tNeedInfo.PlayerNeeds then
		if iItemType == ITEMTYPE_RECIPE then
			d(colorRed.."AutoJunker: "..iconOrange.."Unknown recipe found: "..zo_strformat(SI_TOOLTIP_ITEM_NAME, lItemLink))
		else
			d(colorRed.."AutoJunker: "..iconOrange.."Research item found: "..zo_strformat(SI_TOOLTIP_ITEM_NAME, lItemLink))
		end
	elseif bShowOtherResearchMsgs and bAreOthersWhoNeedOnWatchList then
		if iItemType == ITEMTYPE_RECIPE then
			d(colorRed.."AutoJunker: "..iconYellow.."Unknown recipe found: "..zo_strformat(SI_TOOLTIP_ITEM_NAME, lItemLink))
		else
			d(colorRed.."AutoJunker: "..iconYellow.."Research item found: "..zo_strformat(SI_TOOLTIP_ITEM_NAME, lItemLink))
		end
	end
	
	--only print if player needs or others who need are on watch list
	--if not (bAreOthersWhoNeedOnWatchList or tNeedInfo.PlayerNeeds) then return end
	local sCharsWhoNeedTrait = AutoJunker.GetCharNamesStringFromTable(tNeedInfo)
		
	-- Characters Who Need Message --
	if (AutoJunker.SavedVariables["UNKNOWNRESEARCHMESSAGESNAMES"] and (sCharsWhoNeedTrait ~= "")) then
		d(colorRed.."AutoJunker: "..colorYellow.."Item needed by: "..sCharsWhoNeedTrait)
	end
end





