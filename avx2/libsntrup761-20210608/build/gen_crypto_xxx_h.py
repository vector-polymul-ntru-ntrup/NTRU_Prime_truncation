#!/usr/bin/python3

import sys
import os
import os.path
import re


# parse input.  crypto_xxx/xxx/xxx -> crypto_cate_primitive_imple
def parse_opi( imple_dir ):
  if not os.path.isdir( imple_dir ): return ('','','')
  ll = filter( lambda x: x !='' , map(lambda x: x.strip() , imple_dir.split('/')) )
  ll = list(ll)
  if len(ll) < 3 : return ('','','')
  if not ll[0].startswith( 'crypto_' ) : return ('','','')
  return ( ll[0], ll[1], '_'.join(ll[2:]) )




from sysinfo import lognow


# parse api.h
def read_api_h( imple_dir ) :
  apidict = {}
  #incl = []
  try:
    with open( '%s/api.h'%imple_dir ,'r') as f:
      api = f.read()
  except:
    lognow('warning: no api.h')
    return apidict
  for line in api.splitlines():
    apiline = line.strip().split()
    try:
      assert len(apiline) == 3
      assert apiline[0] == '#define'
      assert apiline[2] == str(int(apiline[2]))
      apidict[apiline[1]] = apiline[2]
    except:
      lognow('warning: api.h looseness: %s' % line)
  return apidict



__location__ = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))

from sysinfo import readfile

macros = readfile( os.path.join(__location__, 'MACROS') ).splitlines()
macros = map( lambda x: x.strip() , macros )
macros = list(macros)

prototypes = {}
prototypes['c'] = readfile( os.path.join(__location__, 'PROTOTYPES.c') ).splitlines()


# first file: crypto_kem.h or crypto_core.h
# The file of this level has no idea about the implementation. It only deals about the category and the primitive.
#
'''
        x = ''
        x += '#ifndef %s_H\n' % o
        x += '#define %s_H\n' % o
        x += '\n'
        x += '#include "%s.h"\n' % op
        for m in macros:
          m = m.strip()
          if m == o or m.startswith(o + '_'):
            x += '#define %s %s%s\n' % (m,op,m[len(o):])
        x += '#define %s_primitive "%s"\n' % (o,p)
        x += '#define %s_implementation %s_implementation\n' % (o,op)
        x += '#define %s_version %s_version\n' % (o,op)
        x += '#define %s_compiler %s_compiler\n' % (o,op)
        x += '\n'
        x += '#endif\n'
'''
def gen_crypto_xxx_h( cate , primitive , apidict ):
  r = []
  r.append( '#ifndef {}_H\n'.format(cate) );
  r.append( '#define {}_H\n'.format(cate) );
  r.append( '\n' );
  r.append( '#include "{}_{}.h"\n'.format(cate,primitive) );
  for m in macros:
    if m == cate or m.startswith( cate + '_' ):
      r.append( '#define %s %s_%s%s\n' % (m,cate,primitive,m[len(cate):]) )
  r.append( '\n' );
  r.append( '#define {0}_PRIMITIVE "{1}"\n'.format( cate , primitive ) );
  r.append( '#define {0}_implementation {0}_{1}_implementation\n'.format( cate , primitive ) );
  r.append( '#define {0}_IMPLEMENTATION {0}_{1}_IMPLEMENTATION\n'.format( cate , primitive ) );
  r.append( '\n' );
  r.append( '#endif\n' );
  return ''.join(r)


# 2nd file : crypto_xxxx_[primitive]_[implementation].h
# The file connect the "defines" in crypto_[primitive].h to real implementations.
#
'''
        x = ''
        x += '#ifndef %s_H\n' % op
        x += '#define %s_H\n' % op
        x += '\n'
        for m in macros:
          m = m.strip()
          if m == o or m.startswith(o + '_'):
            x += '#define %s%s %s%s\n' % (op,m[len(o):],opi,m[len(o):])
        x += '#define %s_implementation %s_implementation\n' % (op,opi)
        x += '#define %s_version %s_version\n' % (op,opi)
        x += '#define %s_compiler %s_compiler\n' % (op,opi)
        x += '\n'

        for m in macros:
          m = m.strip()
          if m.startswith(o + '_'):
            key = 'CRYPTO%s' % m[len(o):]
            if key in apidict:
              x += '#define %s%s %s\n' % (opi,m[len(o):],apidict[key])

        x += '\n'
        x += '#ifdef __cplusplus\n'
        x += '// C++ wrappers not included in libpqcrypto yet\n'
        x += '#include <string>\n'
        for fun in prototypes['cpp']:
          fun = fun.strip()
          if re.search(' %s[(_]' % o,fun):
            x += '%s\n' % re.sub(' %s' % o,' %s' % op,fun)
        x += 'extern "C" {\n'
        x += '#endif\n'
        x += '\n'
        for fun in prototypes['c']:
          fun = fun.strip()
          if re.search(' %s[(_]' % o,fun):
            x += '%s\n' % re.sub(' %s' % o,' %s' % op,fun)
        x += 'extern const char %s_implementation[] __attribute__((visibility("default")));\n' % op
        x += 'extern const char %s_version[] __attribute__((visibility("default")));\n' % op
        x += 'extern const char %s_compiler[] __attribute__((visibility("default")));\n' % op
        x += '\n'
        x += '#ifdef __cplusplus\n'
        x += '}\n'
        x += '#endif\n'
        x += '\n'
        x += '#endif\n'
'''

