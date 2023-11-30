import string
import re
import platform
import sys
import os
import subprocess
import shutil
import datetime




workdir = '%s/supercop' % os.getcwd()
tmpdir = '%s/tmp' % workdir
notes = '%s/log' % workdir




def readfile(fn):
  with open(fn,'r') as f:
    return f.read()

def writefilebinary(fn,s):
  with open(fn,'wb') as f:
    f.write(s)

def writefile(fn,s):
  with open(fn,'w') as f:
    f.write(s)

def copymkdir(old,dir):
  try:
    os.makedirs(dir)
  except:
    pass
  shutil.copy(old,dir)





_si = None

def get_sysinfo(version = datetime.date.today().strftime('%Y%m%d')):
  global _si
  if( None != _si ) : return _si
  si = {}
  si['version'] = version
  okcharacters = string.ascii_letters + string.digits
  shorthostname = platform.node().split('.')[0].lower()
  si['shorthostname'] = ''.join(c for c in shorthostname if c in okcharacters)

  si['startdir'] = os.getcwd()
  work = '%s/link-build/build-%s/%s' % (si['startdir'],si['version'],si['shorthostname'])

  si['work'] = work
  si['notes'] = '%s/notes' % work
  si['hinternal'] = '%s/include' % work
  si['tmp'] = '%s/tmp' % work

  si['log'] = '%s/log' % si['notes']
  _si = si;
  return _si




_logprevious = None

def lognow(x,y=''):
  global _logprevious

  x = re.sub('\n','_',x)
  output = '%s\n' % x
  if y:
    try:
      y = y.decode()
    except:
      pass
    for z in y.splitlines():
      output += '> %s\n' % z

  now = datetime.datetime.now()
  if _logprevious == None: _logprevious = now
  duration = (now - _logprevious).total_seconds()
  _logprevious = now

  try:
    os.makedirs(notes)
  except:
    pass
  with open( '%s/log'%notes ,'a+') as log:
    log.write('%s === %9f === %s' % (now.ctime(),duration,output))
    log.flush()
  sys.stdout.write(output)
  sys.stdout.flush()


def get_tmp_dirname():
  r = 'tmp'
  while os.path.exists( '%s/%s' %(workdir,r) ) :
    r = '%s_' % r
  return '%s/%s' %(workdir,r)


def build_mkdirs():
  #si = get_sysinfo()
  try:
    os.makedirs( tmpdir )
    os.makedirs( notes )
    os.makedirs( '%s/include'% workdir )
    os.makedirs( '%s/lib'    % workdir )
    #os.makedirs( si['work'] )
    #os.makedirs( si['notes'] )
    #os.makedirs( si['hinternal'] )
    #os.makedirs( si['tmp'] )
  except:
    pass



if __name__ == "__main__":
  print('This is a building lib for collecting system info.')
  print('Execute this file will make working directories.')
  build_mkdirs()

  print('sysinfo:')
  print('os.getcwd():', os.getcwd())
  print('workdir    :', workdir)
  print('tmpdir     :', tmpdir)
  print('notes      :', notes)
  d = get_sysinfo()
  for i in d:
    print(i,'\t:\t',d[i])


