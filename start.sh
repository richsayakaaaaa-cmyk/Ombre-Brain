#!/bin/bash
# Start MCP server in background (port 8000)
python server.py &

# Wait for MCP to be ready
sleep 3

# Start Gateway in foreground (port 8010)
python gateway.py
