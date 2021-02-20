/***********************
* CONFIG / SCREEN
* The file defines all config variables used by the enclosure module
***********************/

include <_config.scad>

power_offset_x = 9;
power_offset_z = 10;

power_cutout_radius = 9 / 2;

power_offset_position_z = board_dimensions[2] + standoff_height + height_extension + wall_thickness - power_cutout_radius - power_offset_z;

power_input_position = [power_offset_x, -6.5 + wall_thickness + 1, power_offset_position_z];
led_output_position = [board_dimensions[0] - power_offset_x, -6.5 + wall_thickness + 1, power_offset_position_z];

mounting_offset_center = [0, board_dimensions[1] / 2, -0.5];
mounting_offset_distance = [0, 32.5, 0];

mounting_cutout_head_diameter = 8 + 0.4;
mounting_cutout_shank_diameter = 4 + 0.4;

mounting_cutout_slot_length = 6;