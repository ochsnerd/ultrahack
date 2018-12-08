#insert("helpers.sps")
#insert("importers.sps")

open float handHeight
{
  name = "Height [cm]"
  descr = "Height of your Hand in cm"
  value = 5 * 3.6
  min = 12.5
  max = 5 * 4.4
}

open float handWidth
{
  name = "Width [cm]"
  descr = "Width of your Hand in cm"
  value = 9.95
  min = 7.5
  max = 20.0
}

float handleGeometry[] = handleGeometryFromHand(handWidth, handHeight)

drawAxis(axis)


make (importGripTransition(handleGeometry[1], handleGeometry[0], 36) +
  importNeck() +
  importBaseplate())
