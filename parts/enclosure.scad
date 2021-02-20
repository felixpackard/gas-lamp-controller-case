include <../config/_config.scad>
include <../config/enclosure.scad>
include <../utils/arduino.scad>
include <../utils/vector.scad>

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
* MOUNTING CUTOUT
* Creates a keyhole cutout for wall mounting
***********************/
module mountingCutout(position) {
	translate(position) {
		union() {
			hull() {
				// Slot
				translate([mounting_cutout_shank_diameter / 2 - 0.5, - mounting_cutout_shank_diameter / 2, 0])
					cube([mounting_cutout_slot_length - mounting_cutout_shank_diameter / 2 + 0.5,
						mounting_cutout_shank_diameter, wall_thickness + 1]);

				// Rounded slot end
				translate([mounting_cutout_slot_length - mounting_cutout_shank_diameter, 0, 0])
					cylinder($fn = resolution, r = mounting_cutout_shank_diameter / 2, h = wall_thickness + 1);
			}

			// Hole
			translate([mounting_cutout_head_diameter / 2 + mounting_cutout_slot_length - 1, 0, 0])
				cylinder($fn = resolution, r = mounting_cutout_head_diameter / 2, h = wall_thickness + 1);
		}
	}
}

/***********************
* ENCLOSURE PART
* Renders the enclosure part
***********************/
module enclosurePart() {
    difference() {
		enclosure(heightExtension=height_extension);

		// Power connections
		powerConnectionCutout(power_input_position, power_cutout_radius);
		powerConnectionCutout(led_output_position, power_cutout_radius);

		// Mounting cutouts
		mountingCutout(vsub(mounting_offset_center, mounting_offset_distance));
		mountingCutout(vadd(mounting_offset_center, mounting_offset_distance));
	}
}

/***********************
* RENDER
***********************/
enclosurePart();