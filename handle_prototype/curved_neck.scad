module curved_neck() {
    // Import the curved neck from stl and position it nicely
    translate([0, 30, -80]) {
        rotate([90, 0, 0]) {
            import("include/curved_neck_low.stl");
        }
    }
}

curved_neck();
