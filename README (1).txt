GLOBAL OPPORTUNITIES WEBSITE - SETUP NOTES

Files
- index.html: public website homepage
- admin.html: admin login and manpower demand management page
- config.js.example: Supabase browser configuration template
- supabase/schema.sql: database tables and row-level security policies

IMPORTANT CONFIGURATION
1. Make a copy of config.js.example.
2. Rename the copy to config.js (exactly config.js, not config.js.txt).
3. Open config.js in a text editor.
4. Replace PASTE_YOUR_SUPABASE_PROJECT_URL_HERE with your Supabase Project URL.
5. Replace PASTE_YOUR_SUPABASE_PUBLISHABLE_KEY_HERE with your Supabase Publishable Key.
6. Save the file in the same folder as index.html and admin.html.

SECURITY
- Use only the Supabase Publishable Key in config.js.
- NEVER use a Supabase secret key or service_role key in browser code or upload it to GitHub.
- Keep your Supabase account password private.
- The admin user must be explicitly added to public.admin_users for admin permissions.

DATABASE
- supabase/schema.sql contains the database setup SQL.
- Run it in the Supabase SQL Editor for the project.

PAGES
- Public page: index.html
- Admin page: admin.html

NOTE
This is a starter website project. It still needs Supabase configuration and deployment before it is a live public website.
