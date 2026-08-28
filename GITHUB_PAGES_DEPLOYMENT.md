# Production deployment target

Canonical app URL:

https://fieldguides.omarcrook.com

## Repository contract

- repository: `personal-field-guides` (recommended name)
- production branch: `main`
- deployment: GitHub Pages via `.github/workflows/deploy-pages.yml`
- custom domain: `fieldguides.omarcrook.com`
- backend: existing Supabase project
- PWA install target: iPadOS Safari / desktop browsers

## DNS target

After GitHub Pages is enabled for the repository, point:

`fieldguides.omarcrook.com`

to the GitHub Pages hostname shown by GitHub for the repository. Keep the checked-in `CNAME` file unchanged.

## Supabase Auth

Once the public HTTPS URL resolves, add both of these to the Supabase Auth redirect allowlist:

- `https://fieldguides.omarcrook.com`
- `https://fieldguides.omarcrook.com/`

Then test magic-link sign-in from iPad and desktop.

## Acceptance test

1. Open `https://fieldguides.omarcrook.com`.
2. Install with Safari → Share → Add to Home Screen.
3. Launch standalone.
4. Sign in.
5. Create a Personal field session with typed notes and Apple Pencil ink.
6. Mark a specimen Owned.
7. Add a page annotation.
8. Open the site on laptop under the same login.
9. Sync and verify all three records appear.
10. Switch to Will and confirm the Personal records are not shown.
