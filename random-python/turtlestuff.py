#!/usr/bin/python
import turtle
turtle.speed(10)
turtle.hideturtle()
turtle.colormode(255)

def tursq(len):
  turtle.fill(1)
  for x in range(4):
    turtle.forward(len)
    turtle.lt(90)
  turtle.fill(0)

def pytree(step, len):
  turtle.ht
  tursq(len)
  if step < 1:
    return None
  turtle.lt(90)
  turtle.fd(len)
  turtle.rt(45)
  pytree(step-1, (len*0.707106))
  turtle.rt(45)
  turtle.fd(len)
  turtle.lt(135)
  turtle.fd(len*0.707106)
  turtle.rt(180)
  pytree(step-1, (len*0.707106))
  turtle.fd(len*0.707106)
  turtle.rt(45)
  turtle.fd(len)
  turtle.rt(90)
  turtle.fd(len)
  turtle.rt(180)

def turmandel(step, zoom, xres, yres, xthresh, ythresh):
  turtle.setheading(0)
  for y in range(yres):
    turtle.pu()
    turtle.setpos(0, y)
    turtle.pd()
    for x in range(xres):
      x = float(x)
      y = float(y)
      u = float(x)/float((xres/zoom))-xthresh
      v = float(y)/float((yres/zoom))-ythresh
      x0 = float(u)
      y0 = float(v)
      a = 0.0
      b = 0.0
      i = step
      while ((i>0) and (a+b<=4.0)):
        a = float(x0*x0)
        b = float(y0*y0)
        y0 = float(2.0*x0*y0+v)
        x0 = float(a-b+u)
        i = i - 1
      color = i % 255
      turtle.pencolor((color, color, color))
      if i < 1:
        turtle.pencolor((0,0,0))
      turtle.fd(1)
    #END FOR X
  #END FOR Y

#to mandelcolor :step :zoom :xres :yres :xthresh :ythresh
#  setorientation [0 0 90] 
#  for [y 0 :yres 1] [ ~
#      pu ~
#      setpos (list 0 :y) ~
#      pd ~
#      for [x 0 :xres 1] [ ~
#      make "u :x/(:xres/:zoom)-:xthresh ~
#      make "v :y/(:yres/:zoom)-:ythresh ~
#      make "x0 :u ~
#      make "y0 :v ~
#      make "a 0 ~
#      make "b 0 ~
#      make "i :step ~
#      while [(and (:i>0) (:a+:b<4))] [ ~
#      make "a :x0*:x0 ~
#      make "b :y0*:y0 ~
#      make "y0 2*:x0*:y0+:v ~
#      make "x0 :a-:b+:u ~
#      make "i :i-1 ~
#      ] ~
#      setpencolor (list :i :i :i) ~
#      if :i < 1 [setpencolor[0 0 0]] ~
#      fd 1 ~
#      ] ~
#      ]
#end
