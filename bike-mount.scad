// Rounded-rect side*side square, with rounding chopped off from the sides
// So rounding=0 implies a square bar
// rounding=side/2 implies a cylinder
module rounded_rect(side, rounding, length) {
    opp = (side/2)-rounding;
    adj = (side/2);
    hyp = sqrt(opp*opp+adj*adj);
    
    intersection() {
        scale([side, side, length+2])
            cube(center = true);
        cylinder(center=true, r=hyp, h=length+2);
    }
}

module top_bike_mount(diameter, thickness, length, flange_len, rounding, head_diameter, bolt_diameter, nut_offset) {
  radius = diameter / 2;

  translate([0, 0, (length/2)]) 
    difference() {
      intersection() {
        scale([1, (diameter + (thickness + flange_len) * 2) / (diameter + thickness * 2), 1])
          rounded_rect(diameter+thickness*2, rounding, length);

        // Chop in half
        translate([-(radius + thickness), -(radius+thickness+flange_len), -(length / 2)]) 
          cube(center=false, size=[(radius+thickness), (radius+thickness+flange_len)*2, length]);
      }
      
      union() {
        // left head
        translate([-((radius+thickness)/2 + nut_offset), (radius + (thickness + flange_len) / 2), 0]) {
          rotate([0, 90, 0]) {
            cylinder(center=true, d=head_diameter, h=radius+thickness+1);
          }
        }

        // left shaft
        translate([-(nut_offset/2), (radius + (thickness + flange_len) / 2), 0]) {
          rotate([0, 90, 0]) {
            cylinder(center=true, d=bolt_diameter, h=nut_offset+1);
          }
        }

        // right head
        translate([-((radius+thickness)/2 + nut_offset), -(radius + (thickness + flange_len) / 2), 0]) {
          rotate([0, 90, 0]) {
            cylinder(center=true, d=head_diameter, h=radius+thickness+1);
          }
        }

        // right shaft
        translate([-(nut_offset/2), -(radius + (thickness + flange_len) / 2), 0]) {
          rotate([0, 90, 0]) {
            cylinder(center=true, d=bolt_diameter, h=nut_offset+1);
          }
        }
      }
    }
}

module bottom_bike_mount(diameter, thickness, length, flange_len, rounding, nut_diameter, bolt_diameter, nut_offset) {
  radius = diameter / 2;

  translate([0, 0, (length/2)]) 
    difference () {
    //union () {
      intersection() {
        scale([1, (diameter + (thickness + flange_len) * 2) / (diameter + thickness * 2), 1])
          rounded_rect(diameter+thickness*2, rounding, length);

        // Chop in half
        translate([-(radius + thickness), -(radius+thickness+flange_len), -(length / 2)]) 
          cube(center=false, size=[(radius+thickness), (radius+thickness+flange_len)*2, length]);
      }
      
      union() {
        // Nut hole left
        translate([-((radius+thickness)/2 + nut_offset), (radius + (thickness + flange_len) / 2), 0]) 
          rotate([0, 90, 0]) 
            cylinder($fn=6, center=true, d=nut_diameter, h=radius+thickness+1);

        // Bolt shaft hole left
        translate([-(nut_offset/2), (radius + (thickness + flange_len) / 2), 0]) 
          rotate([0, 90, 0]) 
            cylinder(center=true, d=bolt_diameter, h=nut_offset+1);

        // Nut hole right
        translate([-((radius+thickness)/2 + nut_offset), -(radius + (thickness + flange_len) / 2), 0]) 
          rotate([0, 90, 0]) 
            cylinder($fn=6, center=true, d=nut_diameter, h=radius+thickness+1);

        // Bolt shaft hole left
        translate([-(nut_offset/2), -(radius + (thickness + flange_len) / 2), 0]) 
          rotate([0, 90, 0]) 
            cylinder(center=true, d=bolt_diameter, h=nut_offset+1);
      }
    }
}

//bottom_bike_mount(35, 5, 30, 15, 10);
//top_bike_mount(35, 5, 30, 15, 10);

//hex_cyl(3, 8);
