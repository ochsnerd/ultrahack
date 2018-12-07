open float handHeight
{
  name = "Height [cm]"
  descr = "Height of your Hand in cm"
  value = 5 * 3.6
}

open float handWidth
{
  name = "Width [cm]"
  descr = "Width of your Hand in cm"
  value = 9.95
}

open string axis
{
  name= "Axis"
  descr = "You nosy bugger you"
  value = ''
}

function drawAxis(string dir)
{
  vector axis = <[0,0,0]>
  if (dir == 'x') {
    axis = <[100,0,0]>
  }
  else if (dir == 'y') {
    axis = <[0,100,0]>
  }
  else if (dir == 'z') {
    axis = <[0,0,100]>
  }
  else {
    echo ("Unknown direction " + dir)
    return
  }
  make cylinder(axis, 1)
}

function handleGeometryFromHand(float width, float height)
{
  // Takes the width and height of a hand in cm
  // Returns a list of length 2 containing the length, diameter of the handle
  return [10 * width, 10 * height / 5]
}

function importSTL(string name)
{
  // Import the stl from file name and return it as a solid
  return mesh(name)
}

function importGripCropped(float diameter, float length, float basediam)
{
  // Return the grip, scaled to prescribed length + diameter and fitting the
  // basediam.
}

function importGrip(float diameter, float length)
{
  // Return the grip, scaled to prescribed length + diameter.
  float origLen = 99.5
  float origDia = 36

  float lenScaling = length / origLen
  float diaScaling = diameter / origDia

  solid grip = importSTL("grip_low.stl")
  grip <<= scaling(diaScaling, diaScaling, lenScaling)
  return grip
}

function importNeck()
{
  // Return the neck, with the attachment-point of the handle at (0,0,0)
  return translation(<[0, -80, -30]>) >> importSTL("curved_neck_low.stl")
}


float handleGeometry[] = handleGeometryFromHand(handWidth, handHeight)

drawAxis(axis)

make (importGrip(handleGeometry[1], handleGeometry[0]) +
   importNeck())
