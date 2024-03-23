import subprocess

def passcmd(path):
    res = subprocess.run(["pass", path], capture_output=True, text=True, check=True)
    return res.stdout.rstrip("\n")

def utf7imap(name):
    return name.replace('&', '+').replace(',', '/').encode('ascii').decode('utf7')
