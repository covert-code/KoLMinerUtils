/**********************************************
                 Developed by:
      the coding arm of ProfessorJellybean.
             (#2410942), (#2413598)

 Please don't KMail me unless there are issues.
     I'm glad you're using this but I have
             enough mail already :P

   This script should not be invoked with
   gCLI. It is meant to be a utilities suite
   for other scripts.

**********************************************/

// Documentation Notes
/***
Intent: Mining utilities for use in other scripts.
Domain: Executable ASH Scripts in the Mafia utility
  for the Kingdom of Loathing
  (http://www.kingdomofloathing.com/)

Notes:
  To cut down on filesize and complexity, this script
  will only be concerned with general functions for
  mining, and not concern itself with any specific
  mine in the Kingdom of Loathing.

  All functions in this suite will start with
  utils_mining_ to avoid collisions. Specific fields
  and variables will be named with camelCase.

Contributors:
> Allen Jiang (eliteaccordion)
  - GitHub: AllenTuring
  - LinkedIn: http://allenjiang.rocks/
***/

/** PLAYERSTATE **/
// These functions are concerned with the playerstate
// And do not require the mine to be loaded.
// They do not perform any actions.

// Checks whether or not the player is equipped to mine generic mines.
// Expression: (Mining Gear) v (Dwarvish War Uniform) v (WOTSF ^ Earthen Fist)
boolean utils_mining_wearingMiningGear() {
	return is_wearing_outfit("Mining Gear")
	|| is_wearing_outfit("Dwarvish War Uniform")
	|| (my_path() == "Way of the Surprising Fist" && have_effect($effect[Earthen Fist]))
}

// Checks whether or not the player is fit to mine.
// Does not check for access to a specific mine.
// Does not check for mining gear (some mines have special gear.)
// Return codes:
  // 0 - Fit to mine.
  // 1 - Has no adventures left.
  // 2 - Beaten up.
  // 3 - Drunk. Good luck.
int utils_mining_canMine() {
	//Check if the player is not drunk.
	if(my_inebriety() > inebriety_limit()) {
		return 1;
	}

	//Checks for remaining adventures
	if (my_adventures() == 0) {
		return 2;
	}
	
	//Checks that the player is not beaten up
	if (have_effect($effect[Beaten Up]) != 0) {
		return 3;
	}

	return 0;
}

/** MINE PARSING **/
// These functions are concerned with the parsing of
// the mine's data.