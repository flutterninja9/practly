#!/bin/bash
# Create a temporary file for the service account credentials
echo "$GOOGLE_APPLICATION_CREDENTIALS_CONTENT" > $CM_BUILD_DIR/firebase-key.json
export GOOGLE_APPLICATION_CREDENTIALS="$CM_BUILD_DIR/firebase-key.json"
firebase use "$FIREBASE_PROJECT_ALIAS"
firebase deploy --only functions