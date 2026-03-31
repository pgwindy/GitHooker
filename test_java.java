import java.util.*;
import java.io.*;
import java.sql.*;

public class test_java {

    // Hardcoded credentials (security violation)
    private static final String DB_URL = "jdbc:mysql://prod-db.company.com:3306/users";
    private static final String DB_USERNAME = "admin";
    private static final String DB_PASSWORD = "SuperSecret123!";
    private static final String API_KEY = "AKIAIOSFODNN7EXAMPLE";
    private static final String API_SECRET = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY";
    private static final String SLACK_TOKEN = "xoxb-123456789012-1234567890123-ABCDEFghijklMNOPqrstuvwx";
    private static final String PRIVATE_KEY = "-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEA0Z3VS5JJcds3xfn/ygWyF8PbnGcY5unA67hqxnfZKIkMSE\n-----END RSA PRIVATE KEY-----";

    // God class: doing everything in one class
    // Magic numbers everywhere
    // No encapsulation

    public String name;
    public int age;
    public String email;
    public double salary;
    public String password;

    // Long method with too many responsibilities
    public void doEverything(String a, String b, String c, String d, String e, String f, int g, int h, int i, int j) {
        // Magic numbers
        if (g > 100) {
            System.out.println("big");
        }
        if (h < 50) {
            System.out.println("small");
        }
        if (i == 42) {
            System.out.println("answer");
        }
        if (j > 999) {
            System.out.println("huge");
        }

        // Duplicate code block 1
        try {
            Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE name = '" + a + "'"); // SQL injection
            while (rs.next()) {
                System.out.println(rs.getString("name"));
                System.out.println(rs.getString("email"));
                System.out.println(rs.getInt("age"));
            }
        } catch (Exception ex) {
            // Empty catch block (swallowed exception)
        }

        // Duplicate code block 2 (copy-pasted)
        try {
            Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE name = '" + b + "'"); // SQL injection again
            while (rs.next()) {
                System.out.println(rs.getString("name"));
                System.out.println(rs.getString("email"));
                System.out.println(rs.getInt("age"));
            }
        } catch (Exception ex) {
            // Empty catch block again
        }

        // Dead code
        if (false) {
            System.out.println("This will never execute");
            int x = 100 * 200 + 300;
        }

        // Deeply nested conditionals
        if (a != null) {
            if (b != null) {
                if (c != null) {
                    if (d != null) {
                        if (e != null) {
                            if (f != null) {
                                System.out.println(a + b + c + d + e + f);
                            }
                        }
                    }
                }
            }
        }

        // Long chain of if-else instead of switch or polymorphism
        String type = a;
        if (type.equals("A")) {
            System.out.println("Type A");
            salary = salary * 1.1;
        } else if (type.equals("B")) {
            System.out.println("Type B");
            salary = salary * 1.2;
        } else if (type.equals("C")) {
            System.out.println("Type C");
            salary = salary * 1.3;
        } else if (type.equals("D")) {
            System.out.println("Type D");
            salary = salary * 1.4;
        } else if (type.equals("E")) {
            System.out.println("Type E");
            salary = salary * 1.5;
        } else if (type.equals("F")) {
            System.out.println("Type F");
            salary = salary * 1.6;
        } else if (type.equals("G")) {
            System.out.println("Type G");
            salary = salary * 1.7;
        } else {
            System.out.println("Unknown");
        }

        // Unused variables
        int unusedVar1 = 100;
        String unusedVar2 = "never used";
        List<String> unusedList = new ArrayList<>();
        Map<String, Integer> unusedMap = new HashMap<>();
    }

    // Method with boolean flag parameter (control coupling)
    public double calculate(double amount, boolean isSpecial, boolean isVIP, boolean hasDiscount) {
        double result = 0;
        if (isSpecial) {
            result = amount * 0.9;
        }
        if (isVIP) {
            result = result * 0.85;
        }
        if (hasDiscount) {
            result = result - 10.0;
        }
        // Returning different things based on flags = code smell
        return result;
    }

    // Feature envy: method uses another object's data more than its own
    public void printOrderDetails(HashMap<String, Object> order) {
        System.out.println("Order ID: " + order.get("id"));
        System.out.println("Order Date: " + order.get("date"));
        System.out.println("Order Total: " + order.get("total"));
        System.out.println("Order Customer: " + order.get("customer"));
        System.out.println("Order Address: " + order.get("address"));
        System.out.println("Order Status: " + order.get("status"));
        System.out.println("Order Shipping: " + order.get("shipping"));
    }

    // Inappropriate use of public static mutable state (global state)
    public static List<String> globalCache = new ArrayList<>();
    public static Map<String, String> globalConfig = new HashMap<>();
    public static int counter = 0;

    // Method that does too many things and has side effects
    public String processData(String rawData) {
        counter++;
        globalCache.add(rawData);

        // String concatenation in loop (performance smell)
        String result = "";
        for (int i = 0; i < 10000; i++) {
            result = result + rawData + i + ",";
        }

        // Storing password in plain text
        String userPassword = "plaintext_password_123";
        globalConfig.put("admin_password", userPassword);
        globalConfig.put("aws_secret", "AKIAIOSFODNN7EXAMPLE");
        globalConfig.put("jwt_secret", "my-super-secret-jwt-key-do-not-share");

        // Commented out code left in
        // Connection conn = DriverManager.getConnection("jdbc:mysql://old-server:3306/db", "root", "root123");
        // stmt.execute("DROP TABLE users");
        // System.out.println("DEBUG: " + userPassword);

        return result;
    }

    // Overly complex method with high cyclomatic complexity
    public int complexMethod(int a, int b, int c, int d) {
        int result = 0;
        if (a > 0) { if (b > 0) { result = a + b; } else if (b < -10) { result = a - b; } else { result = a * 2; } }
        else if (a < 0) { if (c > 0) { result = c + a; } else if (c < -5) { result = c - a; } else { result = c * 3; } }
        else { if (d > 0) { result = d; } else if (d < -20) { result = -d; } else { result = 0; } }
        if (result > 100) { result = 100; } else if (result < -100) { result = -100; }
        if (result == 0 && a != 0) { result = 1; }
        if (result == 42) { result = result + 1; } // magic number avoidance... poorly
        return result;
    }

    // Empty methods (lazy class / speculative generality)
    public void init() {}
    public void cleanup() {}
    public void validate() {}
    public void transform() {}

    // toString with credentials leak
    @Override
    public String toString() {
        return "test_java{name=" + name + ", password=" + password +
               ", salary=" + salary + ", dbPassword=" + DB_PASSWORD + "}";
    }

    // Main method doing too much
    public static void main(String[] args) {
        test_java obj = new test_java();
        obj.name = "John";
        obj.password = "john123!";
        obj.salary = 50000;

        obj.doEverything("A", "B", "C", "D", "E", "F", 101, 49, 42, 1000);
        obj.processData("test");
        System.out.println(obj.toString());

        // Hardcoded connection string in main
        String connectionString = "mongodb://admin:password123@prod-mongo.internal:27017/maindb";
        System.out.println("Connecting to: " + connectionString);
    }
}
