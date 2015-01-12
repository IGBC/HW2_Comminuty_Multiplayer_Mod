-- =============================================================================
-- Homeworld 2 Clean Data Resource Project
-- By S110
-- Version 1.0
-- 02/06/2010
-- Tools used: EditPad Lite, LuaDC version 0.9.19, and Cold Fusion LUA Decompiler v1.0.0
-- =============================================================================

aitrace("CPU: CLASSDEF LOADED")

squadclass = {}

squadclass[eMotherShip] = {
	HGN_MOTHERSHIP,
	VGR_MOTHERSHIP,
	VGR_MOTHERSHIP_MAKAAN}

squadclass[eCollector] = {
	HGN_RESOURCECOLLECTOR,
	VGR_RESOURCECOLLECTOR}

squadclass[eScout] = {
	HGN_SCOUT,
	HGN_PROBE,
	HGN_PROXIMITYSENSOR,
	HGN_ECMPROBE,
	VGR_SCOUT,
	VGR_PROBE,
	VGR_PROBE_PROX,
	VGR_PROBE_ECM}

squadclass[eRefinery] = {
	HGN_RESOURCECONTROLLER,
	VGR_RESOURCECONTROLLER}

squadclass[eBuilder] = {
	HGN_MOTHERSHIP,
	HGN_CARRIER,
	HGN_SHIPYARD,
	VGR_MOTHERSHIP,
	VGR_MOTHERSHIP_MAKAAN,
	VGR_CARRIER,
	VGR_SHIPYARD}

squadclass[eDropOff] = {
	HGN_MOTHERSHIP,
	HGN_CARRIER,
	HGN_SHIPYARD,
	HGN_RESOURCECONTROLLER,
	VGR_MOTHERSHIP,
	VGR_MOTHERSHIP_MAKAAN,
	VGR_CARRIER,
	VGR_SHIPYARD,
	VGR_RESOURCECONTROLLER}

squadclass[eSalvageDropOff] = {
	HGN_MOTHERSHIP,
	HGN_CARRIER,
	HGN_SHIPYARD,
	VGR_MOTHERSHIP,
	VGR_MOTHERSHIP_MAKAAN,
	VGR_CARRIER,
	VGR_SHIPYARD}

squadclass[eFighter] = {
	HGN_INTERCEPTOR,
	HGN_ATTACKBOMBER,
	HGN_ATTACKBOMBERELITE,
	VGR_INTERCEPTOR,
	VGR_BOMBER,
	VGR_LANCEFIGHTER}

squadclass[eCorvette] = {
	HGN_ASSAULTCORVETTE,
	HGN_PULSARCORVETTE,
	VGR_MISSILECORVETTE,
	VGR_LASERCORVETTE}

squadclass[eFrigate] = {
	HGN_ASSAULTFRIGATE,
	HGN_DEFENSEFIELDFRIGATE,
	HGN_IONCANNONFRIGATE,
	HGN_MARINEFRIGATE,
	HGN_MARINEFRIGATE_SOBAN,
	HGN_TORPEDOFRIGATE,
	HGN_TORPEDOFRIGATEELITE,
	VGR_ASSAULTFRIGATE,
	VGR_HEAVYMISSILEFRIGATE,
	VGR_INFILTRATORFRIGATE}

squadclass[eCapture] = {
	HGN_MARINEFRIGATE,
	HGN_MARINEFRIGATE_SOBAN,
	VGR_INFILTRATORFRIGATE}

squadclass[eShield] = {
	HGN_DEFENSEFIELDFRIGATE}

squadclass[ePlatform] = {VGR_HYPERSPACE_PLATFORM}

squadclass[eAntiFighter] = {
	HGN_INTERCEPTOR,
	HGN_ASSAULTCORVETTE,
	HGN_ASSAULTFRIGATE,
	VGR_INTERCEPTOR,
	VGR_ASSAULTFRIGATE}

squadclass[eAntiCorvette] = {
	HGN_PULSARCORVETTE,
	HGN_TORPEDOFRIGATE,
	HGN_TORPEDOFRIGATEELITE,
	HGN_DESTROYER,
	VGR_LANCEFIGHTER,
	VGR_LAZERCORVETTE,
	VGR_DESTROYER}

