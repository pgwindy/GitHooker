# GitHooker

Pre-commit git hooks to catch code smells, credential leaks, and formatting issues before they reach your repository.

## Hooks Included

| Hook | What it catches |
|------|----------------|
| **trailing-whitespace** | Trailing whitespace in files |
| **end-of-file-fixer** | Missing newline at end of file |
| **check-merge-conflict** | Leftover merge conflict markers |
| **detect-private-key** | RSA/SSH private keys |
| **check-added-large-files** | Accidentally committed large files |
| **gitleaks** | Hardcoded credentials, API keys, tokens |
| **ruff** | Python code smells (auto-fix enabled) |
| **eslint** | JavaScript/TypeScript code smells |
| **terraform_fmt** | Terraform formatting (auto-fix enabled) |
| **terraform_tflint** | Terraform best practices and errors |
| **checkstyle** | Java code style (Google checks) |

## Quick Setup

Run the one-liner inside your project's git repository to install all hooks.

### macOS

**Prerequisites:** [Homebrew](https://brew.sh)

```bash
curl -fsSL https://github.com/pgwindy/GitHooker/test_git_hooks/setup-hooks.sh | bash
```

**What it installs via Homebrew:** `pre-commit`, `gitleaks`, `tflint`, `node`, `checkstyle`

### Windows

**Prerequisites:** Python/pip, Node.js, Go, Java

If any are missing, install them via [Chocolatey](https://chocolatey.org/install) (requires admin):

```powershell
choco install python nodejs golang ojdkbuild17 -y
```

Then run the setup script (no admin required):

```powershell
iwr -useb https://github.com/pgwindy/GitHooker/test_git_hooks/setup-hooks.ps1 | iex
```

Or if downloaded locally:

```powershell
powershell -ExecutionPolicy Bypass -File .\setup-hooks.ps1
```

**What it installs:**
- Via pip: `pre-commit`
- Via go install: `gitleaks`, `tflint`
- Via Maven Central: `checkstyle` (standalone jar)

## Usage

After setup, hooks run automatically on every `git commit`. To run manually:

```bash
# Run all hooks against all files
pre-commit run --all-files

# Run a specific hook
pre-commit run gitleaks --all-files

# Update hook versions
pre-commit autoupdate
```

## Files Added to Your Project

The setup script downloads these files into your project root:

- `.pre-commit-config.yaml` - Hook configuration
- `.eslintrc.json` - ESLint rules for JavaScript

These should be committed to your repo so all team members share the same hooks.

## Test Files

The repository includes test files with intentional code smells and credential leaks for verifying hooks work correctly:

- `test_python.py` - Python: hardcoded secrets, SQL injection, eval, unused vars
- `test_javascript.js` - JavaScript: eval, loose equality, XSS, callback hell
- `test_java.java` - Java: SQL injection, duplicate code, empty catch blocks
- `test_tf.tf` - Terraform: public S3 buckets, overly permissive security groups, hardcoded secrets
