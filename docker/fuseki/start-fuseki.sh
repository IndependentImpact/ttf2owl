#!/bin/sh
set -e

DATASET_DIR="${FUSEKI_BASE}/databases/ttf"
ONTOLOGY_SRC="/opt/ttf/ttf.ttl"
SHIRO_INI="${FUSEKI_BASE}/shiro.ini"

# Generate shiro.ini with credentials from environment variables
# Note: The generated file will contain passwords in plain text, which is
# expected for Shiro configuration. File permissions are managed by the
# container's security model (fuseki user with restricted access).
echo "Generating shiro.ini with admin credentials..."
cat > "$SHIRO_INI" << 'EOF'
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

[main]
# Development mode: ssl.enabled is set to false by default
ssl.enabled = false

# Session configuration - simple session manager for development
sessionManager = org.apache.shiro.web.session.mgt.DefaultWebSessionManager
securityManager.sessionManager = $sessionManager

# Authentication configuration using Basic Authentication
authcBasic = org.apache.shiro.web.filter.authc.BasicHttpAuthenticationFilter
authcBasic.applicationName = Apache Jena Fuseki

# Define the roles
[users]
# Format: username = password, role1, role2, ...
# Admin credentials loaded from environment variables
EOF

# Append the admin user credentials from environment variables
echo "${FUSEKI_ADMIN_USER:-admin} = ${FUSEKI_ADMIN_PASSWORD:-admin}, admin" >> "$SHIRO_INI"

cat >> "$SHIRO_INI" << 'EOF'

[roles]
# Define role permissions
admin = *

[urls]
# Restrict admin API to authenticated admin users only
## Server status information is generally readable.
/$/status = anon
/$/ping = anon

## Admin operations require authentication and admin role
## This covers dataset creation, deletion, backup, etc.
/$/** = authcBasic, roles[admin]

## Allow anonymous access to all dataset endpoints for queries
## (adjust if you want to secure dataset access too)
/** = anon
EOF

echo "shiro.ini generated successfully."

if [ ! -d "$DATASET_DIR" ] || [ -z "$(ls -A "$DATASET_DIR" 2>/dev/null)" ]; then
  echo "Initializing TDB dataset at $DATASET_DIR"
  mkdir -p "$DATASET_DIR"
  # Use the image's own tdbloader2 wrapper (already +x and in PATH? No → full path)
  /jena-fuseki/tdbloader2 --loc "$DATASET_DIR" "$ONTOLOGY_SRC"
  echo "Dataset loaded."
else 
  echo "Dataset at $DATASET_DIR already exist -- skipping load."
fi

exec /jena-fuseki/fuseki-server --config=/opt/ttf/ttf-config.ttl