squadclass[eAntiFrigate] = {
	HGN_ATTACKBOMBER,
	HGN_ATTACKBOMBERELITE,
	HGN_IONCANNONFRIGATE,
	HGN_MARINEFRIGATE,
	HGN_MARINEFRIGATE_SOBAN,
	HGN_DEFENSEFIELDFRIGATE,
	HGN_DESTROYER,
	HGN_BATTLECRUISER,
	VGR_BOMBER,
	VGR_HEAVYMISSILEFRIGATE,
	VGR_INFILTRATORFRIGATE,
	VGR_DESTROYER,
	VGR_BATTLECRUISER}

squadclass[eCapital] = {
	HGN_CARRIER,
	HGN_MOTHERSHIP,
	HGN_SHIPYARD,
	HGN_DESTROYER,
	HGN_BATTLECRUISER,
	HGN_DREADNAUGHT,
	VGR_CARRIER,
	VGR_MOTHERSHIP,
	VGR_MOTHERSHIP_MAKAAN,
	VGR_SHIPYARD,
	VGR_DESTROYER,
	VGR_BATTLECRUISER}

squadclass[eNonThreat] = {
	HGN_RESOURCECOLLECTOR,
	VGR_RESOURCECOLLECTOR,
	HGN_RESOURCECONTROLLER,
	VGR_RESOURCECONTROLLER,
	HGN_CARRIER,
	HGN_MOTHERSHIP,
	HGN_SHIPYARD,
	VGR_CARRIER,
	VGR_MOTHERSHIP,
	VGR_MOTHERSHIP_MAKAAN,
	VGR_SHIPYARD,
	HGN_SCOUT,
	HGN_PROBE,
	HGN_PROXIMITYSENSOR,
	HGN_ECMPROBE,	
	VGR_SCOUT,
	VGR_PROBE,
	VGR_PROBE_PROX,
	VGR_PROBE_ECM,
	VGR_HYPERSPACE_PLATFORM}

squadclass[eHyperspaceGate] = {
	VGR_HYPERSPACE_PLATFORM}

squadclass[eSubSystemAttackers] = {
	HGN_ATTACKBOMBER,
	HGN_ATTACKBOMBERELITE,
	VGR_BOMBER}

squadclass[eNonCriticalSubSys] = {
	CLOAKGENERATOR,
	FIRECONTROLTOWER,
	HYPERSPACEINHIBITOR,
	ADVANCEDARRAY,
	CLOAKSENSOR}

squadclass[eGoodRepairAttackers] = {
	HGN_INTERCEPTOR,
	HGN_ASSAULTFRIGATE,
	HGN_IONCANNONFRIGATE,
	HGN_DESTROYER,
	HGN_BATTLECRUISER,	
	VGR_INTERCEPTOR,
	VGR_MISSILECORVETTE,
	VGR_ASSAULTFRIGATE,
	VGR_DESTROYER,
	VGR_BATTLECRUISER}

eUselessShips = eMaxCount

eBattleCruiser = eMaxCount + 1

sg_maxClasses = eBattleCruiser + 1

squadclass[eUselessShips] = {}

squadclass[eBattleCruiser] = {
	HGN_BATTLECRUISER,
	VGR_BATTLECRUISER}

function FastAddToClass(tbl, classid)
	for a, b in tbl do
	AddToClass(b, classid)
	end
end

function ClassInitialize()
	for i=0, sg_maxClasses do
	if (squadclass[i]) then
	FastAddToClass(squadclass[i], i)
	end
	end
	AddClassName(eMotherShip, "Motherships")
	AddClassName(eCollector, "Collectors")
	AddClassName(eDropOff, "DropOffs")
	AddClassName(eFighter, "Fighters")
	AddClassName(eFrigate, "Frigates")
	AddClassName(eCorvette, "Corvettes")
	AddClassName(eCapital, "Capital")
	AddClassName(eAntiFighter, "AntiFighter")
	AddClassName(eAntiCorvette, "AntiCorvette")
	AddClassName(eAntiFrigate, "AntiFrigate")
	AddClassName(ePlatform, "Platform")
	AddClassName(eRefinery, "Refinery")
	AddClassName(eHyperspaceGate, "HypGates")
	AddClassName(eShield, "Shields")
	AddClassName(eCapture, "Capture")
	AddClassName(eSubSystemAttackers, "SubSysKillas")
	AddClassName(eBattleCruiser, "BattleCruiser")
end
