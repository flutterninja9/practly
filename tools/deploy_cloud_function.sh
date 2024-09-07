#!/bin/bash
npm install -g firebase-tools
firebase use "$FIREBASE_PROJECT_ALIAS"
firebase deploy --only functions --token "$FIREBASE_TOKEN"