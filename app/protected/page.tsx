import { redirect } from "next/navigation";

import { createClient } from "@/lib/supabase/server";
import { Badge } from "@/components/ui/badge";

export default async function ProtectedPage() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/auth/login");
  }

  const { data: profile } = await supabase
    .from("profiles")
    .select("*")
    .eq("id", user.id)
    .single();

  const roleColor: Record<string, string> = {
    partner: "bg-red-500",
    worker: "bg-blue-500",
    client: "bg-green-500",
  };

  return (
    <div className="flex-1 w-full flex flex-col gap-6">
      <div className="bg-accent text-sm p-3 px-5 rounded-md text-foreground">
        Welcome, <strong>{profile?.full_name || user.email}</strong>
      </div>

      <div className="grid gap-4 md:grid-cols-2">
        <div className="border rounded-lg p-6">
          <h3 className="text-sm text-muted-foreground mb-2">Email</h3>
          <p className="text-lg font-medium">{user.email}</p>
        </div>

        <div className="border rounded-lg p-6">
          <h3 className="text-sm text-muted-foreground mb-2">Role</h3>
          <Badge className={roleColor[profile?.role || "client"] || "bg-gray-500"}>
            {profile?.role || "no role assigned"}
          </Badge>
        </div>

        <div className="border rounded-lg p-6">
          <h3 className="text-sm text-muted-foreground mb-2">Full Name</h3>
          <p className="text-lg font-medium">{profile?.full_name || "Not set"}</p>
        </div>

        <div className="border rounded-lg p-6">
          <h3 className="text-sm text-muted-foreground mb-2">Created At</h3>
          <p className="text-lg font-medium">
            {profile?.created_at
              ? new Date(profile.created_at).toLocaleDateString()
              : "Not set"}
          </p>
        </div>
      </div>
    </div>
  );
}
