#insert("helpers.sps")

open float handHeight
{
  name = "Height [cm]"
  descr = "Height of your Hand in cm"
  value = 5 * 3.6
  min = 10.0
  max = 30.0
}

open float handWidth
{
  name = "Width [cm]"
  descr = "Width of your Hand in cm"
  value = 9.95
  min = 7.5
  max = 20.0
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

  solid grip = importSTL("include/grip_low.stl")
  grip <<= scaling(diaScaling, diaScaling, lenScaling)
  return grip
}

function importNeck()
{
  // Return the neck, with the attachment-point of the handle at (0,0,0)
  return importSTL("include/neck_high.stl")
}

function importBaseplate()
{
  return translation(<[0,-75.5,-25]>) >> importSTL("include/baseplate_low.stl")
}

float handleGeometry[] = handleGeometryFromHand(handWidth, handHeight)

drawAxis(axis)

make (importGrip(handleGeometry[1], handleGeometry[0]) +
  importNeck() +
  importBaseplate()) 
