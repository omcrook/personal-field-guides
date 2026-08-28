# Deployment — V1.1 PWA

This package is ready for static HTTPS deployment.

## Vercel
Deploy the folder root as a static project. No build command is required.

Required production follow-up after the public URL exists:
1. Add the deployed URL to the Supabase Auth allowed redirect URLs.
2. Confirm magic-link sign-in on both iPad Safari and desktop.
3. Add to Home Screen on iPad and confirm standalone launch.
4. Confirm Apple Pencil field notes and page annotations save locally and sync after authentication.

## PWA
Included:
- `manifest.webmanifest`
- `service-worker.js`
- Apple mobile web app meta tags
- installable app icons
- same-origin offline cache for the book shell and locked assets

The service worker intentionally does not cache Supabase/API/auth requests.
