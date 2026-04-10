# Innovizta ERP - Project Context & Session Tracker

> **Created:** April 9, 2026  
> **Status:** Phase 1 - Base Infrastructure ✅ COMPLETE  
> **Stack:** Next.js 15 + Supabase + Vercel (Free Tier)  
> **Template:** `npx create-next-app@latest . -e with-supabase` (official)

---

## Project Overview

**Business:** Educational services company that executes projects for students  
**Purpose:** Internal project management + client portal system  

### Users & Roles (Tentative - awaiting MD files)
| Role | Access Level | Count |
|------|-------------|-------|
| Partners | Full admin access | 3 (may change) |
| Workers | Task execution, progress tracking | ~10 |
| Clients | Request resources/materials via portal | ~100 |

### Core Features (To Be Refined via MD Files)
1. Employee management & progress tracking
2. Client portal for resource/material requests
3. Request fulfillment workflow (client → worker → fulfill)
4. Partner dashboard with full access
5. File sharing via Google Drive (external)

---

## Tech Stack Decisions

| Layer | Choice | Reason |
|-------|--------|--------|
| Frontend | Next.js 15 (App Router) | Official template, Vercel-native |
| Auth | Supabase Auth (cookie-based) | Built-in, RLS integration, free tier |
| Database | Supabase (PostgreSQL) | Row Level Security, free tier (500MB) |
| Hosting | Vercel (Free) | Zero-config Next.js deployment |
| UI | shadcn/ui + Tailwind CSS | Copy-paste components, minimal custom code |
| File Storage | Google Drive (external) | Not using Supabase Storage |
| ORM | Supabase JS Client (direct) | Minimal abstraction, template-aligned |

---

## Templates & Tools Used (No Custom Code Policy)

| Tool/Template | Source | Purpose |
|---------------|--------|---------|
| **Next.js + Supabase** | `npx create-next-app@latest . -e with-supabase` | Base project scaffold |
| **shadcn/ui** | Pre-configured in template | Pre-built UI components |
| **Supabase SSR** | `@supabase/ssr` | Cookie-based auth with SSR |
| **Vercel CLI** | `vercel` CLI (to be installed) | Deployment automation |
| **Supabase CLI** | `supabase` CLI (to be installed) | Local DB, migrations |
| **GitHub Actions** | `.github/workflows/ci.yml` | CI/CD pipeline |

---

## Project Structure

```
innovizta_erp/
├── app/                          # Next.js App Router (from official template)
│   ├── auth/                     # Auth pages (login, signup, forgot-password, etc.)
│   ├── protected/                # Protected dashboard (role-based redirects)
│   ├── layout.tsx                # Root layout
│   ├── page.tsx                  # Landing page
│   └── globals.css               # Global styles + shadcn tokens
├── components/
│   ├── ui/                       # shadcn/ui components (button, card, input, etc.)
│   ├── env-var-warning.tsx       # Template component - remove later
│   ├── logout-button.tsx         # Auth component
│   └── tutorial/                 # Tutorial components - remove later
├── lib/
│   ├── supabase/
│   │   ├── client.ts             # Browser Supabase client
│   │   ├── server.ts             # Server Supabase client
│   │   └── proxy.ts              # Auth proxy/session management
│   └── utils.ts                  # cn() utility for Tailwind classes
├── business-logic/               # 📋 MD files from team (PENDING)
│   ├── README.md                 # Instructions for team
│   └── _template.md              # Blank template for business specs
├── supabase/
│   └── migrations/
│       └── 001_initial_schema.sql # Base schema with RLS + profiles table
├── docs/                         # Architecture & setup docs
├── .github/
│   └── workflows/
│       └── ci.yml                # GitHub Actions CI/CD
├── .env.example                  # Environment variables template
├── vercel.json                   # Vercel deployment config
├── proxy.ts                      # Next.js proxy for Supabase auth
├── components.json               # shadcn/ui config
├── tailwind.config.ts            # Tailwind with shadcn theme
├── tsconfig.json                 # TypeScript config
├── next.config.ts                # Next.js config
├── SESSION.md                    # ← You are here
└── README.md                     # Official template readme
```

