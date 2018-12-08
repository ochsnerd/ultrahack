// Create Pattern Feature using different Logos
function createPattern(solid grip, int logoID)
{
// LogoID: 1 == heart
// LogoID: 2 == puzzle
// LogoID: 3 == star
// LogoID: 4 == audi
// LogoID: 5 == ETH
// LogoID: 6 == alpa

int pattern_n_diameter_dir
int pattern_n_length_dir
float pattern_thickness = 50
​
// Switch condition to select logo
string temp
switch( logoID )
{
 case 1:
  temp = "include/logo_heart.jpg";
  pattern_n_diameter_dir = 10
  pattern_n_length_dir = 9

 case 2:
  temp = "include/logo_puzzle.jpg";
  pattern_n_diameter_dir = 10
  pattern_n_length_dir = 11
​
 case 3:
  temp = "include/logo_star.jpg";
  pattern_n_diameter_dir = 10
  pattern_n_length_dir = 13

 case 4:
  temp = "include/logo_audi.jpg";
  pattern_n_diameter_dir = 10
  pattern_n_length_dir = 8

 case 5:
  temp = "include/logo_ETH.jpg";
  pattern_n_diameter_dir = 10
  pattern_n_length_dir = 6

 case 6:
  temp = "include/logo_alpa.jpg";
  pattern_n_diameter_dir = 10
  pattern_n_length_dir = 6
}

 // Import and invert black-white pattern (sometimes necessary)
 image img(temp)
 img.invert()

 // Convert image to solid
 solid img1 = img_to_solid( img, pattern_thickness, 1.0)

 // Move to center
 img1 = translation(<[-img.width/2, -img.height/2, 0]>) >> img1

 // Scale solid of image
 float scal = 0.04
 img1 = scaling(scal, scal, scal) >> img1
 float pattern_height = scal* img.height
 float pattern_width = scal* img.width

 // Position with correct orientation
 img1 = rotation(<[1.0, 0.0, 0.0]>, rad(-90)) >> img1

 // Offset in y axis with offset (diameter direction)
 float offset_pattern_diameter_dir = 34
 img1 = translation(<[0, offset_pattern_diameter_dir, 0]>) >> img1

 // Offset in -z axis with offset (length direction)
 float offset_pattern_length_dir = 15
 img1 = translation(<[0, 0, -offset_pattern_length_dir]>) >> img1

 // Subdivide solid image for enfold
 img1 = subdiv( 0.3, <[0,0,1]> ) >> img1

 // Execute enfold for solid image
 solid img1_enfold

 for (int i = 0; i < pattern_n_length_dir; i++)
 {
   img1_enfold = rgb( 255, 255, 255 ) >> enfold(img1, grip, <[0.0, -1.0, 0.0]>, 1.0, false, -1)
  img1 = translation(<[0, 0, -pattern_height*1.05]>) >> img1

  for (int j = 0; j < pattern_n_diameter_dir; j++)
  {
   make rotation(<[0, 0, 1]>, rad(360 / pattern_n_diameter_dir) * j) >> img1_enfold
  }

 }
​
 return
}
