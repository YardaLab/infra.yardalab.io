# Contributing to infra.yardalab.io

Thank you for contributing to **infra.yardalab.io**!
This document defines how to work with branches, commits, and pull requests to ensure consistency across all YardaLab infrastructure repositories.

---

## 1. Repository setup

Before contributing, make sure you have:

* **Git** and **Node.js** installed
* **Husky** initialized for pre-commit hooks (run `npm install` then `npm run prepare`)
* Permissions to push to YardaLab repositories (organization-level access)

---

## 2. Branch naming convention

Each issue or task from Jira must have its own branch, following this format:

```
feature/IYI-<issue-number>-<short-description>
```

Other allowed prefixes:

| Prefix      | Purpose                                   |
| ----------- | ----------------------------------------- |
| `feature/`  | New functionality or configuration        |
| `fix/`      | Bug fixes                                 |
| `chore/`    | Maintenance and tooling changes           |
| `docs/`     | Documentation changes                     |
| `refactor/` | Internal refactors without feature impact |

**Examples:**

```
feature/IYI-2-create-github-repository
fix/IYI-11-fix-prebuild-configuration
```

---

## 3. Commit message format

All commit messages must follow the **Conventional Commits** standard with an added Jira issue key:

```
<JIRA_KEY>: <type>(<scope>): <message>
```

**Examples:**

```
IYI-5: docs(repo): add README with basic project description and goals
IYI-6: chore(repo): add .gitignore for Terraform and environment files
IYI-10: feat(infra): add initial Terraform configuration
```

### Allowed commit types

* `feat` – new feature or functionality
* `fix` – bug fix
* `docs` – documentation updates
* `chore` – maintenance, dependencies, config
* `refactor` – code restructuring without behavior change
* `ci` – CI/CD changes (GitHub Actions, prebuilds)
* `test` – adding or updating tests
* `hotfix` – urgent fixes requiring immediate deployment

---

## 4. Husky pre-commit hooks

Husky runs basic checks before every commit:

* Validates commit message format using **commitlint**
* (Optional) Runs `lint` or `format` checks if defined in `package.json`

To install hooks locally:

```bash
npm install
npm run prepare
```

To test commit message validation manually:

```bash
npx commitlint --edit .git/COMMIT_EDITMSG
```

---

## 5. Pull Request workflow

1. Push your feature branch:

   ```bash
   git push --set-upstream origin feature/IYI-<issue-number>-<short-description>
   ```
2. Open a **Pull Request** targeting `main`
3. Assign at least one reviewer
4. Wait for all GitHub Actions checks to pass
5. Merge using **Squash and merge** (to keep history clean)

PR titles must also follow the commit format:

```
IYI-5: docs(repo): add README with basic project description and goals
```

---

## 6. Branch protection

The `main` branch is protected and cannot be pushed to directly.
All changes must come through reviewed Pull Requests.

---

## 7. License

All contributions are made under the **Apache License 2.0**.
See [`LICENSE`](./LICENSE) for more details.

---

Maintainer: **Jaroslav Miczka (YardaLab s.r.o.)**
