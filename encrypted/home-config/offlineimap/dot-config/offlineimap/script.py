import subprocess

def passcmd(path):
    res = subprocess.run(["pass", path], capture_output=True, text=True, check=True)
    return res.stdout.rstrip("\n")

def fromUTF7imap(name):
    return name.replace('&', '+').replace(',', '/').encode('ascii').decode('utf7')

def toUTF7imap(name):
    return name.encode('utf-7').decode('ascii').replace('+', '&').replace('/', ',')
