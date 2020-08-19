$fa=0.1;
$fs=0.1;

include <bike-mount.scad>;

handlebar_diameter=38;
handlebar_rounding=5;
thickness=8;
mount_length=12;
flange_length=4;
rounding=5;
nut_diameter=7 + 1.5;
nut_offset=3;
bolt_head_diameter=8 + 1.5;
bolt_shaft_diameter=4 + 0.5;
original_shield_size=20;
shield_thickness=3;
shield_size=130;
shield_offset=0;
support_width=30;
support_length=60;

module shield(original_size, desired_size, thickness) {
  scale([desired_size / original_size, desired_size / original_size, 1])
    linear_extrude(height=thickness, convexity=10)
      projection(cut = true)
        translate([0, 0, -50])
          surface("shield-micro.png", center=true);
}

module prism(l, w, h){
  translate([-l/2, -w/2, -h/2])
    polyhedron(
      points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
      faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
}

// Top
union() {
  // Bike mount
  difference() {
    top_bike_mount(handlebar_diameter, thickness, mount_length, flange_length, rounding, bolt_head_diameter, bolt_shaft_diameter, nut_offset);
    translate([0, 0, mount_length/2])
      rounded_rect(handlebar_diameter, handlebar_rounding, mount_length);
  }

  // Shield
  translate([-((handlebar_diameter/2 + thickness) + shield_offset + (shield_size/2)), 0, 0])
    shield(original_shield_size, shield_size, shield_thickness);
    
  // Support pole
  translate([-(support_length / 2 + handlebar_diameter / 2 + thickness), 0, (shield_thickness / 2)])
    scale([support_length, support_width, shield_thickness])
      cube(center=true);
  
  // Support prism left
  translate([-((support_length / 2) + handlebar_diameter/2 + thickness), ((support_width - shield_thickness) / 2), (mount_length / 2)])
    rotate([0, 0, -90])
      prism(shield_thickness, support_length, mount_length);

  // Support prism right
  translate([-((support_length / 2) + handlebar_diameter/2 + thickness), -((support_width - shield_thickness) / 2), (mount_length / 2)])
    rotate([0, 0, -90])
      prism(shield_thickness, support_length, mount_length);
}

// Bottom
/*
difference() {
  bottom_bike_mount(handlebar_diameter, thickness, mount_length, flange_length, rounding, nut_diameter, bolt_shaft_diameter, nut_offset);
  translate([0, 0, mount_length/2])
    rounded_rect(handlebar_diameter, handlebar_rounding, mount_length);
}
*/
