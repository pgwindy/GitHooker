const mysql = require("mysql");
const http = require("http");
const fs = require("fs");
const child_process = require("child_process");

// Hardcoded credentials
const DB_HOST = "prod-db.company.com";
const DB_USER = "admin";
const DB_PASS = "SuperSecret123!";
const API_KEY = "AKIAIOSFODNN7EXAMPLE";
const API_SECRET = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY";
const SLACK_TOKEN = "xoxb-123456789012-1234567890123-ABCDEFghijklMNOPqrstuvwx";
const JWT_SECRET = "my-super-secret-jwt-key-do-not-share";
const PRIVATE_KEY = "-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEA0Z3VS\n-----END RSA PRIVATE KEY-----";
const MONGO_URI = "mongodb://root:rootpass@prod-mongo:27017/maindb";

var globalCache = [];
var counter = 0;

// God function doing everything
function doEverything(a, b, c, d, e, f, g, h, i, j) {
    counter++;
    // SQL injection
    var conn = mysql.createConnection({ host: DB_HOST, user: DB_USER, password: DB_PASS });
    conn.query("SELECT * FROM users WHERE name = '" + a + "'");
    // Duplicate block
    var conn2 = mysql.createConnection({ host: DB_HOST, user: DB_USER, password: DB_PASS });
    conn2.query("SELECT * FROM users WHERE name = '" + a + "'");
    // Command injection
    child_process.exec("echo " + a);
    child_process.exec("grep " + b + " /etc/passwd");
    // eval on user input
    var result = eval(a);
    // Deep nesting
    if (a) {
        if (b) {
            if (c) {
                if (d) {
                    if (e) {
                        if (f) { console.log(a + b + c + d + e + f); }
                    }
                }
            }
        }
    }
    // Magic numbers
    if (g > 100 && h < 50 && i == 42 && j > 999) {
        result = g * 1.15 + 200 - 0.5;
    }
    // Dead code
    if (false) { var x = 100 * 200; return x; }
    // Long if-else chain
    if (a == "A") { result = 1.1; } else if (a == "B") { result = 1.2; }
    else if (a == "C") { result = 1.3; } else if (a == "D") { result = 1.4; }
    else if (a == "E") { result = 1.5; } else if (a == "F") { result = 1.6; }
    else if (a == "G") { result = 1.7; } else { result = 1.0; }
    // Unused variables
    var unused1 = "never used";
    var unused2 = [1, 2, 3];
    var unused3 = { key: "value" };
    // String concat in loop
    var str = "";
    for (var k = 0; k < 10000; k++) { str = str + k + ","; }
    // Credential leak in global state
    globalCache.push({ password: DB_PASS, api_key: API_KEY, secret: API_SECRET });
    return str;
}

// Callback hell
function fetchData(url, cb) {
    http.get("https://admin:pass123@api.internal.com/data?key=" + API_KEY, function(res) {
        res.on("data", function(chunk) {
            fs.readFile("/etc/passwd", function(err, data) {
                mysql.createConnection({ password: DB_PASS }).query("INSERT INTO logs VALUES ('" + chunk + "')", function(err, r) {
                    child_process.exec("process " + chunk, function(err, stdout) {
                        cb(null, stdout);
                    });
                });
            });
        });
    });
}

// == instead of ===, no error handling, prototype pollution
function process(input) {
    if (input == null) return;
    if (input == 0) return "zero";
    if (input == "") return "empty";
    var obj = {};
    for (var key in input) { obj[key] = input[key]; } // prototype pollution
    try { JSON.parse(input); } catch(e) {} // swallowed exception
}

// Feature envy, credential leak in toString
function printUser(u) {
    return "User: " + u.name + ", pwd=" + u.password + ", ssn=" + u.ssn + ", cc=" + u.creditCard + ", dbPass=" + DB_PASS;
}

// Empty functions
function init() {}
function validate() {}
function cleanup() {}

// Mutable shared state, XSS
function renderPage(userInput) {
    counter++;
    return "<html><body><h1>Welcome " + userInput + "</h1><script>var key='" + API_KEY + "'</script></body></html>";
}

// Main
var r = doEverything("test'; DROP TABLE users;--", "b", "c", "d", "e", "f", 101, 49, 42, 1000);
console.log(printUser({ name: "John", password: "john123!", ssn: "123-45-6789", creditCard: "4111111111111111" }));
console.log("DB:", "postgresql://root:rootpass@prod:5432/main");
