include <../config/_config.scad>
include <../config/enclosure.scad>
include <../utils/arduino.scad>

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
* ENCLOSURE PART
* Renders the enclosure part
***********************/
module enclosurePart() {
    difference() {
		enclosure(heightExtension=height_extension);
		powerConnectionCutout(power_input_position, power_cutout_radius);
		powerConnectionCutout(led_output_position, power_cutout_radius);
	}
}

/***********************
* RENDER
***********************/
enclosurePart();