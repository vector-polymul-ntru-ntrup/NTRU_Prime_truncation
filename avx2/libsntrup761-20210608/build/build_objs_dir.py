import string
import re
import platform
import sys
import os
import subprocess
import shutil
import datetime


from sysinfo import *
from compile import *
from gen_crypto_xxx_h import *

def walknosticky(d):
  result = []

  for dir,subdirs,files in os.walk(d,followlinks=True):
    if os.stat(dir).st_mode & 0o1000 == 0o1000:
      lognow('%s skipping sticky' % dir)
      for x in list(subdirs): subdirs.remove(x)
      continue
    result += [(dir,subdirs,files)]

  result.sort()
  return result


__location__ = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))


#
# implict input:  workdir from sysinfo.py
# output dir: workdir/rdest_dir    <-- rdest_dir is relative to workdir.
#
def write_crypto_xxx_h( rdest_dir , crypto_xxx_h , crypto_xxx_xxx_h , cate , primitive , imple ):
  try:
    os.makedirs( '%s/%s'%(workdir,rdest_dir) )
  except:
    pass
  fn_xxx = '%s.h' % cate
  fn1 = '/'.join( [workdir,rdest_dir,fn_xxx] )
  writefile( fn1 , crypto_xxx_h )
  fn_xxx_xxx = '%s_%s.h' %( cate,primitive )
  fn2 = '/'.join( [workdir,rdest_dir,fn_xxx_xxx] )
  writefile( fn2 , crypto_xxx_xxx_h )
  return (fn1,fn2)

#
# implict input:  tmpdir and workdir from sysinfo.py
# output dir: workdir/rdest_dir    <-- rdest_dir is relative to workdir.
# workdir/redest_dir contains necessary .h files
#
def build_objs_dir( src_dir , rdest_dir='.' , extra_cflags = '' ):
  if not os.path.isdir( src_dir ) : return []

  dir = src_dir
  files = sorted(os.listdir(dir))
  cfiles = [x for x in files if x.endswith('.c')]
  sfiles = [x for x in files if x.endswith('.s') or x.endswith('.S')]
  files = cfiles + sfiles

  shutil.rmtree(tmpdir,True)
  shutil.copytree(dir,tmpdir)

  ok = True
  r = []
  copt = '%s -I. -I%s/include -I%s/%s'% (extra_cflags, workdir, workdir,rdest_dir)  # !!! use global symbol: workdir
  lognow('compiler options %s' % copt)
  for f in files:
    objs = compile_and_move( '/'.join([tmpdir,f]) , copt , rdest_dir )
    r += objs
    if not objs:
       ok = False
    # but keep going through files to collect error messages
  shutil.rmtree(tmpdir,True)
  r.sort()
  return r







if __name__ == "__main__":
  if 1 == len(sys.argv) :
    print('Usage: \n\tbuild_dir.py crypto_xxx/xxx/xxx [rdest]\n')
    sys.exit(0)

  dir_name = sys.argv[1]
  if '/' == dir_name[-1] : dir_name = dir_name[:-1]
  objs = []

  rdest_dir = '.'
  if len(sys.argv)>2 : rdest_dir = sys.argv[2]

  cate,primitive,imple = parse_opi( dir_name )
  hs = []
  if cate :
    print('{0} is a "crypto_xxx/xxx/xxx" directory.'.format( dir_name ))
    rdest_dir = dir_name
    apidict ,crypto_xxx_h , crypto_xxx_xxx_h = crypto_xxx_env( dir_name , cate , primitive , imple )
    hs = write_crypto_xxx_h( rdest_dir , crypto_xxx_h , crypto_xxx_xxx_h , cate , primitive , imple )

  objs = build_objs_dir( dir_name , rdest_dir )
  print('Results:')
  print('h:')
  for i in hs: print(i)
  print('objs:')
  for i in objs :
    print(i)

