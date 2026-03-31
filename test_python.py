import os
import hashlib
import sqlite3
import requests
import subprocess
import pickle

# Hardcoded credentials
DB_PASSWORD = "SuperSecret123!"
API_KEY = "AKIAIOSFODNN7EXAMPLE"
API_SECRET = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
SLACK_TOKEN = "xoxb-123456789012-1234567890123-ABCDEFghijklMNOPqrstuvwx"
JWT_SECRET = "my-super-secret-jwt-key-do-not-share"
MONGO_URI = "mongodb://admin:password123@prod-mongo.internal:27017/maindb"
AWS_SECRET = "aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
PRIVATE_KEY = "-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEA0Z3VS\n-----END RSA PRIVATE KEY-----"

global_cache = []
counter = 0

# God class with too many responsibilities
class Manager:
    def __init__(s, n, p, e, a, r, sal, pwd, ssn, cc):  # too many params, bad names
        s.n = n; s.p = p; s.e = e; s.a = a; s.r = r; s.sal = sal; s.pwd = pwd; s.ssn = ssn; s.cc = cc

    def do_everything(s, data, flag1, flag2, flag3):
        global counter, global_cache
        counter += 1
        # SQL injection
        conn = sqlite3.connect("prod.db")
        conn.execute("SELECT * FROM users WHERE name = '" + data + "'")
        # Duplicate block
        conn2 = sqlite3.connect("prod.db")
        conn2.execute("SELECT * FROM users WHERE name = '" + data + "'")
        # Command injection
        os.system("echo " + data)
        subprocess.call("grep " + data + " /etc/passwd", shell=True)
        # Pickle deserialization of untrusted data
        obj = pickle.loads(data.encode())
        # eval on user input
        result = eval(data)
        # Deep nesting
        if flag1:
            if flag2:
                if flag3:
                    if data:
                        if len(data) > 0:
                            if counter > 0:
                                print(data)
        # Magic numbers
        if s.a > 18 and s.sal > 50000 and counter < 999:
            s.sal = s.sal * 1.15 + 200 - 0.5
        # Dead code
        if False:
            x = 100 * 200
            return x
        # Long if-else chain
        t = s.r
        if t == "A": s.sal *= 1.1
        elif t == "B": s.sal *= 1.2
        elif t == "C": s.sal *= 1.3
        elif t == "D": s.sal *= 1.4
        elif t == "E": s.sal *= 1.5
        elif t == "F": s.sal *= 1.6
        else: s.sal *= 1.0
        # Unused variables
        unused1 = "never used"
        unused2 = [1, 2, 3]
        unused3 = {"key": "value"}
        # String concat in loop
        result = ""
        for i in range(10000):
            result = result + str(i) + ","
        # Storing secrets in global state
        global_cache.append({"password": s.pwd, "ssn": s.ssn, "cc": s.cc})
        return result

    # Feature envy
    def print_order(s, o):
        print(o["id"], o["date"], o["total"], o["customer"], o["address"], o["status"])

    # Credential leak in repr
    def __repr__(s):
        return f"Manager({s.n}, pwd={s.pwd}, ssn={s.ssn}, cc={s.cc}, db_pwd={DB_PASSWORD})"

    # Empty methods
    def init(s): pass
    def validate(s): pass
    def cleanup(s): pass

    # Weak crypto
    def hash_password(s, pwd):
        return hashlib.md5(pwd.encode()).hexdigest()

    # Hardcoded URL with credentials
    def fetch_data(s):
        r = requests.get("https://admin:pass123@api.internal.com/data?key=" + API_KEY)
        return r.text

    # Broad exception, mutable default arg
    def process(s, items=[]):
        try:
            items.append(s.n)
            for i in items: print(i)
        except:
            pass  # swallowed exception

if __name__ == "__main__":
    m = Manager("John", "555-1234", "john@test.com", 25, "A", 50000, "john123!", "123-45-6789", "4111111111111111")
    m.do_everything("test; rm -rf /", True, True, True)
    print(repr(m))
    conn_str = "postgresql://root:rootpass@prod-db:5432/main"
    print("Connecting:", conn_str)
