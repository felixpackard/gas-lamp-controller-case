/***********************
*
* Light Controller Box v1.0
* designed for Settle Hackspace by Felix Packard
*
* Hardware used:
*
* ELEGOO UNO R3 Arduino Compatible Board
*	https://www.amazon.co.uk/ELEGOO-Board-ATmega328P-ATMEGA16U2-Cable/dp/B01EWOE0UU/
* MakerHawk I2C OLED Display Module
*	https://www.amazon.co.uk/MakerHawk-Display-Module-SSD1306-Arduino/dp/B07BDFXFRK/
* Mini Momentary Push Button Switch
*	https://www.amazon.co.uk/gp/product/B07FQRV69V/
*
***********************/

// Libraries
include <arduino.scad>

/********
* Project options
********/

// Display the modules in an exploded view
explode = true;

// Show the board enclosure module
show_enclosure = true;

// Show the mock arduino module
show_arduino = true;

// Show the mock screen module
show_screen = true;

// Show the case lid module
show_lid = true;

// The resolution for rendering in the preview window
resolution = 100;

/********
* Library options
********/

// How much extra space there should be above the top of the board inside the case
height_extension = 30;

// How tall the board standoffs should be
standoff_height = 5;

// How thick the walls of the enclosure should be
wall_thickness = 3;

// How thick the lid should be
lid_thickness = wall_thickness + 1.5;

// How wide the screen module should be
screen_width = 38;

// How tall the screen module should be
screen_height = 12;

// How thick the screen module should be
screen_thickness = 2.8;

// How wide the display part of the screen module should be
screen_display_width = 26.7;

// How tall the display part of the screen module should be
screen_display_height = 10.2;

// The horizontal of the display part of the screen module
screen_width_offset = -1.7 / 2;

// The vertical offset of the display part of the screen module
screen_height_offset = -1.8 / 2;

// The radius of the button cutouts
button_cutout_radius = 8 / 2;

// How much space there should be between the buttons
button_spacing = 14;

// How far from the center of the lid the buttons should be
screen_and_button_offset = 10;

// The position of the board module
board_position = boardPosition();

// The dimensions of the board module
board_dimensions = boardDimensions();

// The position of the PCB
pcb_position = pcbPosition();

// The dimensions of the PCB
pcb_dimensions = pcbDimensions();

// The horizontal offset of the power ports from the edge
power_offset_x = 9;

// The vertical offset of the power ports from the edge
power_offset_z = 10;

// The radius of the power port cutouts
power_cutout_radius = 9 / 2;

// The position of the power ports on the Z axis
power_offset_position_z = board_dimensions[2] + standoff_height + height_extension + wall_thickness - power_cutout_radius - power_offset_z;

// The position of the cutout for power input
power_input_position = [power_offset_x, -6.5 + wall_thickness + 1, power_offset_position_z];

// The position of the cutout for power output
led_output_position = [board_dimensions[0] - power_offset_x, -6.5 + wall_thickness + 1, power_offset_position_z];

// The depth of the screen clips
screen_clip_depth = screen_thickness + 3.5;

// The lip height of the screen clips
screen_clip_lip_height = 3;

// The lip depth of the screen clips
screen_clip_lip_depth = 2.5;

// The width of the screen clips
screen_clip_width = 3;

// The height of the screen clips
screen_clip_height = screen_thickness + screen_clip_lip_height + 0.4;

// The horiztonal offset of the screen clips from the edge of the screen module
screen_clip_offset = 3;

// The position of the lid module
lid_position = [0, 0, board_dimensions[2] + standoff_height + height_extension + wall_thickness];

// -2 for the Z coordinate is a guess, but seems to be correct...
// ...might want to look into how I can calculate this properly

// The position of the center of the lid module
lid_center = [pcb_dimensions[0] / 2, (pcb_dimensions[1] + 5) / 2, -2];

// Constants
vector_zero = [0, 0, 0];

// Render enclosure
if (show_enclosure) {
	difference() {
		enclosure(heightExtension=height_extension,mountType=PIN);
		powerConnectionCutout(power_input_position, power_cutout_radius);
		powerConnectionCutout(led_output_position, power_cutout_radius);
	}
}

// Render arduino
if (show_arduino) {
	translate(explode ? [0, 0, height_extension + 25] : vector_zero)
	translate([0, 0, wall_thickness + standoff_height]) arduino();
}

