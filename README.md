# Swift_iOS_demonstration
Simple test of Sentry’s Cocoa SDK in Swift environment

## Sentry E-Commerce Sample App

This repository contains a minimal SwiftUI iOS application demonstrating Sentry error monitoring, performance tracing, profiling, user feedback and mobile session replay. The app loads a catalog with an intentional delay, lets users add items to a cart, and triggers an error on checkout to showcase Sentry's reporting.

### Configuration
1. Copy `.env.example` to `.env` and fill in your `SENTRY_DSN`, `SENTRY_ORG`, `SENTRY_PROJECT` and `SENTRY_AUTH_TOKEN` values.
2. Open `SentryECommerceSampleApp.swift` and run the project in Xcode.
