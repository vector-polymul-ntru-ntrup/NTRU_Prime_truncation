import string
import re
import platform
import sys
import os
import subprocess
import shutil
import datetime


def run( command ) :
  process = subprocess.Popen( command.split() ,
                     stdout=subprocess.PIPE ,
                     stderr=subprocess.PIPE , universal_newlines=True )
  stdout, stderr = process.communicate()
  return stdout, stderr


def read_result( data ) :
  key = []
  lat = []
  for l in data.splitlines() :
    if( l.startswith( 'keypairbatch' ) ):
      ll = l.split()
      key.append( int(ll[1]) )
    if( l.startswith( 'latency' ) ):
      ll = l.split()
      lat.append( int(ll[1]) )
  key.sort()
  lat.sort()
  return key[1], lat[1]


p = 761


for i in range(2, 10):

  command = "nm supercop/lib/libsupercop.a"
  res, err = run( command )
  fn = list( filter( lambda x: x.startswith( f'crypto_kem_sntrup{p}') , res.splitlines() )  )

  for f in fn:
    #print( str(f)[:-1] )
    command = f"ar dv supercop/lib/libsupercop.a { str(f)[:-1] }"
    res, err = run( command )
    #print( "res: " + res )
    #print( "err: " + err )


  command = f"python3 build/build_static_lib.py crypto_kem/sntrup{p}/factored -DN_KEYBATCH={i}"
  res, err = run( command )
  if err :
    print( "res: " + res )
    print( "err: " + err )
    break

  command = f"gcc -DN_KEYBATCH={i} -Isupercop/include -O3 unit-test/batchgenkey-test.c supercop/lib/libsupercop.a -o batchgenkey-test -lcrypto"
  res, err = run( command )
  if err :
    print( "res: " + res )
    print( "err: " + err )
    break

  command = "./batchgenkey-test"
  res, err = run( command )
  if err :
    print( "res: " + res )
    print( "err: " + err )
    break

  key, lat = read_result( res )
  print( f"{i},\t{key},\t{lat}" )

  with open(f"result_p{p}_{i}.txt", "w+")  as f:
    f.write( res )
