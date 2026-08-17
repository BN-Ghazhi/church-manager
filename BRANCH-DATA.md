# How HQ sees other branches' data

Short answer: **it depends on whether the branches share one database.** Right
now they don't, and that changes everything about this question.

---

## What works today

Each install has **its own database file**. Nothing travels between machines.

```
HQ laptop            Ikeja laptop         Lekki laptop
┌──────────┐         ┌──────────┐         ┌──────────┐
│ .sqlite  │         │ .sqlite  │         │ .sqlite  │
└──────────┘         └──────────┘         └──────────┘
     ✗ no connection between them ✗
```

So if the Ikeja pastor adds 20 members on their own laptop, **HQ will never see
them** — not because of permissions, but because the records are in a different
file on a different machine.

The branch model, the switcher and the permission system are all real and
working. They let one database hold many branches and control who sees what.
What is missing is a way to get several machines' data into one place.

---

## The three ways to make HQ see everything

### Option 1 — One machine, everyone works on it

The simplest, and viable for a single church office. One computer holds the
database; branch staff record their data on it, either in person or over remote
desktop. HQ signs in as Super Admin, switches to "All branches", and sees the
lot immediately.

**Works now, no development needed.** The branch switcher and consolidated
dashboard already do exactly this.

Limits: one machine, one person at a time, and it must be running for anyone to
work.

### Option 2 — Export and import (a "branch return")

Each branch exports its data periodically; HQ imports the files. This is how a
lot of church software worked before everything went online, and it survives
bad connectivity.

**Export exists today** (Reports → Export data, or Members → Export CSV, both
scoped to what the user may see). **Import does not** — it needs building:

- an import screen that accepts the CSV a branch sends
- matching on a stable id so the same person is not imported twice
- a rule for conflicts when both sides edited the same record
- a record of what was imported and when

Roughly a week of work. Honest trade-off: the data is only as current as the
last import, and nobody's dashboard is live.

### Option 3 — A shared server (proper multi-branch)

Every branch's app talks to one central database. HQ sees Ikeja's new members
the moment they are saved.

```
Ikeja ──┐
Lekki ──┼──►  server + one database  ◄── HQ (sees everything)
Abuja ──┘
```

This is what "HQ wants to see other branches' data" really implies, and it is
the right answer if branches work independently on their own machines.

What it needs:

1. **A hosted database** — Supabase or Postgres. Supabase is the fast path: it
   gives you Postgres, authentication and row-level security together, and has a
   good Flutter SDK.
2. **Move the schema across.** `lib/db/tables.dart` maps to Postgres almost
   directly; `branch_id` is already on every table.
3. **Swap the repository.** Every screen reads through
   `lib/providers/repository.dart`, so the screens do not change — the provider
   bodies become API calls. This is why that seam exists.
4. **Enforce permissions server-side.** This is the part that matters. Today's
   checks are client-side and would be trivially bypassed against a real API.
   With Supabase, row-level security does it in the database:

   ```sql
   -- A user sees their own branch, or every branch if granted.
   create policy branch_scope on members for select using (
     branch_id = auth.jwt() ->> 'branch_id'
     or coalesce((auth.jwt() ->> 'can_see_all_branches')::boolean, false)
   );
   ```

   That mirrors `canSeeAllBranchesProvider` exactly — the same rule, enforced
   where it cannot be circumvented.
5. **Keep offline working.** Branches with unreliable internet still need to
   record attendance on a Sunday morning. A local cache that syncs when the
   connection returns; Drift can stay as that cache.

Realistically two to four weeks depending on how much offline support you want.

---

## My recommendation

**If one office does the data entry:** stay with Option 1. It works today, and a
server would be complexity you do not need.

**If branches genuinely work on their own machines:** go to Option 3, and do not
stop at step 3. Moving the data to a server without moving the permission checks
means every branch could read every other branch's giving by talking to the API
directly. The client-side rules are a convenience for the UI, never a boundary —
the `/access` screen says so on screen for this reason.

Option 2 is worth it only if connectivity makes a server impractical.

---

## What is enforced today, and where

So it is clear what would need re-implementing server-side:

| Rule | Where it lives |
|---|---|
| Which branches a user may see | `visibleBranchIdsProvider` |
| Which branch data is filtered to | `activeBranchIdsProvider` |
| What a role may do per module | `permissionMatrix` |
| Cross-branch sight per account | `StaffUser.canSeeAllBranches` |
| Branch leadership must be a member of that branch | `ChurchRepository.setBranchLeadership` |
| Department members must be from its branch, and meet its age range | `ChurchRepository.setDepartmentMembers` |
| Only Super Admin may grant cross-branch access | `ChurchRepository.setBranchVisibility` |

The bottom three are already enforced in the repository rather than the UI, so
they hold regardless of which screen calls them — those would move to database
constraints or server checks. The top four are client-side and are the ones that
must be rebuilt as policies.

Covered by tests in `test/permissions_test.dart` and `test/writes_test.dart`.
