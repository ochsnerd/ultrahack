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

open color handleColor
{
  name="Color"
  descr="Color of the handle"
  value=rgb(40,40,40)
}

solid attachments[] = [importSTL("include/attachments_empty.stl"),
                       importSTL("include/attachments_quarter.stl"),
                       importSTL("include/attachments_eights.stl"),
                       importSTL("include/attachments_ulcs.stl"),
                       importSTL("include/attachments_cableclips.stl")]

atrafo attachment_transforms[] = [translation(<[0,20,-16.5]>) >> rotation(<[0,0,1]>, rad(0)),
                                  translation(<[0,-1.5,30]>) >> rotation(<[0,0,1]>, rad(0)),
                                  translation(<[20,-1.5,-16.5]>) >> rotation(<[0,0,1]>, rad(0)),
                                  translation(<[-20,-1.5,-16.5]>) >> rotation(<[0,0,1]>, rad(0))]

float handleGeometry[] = handleGeometryFromHand(handWidth, handHeight)

make handleColor >> (importGripTransition(handleGeometry[1], handleGeometry[0], 40) +
  importNeck() +
  importBaseplate())
