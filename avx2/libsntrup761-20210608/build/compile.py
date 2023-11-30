import string
import re
import platform
import sys
import os
import subprocess
import shutil
import datetime


from sysinfo import *



def compile(c,c_,tmp,dir,f):
  #extra_flag = ''
  namespace = dir.replace('/','_')
  extra_flag = f'-DCRYPTO_NAMESPACETOP={namespace} -D_CRYPTO_NAMESPACETOP=_{namespace} -DCRYPTO_NAMESPACE(name)={namespace}_##name -D_CRYPTO_NAMESPACE(name)=_{namespace}_##name'
  #extra_flag = '-DN_KEYBATCH=32'
  #extra_flag = '-g -fsanitize=address'
  try:
    command = '%s -fvisibility=hidden %s -c %s' % (c,extra_flag,f)
    p = subprocess.Popen(command.split(),cwd=tmp,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    out,err = p.communicate()
    assert not err
    if out:
      lognow(f'compile output: {command}',out)
      try:
        os.makedirs('%s/%s/%s' % (notes,c_,dir))
      except:
        pass
      writefilebinary('%s/%s/%s/%s' % (notes,c_,dir,f),out)
    if p.returncode:
      lognow('compiler exited %s %s/%s' % (p.returncode,dir,f))
      return False
    return True
  except Exception as e:
    lognow('compiler failed %s %s/%s : %s' % (e,dir,f, command))
    return False

#####

def guessarchitectures(c):
  try:
    command = '%s -dumpmachine' % (c)
    p = subprocess.Popen(command.split(),cwd='./',stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    out,err = p.communicate()
    assert not err
    if p.returncode:
      lognow('dumpmachine exited %s' % (p.returncode))
    out = out.decode()
    if out.startswith('x86_64'): return ['x86','amd64']
    if out.startswith('i686'): return ['x86']
    if out.startswith('i386'): return ['x86']
    if out.startswith('aarch64'): return ['arm','armeabi','aarch64']
    if out.startswith('arm'): return ['arm','armeabi']
    return
  except Exception as e:
    lognow('dumpmachine failed %s' % e)
    return

def checknamespace(tmp,dir,fo,namespace):
  for symbol in subprocess.check_output(['nm','-pP','--defined-only','%s/%s' % (tmp,fo)]).decode().splitlines():
    symbol = symbol.split()
    if symbol[1] in ['b','d','r','t']: continue
    if symbol[0] == namespace: continue
    if symbol[0].startswith('%s_' % namespace): continue
    if symbol[0].startswith('__x86.get_pc_thunk.'): continue
    x = '%s_priv_%s' % (namespace,symbol[0])
    lognow('%s warning: namespace violation: %s %s %s %s' % (dir,fo,symbol[0],symbol[1],x))

#####


__location__ = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))

compilers = {}
compilers['c'] = readfile( os.path.join(__location__,'compilers/c') ).splitlines()
compilers['c'] = [x.strip() for x in compilers['c']]
compilers['c'] = [x for x in compilers['c'] if x != '']



def compile_and_move(f,opt='',rdest_dir='.'):
  name = os.path.basename(f)
  objs = []
  if '.c' != name[-2:] and '.s' != name[-2:] and '.S' != name[-2:] : return objs
  name_o = '%s.o' % name[:-2]
  dir = os.path.dirname(f)
  if '' == dir : dir = '.'

  lognow('compiling %s' % f )
  for c in compilers['c'] :
    c_ = re.sub(' ','_',c)
    copt = ' '.join( [c,opt,'-I%s/include'%__location__] )  # add internel .h files
    lognow('compiler %s' % c )
    if compile(copt,c_,dir,rdest_dir,name) :
      dest_dir = '/'.join( [workdir,rdest_dir,c_] )  # !!! use global symbol: workdir
      # lognow( 'moving obj to %s/%s'%(dest_dir,name_o) )
      copymkdir( '%s/%s'%(dir,name_o) , dest_dir )
      os.remove( '%s/%s'%(dir,name_o) )
      objs.append( [rdest_dir,c_,'%s/%s'% (dest_dir,name_o)] )
      #checknamespace(tmp,'kernelrandombytes','kernelrandombytes.o','pqkernelrandombytes_impl')
  return objs


#
# parse the result of build_obj_dir()
#
def objs_get_filenames( objs , rdir_name, c_ ):
  return [ x[2] for x in filter( lambda x: x[0]==rdir_name and x[1]==c_ , objs ) ]





if __name__ == "__main__":
  if 1 == len(sys.argv) :
    print('Usage: \n\tcompile.py xxxx.c [extra_args_for_compiler]\n')
    sys.exit(0)
  if 0 == len(compilers) :
    print('no compilers from compilers/c')
    sys.exit(-1)
  if '.c' != sys.argv[1][-2:] and '.s' != sys.argv[1][-2:] and '.S' != sys.argv[1][-2:] :
    print('compile xxx.c/.s/.S only')
    sys.exit(-1)

  args = ' '.join(sys.argv[2:])

  build_mkdirs()
  objs = compile_and_move( sys.argv[1] , args )
  print('Results:')
  for i in objs :
    print(i[0],i[1],i[2])