---

## Environment Variables (Required)

```bash
# .env.local (do not commit)
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY=your-anon-key
```

To get these:
1. Go to https://supabase.com/dashboard
2. Create a new project (free tier)
3. Go to Project Settings → API
4. Copy `Project URL` and `anon public` key

---

## Development Workflow

### Local Development
```bash
npm run dev          # Start dev server (localhost:3000)
npm run build        # Production build
npm run lint         # ESLint check
```

### Supabase Migrations
```bash
# Install Supabase CLI
npm install -g supabase

# Link to your Supabase project
supabase link --project-ref your-project-ref

# Push migrations
supabase db push

# Create new migration
supabase migration new add_new_table
```

### Business Logic Implementation
1. **Team provides MD files** → drop in `/business-logic/`
2. **Read MD files** → understand tables, relations, workflows
3. **Create Supabase migrations** → `supabase db push`
4. **Build UI pages** → using shadcn/ui + Supabase queries
5. **Deploy** → `vercel --prod`

---

## Deployment to Vercel (Free Tier)

### Option A: One-Click Deploy (Recommended)
1. Push code to GitHub
2. Go to https://vercel.com/new
3. Import your GitHub repo
4. Add environment variables:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY`
5. Click Deploy

### Option B: Vercel CLI
```bash
npm i -g vercel
vercel                    # Preview deployment
vercel --prod             # Production deployment
```

---

## Current Progress

### ✅ Completed
- [x] Session context file (SESSION.md)
- [x] Next.js project scaffolded (official Supabase template)
- [x] Supabase Auth pages (login, signup, forgot-password, update-password)
- [x] Protected route with auth guard
- [x] shadcn/ui components (button, card, input, label, checkbox, dropdown-menu)
- [x] Proxy/middleware for session management
- [x] Business-logic folder with MD template
- [x] Supabase migration template (001_initial_schema.sql)
- [x] Vercel deployment config (vercel.json)
- [x] GitHub Actions CI/CD (.github/workflows/ci.yml)
- [x] Build verification (✅ passes)

### 🔄 In Progress
- [ ] Supabase project creation (user needs to create on supabase.com)
- [ ] Environment variables setup

### ⏳ Pending (Awaiting Business Logic MD Files)
- [ ] Database tables (projects, resource_requests, etc.)
- [ ] Role-based dashboard pages
- [ ] Request fulfillment workflow
- [ ] Progress tracking UI
- [ ] Partner admin dashboard
- [ ] Client portal pages
- [ ] Notification system

---

## Business Logic MD Files Status

| File | Status | Notes |
|------|--------|-------|
| `_template.md` | ✅ Created | Ready for team to use |
| `user-roles.md` | ⏳ Pending | Awaiting from team |
| `database-schema.md` | ⏳ Pending | Awaiting from team |
| `workflows.md` | ⏳ Pending | Awaiting from team |
| `resource-requests.md` | ⏳ Pending | Awaiting from team |
| `projects.md` | ⏳ Pending | Awaiting from team |

---

## Next Steps (When Resuming)

1. **Create Supabase project** at https://supabase.com/dashboard (free tier)
2. **Get API keys** → create `.env.local` with Supabase URL + anon key
3. **Test auth** → `npm run dev` → try login/signup
4. **Push initial migration** → `supabase link` → `supabase db push`
5. **Deploy to Vercel** → connect GitHub → deploy
6. **Wait for MD files** → team drops business logic in `/business-logic/`
7. **Implement features** → read MD files → build tables + UI

---

## Notes & Decisions

- **Free tier constraints:** Supabase (500MB DB, 50K MAU), Vercel (100GB bandwidth, serverless function limits)
- **No custom code policy:** Only use proven templates, starters, and official tools
- **AI-led development:** All code generation via AI with template-first approach
- **External file sharing:** Google Drive, not Supabase Storage
- **Role count may exceed 3:** Exact roles TBD from MD files
- **Template used:** `with-supabase` example from Next.js official repo (cleanest, most proven)
