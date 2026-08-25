# Feasterville Live POS

Ready for GitHub Pages.

## Files
- index.html — Feasterville Live POS frontend
- CNAME — custom domain: pos.feasterville.co.za

## Recommended repository
feasterville-pos

## GitHub Pages
1. Open repository Settings.
2. Open Pages.
3. Select Deploy from a branch.
4. Branch: main.
5. Folder: / (root).
6. Set custom domain to pos.feasterville.co.za.
7. Enable HTTPS after DNS verification.

## GoDaddy DNS
Create:
- Type: CNAME
- Name: pos
- Value: <your-github-username>.github.io
- TTL: Default / 1 hour

The POS frontend connects to the existing Supabase backend.