def gen_crypto_xxx_xxx_h( cate , primitive , imple , apidict ) :
  r = []
  r.append( '#ifndef {}_{}_H\n'.format( cate , primitive ) )
  r.append( '#define {}_{}_H\n'.format( cate , primitive) )
  r.append( '\n' )
  #for inc in incl :
  #  r.append( inc )
  for m in macros:
    if m.startswith(cate + '_'):
       key = 'CRYPTO%s' % m[len(cate):]
       if key in apidict:
         r.append( '#define {0}_{1}_{2}{3} {4}\n'.format(cate,primitive,imple,m[len(cate):],apidict[key]) )
  r.append( '\n' )
  for m in macros:
    if m == cate or m.startswith( cate + '_'):
      r.append( '#define {0}_{1}{3} {0}_{1}_{2}{3}\n'.format(cate,primitive,imple,m[len(cate):]) )
  r.append( '\n' )
  r.append( '#ifdef __cplusplus\n' )
  r.append( 'extern "C" {\n' )
  r.append( '#endif\n' )
  for fun in prototypes['c']:
    fun = fun.strip()
    if re.search(' %s[(_]' % cate,fun):
      r.append( '%s\n' % re.sub(' %s' % cate,' {}_{}'.format(cate,primitive),fun) )
  r.append( '#ifdef __cplusplus\n' )
  r.append( '}\n' )
  r.append( '#endif\n' )
  r.append( '\n' )
  r.append( '#define {0}_{1}_IMPLEMENTATION "{0}/{1}/{2}"\n'.format( cate , primitive , imple ) )
  r.append( '#define {0}_{1}_implementation "{0}/{1}/{2}"\n'.format( cate , primitive , imple ) )
  r.append( '#ifndef {}_{}_{}_VERSION\n'.format( cate , primitive , imple) )
  r.append( '#define {}_{}_{}_VERSION "-"\n'.format( cate , primitive , imple) )
  r.append( '#endif\n' )
  r.append( '#define {2}_{0}_VERSION {2}_{0}_{1}_VERSION\n'.format( primitive , imple , cate ) )
  r.append( '\n' )
  r.append( '#endif\n' )
  return ''.join(r)




def crypto_xxx_env( dir_api_h , op, prim, impl ) :
  apidict = read_api_h( dir_api_h )
  crypto_xxx_h = gen_crypto_xxx_h( op , prim , apidict )
  crypto_xxx_xxx_h = gen_crypto_xxx_xxx_h( op , prim , impl , apidict )
  return ( apidict , crypto_xxx_h , crypto_xxx_xxx_h )



if __name__ == "__main__":
  print(__file__)

  if 1 >= len(sys.argv) :
    print('Usage: \n\tgen_crypto_xxx_h.py crypto_xxx/prim/imple\n')
    sys.exit(0)

  dir_name = sys.argv[1]
  op,prim,imple = parse_opi( dir_name )
  if not op :
    print('parse_opi({0}) fail. is {0} a directory of "crypto_xxx/xxx/xxx" ?'.format( dir_name ))
    sys.exit(-1)

  apidict ,crypto_xxx_h , crypto_xxx_xxx_h = crypto_xxx_env( dir_name , op, prim, imple )
  print('api dict contains %s itmes.' % str(len(apidict)))

  fn_xxx = '%s.h' % op
  fn_xxx_xxx = '%s_%s.h' %( op,prim )

  print("write %s" % fn_xxx )
  with open( fn_xxx , "w+" ) as f :
    f.write( crypto_xxx_h )

  print("write %s" % fn_xxx_xxx )
  with open( fn_xxx_xxx , "w+" ) as f :
    f.write( crypto_xxx_xxx_h )

