import { contract } from "@/app/client";
import { getIPFSHashNoAccessControl } from "@/thirdweb/11155111/functions";
import { useQuery } from "@tanstack/react-query";

export function useGetIpfs(walletAddress?: string, tokenId?: string) {
  return useQuery({
    queryKey: ["ipfs", { walletAddress, tokenId }],
    enabled: false,
    queryFn: async () => {
      const data = await getIPFSHashNoAccessControl({
        contract: contract,
        tokenId: BigInt(tokenId!),
      });
      return data;
    },
  });
}
