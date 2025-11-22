# Gator golang scrapper

# Installation
need .gatorConfig.json file in the home directory
- db_url: string
- current_user_name: string

# Setup
Requires postgres database
Requires golang

# Usage
- gator login <username>
- gator register <username>
- gator add <title> <url>
- gator follow <url>
- gator unfollow <url>
- gator browse <limit>
- gator agg <time>
- gator reset
- gator list
- gator myfeeds
- gator following

# Pending items
- TUI
- Docker compose solution to run with DB.