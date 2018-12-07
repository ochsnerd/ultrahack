eps = 0.05;
// Geometry of grip:
g_outer_dia = 36;
g_inner_dia = 14;
g_length = 99.5;
g_dist_thinnest = 12.5;

module grip_clipped(len=g_length, dia=g_outer_dia, base=g_outer_dia) {
    // Import the grip from stl and clip its base to a certain value
    // len : length of the grip
    // dia : diameter of the grip
    // base : diameter of the base,
    // returns : grip with specified dimensions, oriented along y, with the
    //           diameter of the base clipped

    rotate([90, 0, 0]) {
        if (dia > base){
            difference() {
                grip(len, dia);
                corr_cyl_h = g_dist_thinnest;
                translate([0, 0, -.5 * corr_cyl_h + eps]) {
                    difference() {
                        cylinder(h = corr_cyl_h, d = 100, center = true);
                        cylinder(h = corr_cyl_h + eps, d = base, center = true);
                    }
                }
            }
        }
        else {
            union() {
                grip(len, dia);
                h = 5;
                //h = .5 * (g_outer_dia - g_inner_dia - 1);  // 45 deg
                translate([0, 0, -h + eps]) {
                    difference() {
                        cylinder(h = h,
                                 d2 = g_outer_dia,
                                 d1 = g_inner_dia + 1);
                        translate([0, 0, -.5 * eps]) {
                            cylinder(h = h + eps,
                                     d = g_inner_dia + eps);
                        }
                    }
                }
            }
        }
    }
}

module grip(len, dia) {
    // Import the grip from stl
    // len : length of the grip
    // dia : diameter of the grip
    // returns : grip with specified dimensions, oriented along -z

    sc_len = len / g_length;
    sc_rad = dia / g_outer_dia;
    scale([sc_rad, sc_rad, sc_len]) {
        import("include/grip_low.stl", convexity=5);
    }
}

grip(200, 32);
