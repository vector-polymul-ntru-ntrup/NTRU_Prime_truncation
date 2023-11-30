import string
import re
import platform
import sys
import os
import subprocess
import shutil
import datetime
import signal

from sysinfo import *
from compile import *
from gen_crypto_xxx_h import *
from build_objs_dir import *


#test_run = 32

__location__ = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))
static_lib_name = '%s/lib/libsupercop.a' % (workdir)


signals = dict((getattr(signal,x),x) for x in dir(signal) if x.startswith('SIG') and '_' not in x)


def returncodestr(n):
  if -n in signals: return signals[-n]
  return str(n)



def objlib_add( obj_file, prefix_in_lib, staticlib=static_lib_name):
  name = os.path.basename(obj_file)
  dir = os.path.dirname(obj_file)
  doto = '%s/%s_%s' % (dir,prefix_in_lib,name)

  if os.path.exists(doto):
    lognow('warning: overwriting %s' % doto)
    #return
  shutil.copy(obj_file,doto)
  try:
    cmd = 'ar cr %s %s' % (staticlib,doto)
    p = subprocess.Popen(cmd.split(),stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    out,err = p.communicate()
    if out:
      lognow('archiver stdout',out)
    if err:
      lognow('archiver stderr',err)
    if p.returncode:
      lognow('archiver failed exit %s' % returncodestr(p.returncode))
  except Exception as e:
    lognow('archiver failed %s' % e)
  try:
    cmd = 'ranlib %s' % staticlib
    p = subprocess.Popen(cmd.split(),stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    out,err = p.communicate()
    if out:
      lognow('ranlib stdout',out)
    if err:
      lognow('ranlib stderr',err)
    if p.returncode:
      lognow('ranlib failed exit %s' % returncodestr(p.returncode))
  except Exception as e:
    lognow('ranlib failed %s' % e)


def objlib_add_objs( objs , rdir , c_ ):
  trydir = '%s/%s' % (rdir,c_)
  inst_prefix = re.sub( '/','_', trydir ) # necessary since rdir contains '/'
  lognow('addlib %s' % inst_prefix )
  for fo in objs:
    objlib_add(fo,inst_prefix)
  return objs


def link(c,c_,tmp,dir,exe,o):
  try:
    cmd = '%s -fvisibility=hidden -o %s %s ' % (c,exe,' '.join(o))
    p = subprocess.Popen(cmd.split(),cwd=tmp,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    out,err = p.communicate()
    assert not err
    if out:
      lognow('linker output',out)
      try:
        os.makedirs('%s/%s/%s' % (notes,c_,dir))
      except:
        pass
      writefilebinary('%s/%s/%s/%s' % (notes,c_,dir,exe),out)
    if p.returncode:
      lognow('linker failed %s %s/%s ' % (returncodestr(p.returncode),dir,exe))
      return False
    return True
  except Exception as e:
    lognow('linker exited %s %s/%s ' % (e,dir,exe))
    return False

def run(c,c_,tmp,dir,exe):
  try:
    cmd = './%s' % exe
    p = subprocess.Popen(cmd.split(),cwd=tmp,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
    out,err = p.communicate()
    if err:
      lognow('test stderr',err)
      try:
        os.makedirs('%s/%s/%s' % (notes,c_,dir))
      except:
        pass
      writefilebinary('%s/%s/%s/%s' % (notes,c_,dir,exe),err)
    if p.returncode:
      lognow('%s/%s test exited %s' % (dir,exe,returncodestr(p.returncode)))
      return
    return out.decode()
  except Exception as e:
    lognow('%s/%s test failed %s' % (dir,exe,e))
    return

def objsize(o):
  result = 0
  for line in subprocess.check_output(['size']+o).decode().splitlines():
    line = line.split()
    if line[0] != 'text':
      result += int(line[0])
  return result

def link_and_run_internal( objs , rdir , c_ ):
  trydir = '%s/%s' % (rdir,c_)
  tmp = '/'.join([workdir,trydir])
  c = compilers['c'][0]  # linker
  if link(c,c_,tmp,trydir,'test', objs ) :
    cycles = run(c,c_,tmp,trydir,'test')
    if cycles:
      #rec = [ int(cycles.strip()) ]
      #for i in range(1,test_run) :
      #  cycles = run(c,c_,tmp,trydir,'test')
      #  rec.append( int(cycles.strip()) )
      #cycles = sum(rec)/len(rec)
      #rec.sort()
      #cycles = rec[test_run//2]
      # try-cycles returns median of 63 measurements
      cycles = int(cycles.strip())
      lognow('cycles %d %s' % (cycles,trydir))
      return cycles
  return -1


def link_and_run_test( objs , rdir , c_ ):
  trydir = '%s/%s' % (rdir,c_)
  tmp = '/'.join([workdir,trydir])
  c = compilers['c'][0] + ' -L%s/lib'%workdir      # linker
  if link(c,c_,tmp,trydir,'test', objs  + [ '-lsupercop -lcrypto -lssl' ] ) :
    cycles = run(c,c_,tmp,trydir,'test')
    if cycles:
      #rec = [ int(cycles.strip()) ]
      #for i in range(1,test_run) :
      #  cycles = run(c,c_,tmp,trydir,'test')
      #  rec.append( int(cycles.strip()) )
      #cycles = sum(rec)/len(rec)
      #rec.sort()
      #cycles = rec[test_run//2]
      # try-cycles returns median of 63 measurements
      cycles = int(cycles.strip())
      bytes = objsize(['%s/test'%tmp])
      cost = cycles + 0.02*bytes
      lognow('cycles %d cost %.2f bytes %d %s' % (cost,cycles,bytes,trydir))
      return cycles
  return -1



def build_internal_dir( dir ) :
  objs0 = build_objs_dir( '%s/%s'%(__location__,dir) , dir )
  cc = (objs0[0][0],objs0[0][1])   # choose the first category
  return objlib_add_objs( objs_get_filenames(objs0,*cc) , *cc )


def build_internal_dir_test( dir , testdir ):
  objs0 = build_objs_dir( '%s/%s'%(__location__,dir) , dir )
  tester = build_objs_dir( '%s/%s'%(__location__,testdir) , dir )
  cates = list(set( [ (x[0],x[1]) for x in objs0 ] ))
  # test every candidates
  rec = []
  for cc in cates:
    lognow('test %s %s'%cc )
    t = link_and_run_internal( objs_get_filenames(objs0,*cc) + [ tester[0][2] ] , *cc )
    if t>0 : rec.append( (t,cc) )
  # install static lib
  rec.sort()
  if rec :
    cc = rec[0][1]
    lognow('addlib %s %s'%(str(rec[0][0]),'/'.join(cc)) )
    return objlib_add_objs( objs_get_filenames(objs0,*cc) , *cc )
  return []




# ----- crypto_xxx
def build_crypto_xxx(op,prim,path='.',extra_cflags='') :
  curr_dir = os.getcwd()
  op_prim = '%s/%s'%(op,prim)
  ll = os.listdir( '%s/%s/%s'%(curr_dir,path,op_prim) )
  impls = filter( lambda x: os.path.isdir( '%s/%s/%s/%s'%(curr_dir,path,op_prim,x) ) , ll )
  impls = list(impls)
  impls.sort()

  # compile every implementations
  lognow('building: %s,%s'%(op,prim) )
  tester = compile_and_move('%s/%s'%(__location__,'try-cycles.c'),'',op_prim)
  objs  = []
  rec = []
  for impl in impls:
    rdest_dir = '%s/%s'%(op_prim,impl)
    dir = '%s/%s'%(path,rdest_dir)
    lognow( 'building dir %s'%dir )
    # .h files
    apidict ,crypto_xxx_h , crypto_xxx_xxx_h = crypto_xxx_env( dir , op , prim , impl )
    lognow( 'api.h: %s items: %s'%(str(len(apidict)), ' '.join(apidict.keys())  ) )
    write_crypto_xxx_h( rdest_dir , crypto_xxx_h , crypto_xxx_xxx_h , op , prim , impl )
    # generate obj files
    my_objs  = build_objs_dir( dir , rdest_dir , extra_cflags )
    my_tests = build_objs_dir( '%s/%s'%(__location__,op) , rdest_dir , extra_cflags )
    if not my_objs : continue
    objs  += my_objs

    for cc in sorted(set((o[0],o[1]) for o in my_objs)):
      lognow('test %s %s'%cc )
      t = link_and_run_test( objs_get_filenames(my_objs,*cc) + objs_get_filenames(my_tests,*cc) + [ tester[0][2] ] , *cc )
      if t < 0: continue
      rec.append( (t,cc) )
  #cates = list(set( [ (x[0],x[1]) for x in objs ] ))
  # install static lib
  rec.sort()
  r = []
  if rec :
    cycles = str(rec[0][0])
    cc = rec[0][1]
    lognow('addlib %s %s'%(cycles,'/'.join(cc)) )
    r = objlib_add_objs( objs_get_filenames(objs,*cc) , *cc )
    # copy .h files
    fn_crypto_xxx_xxx_h = '%s/%s/%s_%s.h'%(workdir,cc[0],op,prim)
    copymkdir( fn_crypto_xxx_xxx_h , '%s/include'%workdir )
    if 'crypto_rng' == op :      #### for fastrandombytes
      fn_crypto_xxx_h = '%s/%s/%s.h'%(workdir,cc[0],op)
      copymkdir( fn_crypto_xxx_h , '%s/include'%workdir )
  return r



def build_crypto_xxx_notest(op,prim,impl,path='.', extra_cflags='') :
  curr_dir = os.getcwd()
  op_prim = '%s/%s'%(op,prim)
  rdest_dir = '%s/%s'%(op_prim,impl)
  src_dir = '%s/%s'%(path,rdest_dir)
  lognow('building: %s'%(rdest_dir) )
  # .h files
  apidict ,crypto_xxx_h , crypto_xxx_xxx_h = crypto_xxx_env( src_dir , op , prim , impl )
  lognow( 'api.h: %s items: %s'%(str(len(apidict)), ' '.join(apidict.keys())  ) )
  fn_xxx_h, fn_xxx_xxx_h = write_crypto_xxx_h( rdest_dir , crypto_xxx_h , crypto_xxx_xxx_h , op , prim , impl )
  # generate obj files
  objs  = build_objs_dir( src_dir , rdest_dir , extra_cflags )
  if not objs : return objs
  # pick first imple
  cc = (objs[0][0],objs[0][1])
  # install static lib
  lognow('addlib %s'%'/'.join(cc) )
  r = objlib_add_objs( objs_get_filenames(objs,*cc) , *cc )
  # copy .h files
  copymkdir( fn_xxx_xxx_h , '%s/include'%workdir )
  if 'crypto_rng' == op : copymkdir( fn_xxx_h , '%s/include'%workdir )
  return r




def build_system():
  build_mkdirs()
  ### cpucycles
  #build_internal_dir_test( 'cpucycles/amd64cpuinfo' , 'cpucycles' )
  build_internal_dir( 'cpucycles/amd64cpuinfo' )
  build_internal_dir( 'verifylib/declassify' )
  ### randombytes
  #build_internal_dir_test( 'kernelrandombytes/getentropy' , 'kernelrandombytes' )
  build_internal_dir( 'kernelrandombytes/getentropy' )
  build_crypto_xxx_notest('crypto_stream','aes256ctr','dolbeau_aesenc_int','build')
  build_crypto_xxx_notest('crypto_rng','aes256','ref','build')
  build_internal_dir( 'fastrandombytes/supercop' )
  ### sha512
  build_crypto_xxx_notest('crypto_hash','sha512','openssl','build' )



if __name__ == "__main__":

  # process building targets
  build_dirs = []
  if len(sys.argv) > 1 :
    if not os.path.isdir( sys.argv[1] ):
      print('build_static_lib.py [crypto_dir_name] [extra_compiler_flags]')
      exit(-1)
    ll = filter( lambda x: x !='' , [ x.strip() for x in sys.argv[1].split('/')] )
    ll = list(ll)
    if not ll[0].startswith( 'crypto_' ) :
      print('build_static_lib.py [crypto_dir_name: startswith crypto_]')
      exit(-1)
    op = ll[0]
    curr_dir = os.getcwd()
    if 1 == len(ll) :  # crypto_xxx
      prims = filter( lambda x: os.path.isdir( '%s/%s/%s'%(curr_dir,op,x) ) , os.listdir( '%s/%s'%(curr_dir,op) ) )
      prims = sorted(prims)
      build_dirs += [ (op,x,'.') for x in prims ]
    elif 2 == len(ll):  # crypto_xxx/xxx
      build_dirs += [ (op,ll[1],'.') ]
    else :  # crypto_xxx/xxx/xxx
      build_dirs += [ (op,ll[1],ll[2],'.') ]

  # process extra compiler flags
  extra_cflags = ''
  if len(sys.argv) > 2 :
    extra_cflags = ' '.join( sys.argv[2:] )

  if not os.path.exists(static_lib_name) :
    print('build_system()')
    build_system()

  ### default build
  if not build_dirs :
    print('no default build dir except the system.')
    #build_dirs.append( ('crypto_hash','sha512' , 'build' ) )
    #build_dirs.append( ('crypto_encode','761xint16') )
    #build_dirs.append( ('crypto_decode','761xint16') )
    #build_dirs.append( ('crypto_core','multbigsntrup761') )

  for op_pr in build_dirs :
    if len(op_pr)==4: build_crypto_xxx_notest( *op_pr , extra_cflags )
    else : build_crypto_xxx( *op_pr , extra_cflags)



