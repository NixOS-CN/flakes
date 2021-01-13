#!@python3@/bin/python3

import subprocess
import os
import pathlib
import argparse

def may_extract(prefix, tarball, env):
  hash_file = prefix / '.hash'

  try:
    current_hash = pathlib.Path(hash_file).read_text().strip()
  except FileNotFoundError:
    need_update = True
  else:
    if current_hash != '@expectedHash@':
      need_update = True
    else:
      need_update = False

  if need_update:
    prefix.mkdir(parents=True, exist_ok=True)
    subprocess.check_call([
      '@gnutar@/bin/tar', '-xf', tarball, '-C', prefix,
    ])
    subprocess.check_call([
      '@winetricksForWechat@/bin/winetricks', 'sandbox',
    ], env=env)
    subprocess.check_call([
      '@wineForWechat@/bin/wine', 'regedit', r'C:\wechat.reg',
    ], env=env)
    os.unlink(prefix / 'drive_c' / 'wechat.reg')

    with open(hash_file, 'w') as f:
      f.write('@expectedHash@')

if __name__ == '__main__':
  parser = argparse.ArgumentParser(description='Wine WeChat')
  parser.add_argument('-c', '--config', action='store_true',
                      help='run winecfg')
  parser.add_argument('-d', '--dir', action='store_true',
                      help='open Wine prefix directory')
  parser.add_argument('-p', '--profile', type=str,
                      help='use alternative profile')
  parser.add_argument('args', nargs='*',
                      help='arguments for WeChat.exe')
  args = parser.parse_args()

  root = os.environ.get('XDG_DATA_DIR', os.environ['HOME'] + '/.local')
  root = pathlib.Path(root)
  prefix = root / 'lib/wine-wechat' / (args.profile or 'default')
  tarball = pathlib.Path('@tarball@')

  env = os.environ.copy()
  env['WINEDLLOVERRIDES'] = 'winemenubuilder.exe=d'
  env['WINEARCH'] = 'win32'
  env['WINEPREFIX'] = str(prefix)
  env['LANG'] = 'zh_CN.UTF-8'

  may_extract(prefix, tarball, env)

  if args.config:
    os.execvpe('@wineForWechat@/bin/winecfg', ['@wineForWechat@/bin/winecfg'], env)

  if args.dir:
    os.execvp('xdg-open', ['xdg-open', prefix])

  os.chdir(prefix / 'drive_c/Program Files/Tencent/WeChat')
  os.execvpe('@wineForWechat@/bin/wine', ['@wineForWechat@/bin/wine', 'WeChat.exe'] + args.args, env)
