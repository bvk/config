import keyring
import sys

def get_password(hostname, username):
  rv = keyring.get_password(hostname, username)
  if rv is None:
    # As the user for password and save it in the keyring for the future.
    sys.stderr.write("keyring password incorrect or not found\n")
    return ""
  return rv

def set_password(hostname, username, password):
  return keyring.set_password(hostname, username, password)

if __name__ == "__main__":
  if len(sys.argv) == 4:
    set_password(sys.argv[1], sys.argv[2], sys.argv[3])
    sys.exit(0)
  else:
    sys.stderr.write("usage: %s hostname username password" % sys.argv[0])
    sys.exit(1)
