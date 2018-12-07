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
