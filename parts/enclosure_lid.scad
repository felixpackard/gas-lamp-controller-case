include <../config/_config.scad>
include <../config/enclosure_lid.scad>
include <../utils/arduino.scad>

/***********************
* BUTTON CUTOUT
* Creates a cutout for a single push button
***********************/
module buttonCutout() {
	translate([0, 0, -1.6])
	cylinder($fn = resolution, r = button_cutout_radius, h = lid_thickness + 0.2);
}

/***********************
* BUTTON CUTOUT ARRAY
* Creates an array of cutouts for multiple push buttons
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

/***********************
* ENCLOSURE LID PART
* Renders the enclosure lid part
***********************/
module enclosureLidPart() {
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
* RENDER
***********************/
enclosureLidPart();