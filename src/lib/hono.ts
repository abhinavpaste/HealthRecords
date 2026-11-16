import { hc } from "hono/client";

import { AppType } from "@/app/api/[[...route]]/route";

const getBaseUrl = () => {
  if (typeof window !== "undefined") {
    return window.location.origin;
  }
  return (
    process.env.NEXT_PUBLIC_APP_URL ||
    (process.env.VERCEL_URL
      ? `https://${process.env.VERCEL_URL}`
      : "http://localhost:3000")
  );
};

export const apiClient = hc<AppType>(getBaseUrl());
