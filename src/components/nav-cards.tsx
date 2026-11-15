"use client";

import { useRouter } from "next/navigation";

export default function NavCards({
  cards,
}: {
  cards: {
    title: string;
    description: string;
    url: string;
    icon: React.JSX.Element;
  }[];
}) {
  const router = useRouter();

  return (
    <div className="flex items-center">
      <div className="grid w-full max-w-full grid-cols-3 gap-5 sm:grid-cols-2 lg:grid-cols-3 ">
        {cards.map((card, i) => (
          <div
            key={i}
            role="button"
            tabIndex={0}
            onClick={() => router.push(card.url)}
            onKeyDown={(e) => {
              if (e.key === "Enter") router.push(card.url);
            }}
            className="flex min-h-full flex-grow cursor-pointer items-center space-x-5 border-2 border-border bg-white px-5 py-5 shadow-light transition-all duration-200 hover:shadow-none hover:bg-amber-50"
          >
            {card.icon}
            <div>
              <h1 className="text-lg font-heading">{card.title}</h1>
              <h2 className="font-base text-zinc-700">{card.description}</h2>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