// Render screen
if (show_screen) {
	translate(lid_position)
	translate(explode ? [0, 0, 40] : vector_zero)
	translate([
		(lid_center[0] - screen_and_button_offset) - screen_height / 2 - screen_height_offset,
		lid_center[1] - screen_width / 2 - screen_width_offset,
		-3.8
	])
	screen();
}

// Render lid
if (show_lid) {
	translate(lid_position) {
		translate(explode ? [0, 0, 60] : vector_zero)
		difference() {
			union() {
				enclosureLid();
				screenClips();
			}
			screenCutout();
			buttonCutoutArray();
		}
	}
}

/***********************
* POWER CONNECTION CUTOUT
* Creates a cutout for a power connection
***********************/

module powerConnectionCutout(position, radius) {
	translate(position)
	rotate([90, 0, 0])
	cylinder($fn = resolution, r = radius, h = wall_thickness + 1);
}

/***********************
* BUTTON CUTOUT ARRAY
* Creates an array of cutouts for push buttons
***********************/

module buttonCutoutArray() {
	translate([
		lid_center[0] + screen_and_button_offset,
		lid_center[1],
		0
	]) {
		buttonCutout();
		translate([0, -button_spacing, 0]) buttonCutout();
		translate([0, button_spacing, 0]) buttonCutout();
	}
}

/***********************
* BUTTON CUTOUT
* Creates a cutout for a push button
***********************/

module buttonCutout() {
	translate([0, 0, -1.6])
	cylinder($fn = resolution, r = button_cutout_radius, h = lid_thickness + 0.2);
}

/***********************
* SCREEN MODULE
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
* SCREEN CUTOUT
* Creates the cutout for the screen in the case lid
***********************/

module screenCutout() {
	// Screen position and dimensions
	cutout_position = [
		lid_center[0] - screen_and_button_offset - screen_display_height / 2,
		lid_center[1] - screen_display_width / 2,
		lid_center[2]
	];
	cutout_dimensions = [screen_display_height, screen_display_width, lid_thickness + 1];

	translate(cutout_position) cube(cutout_dimensions);
}

/***********************
* SCREEN CLIPS
* Creates the clips for the screen attached to the case lid
***********************/

module screenClips() {
	edge_offset = 0.5;
	z_offset = 0.6;
	
	//translate(lid_center) {
	translate([lid_center[0] - screen_and_button_offset, lid_center[1], lid_center[2]]) {
		// Clip 1 (-x -y)
		translate([
			-screen_height / 2 - edge_offset - screen_height_offset,
			-screen_width / 2 + screen_clip_width / 2 - screen_width_offset + screen_clip_offset,
			z_offset]
		)
		rotate([0, 180, -90])
		clip(
			clipWidth = screen_clip_width,
			clipHeight = screen_clip_height,
			lipHeight = screen_clip_lip_height,
			clipDepth = screen_clip_depth,
			lipDepth = screen_clip_lip_depth
		);
		
		// Clip 2 (+x -y)
		translate([
			screen_height / 2 + edge_offset - screen_height_offset,
			-screen_width / 2 + screen_clip_width / 2 - screen_width_offset + screen_clip_offset,
			z_offset]
		)
		rotate([180, 0, -90])
		clip(
			clipWidth = screen_clip_width,
			clipHeight = screen_clip_height,
			lipHeight = screen_clip_lip_height,
			clipDepth = screen_clip_depth,
			lipDepth = screen_clip_lip_depth
		);
		
		// Clip 3 (-x +y)
		translate([
			-screen_height / 2 - edge_offset - screen_height_offset,
			screen_width / 2 - screen_clip_width / 2 - screen_width_offset - screen_clip_offset,
			z_offset]
		)
		rotate([0, 180, -90])
		clip(
			clipWidth = screen_clip_width,
			clipHeight = screen_clip_height,
			lipHeight = screen_clip_lip_height,
			clipDepth = screen_clip_depth,
			lipDepth = screen_clip_lip_depth
		);
		
		// Clip 4 (+x +y)
		translate([
			screen_height / 2 + edge_offset - screen_height_offset,
			screen_width / 2 - screen_clip_width / 2 - screen_width_offset - screen_clip_offset,
			z_offset]
		)
		rotate([180, 0, -90])
		clip(
			clipWidth = screen_clip_width,
			clipHeight = screen_clip_height,
			lipHeight = screen_clip_lip_height,
			clipDepth = screen_clip_depth,
			lipDepth = screen_clip_lip_depth
		);
	}
}