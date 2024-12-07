#!/usr/bin/env python3
import asyncio
import aiohttp
import sys
from typing import List, Optional
from dataclasses import dataclass

@dataclass
class NodeStatus:
    url: str
    latency: float
    block_height: int
    catching_up: bool

async def test_node(session: aiohttp.ClientSession, url: str, timeout: int) -> Optional[NodeStatus]:
    try:
        start = asyncio.get_event_loop().time()
        async with session.get(f"{url}/status", timeout=timeout) as response:
            if response.status != 200:
                return None

            data = await response.json()
            latency = (asyncio.get_event_loop().time() - start) * 1000

            sync_info = data.get("result", {}).get("sync_info", {})
            return NodeStatus(
                url=url,
                latency=latency,
                block_height=int(sync_info.get("latest_block_height", 0)),
                catching_up=sync_info.get("catching_up", True)
            )
    except:
        return None

async def main():
    if len(sys.argv) < 2:
        print("Usage: ./bash_rpc_tester.py <nodes_url> [timeout] [max_lag]", file=sys.stderr)
        sys.exit(1)

    nodes_url = sys.argv[1]
    timeout = int(sys.argv[2]) if len(sys.argv) > 2 else 5
    max_lag = int(sys.argv[3]) if len(sys.argv) > 3 else 10

    async with aiohttp.ClientSession() as session:
        # Fetch nodes list
        try:
            async with session.get(nodes_url) as response:
                if response.status != 200:
                    sys.exit(1)
                nodes = [line.strip() for line in (await response.text()).split('\n') if line.strip()]
        except:
            sys.exit(1)

        # Test all nodes concurrently
        results = await asyncio.gather(*[test_node(session, node, timeout) for node in nodes])
        valid_results = [r for r in results if r is not None]

        if not valid_results:
            sys.exit(1)

        # Find highest block
        max_height = max(r.block_height for r in valid_results)
        min_height = max_height - max_lag

        # Filter valid candidates
        candidates = [
            r for r in valid_results
            if r.block_height >= min_height and not r.catching_up
        ]

        if not candidates:
            sys.exit(1)

        # Print best node URL to stdout
        best = min(candidates, key=lambda x: x.latency)
        print(best.url)

if __name__ == "__main__":
    asyncio.run(main())