# Branching Strategy

This document describes the branching strategy for this repository. It ensures consistency, collaboration, and clean release management.

---

## 1. Branch Types

We use the following branch types:

* **`main`**

  * Always stable and production-ready.
  * Contains only tested, reviewed, and approved code.
  * Every commit to `main` should be deployable.

* **`develop`** *(optional, if project requires)*

  * Integration branch for upcoming release features.
  * All completed features and fixes are merged here before release.

* **Feature Branches** (`feature/<short-description>`)

  * Used for developing new features.
  * Branch from `develop` (or `main` if not using `develop`).
  * Merged back via Pull Request.

* **Bugfix Branches** (`bugfix/<short-description>`)

  * Used to address non-critical issues found during development.
  * Branch from `develop`.
  * Merged back into `develop`.

* **Release Branches** (`release/<version>`)

  * Created when preparing for a release.
  * Used for final testing, minor bug fixes, and documentation.
  * Merged into both `main` and `develop`.

* **Hotfix Branches** (`hotfix/<short-description>`)

  * Used for urgent fixes in production.
  * Branch from `main`.
  * Merged into both `main` and `develop`.

---

## 2. Workflow

1. **Start Work**

   * Create a feature/bugfix branch from `develop`.
   * Use descriptive branch names (e.g., `feature/user-authentication`).

2. **Commit Guidelines**

   * Use meaningful commit messages.
   * Follow conventional commit style if possible (`feat:`, `fix:`, `docs:`, `chore:`).

3. **Pull Requests**

   * All merges to `develop` and `main` must go through a Pull Request (PR).
   * PRs require at least one reviewer approval.
   * Ensure CI/CD checks pass before merging.

4. **Release Process**

   * Create a `release/<version>` branch when ready.
   * Perform final testing and documentation updates.
   * Merge into `main` and tag the release.
   * Merge into `develop` to sync changes.

5. **Hotfix Process**

   * Branch from `main`.
   * Apply the urgent fix.
   * Merge into both `main` (for deployment) and `develop` (to preserve changes).

---

## 3. Example Branch Flow

```bash
# Start a new feature
git checkout develop
git pull origin develop
git checkout -b feature/login-ui

# Complete work, push and create PR
git push origin feature/login-ui
```

---

## 4. Summary

* `main` → always production-ready
* `develop` → integration branch (if used)
* `feature/*` → new features
* `bugfix/*` → non-critical fixes
* `release/*` → prepping for releases
* `hotfix/*` → urgent production fixes

---
