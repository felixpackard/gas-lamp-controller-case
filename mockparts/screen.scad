include <../config/_config.scad>
include <../config/screen.scad>
include <../config/enclosure_lid.scad>

/***********************
* SCREEN
* Creates a mock screen to check that everything aligns correctly
***********************/
module screen() {
	union() {
		// Render PCB
		color("lightblue")
		cube([screen_height, screen_width, screen_thickness - 0.5]);

		// Render display
		translate([
			screen_height / 2 - screen_display_height / 2 + screen_height_offset + 0.01,
			screen_width / 2 - screen_display_width / 2 + screen_width_offset,
			screen_thickness - 0.5
		])
		color("black")
		cube([screen_display_height, screen_display_width, 0.5]);
	}
}

/***********************
* SCREEN MOCK PART
* Renders the screen mock part
***********************/
module screenMockPart() {
    translate(lid_position)
	translate(explode ? [0, 0, 40] : vector_zero)
	translate([
		(lid_center[0] - screen_and_button_offset) - screen_height / 2 - screen_height_offset,
		lid_center[1] - screen_width / 2 - screen_width_offset,
		-3.8
	])
	screen();
}

/***********************
* RENDER
***********************/
screenMockPart();