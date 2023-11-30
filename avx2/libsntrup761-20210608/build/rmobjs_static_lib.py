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



if __name__ == "__main__":

  if not len(sys.argv) > 1 :
    print('  Usage: rmobjs_static_lib.py obj_name')
    exit(-1)
    #if not os.path.isdir( sys.argv[1] ):
    #  print('build_static_lib.py [crypto_dir_name] [extra_compiler_flags]')

  obj_name = sys.argv[1]
  print( f"\ntarget: supercop/lib/libsupercop.a: {obj_name}\n" );

  command = "nm supercop/lib/libsupercop.a"
  res, err = run( command )
  fn = list( filter( lambda x: x.startswith( obj_name ) , res.splitlines() )  )

  for f in fn:
    tar = str(f)[:-1]
    print( "attempt: rm:" + tar )
    command = f"ar dv supercop/lib/libsupercop.a { tar }"
    res, err = run( command )
    if(res):  print( "res: " + res )
    if(err): print( "err: " + err )

