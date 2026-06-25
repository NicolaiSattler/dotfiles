---
description: review git feature
---
# Code Review: Feature Branch vs Main

Review all changes between the current branch and `main` (or `master`) branch.

## Analysis Checklist

**Security & Quality:**
- Security vulnerabilities (SQL injection, XSS, unsafe dependencies)
- Logic errors and edge cases
- Newly added dependencies with known weaknesses

**Testing & Coverage:**
- Unit tests status and pass/fail
- Test coverage metrics (target: ≥80%)
- Missing test cases

**Documentation & Style:**
- API documentation is present (Javadoc/JSDoc/Markdown/XML in C#)
- Formatting is consistent (no unnecessary blank lines, proper indentation)
- Code comments are clear and helpful

**Commits:**
- Commit messages are clear and descriptive

## Output Format

Organize findings by category with severity levels (Critical, Warning, Info). Highlight actionable recommendations.
