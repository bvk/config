#!/usr/bin/python
import os
import sys
import subprocess
import traceback

def get_password(hostname, username):
  try:
    authinfo = os.path.join(os.environ["HOME"], ".authinfo.gpg")
    if not os.path.isfile(authinfo):
      sys.stderr.write("no authinfo file, %s\n" % authinfo)
      return ""

    args = ["gpg", "--no-tty", "--use-agent", "-d", authinfo]
    content = subprocess.check_output(args).strip()
    for line in content.split("\n"):
      fields = line.split()
      if fields[1] == hostname and fields[3] == username:
        return fields[-1]
    sys.stderr.write("no authinfo entry for %s@%s\n" % (username, hostname))
    return ""
  except Exception as ex:
    sys.stderr.write("%s\n" % traceback.format_exc())
    return ""
