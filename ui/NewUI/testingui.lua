--testing UI, can have data directly written to the screen.
testingUI = 
{
	size = {0, 0, 100, 100},
	stylesheet = "HW2StyleSheet",
	pixelUVCoords = 1,
;
{ 
    type = "Frame", 
    name = "tstdat_Root", 
    size = { 100, 100, }, 
    --backgroundColor = "FEColorDialog", 
    autosize = 1, 
    marginHeight = 1,	
;
	{ 
		type = "TextLabel", 
		name = "tstdat1_name", 
		position = { 0, 0, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "Dat 01:", },
	},
	{ 
		type = "TextLabel", 
		name = "tstdat2_name", 
		position = { 0, 10, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "Dat 02:", },
	},
	{ 
		type = "TextLabel", 
		name = "tstdat3_name", 
		position = { 0, 20, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "Dat 03:", },
	},
	{ 
		type = "TextLabel", 
		name = "tstdat4_name", 
		position = { 0, 30, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "Dat 04:", },
	},
	{ 
		type = "TextLabel", 
		name = "tstdat5_name", 
		position = { 0, 40, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "Dat 05:", },
	},
	{ 
		type = "TextLabel", 
		name = "tstdat6_name", 
		position = { 0, 50, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "Dat 06:", },
	},
	{ 
		type = "TextLabel", 
		name = "tstdat7_name", 
		position = { 0, 60, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "Dat 07:", },
	},
	{ 
		type = "TextLabel", 
		name = "tstdat8_name", 
		position = { 0, 70, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "Dat 08:", },
	},
	{ 
		type = "TextLabel", 
		name = "tstdat9_name", 
		position = { 0, 80, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "Dat 09:", },
	},
	{ 
		type = "TextLabel", 
		name = "tstdat10_name", 
		position = { 0, 90, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "Dat 10:", },
	},
	{ 
		type = "TextLabel", 
		name = "tstdat1_dat", 
		position = { 50, 0, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "<Unassigned>", },
	},
	{ 
		type = "TextLabel", 
		name = "tstdat2_dat", 
		position = { 50, 10, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "<Unassigned>", },
	},
	{ 
		type = "TextLabel", 
		name = "tstdat3_dat", 
		position = { 50, 20, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "<Unassigned>", },
	},
	{ 
		type = "TextLabel", 
		name = "tstdat4_dat", 
		position = { 50, 30, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "<Unassigned>", },
	},
	{ 
		type = "TextLabel", 
		name = "tstdat5_dat", 
		position = { 50, 40, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "<Unassigned>", },
	},
	{ 
		type = "TextLabel", 
		name = "tstdat6_dat", 
		position = { 50, 50, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "<Unassigned>", },
	},
	{ 
		type = "TextLabel", 
		name = "tstdat7_dat", 
		position = { 50, 60, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "<Unassigned>", },
	},
	{ 
		type = "TextLabel", 
		name = "tstdat8_dat", 
		position = { 50, 70, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "<Unassigned>", },
	},
	{ 
		type = "TextLabel", 
		name = "tstdat9_dat", 
		position = { 50, 80, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "<Unassigned>", },
	},
	{ 
		type = "TextLabel", 
		name = "tstdat10_dat", 
		position = { 50, 90, }, 
		size = { 50, 10, }, 
		Text = { 
        textStyle = "FEHelpTipTextStyle", 
        vAlign = "Left", 
        text = "<Unassigned>", },
	},
}}
